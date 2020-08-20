Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE06CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9981A207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSXEA457"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9981A207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Zm1-0002lY-Tp
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1k8ZlU-0002FY-KX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:53:16 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:44303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1k8ZlT-0004wS-43
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 21:53:16 -0400
Received: by mail-vs1-xe41.google.com with SMTP id k25so340205vsm.11
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5fY6uLENvIP8/O+yKASXa5VJ8j7ZSDVEkteHFxVGL1s=;
 b=wSXEA457EIkl+roCtRKkpd5BMbWUrS0lIfL4L4HsrhJQmkFwslBvB42Tfutci54nDn
 1hCnYEqg50EBptOdeBNeJOuh7Sul/pW9uroKUYP3TyFMd5LEUQm/Nkm8d/NWKZpAi3xr
 GfWjrQ1nl2qlY7fPcq7t/6KFUc/6osBaOMlbUiAikTjEZv4JsNCUxpXvBXHm31VK2grw
 ioYyfACdQNrUl8veuxxcbbd+PDawU40bonKJb6BsGVTa4/toGh8VUCujEhcGOWxj4WV8
 FFW+qtZ8NWuvLhxofhLfE4CN9TFZtD8XyAViteHDHjdIdzSMwAcokKRsILrBNPInmcGM
 QTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5fY6uLENvIP8/O+yKASXa5VJ8j7ZSDVEkteHFxVGL1s=;
 b=nDQBFkMsvC8KFG2k28zDmUnTwKf/Qd3wwpnIsI4dLbSpI8um9zgMc4bvKm5otX6XzK
 OxyipB/5NTDqI0e7qfIgycOqThjQviQcV8XtF0wDv4WIZTmHMdyE6qDHaFi85kjfX5bj
 8O3gWjEaaBhC+IByw4WLm3GI50J7uwOzJUE2gVoNCWwrDPUqAx83dfn6+Tr8zrWQRn/7
 GFVCbGBhtHNx2SkgrA/YA/hniDog+zrHhSaIgQIWO2x8rweEyhR4m2sj2QIVANngGVG0
 YSWZ/T7TuBk7iNyrnpQ+f9KQ5pi/QLXJ7bH46THMqwymZHBIhtpzkjjYrORzw096O2UC
 nayA==
X-Gm-Message-State: AOAM532NMylyu9PQqgBdBph3kn99YzT+LfatZRcO07C8emtBP8AuPZ+t
 YossQOAIiSRK+itDpPW0pIowktArfVZIzzNeaQZM0w==
X-Google-Smtp-Source: ABdhPJx71sxin27FBlXNrUalaGbHoK06gYvb6dBlmvDcxf1Tib0JHsIrUIb3QK4x8QsQK+j5bhJh8gqDJSXgNkxblIo=
X-Received: by 2002:a67:7d50:: with SMTP id y77mr665080vsc.207.1597888392435; 
 Wed, 19 Aug 2020 18:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200811004607.2133149-1-hskinnemoen@google.com>
 <20200811004607.2133149-14-hskinnemoen@google.com>
 <64f8cd56-306e-4961-488b-36c666894a54@amsat.org>
 <CAFQmdRbvSKYJ00tE_79Eh+gW_ge8kEco=1gqFtvMcoJGraozdw@mail.gmail.com>
In-Reply-To: <CAFQmdRbvSKYJ00tE_79Eh+gW_ge8kEco=1gqFtvMcoJGraozdw@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 19 Aug 2020 18:53:01 -0700
Message-ID: <CAFQmdRZCk5Rqb1C2TRCEUMaKmF608g2_Or8mLCTSG03nCQ1Ygg@mail.gmail.com>
Subject: Re: [PATCH v7 13/13] tests/acceptance: console boot tests for
 quanta-gsj
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 8:26 PM Havard Skinnemoen
<hskinnemoen@google.com> wrote:
>
> On Tue, Aug 11, 2020 at 1:48 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> > INTERRUPTED: Test interrupted by SIGTERM
> > Runner error occurred: Timeout reached
> > (240.45 s)
> >
> > Is that expected?
>
> I'm not sure why it only happens when running direct kernel boot with
> unoptimized qemu, but it seems a little happier if I enable a few more
> peripherals that I have queued up (sd, ehci, ohci and rng), though not
> enough.
>
> It still stalls for an awfully long time on "console: Run /init as
> init process" though. I'm not sure what it's doing there. With -O2 it
> only takes a couple of seconds to move on.

So it turns out that the kernel gets _really_ sluggish when skipping
the clock initialization normally done by the boot loader.

I changed the reset value of CLKSEL like this:

diff --git a/hw/misc/npcm7xx_clk.c b/hw/misc/npcm7xx_clk.c
index 21ab4200d1..5e9849410f 100644
--- a/hw/misc/npcm7xx_clk.c
+++ b/hw/misc/npcm7xx_clk.c
@@ -67,7 +67,7 @@ enum NPCM7xxCLKRegisters {
  */
 static const uint32_t cold_reset_values[NPCM7XX_CLK_NR_REGS] =3D {
     [NPCM7XX_CLK_CLKEN1]        =3D 0xffffffff,
-    [NPCM7XX_CLK_CLKSEL]        =3D 0x004aaaaa,
+    [NPCM7XX_CLK_CLKSEL]        =3D 0x004aaba9,
     [NPCM7XX_CLK_CLKDIV1]       =3D 0x5413f855,
     [NPCM7XX_CLK_PLLCON0]       =3D 0x00222101 | PLLCON_LOKI,
     [NPCM7XX_CLK_PLLCON1]       =3D 0x00202101 | PLLCON_LOKI,

which switches the CPU core and UART to run from PLL2 instead of
CLKREF (25 MHz).

With this change, the test passes without optimization:

 (02/19) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_q=
uanta_gsj_initrd:
PASS (39.62 s)

It doesn't look like this change hurts booting from the bootrom (IIUC
the nuvoton bootblock overwrites CLKSEL anyway), but it's not super
clean.

Perhaps I should make it conditional on kernel_filename being set? Or
would it be better to provide a write_board_setup hook for this?

