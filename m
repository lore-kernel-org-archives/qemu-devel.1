Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423CBC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 22:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EF120825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 22:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD/uBnaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EF120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55701 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO8mD-0002zU-9l
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 18:41:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hO8l6-00029r-AA
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hO8kx-00043Z-Ep
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:40:20 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fintelia@gmail.com>)
	id 1hO8kr-0003d1-Ha; Tue, 07 May 2019 18:40:09 -0400
Received: by mail-lj1-x242.google.com with SMTP id r76so4687721lja.12;
	Tue, 07 May 2019 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=9ED1N8Nz1S22w3WHAYcAXqzBpvu410fa4BfW85S97qQ=;
	b=TD/uBnaFC3IVQ+djwYzCgEQOpywx1LvM+Hkv9Bvg0tjvCapjt/FcGefdIhNdPtst1N
	P+3roNyPSiba9EmPk+NBVipbNnIK/Y0GcZaapxUyaHcufdSu1DVsGZ932G39rIbHqHrx
	F6ksxuidCG6vN2rxvEhWT4pq0lSYPBKj0ohrTnnY6RaxIshcn4zfXfzo/OScX+vEMYCJ
	or6QAW+hGpplGJSxBXaiEPvZG6X09Ce/02xhsWdP/+1dONhq63kKizbEUvU5/9goy4bz
	aUh2cao7q3LGxSo/8+B3Id7kkieKafIMdDLfm5k1HNeHS5PuRocZWo8/hwBGOSxde5Ww
	nQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=9ED1N8Nz1S22w3WHAYcAXqzBpvu410fa4BfW85S97qQ=;
	b=tQLsfTszXp1+cBj4pfdIVCnd3sTzQsq/qFUPdqxAxwbzRgzXLLB96b/ZIfi1x26e5T
	DA4Th58BYnk/YqhWsh4EgqLFJ03DAH1yITN38F8clDzmGuZQZsbVUFUbNW2LbMND4KYo
	X7FKLmBaN6kay9Gqh77RxxWZtWcNDNngDP9m2XUUwfZVaZ2zbAdnlSFnWlFtejA6z+z0
	dFtRENBZad+yZIF9GHFDfqu3jw/IqVvqJPnzhQ3XOEscUXAkAT5/npJzXRn8qmWE7OpP
	IoY1QZnRwbjeNVFqt3Ql2NzdeXedFJrMqdOXb69b3qnamnl25XVL+CmRjh9IflXQgooK
	foTg==
X-Gm-Message-State: APjAAAWxGYFp8IHFKrSoGVQnndTgsVWaoGAODU0G1G+Vpu11ECFw/8dT
	9HDqGJV4fGVJJxmBOZKwHi00FiyngS7KIS5DFeQ=
X-Google-Smtp-Source: APXvYqxTqfddm+WUQHyBIYSNwyRq0VI7H65WvW1jlrov3k6PyJFQpJSUDmsl2dNRvAtCimWUsACOAbWIKgjTeiKMU84=
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr19236826ljh.80.1557268807076; 
	Tue, 07 May 2019 15:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <CANnJOVHd1aFR2tiORJmZ2h3xa+t8djToUEom4WSy=4vBcOjegg@mail.gmail.com>
	<mhng-29822037-900e-4149-aa85-36cbc1db4972@palmer-si-x1e>
In-Reply-To: <mhng-29822037-900e-4149-aa85-36cbc1db4972@palmer-si-x1e>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Tue, 7 May 2019 18:39:40 -0400
Message-ID: <CANnJOVFDXH3PfAX3dJMhUi=ovXrJ953+Zfu2j19eBfKt7vSObQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for 4.1] target/riscv: More accurate
 handling of `sip` CSR
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, I was pasting the output of `git format-patch`. Gmail displays
properly for me, but seems to have hard-wrapped the plaintext version of my
outgoing message to 78 characters. I've tried re-sending from a different
address where I can use `git send-email` directly, please let me know if it
works and I'll resend the other patch the same way. Sorry about this!

Jonathan


On Tue, May 7, 2019 at 1:52 PM Palmer Dabbelt <palmer@sifive.com> wrote:

> On Mon, 06 May 2019 08:52:43 PDT (-0700), fintelia@gmail.com wrote:
> > According to the spec, "All bits besides SSIP, USIP, and UEIP in the sip
> > register are read-only." Further, if an interrupt is not delegated to
> mode
> > x,
> > then "the corresponding bits in xip [...] should appear to be hardwired
> to
> > zero. This patch implements both of those requirements.
> >
> > Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
> > ---
> >  target/riscv/csr.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 1ec1222da1..fff7d834e8 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -246,6 +246,7 @@ static const target_ulong sstatus_v1_9_mask =
> > SSTATUS_SIE | SSTATUS_SPIE |
> >  static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE |
> SSTATUS_SPIE |
> >      SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
> >      SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
> > +static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP |
> > MIP_UEIP;
> >
> >  #if defined(TARGET_RISCV32)
> >  static const char valid_vm_1_09[16] = {
> > @@ -694,8 +695,10 @@ static int write_sbadaddr(CPURISCVState *env, int
> > csrno, target_ulong val)
> >  static int rmw_sip(CPURISCVState *env, int csrno, target_ulong
> *ret_value,
> >                     target_ulong new_value, target_ulong write_mask)
> >  {
> > -    return rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
> > -                   write_mask & env->mideleg);
> > +    int ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
> > +                      write_mask & env->mideleg & sip_writable_mask);
> > +    *ret_value &= env->mideleg;
> > +    return ret;
> >  }
> >
> >  /* Supervisor Protection and Translation */
>
> This patch (and your previous one) don't apply for me.  I don't see the
> git-send-email tags in your messages, are you trying to do something like
> paste
> them into gmail?  If so I think they're getting line wrapped.
>
