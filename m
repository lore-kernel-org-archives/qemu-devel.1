Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B6CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9D922276
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1eLHX3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9D922276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQteg-0006yR-9S
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtdN-0006Mc-8d
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:44:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtdL-0008Vd-N0
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:44:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id q5so10099639wmq.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZcBpxENNZBm9Pdrtjd9+gi5JOHDQHFEdTR++4eW7GG8=;
 b=F1eLHX3vCVfIlrGoVyo5tDufoT4spKz+5SmwP790yi2EDVrFFXy2/x0+snQ+EL7VUg
 4UzPp50Fcku6WIx9SV+nDQ+QfWo394Ht7qJEKDGaMgJv6wt5tUk3v8RQwJMsKK0afPFA
 PFklZdrvz/hxO94/iw/02IstM6H53qYGbCSxAydCZtTBOBHXDRH5fq/x6CUuixdCyiov
 AAK9mRP7TRtt7MoBBkkeB2t49pNsGF3/Le8JqBt9A9D616Y3cFLXptV+RW+YmQriazWt
 41R7pF55r5p+VQXOHCQM7K/nJ7hh673suOj72ISuvXzNXZL8qGview5pduFs9EDwYOXL
 FF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZcBpxENNZBm9Pdrtjd9+gi5JOHDQHFEdTR++4eW7GG8=;
 b=kvzfYmw7D/VlcUfWHCJl+kvkTpMQmXTKIDbLqhLslTR4z/OE9Q1NIaavNpbcK/cgbC
 alZO6eMwbpr++j4bV/XSn3qPLv9mfF8iaSH94weH+ilpxzpm7L7tDtvaUVGJ2uWUFRJR
 V1TqqOii2Dwd40puA7srB6PDF0zn44J4h1fctD7ikKHyO3sDw0JgTfB5KFI9lrJGMqjG
 8fbV49sNzZOuuQf0UGKVvyE6ZzGcoJG1d5ztUfpB+JKb0Z6rxieh/fdQtz7jvzRPWgnN
 SFp9wRO4Wvef5hwtM9U8CRBwwfr24wAyKufWLWrBHmT4tn9Rf1TnvZdoCNkfFutGrApH
 9n+A==
X-Gm-Message-State: AOAM530vq1V3fRE8DpI37GxKm5MKUVZWSzB4XLqU0992w6ufRzGnY50v
 m6+ff2a6lWoCALjq8K2Mdyw=
X-Google-Smtp-Source: ABdhPJxYxBE67xZbyl9O5vyhdeeejYtsFCqh2VTRoo2sunK5/cErduQB0cAuB8Nd6WgSePhiy7Az4g==
X-Received: by 2002:a7b:c843:: with SMTP id c3mr14917573wml.67.1602254673776; 
 Fri, 09 Oct 2020 07:44:33 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o194sm11608873wme.24.2020.10.09.07.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 07:44:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] target/mips: Demacro helpers for
 <MAX|MAXA|MIN|MINA>.<D|S>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1602103041-32017-4-git-send-email-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a6d61f6a-7bb2-7ce3-25a7-cc8e62676487@amsat.org>
Date: Fri, 9 Oct 2020 16:44:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602103041-32017-4-git-send-email-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@syrmia.com,
 hpoussin@reactos.org, chenhc@lemote.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 10:37 PM, Aleksandar Markovic wrote:
> Remove function definitions via macros to achieve better code clarity.
> 
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>   target/mips/fpu_helper.c | 104 ++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 81 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

