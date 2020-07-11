Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C5BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEFC2068F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zq2LtcG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEFC2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJjd-0007cn-So
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juJj3-00075k-Ms
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:55:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juJj1-0004F0-Ce
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:55:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2so9013407wmf.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ojonnL4T/gaa1jbTlDbI5s7Ov8/s1KyTmaoGkY1q9sQ=;
 b=zq2LtcG9rQSiq51Iv/cNJkQMJd1mnGTTyn6cV/gsDG3P6s3lRDnYpKrZua1k4lgRme
 S/5QBnyc48j/kHB8BUkM0JrOjVzPUADkPU1pR6vIJ1cU/+VCNRE02+F4JBkFoa/7QXm9
 mN74ZnbTQmd0V3Em8oAdM4u4cUgvnc3Pz2BE9DsoTflYGvfC0FctqCy67Hayb0MWqsTQ
 wU9tYtrSxd1ndD5iHO9deWab60Mz6PC8scBpsq/5lWnEuDIwbwqQp/3E/aZ6KtdiSxQx
 VS/XLSES6evRr3DoUUMt4pAwovgVEzGC5UEsf3pism6b3gBqQUCCcAgCTTyUF5zp4eQv
 wzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ojonnL4T/gaa1jbTlDbI5s7Ov8/s1KyTmaoGkY1q9sQ=;
 b=aLtdZWi3SSw1Ugd5hnOJJ5WU0OJVINZvCUqU6ewaePMvHXdJGM3wH5tqDYH7BA5kL7
 qIowwLr+71ikrATdGbr1sH7E9X7bjLVoPnJQ2kJXjHKQXbnsPckTOOsT/UEV033/gxCb
 yHwKpTsGjjfUKazJMljFx6zddotgS/L67M5F1ypI2y65Z9GyURKHNErpTWBQtXZ8K7fv
 4sHrmvHhgRvB/LGhjPYrq/0dqvkJK+Ni6I/EFTojQFYqltc7qmURCMUePxWaucpj+GB3
 f5yBGY3MlJHOL1SAyPszvibDvk1xE3om9+aJU98i4F1dhFnOBX3TGuwf5bJa/UmEWDZE
 MbPQ==
X-Gm-Message-State: AOAM531cER6cSdHoSEs2V+2V7ytpoImBF51HWq+OwBjVWoPAxO3yCJBU
 UbM8D9AXa2Iz5VxLw9zYNO5urw==
X-Google-Smtp-Source: ABdhPJylZLCQDsQxb45auzHukUW7DxlEjklmaUE4EaK3eiUvCLnpjEJftRiY+AOKJKDCvNPZcabxEw==
X-Received: by 2002:a1c:ac81:: with SMTP id
 v123mr10501673wme.159.1594490145335; 
 Sat, 11 Jul 2020 10:55:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k11sm17441197wrd.23.2020.07.11.10.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:55:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9D7CE1FF7E;
 Sat, 11 Jul 2020 18:55:42 +0100 (BST)
References: <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <CAFEAcA8mFM-O=mgCQHNz4TNB5N3Trid2o95s0Nx7JVp_q_dSrw@mail.gmail.com>
 <20200708160316.GA7276@habkost.net>
 <CAFEAcA89ueUQuVPC9O9xqbBBDEzdXmbCLL69OHvk0MJ=VvSnbw@mail.gmail.com>
 <20200708173620.GB780932@habkost.net>
 <CAFEAcA_bLs+PzjfmCaHQQ3z1BrQ9Uack_Qj7Za-dJwtHWu=8kw@mail.gmail.com>
 <20200708213240.GC780932@habkost.net>
 <87k0zdz8ud.fsf@morokweng.localdomain> <87k0zdm63s.fsf@linaro.org>
 <87imev15xt.fsf@morokweng.localdomain>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
In-reply-to: <87imev15xt.fsf@morokweng.localdomain>
Date: Sat, 11 Jul 2020 18:55:42 +0100
Message-ID: <87o8omq6ld.fsf@linaro.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas
 Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>
>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>
>>>> On Wed, Jul 08, 2020 at 09:11:55PM +0100, Peter Maydell wrote:
>>>>> On Wed, 8 Jul 2020 at 18:36, Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
>>>>> >
>>>>> > On Wed, Jul 08, 2020 at 06:09:49PM +0100, Peter Maydell wrote:
>>>>> > > Exactly. It appears that there's a bug in our mechanisms,
>>>>> > > which is why I'm suggesting that the right thing is
>>>>> > > to fix that bug rather than marking the CPU as halted
>>>>> > > earlier in the reset process so that the KVM_RUN happens
>>>>> > > to do nothing...
>>>>> >
>>>>> > I agree this is necessary, but it doesn't seem sufficient.
>>>>> >
>>>>> > Having cpu_reset() set halted=3D0 on spapr (and probably other
>>>>> > machines) is also a bug, as it could still trigger unwanted
>>>>> > KVM_RUN when cpu_reset() returns (and before machine code sets
>>>>> > halted=3D1).
>>>>>
>>>>> The Arm handling of starting-halted sets halted=3D1 within cpu_reset,
>>>>> based on whether the CPU object was created with a
>>>>> "start-powered-off" property.
>>>>
>>>> Making this mechanism generic sounds like a good idea.
>>>
>>> I'll take a stab at doing that and using it for the spapr machine.
>>>
>>>>> I'm not sure in practice that anything can get in asynchronously
>>>>> and cause a KVM_RUN in between spapr_reset_vcpu() calling
>>>>> cpu_reset() and it setting cs->halted (and the other stuff),
>>>>> though. This function ought to be called with the iothread
>>>>> lock held, so KVM_RUN will only happen if it calls some
>>>>> other function which incorrectly lets the CPU run.
>>>>
>>>> Yeah, maybe it won't happen in practice.  It just seems fragile.
>>>> The same way ppc_cpu_reset() kicked the CPU by accident, code
>>>> outside cpu_reset() might one day kick the CPU by accident before
>>>> setting halted=3D1.
>>>
>>> I'm seeing the vcpu being KVM_RUN'd too early twice during hotplug.
>>> Both of them are before cpu_reset() and ppc_cpu_reset().
>>>
>>> Here's the backtrace for the first of them (redacted for clarity):
>>>
>>> #0  in cpu_resume ()
>>> #1  in cpu_common_realizefn ()
>>> #2  in ppc_cpu_realize ()
>>> #3  in device_set_realized ()
>>> #4  in property_set_bool ()
>>> #5  in object_property_set ()
>>> #6  in object_property_set_qobject ()
>>> #7  in object_property_set_bool ()
>>> #8  in qdev_realize ()
>> <snip>
>>> #18 in qmp_device_add ()
>>
>> Is this a hotplug event?
>
> Yes, the way I reproduce the problem is starting a pseries guest with
> `-smp 2,maxcpus=3D32,sockets=3D1,cores=3D16,threads=3D2` and then use qmp=
-shell to
> send the command:
>
> device_add id=3Ddevice-2 driver=3Dhost-spapr-cpu-core core-id=3D2 node-id=
=3D0
>
>>> Here's the second:
>>>
>>> #0  in qemu_cpu_kick_thread ()
>>> #1  in qemu_cpu_kick ()
>>> #2  in queue_work_on_cpu ()
>>> #3  in async_run_on_cpu ()
>>> #4  in tlb_flush_by_mmuidx ()
>>> #5  in tlb_flush ()
>>> #6  in ppc_tlb_invalidate_all ()
>>
>> FWIW tcg_flush_softmmu_tlb handles a tlb_flush in the common reset code.
>
> Ok, maybe KVM should be doing that too? Or maybe it does but pseries
> isn't relying on it. I'll dig further.

No tlb flush is a softmmu only thing.


--=20
Alex Benn=C3=A9e

