Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852CCC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F69A217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F69A217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41736 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTsYw-0000Xv-K0
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 14:35:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hTsY3-0000EO-Hf
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hTsY2-0005ch-FP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:34:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hTsY0-0005H9-PT
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:34:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so3475062wrn.8
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 11:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=yzC7aBbRKtLY7XmH/dss0f5zen5oDyPQVYfU/BdPXJY=;
	b=fTa5osOXCum2wLMbe0lS9FmIFBn9C6AD+jbSdDlTFKiR2GqkNAmnKajQDVOWdQTRfM
	DsFjqYipY8T2Wl5ntbGgtob5pjGkE0vqkHnO4UQ32WvHnuYFVAtBVLMEsyqGSuIBR9aW
	u6V9UpV6CV5S/z6cvqGFJ3+siBmnbTTgVSOCHxItIHUfxXcSpgAWU7k9j3qXFZHKIAaL
	/UyZVjsE6xzq2jAgFflYY4KYY7nCPj9dBwsd/kxWPakfdobv3QOQABz2/EYPo7jvANGn
	4VTEMDBYbntUep/W6/go5DQ/sxI9eWWRY9M5bOgDD8YDiLtsjJu8/rycYG2Mo9p9peJV
	muUA==
X-Gm-Message-State: APjAAAU8YbXOyPi0dg462OmHjVnU+61QK0YoJQnP9MeNq1loJ+c9lpBB
	NRV9Md8Wa2Eb2SCuf9qIeKJR+wmEX9I9mfhuI21aoA==
X-Google-Smtp-Source: APXvYqxAxa7/XYOEeaSknttZK2U8qMEwgyUtKlnoK3tZ4UrVsPb2IbPr988EbEqu0Bxq4zRpOQti/HjoW0tHcrScxSE=
X-Received: by 2002:adf:fa8d:: with SMTP id h13mr32437163wrr.70.1558636468272; 
	Thu, 23 May 2019 11:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190523175413.14448-1-laurent@vivier.eu>
	<016cf4b3-d7b4-9517-e5dc-55b775945480@redhat.com>
In-Reply-To: <016cf4b3-d7b4-9517-e5dc-55b775945480@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 23 May 2019 20:34:17 +0200
Message-ID: <CAP+75-U-hZDDraFYWMSi_qHANT9d+Qs7bKozc6oYnvqdTbZk=w@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix __NR_semtimedop undeclared
 error
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 8:29 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 5/23/19 7:54 PM, Laurent Vivier wrote:
> > In current code, __NR_msgrcv and__NR_semtimedop are supposed to be
> > defined if __NR_msgsnd is defined.
> >
> > But linux headers 5.2-rc1 for MIPS define __NR_msgsnd without defining
> > __NR_semtimedop and it breaks the QEMU build.
> >
> > __NR_semtimedop is defined in asm-mips/unistd_n64.h and asm-mips/unistd=
_n32.h
> > but not in asm-mips/unistd_o32.h.
> >
> > Commit d9cb4336159a ("linux headers: update against Linux 5.2-rc1") has
> > updated asm-mips/unistd_o32.h and added __NR_msgsnd but not __NR_semtim=
edop.
> > It introduces __NR_semtimedop_time64 instead.
> >
> > This patch fixes the problem by checking for each __NR_XXX symbol
> > before defining the corresponding syscall.
>
> Thanks for the quick fix Laurent.
>
> >
> > Fixes: d9cb4336159a ("linux headers: update against Linux 5.2-rc1")
> > Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Aleksandar, you have a pull request in preparation, if you agree with
this patch you might want to include it ;)

Regards,

Phil.

