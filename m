Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7149BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48A0207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WheFEbx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48A0207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6oz-00026a-PW
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ6nu-00011l-Bi; Wed, 07 Oct 2020 06:36:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ6ns-0008D9-Bk; Wed, 07 Oct 2020 06:36:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id q5so1783443wmq.0;
 Wed, 07 Oct 2020 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Sbw+pZ/Z0Nr9AvOi6F8vUAxKeuc3QUAQYMX7zQA8h4M=;
 b=WheFEbx07CuqPQM6YnrYqi7lxFnHKj9INKlVJA2WKm78qUhlMo2xbJMOwk/rIdBohO
 p5GXIqdviasWquJbZd6VinC7gQc8ITs9cGiwWHO6s3i193A3wFr24yUzA2Sq+lutt7lD
 CmJ0F4e/08n/c3bHv0XhwdCoW+/CoDJzwTo5tLjmiKllM+4hnmOdmGRLK9Apvg86EELp
 hOWx+SxcfT2Vyr60Eo+pwQx4aijngUq8Kf2fs7dgWHpJolJNKVaG1fYho+iX50JanJMt
 s8HSknCtQefJcowFDAOBIPNEWqkbVZkPgm/pq1Bc9PBRUH1fmwPQ7cLR42ACvooaKIIF
 YQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sbw+pZ/Z0Nr9AvOi6F8vUAxKeuc3QUAQYMX7zQA8h4M=;
 b=BaWQKXaYNgaLkezswiTPxtgZ9qQzH8mu1J2zxyf7QtfdX3xCd7Iqmw/TuSAnYf+4jV
 DbLLaRJqQcEaYhxD9+l8YO+QnZmqtz5fRgHT5ynsjxo1EXFNN+Gj89CI/fOgM5XO6FAS
 hixVQO+Vl+BepOvz8VfVHd2uCFXnDoeFg8PKpEt8mCiNkA2uaTtPUmeuR6lkL9z781hN
 eR1G/fiM0QhK+O68nIY+Bme8fjkKPjEfx2fO2cr4prrpLP5A+NmIetsqnqhWFxwk4LiB
 ioiqKcNpyjJ2kmQZ0ZU31PR/1Nw9XM0bbnPezh0o+GclOuCcCa12M9hJsEBKEW/087o0
 mdbw==
X-Gm-Message-State: AOAM531JjWYkgXdipoOa3ipn0+sC1jMUqxuXBkCKve3t+urJkSBtEEii
 3Jk2ILyeKLNSoiL2JewP7rHmhoXjNN4=
X-Google-Smtp-Source: ABdhPJz9Aj/uc2hFg66f3Cadg9PQFmzzTMPQmYy8HzbNshqMo4JXyp6aaosSjHe6YDtFFgMG1Vnfwg==
X-Received: by 2002:a1c:9a41:: with SMTP id c62mr2526726wme.35.1602066969966; 
 Wed, 07 Oct 2020 03:36:09 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z13sm2210848wro.97.2020.10.07.03.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 03:36:09 -0700 (PDT)
Subject: Re: [PULL 19/33] mips/cps: Use start-powered-off CPUState property
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
 <20200908051953.1616885-20-david@gibson.dropbear.id.au>
 <87h7r61j1j.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1ffe5f96-be5e-f151-a1fe-7c9f4f765b4d@amsat.org>
Date: Wed, 7 Oct 2020 12:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87h7r61j1j.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: peter.maydell@linaro.org, danielhb413@gmail.com, groug@kaod.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bauerman@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 11:28 AM, Alex Bennée wrote:
> 
> David Gibson <david@gibson.dropbear.id.au> writes:
> 
>> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>
>> Instead of setting CPUState::halted to 1 in main_cpu_reset(), use the
>> start-powered-off property which makes cpu_common_reset() initialize it
>> to 1 in common code.
>>
>> Also change creation of CPU object from cpu_create() to object_new() and
>> qdev_realize_and_unref() because cpu_create() realizes the CPU and it's not
>> possible to set a property after the object is realized.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Message-Id: <20200826055535.951207-6-bauerman@linux.ibm.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> I've finally bisected the breakage in check-acceptance to this patch:
> 
>   10:24:09 [alex.bennee@hackbox2:~/l/q/b/bisect] (102ca966…)|BISECTING|✔ + ./tests/venv/bin/avocado run tests/acceptance/machine_mips_malta.py
>   /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6/site-packages/avocado/plugins/run.py:214: FutureWarning: The following arguments will be changed to boolean soon: sysinfo, output-check, failfast, keep-tmp and ignore-missing-references.
>     FutureWarning)
>   JOB ID     : 1a71a0a81cf9fb9a387d2ab105f8196a26cab84e
>   JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-07T10.24-1a71a0a/job.log
>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core: PASS (5.70 s)
>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n{'name': '2-tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores',
>   'logdir': '/home/alex.bennee/avocado/job-r... (28.91 s)
>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n{'name': '3-tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores',
>   'logdir': '/home/alex.bennee/avocado/job-r... (30.58 s)
>   RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 | CANCEL 0
>   JOB TIME   : 70.12 s
>   10:25:27 [alex.bennee@hackbox2:~/l/q/b/bisect] (102ca966…)|BISECTING|✔ 8 + make -j30
>   make[1]: Entering directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>   make[1]: Nothing to be done for 'all'.
>   make[1]: Leaving directory '/home/alex.bennee/lsrc/qemu.git/slirp'
>   Generating qemu-version.h with a meson_exe.py custom command
>   Compiling C object libqemu-mips64el-softmmu.fa.p/hw_mips_cps.c.o
>   Compiling C object libqemu-mips64-softmmu.fa.p/hw_mips_cps.c.o
>   Compiling C object libqemu-mipsel-softmmu.fa.p/hw_mips_cps.c.o
>   Compiling C object libqemu-mips-softmmu.fa.p/hw_mips_cps.c.o
>   Linking target qemu-system-mips
>   Linking target qemu-system-mips64el
>   Linking target qemu-system-mips64
>   Linking target qemu-system-mipsel
>   10:26:26 [alex.bennee@hackbox2:~/l/q/b/bisect] (a2c93f06…)|BISECTING|✔ + ./tests/venv/bin/avocado run tests/acceptance/machine_mips_malta.py
>   /home/alex.bennee/lsrc/qemu.git/builds/bisect/tests/venv/lib/python3.6/site-packages/avocado/plugins/run.py:214: FutureWarning: The following arguments will be changed to boolean soon: sysinfo, output-check, failfast, keep-tmp and ignore-missing-references.
>     FutureWarning)
>   JOB ID     : ccf294ef4e5ebdf19b3a0b53479d574df4ea54ea
>   JOB LOG    : /home/alex.bennee/avocado/job-results/job-2020-10-07T10.26-ccf294e/job.log
>    (1/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_1core: PASS (5.82 s)
>    (2/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_7cores: PASS (15.16 s)
>    (3/3) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer.test_mips_malta_i6400_framebuffer_logo_8cores: PASS (15.97 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>   JOB TIME   : 40.01 s

Using:

-- >8 --
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 2f7b2c9592..7c11fb3d44 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -38,6 +38,7 @@ static void mips_cpu_reset_async_work(CPUState *cs,
run_on_cpu_data data)
     MIPSCPCState *cpc = (MIPSCPCState *) data.host_ptr;

     cpu_reset(cs);
+    cs->halted = 0;
     cpc->vp_running |= 1ULL << cs->cpu_index;
 }
---

RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 |
JOB TIME   : 37.54 s

> 
>> ---
>>  hw/mips/cps.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
>> index 615e1a1ad2..23c0f87e41 100644
>> --- a/hw/mips/cps.c
>> +++ b/hw/mips/cps.c
>> @@ -52,9 +52,6 @@ static void main_cpu_reset(void *opaque)
>>      CPUState *cs = CPU(cpu);
>>  
>>      cpu_reset(cs);
>> -
>> -    /* All VPs are halted on reset. Leave powering up to CPC. */
>> -    cs->halted = 1;
>>  }
>>  
>>  static bool cpu_mips_itu_supported(CPUMIPSState *env)
>> @@ -76,7 +73,17 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>>      bool saar_present = false;
>>  
>>      for (i = 0; i < s->num_vp; i++) {
>> -        cpu = MIPS_CPU(cpu_create(s->cpu_type));
>> +        cpu = MIPS_CPU(object_new(s->cpu_type));
>> +
>> +        /* All VPs are halted on reset. Leave powering up to CPC. */
>> +        if (!object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
>> +                                      errp)) {
>> +            return;
>> +        }
>> +
>> +        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
>> +            return;
>> +        }
>>  
>>          /* Init internal devices */
>>          cpu_mips_irq_init_cpu(cpu);
> 
> 

