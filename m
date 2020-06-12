Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA044C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 23:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71137206DC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 23:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnBmL/b+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71137206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjtRR-0006SA-MQ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 19:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjtQq-0005yl-DZ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 19:49:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52687)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjtQo-0006FO-8j
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 19:49:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id r9so9367597wmh.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LaQNawiwEYvZ1MJB69Kw7/ny445id7kQfiNq0wv2cX4=;
 b=SnBmL/b+fBL7BVN0WewMXtjOn/Ai18hY7k/3y2e5V3FxkvW7Ma9NTGcJHU+Kn+s8Do
 ojiBwT3Ai9E26IBdhMDXdLVrYHZVw5DXy9DZFrYXucyjAOa459WA44UCIxx2rJZ9ljeK
 iNyAllHB3kcxi9R4UA+EECg4+NMfVyh+zBk0S36DBvjeR8tfkAtu4mPokSgMwu7CF1gg
 yktrUBnKQ+oEDLG1e2tRAnJPJJAik7KduyMtXoNBrL/n62dRc/rybuzb/wcCf8kTvs+l
 mNimPKv40dHlpGX99XQwAjXGtsfwxmwr3SQiM24A0fTyyETabK90xPjG+2BJhM0QTsOD
 vnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LaQNawiwEYvZ1MJB69Kw7/ny445id7kQfiNq0wv2cX4=;
 b=VNqiYAMeQ7PZuZNR6KjzL7CJqVbHL4vZ/vQ+Kvpw6vf/vR25i4vBmGUO43PrUjO/E3
 XpFONgShRNtvDKc0K8qGc5C5j3A5WPAIpD4TRFZAXbfU8E5/AcnQosJW7N2hGbTCMMe6
 /AB0pQLjvHwvJvP6h4lTsP1eqGHjw54Jy3lDOCpN6WQYmiJCW8Oo5FLEeY0vbmM2KnVh
 n6dpg69w2F8AfPrhive4npiE2p5VkWMWDrahqhTeb3660ecdQUiWIxHegyyoxEGJqyBQ
 4p80btThS+SHZ3HpPmKkR+QTZFIlWKs9a7VPgq+lOZj0WIendqZ4uiCckXj8e+znwUBj
 KoGA==
X-Gm-Message-State: AOAM532bI0+eS1WksgKkd5z3Ur0xl+3+FmZJ+tNLNIhlCq2rihIjPUo3
 Sl4xv7AA5IMU5oMLrxg9UXJ85Q==
X-Google-Smtp-Source: ABdhPJxc0RMGS/abeyGz+a0QjspW2LwLbomhGY5Q/Y3ubzOQO/rAvCzW/nuejjfpvLg6Cz1yoFABUg==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr1328787wmf.17.1592005786488; 
 Fri, 12 Jun 2020 16:49:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k26sm11049690wmi.27.2020.06.12.16.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 16:49:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5F1C91FF7E;
 Sat, 13 Jun 2020 00:49:44 +0100 (BST)
References: <159199109693.1247.1521076916816525358@45ef0f9c86ae>
 <7f7210e1-feb4-874d-d866-50ee0ce6eaee@amsat.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v1 00/18] testing/next (tsan, dtc warnings, cross-builds)
In-reply-to: <7f7210e1-feb4-874d-d866-50ee0ce6eaee@amsat.org>
Date: Sat, 13 Jun 2020 00:49:44 +0100
Message-ID: <87o8pn4zfr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 6/12/20 9:44 PM, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20200612190237.30436-1-alex.bennee=
@linaro.org/
>>   CC      x86_64-softmmu/fpu/softfloat.o
>>   CC      x86_64-softmmu/disas.o
>> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a=
(asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfo=
rk' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclan=
g_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>>   GEN     x86_64-softmmu/gdbstub-xml.c
>>   CC      x86_64-softmmu/arch_init.o
>>   CC      x86_64-softmmu/cpus.o
>>   CC      x86_64-softmmu/gdbstub.o
>>   CC      x86_64-softmmu/balloon.o
>>   CC      x86_64-softmmu/ioport.o
>> /tmp/qemu-test/src/fpu/softfloat.c:3365:13: error: bitwise negation of a=
 boolean expression; did you mean logical negation? [-Werror,-Wbool-operati=
on]
>>     absZ &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven );
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>             !
>> /tmp/qemu-test/src/fpu/softfloat.c:3423:18: error: bitwise negation of a=
 boolean expression; did you mean logical negation? [-Werror,-Wbool-operati=
on]
>>         absZ0 &=3D ~ ( ( (uint64_t) ( absZ1<<1 ) =3D=3D 0 ) & roundNeare=
stEven );
>>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
>>                  !
>> /tmp/qemu-test/src/fpu/softfloat.c:3483:18: error: bitwise negation of a=
 boolean expression; did you mean logical negation? [-Werror,-Wbool-operati=
on]
>>         absZ0 &=3D ~(((uint64_t)(absZ1<<1) =3D=3D 0) & roundNearestEven);
>>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>                  !
>> /tmp/qemu-test/src/fpu/softfloat.c:3606:13: error: bitwise negation of a=
 boolean expression; did you mean logical negation? [-Werror,-Wbool-operati=
on]
>>     zSig &=3D ~ ( ( ( roundBits ^ 0x40 ) =3D=3D 0 ) & roundNearestEven );
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>             !
>> /tmp/qemu-test/src/fpu/softfloat.c:3760:13: error: bitwise negation of a=
 boolean expression; did you mean logical negation? [-Werror,-Wbool-operati=
on]
>>     zSig &=3D ~ ( ( ( roundBits ^ 0x200 ) =3D=3D 0 ) & roundNearestEven =
);
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>             !
>> /tmp/qemu-test/src/fpu/softfloat.c:3987:21: error: bitwise negation of a=
 boolean expression; did you mean logical negation? [-Werror,-Wbool-operati=
on]
>>                     ~ ( ( (uint64_t) ( zSig1<<1 ) =3D=3D 0 ) & roundNear=
estEven );
>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
>>                     !
>> /tmp/qemu-test/src/fpu/softfloat.c:4003:22: error: bitwise negation of a=
 boolean expression; did you mean logical negation? [-Werror,-Wbool-operati=
on]
>>             zSig0 &=3D ~ ( ( (uint64_t) ( zSig1<<1 ) =3D=3D 0 ) & roundN=
earestEven );
>>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>>                      !
>> /tmp/qemu-test/src/fpu/softfloat.c:4273:18: error: bitwise negation of a=
 boolean expression; did you mean logical negation? [-Werror,-Wbool-operati=
on]
>>         zSig1 &=3D ~ ( ( zSig2 + zSig2 =3D=3D 0 ) & roundNearestEven );
>>                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>                  !
>> 8 errors generated.
>> make[1]: *** [/tmp/qemu-test/src/rules.mak:69: fpu/softfloat.o] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
>
> The fix for this is in Richard's tcg queue:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg711229.html

Ahh of course - the fedora bump brought the newer clang.


--=20
Alex Benn=C3=A9e

