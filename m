Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F15BC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D2D2087B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D2D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46733 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRaqG-00068s-Fv
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:16:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hRa70-0007Ti-Hk
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hRZv4-00015P-MR
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:16:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hRZv4-00014w-GZ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:16:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id x64so6376227wmb.5
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 03:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=xQQ6KIq5Toa2u3FSu6P1kpYBA68Mm7wqwuxjswFrcE8=;
	b=LOCaS/qCCQqt0Otwgp9c/i27xJxF8xj736wVLe5q1SqHyThtgo9hWdWttrrFcakyQy
	HpaF2pWhKdKjaRKTzkQ2RHQLueukSc6QymqK73uOHUHTcR0bSGraq5gDEt5va/BOM5b7
	c+UQuXu1SAgCxFzCWyFZtp12NGyUt8dFIFRKX+0DsLPUBmks4lgoDR6UuhDBMHV8VrA4
	8Q2o/TllAutmYK2tOszjusdNFbYAdY7w4AzyZGwiAVpGT1jCgCGVTVuya8KFbwEk3XDC
	9anEF6z4IPb8Wo9/qUCGOyXmsYDXeBSv9IH97q6gTOmtrPaKVoWvRRZTZHuVDuLB/3Qi
	EyEA==
X-Gm-Message-State: APjAAAU/EMH+cBCACRlDOrZzwfAogzrvB9Cw0T/I/sT3o8LLvaP6pC4U
	sidxdzo7ZvwU0fzWXIQIIyOuy58QQDppnoV4B49sEQ==
X-Google-Smtp-Source: APXvYqys5ntT7NR6N6Ve0ucUNmNG23tRCoqGPwu5tKMAGg8jxqBR9qnu7h94lIjDeZmZ1WOGsW9ETtH1rLmsyJbmAxs=
X-Received: by 2002:a1c:678a:: with SMTP id b132mr17936544wmc.17.1558088212911;
	Fri, 17 May 2019 03:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
	<ab4b6d04-74f9-2f12-829d-9df8c1b1c4ca@redhat.com>
	<6ae8d347-149d-e7eb-bb02-90aba44c5bbd@kernkonzept.com>
	<1e9a8595-4653-4900-b747-236f9888b893@kernkonzept.com>
	<04a4fcca-0db9-46f8-ac41-0d770b0dc5d6@kernkonzept.com>
	<f9f1b930-2381-b343-854f-70e2590c9b73@redhat.com>
	<CAL1e-=jFH7+cHGUJsmUKpEAkwohagfM5WVb4-rGSozsEkzFrTA@mail.gmail.com>
	<35442861-78a7-a60b-8cb4-913a7a299a26@kernkonzept.com>
In-Reply-To: <35442861-78a7-a60b-8cb4-913a7a299a26@kernkonzept.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 17 May 2019 12:16:41 +0200
Message-ID: <CAP+75-US1XaBuaZx0oHqyShrLuK1gcSMcymuvobAsd=Ye07Rcg@mail.gmail.com>
To: Jakub Jermar <jakub.jermar@kernkonzept.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2] mips: Decide to map PAGE_EXEC in
 map_address
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 11:30 AM Jakub Jermar
<jakub.jermar@kernkonzept.com> wrote:
>
> Hi Aleksandar and Philippe,
>
> On 5/16/19 8:04 PM, Aleksandar Markovic wrote:
[...]
> > I tested Jakub's scenario too, it works as expected, but I am not
> > concerned about it as much as about regression tests. Knowing that you
> > have many MIPS test kernels and images, may I ask you to test some of
> > them WITH Jakub's fix (so indepenently of myself anf Jakub), just to
> > confirm that there are no regressions?
>
> May I suggest to include also the following mips32r2 HelenOS images with
> the following command lines to the set of test kernels used for
> verifying new versions of QEMU? I always test HelenOS master on malta
> when there is a new version of QEMU, but it might be better to spot
> prospective issues earlier for both projects:
>
> http://www.helenos.org/releases/HelenOS-0.9.1-mips32-malta-be.boot
>
> qemu-system-mips -cpu 4Kc -kernel HelenOS-0.9.1-mips32-malta-be.boot
> -nographic
>
> http://www.helenos.org/releases/HelenOS-0.9.1-mips32-malta-le.boot
>
> qemu-system-mipsel -cpu 4Kc -kernel HelenOS-0.9.1-mips32-malta-le.boot
> -nographic

Yes, I added both ;)

