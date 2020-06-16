Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648A8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7CD206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiQ21EUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7CD206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDJf-0000Cc-Ed
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlCtu-0001MK-S2; Tue, 16 Jun 2020 10:49:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlCtt-0003rm-8M; Tue, 16 Jun 2020 10:49:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id f185so3381714wmf.3;
 Tue, 16 Jun 2020 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ES/i38+YHXtP1atxfpL2aGzxN/VNJHWmwNkcGFRb7Ks=;
 b=BiQ21EUr5a7kltMJICQKVyqX6c7fcICYWhW8oNjKQrIZNhpmt6ZV7bd/agkhZ8F7Hf
 tkBdOZNmisTYmfSGBfnYhGkak/VjFCZ20w9znBip6Q1XDMJk+OkLdRpX3tEhZrcfcDWZ
 axDRVxDiKtidrj9o3hFzuPl76caz+3sf/HmfR9271rML5TpEgTnEm1r8dGhx1qR21M5s
 dWDmg9R44+OSZNeYM174AbFSg42rHzR6Ah985+lU/p2BXpwZQyZ4lEAK5h6siSd8P6Md
 AxGCaA9tua7FH7SZ2kCV7ceRFFS9dbd/egqLwlv7Ih1lATwinjlVqj1q0n7sL1vm3IpB
 M72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ES/i38+YHXtP1atxfpL2aGzxN/VNJHWmwNkcGFRb7Ks=;
 b=ZkUae9jcc6ZRsoUg8dPqkuoosIyfCm7MHOJglk1PVy1b5dSVasAampVN6RCCQ0oVuL
 Zypas1qpwewxlRtg9Egw+bHnsCoIhyoQcbWW0GpXd42w6ArODCykI/FjVBLv0Ihu6t/q
 5eqHQLDe4fPP5TKOzG9aUPTGfpOxD76jDuwdw1Y9rhUyD7bbbdFoJie9oenriZypJPuy
 OsOyN3NxKEb0rLNS9B9HG4ACClk75pOTpVlrnIVtqZFJNEUag2/AXv7i1EJeuYo0ctVm
 uZgXa8dYC8LDrHcKsR1OEmoWcCRGdzkYdRBC45iWHoPZ2oR8dNT3MwNY6rXZz5dKVge0
 3D0A==
X-Gm-Message-State: AOAM530E2T7Q2AyKGen45IxuZyzu/Ojw425Q9sDHqFfUp4EISmU5PSxQ
 KwbPOtQ8t66674glzY4wIgE=
X-Google-Smtp-Source: ABdhPJx42dONDaKE3yQCxWxVtZZtbg8XmVzhfqeLcV7LOsid/mBzjlaJ5jqMSSK4jvj+79nZeSqaFw==
X-Received: by 2002:a1c:bd84:: with SMTP id n126mr3401938wmf.149.1592318959406; 
 Tue, 16 Jun 2020 07:49:19 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id o15sm4295294wmm.31.2020.06.16.07.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 07:49:18 -0700 (PDT)
Subject: Re: [PATCH v4 1/7] MAINTAINERS: Cover 'hw/sh4/sh_intc.h' with the R2D
 machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200611114317.13044-1-f4bug@amsat.org>
 <20200611114317.13044-2-f4bug@amsat.org>
 <bb388c24-092c-28f5-2a78-daee14ed5731@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <94575412-81ae-25e1-b9ad-b12317da815b@amsat.org>
Date: Tue, 16 Jun 2020 16:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bb388c24-092c-28f5-2a78-daee14ed5731@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 3:34 PM, Thomas Huth wrote:
> On 11/06/2020 13.43, Philippe Mathieu-Daudé wrote:
>> Commit 81527b94ad added hw/intc/sh_intc.c, complete by
>> adding its corresponding header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 13711aafe8..87ceca7ff1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1257,6 +1257,7 @@ S: Maintained
>>  F: hw/sh4/r2d.c
>>  F: hw/intc/sh_intc.c
>>  F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/sh_intc.h
>>  
>>  Shix
>>  M: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> Hmm, sh_intc.h is used by sh7750_init() in sh7750.c ... and that
> function is used by both, r2d and shix machines ... so should that maybe
> rather be part of both machines or a generic entry?

I'll add it to both machines. The maintainers can reorder
the sections later.

Thanks for the review!

> 
>  Thomas
> 
> 

