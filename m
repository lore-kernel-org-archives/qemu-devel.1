Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F9AC3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4142084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDVhC+EG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4142084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Rkh-0004yk-8z
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j3Rja-0003h3-R8
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j3RjZ-0008C1-WF
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:45:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47906
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j3RjZ-0008BN-Sg
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581889549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xmytMXW+tgsmAcskQL0ru6twUmCftR9y0iWntjSC8cQ=;
 b=DDVhC+EGe0RFmmRg3otntvGPk03i8bHQQPYO786wrJP2oh5BLYPvABBOBKsxo9e7xqR4ZT
 ZJe1tlIRSXrfOwOTR5a5N3LjmKngl4mK5I+hlMZnlmuAgmXNrYtfSWatkyIp/jIz3w1CJw
 6RbyEnZOaDvdtTt45wdGWpdKXM1R/hU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-qODwnv0rN4yldG3z-TE9kg-1; Sun, 16 Feb 2020 16:45:45 -0500
X-MC-Unique: qODwnv0rN4yldG3z-TE9kg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A78A1005516;
 Sun, 16 Feb 2020 21:45:44 +0000 (UTC)
Received: from lpt (ovpn-200-18.brq.redhat.com [10.40.200.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7EE619756;
 Sun, 16 Feb 2020 21:45:41 +0000 (UTC)
Date: Sun, 16 Feb 2020 22:45:38 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/7] commit: Remove unused bytes_written
Message-ID: <20200216214538.GF745061@lpt>
References: <20200214200812.28180-1-kwolf@redhat.com>
 <20200214200812.28180-3-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200214200812.28180-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
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

--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 09:08:07PM +0100, Kevin Wolf wrote:
>The bytes_written variable is only ever written to, it serves no
>purpose. This has actually been the case since the commit job was first
>introduced in commit 747ff602636.
>
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> block/commit.c | 2 --
> 1 file changed, 2 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5JuAIACgkQ+YPwO/Ma
t51q1wf/ZIJk/Tw4gTMwNVg6l0MeYRxriBWI2AChFrjQVAwJKBfnaj1aZOL+WT3/
zOnkCa990uEUEEqTrXJiAYvOUcB6rGdeXFopp4bKfNuM7tObscr5FlADneDxvDCn
PPq7Bp4vNMm4KCZovWGcYYZoO3C59A/8/FibJ6HR+CVxq5OJtyIfmy+0y60V64Co
q1FQlWt/pUabIzXbTPLuZ3W0VzJjoyk4Ok2Mf3V77EhhMz2Fu6/fRYBApK6AKoMG
NU4ei3URDR5dnMDqaXmc8p63EKBncMokPAOwlXCOGjuyr4FGEafUyjiBlz+/yicp
0cJbjo82h4g+m5Njmvj3vlbTp4+r9A==
=1Chz
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--


