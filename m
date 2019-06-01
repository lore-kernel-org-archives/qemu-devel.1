Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AF8C28CC1
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 21:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CC327693
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 21:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbRfUxNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CC327693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41547 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXBWM-0004Gu-Lw
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 17:26:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXBV4-0003G6-Nr
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 17:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXBQs-0002n2-Bl
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 17:20:55 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:46693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hXBQs-0002mX-7N
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 17:20:54 -0400
Received: by mail-qt1-x844.google.com with SMTP id z19so5261010qtz.13
	for <qemu-devel@nongnu.org>; Sat, 01 Jun 2019 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=7FXvEaKBvt1NI2FEjhWewua8v/CE4on3bSW9Zeh1iFE=;
	b=PbRfUxNTJ+syl2kEqfN3ULCDPX7JpJ9nj30RIHG8c+CBwvWucn0bd/dpC6Gmz65FKU
	km8KloMEwjrPTs5OCa1UGB3k7yMDYnjv+7GXc0oZGeG+mPfv29kttZ14CVuByNXzy3vB
	LDDE8UjqbetozGKjEroQByNdnal5zN3Cf8Vu8SMB0akDt8y8t/BnN3VoZcS05+UntK2G
	XmiJ1m7gx1+HXCh1KahUBv4rv/Rg70JJses38MQ0UOHCFaymekKTYF7b3XE9gWdxfED3
	r1eMTlw3LBaHVMCQyrGNh+l7yxDCpX4qRYCCDGXhGruhTNIsqfZowMjBCt/cm9DB41LR
	ryvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7FXvEaKBvt1NI2FEjhWewua8v/CE4on3bSW9Zeh1iFE=;
	b=Nmni+nym2QEIcd3ZQHHpIm/sCYG15tLDm6Pz3CPTb490nNlFsodYtAhFloyopZ+fI0
	LILNjczckIk1aGYOLLYZfMLZwRW6cm71xSbCtr91sPk72s0+PPP5h2YY8qohsjpJY/j6
	EpEjqOiasXL2FnxqnqbDhX5jzkQK723jHJX1il707b2tcBw6jco12cfWy7glPx8rwV1d
	KKab6J1I45q0XPdAZwtuLBurOZ8G6KjUo3iRWHMszjKnZruLuQjBI8pTM8UJ9uX5tkZf
	JNiaNoFfNOW5kVNtU0FPWguj1eqsyV1EaLWLBktmPXblS46oiDClyUXZ+XJGUp66g6h/
	VJqg==
X-Gm-Message-State: APjAAAV9cMtLFtydPqhVW1RqP742Jfos2x8Y6YHi021nvedfcahR7Dk1
	ZuEKpabnwz9nW61L/dkWrHK174kA3j1PIMwwfKg=
X-Google-Smtp-Source: APXvYqyjw/NTsFaYtNJGcRnGUXmyEHFPRDR4YM82C5SYF0HfThj3Q5Gn4tadELNdR2l8g0d9KTDQ5K2fNlmJIfGOX/E=
X-Received: by 2002:ac8:4101:: with SMTP id q1mr12207283qtl.160.1559424052148; 
	Sat, 01 Jun 2019 14:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-9-mrolnik@gmail.com>
	<c501a681-fc9b-1fec-f9bf-190f74c4bb73@redhat.com>
In-Reply-To: <c501a681-fc9b-1fec-f9bf-190f74c4bb73@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sun, 2 Jun 2019 00:20:15 +0300
Message-ID: <CAK4993gA1TTKE74Z++r1d7fpGr6NHqosVCLoKaaVLF-AngynmA@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::844
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH RFC v20 8/8] target/avr: Register AVR
 support with the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric.

please explain what should I do or point to an example or documentation.

On Fri, May 31, 2019 at 5:50 PM Eric Blake <eblake@redhat.com> wrote:

> On 5/30/19 2:07 PM, Michael Rolnik wrote:
> > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> >
> > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
>
> > +++ b/qapi/common.json
> > @@ -187,7 +187,7 @@
> >  # Since: 3.0
> >  ##
> >  { 'enum' : 'SysEmuTarget',
> > -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
> > +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',
> 'lm32',
> >               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
> >               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> >               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>
> Missing documentation that 'avr' is (since 4.1).
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

-- 
Best Regards,
Michael Rolnik
