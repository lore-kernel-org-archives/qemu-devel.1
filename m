Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17880C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC374206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="txV4awPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC374206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9yO-0002JF-W3
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1is9xW-0001mU-5p
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1is9xV-0003K3-58
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:33:34 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::1]:10955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1is9xU-0003Gz-Fb
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579199609;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=7zAoU+3rr7QyoeKkvETZLQc4VZ3lOAInsHTMv0XQi6U=;
 b=txV4awPVhNNIU3ZuINn4S2hHFI52TU8i+1PG64WeoQetiNyOVUa9gO2P1qr/1/GJxN
 vEzAVf+2JKKe51HDy1u6MYKDk7tP2OJvX8N5fMMxIEIs9f2liKHpAHO2mrNLAyeIO11z
 cwv8yoI2Lyb+MwZnd0emTxxn8lmIlBPc1tt+CzdZhqaTMbWKEk8t8Z5cS4fy4tahsD2H
 4KShTe3QMbs9t+upKYOR2JNZhyI0jE6x9AFdJ1z5+ateNg9HU99q2h7xYV9jFhKsTGpY
 yxOu+vukAihIU1B1BEXDkHQXz0QlueBkElz21s+fgwzZPxVes2QywPAM+cJ+5OGK9xWd
 iklQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuaMkK"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.4 SBL|AUTH)
 with ESMTPSA id j08473w0GIXSUEb
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 16 Jan 2020 19:33:28 +0100 (CET)
Date: Thu, 16 Jan 2020 19:33:21 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200116193321.37830fd7.olaf@aepfle.de>
In-Reply-To: <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bId61uGeT.S7BWzOhoLbw.J"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::1
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

--Sig_/bId61uGeT.S7BWzOhoLbw.J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 16 Jan 2020 19:26:39 +0100
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> xenfv does not support cross-version migration compatibility.

Wait, what does that mean?
So far live migration of a running domU must be possible from Xen N to Xen =
N+1.
It would be more than unexpected if the target host running "Xen N+1" must =
have the very same qemu version as "Xen N".

Olaf

--Sig_/bId61uGeT.S7BWzOhoLbw.J
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl4grHEACgkQ86SN7mm1
DoClfQ/9FXQJUMjL7Zv5Fb+GBfEJTippkh7I1kls0/EQhrFwx6tlE4tOwH0zPLq1
BObEL2NhMiFr4I9iSF5kjmH3ezgmHQxgZblza2DVly0xdTzo8bg3sJGfXmrijtEe
rkSZU4OucAk9xwTkKpClGXtdFEFlV4+soB50oi9z/kzdMCUxwwNUC8rIBmpdTb8+
50q54Cgfmc24DhWIX162hrTvA0J820JyO4J+uZqnD7iE07YjSRdVLMpQZep5gcmP
TynW/70EQNI+VZaSTCr97suKzHQvST7ZF3wdIZl7Z5N+loydIoBSxBou8vi5QetH
gZPTgiKgtV3EdoCp6/YOq3fWNlMaDjM48AfmEPJDrapLuneGMfS19yGWWncAeIS5
5MZy8jHU+3KW2hsYW2A+fmF28HbAnUhjDSzukpbnrikEF7Vezg+xSGypKEkZZPH5
S7Z5eVavwPV3DTmxs6vS/sXCHTtYoM9Aa+IMx1Zm/4EE+VtN+q86eC6H/0bvagw7
u71juKOVG+ZMXB1OYdK2hdsJ1R1nfrIHhKUqJlWER4kM7RDSCrHgKeh+0yDnfFv0
wFQJ2jZ/G/fjUIAnJTUVnWwODyPG5hAJrAxsc8yRJTRbaR6uvTbEXCuLEs422EJB
SQ5xq65g7ooh+0PNXgixdEq7okcWyyW60e2wCtLgS0EfMS54Sbc=
=Kxbw
-----END PGP SIGNATURE-----

--Sig_/bId61uGeT.S7BWzOhoLbw.J--

