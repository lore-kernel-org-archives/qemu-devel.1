Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DA2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 21:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F41207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 21:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFQwCNWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F41207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjrQo-0005yd-LQ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 17:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjrQ9-0005Zj-Ud
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 17:41:06 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53657)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjrQ7-0007Sw-9J
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 17:41:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id l26so9177374wme.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=r91n3tes6JporGPbekj9oY3a/8HZ662Ylj3IfxgbWC0=;
 b=pFQwCNWHvaEE/QTeqiaXeJId08C57jMklB5/6l4gjt1lq/StgPyU5ABDi2ACEQCL5e
 f2/4BNsr5V9yTRJm395McdbZB9TCHR4Ev1YKjAOlQUiaKOXKkF4cjq6+0IaNVNVR65Iz
 jsFJFO2kUUuqQL02Fsbc3GqyhHjvTgMpGn1WFmZgYASzmUn8AAPCF2HmkNsUKI2XjhlZ
 UmuAzkVbt/V5mjbdY+LuT7sIZkUmYN7AvAN8cYnV4zk4MAT+dheiH4cedEAFJOVrQZfH
 2S1AHwm8v72eD2dJ4OVnEtW0zXj0/OuMmnhdk5SG9vb7/35UAPmWMcETiEzna9smVthY
 xHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r91n3tes6JporGPbekj9oY3a/8HZ662Ylj3IfxgbWC0=;
 b=WkvxUgtNDT7XxrfVQ5Dq6vmSkh/VftumtwuUrkZoN7YVwY920Nef8sbX/+Q1uEPjuj
 CDLSMl8Yb2yB3ulxd1m/ffLSpeEiKS2ynd3b1ITgolukLx1v+y09r7gZR8EbZ87220tk
 YMsrRlJtNSEmXUYnd03r/S7DYA++RS6J8r52LstvtSwI1hkFutDkDa/DansGo6439fgs
 Y2LqhcdstfzKKvm4ECqUKNtJSdGXENV7xoCpREn1qpY3uGinZsjv+n4iIhS6/rASIYUi
 roe5ncJPSAPbE4EeAnyWEurv0BpLReyJRdqZpTvyg+u97jr50cjgRlN6MFYPYUY2/DnD
 ZkfQ==
X-Gm-Message-State: AOAM530pu249Kt4y/0ZxbjPr/s7IjivH9Wi4ghAA433fmHcVg2gluvU9
 F4vz8gTAiz3WW3lQLwoKnyg=
X-Google-Smtp-Source: ABdhPJzHy8/AUQH5NhOQdzwUYQkFSywwlpF8NwEZNCuc3eDPYpgLsXp6+d2sc2ZLQ6Px+8LVmR3lNQ==
X-Received: by 2002:a1c:dc06:: with SMTP id t6mr923067wmg.118.1591998056804;
 Fri, 12 Jun 2020 14:40:56 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 50sm12624731wra.1.2020.06.12.14.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2020 14:40:55 -0700 (PDT)
Subject: Re: [PATCH v1 00/18] testing/next (tsan, dtc warnings, cross-builds)
To: qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <159199109693.1247.1521076916816525358@45ef0f9c86ae>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7f7210e1-feb4-874d-d866-50ee0ce6eaee@amsat.org>
Date: Fri, 12 Jun 2020 23:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159199109693.1247.1521076916816525358@45ef0f9c86ae>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: fam@euphon.net, richard.henderson@linaro.org, cota@braap.org,
 berrange@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 9:44 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200612190237.30436-1-alex.bennee@linaro.org/
>   CC      x86_64-softmmu/fpu/softfloat.o
>   CC      x86_64-softmmu/disas.o
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfork' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   GEN     x86_64-softmmu/gdbstub-xml.c
>   CC      x86_64-softmmu/arch_init.o
>   CC      x86_64-softmmu/cpus.o
>   CC      x86_64-softmmu/gdbstub.o
>   CC      x86_64-softmmu/balloon.o
>   CC      x86_64-softmmu/ioport.o
> /tmp/qemu-test/src/fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>     absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             !
> /tmp/qemu-test/src/fpu/softfloat.c:3423:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>         absZ0 &= ~ ( ( (uint64_t) ( absZ1<<1 ) == 0 ) & roundNearestEven );
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                  !
> /tmp/qemu-test/src/fpu/softfloat.c:3483:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>         absZ0 &= ~(((uint64_t)(absZ1<<1) == 0) & roundNearestEven);
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                  !
> /tmp/qemu-test/src/fpu/softfloat.c:3606:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>     zSig &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             !
> /tmp/qemu-test/src/fpu/softfloat.c:3760:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>     zSig &= ~ ( ( ( roundBits ^ 0x200 ) == 0 ) & roundNearestEven );
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             !
> /tmp/qemu-test/src/fpu/softfloat.c:3987:21: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>                     ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                     !
> /tmp/qemu-test/src/fpu/softfloat.c:4003:22: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>             zSig0 &= ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                      !
> /tmp/qemu-test/src/fpu/softfloat.c:4273:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>         zSig1 &= ~ ( ( zSig2 + zSig2 == 0 ) & roundNearestEven );
>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                  !
> 8 errors generated.
> make[1]: *** [/tmp/qemu-test/src/rules.mak:69: fpu/softfloat.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:527: x86_64-softmmu/all] Error 2

The fix for this is in Richard's tcg queue:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg711229.html

