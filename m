Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937E9C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3D420748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="ZKS4VPZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3D420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isNr4-0008H4-C8
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 04:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1isNqH-0007hZ-C4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1isNqG-0002T1-70
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:23:01 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::12]:35517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1isNqF-0002M6-IP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579252972;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=BjiKswJS4GhFWbLUlRqJaKYaaiu1UvMZndAL5VLZR9s=;
 b=ZKS4VPZoGmcijxF2y5o4siEPLE/YU8aQ+4JwUBWBFblgieXJacQG8Lyj3Z0rDI3ICA
 SvOVxc9tJPf/u0eAVS/gVWapPiC00zuABIh3gxSyb/WKZ7rIf/nBhcsJcoxJBOprRvMp
 nXGYoSUFJM8GsdzK0oFGrebrUvAzEX79dGQTNnVjWV8FNOphgaO8XeOdCnilaE0bzGYc
 Z0zSfeF6IIvnVwyetFV83NSawFNXq7bDe6Qnzv6DqhiETY96Jp+dRoxLZYwP9UhvGa/8
 xHfWp7JENGKPn9v9je1Z/n11NWdWuZUkLiE0cmRRHbNNk88QWbzMz1qpkGDUAnjD++5X
 UFDw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuaMkK"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.4 SBL|AUTH)
 with ESMTPSA id j08473w0H9MpVnZ
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 17 Jan 2020 10:22:51 +0100 (CET)
Date: Fri, 17 Jan 2020 10:22:44 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200117102244.22edd8a6.olaf@aepfle.de>
In-Reply-To: <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/On7ozSqtCDglPYAdc71BSwH"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::12
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/On7ozSqtCDglPYAdc71BSwH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 16 Jan 2020 19:26:39 +0100
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> My understanding is that Xen is able to use "-M
> pc-i440fx-VERSION,accel=3Dxen".  The presence of the version in the
> machine type guarantees that the migration stream is compatible and that
> the hardware exposed to the guest is the same on the source and destinati=
on.

It seems 'xenfv' is not a 'pc-i440fx-X.X', even with accel=3Dxen.
The "xen-platform" will not be created and as a result no PV driver can be =
used.

I do not know what a 'xenfv' is supposed to be, and how it is supposed to
behave compatible for all existing and future guests.


Olaf

--Sig_/On7ozSqtCDglPYAdc71BSwH
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl4hfOQACgkQ86SN7mm1
DoD+cg/+OKu0tFq1InHEQPNmmrUcWCRpol2sPAv2X3prZCUFoYNYU7euuxD4Mo42
UMCubYr5yvNkTKkTJqG6DHnZPfbAQNTH/cXLn0WQzKiLQklAcHXW8Q74NfcRkEOl
rJwDcUO0/QKVev1zAG+mB3qs62l5q3g/AChWn7NHW81o1xsNGd5QTd5waOSsD31B
potEelN4Rrt65ir/Kr3swbaviLikyZPueYFHxfFHF3o+IZBcMemFMsNGghDjU+K+
MKAaA4o/Axa/4EmhmGwL22f8GImOEfLGqtRf3+hiFq7JRRFbvYF5aQFlo2fHz4/M
Y4n66x1Kl/rGjp4/ufA8BzQNhPP+x/6jNWRBesHxJkD14XyqqXrY2N8cN+RGYKvL
5/5ccnpmuOqFJW7Fusz2l2c+v736epcintrb9t5H2qIHxNG00GDAzfYI11M7rgWW
4di19X8H7ApG+bHqrHzGmHbgOZ5SCo5SABSK7sj4xtEd46yE2CKVcSMkd8iyREXW
33ZMkRED33WmbYQebkkW/Qa/zSxRkczCiZrtCuZvuoOlgefRQ3G6RhqNcrRf3O2N
B9Ar3CSPm3y+bA5eLgR+kUJiAvHYhOwaKTWohOgf3Yj0TTFmUDjxwl8e7G2m8jVc
yRy+AmmhJhwBlhmdH0igKnPBXAxncseDZVpKAD5UvC4ulFQnrZA=
=GHfV
-----END PGP SIGNATURE-----

--Sig_/On7ozSqtCDglPYAdc71BSwH--

