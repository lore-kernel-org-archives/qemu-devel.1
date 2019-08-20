Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE680C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8466206DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJXPQmQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8466206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i01c9-0002qw-SL
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 06:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i01b9-0002Q5-IJ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i01b8-0001D4-7l
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:42:43 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:37003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i01b8-0001Cq-2Y
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:42:42 -0400
Received: by mail-ot1-x32a.google.com with SMTP id f17so4581413otq.4
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o+dZr3TVFUqXFFGIcNV0HWZkdCG0GTXVVPMEtlCWgH0=;
 b=bJXPQmQ/DFq5DfvKZ5KLB5jqaH0wSQMmi04Wx+ZMcCtxhepD4b0atajKe1HctZRmPN
 Let7IRmsAQSto1ruyRPOk3xX+2QzTqLYq5cfjS32wDuOVcPUf2SwWjDgNuxZJagBegEM
 0MdW68Coti0AvYFDhsFp4NeHIHhGJRJeVkDkF7OwKLalXOCTodSY9reQvzhNk3OIvHOH
 22mPwK5dalfSDIwbRzdTK468CFyaFuVxJoyWyNN6qRHK8u4FuE0aKUABqFeX310AHq4l
 BY8lJHAdydK0bE0O8FSh1lo8qtqd8nhVGBC99FTLngO4v/SIYACnNmFT1gTzVyhk9Gnt
 8ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o+dZr3TVFUqXFFGIcNV0HWZkdCG0GTXVVPMEtlCWgH0=;
 b=t3DLj3SZMLSU9aVmN6elRsMt687q2CUp8im/5iw9zaQt1ON2I+yOkroATvNWIL4fwa
 Gy2nOmCFHKLSqv7jlItxmtSjZ9ry0pq05E4/7oULUAqQT1G6+XajLp9jQlfCYzFaAF1R
 TPlwUETCg/bwO2VNlmJ4QrgnUzaJCBCeMTx3pugjy63qNzu5ry3CoCho2cfwYl4estQ9
 jLK5uUSgKwfxpcUxTYHpyBz545W5KCYsv9HB1wf/BGifRB8QjGRc5/hIHzIfy9YptE17
 PXxSn28QhXH2bvx6Or5PZMSI/vxSB/FXjt10hfCto5+3kfOefasTf4xJcejLtG3wYt18
 oBHA==
X-Gm-Message-State: APjAAAU4CtkxvbX4LKhmWIoLb0+aSquZmVWzBxLkun2Yr1idytPLHBFY
 SCizWxJ4Iexyr/K865ze82FbO20y2qkjJ3yZbWc=
X-Google-Smtp-Source: APXvYqydn+FCfBAhq2bS8+IJyw6aB1A6jS0JA9hJaT37HAIzjhkgUboKDeS2jI4y21Vg1CU7uHM23NtIsrHZ+ucIID4=
X-Received: by 2002:a9d:1288:: with SMTP id g8mr19069388otg.306.1566297761263; 
 Tue, 20 Aug 2019 03:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
In-Reply-To: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 20 Aug 2019 12:42:30 +0200
Message-ID: <CAL1e-=ioA+JrQEsS2x=ASCzbyk79f6UrUPYnSZrQ322AEGyy5Q@mail.gmail.com>
To: =?UTF-8?B?56uL?= <zhlb29@foxmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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

On Tue, Aug 20, 2019 at 12:12 PM =E7=AB=8B <zhlb29@foxmail.com> wrote:

> I am working on a project that requires me to modify the ISA of the MIPS
> target. I have been staring at the source code for about a week, but foun=
d
> it really difficult due to me being a young rookie and the sparse comment=
s.
> Specifically, I need to extend MIPS, by adding some new instructions and
> new CPU registers to the current architecture, and that sounds really eas=
y.
> I think the place for me to look at should be at the directory
> ${qemu_root}/target/mips/. With a MIPS Instruction Set Manual Release 6
> handy, I have difficulty finding the source code where the ISA resides. I=
s
> it in op_helper.c? Or translate.c? Any guidance would be really
> appreciated. Thank you very much in advance.
>
>
Let's say you want to add a new instruction to an ISA.

First, you need to define the layout of the binary code for that
instruction. This means some of the bits would determine registers that
contain input and output values for that instruction, and some of the bits
would be the ID (or, some would say, opcode) for that instruction. Perhaps
some other stuff to can be included here.

Once you settle the binary layout, you need to properly decode that
instruction, in one of many switch statements in translate.c.

After that, the main body of your work begin, You need to implement the
functionality you desire. There are two ways. If your functionality is
simple, as a rule, you would implement it using so called TCG (this is
just-in-time compiler inside QEMU). If your functionality is more complex,
you would implement it using C-functions called helpers. Those helpers
usually reside in op_helper.c, while TCG implementation usually reside
within translate.c.

After all this, you need to write a test program (that would be a little
tricky, since your new instruction will not be recognized by the compiler),
and execute it using QEMU.

I wish you an interesting journey into emulation!

Yours,
Aleksandar







>
> Cheers,
> L.
