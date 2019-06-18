Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BADC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 19:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3C720B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 19:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uY+jTxaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3C720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdJz7-0003ty-Nf
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 15:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44054)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hdJxU-00033K-Ly
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 15:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hdJxT-0007AX-9E
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 15:39:56 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hdJxT-00079O-0T
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 15:39:55 -0400
Received: by mail-pf1-x441.google.com with SMTP id 19so8242164pfa.4
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QV5RvZyiPMAh4kaBTkd2mKCukNPLwZ89oJ3Xd+wb/XE=;
 b=uY+jTxajRP46wxazaKlOhNf5R31hoUT940uQqBAtHIqNDBbZ1xR5zrfrLseSj+KBzg
 bixYGh62WZ/JNkwzIXgO4LDmXNBPafao4o645bmVvFUVJWbFOkP/A5rqBrTE9Tu+cBgp
 LdzWeicd0ypBqfYa7J9qSKiOpErkOnYVbv0qrwY0C1sFGvPMAUWve4oN+5etuIGE/E2o
 RMKFJm0yIsdPA7rHY6rLktbUBvM929jk98CDrTwNwXpqaC5TtZDhm9FDZ9RjDcgc0vHU
 HLMRqPxqdNg3fbAASyCowedIP1LZxtCrZsHLP7Peo8OxkhioE/PTxpTkfr5R44nOy/gN
 CkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QV5RvZyiPMAh4kaBTkd2mKCukNPLwZ89oJ3Xd+wb/XE=;
 b=nQuTwOnLCPiv+TdeCq+ojECEn4dvn++YV8WLov7e0MUXZ6aKiETsT+Odi+k3qhS3pc
 REQnm4ucLZNcmqszVou6XNXBibTEBMhpbFgQ15J+C0+y9ZEK8HgAS+WfnVRcNyEYfpN6
 BNZTyqal4ASOYHNts8ahghN5V4kXvMysY4Z4eyukEym0mo252bz94t/kuNlPD5kzlxai
 4SWzz1Wh7aWuzvCXQssCg+xvkyhMYU90dpkqSL/66WESxZV6czu15Et1tzkA6GfTKVxc
 qR+ZOYC0J0PQQskUUxu5hFpk+sH321iw+NSywKaEpXc1DRKrMydEFEkTVSD1iojwL/5P
 6N2Q==
X-Gm-Message-State: APjAAAXGY0ulh80i/iM/t2CNV337X24KAz+e2r5GHoKTQMD2/jH6r3fi
 BECyocRQUE6N8EyxTRqbp4ipsA==
X-Google-Smtp-Source: APXvYqwCvYpRGoySifbuval28W+/8rsx2MuFe6/+BE2Dea6F8tH8GRwjGy0OW3FO+sKMX1wfjZyiaA==
X-Received: by 2002:a17:90a:7f02:: with SMTP id
 k2mr6942466pjl.78.1560886793562; 
 Tue, 18 Jun 2019 12:39:53 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id w4sm16141539pfw.97.2019.06.18.12.39.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 12:39:52 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
References: <20190526075056.33865-1-lucienmp_antispam@yahoo.com>
 <ab1edfe7-8498-eee6-096c-d66d6122d133@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1c3d400a-7ea2-2bdd-8301-8f6c85075b24@linaro.org>
Date: Tue, 18 Jun 2019 12:39:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ab1edfe7-8498-eee6-096c-d66d6122d133@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] Regression for m68k causing Single-Step
 via GDB/RSP to not single step
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Emilio G . Cota" <cota@braap.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/19 11:44 AM, Laurent Vivier wrote:
> Le 26/05/2019 à 09:50, Lucien Murray-Pitts a écrit :
>> A regression that was introduced, with the refactor to TranslatorOps,
>> drops two lines that update the PC when single-stepping is being performed.
>> ( short commit 11ab74b )
>>
>> This patch resolves that issue.
> 
> Fixes: 11ab74b01e0a ("target/m68k: Convert to TranslatorOps")
> 
>> Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
>> ---
>>  target/m68k/translate.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>> index f0534a4ba0..2922ea79c3 100644
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -6130,6 +6130,8 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>>          return;
>>      }
>>      if (dc->base.singlestep_enabled) {
>> +        update_cc_op(dc);
>> +        tcg_gen_movi_i32(QREG_PC, dc->pc);
>>          gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
>>          return;
>>      }
>>
> 
> I've tested this fix single-stepping on a kernel, these two lines are 
> not enough to fix the problem. In fact four lines have been dropped and 
> we must re-add them all:
> 
> iff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index d0f6d1f5cc..6c78001501 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -6200,6 +6200,10 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>          return;
>      }
>      if (dc->base.singlestep_enabled) {
> +        if (dc->base.is_jmp != DISAS_JUMP) {
> +            update_cc_op(dc);
> +            tcg_gen_movi_i32(QREG_PC, dc->pc);
> +        }
>          gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
>          return;
>      }

Even this isn't quite right, according to the comments in the switch that
follows.  I think it'd be best written like so.


r~


diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 2ae537461f..b61c7ea0f1 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6124,27 +6124,34 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase,
CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);

-    if (dc->base.is_jmp == DISAS_NORETURN) {
-        return;
-    }
-    if (dc->base.singlestep_enabled) {
-        gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
-        return;
-    }
-
     switch (dc->base.is_jmp) {
+    case DISAS_NORETURN:
+        break;
     case DISAS_TOO_MANY:
         update_cc_op(dc);
-        gen_jmp_tb(dc, 0, dc->pc);
+        if (dc->base.singlestep_enabled) {
+            tcg_gen_movi_i32(QREG_PC, dc->pc);
+            gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
+        } else {
+            gen_jmp_tb(dc, 0, dc->pc);
+        }
         break;
     case DISAS_JUMP:
         /* We updated CC_OP and PC in gen_jmp/gen_jmp_im.  */
-        tcg_gen_lookup_and_goto_ptr();
+        if (dc->base.singlestep_enabled) {
+            gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
+        } else {
+            tcg_gen_lookup_and_goto_ptr();
+        }
         break;
     case DISAS_EXIT:
         /* We updated CC_OP and PC in gen_exit_tb, but also modified
            other state that may require returning to the main loop.  */
-        tcg_gen_exit_tb(NULL, 0);
+        if (dc->base.singlestep_enabled) {
+            gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
+        } else {
+            tcg_gen_exit_tb(NULL, 0);
+        }
         break;
     default:
         g_assert_not_reached();

