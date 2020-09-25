Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339C7C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D22221741
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dr0ccCvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D22221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpvp-00006Q-Eq
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLpjo-0005CI-Kf
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLpjm-0006m0-HW
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:34:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601048057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2jRr4AvgCfVa23Hi8U1sKX8X2s5I2G5lQffVGscQikc=;
 b=dr0ccCvHezvrr2uqrwNEbkCef9Rg/XBUOWPjWTIqLDM1NAeJKjeZ5KKxBarohVB6omZf4C
 m0GdalY/7AugRRAv/tQf72bEg9fUhsBGrc1KqEqXDLlCcpMRKBS8BnoepHpptUxDXp9aZV
 1YcWacX9YXA1+yqWAB/JdARliP9FwVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-YrRm__MbPfmT4JQL0pvUMg-1; Fri, 25 Sep 2020 11:34:14 -0400
X-MC-Unique: YrRm__MbPfmT4JQL0pvUMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98AD88912FF;
 Fri, 25 Sep 2020 15:34:08 +0000 (UTC)
Received: from localhost (ovpn-115-66.ams2.redhat.com [10.36.115.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC22C5C1BB;
 Fri, 25 Sep 2020 15:34:07 +0000 (UTC)
Date: Fri, 25 Sep 2020 16:34:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 3/6] block/nvme: Reduce I/O registers scope
Message-ID: <20200925153406.GB343759@stefanha-x1.localdomain>
References: <20200922083821.578519-1-philmd@redhat.com>
 <20200922083821.578519-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922083821.578519-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 10:38:18AM +0200, Philippe Mathieu-Daud=E9 wrote:
> @@ -808,6 +808,10 @@ static int nvme_init(BlockDriverState *bs, const cha=
r *device, int namespace,
>          ret =3D -EIO;
>      }
>  out:
> +    if (regs) {
> +        qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)regs, 0, sizeof(Nvme=
Bar));
> +    }

qemu_vfio_pci_unmap_bar(NULL) is a nop, so the check is unnecessary.  I
didn't look to see whether the doorbells can be NULL too during unmap,
but if yes, then it's clearer to be consistent (always check NULL or
never check NULL).

Not worth respinning though.

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9uDe4ACgkQnKSrs4Gr
c8iHiQgAxOb7++9OpggbikvmLdndsptZvQSeRGNNIPfas1MzndIPw8bRjIgIIPQH
PzNu1SHZJpdR6vG+mukKAslliBYsNuQj6Dx0nvbtzE1MMADdEU7yG6XJAqqC8eNq
557psxOaVGIqZvbT5+hb1ZV2V/6+lui4tTHH4iicjDaCYEbkr2ve0pF6/SG1hjKE
MvZd+tsimPih2LxXDKrHu/ncWipxRanuUAdySBJIx9nDUrmyKLSAtsJ73B3K6ASA
EqPq2gIdcAH7m4slx2fvkNr4yk91BCo9wzjR8rGkd1on2zBJe3OYXehj3QDLsLtO
dQD3GP6mX0DZ3A+kPQIRkuhyaRy/Iw==
=Vwyr
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--


