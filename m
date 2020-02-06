Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF8C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31595206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 07:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUBOjc5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31595206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izbB5-0004Dh-BB
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 02:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1izbAP-0003i6-OY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1izbAM-0003NM-5o
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:01:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1izbAL-0003Cb-Uc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 02:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580972492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t0TnzFC0Au1k5m2HeFoqFRFeyxTAtx+m0wg56lcPmSc=;
 b=XUBOjc5FUJRjnzalPQn/x1u1mTt06oo3JDjIMkv7UgZRcvM47DicTn8ZRon9385Vx9zZKg
 X22O+a/swI5TAdoytU5Mlj3i/Cp/UKNjWxpNic3WCfYkrVWAHFStYLZ8+ROzmDNp4UQAjv
 WJ4m0U/J0XGbQcn59G+8vebRNXcxKao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-UgLOX8PXNgyC1iTDSMfSzg-1; Thu, 06 Feb 2020 02:01:28 -0500
X-MC-Unique: UgLOX8PXNgyC1iTDSMfSzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A09C38010E6;
 Thu,  6 Feb 2020 07:01:27 +0000 (UTC)
Received: from localhost (ovpn-116-182.ams2.redhat.com [10.36.116.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F213F100194E;
 Thu,  6 Feb 2020 07:01:24 +0000 (UTC)
Date: Thu, 6 Feb 2020 07:01:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] qemu-img: Place the '-i aio' option in alphabetical order
Message-ID: <20200206070123.GA75441@stefanha-x1.localdomain>
References: <20200205163008.204493-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205163008.204493-1-jusual@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2020 at 05:30:08PM +0100, Julia Suvorova wrote:
> The '-i AIO' option was accidentally placed after '-n' and '-t'. Move it
> after '--flush-interval'.
>=20
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  docs/interop/qemu-img.rst | 8 ++++----
>  qemu-img-cmds.hx          | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl47ucMACgkQnKSrs4Gr
c8gmiwf/W4WTV+ehoPak3DriwqpAqNMkFvrrM4DKMfWj0k1aOOVeDN4zi66hM0iu
a5Q9wvB31mx4cEXR1i8zhfrqH7oFmM5JdFOgBUoW3MZF8MG5nL84Mh08cNuZ2g7L
7/5gE7liBW5N34m6p+qMfhCQymJz4W6iBMpSwC4gfyFg+CXYWdJNIxNN+HdjbEIS
0VKh2C5R2dEykEkNx4hPlkJ/GQv3BuBotMHT7sT0aNc43qlwPjtGH27YW5/krkLx
5r9jMz1+Px0BdAMpFx3thnNyWaf8r5xmjp/pohNogKIBLpujoHmcDAk2KDCGNIar
O1B3tprAkvaMSRrfGNxkSCykzJcgng==
=/4cU
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


