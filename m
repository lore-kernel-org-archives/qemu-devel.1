Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DFCC76199
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7032084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjZLE/iR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7032084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Ro1-0001LY-Vo
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j3RlB-00067Z-W2
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j3RlB-0001ZD-1b
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:47:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j3RlA-0001YY-UH
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581889648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2yJAws9hM7EPA4+jFm+ycdFX7cJVxKlQLYq9qCUmM8=;
 b=VjZLE/iRd8cUNzrqg7TzK83UmhEtiA4dEeiAWq5mei53tS0zOxloz2YeiJ4jXseyHILDDp
 uqVhCkRWHkQnmSLcnZnJ1K2I6UMM6sM0fOyvJX48wZnjT17xIp/AHptv34fEP7U+FzilFW
 AW/99PUJ4zbQUCtcChd8te04LYiCo2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-Al4Vbf1vONClXADsIiYSxw-1; Sun, 16 Feb 2020 16:47:24 -0500
X-MC-Unique: Al4Vbf1vONClXADsIiYSxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9125013E5;
 Sun, 16 Feb 2020 21:47:23 +0000 (UTC)
Received: from lpt (ovpn-200-18.brq.redhat.com [10.40.200.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AD0460BEC;
 Sun, 16 Feb 2020 21:47:21 +0000 (UTC)
Date: Sun, 16 Feb 2020 22:47:18 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 6/7] commit: Expose on-error option in QMP
Message-ID: <20200216214718.GJ745061@lpt>
References: <20200214200812.28180-1-kwolf@redhat.com>
 <20200214200812.28180-7-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200214200812.28180-7-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 09:08:11PM +0100, Kevin Wolf wrote:
>Now that the error handling in the common block job is fixed, we can
>expose the on-error option in QMP instead of hard-coding it as 'report'
>in qmp_block_commit().
>
>This fulfills the promise that the old comment in that function made,
>even if a bit later than expected: "This will be part of the QMP
>command, if/when the BlockdevOnError change for blkmirror makes it in".
>
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> qapi/block-core.json | 4 ++++
> blockdev.c           | 8 ++++----
> 2 files changed, 8 insertions(+), 4 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5JuGYACgkQ+YPwO/Ma
t533xQf/dJVcEsq/78Qxt7HrYkVm49r16QX9nd857bQgVXfuybHpivDrWjB4nxRo
qdyjCqJ6jbCSB38LnXimYrOj0B8zRiY65ZnxiiK/p4HejH11KUCdm1mzSPohAaQ5
91djA/m0Lp6LV09pCTcNKf6Hhy/u6MhzZT1nReFqz0MgxN1joIwhHNflc7K5mrbo
AO3yzpxOTZDyFbSdNkkoBeS8d2ayF9YzBvUHZo1uaM4QgwyTe99S4UaPObRdnjp0
9GXXYjmFV93SoShkZSW1Ztabd99wIIHS7Ls/dX/kOmi+znIaqt7ZzaBHM3CnADXW
DKF4ILmgKUuwcGVZpEV7vcRUtTMCAg==
=7kNp
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--


