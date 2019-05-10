Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27236C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81982182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 02:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpsz+mlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81982182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35587 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOvA0-0001C4-5i
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 22:21:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOv99-0000b4-Fs
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOv98-0000s2-8d
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:20:27 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hOv98-0000pH-3g
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:20:26 -0400
Received: by mail-qt1-x842.google.com with SMTP id y22so1496403qtn.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Dpc5+8PsZmzyrGISONGdscYZleSzl9QiOR0UBOC3T1o=;
	b=Cpsz+mlSLZXXsD0EPkGrTOCmVRDY7WvA0YcFOnZBDrWvOvU5OvMhNvOAaHwvSE8+Ve
	rz7OaBofSq7SIE1E3OZbwbM2JXNX/278EiPC9moEEc4r7IbV72U3nLL0Zl4fPE9qrhna
	SzqCyR9JQJ48qil7EMZRyaMaxG9QBQnWSRvJIuZAXzpCY9pfoyBluZ3yQmmfILOW6xdn
	Auc1tpfBo/aoeCQ+HSCsydjN9hX9bvh6MZnrVIqE+EmGuuMSmjylG0TsECoUpkxM4YDD
	RfpnMSXQPISRqJvIQfa4AaNrBcH0jA5kf3T/FMEkloMDBVsQLsPrPOO1AG6fI8MlXlQf
	MRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Dpc5+8PsZmzyrGISONGdscYZleSzl9QiOR0UBOC3T1o=;
	b=TX5UCiO5Ff8RMbWItv/ezoh3IZvaMlqje6aJZExRC17ciPlCFki3wi69LTGJ9dhej0
	g4y+RxToSGuRYjZOE4JQRLM9Rv5fY3T+g+HAEwcdsLT6otC1YBpIJ2GJN2l6X4/R84UJ
	oQ4NrI1DqVMZyREuNzJCCJ/2fNK6k/KHy+pJCdrjpEfW8EPQqvwySYfBnK+WzsXQxJeH
	dyWVJFkFpZBPktBTAC85NbV1r3xBt7AXjRMgFB5mFnh2q13DCLjoPYHygBhg2ragKVvw
	pB8NmTGoUvFF+cjkGontq7WOG+PmhwoSrYpuMR1Hn/qMI942/aUtUD0ocr3hHpFLdUER
	6FvA==
X-Gm-Message-State: APjAAAV0mB7S0QX1tQ5nJfAIJ6Jka2MBG9xSqyxnIRdYNrYTOhEOMCkC
	i4ozUHgZK6jugZQQ7m6J9SbE+GBsCUk+f0beM2g=
X-Google-Smtp-Source: APXvYqxfVUmFUCt5ZX9SVE70CADELxBQS3CSx9ziBlQZGoIkz6rjya0VbzZNq/FPyyhU02ojwNP0a0rY74jz/DePxUw=
X-Received: by 2002:ad4:5365:: with SMTP id e5mr6539637qvv.197.1557454824211; 
	Thu, 09 May 2019 19:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
	<b6064b77-5ca4-03e1-80ef-027313096cb2@gmail.com>
In-Reply-To: <b6064b77-5ca4-03e1-80ef-027313096cb2@gmail.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Fri, 10 May 2019 10:20:05 +0800
Message-ID: <CABSdmrkW6G23ZGDA7iLucM45vL0HHGsr2F76H0Mf8S0xkhPnsQ@mail.gmail.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 3/3] ramfb enhancement
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Please format the commit subject with a prefix and do not use the same
> subject for all the pacthes
> in the series, for this patch it can be something like:

I'll resend the patches with improved title lines after other issues are
cleared. Thanks for the advice.

> Will this result in a silent failure? So we need to add something to the
> log?

Based on my experience with OVMF, the "silent failure" only happens when
the firmware is malicious. In the current workflow, the only failure modes
are:
- The firmware does not support ramfb, in which case the patch is never
reached
- The firmware fails to allocate a big framebuffer, in which case it writes
log to the serial and hangs / reboots, likely before reaching the patch

If you insist, I can add a log. I need to ask though, what is the standard
way to change something in [PATCH 1/3]? I've never done it before and there
doesn't seem to be an easy git command for that.

> It is actually a cool feature, changing the resolution following a
> display window
> resize, but sadly is not stable enough. Let's hope it will be fixed
someday.

I agree. It's kind of hard to validate everything properly...

Then again, ramfb is not exactly efficient (requiring a full screen
glTexSubImage2D every frame). After the boot screen, I feel it's better to
leave such fancy features to GVT / virtio-gl / ...

> Write an initial resolution to the configuration space on guest reset,
> > which a later BIOS / OVMF patch can take advantage of.
> >
>
I like the idea of moving the ramfb configuration to the PCI
> configuration space,
> do you think is possible to move all the ramfb configuration there so we
> will
> not need the fw-config file?
> ()
>

I need to clarify that when I say "configuration space", I mean the
fw-config file. What I did is to initialize that fw-config content to the
resolution specified on the command line instead of all-zeros.

ramfb is not a PCI device and I don't think it's possible to move its
configuration there. Even when it's attached to vfio-pci, it's technically
a separate thing from the guest's POV.

Is this chunk related to this patch? If not, you may want to split it.
>

Yes. That last chunk lets the user specify an initial resolution without an
EDID when ramfb is created as `-device vfio-pci,ramfb=on`. It can be useful
when debugging GPU passthrough in EFI shell or the Windows Recovery thing
(which shows up in ramfb).

Qiming
