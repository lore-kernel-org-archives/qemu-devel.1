Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F4CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797A120869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+6lCdd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797A120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS4Yt-0006j8-HP
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 14:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iS4W2-0004Ye-Cj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iS4W0-0008D7-Vm
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:29:22 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iS4W0-0008BG-Nu; Tue, 05 Nov 2019 14:29:20 -0500
Received: by mail-lj1-x244.google.com with SMTP id y23so12305083ljh.10;
 Tue, 05 Nov 2019 11:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jxg899qDRU7+5wIiCCiEm/EhtBxbvyNXrULLpItLwoE=;
 b=r+6lCdd1GeCIfVxcTb7CHNnTXZYz59hprOksMSU29Frgis8VLo3WmnfYqpfK9X/x8M
 1J42d/i04adD8PeVgaoRw+JBY5CNP1I6a8Aeao51HB7+hB84dJSjFq7tz9ZyKjbGIMDs
 b6AM0Uh9+GLfGyDEiq32qPev+16mBmBo0UI1OPayzPj9dmDun1gkTUF5PeN4/KS7Xt1I
 23zGYTPn4kaHjvt/XllgBfW3grMum2nsOFNn+uZ8g1qiZ2rmX+ZPfQ1SLpCkBCWVtki3
 LgDmiNsGfKWxJF0yfyNHchB7boUO/kfbunKMTjxBVeT8f5su8xOuhMjbK30YwyWoTCdO
 h6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jxg899qDRU7+5wIiCCiEm/EhtBxbvyNXrULLpItLwoE=;
 b=edlySrKuMvsqufX+VjL93D/JyKXezmXilQwlTnB6sUEAeooSfY7o9GjfjU0eO0VM5B
 jjG0eP+X4mzdjB+o8E1wo2mxl6JPYAwVnIqQamhp2G2zyP7yvFvughextTsoZ14FMYm8
 VRqfw5c5d0jQBHHh1rm5lZvi0gofAqT1gpIRlBDmNVgQR4QFEZzapQ2ZXLD4XKkRs5mY
 7TBfslbQGTLh8JXtIpLk1G/rUpeDLVCGzJkWNsFXtGzghSVPLwndrtsrt49Yrd3hbGKd
 KL/gDXL8j7ucL4AJ2enGT/XjeDrhkKni7gnHX0FrcTjctdyu2ryTc6sY0DvPj2FeeqCa
 fVUQ==
X-Gm-Message-State: APjAAAWgS+yMQca6u6Dv7nt3fIP24P0+Z4SLMKNuxWtQhv3NIwMz2ceX
 QOTT6e5DNOM/lfTzLn2110tEk4RNgOZ8E4/qEis=
X-Google-Smtp-Source: APXvYqyZF9yo7LCAh0cYRJ7NwQTMwln8LMYAEFTSQnyY7UTU8ZJpTIUKlMa8n8aBeQcr/Ibu7sLnQzOaDYEMGBciyO4=
X-Received: by 2002:a2e:9417:: with SMTP id i23mr12140249ljh.152.1572982159020; 
 Tue, 05 Nov 2019 11:29:19 -0800 (PST)
MIME-Version: 1.0
References: <CAP+75-XUbnCDp-JH6JRnGLqVMxDWTFa9kPHJaZXm3NfCzZUbYg@mail.gmail.com>
 <mhng-90e9ee91-7ee7-488a-8db0-35d39043f2fc@palmer-si-x1c4>
 <CAKmqyKMVvLXbziQ8qFC-VcOq2jv1Qm1pK0upK0c1nuYRELgqxw@mail.gmail.com>
In-Reply-To: <CAKmqyKMVvLXbziQ8qFC-VcOq2jv1Qm1pK0upK0c1nuYRELgqxw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Nov 2019 11:23:39 -0800
Message-ID: <CAKmqyKONh4tZ+DfBk2GVDt+k807ncKyrdL-qb1NnTsbyjztFkQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] opensbi: Upgrade from v0.4 to v0.5
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 29, 2019 at 3:33 AM Alistair Francis <alistair23@gmail.com> wro=
te:
>
> On Mon, Oct 28, 2019 at 5:56 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Sat, 26 Oct 2019 01:46:45 PDT (-0700), philmd@redhat.com wrote:
> > > On Sat, Oct 26, 2019 at 10:45 AM Philippe Mathieu-Daud=C3=A9
> > > <philmd@redhat.com> wrote:
> > >>
> > >> Hi Alistair,
> > >>
> > >> On 10/26/19 1:15 AM, Alistair Francis wrote:
> > >> > This release has:
> > >> >      Lot of critical fixes
> > >> >      Hypervisor extension support
> > >> >      SBI v0.2 base extension support
> > >> >      Debug prints support
> > >> >      Handle traps when doing unpriv load/store
> > >> >      Allow compiling without FP support
> > >> >      Use git describe to generate boot-time banner
> > >> >      Andes AE350 platform support
> > >>
> > >> Do you mind amending the output of 'git shortlog v0.4..v0.5'?
> > >
> > > Err this comment is for Palmer, if Alistair agree (no need to repost)=
.
> >
> > Works for me.  I've included the shortlog as part of the patch on my fo=
r-master
> > branch, unless there's any opposition I'll include this in my next PR.
>
> Sounds good!

Ping! Just want to make sure this makes it into 4.2.

Alistair

>
> Alistair
>
> >
> > >
> > >> >
> > >> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > >> > ---
> > >> > You can get the branch from here if the binaries are causing issue=
s:
> > >> > https://github.com/alistair23/qemu/tree/mainline/alistair/opensbi.=
next
> > >>
> > >> You can use 'git format-patch --no-binary'.
> > >>
> > >> >
> > >> >   pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 36888 -> 4098=
4 bytes
> > >> >   pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 45064 -> 4916=
0 bytes
> > >> >   pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 40968 -> 4506=
4 bytes
> > >> >   roms/opensbi                                 |   2 +-
> > >> >   4 files changed, 1 insertion(+), 1 deletion(-)
> > >> [...]
> > >> > diff --git a/roms/opensbi b/roms/opensbi
> > >> > index ce228ee091..be92da280d 160000
> > >> > --- a/roms/opensbi
> > >> > +++ b/roms/opensbi
> > >> > @@ -1 +1 @@
> > >> > -Subproject commit ce228ee0919deb9957192d723eecc8aaae2697c6
> > >> > +Subproject commit be92da280d87c38a2e0adc5d3f43bab7b5468f09
> > >> >

