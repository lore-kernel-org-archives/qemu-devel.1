Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9946FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C6E2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye4A1F9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C6E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7aYd-0001ww-Kh
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7aY2-0001Wq-MT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:31:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7aY1-0002gm-0c
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:31:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id a14so14076428wra.5
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pzM5zy39YS37eRHE7FnipY8K5CRyPtgNWAO1/R0K9DE=;
 b=Ye4A1F9ouTpWLMU9NBlqS9ezMoC543vWFdGOnuRLwStIUD9zONR8XWaGRaaluBbvI4
 8X86wbelz5I6o1B7i6qwMFX/mOOywyzLvwipJhAH2eX8kwhDJuu9WtB/O2OgvFRpzUg8
 EplsdDAWL9YR7CDPwAW89tehiQ2zXHvrUJSi1l3Gb+2VQS5DIL72PwlcVbvPuf2dlEcJ
 WmHqiGAWEci4mGyJfu1qHbjuR0fct5AqihrBSO/C1eF9xcKFlpstADx5FWN06ZY54Jto
 X9mlstYE3s4+R/YZSVaYPz+aYn36vtvzYSFZm/cgAP2f2pTdHwZ+Z3+aUHBA4it3kc5V
 /b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pzM5zy39YS37eRHE7FnipY8K5CRyPtgNWAO1/R0K9DE=;
 b=OJ3N9LpFxfZxZI2EjYbGeQ3dr2UVQVWr3a0XDBTfs9DHBQxeNkBRGZGQ0dPDqd6Wf3
 WxjoIRTwEbZYx5pm844VnxWQINK9Y0vm63p4rKTUAzKCiPrYxtKoqeui2lLGtV/gCiQ5
 Av25/pvHApxxZr5md+K8MVuTYli6W8omDsUXWXVFxh2kTqHwX5PpNbe0rBX+tjnLbsT8
 DLhHYKkFlDSyU2KYczkz0rZNSreJRAlAGTKFOhuMoImsGjCiKheEkZSBCUcG9neRZ7m1
 DKyV68L1x3DgJFb2PFAp/6bW/woS4zpP4C/y+NmfWRouOGiCmZKsCFotuw+diwQvgSmD
 ct0g==
X-Gm-Message-State: AOAM533jF7/GN2eUFlAKreHQssa+S+VaQD/CPlUIZFpOhtIbhnMp5HIj
 VPrNqxYpDRIZXxhbqpuRsKJBHtQzkmc=
X-Google-Smtp-Source: ABdhPJzmuWRnCI2PqKVqHAoG7hFiiyLhEIfeeQjAxT+8svwygLByKOYIUqtUYnp+Qf6/oH3JjCJ38Q==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr13370517wrh.381.1597653075132; 
 Mon, 17 Aug 2020 01:31:15 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k10sm31192366wrm.74.2020.08.17.01.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 01:31:14 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] Add the NVMM vcpu API
To: Kamil Rytarowski <kamil@netbsd.org>, rth@twiddle.net,
 ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, max@m00nbsd.net, jmcneill@invisible.ca
References: <20200811141049.15824-1-n54@gmx.com>
 <215c2dff-56dc-0e2c-6648-6055b7ab2146@netbsd.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b235a6e6-6d8c-4c9b-1e00-51461252fb5a@amsat.org>
Date: Mon, 17 Aug 2020 10:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <215c2dff-56dc-0e2c-6648-6055b7ab2146@netbsd.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kamil,

On 8/17/20 9:59 AM, Kamil Rytarowski wrote:
> Ping?

1/ Your series misses a cover letter, see:
https://wiki.qemu.org/Contribute/SubmitAPatch#Include_a_meaningful_cover_letter
(no need to repost though).

2/ Please wait at least 1 week between pings
(except for critical bug fixes in pre-release),
the maintainer taking this is probably busy.

3/ The 5.2 development window is still not open,
see i.e. the opening commit of the 5.1 tree:
https://git.qemu.org/?p=qemu.git;a=commit;h=a7922a3c8

Regards,

Phil.

> 
> On 11.08.2020 16:10, Kamil Rytarowski wrote:
>> From: Maxime Villard <max@m00nbsd.net>
>>
>> Adds support for the NetBSD Virtual Machine Monitor (NVMM) stubs and
>> introduces the nvmm.h sysemu API for managing the vcpu scheduling and
>> management.
>>
>> Signed-off-by: Maxime Villard <max@m00nbsd.net>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> Reviewed-by: Sergio Lopez <slp@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Jared McNeill <jmcneill@invisible.ca>
>> ---
>>  accel/stubs/Makefile.objs |  1 +
>>  accel/stubs/nvmm-stub.c   | 43 +++++++++++++++++++++++++++++++++++++++
>>  include/sysemu/nvmm.h     | 35 +++++++++++++++++++++++++++++++
>>  3 files changed, 79 insertions(+)
>>  create mode 100644 accel/stubs/nvmm-stub.c
>>  create mode 100644 include/sysemu/nvmm.h

