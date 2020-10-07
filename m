Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64AAC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E1C212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbBMcjU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E1C212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ71U-0002H5-PL
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ6yt-0000Nb-St
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:47:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ6yr-00019Z-FD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:47:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id t9so1568676wrq.11
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=90aLAokvFx9ZFzi2SSnBpXhISmm0mqbGol/9TnGcntw=;
 b=BbBMcjU6ynGQNBhLyTJpersZkC22NfiMtc5F8pjAwqVk93bv4DNkFgyz67bAFlbOTQ
 2LjCfDDyzEz+NzCkZqTpCshwzuhrHIMlT7PtTGUEqCsgmPr9c6QCbyFggiqHtKBSJiNZ
 1nN9cuOynibBlS53ZtM6kv2MxSraDlUFIHLq4vDfznzmf5B2kdQJ/+pzLqdNObtSHQx0
 PRSynCeSLOe4gONibvZuzDAqxKDwnFQ0ooqwQ1H4xyvaKgU/cVtS6eRrjDsZmoR66YCz
 /Z1B92l5hAcPXDwFpbZ43dK4n0R8jbz/7827qCF7JR3Jy5lbCURllCSv98er607RO4NU
 U73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=90aLAokvFx9ZFzi2SSnBpXhISmm0mqbGol/9TnGcntw=;
 b=YXEf/th8vzg3RWh9Tou2SVWObBd0Ei+7xmtvIycEYwBfcHVUtj1UiumR4GLqkm/b/A
 4Q3Lo+X0YAlz1BUZ2EaBczUZu8snr7IrJ7NrSzm89llA/nOgufZOGpF308EIANxFvCHJ
 NqNMgOQTSJ1FkkRy0KI2fkqMuBWhVGdAE5UzNm6z7YdmeZcazXZg7L2i56XeJZHPRUwp
 yRbeKg+RWhVDxA6mvf1qLVf1+gtlXOxrIDI0jRZqAt7c5H5nkokPM0+gLL0jgdDeJNxN
 CIXV8KLKRZX1i4W23Jdg4yI1lBNJ1TcJNM8Q3boKSRfQ9A9oVa4PLDSfoJCvlO56f6mU
 uWeA==
X-Gm-Message-State: AOAM533StRTZ4FpYymb4OuGIeBkc8PszrDylr/6A58clZ5+z8mGzWRaC
 CkUdeRqMSTJOfS1hqJu4nN+yag==
X-Google-Smtp-Source: ABdhPJwuVP3TRsQ+FiE8Nogs112rMlwJKP07+/QkzyWI/kwdpEIMz7rSztvnhnvEm/0XL/p3esNyOQ==
X-Received: by 2002:adf:9504:: with SMTP id 4mr3004091wrs.27.1602067651545;
 Wed, 07 Oct 2020 03:47:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f63sm2263676wme.38.2020.10.07.03.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 03:47:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A29E01FF7E;
 Wed,  7 Oct 2020 11:47:29 +0100 (BST)
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
 <20200908051953.1616885-20-david@gibson.dropbear.id.au>
 <87h7r61j1j.fsf@linaro.org>
 <1ffe5f96-be5e-f151-a1fe-7c9f4f765b4d@amsat.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PULL 19/33] mips/cps: Use start-powered-off CPUState property
In-reply-to: <1ffe5f96-be5e-f151-a1fe-7c9f4f765b4d@amsat.org>
Date: Wed, 07 Oct 2020 11:47:29 +0100
Message-ID: <87eema1fem.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: peter.maydell@linaro.org, danielhb413@gmail.com, groug@kaod.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 10/7/20 11:28 AM, Alex Benn=C3=A9e wrote:
>>=20
>> David Gibson <david@gibson.dropbear.id.au> writes:
>>=20
>>> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>>
>>> Instead of setting CPUState::halted to 1 in main_cpu_reset(), use the
>>> start-powered-off property which makes cpu_common_reset() initialize it
>>> to 1 in common code.
>>>
>>> Also change creation of CPU object from cpu_create() to object_new() and
>>> qdev_realize_and_unref() because cpu_create() realizes the CPU and it's=
 not
>>> possible to set a property after the object is realized.
>>>
>>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>> Message-Id: <20200826055535.951207-6-bauerman@linux.ibm.com>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>=20
>> I've finally bisected the breakage in check-acceptance to this patch:
>>=20
>>   10:24:09 [alex.bennee@hackbox2:~/l/q/b/bisect] (102ca966=E2=80=A6)|BIS=
ECTING|=E2=9C=94 + ./tests/venv/bin/avocado run tests/acceptance/machine_mi=
ps_malta.py
>>   /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6=
/site-packages/avocado/plugins/run.py:214: FutureWarning: The following arg=
uments will be changed to boolean soon: sysinfo, output-check, failfast, ke=
ep-tmp and ignore-missing-references.
>>     FutureWarning)
>>   JOB ID     : 1a71a0a81cf9fb9a387d2ab105f8196a26cab84e
>>   JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-07T10.2=
4-1a71a0a/job.log
>>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_1core: PASS (5.70 s)
>>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_7cores: INTERRUPTED: Test interrupte=
d by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERRO=
R\n{'name': '2-tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuff=
er.test_mips_malta_i6400_framebuffer_logo_7cores',
>>   'logdir': '/home/alex.bennee/avocado/job-r... (28.91 s)
>>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_8cores: INTERRUPTED: Test interrupte=
d by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERRO=
R\n{'name': '3-tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuff=
er.test_mips_malta_i6400_framebuffer_logo_8cores',
>>   'logdir': '/home/alex.bennee/avocado/job-r... (30.58 s)
>>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2=
 | CANCEL 0
>>   JOB TIME   : 70.12 s
>>   10:25:27 [alex.bennee@hackbox2:~/l/q/b/bisect] (102ca966=E2=80=A6)|BIS=
ECTING|=E2=9C=94 8 + make -j30
>>   make[1]: Entering directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>>   make[1]: Nothing to be done for 'all'.
>>   make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>>   Generating qemu-version.h with a meson_exe.py custom command
>>   Compiling C object libqemu-mips64el-softmmu.fa.p/hw_mips_cps.c.o
>>   Compiling C object libqemu-mips64-softmmu.fa.p/hw_mips_cps.c.o
>>   Compiling C object libqemu-mipsel-softmmu.fa.p/hw_mips_cps.c.o
>>   Compiling C object libqemu-mips-softmmu.fa.p/hw_mips_cps.c.o
>>   Linking target qemu-system-mips
>>   Linking target qemu-system-mips64el
>>   Linking target qemu-system-mips64
>>   Linking target qemu-system-mipsel
>>   10:26:26 [alex.bennee@hackbox2:~/l/q/b/bisect] (a2c93f06=E2=80=A6)|BIS=
ECTING|=E2=9C=94 + ./tests/venv/bin/avocado run tests/acceptance/machine_mi=
ps_malta.py
>>   /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6=
/site-packages/avocado/plugins/run.py:214: FutureWarning: The following arg=
uments will be changed to boolean soon: sysinfo, output-check, failfast, ke=
ep-tmp and ignore-missing-references.
>>     FutureWarning)
>>   JOB ID     : ccf294ef4e5ebdf19b3a0b53479d574df4ea54ea
>>   JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-07T10.2=
6-ccf294e/job.log
>>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_1core: PASS (5.82 s)
>>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_7cores: PASS (15.16 s)
>>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.=
test_mips_malta_i6400_framebuffer_logo_8cores: PASS (15.97 s)
>>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>>   JOB TIME   : 40.01 s
>
> Using:
>
> -- >8 --
> diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
> index 2f7b2c9592..7c11fb3d44 100644
> --- a/hw/misc/mips_cpc.c
> +++ b/hw/misc/mips_cpc.c
> @@ -38,6 +38,7 @@ static void mips_cpu_reset_async_work(CPUState *cs,
> run_on_cpu_data data)
>      MIPSCPCState *cpc =3D (MIPSCPCState *) data.host_ptr;
>
>      cpu_reset(cs);
> +    cs->halted =3D 0;
>      cpc->vp_running |=3D 1ULL << cs->cpu_index;
>  }

That seems reasonable.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Do you want to roll that into a proper patch or shall I apply directly
into my testing/next tree?

--=20
Alex Benn=C3=A9e

