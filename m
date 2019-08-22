Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706A8C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351D521726
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz2j4KV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351D521726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40569 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kjw-0001bH-88
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0kiW-00080t-VE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i0kiV-00046x-D0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:20 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:39433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i0kiV-00045r-6l
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:53:19 -0400
Received: by mail-ot1-x32b.google.com with SMTP id b1so5027184otp.6
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1wlg6KQ9BPa72AXxau39YdE2JqQKxGIR6IITqaCDJHs=;
 b=Fz2j4KV3cs8nX2FNEeEnbmDsHYZgxQuMgtHjrVI2YkeghjDX+H4xWrn9ixpxEQZ90A
 /4HmSCITDJNQlqh8YnSMohPXs67PNSaDUjgPbpwR21/U2pbH/Xq+OxQwVCDUWnwZQ9Uj
 0tOQvmaFzzrTPyVf9zhu6URm1JunzhRU3vSTgf2mWy0Emp/fEy0oK4wKTWw8RZG7ksr1
 loOJNB3uwwYIPajV4gp1khd8lA5vW+4LPywnB3J2m49JJ9ttZSBPYdq4ARgMJQd2XSFx
 9XXMbOIgfmvPSgkl2wiz3kT7Uea0z3n3sPHRqCGAyW7KYz0WV0L4mptMW5gaXzWt9Dgs
 mT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1wlg6KQ9BPa72AXxau39YdE2JqQKxGIR6IITqaCDJHs=;
 b=EUXuVZ6iRv4Jf2lj51icj9KLxYji+VsP5ftGkw5PXeHAqQmkL3+UZJ/xNxSy+ZiT1v
 boxiGILjS9p5ZxQz9m6MgGfu2Zxe6vAXPzq6EDIK+c+5t6pqY8o9kGihKyRnOiHIyk/f
 B/uogwunqGJMdIDs6l3JdpqyG+zVhtQRKbljsodY2kwuW4CWFP3AFirn1iXkhmqszcou
 PDNoHGSsNPuovFeYF94bvD9QTnYwQfNBzRUyEXZ+GjdU+G+QSfFbXPz6ixlKIZnRNGnc
 BVyAAWMMqU+R4bGSCaS3hN5yZZI1WaUTYOOUG/lWxFyroyiQ/MWu2ph1vxTfxuUUQHPb
 R0Cg==
X-Gm-Message-State: APjAAAXhtZ3xiFohgiPfyvR0BAQjpeYx4JzIyhLwIC6J0EnWXAMKJVni
 hSLEXJa6BsPtojftBf0S8SReDFlnC1uBT6G5mMU=
X-Google-Smtp-Source: APXvYqxQeg1d+/6/GPx/dLl0LJa4H5j9tX4p77HgneYUbq/OGDD0O99/m6EzmHU8asjjJcRShi2f14pJKM/JW7mLX+s=
X-Received: by 2002:a05:6830:15cc:: with SMTP id
 j12mr29332179otr.64.1566471197122; 
 Thu, 22 Aug 2019 03:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
 <CAL1e-=jUNzu19BBhFq0M_hjxi6BSgfmZUgQMygszTTonORVNmg@mail.gmail.com>
 <tencent_6386EC2F24D7A13D2B753FCF@qq.com>
In-Reply-To: <tencent_6386EC2F24D7A13D2B753FCF@qq.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 22 Aug 2019 12:53:06 +0200
Message-ID: <CAL1e-=gtL6AxsRYPTO5bztH_F-gJDXixEEif3QRKQYo7d4XcUA@mail.gmail.com>
To: =?UTF-8?B?56uL?= <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 12:24 PM =E7=AB=8B <zhlb29@foxmail.com> wrote:

> Hi Aleksandar,
>
> Thank you very much for your patient explanation in the previous post. An=
d
> thank you for checking.
> Your and Peter's replies in the previous post certainly helped a lot. I a=
m
> now looking at a git commit 7 years ago (
> bd277fa1966bc400f1b411f868f39125cda0c403), it was a Loongson Multimedia
> Instruction implementation done my Richard Henderson.
>

Cool, that commit is a very good staring point - it is definitely not too
simple, and it is not too complex either. And you can discover several
different concepts in the process of exploring the change.

Documentation on instruction set extension related to the commit (found by
Google):
https://files.somniafabularum.com/loongson/docs/Loongson2FUserGuide.pdf

Be persistent, take your time, study the details and handling of individual
instructions, and, of course, let us know if you encounter some major
obstacles or thorny dilemmas.

Yours,
Aleksandar


> I think what he did is exactly what I want to do now. I got a vague view
> of the big picture, but I need more time to figure out the details. I wil=
l
> certainly ask more questions about this later, but before that I need to
> look at some other parts of the source code:) Again thank you for checkin=
g!
>
> Cheers,
> Libo
>
>
> ------------------ Original message ------------------
> *From:* "Aleksandar Markovic";
> *Sendtime:* Thursday, Aug 22, 2019 4:23 PM
> *To:* "=E7=AB=8B";
> *Cc:* "qemu-devel";
> *Subject:* Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
>
> On Tue, Aug 20, 2019 at 12:12 PM =E7=AB=8B <zhlb29@foxmail.com> wrote:
>
> > I am working on a project that requires me to modify the ISA of the MIP=
S
> > target.
>
>
> L.,
>
> How is it going?
>
> Aleksandar
>
>
>
> > I have been staring at the source code for about a week, but found it
> > really difficult due to me being a young rookie and the sparse comments=
.
> > Specifically, I need to extend MIPS, by adding some new instructions an=
d
> > new CPU registers to the current architecture, and that sounds really
> easy.
> > I think the place for me to look at should be at the directory
> > ${qemu_root}/target/mips/. With a MIPS Instruction Set Manual Release 6
> > handy, I have difficulty finding the source code where the ISA resides.
> Is
> > it in op_helper.c? Or translate.c? Any guidance would be really
> > appreciated. Thank you very much in advance.
> >
> >
> > Cheers,
> > L.
>
