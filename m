Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E3C2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B2D206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvTnFCKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B2D206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxF2-0000TK-Eg
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIx9d-00047K-Vw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:53:06 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIx9c-0004Gg-43
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:53:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id e11so4839838wme.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZurrNfZeEolKdKhZeySicSYVuuOV/5QvZiscbHtkLco=;
 b=nvTnFCKJuNEf3W2gU3TTgIJLBDXhCFYFWCgNKwnSWPQeJnxozUQ0JFJpo8/xU81xN9
 qagBDEhFEEGwSzLn8qzPpBH7FXDnNL49r5YVvE5kqvYvgZS7e57FUsA9H45Q1Ba6Q+st
 N3+M/3Gm963cnZSHtlo1VONA+knoSODShok8Os3JO3AR7Tr3/QWUi05xB2iHKebZRuOs
 MVZ94P3JeTxG5txZXQyOowRb4fMdGFOtvoX+w3RKOJDSzLnEuOWcwf1afcmhSapjVcGZ
 KX7KvzQ8p/BNus9gizjFVyX3lHJmZ2J/AMlk0kx1SEcKaC+AOSP7jh6zMBY+q6ELc2xq
 kiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZurrNfZeEolKdKhZeySicSYVuuOV/5QvZiscbHtkLco=;
 b=iUetyfXHEoFPBCBEENTSIcXMUBKOuzOTBqLPddpLwh6+B0mLJCi5uhJHAUtzoY7tCE
 xfKHNvr4cwXebBptQubEJuvahQDJxn004Dap8DNO8R4eWmjQfwYisXZfkpXyljrThzJH
 55DlbrwOXBiD/yzrRrLVUYsdWBROttR8YfMfjoeHLjXpa5vh/5VMzW1qceg1sl+6JNO+
 oPFjrXf61rnN7FvflCkrtWv9Os4Ey29QwUwnd5yJ4DCscpGADX7SzKCEK4GnA+cokAM3
 i2TKJeIOkx4KK2wsmM1n/e6iZNXeI14XAe6Vi5oo2g+IAic1p0VA94WXubg6BKIv/4Ys
 J8Sg==
X-Gm-Message-State: AOAM531iCdt3VOnb/2yZLtHxlgOgciaH8+fej3gOWwroAq412D9Wb5KT
 WV6ya45wZn6lYTSZoey3gUy2MA==
X-Google-Smtp-Source: ABdhPJy1tydIrTraTqhDoVQko9w7QMdt9xgmsjB+jyVX3YIelzdoWIqiYUQ9rZU63QbEe/lglxN1gw==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr10467944wmj.149.1600361581846; 
 Thu, 17 Sep 2020 09:53:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q4sm182317wru.65.2020.09.17.09.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 09:53:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E2FF71FF7E;
 Thu, 17 Sep 2020 17:52:59 +0100 (BST)
References: <20200917104441.31738-1-pbonzini@redhat.com>
 <faab2d69-4bd1-4878-d638-4c9414e56499@amsat.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] docker.py: always use --rm
In-reply-to: <faab2d69-4bd1-4878-d638-4c9414e56499@amsat.org>
Date: Thu, 17 Sep 2020 17:52:59 +0100
Message-ID: <87een0xs44.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 9/17/20 12:44 PM, Paolo Bonzini wrote:
>> Avoid that containers pile up.
>>=20
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  tests/docker/Makefile.include | 1 -
>>  tests/docker/docker.py        | 4 ++--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inclu=
de
>> index 3daabaa2fd..75704268ff 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -243,7 +243,6 @@ docker-run: docker-qemu-src
>>  		$(DOCKER_SCRIPT) run 					\
>>  			$(if $(NOUSER),,--run-as-current-user) 		\
>>  			--security-opt seccomp=3Dunconfined		\
>> -			$(if $V,,--rm) 					\
>>  			$(if $(DEBUG),-ti,)				\
>
> Alternatively:
>
> -                       $(if $V,,--rm)
> -                       $(if $(DEBUG),-ti,)
> +                       $(if $(DEBUG),-ti,--rm)

Surely that should b:

  $(if $(DEBUG),-ti --rm,)

I think being able to keep the container around is useful for debug, I
have no problem with changing the behaviour for V=3D1.

>
> Anyhow:
> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>>  			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=3D$(NETWORK)),--ne=
t=3Dnone) \
>>  			-e TARGET_LIST=3D$(subst $(SPACE),$(COMMA),$(TARGET_LIST))	\
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 356d7618f1..36b7868406 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -377,7 +377,7 @@ class Docker(object):
>>              if self._command[0] =3D=3D "podman":
>>                  cmd.insert(0, '--userns=3Dkeep-id')
>>=20=20
>> -        ret =3D self._do_check(["run", "--label",
>> +        ret =3D self._do_check(["run", "--rm", "--label",
>>                               "com.qemu.instance.uuid=3D" + label] + cmd,
>>                               quiet=3Dquiet)
>>          if not keep:
>> @@ -616,7 +616,7 @@ class CcCommand(SubCommand):
>>          if argv and argv[0] =3D=3D "--":
>>              argv =3D argv[1:]
>>          cwd =3D os.getcwd()
>> -        cmd =3D ["--rm", "-w", cwd,
>> +        cmd =3D ["-w", cwd,
>>                 "-v", "%s:%s:rw" % (cwd, cwd)]
>>          if args.paths:
>>              for p in args.paths:
>>=20


--=20
Alex Benn=C3=A9e

