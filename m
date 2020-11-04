Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8F0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 03:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18E92074F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 03:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nh8b1igv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18E92074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka9aH-0004kP-PM
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 22:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1ka9ZE-0003qt-Aj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 22:34:36 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:45358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1ka9ZC-0002J4-IU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 22:34:36 -0500
Received: by mail-il1-x141.google.com with SMTP id g7so18113826ilr.12
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 19:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5PUSGyVUel6H3b39NCDAmJ/GV/NDx9yc0EfMgBVAats=;
 b=Nh8b1igvADNlyZT4E8oz9eWlNtSxij5GonBUgHpeudzLkt9vaybs9YTEdt7pLkuQ1v
 zJpHVdJweDCUTxP1ItByzVE3fAWWRnqTGzhXLKSnY6Z82GAx571bhPR+gf6kGvOkxiUo
 gh8ZjYk8FcqtkicMhNiM8+OYLEsL0KmweRjoKR0cucWoSvIAgkzbnWoh8QeJPfiXxiB6
 lexNrDxw0mgDnnqjTDj/RdrCYU5Wd89RMiqafExfj0nGRafgZzVbY22Emh6PQ8UpH9Gc
 3RGYuQDgSx4Mt00Bs4YPLKZxUqQijLhweqnfZeCGsMmRrf1nupdMSDVWS5R8U0aSZAaj
 kzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5PUSGyVUel6H3b39NCDAmJ/GV/NDx9yc0EfMgBVAats=;
 b=DR5QZexGEMTS2Uktje9eSpRz1/idhonyjhIsHBREK0ZFk62Vo7GETGXPkRNaYuvzED
 +FZ4aaJzVoGQ2LCX5HfzINhF2L0KzlcUfdbfTzN1MABJTyYvPpkUwg+NegxkIDlebICE
 z5WY4MP6GF+Fa+ljY1/GODgaCRebi+oYg+Rjk4qYF97FZ8gkfgBjEnyvKvapY72GVlMv
 IGLa3u0lsn2uAu9V1iNIOZSd9/TLG14WjjrkTyhBJUYTgJ7EE7gqhEr1Ha/xqjbBaPvH
 KCRuNu7dj+lmPZvE91G14bkgqzrYqcqcE+Ep7EvwH2BHx7JESfP5Xtdu4iYT1QBGslkv
 HKug==
X-Gm-Message-State: AOAM530fYdYmkNCYvhj5ESysOQplCc7j3RBUSTMf6d0uRi2TbHbGyY/J
 LNJdgQBwjkC5Ct9BWT3uMwvtEzpAEGl2xfDnGqA=
X-Google-Smtp-Source: ABdhPJwzfzZaimkfJDjSYuzgGgMkdHEzWeoRO4auIFwkJRkX59rLE25c/0KhPqCNP6fJlp3sFTT2m/X+NBv3zd45byo=
X-Received: by 2002:a92:8e51:: with SMTP id k17mr16682113ilh.270.1604460873500; 
 Tue, 03 Nov 2020 19:34:33 -0800 (PST)
MIME-Version: 1.0
References: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
 <1604053541-27822-2-git-send-email-chenhc@lemote.com>
 <7fdb67f6-edf6-4fe9-6e3b-f2817a3a06f3@amsat.org>
In-Reply-To: <7fdb67f6-edf6-4fe9-6e3b-f2817a3a06f3@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 4 Nov 2020 11:34:21 +0800
Message-ID: <CAAhV-H7QB-TQ0ZtW-tSG-EgBRNTtzZNmFsdg=7CzRWnYEYPv5A@mail.gmail.com>
Subject: Re: [PATCH V16 1/6] target/mips: Fix PageMask with variable page size
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Phillippe,

On Tue, Nov 3, 2020 at 10:53 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 10/30/20 11:25 AM, Huacai Chen wrote:
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >
> > Our current code assumed the target page size is always 4k
> > when handling PageMask and VPN2, however, variable page size
> > was just added to mips target and that's no longer true.
> >
> > Fixes: ee3863b9d414 ("target/mips: Support variable page size")
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >  target/mips/cp0_helper.c | 36 +++++++++++++++++++++++++++++-------
> >  target/mips/cpu.h        |  1 +
> >  2 files changed, 30 insertions(+), 7 deletions(-)
> >
> > diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
> > index 12143ac..d90ddd9 100644
> > --- a/target/mips/cp0_helper.c
> > +++ b/target/mips/cp0_helper.c
> > @@ -892,13 +892,31 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, t=
arget_ulong arg1)
> >
> >  void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pa=
gemask)
> >  {
> > -    uint64_t mask =3D arg1 >> (TARGET_PAGE_BITS + 1);
> > -    if (!(env->insn_flags & ISA_MIPS32R6) || (arg1 =3D=3D ~0) ||
> > -        (mask =3D=3D 0x0000 || mask =3D=3D 0x0003 || mask =3D=3D 0x000=
F ||
> > -         mask =3D=3D 0x003F || mask =3D=3D 0x00FF || mask =3D=3D 0x03F=
F ||
> > -         mask =3D=3D 0x0FFF || mask =3D=3D 0x3FFF || mask =3D=3D 0xFFF=
F)) {
> > -        env->CP0_PageMask =3D arg1 & (0x1FFFFFFF & (TARGET_PAGE_MASK <=
< 1));
> > +    unsigned long mask;
> > +    int maskbits;
> > +
> > +    if (env->insn_flags & ISA_MIPS32R6) {
> > +        return;
> > +    }
> > +    /* Don't care MASKX as we don't support 1KB page */
> > +    mask =3D extract32((uint32_t)arg1, CP0PM_MASK, 16);
> > +    maskbits =3D find_first_zero_bit(&mask, 32);
> > +
> > +    /* Ensure no more set bit after first zero */
> > +    if (mask >> maskbits) {
> > +        goto invalid;
> > +    }
> > +    /* We don't support VTLB entry smaller than target page */
> > +    if ((maskbits + 12) < TARGET_PAGE_BITS) {
> > +        goto invalid;
> >      }
> > +    env->CP0_PageMask =3D mask << CP0PM_MASK;
> > +
> > +    return;
> > +
> > +invalid:
> > +    /* When invalid, set to default target page size. */
> > +    env->CP0_PageMask =3D (~TARGET_PAGE_MASK >> 12) << CP0PM_MASK;
> >  }
>
> I was going to queue this patch for 5.2-rc1, but it fails all
> I6400 tests...
>
>   Linux version 4.7.0-rc1-dirty (root@2e66df87a9ff) (gcc version 6.3.0
> 20170516 (Debian 6.3.0-18) ) #1 SMP Sat Feb 1 18:38:13 UTC 2020
>   GCRs appear to have been moved (expected them at 0x1fbf8000)!
>   earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
>   bootconsole [uart8250] enabled
>   MIPS CPS SMP unable to proceed without a CM
>   CPU0 revision is: 0001a900 (MIPS I6400)
>   FPU revision is: 20f30300
>   MSA revision is: 00000300
>   MIPS: machine is mti,malta
>   Software DMA cache coherency enabled
>   Determined physical RAM map:
>   memory: 0000000008000000 @ 0000000000000000 (usable)
>   Zone ranges:
>   DMA      [mem 0x0000000000000000-0x0000000000ffffff]
>   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>   Normal   empty
>   Movable zone start for each node
>   Early memory node ranges
>   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
>   Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
>   Primary instruction cache 64kB, VIPT, 4-way, linesize 64 bytes.
>   Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 64 bytes
>   percpu: Embedded 5 pages/cpu @980000000107c000 s29664 r8192 d44064 u819=
20
>   Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 81=
63
>   Kernel command line: clocksource=3DGIC console=3Dtty0 console=3DttyS0
>   PID hash table entries: 512 (order: -2, 4096 bytes)
>   Dentry cache hash table entries: 16384 (order: 3, 131072 bytes)
>   Inode-cache hash table entries: 8192 (order: 2, 65536 bytes)
>   Kernel panic - not syncing: MMU doesn't support PAGE_SIZE=3D0x4000
OK, let's investigate it.

Huacai

