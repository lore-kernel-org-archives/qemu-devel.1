Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6CBC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11162063A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 11:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZm1KHNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11162063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvfaV-00061e-41
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 07:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvfZh-0005by-Rp
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:27:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvfZg-0005qI-1p
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 07:27:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id w3so5426777wmi.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3EFATFoxO7iSVk7VOQOqbW43HUjqtediW/rmduiEUgc=;
 b=oZm1KHNOgh7N5sf6mfsMc1X2GCBOZlYeq4e61SA4inmYIef+HG2QIR2JuRsYJSwl9e
 qZxpIYLa7kPmUsiiUNRoV3X20t4oT1ziZ7sD3dbYIE8W7ownu4yCU6qdjEe5dp3SGFTE
 y2uKJBkI6DFL0RIthHNk9yHPdSO6sq776Mg06m28Ynrqz7Gs1Yfnd1uHra4kg9OEL6Gj
 SOL1z6UtJ9LqUZ0fs6Ybzh2BPC+OUnoVkhqOPx0QHv5MEyII36Xd6VrgNByaE+TV2vwq
 BOOhquseT0zq3GTgJ60FDJVoU1rlQRQ5hzup5fNkWUfj1/RLz8XUPL6hNctLz17yZ2i/
 zuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3EFATFoxO7iSVk7VOQOqbW43HUjqtediW/rmduiEUgc=;
 b=cb/3Bk/GTJ40TcmWr6mN2eFhTy5SyNB055Nc2r0mP36JwcpJ+NkCy0Hh4rQztQUFFb
 Fhf9pHKhaRZnrl7Bcka2KwWasDo2qdl0AEJSYh3iOinj4lgKYe34KzyI5oJMI7tlO3Vq
 x5/tiQimD8PqXxXDoyE9nCa86dLbpTOzpgHP29EhbePHIFYEEwI+/Uo8rBPSN8ThYlA4
 A4NryUDv+rPlacwcTBxV6Tsxmbh98nGDIU6FLfK6PC4vgYGxqk+jjZMblPt8D9DDiExA
 2UIo++ulnrwW2j7Tm1Xrk2ywRex3xlDY8u9+gA+tUpSXEKg5LjwTwgpIWtZqocmsQJoC
 KAAg==
X-Gm-Message-State: AOAM531ClSVkQpJbI3Om++YWMrkjW+nyRBemA21+vBQT/8CSAQON23On
 q6ziCUCuJ4evUqIZxNJt3YYHSQ==
X-Google-Smtp-Source: ABdhPJwjLGq+Jm11Dxu8S/SRTY+IoVzVEPeTMVEWml3eob8DUGCaUtF1TRgD3llPurJGGUBivyQnXg==
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr7974404wmo.62.1594812462370; 
 Wed, 15 Jul 2020 04:27:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a12sm3179738wrv.41.2020.07.15.04.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 04:27:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 60B6F1FF7E;
 Wed, 15 Jul 2020 12:27:40 +0100 (BST)
References: <159316678008.10508.6615172353109944370.stgit@pasha-ThinkPad-X280>
 <159316683702.10508.7973844299019522260.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: Re: [PATCH 10/13] gdbstub: add reverse step support in replay mode
In-reply-to: <159316683702.10508.7973844299019522260.stgit@pasha-ThinkPad-X280>
Date: Wed, 15 Jul 2020 12:27:40 +0100
Message-ID: <87d04xxbkj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> GDB remote protocol supports two reverse debugging commands:
> reverse step and reverse continue.
> This patch adds support of the first one to the gdbstub.
> Reverse step is intended to step one instruction in the backwards
> direction. This is not possible in regular execution.
> But replayed execution is deterministic, therefore we can load one of
> the prior snapshots and proceed to the desired step. It is equivalent
> to stepping one instruction back.
> There should be at least one snapshot preceding the debugged part of
> the replay log.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> ---
>  0 files changed
>
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 603d17ff83..fb1e19c585 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -17,6 +17,7 @@
>  #include "exec/log.h"
>  #include "exec/translator.h"
>  #include "exec/plugin-gen.h"
> +#include "sysemu/replay.h"
>=20=20
>  /* Pairs with tcg_clear_temp_count.
>     To be called by #TranslatorOps.{translate_insn,tb_stop} if
> diff --git a/cpus.c b/cpus.c
> index 41d1c5099f..35381ea941 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1100,9 +1100,17 @@ static bool cpu_can_run(CPUState *cpu)
>=20=20
>  static void cpu_handle_guest_debug(CPUState *cpu)
>  {
> -    gdb_set_stop_cpu(cpu);
> -    qemu_system_debug_request();
> -    cpu->stopped =3D true;
> +    if (!replay_running_debug()) {
> +        gdb_set_stop_cpu(cpu);
> +        qemu_system_debug_request();
> +        cpu->stopped =3D true;
> +    } else {
> +        if (!cpu->singlestep_enabled) {
> +            cpu_single_step(cpu, SSTEP_ENABLE);
> +        } else {
> +            cpu_single_step(cpu, 0);
> +        }
> +    }

This no longer applies cleanly.

--=20
Alex Benn=C3=A9e

