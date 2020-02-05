Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4903EC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B3A2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkVq9cH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B3A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIgg-0003VH-9a
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1izIfm-0002eI-Tu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1izIfl-0003RE-8c
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:16:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53962
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1izIfl-0003Qs-4c
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580901404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w/DbaBf7WPLM1IYy9qROL2ypWnvELw1W+/y8/wbiqJQ=;
 b=CkVq9cH6nVbU1rW1lGCmf9nQLud3vle+5bh0/EmBMna1znHbN7Zn9/zJkukBACYDbpYgP5
 CaQRkyIw21ps3Z06MBXJIGsBbEuNpi2CMsOGErywfMVPS1ugZ2fQDwvCNqiJwN8pTy6sFj
 BDJcfL2adlqqXWpZpfC6VAxW5QAKG28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-D0RNwZmAOTCr9Fv9jtZf3g-1; Wed, 05 Feb 2020 06:16:41 -0500
X-MC-Unique: D0RNwZmAOTCr9Fv9jtZf3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74B5F8018CD;
 Wed,  5 Feb 2020 11:16:40 +0000 (UTC)
Received: from lpt (ovpn-200-44.brq.redhat.com [10.40.200.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE3355DA7B;
 Wed,  5 Feb 2020 11:16:33 +0000 (UTC)
Date: Wed, 5 Feb 2020 12:16:30 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/5] ui: deprecate legacy -show-cursor option
Message-ID: <20200205111630.GA26464@lpt>
References: <20200205110356.3491-1-kraxel@redhat.com>
 <20200205110356.3491-6-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205110356.3491-6-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, jpewhacker@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2020 at 12:03:56PM +0100, Gerd Hoffmann wrote:
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> vl.c                 | 2 ++
> qemu-deprecated.texi | 5 +++++
> 2 files changed, 7 insertions(+)
>

libvirt does not use -show-cursor

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl46pAoACgkQ+YPwO/Ma
t50fsAf+JjkV+x3bjjaQ3sYGcLkE0KSKe7mY2010aTsssNoWGZEaW4C8LxCwHo5q
URaWAnzMXpsjQgHmg7tzZUWhNqc6Bsax50eqyHagJNhHBo1JLWL6m/wAYOv41T2Y
d+rvRpcGhh3tWVQfUWjZfB/p67m4qQWUliDF5dQgrxuKp4cmRGLkpCrpkRzJpyMd
HB6p+aOnsYJqoeNxm48jROZO4EiCSAamL7Dd8kFVdCJuv/V0EHmlzmwOztkLshcD
9DJI/a8QQKEvoNq71yYzPKiy/X52FsxdvqyXRNaXhnvTVGcZ7iiE4S/GHbthLFAm
0Nz3dyxBcEXx+TqXPR6ZvSP7YaTRMQ==
=+anq
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--


