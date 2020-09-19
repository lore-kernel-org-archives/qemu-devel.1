Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514B4C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 10:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE9D20888
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 10:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7Q+DqKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE9D20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJaOo-0001Zx-RL
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 06:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJaOE-000142-Am; Sat, 19 Sep 2020 06:46:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJaOC-0003vc-Hi; Sat, 19 Sep 2020 06:46:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id t10so8027386wrv.1;
 Sat, 19 Sep 2020 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+atIDDG1io4VXvDSH1rnmJsXFlg1IvhbkCCWv/A459w=;
 b=L7Q+DqKblfyvJGPuDKDgeDAQxuKwIzyrLNmbPY3odJ+aRcV/n0cH9CdkoVkQX0OVYH
 Oqju+Gxv5aFJZCFAA6orJ5y7VZ3Aq4zm+2dxDIxKLwPv1mq8nM449R9b0Ra227Gh1SxG
 m5l/nztx0h/ra2WLHG51egnaMs16KMVlDDGrIAa/54Af0Fe4SsU+g7umwW5XSOEelZTE
 Nma2Ev6i/U5YM9wLiXnvxrI863vNleUN22cD1t2D+Dud13Qyz94/IgxDu/UFAH3fdjuH
 2C6wLiBL+229pEmoBxMMrz1kiVSr+LANGIH5lGQzumJMysOT059X5ewUbBW4LK0U7bk/
 2R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+atIDDG1io4VXvDSH1rnmJsXFlg1IvhbkCCWv/A459w=;
 b=hcyljdiMJdH+Ls2+fXJ0DvP/zMi7+v1Y00HQJiq3XssLWcbk4FVaYFxhZRMWaFY/oz
 5IC+LeJj0nF2kn09Awnt622MaUY+6IgR99t5HIfeiAG4dvwtRZ+b6xnUlY4Q+pKu/jMB
 hBO5I6NVMnwKv/hcDwBqT63CXD4M+R3fGamyuZUhgWMvQUX0THX/PHUefSTV5tkobOIo
 11JOKQQivZwJUaGDLZaf+89j0WuOW/nHCMMllrXSXMe6am44mgMQ6Kos4IQ5+bvXaO2U
 Lkr9X5HFbr4dKFwABPWYB0RD3FkN5rNaTl4no4dUlw6FMo1oiIYYgHS1IVYTweym5zk2
 YHeg==
X-Gm-Message-State: AOAM533XZWdHXFoUARILVWTkiBgI8/sCvlL9cHC4KNnhqKJ5a25llAkR
 e7EwOfM8uzLiDXKxQrcgUXE=
X-Google-Smtp-Source: ABdhPJwIUEubnUgQ5iYtNG90PMXX/5wvkEgNsbdyUFQLIvnxwAF+jv0PzFGMossto8pfjvWLxvVj9w==
X-Received: by 2002:a5d:4450:: with SMTP id x16mr40742441wrr.28.1600512401766; 
 Sat, 19 Sep 2020 03:46:41 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l16sm11448798wrb.70.2020.09.19.03.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 03:46:40 -0700 (PDT)
Subject: Re: [PATCH] Add *.pyc back to the .gitignore file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200919101859.28739-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b9aa78cc-4919-6ed7-37ea-868f2b0e1c72@amsat.org>
Date: Sat, 19 Sep 2020 12:46:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200919101859.28739-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-1.869,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/20 12:18 PM, Thomas Huth wrote:
> Python still dumps its bytecode into the source directory, so
> we should continue to ignore the *.pyc files.
> 
> Fixes: 0e72b7df4d ("Simplify the .gitignore file")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 5515f595e6..b32bca1315 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,5 +1,6 @@
>  /GNUmakefile
>  /build/
> +*.pyc
>  .sdk
>  .stgit-*
>  .git-submodule-status
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


