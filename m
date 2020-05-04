Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A1DC4724C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9514F20705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMyFX3nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9514F20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdNJ-0000Qg-O1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jVdM5-0007Cm-9Y; Mon, 04 May 2020 11:50:05 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jVdM4-0001wi-FF; Mon, 04 May 2020 11:50:04 -0400
Received: by mail-io1-xd42.google.com with SMTP id y26so12845001ioj.2;
 Mon, 04 May 2020 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DUIUpYBgndCfIEYWJrb1q1m15DPauWD8dSbVEpcE9Og=;
 b=MMyFX3nYfGc8xWRIV+PKhvfU30oWfs0HEBfwAJECzDGyQfdZ/EGc9NS75lq/2WO6Sj
 IKMPnkNr6o9YtQQayI/eSwVTZXLuo3y9JUHInXk4HdIfs3m6TIGyAteKSIbqf/0xODiB
 D7gX2MSJoV7wz0h/V7mUB5CA/2g7bcCc3xQGCkUiEAp3UVTo6j4vX8NOuBM0jDRYtvHL
 tBU+j+54nKiE6g8cpSlfz/3xqJjfmJuz6rNQpeuKHIjbFAqaklD5XYx408tMz58Eg5NI
 yjNDm7JHI3FX4/HbqMhNyQJdA4T/ptWwhmL894CG8btODtTnFSwJQhZoMQ/HcfnsHBJB
 OdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DUIUpYBgndCfIEYWJrb1q1m15DPauWD8dSbVEpcE9Og=;
 b=GCQKZoWD+2aheOqlJgdQKn4MlvGArgnNfA6TWBN7G+ZZWAlmE41MHHUWKWpoZoDet6
 zGIeURKqoqE7MReOCiyFdMcBcvtKxirpT22KBIuAfDRg1f1DdY2VbMKT8eskgPHHpoai
 56EcMTJDgXH4O1mC44xbasRfSuMVyhPHnQOd02R9NWrha+p/CqOJehotQYVvwQyobFAV
 3mEA9Ilm1sVa6xkNXo0JuwQbglSJjdmkJGTX8ciPREBfqkrkDQEQd6DT24WVfBYT3M7C
 bYPhS2T2YarNUkGh1gFe29JJOcaWmvTHZAU9czpFzMX6kAY59fKUZTjuDnwMJNU+IjIR
 HwXA==
X-Gm-Message-State: AGi0PuZhJioGhzVN5XT1+LPttJcjjkPjVMCm9VUUFyM9wDVyHKF+v20E
 0WQN/SSraIAx6wkwVXmYu+jrqLkebQmT1kM1pvY=
X-Google-Smtp-Source: APiQypKKYwPhj7zL733F2UrRn/hNhEMeR5qzTnwBmqZSwlpjPat/3MYntLUhFZA8VBylRMH2d/Fum2sPj7Vvm+M3nCY=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr16392769iol.105.1588607401793; 
 Mon, 04 May 2020 08:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200504152922.21365-1-philmd@redhat.com>
 <20200504152922.21365-9-philmd@redhat.com>
In-Reply-To: <20200504152922.21365-9-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 May 2020 08:41:21 -0700
Message-ID: <CAKmqyKO5ftGGwcRj1C8jRxoMExH=teKK1KHO_3kWKYiuJVVJLQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] exec: Assert CPU migration is not used on
 user-only build
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 4, 2020 at 8:41 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  exec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/exec.c b/exec.c
> index 2874bb5088..3a39ffb1eb 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -946,7 +946,9 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>
>      qemu_plugin_vcpu_init_hook(cpu);
>
> -#ifndef CONFIG_USER_ONLY
> +#ifdef CONFIG_USER_ONLY
> +    assert(cc->vmsd =3D=3D NULL);
> +#else /* !CONFIG_USER_ONLY */
>      if (qdev_get_vmsd(DEVICE(cpu)) =3D=3D NULL) {
>          vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu)=
;
>      }
> --
> 2.21.3
>
>

