Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4222DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD7020738
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtArooMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD7020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k090i-000164-Cg
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0908-0000fc-Mt
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:41:32 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k0907-0003TS-0I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:41:32 -0400
Received: by mail-pf1-x443.google.com with SMTP id m8so2796728pfh.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4pqMNomJh7WNN6/o8pTGK9xDfjiIbi9zXVSzl6e9LRY=;
 b=dtArooMoyDp1hpwFC8VPZNUgugGkeh/ycit9TQXYn9hPszEYc9OHCjX9a4t1vNw0RC
 +XRtrE27Yy/Pzd/p6/QrfKkYMsDE0n/Q01g44pNsv8XQiFt7uncgG20Guo7NSnmrXMGn
 JpSNV2VQfIHUd6xq4Slj9BWJl45/Se6wDm1rVZomh0P/I7cw1y6MvP3JbPB3tLDZCGpr
 0JJiMzKeYb3MyOhhxU2kYHTZhy6jZJcKOGhDnfi2QI8bUPmIFOJ9xMyPofacsoIpJgGp
 Ym/GWBkjSNIK1ywuVEycW3XxQbkIaY7l44DUt8KstSIfbLMnyLV3Qd/GZf4O/RGkptGM
 6bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4pqMNomJh7WNN6/o8pTGK9xDfjiIbi9zXVSzl6e9LRY=;
 b=tIMk4LP6oRwcTdX1iaXpiTkTolklQDXlFZI6UFRs7ELHqZk7HH7UmJSwNAH04L9ii3
 t7vX2P3qsorirHRS56BaPpS4QmmyfQKpOKja54MCHiPl5BZHB1XGzY0yJRluD0oh5HcV
 0tAb4pU+6hHxoimXkPGRli3ovFigXuFiU9x1eaYmfpypwTunzgdh1z3KZVifwQLhg78O
 rHG2Gx1J9gxdtv++kD+DHMATAQt6XIDSdOI+e+F1TAmC35D/QlH9d7xmfL7MQU1GTo7D
 V8fbGn+5A/RVagoKEM4nV2B2WpC7qT1rvlUoH3JblDmty++csFz9g2zjl6vzahvGPvm+
 Vt+g==
X-Gm-Message-State: AOAM533JNZYdGLlil447fHZRW5JkwO34fLDwpk90r6l7wG8ziyMLwmtI
 1Khb5YAwAaUOdZ033dqPzIZxPA==
X-Google-Smtp-Source: ABdhPJzTcemAbgriuv1R8r69Tet7nh1BJv1jOFULFgjpONr1J6a9UpKoN6h7JI18N2tn1uMVfnHrsQ==
X-Received: by 2002:a63:5a60:: with SMTP id k32mr20856559pgm.73.1595878889267; 
 Mon, 27 Jul 2020 12:41:29 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 s67sm6024906pfs.117.2020.07.27.12.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 12:41:28 -0700 (PDT)
Subject: Re: [PATCH] linux-user: Ensure mmap_min_addr is non-zero
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200724212314.545877-1-richard.henderson@linaro.org>
 <ed16b937-9f82-8221-0764-77e7fddbed96@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74132eed-5c06-ac28-9482-fe6ebb28b777@linaro.org>
Date: Mon, 27 Jul 2020 12:41:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ed16b937-9f82-8221-0764-77e7fddbed96@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: alex.bennee@linaro.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 4:19 AM, Laurent Vivier wrote:
> Le 24/07/2020 à 23:23, Richard Henderson a écrit :
>> When the chroot does not have /proc mounted, we can read neither
>> /proc/sys/vm/mmap_min_addr nor /proc/sys/maps.
>>
>> The enforcement of mmap_min_addr in the host kernel is done by
>> the security module, and so does not apply to processes owned
>> by root.  Which leads pgd_find_hole_fallback to succeed in probing
>> a reservation at address 0.  Which confuses pgb_reserved_va to
>> believe that guest_base has not actually been initialized.
>>
>> We don't actually want NULL addresses to become accessible, so
>> make sure that mmap_min_addr is initialized with a non-zero value.
>>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1888728
>> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  linux-user/main.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
> 
> Richard, do you want to add this fix in one of your branches PR?

I don't have anything queued at the moment.  I thought I would be able to
convince Alex to add it to his misc queue, but he sent that this morning.

> In this case:
> Acked-by: Laurent Vivier <laurent@vivier.eu>
> 
> Otherwise I can prepare a small one for linux-user, adding one or two
> fixes...

Please go ahead.


r~

