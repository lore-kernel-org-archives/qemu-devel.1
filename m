Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58AD207EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOxFl/y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58AD207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD39Y-00062I-Up
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD38j-0004RW-Ve
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:03:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD38i-00052S-7J
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:03:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id o5so801068wrn.13
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l38jv7hiIk6fX5RwuE4QuF5W1yfViQor2JQeE+xV7j8=;
 b=vOxFl/y7cvbR0AoqI65K84ItsmSJTa5o5EshH8gSQGalsWNA1YqAorZqrUHDGPEjvj
 PPr4Q1LZxUhaZwYMCsKyErqKPNLLlmLuktcxZGN6y6WaTYEm54nJVb04b0mvlVGIgO4y
 D7NvZzAmOh27/vKD92lRFoUCIHWsPHo1RvZ7vEC7cqvU8d71b3yQdegDaIToMNPt8rvw
 kxXLpv4yL90QevYayedIt1RRGslU1TdYaydNwGoLZRjkBwLTQqcuA6iP8eSm5WbLOvma
 704gcbPkiPU9n3Lv2GrcSFFQfZLwyz8xQqasjgCdkIQG82sJbBh5FLyMIhzL7wGeJDhF
 /5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l38jv7hiIk6fX5RwuE4QuF5W1yfViQor2JQeE+xV7j8=;
 b=o9zyJxDabqGIUi4Pa3rZy4lspeHwlUTYhjMNqhKT2x58bMt8myd07qwdfBMyTYnxBx
 twPMdDMpOe3/VR8rx7cLrPpwVfaWnHJ0Ocw9KFVEAtaYHD3gaceZsnDtLSUkdctrLJv1
 OMjx9bCndQQJt6Uy0PHmxTWxU8vbOijEv4MLw67ncZM95KYSLqZ9xNDuMooLZDPvWqPT
 KMbNLR971RjEMLSPcX6G0NKydMSvsCVvUNtpKoN/I4G+9ay+CAjozUgNRgtBxDoiT2n7
 qt9iUCKdjE8dHGZuQFuOVkxyVdBNQNoX5qF/mt3StpY9Xqff1F1/VW1MLB/GtDUMmDxR
 K/Wg==
X-Gm-Message-State: AOAM530/npW5Oa4YY1cQYWnC5nBaKL6Pw6DOvRr+Lmr6+mTm1e5PK9Dm
 CkVz5DiBMPYIF4CVH0qgG/Y=
X-Google-Smtp-Source: ABdhPJyP68JxeF7EEucGS3E0mYRaqC8G56NzUtcE8S0h8HBI3bC3IqJ8wRyTnzLtSWxkfx2F5apBTg==
X-Received: by 2002:adf:e407:: with SMTP id g7mr980752wrm.349.1598954622433;
 Tue, 01 Sep 2020 03:03:42 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id d18sm1332481wrm.10.2020.09.01.03.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 03:03:41 -0700 (PDT)
Subject: Re: [RFC PATCH v2] hw/display/tcx: Allow 64-bit accesses to
 framebuffer stippler and blitter
To: Andreas Gustafsson <gson@gson.org>
References: <20200822142127.1316231-1-f4bug@amsat.org>
 <24395.20047.450062.992384@guava.gson.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5a7d94f9-eaec-c8f6-da4a-3ec0cfc68961@amsat.org>
Date: Tue, 1 Sep 2020 12:03:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <24395.20047.450062.992384@guava.gson.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
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
Cc: Michael Lorenz <macallan@NetBSD.org>, 1892540@bugs.launchpad.net,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 8:59 AM, Andreas Gustafsson wrote:
> Philippe Mathieu-Daudé wrote:
>> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
>> index 1fb45b1aab8..96c6898b149 100644
> 
> With this patch, the kernel boots successfully for me.

Thanks, can I add "Tested-by: Andreas Gustafsson <gson@gson.org>"
to the patch?

