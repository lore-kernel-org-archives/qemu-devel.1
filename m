Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80306C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532CC207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFP2MmhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532CC207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFmN-0002Wy-J7
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlFlf-00022E-5e
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:53:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlFlc-0007WR-Rq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:53:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id d128so4018068wmc.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ECUzg6aUj9q9ut7trOuX2iKOknKK7KM1Q7Drqi0QfdM=;
 b=uFP2MmhMNBSl26YZU2dJUJKXzpfKBFwCOCcmxM1t8134iqtcdyn8Ontm8m1B6U2hgw
 7+P3F+YRi7fEYfRITwwbz0bubl+Lc/1/SZAQQvMloz4gITnys9PSYBwC6yJ/9VVfIaGE
 g+WwkKBGKIgZENpFPuErkv62OityB1ibhwej4Gqr+cIYn/2CVmtv9rUkmNDtAIFYFMAT
 AEnTQpEfbo0NJI9U3uziCVwB/gksBsVX+01g8ld4SPltTZ9Fw1UGDehRpVt5sICGUUPR
 0sFg6hdXQjoWwKJYBww6I57kjcGhtcIalCTwJ3awHnObGejKHcn49zDeJ0yN4WFfJnWA
 9e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ECUzg6aUj9q9ut7trOuX2iKOknKK7KM1Q7Drqi0QfdM=;
 b=bs1fPLbhTFNNBujPvWLHyjTlHF4/5Lk03ieyQJtfwytsPeb7vIhwP62DYio3J8/Ej6
 1GtKHRLrJTzH/UqFUfTL83u+8coWubpoEfqca/0tAZlzhI5fgrNHBxXrsHIyqxmUwaBg
 GOlgdNNUek6vIhgyL8oeFUbBqhcYS6PEyY6SqgWB5AH3gghiuXLd77DT3730+jpG+RgW
 5mghYUATKHbtC4iAw8ct8Cq5Yy4FUj2kq13MeQJCjV2+h5Zt3uSvs1l9rq2IXBA0cr9l
 jp/BmrqoR6HJCDwVKDpQNrg5McXgF+B9YOnipTvwblBKn9zko00mtIc5YCPWoyCeedO5
 ho+w==
X-Gm-Message-State: AOAM532NlrkG6Q9Qh4NZoRVtvOqdylAW2pSysg/mpeTQHtp6er4MjXE+
 mgyI5IZOwlH46nzCnkSgvHTTvQ==
X-Google-Smtp-Source: ABdhPJxQLlwsbZUp+6xRkjrrlt6tgyKN5ftT0KyrhS5Yybf9Ebycn65QanZcOJ5vvYbg+PPs/rMnxg==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr4381962wmi.119.1592329979225; 
 Tue, 16 Jun 2020 10:52:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u7sm30729060wrm.23.2020.06.16.10.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:52:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4A6091FF7E;
 Tue, 16 Jun 2020 18:52:57 +0100 (BST)
References: <20200615180346.3992-1-cfontana@suse.de>
 <20200615180346.3992-5-cfontana@suse.de> <87y2onyu39.fsf@linaro.org>
 <75a85b11-6241-ebce-9fb9-ca92fdfba5de@suse.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v5 4/4] cpus: extract out accel-specific code to each accel
In-reply-to: <75a85b11-6241-ebce-9fb9-ca92fdfba5de@suse.de>
Date: Tue, 16 Jun 2020 18:52:57 +0100
Message-ID: <87wo46yk1y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> Hi Alex,
>
> thanks for looking at this,
>
> On 6/16/20 4:16 PM, Alex Benn=C3=A9e wrote:
>>=20
>> Claudio Fontana <cfontana@suse.de> writes:
>>=20
>>> each accelerator registers a new "CpusAccel" interface
>>> implementation on initialization, providing functions for
>>> starting a vcpu, kicking a vcpu, and sychronizing state.
>>>
>>> This way the code in cpus.c is now all general softmmu code,
>>> nothing accelerator-specific anymore.
>>>
>>> There is still some ifdeffery for WIN32 though.
>>>
>>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>>> ---
>>>  MAINTAINERS                   |   1 +
>>>  accel/Makefile.objs           |   2 +-
>>>  accel/kvm/Makefile.objs       |   2 +
>>>  accel/kvm/kvm-all.c           |  15 +-
>>>  accel/kvm/kvm-cpus.c          |  94 +++++
>>>  accel/kvm/kvm-cpus.h          |  17 +
>>>  accel/qtest/Makefile.objs     |   2 +
>>>  accel/qtest/qtest-cpus.c      | 105 +++++
>>>  accel/qtest/qtest-cpus.h      |  17 +
>>>  accel/{ =3D> qtest}/qtest.c     |   7 +
>>>  accel/stubs/kvm-stub.c        |   3 +-
>>>  accel/tcg/Makefile.objs       |   1 +
>>>  accel/tcg/tcg-all.c           |  12 +-
>>>  accel/tcg/tcg-cpus.c          | 523 ++++++++++++++++++++++++
>>>  accel/tcg/tcg-cpus.h          |  17 +
>>>  hw/core/cpu.c                 |   1 +
>>>  include/sysemu/cpus.h         |  32 ++
>>>  include/sysemu/hw_accel.h     |  57 +--
>>>  include/sysemu/kvm.h          |   2 +-
>>>  softmmu/cpus.c                | 911 ++++------------------------------=
--------
>>>  stubs/Makefile.objs           |   1 +
>>>  stubs/cpu-synchronize-state.c |  15 +
>>>  target/i386/Makefile.objs     |   7 +-
>>>  target/i386/hax-all.c         |   6 +-
>>>  target/i386/hax-cpus.c        |  85 ++++
>>>  target/i386/hax-cpus.h        |  17 +
>>>  target/i386/hax-i386.h        |   2 +
>>>  target/i386/hax-posix.c       |  12 +
>>>  target/i386/hax-windows.c     |  20 +
>>>  target/i386/hvf/Makefile.objs |   2 +-
>>>  target/i386/hvf/hvf-cpus.c    | 141 +++++++
>>>  target/i386/hvf/hvf-cpus.h    |  17 +
>>>  target/i386/hvf/hvf.c         |   3 +
>>>  target/i386/whpx-all.c        |   3 +
>>>  target/i386/whpx-cpus.c       |  96 +++++
>>>  target/i386/whpx-cpus.h       |  17 +
>>>  36 files changed, 1362 insertions(+), 903 deletions(-)
>>>  create mode 100644 accel/kvm/kvm-cpus.c
>>>  create mode 100644 accel/kvm/kvm-cpus.h
>>>  create mode 100644 accel/qtest/Makefile.objs
>>>  create mode 100644 accel/qtest/qtest-cpus.c
>>>  create mode 100644 accel/qtest/qtest-cpus.h
>>>  rename accel/{ =3D> qtest}/qtest.c (86%)
>>>  create mode 100644 accel/tcg/tcg-cpus.c
>>>  create mode 100644 accel/tcg/tcg-cpus.h
>>>  create mode 100644 stubs/cpu-synchronize-state.c
>>>  create mode 100644 target/i386/hax-cpus.c
>>>  create mode 100644 target/i386/hax-cpus.h
>>>  create mode 100644 target/i386/hvf/hvf-cpus.c
>>>  create mode 100644 target/i386/hvf/hvf-cpus.h
>>>  create mode 100644 target/i386/whpx-cpus.c
>>>  create mode 100644 target/i386/whpx-cpus.h
>>=20
>> Predictably for such a spider patch I got a bunch of conflicts
>> attempting to merge on my testing branch so only a few comments.
>>=20
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index f308537d42..ef8cbb2680 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -427,6 +427,7 @@ WHPX CPUs
>>>  M: Sunil Muthuswamy <sunilmut@microsoft.com>
>>>  S: Supported
>>>  F: target/i386/whpx-all.c
>>> +F: target/i386/whpx-cpus.c
>>>  F: target/i386/whp-dispatch.h
>>>  F: accel/stubs/whpx-stub.c
>>>  F: include/sysemu/whpx.h
>>> diff --git a/accel/Makefile.objs b/accel/Makefile.objs
>>> index ff72f0d030..c5e58eb53d 100644
>>> --- a/accel/Makefile.objs
>>> +++ b/accel/Makefile.objs
>>> @@ -1,5 +1,5 @@
>>>  common-obj-$(CONFIG_SOFTMMU) +=3D accel.o
>>> -obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D qtest.o
>>> +obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D qtest/
>>=20
>> This does raise the question if qtest is "just another" accelerator then
>> should we not be creating a CONFIG_QTEST symbol for explicitness?
>>=20
>>>  obj-$(CONFIG_KVM) +=3D kvm/
>>>  obj-$(CONFIG_TCG) +=3D tcg/
>>>  obj-$(CONFIG_XEN) +=3D xen/
>> <snip>
>>> +static void *qtest_cpu_thread_fn(void *arg)
>>> +{
>>> +#ifdef _WIN32
>>> +    error_report("qtest is not supported under Windows");
>>> +    exit(1);
>>> +#else
>>=20
>> This is literally impossible to build isn't it?
>>>=20=20
>>>  static int qtest_init_accel(MachineState *ms)
>>>  {
>>> +    cpus_register_accel(&qtest_cpus);
>>>      return 0;
>>>  }
>>=20
>> I wonder if these register functions could be moved to initfns like we
>> use for our hardware models?
>
> The context is the configure_accelerator() in vl.c , where we loop over p=
ossible candidate accelerators
> and try to initialize them.
>
> In this RFC the cpus_register_accel is triggered at accel_init_machine() =
time,
> in the accelerator class init_machine() method, where we are trying to us=
e a specific accelerator.
>
> This is the case for qtest like for the other AccelClass types (tcg and t=
he hardware accelerators).
>
> If not in init_machine(), where would the registration best happen?

Ahh I see - this is once the decision about which accelerator has been
made. I was thinking along the lines of the init functions driven by:

  #define type_init(function) module_init(function, MODULE_INIT_QOM)

which would then populate the list of available accelerators in a more
QOM like manner. I assume having a completely configurable set of
accelerators is the eventual aim of this?

>
>>=20
>> <snip>
>>>=20=20
>>> +/*
>>> + * every accelerator is supposed to register this.
>>> + * Could be in the AccelClass instead, but ends up being too complicat=
ed
>>> + * to access in practice, and inefficient for each call of each method.
>>> + */
>>> +static CpusAccel cpus_accel;
>>> +
>>=20
>> wait what? Does an indirection cause that much trouble? I'm surprised
>> given how often we use it elsewhere in the code. I guess others might
>
> CpusAccel is not used elsewhere currently in the codebase, it's new, or w=
hat do you mean?
>
>> argue for a full QOM-ification of the accelerator but I think we can at
>> least have an indirection rather than a copy of the structure.
>>=20
>>=20
>
> As mentioned in v3 and v2, this is what we end up if we put CpusAccel ins=
ide the AccelClass,
> every time we need a vcpu kick, sync state, etc:
>
> 1) current_accel() function call
> 2) pointer dereference (->accelerator)
> 3) object_class_dynamic_cast_assert function call (ACCEL_GET_CLASS -> OBJ=
ECT_CLASS_CHECK)
> 4) pointer dereference (-> AccelCpusInterface)
> 5) pointer dereference (-> method)
> 6) function call ( ->synchronize_state(cpu))
>
> So the code then would look like this (more or less, probably I would put=
 also an assert for non-NULL in there):
>
> VERSION A)
>
> void cpu_synchronize_state(CPUState *cpu)
> {
>     ACCEL_GET_CLASS(current_accel())->cpus_int->synchronize_state(cpu);
> }

I don't think it has to be quite so extreme. I was just arguing for
something along the lines of:

static CpuAccel *accel;

and

void cpu_synchronize_state(CPUState *cpu)
{
   if (accel && accel->synchronize_state) {
      accel->synchronize_state(cpu);
   }
}

> Instead with the current RFC code, this is what we end up with every
> time we need a vcpu kick, sync state, etc:

I don't think a pointer de-reference alone is super critical for
something that happens on the outside of the main run loop. It might be
a different argument if this was somewhere in the hot path.

> Are you arguing in favor of VERSION A) here?

Version C ;-)

>
> I would like to have an ACK from the owners of the hardware accels especi=
ally that the additional overhead in this code path
> is of negligible importance..
>
>
> Thank you for your comments,
>
> Ciao,
>
> Claudio


--=20
Alex Benn=C3=A9e

