Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7FAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80F320708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhsW1qqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80F320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTQI-0002Mx-S8
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtTPS-0001we-L0; Thu, 09 Jul 2020 06:04:07 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:37124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jtTPQ-00050o-GI; Thu, 09 Jul 2020 06:04:06 -0400
Received: by mail-yb1-xb42.google.com with SMTP id x9so775218ybd.4;
 Thu, 09 Jul 2020 03:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Nl24aYNJ3Frh8FTGd2qXFksBTp94LCTNu58FNuyNa5A=;
 b=UhsW1qqd3LKBgPcn4uTW61FsoVc1qQPbLjHeE18YiHtCbokPXNAcE0Dwoca0YlFMUC
 R4MgHYn+IOY1eSUmWLjIB3YC3aNWoofoe8lJgX9h6Q26xIwcCFbilp5hT/3OnREu30Kc
 OfIRdJV45Dgd57VTboXSwd2jOZUYVGSRB2fPTjY/ejNQAhHC2GLxvHxME0A2u+zGxTXH
 eDsX9rYWxRqCcW8wr4hWEk+biFU65UjNBtrxHEJg0NyRxTWwlox+PEfSQyfs68OEgF6l
 zDSSJg5MTV5j+b/KwOvM8rDJnu3Jbh6VCEfEZ6qi7L/Xyrjf/U1J0kInfG6Bf+AQ44oJ
 4fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Nl24aYNJ3Frh8FTGd2qXFksBTp94LCTNu58FNuyNa5A=;
 b=UmYtvnXt4MYc2ubWawxSoLUeQvxZkBRtPGgGkqGaFrudWU8kl/7H++Yob5UJpONjJe
 ZBaxkE5OL0wlJKmPgFfyM/4XM9Cz+GDibTkkS6VQu3UY1RgsI876+OKGqf3Oyn3dnryR
 eKv76rjWX1iZaQVPVMHxjTTF4XKf8bAyUYap62gpaugaGV9mVggXkWp82gV+3Gy8usL5
 rk9ycW/IeGONvx/4A7GhJyP8YigUwnazu2XrHi7rOdzqBRwBWfPKtNVfuQnUY8G9Z0xQ
 SxJSd6UWKvM2eUCorbXtXPFQcSOxty/hfYhPa7dVNMUkk9pGnsDPrDSIoXg0PHRs6Cuu
 J4Dw==
X-Gm-Message-State: AOAM531D86bQUa6B3jhelhlzBdbwvWBmu7Py1g6XJszXEtvla2fSDM4L
 53EsxGr0oVxbbq4TtJCznN1yCmFm8/4azotYkJw=
X-Google-Smtp-Source: ABdhPJzukp5mpiHZ3A+JZWbAeBLn7P1aSJA0gnWpf2PpT6eAmQW7lmwHhYMOW0hMVtNc22KAFnKsPenPsy5Fgqxcw8E=
X-Received: by 2002:a25:46:: with SMTP id 67mr15591747yba.517.1594289042753;
 Thu, 09 Jul 2020 03:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <1594256945-21744-1-git-send-email-bmeng.cn@gmail.com>
 <0dbf53ec-da16-1188-900a-b416b92a057f@amsat.org>
In-Reply-To: <0dbf53ec-da16-1188-900a-b416b92a057f@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 9 Jul 2020 18:03:50 +0800
Message-ID: <CAEUhbmXq+vVGzBkod8_HTFVD9eerF7KBXt+P_jqfr5i5dFp_Xg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/riscv: Modify MROM size to end at 0x10000
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Thu, Jul 9, 2020 at 1:15 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 7/9/20 3:09 AM, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > At present the size of Mask ROM for sifive_u / spike / virt machines
> > is set to 0x11000, which ends at an unusual address. This changes the
> > size to 0xf000 so that it ends at 0x10000.
>
> Maybe the size is correct but the first 4K are shadowed by the DEBUG
> region?
>

The DEBUG region does not match what the SiFive FU540 manual says. But
we don't support DEBUG in QEMU anyway :)

> Anyway for QEMU this patch is an improvement, so:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Thanks for the review!

Regards,
Bin

