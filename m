Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34CEC388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE71321D91
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bITt3Cg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE71321D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0HN-0003At-Pk
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ka0GC-0001pk-Eb
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ka0GA-0008M4-OH
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604425097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mXs/YUwpAbZ+xq/X+SMR2xhfgOHeV6MmtpKpBQfK0ug=;
 b=bITt3Cg/CuXzpLff+8FN7isAxI0bL5p/XayAAwvW+wftdD5hklOQOfQ6GIBhmHJlouDpJf
 cX3MhxBQDZX26DlvzV0RiFHvHyMChLFy+RZHEiV5ttaW1qq6TILTohGWL0pAfbWLKRT0ye
 OZFVCIzbsGw/AcMdz9rCn3DmgH//fIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-7tDZk8P7NFiaUsBnT18mCQ-1; Tue, 03 Nov 2020 12:38:13 -0500
X-MC-Unique: 7tDZk8P7NFiaUsBnT18mCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056E21099F65;
 Tue,  3 Nov 2020 17:38:12 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90E9E7512C;
 Tue,  3 Nov 2020 17:38:07 +0000 (UTC)
Date: Tue, 3 Nov 2020 17:38:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Revert "vhost-blk: set features before setting inflight
 feature"
Message-ID: <20201103173807.GE259481@stefanha-x1.localdomain>
References: <20201102165709.232180-1-stefanha@redhat.com>
 <DM6PR11MB37234EA5646AF3693B66E7C180110@DM6PR11MB3723.namprd11.prod.outlook.com>
 <20201103144130.GA253848@stefanha-x1.localdomain>
 <20201103094509-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201103094509-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Yu, Jin" <jin.yu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 09:45:27AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 03, 2020 at 02:41:30PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Nov 03, 2020 at 05:11:18AM +0000, Yu, Jin wrote:
> > > =09I have sent a version 2 and it should fix this issue.
> >=20
> > Great, thanks! Michael can review and consider it for merge instead of
> > this patch.
> >=20
> > Stefan
>=20
> It's not instead, it's on top of your revert.

Okay.

Stefan

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hlX4ACgkQnKSrs4Gr
c8jLEAf/fsKdp7ckfSCZvHt4IVNZKJFeoMasYf/BNYhaXfn9ODvnaEGP/uopmJ2o
Ml7S96JIfWUqfQNMNkkQ+3aIev38kiv6IldLTa7fQoJ+BobX8qctf96RhiKpW1uW
pMz3c7+dNjjH8tvCNuWdFbZepfwu+3/e2qvwIGIk2XChggmrmqhVqjKUw7azdJdl
aQod5emYfIOB01ERBVUf4YEKvklRmpfN2qyAd4PozsNEjcQMZG//ezykpQAiYJYv
o5hp6cyimyfAAOgRZYV0UmOzFFw55njKiOWvsahQeukQAveAs5RB2DeFOqMBALUm
aJkD9WHBg8Ni0oo50n5/1yo3FIQ2PQ==
=AWZU
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--


