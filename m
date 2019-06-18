Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B524CC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D2720B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 22:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS55AJCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D2720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdMUa-0000bh-Qz
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 18:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdMSM-0007BZ-Dk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdMSL-0001de-A5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 18:19:58 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:43249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdMSK-0001cI-Su; Tue, 18 Jun 2019 18:19:57 -0400
Received: by mail-lj1-x241.google.com with SMTP id 16so1129197ljv.10;
 Tue, 18 Jun 2019 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aAJWVVec2Jigq26RokbFHtvW8G9YhYkNmX2iMrQF5lE=;
 b=dS55AJCvYsoR8xfgTZb+RtYoek/PKIsQgOxQz3xxCXgslJcut/r8rOxGTPgrsfe1g0
 4hoUInawsIu+kAR4pEXzKDfcz9ceL5znGyRZSBSX08hlB0J0HDJNl8ITxYQDz13/zvLn
 Mj2agxTyFJ6L/FkAwc2RFopsqwkI3YDDx4tFZ05PwvhDEglmJ7clNV/qZ84zi6cuyJA6
 4PT8KZbcYyawR2LRGGoi7RVMc+XK2aW4EAMR3uCgVNXUibgrbRY6TK/EHPkT+EPQmRve
 T+l1Ee+3/intZYTz4JcFzi0YnnBynkIsnGli/035ruGi3ku0cD5erI6wamxUPNoa/OUc
 JAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aAJWVVec2Jigq26RokbFHtvW8G9YhYkNmX2iMrQF5lE=;
 b=tdDhUxPA3AzJ9Iy59wT6E6D/rfe69/PUPXE5bL9r+aCCQW02z6CfRKOZhk3a4sI/sI
 yN1HbinwR0TqZPdFm4rPftU8sYR8nK4i3X11PwpZFtzAchCK1o+ppkMP3kDDyUcVKvkw
 Ux0vW5Dy/n3iWviQIv90AXhwQ+BT/Wt7rabXJP/yjUOxYlP9dsugjZO3LP29KfULv85F
 C1hhFS1/kfMqkcvTvLqvQYoRVWI5N1uVC3crRrtZiwLb7MkLfbGFlB7VBGWToy8fiGvo
 tWM6buka6qEiyWMyouyVYvzHF8ecqW7NTC4vD7JYpEBZJWBG4cz+7N+WNuKNHeJFrbo9
 O5mw==
X-Gm-Message-State: APjAAAVELoumjpDj59QhUVRolHLnplRFRaUBkfxk2+Q4w/7z9Q8oU5qF
 Sy4YAEogCe9q1ehl+47lLpu9SVs3zqfVddXgL/Yvel/i
X-Google-Smtp-Source: APXvYqwlVDRjRKxSxiUCkwiCpZcGt/auKl/RQmuJj4z23mhf2qXLrj3mMH04/KSk99wm0T7jbaPuzVpjEEURGelJy0g=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr12553772ljj.58.1560896395174; 
 Tue, 18 Jun 2019 15:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMs4nt0eddFkXHG9vOdxnj=yB8jx8s9NivNiwvVg8TObA@mail.gmail.com>
 <mhng-03d5c9ed-4818-4efc-99e0-cdceab2eab3d@palmer-si-x1e>
In-Reply-To: <mhng-03d5c9ed-4818-4efc-99e0-cdceab2eab3d@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Jun 2019 15:17:07 -0700
Message-ID: <CAKmqyKOE11M=yn_xbHG3yGDLzC8tCNjL3MkkW54Zu=EjwrVa6A@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] RISC-V: Include ROM in QEMU
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>, onathan@fintelia.io,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 7, 2019 at 5:03 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 06 Jun 2019 16:22:47 PDT (-0700), alistair23@gmail.com wrote:
> > Hello,
> >
> > As a test of the waters, how would the QEMU community feel about
> > including the RISC-V OpenSBI project as a ROM submodule?
> >
> > The idea would be to have OpenSBI (similar to ATF for ARM and a BIOS
> > for x86) included by default to simplify the QEMU RISC-V boot process
> > for users. This would remove the requirement for users/developers to
> > build a RISC-V firmware. The goal here is to allow people to just
> > download and run their kernel as easily as they currently do for x86.
> >
> > We would make sure that it can be disabled! That is users/developers
> > can use their own (or none) if they want to. The idea here is just to
> > simplify the boot process, not lock anyone out.
>
> I like it.  My only question is about the mechanics of doing so: are we just
> going to assume there's a cross compiler in PATH?  I guess that's less of a
> usability headache than needing a complier and a firmware.

It looks like we will include a binary in the QEMU source and also
provide the option for users to compile it themselves.

Alistair

