Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A785CC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F78424653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyY4P+DE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F78424653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwgg-0007Lr-3d
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1itweP-0005LM-Q3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1itweL-0005HI-SD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:45:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35110
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1itweL-0005H6-O6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579625109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fRrsxqhOgrCMZwCsr/V4byi9JNdwTmBC+vMSpc5B9gg=;
 b=cyY4P+DEJowDk2h/h2b8LaFJHEbyLEvqjVD+R7BOAn0hZ1OqSE5R747WkoB/PPP19luabL
 zntGOtU0TcfOIgPHOxGskyhkbVnDhkTFUvsYHFfFtIolvaIBoeLG2Ifwvzk3TkBt1FISqQ
 6Dfb1Vtsa2O2y5EnF1A06tYvB6mJLHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-L1y1sQRuO_Kme7YDbjJFbQ-1; Tue, 21 Jan 2020 11:45:05 -0500
X-MC-Unique: L1y1sQRuO_Kme7YDbjJFbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C17EBA015F;
 Tue, 21 Jan 2020 16:45:04 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 086917DB5D;
 Tue, 21 Jan 2020 16:44:59 +0000 (UTC)
Date: Tue, 21 Jan 2020 16:44:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v7 00/20] Add virtual device fuzzing support
Message-ID: <20200121164458.GI641751@stefanha-x1.localdomain>
References: <20200120055410.22322-1-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200120055410.22322-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "darren.kenny@oracle.com" <darren.kenny@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 05:54:36AM +0000, Bulekov, Alexander wrote:
> This series adds a framework for coverage-guided fuzzing of
> virtual-devices. Fuzzing targets are based on qtest and can make use of
> the libqos abstractions.
>=20
> This version mostly contains cleanup with some changes to the virtio-net
> fuzzer.

I left a few small comments.

Stefan

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4nKooACgkQnKSrs4Gr
c8hatgf6AtOJnRRnuvJPc2YlyOnGWcdhMd0ryl4hGYR63Y6VeikOHSGyjFG0/9jx
TbDeNG/AwSquwdaDUwm1J6OqIAkWJPYPmPo1HFfWFEfm+aIQ9EwFJhG75k6czL7g
ESWr9wTHoF7+PwH98WYwA9GrLtNOLtwaNeHY3D/er2pjwKl0V+8fJcGW+0ZrC/Zt
dsNYcnNDPAM8dqUHzzwwrMC5iEsV4p9wTGhW4BxHxj4IlGu9F7Z5Su56JH4t0CVq
+ADySa6msakU/bsCvlRfBRkeV81Ed64wibGp7tdQeaAu4/C1RtAHMQ42cvPjzqoM
frXs2gIrhuOLp1pB0B2JiGgNMpNUlg==
=UcfQ
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--


