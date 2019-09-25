Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E50C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D7C21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkOUvG0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D7C21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDA0j-0001tq-BL
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iD9y5-00081H-Gr
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iD9y4-0002fN-A3
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iD9y4-0002el-4H; Wed, 25 Sep 2019 12:16:40 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 46F2921D7F;
 Wed, 25 Sep 2019 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569428198;
 bh=G2rWrfgCLyXkXuoP1p6fWLaQHHJK8GenQPy5V1iTb3A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=QkOUvG0SpvalvnxfvNk71KeNopsp05lh1aPxatreGIgRrnZ5v/1pg/A8YA02OiYO7
 BOIratqJaL+8mFKYx2z68MxogCEpV+vKBC/6tjk5xP0cWZLYLjcLl+fa2/ki0W1hOm
 EDjsH9mIWIZWEIQx+v7lckDZ+rxxTzIfQX/uZKeE=
Received: by mail-wr1-f44.google.com with SMTP id q17so7655609wrx.10;
 Wed, 25 Sep 2019 09:16:38 -0700 (PDT)
X-Gm-Message-State: APjAAAV7IagbakWYxxdXI4VXCcSoXxbqLpg+Nrz7BUNsdMkTroLveuEQ
 k+0wcppMDngwIK+0M4/6qpY3pqbz9gCStZo+Z3U=
X-Google-Smtp-Source: APXvYqwMWMH9sHZMAxqHGk19ydPa07PadcsCmgVGvNPeGZhJ2/cyNBP0ur5l7Os6z/uyFWelhEphZjfHMdZQE3pjJMI=
X-Received: by 2002:a5d:49c2:: with SMTP id t2mr9903770wrs.351.1569428196823; 
 Wed, 25 Sep 2019 09:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <1569386895-8726-1-git-send-email-guoren@kernel.org>
 <CAKmqyKMraotFmqMg7MrJC5C4SogGqSaVtHkVYTEgGWK9UnWb5g@mail.gmail.com>
 <CAJF2gTR0o0s_p0H669BRZ86phLtpATwWczczWV8HWw1nc+doFA@mail.gmail.com>
 <CANnJOVFkviip0g1tBHdL6n2B8pMAQxVBC83RTaF4PAE1t+aPew@mail.gmail.com>
 <CAJF2gTS=1uaQi7=CXg7f0eh2xb-HcG_sriMtU208VHXnJ4GTvA@mail.gmail.com>
 <CANnJOVFkUAS3mP4y0mu+jCajy9m4hDK389xpZz4wza1t0Bvo_g@mail.gmail.com>
In-Reply-To: <CANnJOVFkUAS3mP4y0mu+jCajy9m4hDK389xpZz4wza1t0Bvo_g@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 26 Sep 2019 00:16:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQR7cZ+HNAfKwdQ9P3rJTStmmjVGZ7UsaA9dbMYh9PqYw@mail.gmail.com>
Message-ID: <CAJF2gTQR7cZ+HNAfKwdQ9P3rJTStmmjVGZ7UsaA9dbMYh9PqYw@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: Bugfix reserved bits in PTE for RV64
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 198.145.29.99
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Bits 63=E2=80=9354 are reserved for future use and must be
zeroed by software for forward compatibility."

That doesn't mean 63-54 are belong to ppn, it's reserved for future
and nobody know 63-54 will be part of ppn.
Current riscv qemu ppn implementation is obviously wrong. It shouldn't
care the software's behavior, please follow the spec.

On Wed, Sep 25, 2019 at 11:58 PM Jonathan Behrens <fintelia@gmail.com> wrot=
e:
>
> > The specification is very clear: these bits are not part of ppn, not
> > part of the translation target address. The current code is against
> > the riscv-privilege specification.
>
> If all of the reserved bits are zero then the patch changes nothing.
> Further the only normative mention of the reserved bits in the spec
> says they must be: "Bits 63=E2=80=9354 are reserved for future use and mu=
st be
> zeroed by software for forward compatibility." Provided that software
> follows the spec current QEMU will behave properly. For software that
> ignores that directive an sets some of those bits, the spec says
> nothing  about what hardware should do, so both the old an the new
> behavior are fine.
>
> Jonathan



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

