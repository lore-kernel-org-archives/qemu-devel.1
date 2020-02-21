Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A63AC11D00
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 02:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598A1207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 02:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofK53K3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598A1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4yDq-00019w-Gk
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 21:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j4yDH-0000ih-VQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 21:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j4yDG-0007W1-TZ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 21:38:47 -0500
Received: from mail-yw1-xc30.google.com ([2607:f8b0:4864:20::c30]:36504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j4yDG-0007UZ-PQ; Thu, 20 Feb 2020 21:38:46 -0500
Received: by mail-yw1-xc30.google.com with SMTP id n184so438813ywc.3;
 Thu, 20 Feb 2020 18:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9mJqNg+kd+Gnur2BCeF91WJfZ2SqDXmGECeJIATH4fY=;
 b=ofK53K3tKYbQyevhOmAsegcpMBB1URHWKWMmxFG5WzodnbIY3SdBQAiDaeScAS4DmK
 2vXfaJbWtqxCPdhCmU5XBDgwRzIwTBPN2eGTExpB+sDFmrw1bEL9AnYIDcI8NBifZEly
 adk0C9MgTq7+Vdn27bKBonSu+hWzwhud92cVgy7o+uLA8VP1GQa1d0Sh1fxm1ScZWCDN
 B42foE/ZWyMKG50AgHNe+f1yUTagmGL3qNruWOLQLCVLAyJQNnLmTjZ8j2v2mZmeHL4T
 5Kz9jYwhmqslICKR/eEd/Hvh+TdNcSxiolYLn4FV+bgTAiHvNZTUOM9Md6SLIv3Q2PrH
 XN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9mJqNg+kd+Gnur2BCeF91WJfZ2SqDXmGECeJIATH4fY=;
 b=QTyY4DVGW8MVj6eo2nv9oDtpWgRZ/T3FIbw3lwc/Ze3qoiYY89Jj17BWRzfHjLBCZ4
 SpfeWogjfiMmbc5+XEacPFnJok5MJWgWHDZ6GHw4vi66W1R2Lwsy9GNLSmDfqZgjBgQ7
 B0cho7NYN2l4FcLUPPDrJ7MMOrJfyTtf+qRbEFi4286aoS1XLXay5es7IFd4MM1fREw+
 ORSTDrovOYEuUfRia2YGF12t2tu5eIDuY2PeqMEU4SLPqzvMkH3LQZXnGQvWRZpeTQn/
 t2G4AMOGO9XCwPhz+LHMzbAmV6YwT87AK79yBfMM6nNahVe65OBJY2VtpHU4rOl9pt/Q
 IOmg==
X-Gm-Message-State: APjAAAW0gND18XNAD++mRbqtvv2Qouew4TCHaTk5Fe40vJfFHazel9Gf
 WzZ0XiwoO4P+i9qw+ThGLnmHn9aCBBwWDmFak1A=
X-Google-Smtp-Source: APXvYqzycAbddCUu5M52aui6RtGg3wAB8VVWFjrIkikTw2jazsAnA5pgI/1UXiMQ9lj2327ApdDZj+sqCpcvnZDP2ZI=
X-Received: by 2002:a81:8606:: with SMTP id w6mr27116959ywf.137.1582252726048; 
 Thu, 20 Feb 2020 18:38:46 -0800 (PST)
MIME-Version: 1.0
References: <1582209758-2996-1-git-send-email-bmeng.cn@gmail.com>
 <f92f1ec7-ac03-a012-f232-32c533beb9d2@redhat.com>
In-Reply-To: <f92f1ec7-ac03-a012-f232-32c533beb9d2@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 21 Feb 2020 10:38:34 +0800
Message-ID: <CAEUhbmV9ouup0aqrUvEfpGFAoggVNJXw-PLD0xYurBXg+h3OMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: roms: Add 32-bit OpenSBI firmware image for
 sifive_u
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c30
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Fri, Feb 21, 2020 at 1:31 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Bin,
>
> On 2/20/20 3:42 PM, Bin Meng wrote:
> > Although the real world SiFive HiFive Unleashed board is a 64-bit
> > hardware configuration, with QEMU it is possible to test 32-bit
> > configuration with the same hardware features.
> >
> > This updates the roms Makefile to add the build rules for creating
> > the 32-bit OpenSBI firmware image for sifive_u machine. A pre-built
> > OpenSBI image (built from commit 3e7d666) has been added as the
> > default bios for 32-bit sifive_u machine.
>
> With QEMU:
>
> fatal: ambiguous argument '3e7d666': unknown revision or path not in the
> working tree.
>
> This looks like an OpenSBI commit but QEMU only include up to v0.5.
>
> Can you build v0.5? Else can you update the submodule?
>

Will do in v2.

> Also, can you add a CI job to build this, so we have reproducible builds
> (see QEMU commit 71920809ceabed as example)?

I cannot find any document for how to test CI job with gitlab CI. Does
QEMU has a public CI runner for testing?

Regards,
Bin

