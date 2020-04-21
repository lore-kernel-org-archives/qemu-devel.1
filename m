Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF01C38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 02:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE632082E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 02:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns74c72+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE632082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQiW2-0007Qh-VP
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 22:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jQiTf-0005fH-LG
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 22:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jQiTf-0001RF-5H
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 22:17:35 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:40117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jQiTe-0001PJ-ME; Mon, 20 Apr 2020 22:17:34 -0400
Received: by mail-yb1-xb42.google.com with SMTP id f13so6545859ybk.7;
 Mon, 20 Apr 2020 19:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jWkvOyr+88HiawW1j5ogbGmOOThFB0bPD5WehBJ7sS8=;
 b=Ns74c72+BKJNSb5tyXfWE3rmoIJgJMw5RlaIcdMcc4pVf/NgCuEPtHqXk0DFilIMes
 bdNLk6EPtblyfUHpMazkMddxVjRIx6BFssu2XduL3iq9a3+5u00mAUi07YXJCuVp4kOZ
 0wswbGKD+ixWjGB13eI21EfnpD2Jr6TqTI5wagDWH3ZFQ5fK24M4NbTXPyEvOnq8+txb
 qIqIadq3XlBgsDrYEKWP+EKh9pflo6Uy2felLyfuBVNBKbi3fLmiTrizMlxtiPKLBePv
 SUHQNZF8ps9LjaHtKd9mNtdjR/MMx3xCrmTmdmMU5xz0ikiT76gHKBG4y3sMerKfmVNu
 ZOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jWkvOyr+88HiawW1j5ogbGmOOThFB0bPD5WehBJ7sS8=;
 b=Dwi1hRQAG7h7Q67JzC9ixkMaLbWcdlvFArC07hf+2IWroxHOWNmFywn9V39aaemkD7
 pB3nmPmp3cFmk8V2lLHoqf18d6vFs403ybJ1H6CPv6QTSCauo7I8pPCERWd0WGahqwVj
 a30q1W+JEQm5df4qkWL3qePehxQ7QKPPMtRGzRJC7v7w0vyA5SgIKcGrHiYwgv3UQpig
 Yvv33gy89CcpI0B5BwntyLcPEwiJtMDNhHPKaI9XoROIo0tlNR19WjhX4qBLfpUeZG+N
 KxoDvS+s5eowj1SkVYlJgSUJs/mPbk6x1qIk+1Pp1Ou4kBvV3FIzBkn5oJ494K5dKUUA
 cJeA==
X-Gm-Message-State: AGi0PuZ7rNeJK1wJM7zMsO5xX134nYDh7VX3bmas6rEnH/G/ULH5xCst
 2U5cd7XDM/epypf+q0rFuYxUmaiBglRp4jjyogQ=
X-Google-Smtp-Source: APiQypI09h2gIcJoiM0Q9W320UQOP5OpXI9kvlbc7pSBZM0FlSuwI4t1piXI61tYEWADY94mJQEn7xY8he9x648lXwI=
X-Received: by 2002:a25:734c:: with SMTP id o73mr22665604ybc.11.1587435453253; 
 Mon, 20 Apr 2020 19:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583530528.git.alistair.francis@wdc.com>
 <CAEUhbmUHNLYoJutr3dg0hpEPehuzRD4r6eux1EStZxCknMst0w@mail.gmail.com>
 <CAEUhbmWEEBJ67R=kktq=93a2h_ROA0C45Baj+Za73jg251W=WQ@mail.gmail.com>
 <CAKmqyKNegLq5NG+qr_ayZc-_ks5cddZ1mGGWSPCEQ8tgSkOXTg@mail.gmail.com>
In-Reply-To: <CAKmqyKNegLq5NG+qr_ayZc-_ks5cddZ1mGGWSPCEQ8tgSkOXTg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 21 Apr 2020 10:17:23 +0800
Message-ID: <CAEUhbmW0u9-qOR_WyobeodLJ0jqEChSQNfrJ-ckT+up_fzgCMw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] hw/riscv: Add a serial property to sifive_u
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::b42
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 3:26 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Apr 1, 2020 at 10:39 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Tue, Mar 24, 2020 at 10:08 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Palmer,
> > >
> > > On Sat, Mar 7, 2020 at 5:45 AM Alistair Francis
> > > <alistair.francis@wdc.com> wrote:
> > > >
> > > > At present the board serial number is hard-coded to 1, and passed
> > > > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > > > the serial number to generate a unique MAC address for the on-chip
> > > > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > > > created and connected to the same subnet, they all have the same
> > > > MAC address hence it creates a unusable network.
> > > >
> > > > A new "serial" property is introduced to specify the board serial
> > > > number. When not given, the default serial number 1 is used.
> > > >
> > >
> > > Could you please take this for v5.0.0?
>
> Applied to the RISC-V tree for 5.1
>

Sigh, this patch was submitted on Mar 7 and that is before soft freeze ...

Any chance to get this in 5.0?

Regards,
Bin

