Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF4C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041DC20873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 11:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041DC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoRKW-0006sh-7o
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 07:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41093)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hoRKL-0006U4-Lv
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hoRKK-0000r7-OC
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:45:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hoRKK-0000oo-IN
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 07:45:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so23548662wmd.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 04:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jSIQ1t6pUoKe0wLYlN85oMJsWpQGfI0C6f44vHE/H2Y=;
 b=mMz+2ZBg1K+9xnDmvBr3cETUK6sXJV0hafJSGfX17IZPIdpRybBRH1ufWAoKdgkJb2
 zORAHJI+fpDl84/zaxcnLeXwol7s+OoIhMOoaFaek2IsBdV9020/0wDUkTKug0oKh7P7
 f/OwYXWQ3efzds7obY/IQauHmDpe5NbSY7AIxsKUmZ5Acj5zwBh0xJc/kOz1ttnXw6Wv
 aVUADsJXDp2819Lv15RlbDyq1SLM2lyJ1ljofO3vbtDeTeMIHa+mZQ7qXbIoieMDMlJY
 SpX4J3vHRdawDETihCoX48mqu1giGNPXHz6qlWY2eNZFPUdA4+Rx9xltYpCRDd9gDzWA
 MBGw==
X-Gm-Message-State: APjAAAWrMqxw5r/Klt5kAOtK127yuAk0JtoVbjJvFPTldzMTUjmJJmJO
 grNlMSa/cJVaj4OGfvc/ntMSlw==
X-Google-Smtp-Source: APXvYqwMRDIXznGrzat00PvxaJY3nFQp3NaFE0X3qVc8BhTZzF9pHiroOH+l/HBx276WFA21RmF7KA==
X-Received: by 2002:a1c:968c:: with SMTP id
 y134mr45271871wmd.122.1563536727295; 
 Fri, 19 Jul 2019 04:45:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8?
 ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 2sm37086038wrn.29.2019.07.19.04.45.26
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Jul 2019 04:45:26 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190719112315.14432-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1f5ee7a6-d78c-8d60-40ef-68032d7ef923@redhat.com>
Date: Fri, 19 Jul 2019 13:45:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719112315.14432-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.1] target/i386: Correct misplaced
 break statement in gen_shiftd_rm_T1()
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/07/19 13:23, Philippe Mathieu-Daudé wrote:
> Reported by GCC9 when building with CFLAG -Wimplicit-fallthrough=2:
> 
>     CC      target/i386/translate.o
>   target/i386/translate.c: In function ‘gen_shiftd_rm_T1’:
>   target/i386/translate.c:1785:12: error: this statement may fall through [-Werror=implicit-fallthrough=]
>    1785 |         if (is_right) {
>         |            ^
>   target/i386/translate.c:1810:5: note: here
>    1810 |     default:
>         |     ^~~~~~~
>   cc1: all warnings being treated as errors
> 
> Fixes: f437d0a3c24
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/i386/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 03150a86e2..4b2b5937ca 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -1805,8 +1805,8 @@ static void gen_shiftd_rm_T1(DisasContext *s, TCGMemOp ot, int op1,
>              tcg_gen_shri_i64(s->tmp0, s->tmp0, 32);
>              tcg_gen_shri_i64(s->T0, s->T0, 32);
>          }
> -        break;
>  #endif
> +        break;
>      default:
>          tcg_gen_subi_tl(s->tmp0, count, 1);
>          if (is_right) {
> 

I haven't looked closely at the code but I would guess that the
fallthrough is intended, because the default label has an "ot == MO_16"
condition.

It certainly needs more comments... :(

Paolo

