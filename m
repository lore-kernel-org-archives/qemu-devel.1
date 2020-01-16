Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123CCC33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2862464B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQDyLvos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2862464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9SI-0007g4-2I
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is9RT-00075e-9T
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is9RS-0002Xc-8z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:00:27 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is9RS-0002Wf-51
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:00:26 -0500
Received: by mail-ot1-x344.google.com with SMTP id p8so20158625oth.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kJxILsF4SiOaMkqCzpZ49tewmt0Vuw9F+FxGG9I7Ngo=;
 b=FQDyLvosUM+6b+kQwv5RyhY1UG+OEASXM7O+Rm4Ps0qRh9G7/BB6++qxqmjQKJ+jv/
 ASBm6r0DIgr8aHYSMkZVZsC/T2AsqLa59GETiW6cuVxGxsIiwff3jpg4joDSBuhWG6zI
 T8OUd9iJHvpcbUZah6opj/B2MTC73Z1zgHKlAgdxINGT+spT9D+hu6RuWCqB972h9FE/
 RuKwKTu5nmMU7zbAkkzR7e3KM+kiY+s8d0XHKT8t5icJNWcF7fHJkrAhM386CQhcYzfr
 hEh9VScSXx+WapykNd0Nbh9J2ALWPLbw4FfviuJi5iZzKB4w/QJQJigfjGHFpsS+3Xe9
 YYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kJxILsF4SiOaMkqCzpZ49tewmt0Vuw9F+FxGG9I7Ngo=;
 b=r6vlKWyT/tCBm5ziWp/heKSiYrH8FY/TMx3HE5ZbQVb5Yg1zH0NDzYvH8jxdLnSxUO
 EWg3zq6G2O71qByDw1ooGnaIC7gz26R8xHOKWIwnpYYLMBtMa+aOJeTjXb1NrQeo6pbw
 QSUuasPilRvbBCD9X61x4BNGR1uuyO+v63Pu2UvHkzDFsnYa0CPQqBOYwNZqCJMzfe4z
 bL99zW1q55q3C+v0g4hgrAoOaFSsw6Ksb6ObBX3fSn0V65nKOK4ylgiMKTUZ8yM9Powe
 M8zYwzIehJ1EenXhvdC4f3442p5Zi+ylWRgu1h5hXenEPvYOucys0l3jisU8O5WxNVS/
 O5/g==
X-Gm-Message-State: APjAAAWPYpufkzzq09ZBMgVJWKw4kuoGNxCPTVPhYfuGtGMJaa3/CrCy
 7KYC96zR2Z7F6eX+9k7didZt6cLXKSTR1Xo16SkKQw==
X-Google-Smtp-Source: APXvYqzOZqIld2EirXI5snf2XKTwvKcyVRu6Rkq8vVKQgQs1HPgDQCliUqN3qgVeP2Gfzt8/Kh63H3PC+7OPjPBl7Vg=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr3046385otd.91.1579197625271; 
 Thu, 16 Jan 2020 10:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20200113155934.97572-1-jeff.kubascik@dornerworks.com>
In-Reply-To: <20200113155934.97572-1-jeff.kubascik@dornerworks.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 18:00:14 +0000
Message-ID: <CAFEAcA8NFO0_ZuezUbzFe7yFFN8G3JAF-c43evFbcZgvhn2UBA@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: adjust program counter for wfi exception
 in AArch32
To: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jan 2020 at 15:59, Jeff Kubascik
<jeff.kubascik@dornerworks.com> wrote:
>
> The wfi instruction can be configured to be trapped by a higher exception
> level, such as the EL2 hypervisor. When the instruction is trapped, the
> program counter should contain the address of the wfi instruction that
> caused the exception. The program counter is adjusted for this in the wfi op
> helper function.
>
> However, this correction is done to env->pc, which only applies to AArch64
> mode. For AArch32, the program counter is stored in env->regs[15]. This
> adds an if-else statement to modify the correct program counter location
> based on the the current CPU mode.
>
> Signed-off-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
> ---
> Hello,
>
> I am using the ARMv8 version of QEMU to run the Xen hypervisor with a guest
> virtual machine compiled for AArch32/Thumb code. I have noticed that when
> the AArch32 guest VM executes the wfi instruction, the hypervisor trap of
> the wfi instruction sees the program counter contain the address of the
> instruction following the wfi. This does not occur for an AARch64 guest VM;
> in this case, the program counter contains the address of the wfi
> instruction. I am confident the correct behavior in both cases is for the
> program counter to contain the address of the wfi instruction, as this works
> on actual hardware (Xilinx Zynq UltraScale+ MPSoC).
>
> I have tested the above patch and it works for Xen with both an AArch64
> guest (Linux) and an AArch32 guest (RTEMS). I'm still getting accustomed to
> the QEMU code base, so it may not be correct. Any feedback would be greatly
> appreciated.
>
> Sincerely,
> Jeff Kubascik
>
> Changes in v2:
> - Added braces {} to if-else statement, per patchew feedback
> ---



Applied to target-arm.next, thanks.

-- PMM

