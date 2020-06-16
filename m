Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3694C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36CA20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jE0icwKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36CA20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCP8-0000P2-SK
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlCNy-0007ft-Fw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:16:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlCNt-0006Mr-Pq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:16:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id c3so20918914wru.12
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YcBLs21lASDhLo9oArtApXGLp0A5+ux1fGqtDC7hFdM=;
 b=jE0icwKh+83nRSuXJ28WYfvx2Ca51DGOJiXzOs0zKnh/F2T9t76rUkoHCyJYnv10wB
 wf3eFqxIjwhljiR3yzUFi2DBxlrR3Qe8jcsb7pP/+gL+S3K5Kc46+hYAARtHFLISvkXr
 AUzGsmdCdFqwt/eM4ImQilxY6ZEbn/eoMmId1taOwCqMoCfCvnbSuVU6yA/qltvR+VHq
 HhRLoFnz2YMgdwVQI355guADBgjiHe/Wyoot6w648fwl2xiKdD7ZhqGK7SIIgqCchrB7
 Q5ko+49N3ZGGzNLgTLOYz5ziClDBJhtJv2PYhPup4pZ/o2X6CAy3Hcx0wR23jn4akqHn
 JS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YcBLs21lASDhLo9oArtApXGLp0A5+ux1fGqtDC7hFdM=;
 b=A9B6D/FEoR6JlEy9Am743n838xixEcPZ28rTTWou279OTUCBsyEmt4eF07jv2lOZ5V
 oyAtpbMvEgOReCPCIKFe64IaNVvh6XOe8XCTTa6MOU8rqPq7GaOTPziHdm0NHLj0dkQ7
 t7M6zgTWN8AOHWWEMHVjKv4gm5Y31eqkU6crRkdjImOyS8bVPFtTSYCvQYDF8CAB6sES
 uz/uCN7dT2JlsuUeL8kxmvcxI74kNZ8rtugSw2F0O+IuipCZClfTt2MffIVMsQFy+kuF
 3cnktAeTs3J6/6MRZ4T3OxF+pEq1YsJr+SJ8DN3NEHrpPsul3XTBZaw3fIv8d5G+ZsBd
 LoWA==
X-Gm-Message-State: AOAM531ab3dyfBho505RtMjFJfno6GU1k4j3hM1gxB5Gvu361HDJ7ZKv
 vyvab7i9qRUsxa+omt81fBY7uA==
X-Google-Smtp-Source: ABdhPJy/evnWkB0//MqZXlwrIoZ+8HCqxQVEafTFaNMsyBjLMQ6QsA3LbEiV6eLfKeFdA/r8MeIiQg==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr3646912wro.60.1592316972382;
 Tue, 16 Jun 2020 07:16:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p7sm29722464wro.26.2020.06.16.07.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 07:16:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 742271FF7E;
 Tue, 16 Jun 2020 15:16:10 +0100 (BST)
References: <20200615180346.3992-1-cfontana@suse.de>
 <20200615180346.3992-5-cfontana@suse.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v5 4/4] cpus: extract out accel-specific code to each accel
In-reply-to: <20200615180346.3992-5-cfontana@suse.de>
Date: Tue, 16 Jun 2020 15:16:10 +0100
Message-ID: <87y2onyu39.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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

> each accelerator registers a new "CpusAccel" interface
> implementation on initialization, providing functions for
> starting a vcpu, kicking a vcpu, and sychronizing state.
>
> This way the code in cpus.c is now all general softmmu code,
> nothing accelerator-specific anymore.
>
> There is still some ifdeffery for WIN32 though.
>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  MAINTAINERS                   |   1 +
>  accel/Makefile.objs           |   2 +-
>  accel/kvm/Makefile.objs       |   2 +
>  accel/kvm/kvm-all.c           |  15 +-
>  accel/kvm/kvm-cpus.c          |  94 +++++
>  accel/kvm/kvm-cpus.h          |  17 +
>  accel/qtest/Makefile.objs     |   2 +
>  accel/qtest/qtest-cpus.c      | 105 +++++
>  accel/qtest/qtest-cpus.h      |  17 +
>  accel/{ =3D> qtest}/qtest.c     |   7 +
>  accel/stubs/kvm-stub.c        |   3 +-
>  accel/tcg/Makefile.objs       |   1 +
>  accel/tcg/tcg-all.c           |  12 +-
>  accel/tcg/tcg-cpus.c          | 523 ++++++++++++++++++++++++
>  accel/tcg/tcg-cpus.h          |  17 +
>  hw/core/cpu.c                 |   1 +
>  include/sysemu/cpus.h         |  32 ++
>  include/sysemu/hw_accel.h     |  57 +--
>  include/sysemu/kvm.h          |   2 +-
>  softmmu/cpus.c                | 911 ++++--------------------------------=
------
>  stubs/Makefile.objs           |   1 +
>  stubs/cpu-synchronize-state.c |  15 +
>  target/i386/Makefile.objs     |   7 +-
>  target/i386/hax-all.c         |   6 +-
>  target/i386/hax-cpus.c        |  85 ++++
>  target/i386/hax-cpus.h        |  17 +
>  target/i386/hax-i386.h        |   2 +
>  target/i386/hax-posix.c       |  12 +
>  target/i386/hax-windows.c     |  20 +
>  target/i386/hvf/Makefile.objs |   2 +-
>  target/i386/hvf/hvf-cpus.c    | 141 +++++++
>  target/i386/hvf/hvf-cpus.h    |  17 +
>  target/i386/hvf/hvf.c         |   3 +
>  target/i386/whpx-all.c        |   3 +
>  target/i386/whpx-cpus.c       |  96 +++++
>  target/i386/whpx-cpus.h       |  17 +
>  36 files changed, 1362 insertions(+), 903 deletions(-)
>  create mode 100644 accel/kvm/kvm-cpus.c
>  create mode 100644 accel/kvm/kvm-cpus.h
>  create mode 100644 accel/qtest/Makefile.objs
>  create mode 100644 accel/qtest/qtest-cpus.c
>  create mode 100644 accel/qtest/qtest-cpus.h
>  rename accel/{ =3D> qtest}/qtest.c (86%)
>  create mode 100644 accel/tcg/tcg-cpus.c
>  create mode 100644 accel/tcg/tcg-cpus.h
>  create mode 100644 stubs/cpu-synchronize-state.c
>  create mode 100644 target/i386/hax-cpus.c
>  create mode 100644 target/i386/hax-cpus.h
>  create mode 100644 target/i386/hvf/hvf-cpus.c
>  create mode 100644 target/i386/hvf/hvf-cpus.h
>  create mode 100644 target/i386/whpx-cpus.c
>  create mode 100644 target/i386/whpx-cpus.h

Predictably for such a spider patch I got a bunch of conflicts
attempting to merge on my testing branch so only a few comments.

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f308537d42..ef8cbb2680 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -427,6 +427,7 @@ WHPX CPUs
>  M: Sunil Muthuswamy <sunilmut@microsoft.com>
>  S: Supported
>  F: target/i386/whpx-all.c
> +F: target/i386/whpx-cpus.c
>  F: target/i386/whp-dispatch.h
>  F: accel/stubs/whpx-stub.c
>  F: include/sysemu/whpx.h
> diff --git a/accel/Makefile.objs b/accel/Makefile.objs
> index ff72f0d030..c5e58eb53d 100644
> --- a/accel/Makefile.objs
> +++ b/accel/Makefile.objs
> @@ -1,5 +1,5 @@
>  common-obj-$(CONFIG_SOFTMMU) +=3D accel.o
> -obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D qtest.o
> +obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D qtest/

This does raise the question if qtest is "just another" accelerator then
should we not be creating a CONFIG_QTEST symbol for explicitness?

>  obj-$(CONFIG_KVM) +=3D kvm/
>  obj-$(CONFIG_TCG) +=3D tcg/
>  obj-$(CONFIG_XEN) +=3D xen/
<snip>
> +static void *qtest_cpu_thread_fn(void *arg)
> +{
> +#ifdef _WIN32
> +    error_report("qtest is not supported under Windows");
> +    exit(1);
> +#else

This is literally impossible to build isn't it?
>=20=20
>  static int qtest_init_accel(MachineState *ms)
>  {
> +    cpus_register_accel(&qtest_cpus);
>      return 0;
>  }

I wonder if these register functions could be moved to initfns like we
use for our hardware models?

<snip>
>=20=20
> +/*
> + * every accelerator is supposed to register this.
> + * Could be in the AccelClass instead, but ends up being too complicated
> + * to access in practice, and inefficient for each call of each method.
> + */
> +static CpusAccel cpus_accel;
> +

wait what? Does an indirection cause that much trouble? I'm surprised
given how often we use it elsewhere in the code. I guess others might
argue for a full QOM-ification of the accelerator but I think we can at
least have an indirection rather than a copy of the structure.


--=20
Alex Benn=C3=A9e

