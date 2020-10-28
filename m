Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ED5C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE5B247C5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5Re+cjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE5B247C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnHz-0005cT-Hn
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnCn-0001Fd-Q7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnCj-0006Ee-OY
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603898256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wq4r4RjCYX6NbBeXKfhIV/9dVvNOAC3BHWPEj4QpSN0=;
 b=h5Re+cjqWPArDFj+Ap2tfVpeRVv24UaDI2hIRsREwf1/8HFAG69IrSI3jheYOqkWSEdhc0
 3Cctb88oXeV4g2mj4HSekHfvT4r/VIbHq3nExHtUENFgX9z/0L2LB/jcux5jW2B6BqZBs1
 DEYKks3cwcM5oP0Gtwrne+3xIK7sBEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-ds7IgBatOCmbJmaWlXwBJQ-1; Wed, 28 Oct 2020 11:17:31 -0400
X-MC-Unique: ds7IgBatOCmbJmaWlXwBJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 488F11084C94;
 Wed, 28 Oct 2020 15:17:29 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1C735B4BA;
 Wed, 28 Oct 2020 15:17:25 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:17:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 15/25] block/nvme: Correctly initialize Admin Queue
 Attributes
Message-ID: <20201028151724.GJ231368@stefanha-x1.localdomain>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-16-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-16-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 02:55:37PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> From the specification chapter 3.1.8 "AQA - Admin Queue Attributes"
> the Admin Submission Queue Size field is a 0=E2=80=99s based value:
>=20
>   Admin Submission Queue Size (ASQS):
>=20
>     Defines the size of the Admin Submission Queue in entries.
>     Enabling a controller while this field is cleared to 00h
>     produces undefined results. The minimum size of the Admin
>     Submission Queue is two entries. The maximum size of the
>     Admin Submission Queue is 4096 entries.
>     This is a 0=E2=80=99s based value.
>=20
> This bug has never been hit because the device initialization
> uses a single command synchronously :)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  block/nvme.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+Zi4QACgkQnKSrs4Gr
c8hy2QgAxVGRqiR0f4Fu9y/u5N70hXSaaZTqCC8JdQSpsvnbjmGc4hEmq3GzM+K3
82qXSgQCDPE+Ws/BnAUZr396TZ2HeRvU0+BONGt48DjNd6ydTwMquKRQtugQ6Prx
LeudERPs3ne6ynpYysL0y1mqYf7rXttK+O452eEankXSIP1cG+o2xerOXpHLIoJ5
7IeXE2QKiegP4vPcLncUHB1JdKwmYUd8eyNTckvEM6eZSH0gtw5iH6eX0L6Ty4Vf
QaAUpRu9flIuFHffrxdVjE5gbMNRd0kdrVkc/e2t6ae/RbDxWDsj+gMcVjCNXBOi
PATlIW9MUMqZ8ejcnIjBzSMLAFSnlw==
=hqlX
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--


