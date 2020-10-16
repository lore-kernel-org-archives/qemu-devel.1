Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5687C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6ECC20878
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZtTj4ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6ECC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTWH4-0001Ou-3I
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 16:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTWAf-0005yC-LS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 16:17:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTWAd-0006k1-1e
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 16:17:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id g12so4373742wrp.10
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KGvEfGQuMK1ksJymoTilEXY014MQ5O94CjwvhK1oc9U=;
 b=SZtTj4ijACghjeX0l/nJjIJucbmsy0o5nNUTUj4peXE09NdTms1Q9/Z0rap4bTSGiN
 zC2Gk+D3PbyF+ymvnYcU5WaWbZYrVAtfW7cx+wie7iylxdIf7VJjYCTT6Dgddh7P+Pme
 Mh2Vd399g+U1Pf2HtexUhez0zWb0zoPTwX4SETDa1Kw0v53KTT0jOWrpjwKSlrOL8tF5
 icbnEnnHQm6dRE4fBimhMLwBh1pcJugRB6PKKFMWmGczNGA+HPU73vwm7jKLha2yWV8n
 wKpeSF50GsML0wdzN9qNVnHqUj1vdYNuonfLte4sEkdAV8DbAesASpbt7Ugt8hgOKo16
 Cr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KGvEfGQuMK1ksJymoTilEXY014MQ5O94CjwvhK1oc9U=;
 b=lqL8YEnGJJ5wN5P48Dj6t/zsIgiN4oG+RtS6Wnfw27+RMSiZMZEmKFBl8tN2LyzV7P
 J+YAJ5NRBPc250Ewygr/mMdHdAKlt8txJWahnu8Lus58gP28HhS77PrPiXi2OAnFzINd
 ZbMQM3GaYNrhsb83v3aj4gzQagdXRgbwyxGKxtgeXesKVBC09s/EDGakgFhdE6iz7emD
 Autt+MX4AdN0zc9vjc0VR9lyxRQPc1IidwixzN5G5rXML2M4762sLHdKIdAm1YlSnv/5
 hEnuD8hKSqIq8Ip+80VlBucCzAT2vwxaFANpOU6QMJNx0uWKUZgcperRGiY8MHb/K39q
 RW4g==
X-Gm-Message-State: AOAM5324e5ENavxnRXpWk9EdAcyaE3TZwfSpbuJ/3rwNnM5jMytFyMaL
 MkqS3j8gprhLRQWn5L5Q5gs=
X-Google-Smtp-Source: ABdhPJyK5glJ7CLUWLvVrGgpQeYfSLdWQ+0QlK8MEdnWMOjY6UwxH5OoBhQvgUNVm75BWNdGAGgl5A==
X-Received: by 2002:a05:6000:10c6:: with SMTP id
 b6mr6135674wrx.10.1602879464498; 
 Fri, 16 Oct 2020 13:17:44 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id p13sm4299908wmb.5.2020.10.16.13.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 13:17:43 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] target/mips: Refactor helpers for fp comparison
 instructions
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1602103041-32017-5-git-send-email-aleksandar.qemu.devel@gmail.com>
 <7da26134-7e26-457a-c48e-877e66309793@amsat.org>
Message-ID: <2b5ed8be-9c2a-9d4d-cd77-612073f1d794@amsat.org>
Date: Fri, 16 Oct 2020 22:17:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <7da26134-7e26-457a-c48e-877e66309793@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hpoussin@reactos.org, aurelien@aurel32.net, chenhc@lemote.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/20 4:47 PM, Philippe Mathieu-Daudé wrote:
> Hi Aleksandar,
> 
> On 10/7/20 10:37 PM, Aleksandar Markovic wrote:
>> This change causes slighlty better performance of emulation of fp
>> comparison instructions via better compiler optimization of refactored
>> code. The functionality is otherwise unchanged.
>>
>> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> ---
>>   target/mips/fpu_helper.c | 56 
>> +++++++++++++++++++++++++++---------------------
>>   1 file changed, 32 insertions(+), 24 deletions(-)
>>
> [...]
> 
>>   /*
>> @@ -2080,12 +2088,12 @@ uint64_t helper_r6_cmp_d_ ## op(CPUMIPSState 
>> *env, uint64_t fdt0,   \
>>   {                                                                   \
>>       uint64_t c;                                                     \
>>       c = cond;                                                       \
>> -    update_fcr31(env, GETPC());                                     \
>>       if (c) {                                                        \
>>           return -1;                                                  \
>>       } else {                                                        \
>>           return 0;                                                   \
>>       }                                                               \
>> +    update_fcr31(env, GETPC());                                     \
> 
> Isn't it now never called (dead code)?

Confirmed:

target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_af’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2103:1: note: in expansion of macro ‘FOP_CONDN_D’
  2103 | FOP_CONDN_D(af,  (float64_unordered_quiet(fdt1, fdt0,
       | ^~~~~~~~~~~
Compiling C object libqemu-mips-softmmu.fa.p/target_mips_dsp_helper.c.o
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_un’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2105:1: note: in expansion of macro ‘FOP_CONDN_D’
  2105 | FOP_CONDN_D(un,  (float64_unordered_quiet(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_eq’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2107:1: note: in expansion of macro ‘FOP_CONDN_D’
  2107 | FOP_CONDN_D(eq,  (float64_eq_quiet(fdt0, fdt1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_ueq’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2109:1: note: in expansion of macro ‘FOP_CONDN_D’
  2109 | FOP_CONDN_D(ueq, (float64_unordered_quiet(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_lt’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2113:1: note: in expansion of macro ‘FOP_CONDN_D’
  2113 | FOP_CONDN_D(lt,  (float64_lt_quiet(fdt0, fdt1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_ult’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2115:1: note: in expansion of macro ‘FOP_CONDN_D’
  2115 | FOP_CONDN_D(ult, (float64_unordered_quiet(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_le’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2119:1: note: in expansion of macro ‘FOP_CONDN_D’
  2119 | FOP_CONDN_D(le,  (float64_le_quiet(fdt0, fdt1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_ule’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2121:1: note: in expansion of macro ‘FOP_CONDN_D’
  2121 | FOP_CONDN_D(ule, (float64_unordered_quiet(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_saf’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2129:1: note: in expansion of macro ‘FOP_CONDN_D’
  2129 | FOP_CONDN_D(saf,  (float64_unordered(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_sun’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2131:1: note: in expansion of macro ‘FOP_CONDN_D’
  2131 | FOP_CONDN_D(sun,  (float64_unordered(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_seq’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2133:1: note: in expansion of macro ‘FOP_CONDN_D’
  2133 | FOP_CONDN_D(seq,  (float64_eq(fdt0, fdt1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_sueq’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2135:1: note: in expansion of macro ‘FOP_CONDN_D’
  2135 | FOP_CONDN_D(sueq, (float64_unordered(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_slt’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2139:1: note: in expansion of macro ‘FOP_CONDN_D’
  2139 | FOP_CONDN_D(slt,  (float64_lt(fdt0, fdt1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_sult’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2141:1: note: in expansion of macro ‘FOP_CONDN_D’
  2141 | FOP_CONDN_D(sult, (float64_unordered(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_sle’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2145:1: note: in expansion of macro ‘FOP_CONDN_D’
  2145 | FOP_CONDN_D(sle,  (float64_le(fdt0, fdt1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_sule’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2147:1: note: in expansion of macro ‘FOP_CONDN_D’
  2147 | FOP_CONDN_D(sule, (float64_unordered(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_or’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2151:1: note: in expansion of macro ‘FOP_CONDN_D’
  2151 | FOP_CONDN_D(or,   (float64_le_quiet(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_une’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2155:1: note: in expansion of macro ‘FOP_CONDN_D’
  2155 | FOP_CONDN_D(une,  (float64_unordered_quiet(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_ne’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2161:1: note: in expansion of macro ‘FOP_CONDN_D’
  2161 | FOP_CONDN_D(ne,   (float64_lt_quiet(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_sor’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2165:1: note: in expansion of macro ‘FOP_CONDN_D’
  2165 | FOP_CONDN_D(sor,  (float64_le(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_sune’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2169:1: note: in expansion of macro ‘FOP_CONDN_D’
  2169 | FOP_CONDN_D(sune, (float64_unordered(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_d_sne’:
target/mips/fpu_helper.c:2097:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2097 | }
       | ^
target/mips/fpu_helper.c:2175:1: note: in expansion of macro ‘FOP_CONDN_D’
  2175 | FOP_CONDN_D(sne,  (float64_lt(fdt1, fdt0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_af’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2198:1: note: in expansion of macro ‘FOP_CONDN_S’
  2198 | FOP_CONDN_S(af,   (float32_unordered_quiet(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_un’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2200:1: note: in expansion of macro ‘FOP_CONDN_S’
  2200 | FOP_CONDN_S(un,   (float32_unordered_quiet(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_eq’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2202:1: note: in expansion of macro ‘FOP_CONDN_S’
  2202 | FOP_CONDN_S(eq,   (float32_eq_quiet(fst0, fst1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_ueq’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2204:1: note: in expansion of macro ‘FOP_CONDN_S’
  2204 | FOP_CONDN_S(ueq,  (float32_unordered_quiet(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_lt’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2208:1: note: in expansion of macro ‘FOP_CONDN_S’
  2208 | FOP_CONDN_S(lt,   (float32_lt_quiet(fst0, fst1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_ult’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2210:1: note: in expansion of macro ‘FOP_CONDN_S’
  2210 | FOP_CONDN_S(ult,  (float32_unordered_quiet(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_le’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2214:1: note: in expansion of macro ‘FOP_CONDN_S’
  2214 | FOP_CONDN_S(le,   (float32_le_quiet(fst0, fst1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_ule’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2216:1: note: in expansion of macro ‘FOP_CONDN_S’
  2216 | FOP_CONDN_S(ule,  (float32_unordered_quiet(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_saf’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2224:1: note: in expansion of macro ‘FOP_CONDN_S’
  2224 | FOP_CONDN_S(saf,  (float32_unordered(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_sun’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2226:1: note: in expansion of macro ‘FOP_CONDN_S’
  2226 | FOP_CONDN_S(sun,  (float32_unordered(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_seq’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2228:1: note: in expansion of macro ‘FOP_CONDN_S’
  2228 | FOP_CONDN_S(seq,  (float32_eq(fst0, fst1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_sueq’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2230:1: note: in expansion of macro ‘FOP_CONDN_S’
  2230 | FOP_CONDN_S(sueq, (float32_unordered(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_slt’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2234:1: note: in expansion of macro ‘FOP_CONDN_S’
  2234 | FOP_CONDN_S(slt,  (float32_lt(fst0, fst1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_sult’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2236:1: note: in expansion of macro ‘FOP_CONDN_S’
  2236 | FOP_CONDN_S(sult, (float32_unordered(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_sle’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2240:1: note: in expansion of macro ‘FOP_CONDN_S’
  2240 | FOP_CONDN_S(sle,  (float32_le(fst0, fst1,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_sule’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2242:1: note: in expansion of macro ‘FOP_CONDN_S’
  2242 | FOP_CONDN_S(sule, (float32_unordered(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_or’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2246:1: note: in expansion of macro ‘FOP_CONDN_S’
  2246 | FOP_CONDN_S(or,   (float32_le_quiet(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_une’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2250:1: note: in expansion of macro ‘FOP_CONDN_S’
  2250 | FOP_CONDN_S(une,  (float32_unordered_quiet(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_ne’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2256:1: note: in expansion of macro ‘FOP_CONDN_S’
  2256 | FOP_CONDN_S(ne,   (float32_lt_quiet(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_sor’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2260:1: note: in expansion of macro ‘FOP_CONDN_S’
  2260 | FOP_CONDN_S(sor,  (float32_le(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_sune’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2264:1: note: in expansion of macro ‘FOP_CONDN_S’
  2264 | FOP_CONDN_S(sune, (float32_unordered(fst1, fst0,
       | ^~~~~~~~~~~
target/mips/fpu_helper.c: In function ‘helper_r6_cmp_s_sne’:
target/mips/fpu_helper.c:2192:1: error: control reaches end of non-void 
function [-Werror=return-type]
  2192 | }
       | ^
target/mips/fpu_helper.c:2270:1: note: in expansion of macro ‘FOP_CONDN_S’
  2270 | FOP_CONDN_S(sne,  (float32_lt(fst1, fst0,
       | ^~~~~~~~~~~
Compiling C object libqemu-mips-softmmu.fa.p/target_mips_cpu.c.o
cc1: all warnings being treated as errors
Makefile.ninja:3848: recipe for target 
'libqemu-mips-softmmu.fa.p/target_mips_fpu_helper.c.o' failed
make: *** [libqemu-mips-softmmu.fa.p/target_mips_fpu_helper.c.o] Error 1


