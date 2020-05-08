Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A68CC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214862173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcfKCcbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214862173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX8E0-0000np-6S
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jX8DQ-0000O6-Kp
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:59:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jX8DP-0002Pk-W6
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:59:20 -0400
Received: by mail-wr1-x441.google.com with SMTP id k1so3118659wrx.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y4hLlZCldwWpVfnCB3CzdKiUmoIsVvcaYIHI++Lv+ng=;
 b=tcfKCcbdcIJ8JYujXxxDUS0nzooo6PzyoQBKJwPPKIXAUkJWz+aZOSdI+pmyx4myE/
 jyidS7K5Zu0B11bo7Fn2Zx6WsRu6mH2XgMAYT50L9U04BqMO+uRdECJTYjnlN4CRsldl
 IhPq+hh1TUfNJ7DZ7Q22Q+850YtPCvbLhz9VW3PxsgimEmYnAAAW/EPwcLK5IA3qktjz
 PrXkquI1FFBAkq4KwFoTwF9JCb2RAGwXVrl5sKrH/Glfw5pI6Dv9gZ2mExHfN8Pw5twF
 XqfP73PM/DHWOgZE0PeFv/Wkh6ADyohdATxbqs2LVTCdpIGjTy2qfZLyXf6MhXtlqnDD
 1MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y4hLlZCldwWpVfnCB3CzdKiUmoIsVvcaYIHI++Lv+ng=;
 b=AzBRPYGDkBQIBlW2vPidvmNKA6I3gf9BwSyebg9oiotP9QXWSie9UBhyHPLnI4zsAI
 zVgFU1CfMuvh4B5DVkZou6uzecwt59jOAOV7PkYjevQYytxQJax8Br9oyU9oPwnBQyKP
 Sk3naVUX/0qCpDAlStTCo9rZCcv1XtXel1P/DvNyDMH4puOs4FLT+ksGTDLrOhVv7VIz
 aW2CSExItzkO3kICvaTJxlbMjP0tiBEhvC/FqY5nXtR5cSpGO8pqv26Qgv+1qdCKhDSR
 vdhePeqklh6ShhkUakVyBSUcNGYRqb7QQPPp9pQyvY4kbAenr33rlYIzbFacn7EPgxMh
 o4hw==
X-Gm-Message-State: AGi0Puaujsy3bw5hnghlJapFmIR59pyDl9C+px9OBYSXMj3mSn4hIWqF
 +W95CVWh/IAQlfvVafiSslw=
X-Google-Smtp-Source: APiQypLy/90WLliZxXuwKSgVUUgPqy2aX4xxFFy/o3dEzG87DpIKWbsdUmi7ZGHjkh4jvdzJC0IIlg==
X-Received: by 2002:adf:fa04:: with SMTP id m4mr4432689wrr.30.1588964358276;
 Fri, 08 May 2020 11:59:18 -0700 (PDT)
Received: from [192.168.1.37] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h16sm4852124wrw.36.2020.05.08.11.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 11:59:17 -0700 (PDT)
Subject: Re: [PATCH v4 01/19] tcg: Consolidate 3 bits into enum TCGTempKind
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200508182616.18318-1-richard.henderson@linaro.org>
 <20200508182616.18318-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8380dee6-091f-89a8-a390-292c42eead58@amsat.org>
Date: Fri, 8 May 2020 20:59:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200508182616.18318-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 8:25 PM, Richard Henderson wrote:
> The temp_fixed, temp_global, temp_local bits are all related.
> Combine them into a single enumeration.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  20 +++++---
>   tcg/optimize.c    |   8 +--
>   tcg/tcg.c         | 122 ++++++++++++++++++++++++++++------------------
>   3 files changed, 90 insertions(+), 60 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

