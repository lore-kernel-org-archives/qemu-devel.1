Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9C6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A64F22261
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKil2ma5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A64F22261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuJI-0005J1-G0
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuHC-00032I-MW
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:25:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQuHA-0005UE-I8
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:25:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id n6so10422060wrm.13
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oLmpc8phkt8TfYjheqEATKdDv9YxbDnhtUrYNgM8bhc=;
 b=YKil2ma5yq1r9Xf+0TZm6lDQDM+WDFcaIlpuL1TJfiQ5WINJ1DcoWxqugVDJoAMwyI
 JZHwpaJIP+bG/xj7ijc9rYVdslV2u6K9c1UwPBuk/x6FaTH2JrLyj1yMtNar3vRVs8R9
 oTzloAcISEQieaPU0mBhF4YaNoKwCXkrb+MFjr8QQyMiWpi6SU0opLDsHIcrDkUUNsY6
 FxLOErf+S/ZJZGqj3g79cjf4GQirBmsjDS5zy9sj/yq3/PxRlFCsJtwtuAWI42LsNpp/
 UdoRRmGUisN71S8RLpRbwbCbdm+ulfaOlkWBCfXMHNSjOVu8nnO5O0sSOvJ/yTWHG4eK
 ALgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oLmpc8phkt8TfYjheqEATKdDv9YxbDnhtUrYNgM8bhc=;
 b=SpLwCJamVjbwOeCZMBxqdlRZ2976mNmNQqavgM/4XLOoWz1evOJjzrZh/MNxZ/R/FF
 w+6hihkOtA8Uod1M+Us0LJEs/5NhK8kjv0zovlEr5SQTK0ZyA+U/Lqx154lMB9EPcc2v
 EPPmmCw6pzQCryMLaXV+PZcVBLZRVaUksshDem/eAUAiQPymU4IaNZtRAE4yLMn1+DYy
 ch/pDi1OIxHAm5YD23h6Fr+U+b+Q0TjxHv1JE74xFQqKmekewgyMWidhX8Gu3TyOXtx9
 vkY/p1uX64FwJ7qF18YNWX8yD/S5GjbmcNfgEoqbp0UR3JWYZSxDj1oOdLyJKilSBTIF
 Zu3g==
X-Gm-Message-State: AOAM530CjTKXHIlaLe7+77j5N9GU1LMWULEf2pi/Fn9BzQ6iWxeHSuE5
 kEg3DjC6u1eDSsRR/zZDWZc=
X-Google-Smtp-Source: ABdhPJyZDBKQ4OQzF0mc4Wk18/tKlCNs8+o6xXWrLXPh5Q37+qDP/DytziVJC2XGB2sh8Dg7tIYCRA==
X-Received: by 2002:adf:c392:: with SMTP id p18mr15113318wrf.88.1602257142938; 
 Fri, 09 Oct 2020 08:25:42 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id e15sm12093834wro.13.2020.10.09.08.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 08:25:42 -0700 (PDT)
Subject: Re: [PATCH 18/63] mips: Rename TYPE_MIPS_BOSTON to TYPE_BOSTON
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-19-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f03cc567-ff86-ca8a-36c9-1ebe8978d008@amsat.org>
Date: Fri, 9 Oct 2020 17:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-19-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, berrange@redhat.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> This will make the type name constant consistent with the name of
> the type checking macro.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: qemu-devel@nongnu.org
> ---
>   hw/mips/boston.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

And queued to mips-next, thanks.

Phil.

