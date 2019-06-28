Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66153C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 311FC206A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngkatILq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311FC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hggZ0-0005c3-Aq
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 22:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hggXG-000405-54
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 22:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hggXD-0001dY-Jd
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 22:22:45 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hggXC-0001Ro-6C
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 22:22:43 -0400
Received: by mail-oi1-x241.google.com with SMTP id m206so3114182oib.12
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 19:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LYvLjPL/B7wrk8yUY0h9s4MAWEaGBNQcPV+Hmqz4kUg=;
 b=ngkatILqNWNalgIUTms/4TaCdGMwS5/3qx9IM75raMINkFL1xPTahI8aAJ9tpIY94z
 qbN+Zl4Mzh6Y/JucAKXb2EfQo2vUkGrY0bByiXrEbXuZgDGtIiLjf6rBdAPu2of2UsU8
 OLcjUus+mvusokq4Mg43NHzMPtUhduE2zJNefD2i4nGxt4mlU3ptk18WJmEgCCCcQN8E
 o+WmbVYibzhfkDosLXvXaJAUxDYd0yYt/78ms68AumfKpGLIk4zuSgL9vh05etYRmmFE
 8yU57B5PphMc0QI8Ivhp3J1C9iSSCo/CW2FnYg8InkaR8oGSxU6dB2F+cbXtcjEQBSxA
 gkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LYvLjPL/B7wrk8yUY0h9s4MAWEaGBNQcPV+Hmqz4kUg=;
 b=eXFjvYqz3HzYzs8ZCx2N7MhRrNyj00+VQfP10WvBYgCi3uIFMgW6EJxkkeAeLrfDqZ
 C7dnFG1G1J190s3uWjg5b86HFyF3TPXZ+4KADd2NXjOqpofZ59JAcCQ08F6HxVNCha21
 Xdq7VYpSXA29Jyek9y4YwDEYcbiNZec33mbPLvUsC6DIPDm8y7fMZxOYGIe8xu5BBZel
 lS3YbQA/S4ZXmhwDIMQ9WVrZPGMaA8f0T6AQFjP+eam0aMnyXNgeYTwgEJJcMuDjFlkb
 Onj3TV1zNFP/DHHpfFU4SiqgQqMp6Xow1EDxVaGXodU5Th5Lxp8AePWZMDE+L+dmYdLg
 GqBg==
X-Gm-Message-State: APjAAAUhRD+1jYzd5adnt10Nzmfqx0iQ6Bzdajd63sKxXgvJyMyWkY3K
 nNunfGHc1YJ8bhGp8Fuosia0SqGZdv/8l91mXyo=
X-Google-Smtp-Source: APXvYqxXCNJFe9Gwr83sP+ij3w8r1HkSu4eIM7/MTNJODmVQ83QgHW/1IzvldgeNbngngVDJ2IoNtamMdZ06RHEkvwo=
X-Received: by 2002:a54:4f97:: with SMTP id g23mr339370oiy.97.1561688557387;
 Thu, 27 Jun 2019 19:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190622002119.126834-1-liq3ea@163.com>
In-Reply-To: <20190622002119.126834-1-liq3ea@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 28 Jun 2019 10:22:00 +0800
Message-ID: <CAKXe6SJOYQ38fADJRHxw4HdXC9hqoMPdxgTtLJt49LDxYFCSvw@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] ioapic: use irq number instead of
 vector in ioapic_eoi_broadcast
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
Cc: Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping, what's the status of this patch.


Li Qiang <liq3ea@163.com> =E4=BA=8E2019=E5=B9=B46=E6=9C=8822=E6=97=A5=E5=91=
=A8=E5=85=AD =E4=B8=8A=E5=8D=888:21=E5=86=99=E9=81=93=EF=BC=9A

> When emulating irqchip in qemu, such as following command:
>
> x86_64-softmmu/qemu-system-x86_64 -m 1024 -smp 4 -hda /home/test/test.img
> -machine kernel-irqchip=3Doff --enable-kvm -vnc :0 -device edu -monitor s=
tdio
>
> We will get a crash with following asan output:
>
> (qemu) /home/test/qemu5/qemu/hw/intc/ioapic.c:266:27: runtime error: inde=
x
> 35 out of bounds for type 'int [24]'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D113504=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addres=
s
> 0x61b000003114 at pc 0x5579e3c7a80f bp 0x7fd004bf8c10 sp 0x7fd004bf8c00
> WRITE of size 4 at 0x61b000003114 thread T4
>     #0 0x5579e3c7a80e in ioapic_eoi_broadcast
> /home/test/qemu5/qemu/hw/intc/ioapic.c:266
>     #1 0x5579e3c6f480 in apic_eoi /home/test/qemu5/qemu/hw/intc/apic.c:42=
8
>     #2 0x5579e3c720a7 in apic_mem_write
> /home/test/qemu5/qemu/hw/intc/apic.c:802
>     #3 0x5579e3b1e31a in memory_region_write_accessor
> /home/test/qemu5/qemu/memory.c:503
>     #4 0x5579e3b1e6a2 in access_with_adjusted_size
> /home/test/qemu5/qemu/memory.c:569
>     #5 0x5579e3b28d77 in memory_region_dispatch_write
> /home/test/qemu5/qemu/memory.c:1497
>     #6 0x5579e3a1b36b in flatview_write_continue
> /home/test/qemu5/qemu/exec.c:3323
>     #7 0x5579e3a1b633 in flatview_write /home/test/qemu5/qemu/exec.c:3362
>     #8 0x5579e3a1bcb1 in address_space_write
> /home/test/qemu5/qemu/exec.c:3452
>     #9 0x5579e3a1bd03 in address_space_rw /home/test/qemu5/qemu/exec.c:34=
63
>     #10 0x5579e3b8b979 in kvm_cpu_exec
> /home/test/qemu5/qemu/accel/kvm/kvm-all.c:2045
>     #11 0x5579e3ae4499 in qemu_kvm_cpu_thread_fn
> /home/test/qemu5/qemu/cpus.c:1287
>     #12 0x5579e4cbdb9f in qemu_thread_start util/qemu-thread-posix.c:502
>     #13 0x7fd0146376da in start_thread
> (/lib/x86_64-linux-gnu/libpthread.so.0+0x76da)
>     #14 0x7fd01436088e in __clone (/lib/x86_64-linux-gnu/libc.so.6+0x1218=
8e
>
> This is because in ioapic_eoi_broadcast function, we uses 'vector' to
> index the 's->irq_eoi'. To fix this, we should uses the irq number.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Change since v1:
> remove auto-generated unnecessary message
>
>  hw/intc/ioapic.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 7074489fdf..711775cc6f 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -245,8 +245,8 @@ void ioapic_eoi_broadcast(int vector)
>              s->ioredtbl[n] =3D entry & ~IOAPIC_LVT_REMOTE_IRR;
>
>              if (!(entry & IOAPIC_LVT_MASKED) && (s->irr & (1 << n))) {
> -                ++s->irq_eoi[vector];
> -                if (s->irq_eoi[vector] >=3D SUCCESSIVE_IRQ_MAX_COUNT) {
> +                ++s->irq_eoi[n];
> +                if (s->irq_eoi[n] >=3D SUCCESSIVE_IRQ_MAX_COUNT) {
>                      /*
>                       * Real hardware does not deliver the interrupt
> immediately
>                       * during eoi broadcast, and this lets a buggy guest
> make
> @@ -254,16 +254,16 @@ void ioapic_eoi_broadcast(int vector)
>                       * level-triggered interrupt. Emulate this behavior
> if we
>                       * detect an interrupt storm.
>                       */
> -                    s->irq_eoi[vector] =3D 0;
> +                    s->irq_eoi[n] =3D 0;
>                      timer_mod_anticipate(s->delayed_ioapic_service_timer=
,
>
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                                           NANOSECONDS_PER_SECOND / 100);
> -                    trace_ioapic_eoi_delayed_reassert(vector);
> +                    trace_ioapic_eoi_delayed_reassert(n);
>                  } else {
>                      ioapic_service(s);
>                  }
>              } else {
> -                s->irq_eoi[vector] =3D 0;
> +                s->irq_eoi[n] =3D 0;
>              }
>          }
>      }
> --
> 2.17.1
>
>
>
