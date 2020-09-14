Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE45C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 21:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43F0208B3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 21:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRNbiPXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43F0208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHvkv-000724-Pr
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 17:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHvjk-0006LY-UJ; Mon, 14 Sep 2020 17:10:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kHvjj-0001qn-0r; Mon, 14 Sep 2020 17:10:08 -0400
Received: by mail-oi1-x244.google.com with SMTP id x69so1373871oia.8;
 Mon, 14 Sep 2020 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=TcHpIKoPDO33ffoJktqBevTPNMjQSBbzECnpS1rtBTI=;
 b=kRNbiPXo5NbkTnC355467wZXGv6qqbbLpDxsFzvjQwvPh5f7BE1GkfCDEpVgx7kPBd
 Q3dfIbKvN2gG7QeDvNOaVbBueiD3wB5jBjE7fyKzF9EfaqHR0RyDU6qvu2QwqtYpWZTO
 zHJTovvIqX3HNpPZyRq48RnWYm1IW5qDyJJezz5OoinofzrKQIcTDXtsr6bV4kWepEeK
 iLyPBBoq+fri3Zt+HvhU1pF8sx9JYs/xP3TS14xrR4H9GuKYqj7Cayi2c7+YGbA1KPMx
 peJWoe8xRNMnIwjMOqNjaIYIqx92Hf1lp74OAKYizbQUupowuwS3IkX5UimnQIat58rG
 qPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=TcHpIKoPDO33ffoJktqBevTPNMjQSBbzECnpS1rtBTI=;
 b=oPMIPhPmuy9lb6MI8VakDt7c8BeSIoG0q/pswrRI6MXly5vd94VVwNHsMPdUF+ZR1h
 SPJjDPX8fHwkufbFtHrk110dgr7nwy3gwtDdRLZgOOI9eKS1UnjsvUxxlNyYmAir69ss
 gg8ghxyMUYOC65MdFrUMkkADs7AY2QmJ72fCgDoK0KPd1IVCR0h2J2oyWFqEdhFaCmAe
 0/jziosDwIMcyiK46CSwZnrwT4WUEeCwJpKV0YY+ZrEksLsN97g4b9Rb66qjSUFGf/QC
 C5dDw1Ak0BuPL8vVwck8YhtZ299TIqpsM/rfxp8YINlLZ4Pd8EZT+jRUv3E2jFbbi+en
 OhTA==
X-Gm-Message-State: AOAM533+LdPJg70h/JLD6vNXLO8PCSTmvyoxunMJMN1QWcP7XFaDKB3d
 ItVtJivNMGj/Z8S+9wl3Y8Q=
X-Google-Smtp-Source: ABdhPJzqSjKb66s5WL6XVcVqrND2zoofNROWnoXtMGrCHeWTx7fC7V5RM/j5egtnrPv5pdAxD5lJuw==
X-Received: by 2002:aca:4b85:: with SMTP id y127mr909032oia.52.1600117804822; 
 Mon, 14 Sep 2020 14:10:04 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g21sm5065205oos.36.2020.09.14.14.10.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Sep 2020 14:10:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Alistair Francis <alistair23@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAKmqyKNvatCfS_gPoxLu-K+6anNjbfP4Ad=MA--3pQQ9h-mBRA@mail.gmail.com>
References: <20200901055822.2721209-1-natechancellor@gmail.com>
 <CAKmqyKNRMmJgmZSPK6wqqNQW41QLHwChPi+1cjqao_x1Q_iryQ@mail.gmail.com>
 <159916712670.15432.11504227918284494914@sif>
 <CAKmqyKMYKiM4Q-geEsNR3Us4vOn_u52omr6h2vcodbsr1hFW2g@mail.gmail.com>
 <159982720259.29065.11121265558750623606@sif>
 <CAKmqyKNvatCfS_gPoxLu-K+6anNjbfP4Ad=MA--3pQQ9h-mBRA@mail.gmail.com>
Message-ID: <160011779946.29065.10046255082586906138@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH] riscv: sifive_test: Allow 16-bit writes to memory region
Date: Mon, 14 Sep 2020 16:09:59 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

Quoting Alistair Francis (2020-09-14 11:07:26)
> On Fri, Sep 11, 2020 at 5:26 AM Michael Roth <mdroth@linux.vnet.ibm.com> =
wrote:
> >
> > Quoting Alistair Francis (2020-09-10 13:10:43)
> > > On Thu, Sep 3, 2020 at 2:05 PM Michael Roth <mdroth@linux.vnet.ibm.co=
m> wrote:
> > > >
> > > > Quoting Alistair Francis (2020-09-01 18:59:29)
> > > > > On Mon, Aug 31, 2020 at 10:59 PM Nathan Chancellor
> > > > > <natechancellor@gmail.com> wrote:
> > > > > >
> > > > > > When shutting down the machine running a mainline Linux kernel,=
 the
> > > > > > following error happens:
> > > > > >
> > > > > > $ build/riscv64-softmmu/qemu-system-riscv64 -bios default -M vi=
rt \
> > > > > >     -display none -initrd rootfs.cpio -kernel Image -m 512m \
> > > > > >     -nodefaults -serial mon:stdio
> > > > > > ...
> > > > > > Requesting system poweroff
> > > > > > [    4.999630] reboot: Power down
> > > > > > sbi_trap_error: hart0: trap handler failed (error -2)
> > > > > > sbi_trap_error: hart0: mcause=3D0x0000000000000007 mtval=3D0x00=
00000000100000
> > > > > > sbi_trap_error: hart0: mepc=3D0x000000008000d4cc mstatus=3D0x00=
00000000001822
> > > > > > sbi_trap_error: hart0: ra=3D0x000000008000999e sp=3D0x000000008=
0015c78
> > > > > > sbi_trap_error: hart0: gp=3D0xffffffe000e76610 tp=3D0xffffffe00=
81b89c0
> > > > > > sbi_trap_error: hart0: s0=3D0x0000000080015c88 s1=3D0x000000000=
0000040
> > > > > > sbi_trap_error: hart0: a0=3D0x0000000000000000 a1=3D0x000000008=
0004024
> > > > > > sbi_trap_error: hart0: a2=3D0x0000000080004024 a3=3D0x000000008=
0004024
> > > > > > sbi_trap_error: hart0: a4=3D0x0000000000100000 a5=3D0x000000000=
0005555
> > > > > > sbi_trap_error: hart0: a6=3D0x0000000000004024 a7=3D0x000000008=
0011158
> > > > > > sbi_trap_error: hart0: s2=3D0x0000000000000000 s3=3D0x000000008=
0016000
> > > > > > sbi_trap_error: hart0: s4=3D0x0000000000000000 s5=3D0x000000000=
0000000
> > > > > > sbi_trap_error: hart0: s6=3D0x0000000000000001 s7=3D0x000000000=
0000000
> > > > > > sbi_trap_error: hart0: s8=3D0x0000000000000000 s9=3D0x000000000=
0000000
> > > > > > sbi_trap_error: hart0: s10=3D0x0000000000000000 s11=3D0x0000000=
000000008
> > > > > > sbi_trap_error: hart0: t0=3D0x0000000000000000 t1=3D0x000000000=
0000000
> > > > > > sbi_trap_error: hart0: t2=3D0x0000000000000000 t3=3D0x000000000=
0000000
> > > > > > sbi_trap_error: hart0: t4=3D0x0000000000000000 t5=3D0x000000000=
0000000
> > > > > > sbi_trap_error: hart0: t6=3D0x0000000000000000
> > > > > >
> > > > > > The kernel does a 16-bit write when powering off the machine, w=
hich
> > > > > > was allowed before commit 5d971f9e67 ("memory: Revert "memory: =
accept
> > > > > > mismatching sizes in memory_region_access_valid""). Make min_ac=
cess_size
> > > > > > match reality so that the machine can shut down properly now.
> > > > > >
> > > > > > Cc: qemu-stable@nongnu.org
> > > > > > Fixes: 88a07990fa ("SiFive RISC-V Test Finisher")
> > > > > > Fixes: 5d971f9e67 ("memory: Revert "memory: accept mismatching =
sizes in memory_region_access_valid"")
> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > >
> > > > > Thanks!
> > > > >
> > > > > Applied to riscv-to-apply.next
> > > >
> > > > FYI, I'm hoping to pull this patch into the upcoming 5.0.1 stable
> > > > release. The freeze is scheduled for 2020-09-20, I will apply this =
if it
> > > > hits master before then.
> > >
> > > I just sent a PR with this patch. Is this still on track to make it i=
nto 5.0.1?
> >
> > Since it's not likely to invalidate any testing on my end outside of the
> > ones built into QEMU I can probably still slip it in if it hits master
> > by Monday, or maybe just grab it from your tree.
> =

> This is in master now, I hope that's enough time to make it in.

Yes I pulled it in yesterday:

  https://github.com/mdroth/qemu/commits/stable-5.0-staging

> =

> Let me know if you want me to do anything else.

Thanks!

> =

> Alistair
> =

> >
> > >
> > > Alistair
> > >
> > > >
> > > > >
> > > > > Alistair
> > > > >
> > > > > > ---
> > > > > >
> > > > > > Please let me know if the tags are wrong or inappropriate, this=
 is my
> > > > > > first QEMU patch.
> > > > > >
> > > > > >  hw/riscv/sifive_test.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
> > > > > > index 0c78fb2c93..8c70dd69df 100644
> > > > > > --- a/hw/riscv/sifive_test.c
> > > > > > +++ b/hw/riscv/sifive_test.c
> > > > > > @@ -59,7 +59,7 @@ static const MemoryRegionOps sifive_test_ops =
=3D {
> > > > > >      .write =3D sifive_test_write,
> > > > > >      .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > > > >      .valid =3D {
> > > > > > -        .min_access_size =3D 4,
> > > > > > +        .min_access_size =3D 2,
> > > > > >          .max_access_size =3D 4
> > > > > >      }
> > > > > >  };
> > > > > >
> > > > > > base-commit: 2f4c51c0f384d7888a04b4815861e6d5fd244d75
> > > > > > --
> > > > > > 2.28.0
> > > > > >
> > > > > >
> > > > >

