Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17093C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B58247D0
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SI44E+N6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B58247D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnmT-00077R-FW
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnhV-0002Wd-FA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnhT-0002Fc-Sc
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603900160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eTyj+fAm7ULa3rdY0BuDy9kyxb92LnLqsP6JUD4tUzU=;
 b=SI44E+N6PW3wC3muGBWo/Dwu5dAXOZ2Pkxr2BMLgx9w+1fnw+Gh1KjEKBDZRDGD/kla7ee
 4egcpls9joBxke48EAzLYAfDjB1PzTbQNaoMHDDsdV3xc3SyrQ8WU1Gs553pMZSw0eQcEB
 uo5ekCHDFhzn9s+CV5Lhqf376IvEB58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-mAC6tSnMOQWQjClVG7evzg-1; Wed, 28 Oct 2020 11:49:17 -0400
X-MC-Unique: mAC6tSnMOQWQjClVG7evzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B5F760C4;
 Wed, 28 Oct 2020 15:49:16 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57BCC10013D9;
 Wed, 28 Oct 2020 15:49:13 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:49:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 10/25] block/nvme: Use unsigned integer for queue
 counter/size
Message-ID: <20201028154912.GZ231368@stefanha-x1.localdomain>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-11-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-11-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gpOboRovIPmaBszt"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gpOboRovIPmaBszt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 02:55:32PM +0100, Philippe Mathieu-Daud=E9 wrote:
> We can not have negative queue count/size/index, use unsigned type.
> Rename 'nr_queues' as 'queue_count' to match the spec naming.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/nvme.c       | 38 ++++++++++++++++++--------------------
>  block/trace-events | 10 +++++-----
>  2 files changed, 23 insertions(+), 25 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gpOboRovIPmaBszt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZkvgACgkQnKSrs4Gr
c8g9Xgf+K5H8xmaR/EWrC8ifTSw3zGHxncykTEesQP4yi+M6eonEPcKqkNTp0fcF
heEElzN1mj7Iqou/JtFqOuC9KCxTvD1vJO1uIAbCZo8Ze4gyx16STEel13ZoPzx5
Q8MXjGl8F4UZgmncIZ0yBAq1YfOZ3Ckho0aXqVeSJyODdQ42K37qmWpbK5ogwxcX
ShsdFY1+BEenUmkh0/EFCF4bSKcgyM4+F06aBhcjcAv3du5/hM47lolkd9ZJkp4o
GYhsVER9un45usnI3sf/7z/EJeIfNDWTlORtCUY6ldCf7Mq4LH00mub6D4FPXmEd
eBVPZixuKMtzcrRc3ot0WPdyNPmYQw==
=aLDP
-----END PGP SIGNATURE-----

--gpOboRovIPmaBszt--


