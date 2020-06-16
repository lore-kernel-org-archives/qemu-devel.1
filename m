Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C55C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906BB20B80
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwjIjfus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906BB20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBOo-0003Wh-LB
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBNO-00020V-QS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:11:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlBNM-0003cP-Eg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:11:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id y20so3014892wmi.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Uu3YA6xN9OiaO3jQD6rztHmPMjUNaTzPkyj9MB2NriE=;
 b=dwjIjfusH57+6reeoo8og5PxHpx5VOr4dnBVlbfGR9BReetsgi6EkGzaBkXxd9m51A
 eV5IPkkb60urRg235mI3G9iaHyvF1+5vRfVFE/omxOEpUPYkszBRHXfr3ZW/6UHbpB0W
 2stZJdo1bHjJqqJ2Fvpij9oHTej6XrOcptvkIEoN4vKMtJzPB94hOYNCfOWZtQM8rFuK
 zF8HPgKD7YWTGqciDTRuVXtwfkLZCtjyhqz3Ii3WDbMQeKOrPMyuySt8FHk2TTztInti
 RvifHXu9dz2HiM3RCDQWBu2OyRvvragmkNXYwkWp3PyjKOguNvq6qG3TKqFIXaoWbXuA
 POoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Uu3YA6xN9OiaO3jQD6rztHmPMjUNaTzPkyj9MB2NriE=;
 b=e9zM8z7lLKDTW0Arfx9BA3K4GRu4MR+o9mJVECNtOmlUEn7zMVzoF4WMdQqAk0Kcou
 22YmClxHIGPp60ajDo18c4gvxo3xFtyx06ni/Byn9q0UHb/eSQl3bz8jLVQlx9U7bY0f
 GI2fOyMN37/TShNy1iVvCaM16kKCfneWRiBwdrFSWv8GTx1/Unq8bRjl8oxocDFIdk+W
 Qq3dONV16u9QzAp+OHz92ZSgimkFS1r29gJ9ziFVE3SKlUf2SvTbbvz7eNor7gA6/xMT
 cEgRfVJ1jfZgwd9drCGeVLkkeNkamViZA/KnRNiz/LsyseCzwgYFFtEQ8U7VPW+7kaMN
 hzUQ==
X-Gm-Message-State: AOAM530qkVM+BQF384hITo0o/D/dbUuOGmLNmBme9xHDtl91miqDr0e6
 Gy2NbI31lUp3m6mmB2bTyV9lIg==
X-Google-Smtp-Source: ABdhPJw7s12h/bCyazsNYGvGz9wTnlRftxGQKJA05LNoucHILYCr6bZs6BJtJYuS+yPrsS+sGPqpJQ==
X-Received: by 2002:a1c:2d54:: with SMTP id t81mr3399273wmt.154.1592313098755; 
 Tue, 16 Jun 2020 06:11:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f11sm27634485wrm.13.2020.06.16.06.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 06:11:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8ABAB1FF7E;
 Tue, 16 Jun 2020 14:11:36 +0100 (BST)
References: <20200615180346.3992-1-cfontana@suse.de>
 <20200615180346.3992-2-cfontana@suse.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v5 1/4] softmmu: move softmmu only files from root
In-reply-to: <20200615180346.3992-2-cfontana@suse.de>
Date: Tue, 16 Jun 2020 14:11:36 +0100
Message-ID: <87d05z17g7.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

> move arch_init, balloon, cpus, ioport, memory, memory_mapping, qtest.
>
> They are all specific to CONFIG_SOFTMMU.
>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS                                  | 12 ++++++------
>  Makefile.target                              |  7 ++-----
>  softmmu/Makefile.objs                        | 10 ++++++++++
>  arch_init.c =3D> softmmu/arch_init.c           |  0
>  balloon.c =3D> softmmu/balloon.c               |  0
>  cpus.c =3D> softmmu/cpus.c                     |  0
>  ioport.c =3D> softmmu/ioport.c                 |  0
>  memory.c =3D> softmmu/memory.c                 |  0
>  memory_mapping.c =3D> softmmu/memory_mapping.c |  0
>  qtest.c =3D> softmmu/qtest.c                   |  0
>  10 files changed, 18 insertions(+), 11 deletions(-)
>  rename arch_init.c =3D> softmmu/arch_init.c (100%)
>  rename balloon.c =3D> softmmu/balloon.c (100%)
>  rename cpus.c =3D> softmmu/cpus.c (100%)
>  rename ioport.c =3D> softmmu/ioport.c (100%)
>  rename memory.c =3D> softmmu/memory.c (100%)
>  rename memory_mapping.c =3D> softmmu/memory_mapping.c (100%)
>  rename qtest.c =3D> softmmu/qtest.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a922775e45..1b4d2e0285 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -115,7 +115,7 @@ Overall TCG CPUs
>  M: Richard Henderson <rth@twiddle.net>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> -F: cpus.c
> +F: softmmu/cpus.c
>  F: cpus-common.c
>  F: exec.c
>  F: accel/tcg/
> @@ -1682,7 +1682,7 @@ M: David Hildenbrand <david@redhat.com>
>  S: Maintained
>  F: hw/virtio/virtio-balloon*.c
>  F: include/hw/virtio/virtio-balloon.h
> -F: balloon.c
> +F: softmmu/balloon.c
>  F: include/sysemu/balloon.h
>=20=20
>  virtio-9p
> @@ -2131,12 +2131,12 @@ Memory API
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Supported
>  F: include/exec/ioport.h
> -F: ioport.c
>  F: include/exec/memop.h
>  F: include/exec/memory.h
>  F: include/exec/ram_addr.h
>  F: include/exec/ramblock.h
> -F: memory.c
> +F: softmmu/ioport.c
> +F: softmmu/memory.c
>  F: include/exec/memory-internal.h
>  F: exec.c
>  F: scripts/coccinelle/memory-region-housekeeping.cocci
> @@ -2168,13 +2168,13 @@ F: ui/cocoa.m
>  Main loop
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> -F: cpus.c
>  F: include/qemu/main-loop.h
>  F: include/sysemu/runstate.h
>  F: util/main-loop.c
>  F: util/qemu-timer.c
>  F: softmmu/vl.c
>  F: softmmu/main.c
> +F: softmmu/cpus.c
>  F: qapi/run-state.json
>=20=20
>  Human Monitor (HMP)
> @@ -2327,7 +2327,7 @@ M: Thomas Huth <thuth@redhat.com>
>  M: Laurent Vivier <lvivier@redhat.com>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> -F: qtest.c
> +F: softmmu/qtest.c
>  F: accel/qtest.c
>  F: tests/qtest/
>  X: tests/qtest/bios-tables-test-allowed-diff.h
> diff --git a/Makefile.target b/Makefile.target
> index 8ed1eba95b..7fbf5d8b92 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -152,16 +152,13 @@ endif #CONFIG_BSD_USER
>  #########################################################
>  # System emulator target
>  ifdef CONFIG_SOFTMMU
> -obj-y +=3D arch_init.o cpus.o gdbstub.o balloon.o ioport.o
> -obj-y +=3D qtest.o
> +obj-y +=3D softmmu/
> +obj-y +=3D gdbstub.o
>  obj-y +=3D dump/
>  obj-y +=3D hw/
>  obj-y +=3D monitor/
>  obj-y +=3D qapi/
> -obj-y +=3D memory.o
> -obj-y +=3D memory_mapping.o
>  obj-y +=3D migration/ram.o
> -obj-y +=3D softmmu/
>  LIBS :=3D $(libs_softmmu) $(LIBS)
>=20=20
>  # Hardware support
> diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
> index dd15c24346..a4bd9f2f52 100644
> --- a/softmmu/Makefile.objs
> +++ b/softmmu/Makefile.objs
> @@ -1,3 +1,13 @@
>  softmmu-main-y =3D softmmu/main.o
> +
> +obj-y +=3D arch_init.o
> +obj-y +=3D cpus.o
> +obj-y +=3D balloon.o
> +obj-y +=3D ioport.o
> +obj-y +=3D memory.o
> +obj-y +=3D memory_mapping.o
> +
> +obj-y +=3D qtest.o
> +
>  obj-y +=3D vl.o
>  vl.o-cflags :=3D $(GPROF_CFLAGS) $(SDL_CFLAGS)
> diff --git a/arch_init.c b/softmmu/arch_init.c
> similarity index 100%
> rename from arch_init.c
> rename to softmmu/arch_init.c
> diff --git a/balloon.c b/softmmu/balloon.c
> similarity index 100%
> rename from balloon.c
> rename to softmmu/balloon.c
> diff --git a/cpus.c b/softmmu/cpus.c
> similarity index 100%
> rename from cpus.c
> rename to softmmu/cpus.c
> diff --git a/ioport.c b/softmmu/ioport.c
> similarity index 100%
> rename from ioport.c
> rename to softmmu/ioport.c
> diff --git a/memory.c b/softmmu/memory.c
> similarity index 100%
> rename from memory.c
> rename to softmmu/memory.c
> diff --git a/memory_mapping.c b/softmmu/memory_mapping.c
> similarity index 100%
> rename from memory_mapping.c
> rename to softmmu/memory_mapping.c
> diff --git a/qtest.c b/softmmu/qtest.c
> similarity index 100%
> rename from qtest.c
> rename to softmmu/qtest.c


--=20
Alex Benn=C3=A9e

