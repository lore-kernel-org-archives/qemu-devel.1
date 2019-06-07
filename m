Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E590C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4855320B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 14:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4855320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZFYb-0004EG-7n
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 10:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZFVK-0002JY-Cc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZFVI-0002my-9r
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:06:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZFVG-0002DP-8Z
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:05:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so2063689wml.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 07:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=twOSqC6YADnSvFE0Z+yFp2sokT6QtyDbM+rnLE2QUpI=;
 b=dVbYvyDcHv9Zbc+3ir8kVYT2sALJ9Bq38or5MyUsJINXQTwKrnkJ/dkezzXgMK1Is/
 fxk5/DYDEbcSFhqNbUgAXV7nQHSq2MMvLdI2hp5Mr0mEk3WB/r4hSnCoBXiz3BnX/TZP
 Hv2z5JRLhrBaZnVGg8O5Rp+1RkyltvWrVzUopOdDw680lHPN1WhEqQZX0JdS3X1iMfaP
 swmCB/xpR+hvCqe+SoQdy4/VTJZGSrQ12uvYLmi2ZMweBuFocmOz9L16E0iG0ENgLWX/
 mxWvrhJWz0jLkTI5ztzTYSQ4LB6HiiX/d2rC6+HW8dZBbFULripGM32Hr7M4egD3qbja
 UOUQ==
X-Gm-Message-State: APjAAAUtxDB1E113cpL0y3nEcoeqoajLkMtHO3AG8YQZS2hwFAQkFJZY
 I6jrZPzJGeHQgY5oyohe5Z27wA==
X-Google-Smtp-Source: APXvYqwqMWx19FsVYWUT6oE+S+BW5nSjPU8L27wuFtUyOe44anQGVuZtHEckBHLk3a9d8M0igSta8A==
X-Received: by 2002:a1c:4184:: with SMTP id o126mr3860317wma.68.1559916337719; 
 Fri, 07 Jun 2019 07:05:37 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id j132sm3679324wmj.21.2019.06.07.07.05.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 07:05:37 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-15-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3eb4a6aa-6e87-3c27-5b6b-16356c4471f9@redhat.com>
Date: Fri, 7 Jun 2019 16:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607091116.49044-15-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v17 14/24] tests: Add rx to
 machine-none-test.c
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 11:11 AM, Yoshinori Sato wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Fixes check-qtest-rx: tests/machine-none-test.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Again:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  tests/machine-none-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 4c6d470798..80df277357 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -56,6 +56,7 @@ static struct arch2cpu cpus_map[] = {
>      { "hppa", "hppa" },
>      { "riscv64", "rv64gcsu-v1.10.0" },
>      { "riscv32", "rv32gcsu-v1.9.1" },
> +    { "rx", "rx62n" },
>  };
>  
>  static const char *get_cpu_model_by_arch(const char *arch)
> 

