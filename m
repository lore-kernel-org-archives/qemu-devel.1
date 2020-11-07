Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C804C388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 15:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C494420719
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 15:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shmIUnip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C494420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbPtJ-0000r5-Px
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 10:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbPsk-0000Pt-Lk
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 10:11:58 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbPsj-00028h-3S
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 10:11:58 -0500
Received: by mail-wm1-x342.google.com with SMTP id s13so3999799wmh.4
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 07:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2EJXy1j7giWnSGXeUdkJHuBd9MSwCMKQHxLtKVZrALw=;
 b=shmIUnip3uzdQsNcDzSLOLtlCpxZLCGTQeGBywsyu5MCK3nc0tD2qtaOnkVCmOdcBe
 KIjnOIzU9kzJGhClBSF897L1jtt/EXs8Mma32dK8pPc+xcVeRQk0AZ8M6W04Ojh381s4
 6ASga+FdmtH9P7u7T23MFLRJGcKG03KWY6O4PBe4GYiBUGF3SKVy5sfc0g7tx7cHMhjt
 ljcgltTleDvabaIl7N5NoXkRfJ2/AVlSDMCW2SBcOODQZ01bq7JwS0t6T2m+w6jWTp6u
 3lusikkskccifatFLC8FDRzlqSBGR/GR8FhXd7iiIs2WHCaleMg4kGBb5nnLbjS1hf+u
 pstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2EJXy1j7giWnSGXeUdkJHuBd9MSwCMKQHxLtKVZrALw=;
 b=j/tDCbUVSTnnPns2ym4EnOeLVzrfTPUgmQvd0lXY2Q7Eo5SxcMysjRoS7f4VebCMNK
 /2puiOKNh8U+g8xF8yOuHdU8ozytm5aIpqfIv0nfCY5bNQm5NgVYpn0SfF8XBJ06a8JJ
 /Hhmu+3c72wF4urAgn2JWy0syBHuo1CFlzKKv4/20k7mkCYwIvnrD5CFCnJCYz5cFVn0
 2EIAt2JOLd8qAZYHh8TKxHdJhZSbrfhCHux8plev7GVLf2IK0nL/HFs6yDPIFzPnOR3c
 uMgDmCbDX4hPlghXBmlatxIhyIYYisuTMrxZ2yPgOzphEZ2H0UuYmsappn+Ay1eT4Wh0
 zn+Q==
X-Gm-Message-State: AOAM530cVGdxxKizm0nUsyiJNf0UC/YXYL6cCE9qsEmsPryE48aQsCE5
 GJA+0OxRM7G4ZlXPdJD8Xfs=
X-Google-Smtp-Source: ABdhPJyXEbq67Wzf4O0PJ6LaTDlprt2balwNubal+uJ/lKFwxIjXJcLFsYu8Mcq/6sP4OWPlotPwow==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr5325759wma.48.1604761915073; 
 Sat, 07 Nov 2020 07:11:55 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n9sm6777496wmd.4.2020.11.07.07.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 07:11:54 -0800 (PST)
Subject: Re: [PATCH 1/2] hw/m68k/q800: Don't connect two qemu_irqs directly to
 the same input
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106235109.7066-1-peter.maydell@linaro.org>
 <20201106235109.7066-2-peter.maydell@linaro.org>
 <11e6fcf5-fbd3-d2d8-ab20-c017080599d4@amsat.org>
Message-ID: <8a37182d-1c8e-ac5d-a0db-4d62e924869c@amsat.org>
Date: Sat, 7 Nov 2020 16:11:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <11e6fcf5-fbd3-d2d8-ab20-c017080599d4@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On 11/7/20 12:51 AM, Peter Maydell wrote:
>> The q800 board code connects both of the IRQ outputs of the ESCC
>> to the same pic[3] qemu_irq. Connecting two qemu_irqs outputs directly
>> to the same input is not valid as it produces subtly wrong behaviour
>> (for instance if both the IRQ lines are high, and then one goes
>> low, the PIC input will see this as a high-to-low transition
>> even though the second IRQ line should still be holding it high).
>>
>> This kind of wiring needs an explicitly created OR gate; add one.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/m68k/q800.c  | 12 ++++++++++--
>>  hw/m68k/Kconfig |  1 +
>>  2 files changed, 11 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

