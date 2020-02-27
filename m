Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417B3C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8982467F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZ2efe/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8982467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FiU-00078E-6O
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j7FhY-0006YG-CV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j7FhW-0006NX-Hd
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:43:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22928
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j7FhV-0006Mm-QM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582796604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AxJD58PkEqCuECClxO2X8LUJ08wREGf8GLDkzyUvyGM=;
 b=hZ2efe/EtYPqLBQzmbPmXCDv8h32MiPRxCFH+kymKZz3i2oHM9B18Lo5RvNrAbDqwnz1X1
 wDqYIFAy77FDjKxQQRkBO909chAm9mjzDBBGcHO/Ht11P/81WigmfY0okBcftGQL4WQKCA
 CkTnanEzTRqjgtX8Mjx/a0sbLnlAzAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-YS8LMF6KNemesNsqYM49hw-1; Thu, 27 Feb 2020 04:43:22 -0500
X-MC-Unique: YS8LMF6KNemesNsqYM49hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 870191922960;
 Thu, 27 Feb 2020 09:43:21 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52EA01001DC0;
 Thu, 27 Feb 2020 09:43:17 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:43:14 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 3/3] qemu-img: Deprecate use of -b without -F
Message-ID: <20200227094314.GF2262365@lpt>
References: <20200227023928.1021959-1-eblake@redhat.com>
 <20200227023928.1021959-4-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227023928.1021959-4-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On a Wednesday in 2020, Eric Blake wrote:
>Creating an image that requires format probing of the backing image is
>inherently unsafe (we've had several CVEs over the years based on
>probes leaking information to the guest on a subsequent boot).  If our
>probing algorithm ever changes, or if other tools like libvirt
>determine a different probe result than we do, then subsequent use of
>that backing file under a different format will present corrupted data
>to the guest.  Start a deprecation clock so that future qemu-img can
>refuse to create unsafe backing chains that would rely on probing.
>
>However, there is one time where probing is safe: if we probe raw,
>then it is safe to record that implicitly in the image (but we still
>warn, as it's better to teach the user to supply -F always than to
>make them guess when it is safe).
>
>iotest 114 specifically wants to create an unsafe image for later
>amendment rather than defaulting to our new default of recording a
>probed format, so it needs an update.
>
>Signed-off-by: Eric Blake <eblake@redhat.com>
>---
> qemu-deprecated.texi       | 15 +++++++++++++++
> block.c                    | 21 ++++++++++++++++++++-
> qemu-img.c                 |  8 +++++++-
> tests/qemu-iotests/114     |  4 ++--
> tests/qemu-iotests/114.out |  1 +
> 5 files changed, 45 insertions(+), 4 deletions(-)
>

This seems to affect code paths that are used even outside of qemu-img,
should the commit message mention it?

Jano

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5Xjy4ACgkQ+YPwO/Ma
t50M0QgAr2Y+NDUFhxFfSjfq4GA/UTtszBE6tOjcvjEN2uwnBoYzFjE0xuu9QOLi
an+O8BL0Km2qMJnw1DLH9FyJTnPPamj0rmybS7mZiAXK725/4ZP1MZ1ve+W6Fn3I
DFZirj71pYEbQztHSOXY0D6PX2GxrLXpO4Te3pcaB885++A85eVvTzXfdQFHruEy
FA688cwoU2m3ElR1sAD9RC43d7wXzxq7c1w1gnUmkpdDmscmI9K+vpuVukHUFUnx
G4Rir/GQ3noEldyHx+HJ7nBzpbZ5TDzgOse/k1vgKog+CIBeUkWYsLADNoUNIpsD
wjdZ4t53rNYZHnemyVVqozxkobC8cw==
=Gxmw
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--


