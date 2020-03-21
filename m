Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCFBC4332D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A975206F9
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 14:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0tXE7pU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A975206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFfWP-00077A-G9
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 10:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFfLm-0000Lk-VL
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFfLk-0000Ot-O8
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:43:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22309)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFfLk-0000NZ-JO
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 10:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584801824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xP1X/vYsg9JeRGG0cK/lMXeLtyzTis334aQojn7RlgE=;
 b=E0tXE7pUdhEsfcITnzt0Z5Q/3N4qRIG4X9JBeGMe7/8qcehnzxDNulS+54udCqRykfOKzC
 Gyzor8eyo6sxD+0C3Hk8xvHipXcTKwbbSCe4+15e7lQDyd+K3dj+j3ICvNPmwA/8uLZ/8m
 bzTyO2khsJX/ti1fxlt8mTrIA+FKWDs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-gch8ub5pN-21tDMLvvDhkg-1; Sat, 21 Mar 2020 10:43:40 -0400
X-MC-Unique: gch8ub5pN-21tDMLvvDhkg-1
Received: by mail-ed1-f72.google.com with SMTP id i10so7610048edk.13
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 07:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F/OLVnoElxwEF3rlTbyB1ANgms+SlUxPt5Z/ioqo0ws=;
 b=GsWsEWzgFg3RJIEoxg2zeDDv0NG4UG5jJAHYNOrcRjVY28vYpebRDRJVKCttqdbwUy
 S1fEWp60EJ/hSrgsif/7dvqzODhiy/7izT1XRwdEMkaMHh6pv0suN21R+xH3ea2uAaFC
 393/lJAbtlZr/tc2Io0gF56g2cbKzYak/m4pWd+LDWy7Ogg0Wxh5Md9Zbp3UnTZ/IIRw
 4x4KbH7/xGrLsRaQgLh/UM6LAa9sawXqlW9Z8fGrwxYyLmeimfSR74FLXGleDnrYu3l3
 iFECP9ea8O7fid8nP57mydQS4mTcE4e8NFcV/oSbijgIrJbnck1YhFjwBRIZz7zq4+5H
 66aw==
X-Gm-Message-State: ANhLgQ2waURtdS4yrRiauHZISgPStutbcS7G1bC8jX5OUNI0yjlkqTRZ
 DualJ6uEZFoPVVQFP47RCxTC/zLl/JVVsYXpndntJnx2wCqGGnxqDu59UJEOP75hTZbdiA1/OJ3
 hfIRHMqCqUCiukR4=
X-Received: by 2002:a17:906:9451:: with SMTP id
 z17mr12858635ejx.176.1584801818843; 
 Sat, 21 Mar 2020 07:43:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuQpSBay0NoE2JtF/dbQw/BKYEI/H2jAJkkC81gLLfWpRUJt8dIypFXtrHpnZV46cFcJZPGng==
X-Received: by 2002:a17:906:9451:: with SMTP id
 z17mr12858601ejx.176.1584801818627; 
 Sat, 21 Mar 2020 07:43:38 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id t13sm613293edw.49.2020.03.21.07.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 07:43:38 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 00/11] misc: Trivial static code analyzer fixes
To: qemu-devel@nongnu.org
References: <20200321144110.5010-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f16abe6b-f0d5-60f1-71e4-f4c40e08aa33@redhat.com>
Date: Sat, 21 Mar 2020 15:43:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200321144110.5010-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/21/20 3:40 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix trivial warnings reported by the Clang static code analyzer.

I forgot to add the official Clang static code analyzer documentation is=20
on https://clang-analyzer.llvm.org/ and on Fedora I simply used it as:

$ sudo dnf install clang-analyzer
$ ../configure
$ scan-build make

>=20
> Since v1:
> - Addressed Markus/Zoltan/Aleksandar review comments
>=20
> Philippe Mathieu-Daud=C3=A9 (11):
>    block: Avoid dead assignment
>    blockdev: Remove dead assignment
>    hw/i2c/pm_smbus: Remove dead assignment
>    hw/input/adb-kbd: Remove dead assignment
>    hw/ide/sii3112: Remove dead assignment
>    hw/isa/i82378: Remove dead assignment
>    hw/gpio/aspeed_gpio: Remove dead assignment
>    hw/timer/exynos4210_mct: Remove dead assignments
>    hw/timer/stm32f2xx_timer: Remove dead assignment
>    hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning
>    hw/scsi/esp-pci: Remove dead assignment
>=20
>   block.c                    | 2 +-
>   blockdev.c                 | 2 +-
>   hw/gpio/aspeed_gpio.c      | 2 +-
>   hw/i2c/pm_smbus.c          | 1 -
>   hw/ide/sii3112.c           | 5 +++--
>   hw/input/adb-kbd.c         | 6 +-----
>   hw/isa/i82378.c            | 8 ++++----
>   hw/scsi/esp-pci.c          | 1 -
>   hw/timer/exynos4210_mct.c  | 3 ---
>   hw/timer/pxa2xx_timer.c    | 1 +
>   hw/timer/stm32f2xx_timer.c | 1 -
>   11 files changed, 12 insertions(+), 20 deletions(-)
>=20


