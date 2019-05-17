Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D6C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 20:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF252087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 20:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1T9LaN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF252087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53231 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRj8Y-0007hm-Gt
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 16:07:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tedheadster@gmail.com>) id 1hRj7l-0007Ox-7a
	for qemu-devel@nongnu.org; Fri, 17 May 2019 16:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tedheadster@gmail.com>) id 1hRj7j-000256-Ac
	for qemu-devel@nongnu.org; Fri, 17 May 2019 16:06:37 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:39686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tedheadster@gmail.com>)
	id 1hRj7h-00020n-CY
	for qemu-devel@nongnu.org; Fri, 17 May 2019 16:06:33 -0400
Received: by mail-vk1-xa44.google.com with SMTP id t18so2341691vkb.6
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:reply-to:from:date:message-id
	:subject:to:cc;
	bh=+FcojWGcM2Za5Z3tys5wJ3ZlVakUhLpyXOiD4mViADA=;
	b=p1T9LaN89vyyG6oykrssttLfKSSxQ9njY4vCwr8AD7PkDZR/RGHpZljfjbvA+JPkMO
	gbvVdQP4x54NjpD5j1V/genwia79pljK4sQ7LIKakVuC/ayQWhoduyDuJhncdvc/E9jL
	dPL3ld8EDP3hYn+hiShsfIAOv6y4/lBvWfc7NrNITVnXziy1sE2I7svg2QWlzQHRGtcG
	+2/qng718tc/7Z+VTT8AkCyEBzVfrqcoxcAKsClZg0Az1ANh90Lz6z6zgw3/1aHR2bob
	dAWSNzfB/aVHKK3e5IJ+uFJZIWqsZLimWxr1OPj3J27En03RfpwxBF1k9we14hV6SF91
	EWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
	:from:date:message-id:subject:to:cc;
	bh=+FcojWGcM2Za5Z3tys5wJ3ZlVakUhLpyXOiD4mViADA=;
	b=VOMLPhB5rYzsIvwStFD60SQ34zE0LzdkQRngmQetB0eu8Xt8m2W/Tnp1YZ4qHyiuoX
	RFjgYdwgTfP5pvh9OLDVL9OrsTW2d9j4lnVjibbJyCyszColX/YwZ5quNBbtelEA4Y2c
	Esi8fF8qUXBzOgdfKFTEQV+OrytHkH5T0h6oaPz1lmdh79A7QJhPHQ/meXsQXxMh0+o1
	WBIuTyuGvMEhPrICFHcY/a7g0x3odck5LfitQz5h1neOSZAHrpI4sGdV30BYOOBGBchc
	XVRoXpkMI06Nc5qPD6FRE0OxW1Y4+Dnx+gYOkOwKGoPVf0K/7k/X10h8cjowIyHcpEnG
	6qhg==
X-Gm-Message-State: APjAAAXS/w2ZeaYn/Meo3nfJmu0f8w06tcxamim9uJfPjecxuNqC8PV9
	xHPJ8Yd/FmQFknnDL/VCwx3HYmLWuFOrbBE+3g==
X-Google-Smtp-Source: APXvYqyY5EZ+d14q6+PQ/A3seeKuKImFSK2eLcrt4mWpYVJQwdegqaDK+2a/vFzjTcNZ7frPSgZQZ6H06vFC+YDEPX0=
X-Received: by 2002:a1f:c2c1:: with SMTP id s184mr394381vkf.65.1558123592274; 
	Fri, 17 May 2019 13:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8WD_bf=0=tyCumcNpVLtneio+vbd4JuFMmtWqSwXWFC-7PMg@mail.gmail.com>
	<6da0c28c-ef4f-8199-1cee-bf1f08387ff1@redhat.com>
	<ea9cf5ec-f259-9a23-eae1-1b2250c367b0@redhat.com>
	<CAP8WD_ZUVZJKk-tEfG8+yd6t_U9+A3a4s5_ohjU5KLP0tY5YwQ@mail.gmail.com>
	<20190517181523.GL4189@habkost.net>
In-Reply-To: <20190517181523.GL4189@habkost.net>
From: tedheadster <tedheadster@gmail.com>
Date: Fri, 17 May 2019 16:06:20 -0400
Message-ID: <CAP8WD_aUC9V1wPuC2w5jzAPrThrODfxjA3h3p8z8WAyKaG8Tuw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::a44
Subject: Re: [Qemu-devel] Pentium Pro Feature Bugs
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
Reply-To: whiteheadm@acm.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Matthew Whitehead <whiteheadm@acm.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 2:15 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
> Are you running the same kernel version on all VMs?
> X86_FEATURE_CPUID was added in Linux v4.11.
>

Eduardo,
  I am running a 4.9.162 virtual machine (very intentionally, the
drivers I need got broken in 4.11) inside of a 5.1.2 host.

X86_FEATURE_CPUID is certainly defined in
arch/x86/kernel/cpu/capflags.c but nothing much seems to be done with
it.

The whole reason this came up is I was running 'perf top' on the
virtual host and it was spending the most kernel time calling cpuid(),
which seemed wrong.

- Matthew

