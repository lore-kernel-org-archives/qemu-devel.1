Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDF1C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7A52074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7A52074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEED9-00009M-OZ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEE9p-0003tL-B8
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:01:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEE9m-00024L-Qk
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:01:44 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-n0P_qf0eMieUIt7YnMR_GA-1; Fri, 04 Sep 2020 12:01:37 -0400
X-MC-Unique: n0P_qf0eMieUIt7YnMR_GA-1
Received: by mail-wr1-f70.google.com with SMTP id v5so2440277wrs.17
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zo7IzfvzyB3E05Wp35PQK3UTkZUYbuig2D3JBn7up5s=;
 b=fa2ggQolXbfydJZqP8Gn7KxgxaFPeuIeVL+lzvy8P3+Ne0TODuTD6VCJZ/gSBzN+9A
 A3cPYS2SBTvIbpQC5c9T+Pe+ch2bnGBLcF0GqFtK7F09uPLm0Xliy/eRfD5hy9WYynKK
 5890Vde6ha0c5fA5OBy/qBq25y7vFX5a/8hv/XkqOn5Ytm5xAoaeJztKHqDMhAPXcCCt
 AoHz+oI7/qZDzb89bsEoEWSF0xesHiN7WYO26NdaDi3FzBywKml6sQvFrcNWYZKAY6ma
 6JJUmBpiyMonxQAD2uAEVzMkaP6hVEv2XEzT+1zAuFONYnVniLEG/x6KBBUlH+3FtOQk
 yavA==
X-Gm-Message-State: AOAM531nzHYcciFkLLq+cKRfvg32Kv13stbYghcrUumItCfo2g4FUy8S
 bKG+qGbcNqocuoQEZGsBo6MvpLuThsb+rU7buCPuhuOf2ZQMFoZXf5rT9pCgkSAka31kOcyURzd
 rFA13urURG16rdVQ=
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr9138406wrn.347.1599235296214; 
 Fri, 04 Sep 2020 09:01:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaPG/GPz7sOWDiFVw45nMdNfjkQXgXBwK3kBofk0YEn3naszgP82r8vx8Iqdx1AkoUrFRY1A==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr9138356wrn.347.1599235295818; 
 Fri, 04 Sep 2020 09:01:35 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id g143sm11450301wme.0.2020.09.04.09.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 09:01:35 -0700 (PDT)
Subject: Re: [PATCH 2/2] target/arm: Remove no-longer-reachable 32-bit KVM code
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200904154156.31943-1-peter.maydell@linaro.org>
 <20200904154156.31943-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <11457fd8-725f-5836-e2ef-6c60aee344e5@redhat.com>
Date: Fri, 4 Sep 2020 18:01:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904154156.31943-3-peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 5:41 PM, Peter Maydell wrote:
> Now that 32-bit KVM host support is gone, KVM can never
> be enabled unless CONFIG_AARCH64 is true, and some code
> paths are no longer reachable and can be deleted.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
[...]
>  static void arm_max_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
>  
> -    if (kvm_enabled()) {
> -        kvm_arm_set_cpu_features_from_host(cpu);
> -    } else {
> -        cortex_a15_initfn(obj);
> +    cortex_a15_initfn(obj);
>  
> -        /* old-style VFP short-vector support */
> -        cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
> +    /* old-style VFP short-vector support */
> +    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
>  
>  #ifdef CONFIG_USER_ONLY
> -        /* We don't set these in system emulation mode for the moment,
> -         * since we don't correctly set (all of) the ID registers to
> -         * advertise them.
> -         */
> -        set_feature(&cpu->env, ARM_FEATURE_V8);
> -        {
> -            uint32_t t;
> +    /* We don't set these in system emulation mode for the moment,

checkpatch might warn "block comment ... separate line" :/

> +     * since we don't correctly set (all of) the ID registers to
> +     * advertise them.
> +     */
> +    set_feature(&cpu->env, ARM_FEATURE_V8);
> +    {
> +        uint32_t t;
>  
> -            t = cpu->isar.id_isar5;
> -            t = FIELD_DP32(t, ID_ISAR5, AES, 2);
> -            t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);
> -            t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);
> -            t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
> -            t = FIELD_DP32(t, ID_ISAR5, RDM, 1);
> -            t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);
> -            cpu->isar.id_isar5 = t;
> +        t = cpu->isar.id_isar5;
> +        t = FIELD_DP32(t, ID_ISAR5, AES, 2);
> +        t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);
> +        t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);
> +        t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
> +        t = FIELD_DP32(t, ID_ISAR5, RDM, 1);
> +        t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);
> +        cpu->isar.id_isar5 = t;
>  
> -            t = cpu->isar.id_isar6;
> -            t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
> -            t = FIELD_DP32(t, ID_ISAR6, DP, 1);
> -            t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
> -            t = FIELD_DP32(t, ID_ISAR6, SB, 1);
> -            t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
> -            cpu->isar.id_isar6 = t;
> +        t = cpu->isar.id_isar6;
> +        t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);
> +        t = FIELD_DP32(t, ID_ISAR6, DP, 1);
> +        t = FIELD_DP32(t, ID_ISAR6, FHM, 1);
> +        t = FIELD_DP32(t, ID_ISAR6, SB, 1);
> +        t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);
> +        cpu->isar.id_isar6 = t;
>  
> -            t = cpu->isar.mvfr1;
> -            t = FIELD_DP32(t, MVFR1, FPHP, 3);     /* v8.2-FP16 */
> -            t = FIELD_DP32(t, MVFR1, SIMDHP, 2);   /* v8.2-FP16 */
> -            cpu->isar.mvfr1 = t;
> +        t = cpu->isar.mvfr1;
> +        t = FIELD_DP32(t, MVFR1, FPHP, 3);     /* v8.2-FP16 */
> +        t = FIELD_DP32(t, MVFR1, SIMDHP, 2);   /* v8.2-FP16 */
> +        cpu->isar.mvfr1 = t;
>  
> -            t = cpu->isar.mvfr2;
> -            t = FIELD_DP32(t, MVFR2, SIMDMISC, 3); /* SIMD MaxNum */
> -            t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
> -            cpu->isar.mvfr2 = t;
> +        t = cpu->isar.mvfr2;
> +        t = FIELD_DP32(t, MVFR2, SIMDMISC, 3); /* SIMD MaxNum */
> +        t = FIELD_DP32(t, MVFR2, FPMISC, 4);   /* FP MaxNum */
> +        cpu->isar.mvfr2 = t;
>  
> -            t = cpu->isar.id_mmfr3;
> -            t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
> -            cpu->isar.id_mmfr3 = t;
> +        t = cpu->isar.id_mmfr3;
> +        t = FIELD_DP32(t, ID_MMFR3, PAN, 2); /* ATS1E1 */
> +        cpu->isar.id_mmfr3 = t;
>  
> -            t = cpu->isar.id_mmfr4;
> -            t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
> -            t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
> -            t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
> -            t = FIELD_DP32(t, ID_MMFR4, XNX, 1); /* TTS2UXN */
> -            cpu->isar.id_mmfr4 = t;
> -        }
> -#endif
> +        t = cpu->isar.id_mmfr4;
> +        t = FIELD_DP32(t, ID_MMFR4, HPDS, 1); /* AA32HPD */
> +        t = FIELD_DP32(t, ID_MMFR4, AC2, 1); /* ACTLR2, HACTLR2 */
> +        t = FIELD_DP32(t, ID_MMFR4, CNP, 1); /* TTCNP */
> +        t = FIELD_DP32(t, ID_MMFR4, XNX, 1); /* TTS2UXN */
> +        cpu->isar.id_mmfr4 = t;
>      }
> +#endif

Scary :) This is the if {} else {} removed, OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  }
>  #endif
>  
> @@ -2269,11 +2265,7 @@ static void arm_host_initfn(Object *obj)
>  
>  static const TypeInfo host_arm_cpu_type_info = {
>      .name = TYPE_ARM_HOST_CPU,
> -#ifdef TARGET_AARCH64
>      .parent = TYPE_AARCH64_CPU,
> -#else
> -    .parent = TYPE_ARM_CPU,
> -#endif
>      .instance_init = arm_host_initfn,
>  };
[...]


