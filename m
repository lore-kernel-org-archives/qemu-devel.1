Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9F5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5010F2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="iejepmQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5010F2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKWg-0006Op-HN
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbKVx-0005W1-4b
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:55:49 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:44151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbKVr-0000t0-G7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:55:48 -0400
Received: by mail-ua1-x944.google.com with SMTP id 14so981440uaq.11
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 01:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zryy6+9dKEzQDfkESiOultAmn2/g2ClknF50ZR78TV0=;
 b=iejepmQuRfichY4Q2imu61QJzN1nqaV9qdgSIwacsGHvXIRKb4MtSXM70821aOEwzG
 N9N+GV4NndkF4G1ZoyKfykHB+/9/11LsMW9t3uoW5hDw4xe7T46u93uoSzzDKt06j7f+
 PJhmtyXs1ZmLYpto7SFQTYM9qsnWJ6/g2uLp7FwDwTNKR6tFHEb/4ALIzkF5M/QkilG5
 98f8LPhCWbIhc9E3TvOCfGeRHPsmoVjbJG6dGjVxRVtlCaYkTj1MhAGcYAzyUTE3LGO2
 EFePAn7fMBebO0bXmZXjL65GKASFJPF0iY5nsXsfsuznOWTpYwzTOddupRGrz7F1eJw7
 s4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zryy6+9dKEzQDfkESiOultAmn2/g2ClknF50ZR78TV0=;
 b=TS6s5ST71pnLgpMJGUhkajM+XU4zrtGfOtmy1kvnSkpwkJ0eF+QHR2AoaZmjj38S0c
 0i8QaJyUe4Gj8uDOMhWQo+YONejByKlyjK6+9nlhbxUa6as+tV5HnnE3rVfc9uxZhMWW
 VE9mvL2XH+mk1mPiod5KJuqgwFVX3iyDVggGn/9pbsuyKS/lAvs/Bj+hd6uDecwFsqsk
 FEGPn/pD77ZYPpWK+5hJ7vQw96m/gCMfEi75c//RXE9+nUUNIYPB5G2jg6V/Ft6r2h52
 135WTsx9KBZil8uf69pqQLXLOnVj0aU7xAXEbatnHL6DwAZMs70Gkdq1eQt8pISwy5GD
 Nl6g==
X-Gm-Message-State: AOAM5319vqyJzDxqeW1AuXbFIUTbOQt/iCNvS3/yq8bHzRZzSiIUsjEA
 UO8rWhATX271MUNCwaHMBiig8Nf74zRHcy7d56VQBw==
X-Google-Smtp-Source: ABdhPJxTVZ681jnY+btEH1ahrZ1R2PWKjysEVlE7wq4i7aaF0ygrlSoHT32HBGoMAAlasinKdFlp1UFaFKAWfPTXYqc=
X-Received: by 2002:ab0:2f5:: with SMTP id 108mr2645291uah.122.1589964940141; 
 Wed, 20 May 2020 01:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHckoCymFfuVd=tKV-hk+PHn2fk6ydWjSxwKVorj9Qe5KV6nGQ@mail.gmail.com>
 <CAHckoCzWmN4oedOHMvR_TbbBcbYqSjg1fUr2RjJkh-iuZO-Jng@mail.gmail.com>
 <55b6466c-0769-6652-a237-c6bc18704064@redhat.com>
 <20200514125220.GJ2787@work-vm>
 <CAHckoCyegWG9yH_y6VjHhnghfHJD-Wq+EmOyRZE3EYguTOHfPw@mail.gmail.com>
 <20200514151600.GO2787@work-vm>
 <CAHckoCxc2XTA3ckU0sq-BmbZZFtfAY_GaEOW46XFzfZ2qXjeMQ@mail.gmail.com>
 <20200514153129.GP2787@work-vm>
 <CAHckoCxOjNEAM4DwWtXS9JT_aPsqOtDAzf5zhhiRrDyAmQa00Q@mail.gmail.com>
 <CAHckoCwee+aNHcgRFvReCCz_0J-vLrM5=MPZFpqvQjkefV2MiQ@mail.gmail.com>
 <986fbf33-8127-870b-9163-4aa8d332553f@redhat.com>
 <CAHckoCxw=j8+uXHD3tzQc4vGkRu-_xhcHn8sSeiKaSHw=Bt6mA@mail.gmail.com>
 <7ecfb762-0359-92a4-d8b3-1a9e081ace92@redhat.com>
In-Reply-To: <7ecfb762-0359-92a4-d8b3-1a9e081ace92@redhat.com>
From: Li Feng <fengli@smartx.com>
Date: Wed, 20 May 2020 16:55:29 +0800
Message-ID: <CAHckoCwEt+citc5pQkJxhsWkLuqJa47A98YUYtMHd7epmx0esQ@mail.gmail.com>
Subject: Re: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs'
 failed.
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::944;
 envelope-from=fengli@smartx.com; helo=mail-ua1-x944.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
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
Cc: vkuznets@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 20/05/20 10:22, Li Feng wrote:
> >> - bit 2, vmx-exit-nosave-debugctl
> >> - bit 9, host address space size, is handled automatically by QEMU
> >> - bit 15, vmx-exit-ack-intr
> >> - bit 17, vmx-exit-save-pat
> >> - bit 18, vmx-exit-load-pat
> >> - bit 19, vmx-exit-save-efer
> >> - bit 20, vmx-exit-load-efer
> >> - bit 21, vmx-exit-save-preemption-timer
> >>
> >> Try removing all of these and see if QEMU starts:
> >>
> >> qemu-kvm ... -cpu
> >> host,-vmx-exit-nosave-debugctl,-vmx-exit-ack-intr,-vmx-exit-save-pat,-=
vmx-exit-load-pat,-vmx-exit-save-efer,-vmx-exit-load-efer,-vmx-exit-save-pr=
eemption-timer
> >>
> >> And then add them back one at a time.
> > Hi, Paolo.
> > Thanks, the crash is still here when removing the above features:
> > qemu-system-x86_64: error: failed to set MSR 0x48f to 0x36fff00036dff
> >
> > After computing xor, the result is 0b1000000000.
> > The bit 9 is set.
>
> Are you running KVM with a 32-bit kernel.
>
No, I'm running 64 bit.

$ uname -a
Linux 31_216 5.6.7-1.el7.centos.x86_64 #1 SMP Mon Apr 27 15:26:08 CST
2020 x86_64 x86_64 x86_64 GNU/Linux

$ cat /boot/config-5.6.7-1.el7.centos.x86_64 | grep -i x86_64
# Linux/x86_64 5.6.7-1.el7.centos.x86_64 Kernel Configuration
CONFIG_X86_64=3Dy
CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"

> Paolo
>

