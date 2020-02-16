Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA18C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07822072C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWPYFDC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07822072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3RKx-0004pX-4P
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j3RKK-0004D3-Hn
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j3RKI-0000cH-Qx
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:19:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20336
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j3RKI-0000Zw-Mm
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581887980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uQoQ6qym7wtCt5GfnPKVaoRQ02ONaUmQ52PdFFRCbk=;
 b=PWPYFDC+Xg9frxrG3Lh/5cyPh0B8XepnjGAYoR7B1i3g05vBXTT33PxOlODzEUxjlumaSL
 Dt3eqKg2QPjZY5mjzvP8yWFd0pcPY6hMD7euhpH+6/rxwpvCGKi+Jt6oe1mVdagwVCDJrC
 uhkK50hf3B5SMrNyS6MkMUAl0h6afcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-_k3Ir2PXOY6U73TzmLNS6Q-1; Sun, 16 Feb 2020 16:19:38 -0500
X-MC-Unique: _k3Ir2PXOY6U73TzmLNS6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41CB21005516
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 21:19:37 +0000 (UTC)
Received: from lpt (ovpn-200-18.brq.redhat.com [10.40.200.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31FFC19488;
 Sun, 16 Feb 2020 21:19:27 +0000 (UTC)
Date: Sun, 16 Feb 2020 22:19:24 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/3] tools/virtiofsd/passthrough_ll: Remove unneeded
 variable assignment
Message-ID: <20200216211924.GB745061@lpt>
References: <20200215160716.1262-1-philmd@redhat.com>
 <20200215160716.1262-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200215160716.1262-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2020 at 05:07:14PM +0100, Philippe Mathieu-Daud=E9 wrote:
>Fix warning reported by Clang static code analyzer:
>
>    CC      tools/virtiofsd/passthrough_ll.o
>  tools/virtiofsd/passthrough_ll.c:1083:5: warning: Value stored to 'saver=
r' is never read
>      saverr =3D ENOMEM;
>      ^        ~~~~~~
>
>Fixes: 7c6b66027
>Reported-by: Clang Static Analyzer
>Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>---
> tools/virtiofsd/passthrough_ll.c | 2 --
> 1 file changed, 2 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5JsdwACgkQ+YPwO/Ma
t50NwggAk2s1dgEGfIUBy10m/maTjpairJ8jPc6iUsL2/IQyW46czrlK/L4TJkIq
kluEgf7mIaA7n6KlpjzvAy2zNjqd98y0LUcokg99ZmTGMgbEpXAHBms4PYJEXg9I
VQgI1VHs21uR24il01kg3Easi1vx0bdMbv4IG5fJWGXvt7PAC2MAz5OewWJ3q5xV
7tspfPnpOPIrlGPl/6ioj0a4raKLQiAPks4s1G3IG6/4FMvSg3twTeAaxH0LTiTS
Tur/h0RGIRDnCsvoXmqEX8vFOLNB9My+0U48+GnB8g962piDzDJpa3mjw6AuGdEX
kMhIezGY/X8xpPCCvSlwkDxxJ89PHA==
=1CrZ
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--


