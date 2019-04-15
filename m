Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79763C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 23:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DC520848
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 23:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmTp+34p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DC520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGBVJ-0000QL-0K
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 19:59:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hGBU3-00088c-TV
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 19:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hGBTy-0003t9-Qp
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 19:57:55 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hGBTy-0003re-H5; Mon, 15 Apr 2019 19:57:50 -0400
Received: by mail-lf1-x141.google.com with SMTP id i68so3551742lfi.10;
	Mon, 15 Apr 2019 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=utp70kpvqVYAgzmbP1/KSHWEj/gyntLc4EKiJ3F1dMY=;
	b=tmTp+34p3fD1XZmlQwOt8RpbUB48npaVbjDtPz/NDerIywJXf/pjmUdw/84Jk0ac0K
	E63vfEDWI6Oo+hWfzTlPteHYyuddmpgDZCgBSMS8ACyLrbMPQ4XBVcat/F5Qotst5ad6
	8S251z5CzwSjYCoDZ9OsIrxeor1BpEFdzZshoB35Jjl0ktvBCCfeQBJdXC2eOngWjKLe
	BQlbjP9W8ovqmYcWTQ57f/wXJDptuUFvN+H0OIGQMN69Pn8uNtDAzmCu+nTxdvmoOTxT
	AWq1/XwqhE7nevOnFCdGJmuB8KEVJw3XQzE3/fYrQ1VM7CU+9cvBlv5lAM3fGJVLO0x+
	qIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=utp70kpvqVYAgzmbP1/KSHWEj/gyntLc4EKiJ3F1dMY=;
	b=U7z/ypinEG6G0i7h5YXZgcvdB99t7Gb8WTqlIHDl8GcHtMwGLShybcw6b0i/NJglnK
	YR+lRizUuYoExkFYmJyMz/49EHJC7n7GGfD9fiUzCLh7ZfBOffS45LwGvTjJeKKsyuoM
	GwcBSxkkR9+6Exi/gEknbB4dSSx8RvbHXgmRBQctGi3gjDc1+MtBOOWgdbSX15J8sojw
	p1FctAOvQE8xoaGKY4Wps13B72MfHU4izaYWQv7F8Q9V8/6XPkIWzzCd3x1ERGpefLxB
	aeqn8ySNFoGIOwHeEeKdYYRxDCrIdlu86DsvppVLnspN8PD9PhGU5zR5MYVnQPfEzDc1
	rMTw==
X-Gm-Message-State: APjAAAWS5RHOdZlkcyMbTf4dp7wmb/1ylKzWtA5DrGZcFHMLUxBVvbFj
	whwwZ6qfcL3sWwLaD54hrQ+bk0ZprlZaf56e3QdihQGZGCU=
X-Google-Smtp-Source: APXvYqxTsXW6Y+VaJ0pL/wd8dD1qKe9Mc5q23rk953OJM7jFGALhlPqFCZ0UzFT9hVwdpOfauGgITTHoyWLNp9KrDIU=
X-Received: by 2002:a19:f512:: with SMTP id j18mr35428968lfb.48.1555372668825; 
	Mon, 15 Apr 2019 16:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
	<20190411141848.119ee969@redhat.com>
	<CAKmqyKOQ9a5Q8c83ufCgQgsa_RdQv01dDFCLFGmiSC8mkTw0LQ@mail.gmail.com>
	<20190412103558.7be8383d@redhat.com>
	<CAKmqyKOFs8Pv4np+BXyVYGRFwLKn9N-H7q=7JN+nBprAjHBYCQ@mail.gmail.com>
	<20190415103815.35f45e99@Igors-MacBook-Pro.local>
In-Reply-To: <20190415103815.35f45e99@Igors-MacBook-Pro.local>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Apr 2019 16:56:08 -0700
Message-ID:
 <CAKmqyKOYif-SVvz3btkx+D9RDCFOmEaQSOR+0y4k18WLtrk3rQ@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 2/6] target/riscv: Fall back to
 generating a RISC-V CPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
	"palmer@sifive.com" <palmer@sifive.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"ijc@hellion.org.uk" <ijc@hellion.org.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415235608.3XFQPN9e5cSN1NbEK7i0WH-n7o-m6Zl6ouBVGANs1Og@z>

On Mon, Apr 15, 2019 at 1:38 AM Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Fri, 12 Apr 2019 14:19:16 -0700
> Alistair Francis <alistair23@gmail.com> wrote:
>

...

> > >
> > > if it's programming error it should be assert
> > > but in general instance_init()  should never fail.
> >
> > We are checking for a user specified CPU string, not a programming
> > error so an assert() isn't correct here.
> >
> > If *init() can't fail how should this be handled?
> typical flow for device object is
>
>  object_new(foo) -> foo_init_fn()
>  set properties on foo
>  set 'realize' property to 'true' -> foo_realize_fn()
>
> all checks should be performed in realize() or during property setting.

I thought there was a reason realise didn't work, but now I can't see
what it is. I can move it to realise.

>
> > > the same applies to errors or warnings within this function.
> > >
> > > > > > +    }
> > > > > > +
> > > > > > +    if (riscv_cpu[0] == 'r' && riscv_cpu[1] == 'v') {
> > > > > > +        /* Starts with "rv" */
> > > > > > +        if (riscv_cpu[2] == '3' && riscv_cpu[3] == '2') {
> > > > > > +            valid = true;
> > > > > > +            rvxlen = RV32;
> > > > > > +        }
> > > > > > +        if (riscv_cpu[2] == '6' && riscv_cpu[3] == '4') {
> > > > > > +            valid = true;
> > > > > > +            rvxlen = RV64;
> > > > > > +        }
> > > > > > +    }
> > > > > > +
> > > > > > +    if (!valid) {
> > > > > > +        error_report("'%s' does not appear to be a valid RISC-V CPU",
> > > > > > +                     riscv_cpu);
> > > > > > +        exit(1);
> > > > > > +    }
> > > > > > +
> > > > > > +    for (i = 4; i < strlen(riscv_cpu); i++) {
> > > > > > +        switch (riscv_cpu[i]) {
> > > > > > +        case 'i':
> > > > > > +            if (target_misa & RVE) {
> > > > > > +                error_report("I and E extensions are incompatible");
> > > > > > +                exit(1);
> > > > > > +            }
> > > > > > +            target_misa |= RVI;
> > > > > > +            continue;
> > > > > > +        case 'e':
> > > > > > +            if (target_misa & RVI) {
> > > > > > +                error_report("I and E extensions are incompatible");
> > > > > > +                exit(1);
> > > > > > +            }
> > > > > > +            target_misa |= RVE;
> > > > > > +            continue;
> > > > > > +        case 'g':
> > > > > > +            target_misa |= RVI | RVM | RVA | RVF | RVD;
> > > > > > +            continue;
> > > > > > +        case 'm':
> > > > > > +            target_misa |= RVM;
> > > > > > +            continue;
> > > > > > +        case 'a':
> > > > > > +            target_misa |= RVA;
> > > > > > +            continue;
> > > > > > +        case 'f':
> > > > > > +            target_misa |= RVF;
> > > > > > +            continue;
> > > > > > +        case 'd':
> > > > > > +            target_misa |= RVD;
> > > > > > +            continue;
> > > > > > +        case 'c':
> > > > > > +            target_misa |= RVC;
> > > > > > +            continue;
> > > > > > +        case 's':
> > > > > > +            target_misa |= RVS;
> > > > > > +            continue;
> > > > > > +        case 'u':
> > > > > > +            target_misa |= RVU;
> > > > > > +            continue;
> > > > > > +        default:
> > > > > > +            warn_report("QEMU does not support the %c extension",
> > > > > > +                        riscv_cpu[i]);
> > > that's what looks to me like fallback, and what makes
> > > CPU features for this CPU type non deterministic.
> >
> > What do you mean? QEMU will always parse the specified CPU string and
> > create a CPU based on the features specified by the user. For each
> > version of QEMU it will always result in the same outcome for the same
> > user supplied command line argument.
>
> I've meant that here you would print warning and happily continue parsing
> user input ignoring input error. One should error out instead and make
> user fix error.

Ah, ok. I can change this one to an error.

>
> >
> > Newer QEMU versions will support more features though, so they will
> > accept different options.
> >
> > > I'm not sure what you are trying to achieve here, but it look like
> > > you are trying to verify MachineClass field in object constructor
> > > along with other things.
> >
> > I'm just trying to parse the -cpu string option.
> >
> > >
> > > I'd put all MachineClass checks in class_init and abort on error
> > > since invalid mcc->isa_str is codding error.
> >
> > No, it's a user error.
>
> Parsing -cpu by assigning to class members user input looks unusual.
>
> We had a custom parsing for x86 & sparc cpus, but that was factored out
> into compat utilities and we shouldn't do it anywhere else without very
> compelling reason.

I did see that, but it didn't seem to work the same way as this.

>
> Currently it's preferred to use canonical form for cpu properties, like:
>
>   -cpu foo,prop1=x,prop2=y,...

Yeah, but I don't see how that would work nicely.

Instead of:
    -cpu rv64gcsu
we would have:
    -cpu rvgen,xlen=64,g=true,c=true,s=true,u=true
which seems more complex for users

>
> and let the generic parser to do the job. For it to work you would need
> to create a property per a cpu feature.
>
> This way it will work fine with -cpu and -device/device_add without any
> custom parsing involved.

Although I think it's messy for users, it is the cleanest
implementation in terms of QOM. Maybe that will be the only solution.

Alistair
...

