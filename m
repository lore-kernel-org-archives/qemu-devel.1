Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0858AC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BFC20665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgFIiROA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BFC20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9wO-00009q-Gh
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45246)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hl9vd-00082r-P2
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hl9vc-0000ex-Fx
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:34:25 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:46799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hl9vc-0000cs-5x
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:34:24 -0400
Received: by mail-qk1-x741.google.com with SMTP id r4so1406310qkm.13
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TA8KfUWPpwMfIHjv+1wev+PVDZCNC1XIvpAX53YemRE=;
 b=JgFIiROABoi6cOgZqiH0H6hNqyFasJ+BsgwBuoUjMrjbe+ehSUShOKhg6Dst6YWVjh
 WJWZsxUoSFR7LscisN1Xh/fs5NuKw6iNf8ZTXaCBfCr9hztOFXcHoAibpSJgxAn2sbmS
 tFxhiydfHwKM27Bnaz3RD4PAufE0gVdE1aMTi8u+mGlSWMaNnGhMo4dWvaP+5yu1Hjmq
 r90C00ueWW+oJngojRKPc/bMKSV1A1CokcuhyWmLYXxY4RFoz03r+RZYyHWP/s9gg4oY
 FS74J6prYb023AYN7t1sD/ps8+YBvmE+/yCxpgl7f0O7YTVter7fR8cZSWZ2lGs6g5LF
 YDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TA8KfUWPpwMfIHjv+1wev+PVDZCNC1XIvpAX53YemRE=;
 b=TBG6Y3Tt1NUy4S0TsGs5ZaxKu2Uh0BKQQQsN71UwXU0KQWpFmp0h2oAz4FhEwDFmA/
 UczQZuji5Is5lShPS1iASMBXWI/ormHrrtpU7NsXIAMx6J2BZlsizu9rE5W4FFr1YusX
 Kg0l0c5yrScS788ZsmfQKc1atyNxknqPs7/t6VOIVoy4rIL1U3f+ojlBKSTxvmLSsy6Y
 UT8QUuXuy6oZCpZSDHRmCUuIKzGI6zmiyJ1vztycK3LPT6lrFe6JGpBPg1edZ3+BEsuK
 IUjrecAokv5OE0oDTYT6oe/J0hiZ+jh2TlJbxWfyTQaRUKuLKIe1LWLeeaSX/peyhd/4
 IzoA==
X-Gm-Message-State: APjAAAUr+UVTH9mvG0zLM2BTYhqt24LtPISG7rKALzXWaqNdkIMaJ4sW
 rLwhXUvlK2WhV+d4xHDlX+8haen3THgm7pG4/mE=
X-Google-Smtp-Source: APXvYqxQ2wiQEk0r0p00X85PgwWuKZf0+gZSXUQxO1sk5jGkV8QJtDet+xBkM6lUpA3Pbv7WBrDrRUr1Mbz+aEc6SVo=
X-Received: by 2002:a37:a854:: with SMTP id r81mr21993345qke.378.1562754862263; 
 Wed, 10 Jul 2019 03:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190709213651.77315-1-mrolnik@gmail.com>
 <20190709213651.77315-7-mrolnik@gmail.com>
 <bf1181ea-0ad3-c6fa-c580-1175daa373ce@redhat.com>
In-Reply-To: <bf1181ea-0ad3-c6fa-c580-1175daa373ce@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 10 Jul 2019 13:33:43 +0300
Message-ID: <CAK4993igbJbbBfH-1zGu_uThHqujm3Caev=+z5t_y34HrUfC0Q@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v25 6/7] target/avr: Add example board
 configuration
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
Cc: Igor Mammedov <imammedo@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe.

My intension was to implement CPU only. I was not interested in modelling
boards, I hoped other people would do it. that's why I stopped two years
ago and did not proceed as there was no interest.
however, it seems there is an interest as Sarah added some peripheral and
fixed some bugs.
I am still not interested in modelling boards, nonetheless, I will support
/ maintain the CPU and whatever other people will add.

Regards,
Michael

On Wed, Jul 10, 2019 at 1:10 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 7/9/19 11:36 PM, Michael Rolnik wrote:
> > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> >
> > A simple board setup that configures an AVR CPU to run a given firmware
> image.
> > This is all that's useful to implement without peripheral emulation as
> AVR CPUs include a lot of on-board peripherals.
>
> Why not model a tiny existing board?
>
> You can mark various pieces of hardware as 'unimplemented'.
>
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
> >  hw/Kconfig           |   1 +
> >  hw/avr/Kconfig       |   4 +
> >  hw/avr/Makefile.objs |   1 +
> >  hw/avr/sample.c      | 217 +++++++++++++++++++++++++++++++++++++++++++
> [...]
>


--=20
Best Regards,
Michael Rolnik
