Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340F3C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02365256E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHcNzfSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02365256E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50521 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWI5y-00021j-A5
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:15:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWI5F-0001kd-VY
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWI5E-0005VZ-T7
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:14:53 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWI5E-0005UK-KB
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:14:52 -0400
Received: by mail-ot1-x342.google.com with SMTP id i2so4093486otr.9
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QO6xCY5pb9riuLl9pTYYhKz65ABsdYR5nMPHpztGpCk=;
	b=fHcNzfSy6G8lzvdkAyfVr+f+FrsELfz9xj/VpbZZF8go1x36b55nSc5DQs8Uu315FU
	IObTl6G7Kvi9ZjUxUyUM64POtNltJGUmIZrd+4cAQv6lrx7e7NTEFKS03UXqC182MOmu
	bdXwwOO/qMET1vfZS8JM9clWDtQ+plHbzF9gtzySK/TjNlmnyC/bzmG7fIDlNe8WKOxl
	P8WLiFUA/SQJqhVU+V1NteYqpsP0S0Ai0MW5NIhtkLLh8HUTm263V1AnMOqpEXAc5+HB
	y/KnBJIdhCvgWpSkdz+ZWfhQlAt9u2lMcJzJ0PneriZUfotXFDPn6C1kZtYJi5P32cCM
	ZngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QO6xCY5pb9riuLl9pTYYhKz65ABsdYR5nMPHpztGpCk=;
	b=TIbxjHsIZ+JjzvsukiBer7Y1QNZrtKqdWYrsas1O3AjGoGTdKdjOWqiT1MoE2D437T
	X/OJCiwckGy3w/q/CUdw5EudI77+DoyGuCxgnw3prGgXGqlwu9TeB0QYuuU+EYtVbVqw
	ZIhNH/76v7j9tMXWPpVUMw2tKgCOQjqJ0xhVTNnR5X9c3wXaMcEeW58aH5X05s9H//YC
	EF2x8w30ZEnspDa8FbHHjMUtY/Srjq7PXs2bSmH+f7on+sqcLJ87yGyeKGBG56f4PN31
	tYAyxwdHtKcNEAl7bhM5hx19gj1j0Pvr3q7gyno1KuybQkD0ynZPCBW2Pt6N+GtU3njg
	yChw==
X-Gm-Message-State: APjAAAWxpxLkEMQlZgCpd+7ch4ltCs3wBusU76C/WVvm1i5fokXJbsS5
	Itfg8pJN46ja0YRZt9MkRAfHXWsFtMxss8Nrifaqww==
X-Google-Smtp-Source: APXvYqy39Y35Jt8yQdoiCkDN+CClBEvBHXNOkGTOETSGhVQwai5AwVZoSlJEo3To5yLa8t7zVBhhu4NCOWF6T4/uNV4=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr2008280otp.91.1559211290302; 
	Thu, 30 May 2019 03:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<CAFEAcA_DdosM2mSo0FWMLjv2eBHscQGXw-_J6AefiwURZGCCrg@mail.gmail.com>
	<87o93lfmvd.fsf@dusky.pond.sub.org>
In-Reply-To: <87o93lfmvd.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 11:14:38 +0100
Message-ID: <CAFEAcA8hLCSeQ-mq8_9vOV3MuCXSjSx1_QiBi3sEPkMUr7Uq1A@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 at 13:48, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > fpu/softfloat-specialize.h is a bit odd as it's intended to be included
> > exactly once, by fpu/softfloat.c. Guards wouldn't hurt, I think, but it
> > might be cleanest to rename it to fpu/softfloat-specialize.inc.c
> > to match our convention for "lump of C which is textually
> > included but isn't a header".
>
> Makes me wonder why we bother with a separate file.

Partly historical, because all the fpu/ code is originally
third-party from the softfloat project. Partly it separates
out "code which may need to be adjusted with ifdefs to
implement target-specific behaviour" from "code that should
be target-agnostic".

thanks
-- PMM

