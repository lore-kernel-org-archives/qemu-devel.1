Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B4DC32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E966E22314
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mngArEu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E966E22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqZrQ-0005UV-0L
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 04:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iqZqJ-0004n7-MP
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iqZqI-0006E8-NY
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:47:35 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iqZqI-00068e-Ea; Sun, 12 Jan 2020 04:47:34 -0500
Received: by mail-lj1-x242.google.com with SMTP id y4so6722908ljj.9;
 Sun, 12 Jan 2020 01:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RDLnJ4qJFqQy+U2F1GzxeKsnp0OT/5UfLwjGUAO8yps=;
 b=mngArEu9hEfT+he2g+EY39i8voXyGMVQyKHnLGrN07fzeQ1oIjuJ/uT0rE67m9W0b5
 1B+ijvVUx/OhDdfb1W5aANqY0iG9CNXuRz5sR70kDZgbkmqHKEvaUX6gG7DOJe7HCqWk
 EPl5PVbwgppO8o6+HhV+afhC2eeefiQdrYMxKIubn0AMyt94q4JklFzFY6iBJLZim+q+
 lxQrbiWgNHaYT0sE8GOwUkn4je2IxgK4CHpN4LnMvnGDDZvsGKRwVruyume7Vt7D2r89
 Tj9Cg4v2YHHE1KOUEZv6+irkvJCrwZwUBUmMEhDodr++MSsyQSgwpySIIGmBs5M8ZBjE
 PtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RDLnJ4qJFqQy+U2F1GzxeKsnp0OT/5UfLwjGUAO8yps=;
 b=h/MoUF/ror5RXuhv8vgjB8tBT4KGIhcEo5sZEZOuWCui71C4kWMXrkdD2MxwtyHRyW
 BoRiKatzEJfB63rdRf+vEgFWW5+KDHcN1IA1y5CNMWnsAEbOHEIdYyRh2O9MXPKK+99U
 vO9qJoq2zftknsUf8giUytkUk7a+NwRuhyb6FvulGGKSPdrLUDXu9TwkxDK/XAaPVVJ/
 D1uxjDBeoEp0aX1d+VLXv8mAdE0KRQJn4DHbjRzqVld8ILX5hRfrL214tTVLPear8Q2N
 2Bj1JlZglB48NInnb3R63/hSGuh44qH8YtSbGoGxwCodufciIm0ByMtArW1R5fDDbqAA
 e0LA==
X-Gm-Message-State: APjAAAWAqpcbgcBvF5tqa8vyN+R0/WkwczBDiOg33Mvb6tNynSj/ToFk
 356RBweohijStgoAZGkNHKpZSd4lQryzjb7S+RCjJMr+
X-Google-Smtp-Source: APXvYqzvRwD0wTNL3ge0fIaHzVy8ssKZyDWXWui59E3SmT+L+JPpV/KxHTsDtelWxlfc754pdzRavhGgWEDG2TwsVLU=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr7529135ljj.206.1578822453192; 
 Sun, 12 Jan 2020 01:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-9-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-9-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 12 Jan 2020 17:47:04 +0800
Message-ID: <CAKmqyKMbgEhs8teVezJRYRidC4oQ-Ucq7_PXqcf9nj0taxBPdA@mail.gmail.com>
Subject: Re: [PATCH 08/15] target/arm/monitor: Replace current_machine by
 qdev_get_machine()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 11:23 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As we want to remove the global current_machine,
> replace 'current_machine' by MACHINE(qdev_get_machine()).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/arm/monitor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index fa054f8a36..bcbf69802d 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -136,7 +136,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(=
CpuModelExpansionType type,
>      }
>
>      if (kvm_enabled()) {
> -        const char *cpu_type =3D current_machine->cpu_type;
> +        MachineState *ms =3D MACHINE(qdev_get_machine());
> +        const char *cpu_type =3D ms->cpu_type;
>          int len =3D strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
>          bool supported =3D false;
>
> --
> 2.21.1
>
>

