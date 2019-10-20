Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314ACCA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 14:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F235E21897
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 14:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F235E21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMCN1-0000nu-5b
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 10:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iMCLg-0008Bg-G5
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 10:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iMCLe-0006bG-6L
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 10:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iMCLe-0006ar-0O
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 10:38:22 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F58B4E4E6
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 14:38:19 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id p5so1110077wru.8
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 07:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O+rVKb+kZ+Zq/2UXbCQSDJsujZ2v2ovcuOiXqrLYI10=;
 b=SnP3k/Qj4N7Rke6tXlMeVKc93uPtrohql8spx4ATQ5hoi+L5APQ1f2sjEcOJRF6bXP
 xNwF2ZjG9bAoz/GCcwxEqPHQV9jw+JixB7/hF66hg9wE+82XeE9XFjkdMooXrLyJsDel
 xBG3zgUyWcn11+lLiloSWVGHmsZjgP5rXqnsFKGVfmwXPSLkAdVbxSQg3oQQVAI3YT/G
 jcN1NLm7RviuYD0lijEwPFq02e35TWqLSvMSkczC44NoFX9mu1G9uW15perheS71NNmZ
 JFtCcUYHENCmTteuvjGv/lbYK6Y2Tz9h3dglVDqbKzA11iWyDh+/nUh6d2o2Luyq104D
 cyZw==
X-Gm-Message-State: APjAAAU05IUrtKO2xz5SNCiYuqd1abdMvjUZ3srOHjbS5BNhAw0ZDNz3
 ef1UqYBOfkgq8r82a6Ww9RJ46SHWFiHzzJeg/CSRMkLj9FHX82ksPIBjbcC8Mk9i+dYfiPkPYd9
 /uqY8wYO0zJ2NT+xSa+J3xD9ed2jO1yo=
X-Received: by 2002:adf:e302:: with SMTP id b2mr14863965wrj.298.1571582298154; 
 Sun, 20 Oct 2019 07:38:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx64YNtMbDw4l8nS7RZi43ayCMm8PDwizi1uBt75D5pUqITZYIzhK0I2cW9tYgkb1/pqExMIuVnjPPSmxcprYA=
X-Received: by 2002:adf:e302:: with SMTP id b2mr14863941wrj.298.1571582297856; 
 Sun, 20 Oct 2019 07:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191008113318.7012-1-imammedo@redhat.com>
 <20191010193503.097548e4@Igors-MacBook-Pro>
 <20191011172310.19fc5d93@redhat.com>
In-Reply-To: <20191011172310.19fc5d93@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Sun, 20 Oct 2019 16:38:06 +0200
Message-ID: <CAP+75-W5HD37gA2JOpniQKMqnVf5z+U6RQT8YZT9TtdDyz3d5g@mail.gmail.com>
Subject: Re: [PATCH 0/3] eliminate remaining places that abuse
 memory_region_allocate_system_memory()
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping?

On Fri, Oct 11, 2019 at 5:23 PM Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 10 Oct 2019 19:35:03 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>
> Forgot to actually CC Eduardo,
>
> > On Tue,  8 Oct 2019 07:33:15 -0400
> > Igor Mammedov <imammedo@redhat.com> wrote:
> ...
> > Eduardo,
> >
> > This patches are fixing various machines across tree, so series does not belong
> > to any particular arch specific tree, can you merge it via generic machine tree?
>
>
> > >
> > >
> > > Igor Mammedov (3):
> > >   sparc64: use memory_region_allocate_system_memory() only for '-m'
> > >     specified RAM
> > >   ppc: rs6000_mc: drop usage of memory_region_allocate_system_memory()
> > >   hppa: drop usage of memory_region_allocate_system_memory() for ROM
> > >
> > >  hw/hppa/machine.c    |  5 ++---
> > >  hw/ppc/rs6000_mc.c   | 15 ++++++++++-----
> > >  hw/sparc64/niagara.c | 25 +++++++++++++------------
> > >  3 files changed, 25 insertions(+), 20 deletions(-)
> > >

