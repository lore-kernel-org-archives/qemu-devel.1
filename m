Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF4C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 17:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E9620679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 17:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1Qy+6DI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E9620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxaKM-00058f-V9
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 13:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34713)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hxaJy-0004iT-Vf
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 13:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hxaJx-0007Pa-WA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 13:10:54 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hxaJx-0007OT-Ox; Tue, 13 Aug 2019 13:10:53 -0400
Received: by mail-lj1-x242.google.com with SMTP id x4so10113044ljj.6;
 Tue, 13 Aug 2019 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HBrT9PVO+V8KRnuIQ+9cFX4uXYkSelomZsn17W5qN3A=;
 b=q1Qy+6DIfi1ZyBom5q3mnYXXGNAY5oYxb7fpzmGx8LbcjlqxTekUcWwXlNUKGjM7JO
 Tq6tng/meQyII8D6DVLfC23i6aEKWFuJGvzmy0gkao6ylyvg7qAMJp7WMspBuGuOJpw1
 vNCtcxHgjGqoPRNdCCBtMwwENkFDeqN9+fhhlhhLtKk0TgvFpe6mLb2QEIKRT15D6USa
 kuTgTMesQJrtx/jVS2TG9RtxbDgTFSmvfmN0tY0ygivgVlweNMjKC+RpWEPqfq7kh86N
 87b6LPk0pXvciRF9FqGEx8ikh4jdExb9Q1TcK1YTboiuccUs7+X2IFDR/rWAHMQ3QgdQ
 Wiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HBrT9PVO+V8KRnuIQ+9cFX4uXYkSelomZsn17W5qN3A=;
 b=XEnIMsl9D9kWP7kDDLeU8ik3XtBtpZQ7o/cBqRcvpsFp8NW6rVb2BxIjJZWcNdf8zd
 +MUcpUk++syRYCbnlzf7NG52A3jA0ESKyeGqUyQ3SjTJAb/GU16IKCZKyTsjfv+Zkvkz
 bavrlho1gjRC9jsW4N87kvvIAMEnUbZDqkC8PZ3YY4zLJJpORd0T7Z1Z+y4vH4Mv6KVG
 8U8c8mNNDNQTS3wkIQABvD8uRRX66rhvhXk7ELRRLOXLHjBZ9+ImKHig9Mf6bb5Yg30m
 zkfGXpUG7GR481xJ115+nmOEo8bCLjFWkV11AZ6mxd+7A6AVQasKXmK0jgr6Y+zisFO1
 R8Mw==
X-Gm-Message-State: APjAAAVkvIlTKyJdiIT+D8RUct3ewCLa+XLFlvFRFlL00Bu5+JDC6Gi1
 uxR3Jn5iHdnhCLHAvU4M++x+ToMG2O4WBO5kfs0=
X-Google-Smtp-Source: APXvYqyGwDt030AJ2jiSpS2drMwpqkR7kNzXq1nEhvFNSKdvLY/+IXrvzVDl7KVWvZ2bzUL9V+hm3wPC9n2b77mBgs8=
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr5402580ljr.119.1565716252228; 
 Tue, 13 Aug 2019 10:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <4dad98dcc3b6a3f3a5097922494b0521c60570c7.1564529681.git.alistair.francis@wdc.com>
 <mhng-41c1b372-8997-4180-b5d1-61625070690b@palmer-si-x1e>
In-Reply-To: <mhng-41c1b372-8997-4180-b5d1-61625070690b@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Aug 2019 10:06:58 -0700
Message-ID: <CAKmqyKOikOJCp0d7ivt2tvd9P56xGZKEh_OrGBf4qo0hQOidJA@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH-4.2 v2 5/5] target/riscv: Fix Floating
 Point register names
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 12, 2019 at 4:08 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 30 Jul 2019 16:35:34 PDT (-0700), Alistair Francis wrote:
> > From: Atish Patra <atish.patra@wdc.com>
> >
> > As per the RISC-V spec, Floating Point registers are named as f0..f31
> > so lets fix the register names accordingly.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index f8d07bd20a..af1e9b7690 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -40,10 +40,10 @@ const char * const riscv_int_regnames[] = {
> >  };
> >
> >  const char * const riscv_fpr_regnames[] = {
> > -  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
> > -  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
> > -  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
> > -  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
> > +  "f0", "f1", "f2",  "f3",  "f4", "f5", "f6", "f7",
> > +  "f8", "f9", "f10",  "f11",  "f12", "f13", "f14", "f15",
> > +  "f16", "f17", "f18",  "f19",  "f20", "f21", "f22", "f23",
> > +  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31"
> >  };
> >
> >  const char * const riscv_excp_names[] = {
>
> I actually don't think this one is right: riscv_int_regnames uses the ABI
> names, so this should match.  I'd be OK switching both of them, but not just
> one.

I like that the int registers use the ABI names though, as I find that useful.

What about we change the registers to use both? As in something like
x0/zero for all registers?

The disadvantage is that it's a little longer, but it seems the most useful.

Alistair

>
> I've queued the other four patches.

