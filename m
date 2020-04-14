Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3033BC2BB86
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AAD20732
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AAD20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKe1-0002EX-8f
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jOKcF-0000C2-QF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jOKcD-000561-Um
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:24:35 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jOKcD-00053o-D3; Tue, 14 Apr 2020 08:24:33 -0400
Received: by mail-yb1-f196.google.com with SMTP id f13so5343713ybk.7;
 Tue, 14 Apr 2020 05:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EvplgF3+KjWKqP1BAyGxZLksNkOi6W16UFUmN+P+rTw=;
 b=PuTUcdcrlXlZxgnW8WkEJagGDhLnPO0PvgeRHUrodZVCJ3Ib0sPc8xsG6iX2NBe85C
 K07KGeX+YXKfc7KSGcN+9RDtPh4JtKuCH/Sxl4Gh2n8mFgPgddJIL3U9SPDoMIrioRAJ
 D8mNziaZ1sQMey0RvVIAalVW/rcySPocisP0bWkWQPIGDgP+vChmGMCMAvHkPTcsvByN
 m+254pVknWwnzwFFwS8KbLDMgradrQTnwysCxGpBhczdxoy62PKmIXmXNOFICX+JHEmo
 pn3yIyBZmjpaQj7GhS60y71sHgfIafflsAAFyZ8kQIaxGv0yP0eLhKsE29a4iGY0WfLU
 wmqA==
X-Gm-Message-State: AGi0Pub5VhC6cz5GGsyRGMaCoZwvhaolyqXtoMVdbuW+03OBpaGrqGsO
 KHWfxk7rFs7LOt6FYeqGopdPSgKdO/MPn+ILdi0=
X-Google-Smtp-Source: APiQypLH+egm6x4eUDPR2koFJzmqSuZIBARE0XflOzpjOdkwbOEm/3zColNqA/v4em9UcBzkwFPPKfdHKrXV5PBP3zo=
X-Received: by 2002:a5b:84c:: with SMTP id v12mr22570221ybq.483.1586867072667; 
 Tue, 14 Apr 2020 05:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200412212943.4117-1-f4bug@amsat.org>
 <20200412212943.4117-4-f4bug@amsat.org>
 <20200412233308.GS7926@lianli.shorne-pla.net>
 <d2e08a54-a020-1d46-fb88-65f5bb78156f@amsat.org>
In-Reply-To: <d2e08a54-a020-1d46-fb88-65f5bb78156f@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 14 Apr 2020 14:24:21 +0200
Message-ID: <CAAdtpL7FBjzxr9CSMoGd_q8rzm4tr-BwUp8HmmDjrM1DXPSq8A@mail.gmail.com>
Subject: Re: [PATCH-for-5.0? 3/3] hw/openrisc/pic_cpu: Use qdev gpio rather
 than qemu_allocate_irqs()
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.196
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
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 13, 2020 at 11:15 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Hi Stafford,
>
> On 4/13/20 1:33 AM, Stafford Horne wrote:
> > On Sun, Apr 12, 2020 at 11:29:43PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> Switch to using the qdev gpio API which is preferred over
> >> qemu_allocate_irqs(). Doing so we also stop leaking the
> >> allocated memory. One step to eventually deprecate and
> >> remove qemu_allocate_irqs() one day.
> >>
> >> Patch created mechanically using spatch with this script
> >> inspired from commit d6ef883d9d7:
> >>
> >>   @@
> >>   typedef qemu_irq;
> >>   identifier irqs, handler;
> >>   expression opaque, count, i;
> >>   @@
> >>   -   qemu_irq *irqs;
> >>       ...
> >>   -   irqs =3D qemu_allocate_irqs(handler, opaque, count);
> >>   +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
> >>       <+...
> >>   -   irqs[i]
> >>   +   qdev_get_gpio_in(DEVICE(opaque), i)
> >>       ...+>
> >>   ?-  g_free(irqs);
> >>
> >> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>  hw/openrisc/pic_cpu.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/openrisc/pic_cpu.c b/hw/openrisc/pic_cpu.c
> >> index 36f9350830..4b0c92f842 100644
> >> --- a/hw/openrisc/pic_cpu.c
> >> +++ b/hw/openrisc/pic_cpu.c
> >> @@ -52,10 +52,9 @@ static void openrisc_pic_cpu_handler(void *opaque, =
int irq, int level)
> >>  void cpu_openrisc_pic_init(OpenRISCCPU *cpu)
> >>  {
> >>      int i;
> >> -    qemu_irq *qi;
> >> -    qi =3D qemu_allocate_irqs(openrisc_pic_cpu_handler, cpu, NR_IRQS)=
;
> >> +    qdev_init_gpio_in(DEVICE(cpu), openrisc_pic_cpu_handler, NR_IRQS)=
;
> >>
> >>      for (i =3D 0; i < NR_IRQS; i++) {
> >> -        cpu->env.irq[i] =3D qi[i];
> >> +        cpu->env.irq[i] =3D qdev_get_gpio_in(DEVICE(cpu), i);
> >>      }
> >>  }
> >
> > This looks fine to me.
> >
> > Why do you have the '5.0?' in the subject?
>
> Simply because similar commit d6ef883d9d7 was merged in 5.0-rc1 (and it
> fixes a bug reported by Coverity, I'm not sure why Coverity didn't
> reported this too).

Actually Coverity reported this issue as CID1421934 "Resource leak" on
2020-03-19 18:52:20.

  The system resource will not be reclaimed and reused, reducing the
future availability of the resource.
  In cpu_openrisc_pic_init: Leak of memory or pointers to system
resources (CWE-404)

>
> >
> > -Stafford
> >

