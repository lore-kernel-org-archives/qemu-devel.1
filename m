Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F0DC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 19:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B8826B64
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 19:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtH9HzHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B8826B64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXt3D-0005wp-5q
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 15:55:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXt1b-00051H-PQ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXt1a-0005Ce-KL
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:53:43 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:45553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hXt1a-0005AM-FC
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:53:42 -0400
Received: by mail-qk1-x741.google.com with SMTP id s22so1253050qkj.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zdEgs1wJH0i3bBjSBd7DPVOfk8fjwHyXVwJbYdlnyH0=;
	b=BtH9HzHPAmfN/afRSg+c3IxIHQN3eZ6Si+kxSfxGiHGYAG3ohDoySJYme1PKJkQrZ9
	2RiiQGcbP3E1nUu7px8VQa6B6Y5T/qhnzYHKtowUZTzz9adILc+CDZirRWq/xx19WZoL
	0R5vyHB4IDMx3okvGDQ/CEl0xBYawkCxHNCz10/gGOTz5BK6gXHz8ZQ7H126J9eOwrgY
	mu1Vd/FQ+SgPOBS1YikTeTJ5fzVvEji/5gG9n4coEP4rJRw5xiYBQNXvY8QzKNs+7gv4
	UDOyG5Y1oOavUdqQ//ebKyfqy8ZvXKnYLTRI2u+qhOOrGyLgbq25zp0Vfrwa+IwYvZ4V
	FKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=zdEgs1wJH0i3bBjSBd7DPVOfk8fjwHyXVwJbYdlnyH0=;
	b=IkqZ2h273rWkmDrsTmWjYE4+IQpAl7H2NzQR02Mvd1kH74eaEliDvbW/1zmYVlkWWL
	GSPvGH3qgqm973DKepi6j6NYU9l3iqIBGnWXYb5tFqgLRx0RW2lZ67rnEYg8Cx7jEKl2
	ViIlsIfO0Lm6v16msANtHInxH0FC2DwNthcC1Codw/N/CcIE+AZ4dFDookEDIok8Fp7l
	+Q2MBoPxySfPR67MbXcyq38EIuyAyFtl01GyJstC5MTWGDUtxR1TdHMoP/G9DIFeCr4X
	OON0OOmot6l+nr3RPwcjFXuHdPMMjbzubibV3ZFLTJzf+yd/MykOU6yUDJIyYDTwy153
	Ul4w==
X-Gm-Message-State: APjAAAXni1s5bphI7zA9iKgTZ4ywELjEVkwsy90HtKmmp8d3Rq8zLIq4
	ixtxnJOjbjIEQih+QBxm6CP0pNOx7wjwNOBisv8=
X-Google-Smtp-Source: APXvYqwMHeOYNQwEhcbAssgQhtOuUSSbrOgejC/Hy+YX1wjmxQAyQ+l2X3MKu6RBqWPCVcR6v3qtlBXfHa0zxcrn5fg=
X-Received: by 2002:a05:620a:5b1:: with SMTP id
	q17mr22962612qkq.174.1559591621006; 
	Mon, 03 Jun 2019 12:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-9-mrolnik@gmail.com>
	<c501a681-fc9b-1fec-f9bf-190f74c4bb73@redhat.com>
	<CAK4993gA1TTKE74Z++r1d7fpGr6NHqosVCLoKaaVLF-AngynmA@mail.gmail.com>
	<a71efc15-ec01-43b5-42e9-2393ac9450a5@redhat.com>
In-Reply-To: <a71efc15-ec01-43b5-42e9-2393ac9450a5@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 3 Jun 2019 22:53:03 +0300
Message-ID: <CAK4993gPcebFNOUQtC83PXDR7GWcwTfvTtRs0ho3OYGoyi=FWw@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

Thanks!

On Mon, Jun 3, 2019 at 10:47 PM Eric Blake <eblake@redhat.com> wrote:

> On 6/1/19 4:20 PM, Michael Rolnik wrote:
> > Hi Eric.
> >
> > please explain what should I do or point to an example or documentation.
> >
>
> >>>  # Since: 3.0
> >>>  ##
> >>>  { 'enum' : 'SysEmuTarget',
> >>> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386',
> 'lm32',
> >>> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',
> >> 'lm32',
> >>>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
> >>>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> >>>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> >>
> >> Missing documentation that 'avr' is (since 4.1).
>
> Look above a few lines, where it says:
>
> # ppcemb: dropped in 3.1
> #
> # Since: 3.0
> ##
> { 'enum' : 'SysEmuTarget',
>
> You'll add a new line, right after ppcemb, which states
>
> # avr: since 4.1
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
