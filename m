Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7125206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7125206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsisU-0003L6-Tq
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jsirh-0002WD-1e
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:22:09 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jsirf-0007as-0O
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:22:08 -0400
Received: by mail-ej1-f65.google.com with SMTP id ga4so45642254ejb.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 01:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RFvxEznxuCZiIBGPVFSu+GKQIT6NVK0ghKwuZ4ek8cQ=;
 b=cG0oGEw8u/GqQqROwmJvWY5mMZy5UN3nAgbXCNfdOSqiRBock2NzUdgg0LEER1NENw
 R4TJwIvwuvw1ypagg7lL27YX4dizsM48VwEOqHffCKzWA33KO5+KAz9ZXvr8smEL+fcr
 lGdw9aoplWrtkwgibGXWgRtAKx/ZHxjKwiWPelLCfX+MMkYnF3kSD1+pHV7NkqZmhmTS
 Wm0aqoFLVILuUT7po/0BXvjNfyLqjRI/cT4YoXYGUEJJXOMLxLBg8dSZbsAvdXNwXqkx
 sZyjOBDAehv9CuUPs3Y0kfNgkxAJuaA1oe8HPfb1YmhjRvNgzmK6oJIHftGgXo2zaX2k
 bSWg==
X-Gm-Message-State: AOAM532JE6ce0nxUhDAOECVkqehkQ9bR8qzC+ThKEK4L5j6Wd7YLiz+F
 Jll1JNAxEF1tALQzVkt39Mc=
X-Google-Smtp-Source: ABdhPJwkLZ8mEmSagx8KFX2+ZaEfby+Xh8Kg73FxgrJ5SpV8MrXGoBdjXrqpxk9x/Ba7nn4zF4Cp3Q==
X-Received: by 2002:a17:906:1747:: with SMTP id
 d7mr38471286eje.39.1594110125431; 
 Tue, 07 Jul 2020 01:22:05 -0700 (PDT)
Received: from thl530.multi.box (pd95758fa.dip0.t-ipconnect.de.
 [217.87.88.250])
 by smtp.gmail.com with ESMTPSA id j64sm7203382edd.61.2020.07.07.01.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 01:22:05 -0700 (PDT)
Date: Tue, 7 Jul 2020 10:22:04 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 2/4] target/avr/cpu: Fix $PC displayed address
Message-ID: <20200707102204.10d63988@thl530.multi.box>
In-Reply-To: <20200707070021.10031-3-f4bug@amsat.org>
References: <20200707070021.10031-1-f4bug@amsat.org>
 <20200707070021.10031-3-f4bug@amsat.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.65; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 04:22:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, Michael Rolnik <mrolnik@gmail.com>,
 qemu-devel@nongnu.org, Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Tue,  7 Jul 2020 09:00:19 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:

> $PC is 16-bit wide. Other registers display addresses on a byte
> granularity.
> To have a coherent ouput, display $PC using byte granularity too.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/avr/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 50fb1c378b..9be464991f 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -151,7 +151,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE
> *f, int flags) int i;
> =20
>      qemu_fprintf(f, "\n");
> -    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
> +    qemu_fprintf(f, "PC:    %06x\n", env->pc_w * 2);
>      qemu_fprintf(f, "SP:      %04x\n", env->sp);
>      qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
>      qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

