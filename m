Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9563520775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCWBHm4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9563520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joiw8-00049V-Ta
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joivb-0003j7-0G
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:37:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joivY-0002Ad-Vv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:37:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id l2so6922653wmf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 00:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XXKU96ehp52N62ZpV+Tm9E+yQKCWytsdskpTB5pZMHk=;
 b=PCWBHm4d14slTHRxze9HKih/qS0Zbt81xFkpgg9D3sOfJY1imkB6gTRv+c966up1sG
 HI+9TpAe33yfP7zApBD8HzTpwt+Q9fiF11C+A4LbINzL9iODCVtpgOqYjMrBV93GbhQe
 TRuJfSg9QeLenLtyP7ZfOEf/16rF2Up3T3cvk2DVSMlLjzoY+gJb+kRcJNX7lcMrXvds
 1AiMmB8qOAvo+Ey/k8qelGHr0qALl0ZhoE4dQIHerw3VmEo6ZD/q3ATlZY/1QAUJKI6/
 rUUJmbqYRoYrAXPTvNic55VImKmKEmi9nEC6riL9DTJ08MkcPwFwxY3ypht00faf7vVr
 CD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XXKU96ehp52N62ZpV+Tm9E+yQKCWytsdskpTB5pZMHk=;
 b=rt2pqwMawfRlB9zKmOeeH+WpHyk+zZHabiURtSHstDbXO520wFJFnjsxIwIO6DoOJl
 XXf1GwQfj/xu9ZNxhGy/K4eZIPuSOxGufTlSNcp0x4ruyKCbR3WNXSxMTxo2xuHD24Gm
 i6qwc8gXWmQLoApS6e6UmXlnlyUfJ+/acdB9zIJZexC6U679XEwJ4Mpefg4xLqwUyRkm
 AyJMqNH54lwBkfEVRRaSTtOF/q2WTFZINAo0dJ44o+JhLnW0RYzL7W134KO0WkHxSGt4
 UHxGN+iIt50cx7nARN5opT/jXcVG4SMSRNNlKP2MkCLpn/WgPSqheSL5hVhAQQDNgHWJ
 hY/w==
X-Gm-Message-State: AOAM531dhD0KB1yIWxsR9Auo8QjD0ccf87X9wD9qI9uYSAyLSmUp+gPG
 yfOsuRhuLVvImRVIyawOISVtOWXnT92r79GYZ/o=
X-Google-Smtp-Source: ABdhPJx9u0adUyuiWVsnhDR5OjQ6XoVwcYucQGUTLQp4tGFbTj54LAhaNEhBnPeKP9RN9RnZk3gErFVp281a7yxB2zM=
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr1893262wme.159.1593157055340; 
 Fri, 26 Jun 2020 00:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <159315507826.13901.17398620572438937429.malonedeb@wampee.canonical.com>
In-Reply-To: <159315507826.13901.17398620572438937429.malonedeb@wampee.canonical.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 26 Jun 2020 09:37:14 +0200
Message-ID: <CAHiYmc7_ra2qWJ8mkZ-vqL5vN2BKdWxAZeKNnMEkPtien5-fsw@mail.gmail.com>
Subject: Re: [Bug 1885247] [NEW] Build error in Intel 32-bit hosts
To: Bug 1885247 <1885247@bugs.launchpad.net>, arilou@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=B5=D1=82, 26. =D1=98=D1=83=D0=BD 2020. =D1=83 09:11 Aleksandar Ma=
rkovic
<1885247@bugs.launchpad.net> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:
>
> Public bug reported:
>
> The code base is on master, checked out on Thursday June25th 2020,
> 0250c595c9d. The build procedure:
>
> $ mkdir build-gcc
> $ cd build-gcc
> $ ../configure
> $ make
>
> The build error message is:
>
>   CC      x86_64-softmmu/hw/hyperv/hyperv.o
>   CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
>   CC      x86_64-softmmu/hw/hyperv/vmbus.o
> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function =E2=80=98gpad=
l_iter_io=E2=80=99:
> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast to poi=
nter from integer of different size [-Werror=3Dint-to-pointer-cast]
>          p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_i=
n_page);
>              ^
> cc1: all warnings being treated as errors
> make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69: hw/hyperv/vmbus.=
o] Error 1
> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
>

Jon,

Do arilyou have any comment or insight on this?

Thanks,
Aleksandar

> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1885247
>
> Title:
>   Build error in Intel 32-bit hosts
>
> Status in QEMU:
>   New
>
> Bug description:
>   The code base is on master, checked out on Thursday June25th 2020,
>   0250c595c9d. The build procedure:
>
>   $ mkdir build-gcc
>   $ cd build-gcc
>   $ ../configure
>   $ make
>
>   The build error message is:
>
>     CC      x86_64-softmmu/hw/hyperv/hyperv.o
>     CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
>     CC      x86_64-softmmu/hw/hyperv/vmbus.o
>   /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function =E2=80=98gp=
adl_iter_io=E2=80=99:
>   /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast to p=
ointer from integer of different size [-Werror=3Dint-to-pointer-cast]
>            p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off=
_in_page);
>                ^
>   cc1: all warnings being treated as errors
>   make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69: hw/hyperv/vmbu=
s.o] Error 1
>   make: *** [Makefile:527: x86_64-softmmu/all] Error 2
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1885247/+subscriptions
>

