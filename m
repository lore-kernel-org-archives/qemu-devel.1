Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D81C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1F520678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG7ImM2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1F520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxJR-0000tN-WD
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwQN-0003iu-Q5; Thu, 03 Sep 2020 17:05:39 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwQL-0008NQ-Is; Thu, 03 Sep 2020 17:05:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id i17so4511016oig.10;
 Thu, 03 Sep 2020 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=bMJNqiDHdknljJquNb2m0jVP2VmgDAr1mvv+CHjwIEw=;
 b=mG7ImM2DW7zXAIVgUmhfG8qyF4GCL4ktcVafMZ8kY6bzTGaG7dhVdcaEFNBts/C1PU
 7xI/dcQhMO2UoMRbFKueyk8pkEANIgS/U6EaCG5NNzkGGO9RrCiw2hXIzhb896lwnbq/
 rLIA5i1DPLJZrSyh4C97Ne2XB0agbO9no50Pq32e1ZQoZfRqAg+ASP3t79FiQEVHTFTQ
 iVggugL1GtFIk4IhVop8IDL82kTuCKdtnAsgLsMgKxKMbfyESG4auH7xlniluNKQPst6
 u3SSJZD6z71URisDKEPw9cSa+A0n90hUcX8B3XzoMBcyN81q3KM9HxX7ipJ6ABetDktt
 aKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=bMJNqiDHdknljJquNb2m0jVP2VmgDAr1mvv+CHjwIEw=;
 b=WqYzd/iqfNVZD9JbtZvWVuok9FB4YJDbHRlBNTtyFrEAwhCD7ABzGXiXfjpvF2Dtpx
 3QO/n3Bu2t3fhlFrNIIBU9G2e34LijdimL76GK77gQOeXGpL2nlWb/2zNj940bBAb/de
 bZ+z6cyGmboMjz3EKaym5qjqAg+q4ToXv/BA4IW5orsT02JbEa755QbG9dzSVTGp3XFj
 9Ofo1CPN7LeK4WnWs7uJhqYJXZi4dbOAAn2EBVHO3frkxBxurF8x8Yu+cApRR0KoytEO
 Bv4tu41Q4+2W3coSV4WdfArQjrvDinjU37G1nhvZ+ngt+yFiPHPSYMF/kajTjO3KcTdZ
 lFwA==
X-Gm-Message-State: AOAM532avqrQnrErQfQ/AcWPcGF05e1BuBMnCtYwsGrpql81HwOmRvPh
 KXkLdtdty2zOJEHfYs5kWtI=
X-Google-Smtp-Source: ABdhPJy/jC45YHnEbU3Hlpx+459cA93LqgJnvpGNbJoHNQM0i+CE3PDZ5PkRlirWHRfdSGRUkGKLqw==
X-Received: by 2002:a05:6808:60f:: with SMTP id
 y15mr3371060oih.137.1599167135372; 
 Thu, 03 Sep 2020 14:05:35 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id r21sm722901oie.15.2020.09.03.14.05.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:05:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Alistair Francis <alistair23@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAKmqyKNRMmJgmZSPK6wqqNQW41QLHwChPi+1cjqao_x1Q_iryQ@mail.gmail.com>
References: <20200901055822.2721209-1-natechancellor@gmail.com>
 <CAKmqyKNRMmJgmZSPK6wqqNQW41QLHwChPi+1cjqao_x1Q_iryQ@mail.gmail.com>
Message-ID: <159916712670.15432.11504227918284494914@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH] riscv: sifive_test: Allow 16-bit writes to memory region
Date: Thu, 03 Sep 2020 16:05:26 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Alistair Francis (2020-09-01 18:59:29)
> On Mon, Aug 31, 2020 at 10:59 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > When shutting down the machine running a mainline Linux kernel, the
> > following error happens:
> >
> > $ build/riscv64-softmmu/qemu-system-riscv64 -bios default -M virt \
> >     -display none -initrd rootfs.cpio -kernel Image -m 512m \
> >     -nodefaults -serial mon:stdio
> > ...
> > Requesting system poweroff
> > [    4.999630] reboot: Power down
> > sbi_trap_error: hart0: trap handler failed (error -2)
> > sbi_trap_error: hart0: mcause=3D0x0000000000000007 mtval=3D0x0000000000=
100000
> > sbi_trap_error: hart0: mepc=3D0x000000008000d4cc mstatus=3D0x0000000000=
001822
> > sbi_trap_error: hart0: ra=3D0x000000008000999e sp=3D0x0000000080015c78
> > sbi_trap_error: hart0: gp=3D0xffffffe000e76610 tp=3D0xffffffe0081b89c0
> > sbi_trap_error: hart0: s0=3D0x0000000080015c88 s1=3D0x0000000000000040
> > sbi_trap_error: hart0: a0=3D0x0000000000000000 a1=3D0x0000000080004024
> > sbi_trap_error: hart0: a2=3D0x0000000080004024 a3=3D0x0000000080004024
> > sbi_trap_error: hart0: a4=3D0x0000000000100000 a5=3D0x0000000000005555
> > sbi_trap_error: hart0: a6=3D0x0000000000004024 a7=3D0x0000000080011158
> > sbi_trap_error: hart0: s2=3D0x0000000000000000 s3=3D0x0000000080016000
> > sbi_trap_error: hart0: s4=3D0x0000000000000000 s5=3D0x0000000000000000
> > sbi_trap_error: hart0: s6=3D0x0000000000000001 s7=3D0x0000000000000000
> > sbi_trap_error: hart0: s8=3D0x0000000000000000 s9=3D0x0000000000000000
> > sbi_trap_error: hart0: s10=3D0x0000000000000000 s11=3D0x0000000000000008
> > sbi_trap_error: hart0: t0=3D0x0000000000000000 t1=3D0x0000000000000000
> > sbi_trap_error: hart0: t2=3D0x0000000000000000 t3=3D0x0000000000000000
> > sbi_trap_error: hart0: t4=3D0x0000000000000000 t5=3D0x0000000000000000
> > sbi_trap_error: hart0: t6=3D0x0000000000000000
> >
> > The kernel does a 16-bit write when powering off the machine, which
> > was allowed before commit 5d971f9e67 ("memory: Revert "memory: accept
> > mismatching sizes in memory_region_access_valid""). Make min_access_size
> > match reality so that the machine can shut down properly now.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 88a07990fa ("SiFive RISC-V Test Finisher")
> > Fixes: 5d971f9e67 ("memory: Revert "memory: accept mismatching sizes in=
 memory_region_access_valid"")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> =

> Thanks!
> =

> Applied to riscv-to-apply.next

FYI, I'm hoping to pull this patch into the upcoming 5.0.1 stable
release. The freeze is scheduled for 2020-09-20, I will apply this if it
hits master before then.

> =

> Alistair
> =

> > ---
> >
> > Please let me know if the tags are wrong or inappropriate, this is my
> > first QEMU patch.
> >
> >  hw/riscv/sifive_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> > index 0c78fb2c93..8c70dd69df 100644
> > --- a/hw/riscv/sifive_test.c
> > +++ b/hw/riscv/sifive_test.c
> > @@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops =3D {
> >      .write =3D sifive_test_write,
> >      .endianness =3D DEVICE_NATIVE_ENDIAN,
> >      .valid =3D {
> > -        .min_access_size =3D 4,
> > +        .min_access_size =3D 2,
> >          .max_access_size =3D 4
> >      }
> >  };
> >
> > base-commit: 2f4c51c0f384d7888a04b4815861e6d5fd244d75
> > --
> > 2.28.0
> >
> >
>=20

