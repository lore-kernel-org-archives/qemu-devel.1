Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF99C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A92C216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX3V9piI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A92C216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38677 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlaL-0006Ma-R2
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:56:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSlZT-00061o-Hj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSlZS-0006hQ-HC
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:55:31 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hSlZS-0006ao-5a; Mon, 20 May 2019 12:55:30 -0400
Received: by mail-lj1-x241.google.com with SMTP id z1so13165016ljb.3;
	Mon, 20 May 2019 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=YdjGz1iUHCrBeRgBbXhnRBGUiP9Ld3ZHUDxu+Ht+8Lc=;
	b=GX3V9piI9dxxscXO00totoRV5oqJuU0ZEdn/tA248nS3Z2/VjJJfEsrG3z6im1A3kj
	yzckuUj0hVy054TJzIr+Jqnc8nb2df0PLLTWFTmK+9d+nrKgOpTjQKSJHKTwsSo71eZq
	fugc7g6p/QwY+ViiaHMnk4C/U3G9Y2ECxdB7iDDeKSqC+Zi7H97FnxXFJlMwvFdQcINm
	FBMgnovH87dhOJJRIo9U7ajb3FrWAr2Bqnu897GPzEmpR4Km+vY3IwliKv747fJJHQKy
	jwzPisuV1fiEPhMc+BO41I+2zFuMub6kTjVelD+n31kStzjVvU6NRbI1QVd5J+K/VJhx
	zIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=YdjGz1iUHCrBeRgBbXhnRBGUiP9Ld3ZHUDxu+Ht+8Lc=;
	b=p9EjYnck7d7+EmqewHTh/N12qz74fROdIvwjvmJVJsNLuhHJDTrakpBb1Xcozl4vJ+
	S8o5tv82LK6IaZCJYSWEEvDu7Rk1aatFQLxeh6+FteYICTkqEUWzRo+RdGC5pyYym6wb
	BF4xCZUexmVW4W7e+3rsIxV1UgAOTvfeo1oasTEBOdYe7T/JoRDdepI3dCevVoMwPpDW
	uxw8KnL3/K5T1WxiC/bB2N+D63HwMYtpXRSQAVXdpP3JtPFMXoVVfv/LNJDQttBfh2e8
	x6Mm1EB6gXdrGhC0Q476C6C9eTJ/2xQJWjVKhXhmSeiGZOzix2TifP5zAcMXKJc8Z+EN
	vlzg==
X-Gm-Message-State: APjAAAWI+VNJ4ABZUItrZx/cNVXxSXS1JtoQkjr02ASkYkNAbKbK60PR
	u+YJzmSydsq+cSHrSdJS1iFOXaZMmYEqQLWwPrQ=
X-Google-Smtp-Source: APXvYqx8AaxMskIR9+aEGolBuyHzRQhdjCe+VAVMPR+j80crpkDnIrcHUaJxBuq/j2KRCb8xgHvXq0eG305OztEXYBk=
X-Received: by 2002:a2e:9a4f:: with SMTP id k15mr32201778ljj.159.1558371324699;
	Mon, 20 May 2019 09:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190517222342.26394-1-jonathan@fintelia.io>
	<20190517222342.26394-3-jonathan@fintelia.io>
	<CAKmqyKMG6ffhQ5VYgLZ3XVfZ2-E_O9BH6UCanmLJ3awDDUfS_w@mail.gmail.com>
	<CANnJOVFE51rFdV0h0T6_dV6r37kBLcBQCo7Csg8NOUoYkOELpQ@mail.gmail.com>
In-Reply-To: <CANnJOVFE51rFdV0h0T6_dV6r37kBLcBQCo7Csg8NOUoYkOELpQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 May 2019 09:53:10 -0700
Message-ID: <CAKmqyKM3C59_w214=mqLFpfwPhUjcLL0EuOY0Yk3DQePx8ZTQg@mail.gmail.com>
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] target/riscv: Add support for
 -bios "firmware_filename" flag
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 18, 2019 at 2:57 PM Jonathan Behrens <jonathan@fintelia.io> wro=
te:
>
> > I've never been fully convinced of this, why not just use the generic l=
oader?
>
> If I understand you are proposing passing bbl (or other firmware) with th=
e -kernel flag, and then vmlinux (or another kernel) with the -initrd flag?=
 Wouldn't this result in losing the ability to pass a real init ramdisk to =
Linux? It also seems to open the possibility for strange bugs/compatibility=
 issues later if firmware starts recognizing any "initrd" entries in the de=
vice tree as kernel code to jump into.

No I mean passing in OpenSBI (or some other boot loader) via the
-kernel option and then passing in the kernel with QEMU's generic
device loader. This is documented as part of the OpenSBI boot flow:
https://github.com/riscv/opensbi/blob/master/docs/platform/qemu_virt.md

The only disadvantage with that is that we don't get debug symbols
from the kernel, but it does mean that the boot loader in QEMU is much
simpler.

>
> I do wonder though how compatible the current design is with providing de=
fault firmware for riscv in the future.
>
> > This should be in a generic boot.c file and support added to all RISC-V=
 boards.
>
> I can do this for v2.

Thanks

Alistair

>
> Jonathan

