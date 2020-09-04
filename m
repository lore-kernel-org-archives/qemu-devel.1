Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F30C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E570E206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNPOpmGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E570E206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEB53-0001V2-2H
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEB3j-0008VL-5N
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:43:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEB3g-0006l2-Nj
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:43:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id w5so6612699wrp.8
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XOYK2LNZrbY7uLOwOomLIdV+XRY5uWBmgOIPdTTlwNA=;
 b=sNPOpmGjsJQVNnlj74g6rcmU/o1Y6DciklPe9wuXIYDhxQm6GlvEU4Ejis79j1zT9U
 6wnmCJ01KtwwxkYBSk2qT8gbEQXGG4STtIvdbRJqa91EZnRrauqCOocg0mqGbd1IynTC
 WJQ6vLnesBAPeUMs/xe1eN3pdUsv3wuqQDEfL7mvXoTDlhNogF3O0Pcu13ZhsSXIkDzl
 eZv++3Y97n75LQpSGrac2OVPqCGVIZ5weKVS2q+c1BdWfofO/Mr4PLMM90BJvBeCA7+N
 V3raz9dg4b8M1PY+a/LPSs2qq+oYdsl140DeUA6nV7EBpupeY2235KOV5drX2YTJykMJ
 uMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XOYK2LNZrbY7uLOwOomLIdV+XRY5uWBmgOIPdTTlwNA=;
 b=Fm8f8NA8bvd6mc9ntHMw96Ub25QWj68WKXj12cElGwIDi1bpNuQ3LSt1va1tiAvXM9
 i1iy87o/LuQBg16gLfS9Py5GbMBIQGKPsRWO7+w/MK3BwUbsJzOSNjXUjAqi6p+WFJMJ
 sM8maaLpr9FRzzMBw5MZiut1gn/ElK6JDuXGYL09tRlc5VjSbtcMHWAbiAbMdNaQ/NxI
 9dKUHWx8dB+iWwyphnq0tWOXUYN4EUkAsCTx0nl1wxXfRSCvQjRBRWT488BeeJSuiuqW
 PIfkdJRXwnczAwdHutjYt45g3bhTl3DQ2WfXUrpkmWLP3VUh/J4c3Dz/IwM7NeFMMi15
 PbgQ==
X-Gm-Message-State: AOAM530/8O27UAc1ILJSXSkB4lzpv9UEEaLuamGUP2zUgzXR246iEFz3
 y3e/er/ahrm6hW1t7TifAcs=
X-Google-Smtp-Source: ABdhPJz5NSeEVFKySOaIqFjgOf1LOb6Olg69bJLbY2+MB4Gwq6M4a8s0H5yrhTUo6pplKaP5pon3ag==
X-Received: by 2002:a05:6000:11c5:: with SMTP id
 i5mr7672796wrx.18.1599223390850; 
 Fri, 04 Sep 2020 05:43:10 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t16sm11245981wrm.57.2020.09.04.05.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 05:43:10 -0700 (PDT)
Subject: Re: [PATCH v2 04/12] target/microblaze: Rename mmu structs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
 <20200903072650.1360454-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b9a4acfd-8bc2-ca5d-e5f2-6ed7583d8012@amsat.org>
Date: Fri, 4 Sep 2020 14:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903072650.1360454-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.107,
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
Cc: edgar.iglesias@xilinx.com, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 9:26 AM, Richard Henderson wrote:
> Introduce typedefs and follow CODING_STYLE for naming.
> Rename struct microblaze_mmu to MicroBlazeMMU.
> Rename struct microblaze_mmu_lookup to MicroBlazeMMULookup.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/cpu.h    |  2 +-
>  target/microblaze/mmu.h    | 15 ++++++---------
>  target/microblaze/helper.c |  4 ++--
>  target/microblaze/mmu.c    | 11 +++++------
>  4 files changed, 14 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

