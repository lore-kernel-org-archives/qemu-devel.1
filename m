Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A44C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47810206DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXDBFflU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47810206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbu0T-0008W5-8w
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbtzQ-00083j-53
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:20:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbtzO-0008Gs-Cf
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:20:51 -0500
Received: by mail-wm1-x334.google.com with SMTP id t67so1997077wmt.5
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zjvT66KDSRhto4AqN58YhOzZlIDojjAEJZ+fZd83T+k=;
 b=TXDBFflUScAGXrqp7I8+qoOTp5dlKONm7H2XPzt2xTWRnHdKA7AbGPGmzGF3PoeGlg
 rkOyejThrqzbHv+Jc2KAoMfSbxaeKZDZDNwTWC8i1d3FakRPsElTZrX0tZ4k9H/5UWrF
 +jq+775e7xdlIUpSPfNXwdSw7Q6w4462aBW43DFobp2lZufJcitK7tIVC00bgSbB+sUo
 dEgaMiNI47CIWy4UiS4G5UsRIJxbEEa4ZiK/biYbhvHWUBcxqF0K+GYwhDX9ClbnM38C
 44g5IwICWI9aZu/ufPaUmMoUmTos3hawAhhBhvaLxSF4mvLLKHYSVvqiv+M4X399eSTS
 riow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zjvT66KDSRhto4AqN58YhOzZlIDojjAEJZ+fZd83T+k=;
 b=PL5eoOOrwEGRF21ZyawTb675JbvOiS8WD1Ebc7HsWIUq+B1vL8Sl8Ad3p2ShX1hCPJ
 h5AySaY64jvDyHHh2BhKCMq4OK63EzXxYqR+3Smzb5hSEkZRjB0GgFsWgogNGVMdVNO8
 rgEY2/82swW3YqcJ2MDtT5SxgApHZqTxc0pcClaqgpWFb/fCa5lSwzXgym6gD66oED46
 NUqlayKfEhOyX+qHrTWjykGMiKrj/OvWaSWVV+3pGHhSIM+dy/7cfSrYrDGMP7OPCipR
 UrO/JoLxkdTNSSnusbt3nDqFt05b+EcR01O85ZyCMqpMGoe+ieFa9GKpvuYA8oOVtgln
 otEg==
X-Gm-Message-State: AOAM5304bZ5mwCXUfx5TDkKPlmxmBbvxiQK4bhvZ9K/jyw/o6JxytgAa
 aNpn+iqdVGCI4nXMeLJ8jXI=
X-Google-Smtp-Source: ABdhPJz4y2TaC5RATR7MX7Tzaxnv3z3BZ+Ln17b1fjBXPRZE3qSW9TGexRAYT2+ae9AUK+M0VWiSag==
X-Received: by 2002:a1c:2d53:: with SMTP id t80mr10932637wmt.125.1604877648966; 
 Sun, 08 Nov 2020 15:20:48 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y185sm10956018wmb.29.2020.11.08.15.20.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 15:20:48 -0800 (PST)
Subject: Re: [PATCH-for-5.2] target/mips: Deprecate nanoMIPS ISA
To: qemu-devel@nongnu.org
References: <20201102202710.2224691-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f64a0e61-a479-1776-496e-aed7dde9eb4c@amsat.org>
Date: Mon, 9 Nov 2020 00:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102202710.2224691-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>, libvir-list@redhat.com,
 James Hogan <jhogan@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 9:27 PM, Philippe Mathieu-Daudé wrote:
> The nanoMIPS ISA has been announced in 2018 for various projects:
> 
> GCC:   https://gcc.gnu.org/legacy-ml/gcc/2018-05/msg00012.html
> Linux: https://lwn.net/Articles/753605/
> QEMU:  https://www.mail-archive.com/qemu-devel@nongnu.org/msg530721.html
> 
> Unfortunately the links referenced doesn't work anymore (www.mips.com).
> 
> From this Wayback machine link [1] we can get to a working place to
> download a toolchain (a more recent release than the one referenced
> in the announcement mails):
> http://codescape.mips.com/components/toolchain/nanomips/2018.04-02/downloads.html
> 
> The toolchain page mention LLVM but simply links http://llvm.org/
> where there is no reference on nanoMIPS.
> 
> The only reference in the GCC mailing list, is the nanoMIPS
> announcement: https://gcc.gnu.org/pipermail/gcc/2018-May.txt
> 
> The developer who authored the announcements have been emailed [2]
> to ask for more information but all their emails are now bouncing:
> 
> - Your message to Stefan.Markovic@mips.com couldn't be delivered.
> 
> - Your message to smarkovic@wavecomp.com couldn't be delivered.
> 
> - Couldn't deliver the message to the following recipients:
>     Robert.Suchanek@mips.com, matthew.fortune@mips.com,
>     marcin.nowakowski@mips.com
> 
> Our deprecation policy do not allow feature removal before 2 release,
> therefore declare the nanoMIPS ISA code deprecated as of QEMU 5.2.
> This gives time to developers to update the QEMU community, or
> interested parties to step in to maintain this code.
> 
> [1] https://web.archive.org/web/20180904044530/https://www.mips.com/develop/tools/compilers/
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg756392.html
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  docs/system/deprecated.rst | 23 +++++++++++++++++++++++
>  MAINTAINERS                |  6 +++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)

Thanks, applied to mips-fixes.

