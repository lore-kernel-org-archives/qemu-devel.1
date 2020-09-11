Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C417C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D716221E3
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfZIrPiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D716221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGi9p-0007Vg-CR
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kGi8q-0006UY-75; Fri, 11 Sep 2020 08:27:00 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:34968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kGi8o-0000Hv-5O; Fri, 11 Sep 2020 08:26:59 -0400
Received: by mail-qk1-x744.google.com with SMTP id q5so9668923qkc.2;
 Fri, 11 Sep 2020 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=mrVvgNJ5Qv9NfC9WoOZoBoBc0aElVdGn58duUSk9cX4=;
 b=JfZIrPiHitA2WCuMUp5ThswIXmnZv/t1dWmVmoh787s1Whu3wJFXcAnKCQI89j+8Sn
 13CfOJbp0ODprYaTS1YQtimEP5lteqnODSKPQTNpNPKADv+eVdUVCkCDiXn/6V1YtZ4H
 ZtQxIU37Z3X0QHdLThP/GiwxJkhtOr+It1imHY/Wo5FPtCgBkPiSwgHXRd4W8UZhcuLF
 EB+p5bQAo2TutLQaNxijKvusJ07JoGi09zlgFX3UdVzB4A5yYb93wzP+SJFMb0bwahH1
 Ss/DoQmP3lErcQBPZkaBgIUWc7BWQnbbw75UeyNiCStUe8mRSg6FpCxBx1IKAudSjLaV
 I9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=mrVvgNJ5Qv9NfC9WoOZoBoBc0aElVdGn58duUSk9cX4=;
 b=DUdDP7u11NbzxN7l3efNd6fRkjWJYbjJ8RPNoye5r9+V8UAVdQdGgMB49qdDHIX8Tm
 NH4pbx1yYp8nTltOU59Kzdpj6m/M1v1iJDCO3q3uyNbf24EKNU9kqmKzjYeNfi+IB8P3
 rnjwoso5sURO8WCHNI5eQvcKGPaYrtMwXdzHAzHR8yQ0h4dvIEXaCL5Z2R2vMjWUc3L3
 DJQcDEmPXw7KBVRTiQkxJ7laKnJ2gezvYljYUcq9S0HvNGPOxnvWHbxsR3JV+eVbbNZy
 K+Pzcy1Q762NhxyUWzTp0qM8sVLsOTFTiAZ9vDxtcCVgCpukXeo3gQNp14Y0d6nHm0Ku
 6hQw==
X-Gm-Message-State: AOAM530x+XZPl+Uo68Erk7GwBlWnth+PLJdhIn/reufLOzG75eFGbtk+
 iczGlexKUhCVch/iLk4KZ98=
X-Google-Smtp-Source: ABdhPJx2hk3nOCauUZKC2fK29yW8i9mvTjP2uXvZToUG4Rw4SlTmPdNGN4kOR5NOrTuj4dQNGcUyTg==
X-Received: by 2002:a05:620a:a45:: with SMTP id
 j5mr1271949qka.367.1599827216342; 
 Fri, 11 Sep 2020 05:26:56 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 145sm2729200qkf.18.2020.09.11.05.26.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Sep 2020 05:26:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Alistair Francis <alistair23@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAKmqyKMYKiM4Q-geEsNR3Us4vOn_u52omr6h2vcodbsr1hFW2g@mail.gmail.com>
References: <20200901055822.2721209-1-natechancellor@gmail.com>
 <CAKmqyKNRMmJgmZSPK6wqqNQW41QLHwChPi+1cjqao_x1Q_iryQ@mail.gmail.com>
 <159916712670.15432.11504227918284494914@sif>
 <CAKmqyKMYKiM4Q-geEsNR3Us4vOn_u52omr6h2vcodbsr1hFW2g@mail.gmail.com>
Message-ID: <159982720259.29065.11121265558750623606@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH] riscv: sifive_test: Allow 16-bit writes to memory region
Date: Fri, 11 Sep 2020 07:26:42 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=flukshun@gmail.com; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Alistair Francis (2020-09-10 13:10:43)
> On Thu, Sep 3, 2020 at 2:05 PM Michael Roth <mdroth@linux.vnet.ibm.com> w=
rote:
> >
> > Quoting Alistair Francis (2020-09-01 18:59:29)
> > > On Mon, Aug 31, 2020 at 10:59 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > When shutting down the machine running a mainline Linux kernel, the
> > > > following error happens:
> > > >
> > > > $ build/riscv64-softmmu/qemu-system-riscv64 -bios default -M virt \
> > > >     -display none -initrd rootfs.cpio -kernel Image -m 512m \
> > > >     -nodefaults -serial mon:stdio
> > > > ...
> > > > Requesting system poweroff
> > > > [    4.999630] reboot: Power down
> > > > sbi_trap_error: hart0: trap handler failed (error -2)
> > > > sbi_trap_error: hart0: mcause=3D0x0000000000000007 mtval=3D0x000000=
0000100000
> > > > sbi_trap_error: hart0: mepc=3D0x000000008000d4cc mstatus=3D0x000000=
0000001822
> > > > sbi_trap_error: hart0: ra=3D0x000000008000999e sp=3D0x0000000080015=
c78
> > > > sbi_trap_error: hart0: gp=3D0xffffffe000e76610 tp=3D0xffffffe0081b8=
9c0
> > > > sbi_trap_error: hart0: s0=3D0x0000000080015c88 s1=3D0x0000000000000=
040
> > > > sbi_trap_error: hart0: a0=3D0x0000000000000000 a1=3D0x0000000080004=
024
> > > > sbi_trap_error: hart0: a2=3D0x0000000080004024 a3=3D0x0000000080004=
024
> > > > sbi_trap_error: hart0: a4=3D0x0000000000100000 a5=3D0x0000000000005=
555
> > > > sbi_trap_error: hart0: a6=3D0x0000000000004024 a7=3D0x0000000080011=
158
> > > > sbi_trap_error: hart0: s2=3D0x0000000000000000 s3=3D0x0000000080016=
000
> > > > sbi_trap_error: hart0: s4=3D0x0000000000000000 s5=3D0x0000000000000=
000
> > > > sbi_trap_error: hart0: s6=3D0x0000000000000001 s7=3D0x0000000000000=
000
> > > > sbi_trap_error: hart0: s8=3D0x0000000000000000 s9=3D0x0000000000000=
000
> > > > sbi_trap_error: hart0: s10=3D0x0000000000000000 s11=3D0x00000000000=
00008
> > > > sbi_trap_error: hart0: t0=3D0x0000000000000000 t1=3D0x0000000000000=
000
> > > > sbi_trap_error: hart0: t2=3D0x0000000000000000 t3=3D0x0000000000000=
000
> > > > sbi_trap_error: hart0: t4=3D0x0000000000000000 t5=3D0x0000000000000=
000
> > > > sbi_trap_error: hart0: t6=3D0x0000000000000000
> > > >
> > > > The kernel does a 16-bit write when powering off the machine, which
> > > > was allowed before commit 5d971f9e67 ("memory: Revert "memory: acce=
pt
> > > > mismatching sizes in memory_region_access_valid""). Make min_access=
_size
> > > > match reality so that the machine can shut down properly now.
> > > >
> > > > Cc: qemu-stable@nongnu.org
> > > > Fixes: 88a07990fa ("SiFive RISC-V Test Finisher")
> > > > Fixes: 5d971f9e67 ("memory: Revert "memory: accept mismatching size=
s in memory_region_access_valid"")
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >
> > > Thanks!
> > >
> > > Applied to riscv-to-apply.next
> >
> > FYI, I'm hoping to pull this patch into the upcoming 5.0.1 stable
> > release. The freeze is scheduled for 2020-09-20, I will apply this if it
> > hits master before then.
> =

> I just sent a PR with this patch. Is this still on track to make it into =
5.0.1?

Since it's not likely to invalidate any testing on my end outside of the
ones built into QEMU I can probably still slip it in if it hits master
by Monday, or maybe just grab it from your tree.

> =

> Alistair
> =

> >
> > >
> > > Alistair
> > >
> > > > ---
> > > >
> > > > Please let me know if the tags are wrong or inappropriate, this is =
my
> > > > first QEMU patch.
> > > >
> > > >  hw/riscv/sifive_test.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> > > > index 0c78fb2c93..8c70dd69df 100644
> > > > --- a/hw/riscv/sifive_test.c
> > > > +++ b/hw/riscv/sifive_test.c
> > > > @@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops =3D {
> > > >      .write =3D sifive_test_write,
> > > >      .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > >      .valid =3D {
> > > > -        .min_access_size =3D 4,
> > > > +        .min_access_size =3D 2,
> > > >          .max_access_size =3D 4
> > > >      }
> > > >  };
> > > >
> > > > base-commit: 2f4c51c0f384d7888a04b4815861e6d5fd244d75
> > > > --
> > > > 2.28.0
> > > >
> > > >
> > >

