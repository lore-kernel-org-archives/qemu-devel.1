Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE019C2BA12
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E35206E9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzl7kK3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E35206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKOqZ-0003kQ-PX
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sophian.yoma@gmail.com>) id 1jKOpY-0002kn-OU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sophian.yoma@gmail.com>) id 1jKOpX-0003uq-PM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:06:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:41572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sophian.yoma@gmail.com>)
 id 1jKOpX-0003u0-H9
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:06:03 -0400
Received: by mail-pf1-x432.google.com with SMTP id a24so3671780pfc.8
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2pfI5oFdZDUYtRE6ZFUIV6C/vk36bk0XX1xmRNb7rqA=;
 b=Pzl7kK3wb5aRFhAO7qOY8zeCUlMDtcTUcSXMJ+hTiMQ9NCF4+D58JIRpZSMguMAD0y
 S3jtHsGV4wfnrDKnG7+283yUGxs/DJ36m6fjSwZB0x4Vt10W6cCLnr6+gQmfpMx4VbBG
 Dn/qLeboS4Pi9kWO3YF9cppH/J7mLsTo/jS6VkrstygbBbdhNW5s1ZO7/pRwlDJnhDjF
 /pfwOACO2PFlcC2nGfwWdmKSimumw+IKd4QbIG6Qw5X0ksqALlHAbTbjDTsdHfRNyXyB
 X+0RB64mtDG4mlYkMCP640dpf6tgLaxEVCvQ/TcT50WU9eUzfW4p+A6JcwS7msWHksUT
 JnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2pfI5oFdZDUYtRE6ZFUIV6C/vk36bk0XX1xmRNb7rqA=;
 b=N4Z5mlUSZKeePF8vmCeVpJX6euxRFcFT2AH0epN0J6UcOFCppBSfttcV6HBUowEynQ
 f+ZKw4Maf2CRSn8W2BWvbVr3P+JcQFLtpJtBGUJfg89vTWJNuh/haLTmqX+gQKcUN/i5
 /h3tEZOc6Tbh6bcDd2pX2aWKT3fwn3NTYjQ+bEu+r5tdClnRJfhIC8cgRxTQ69SAaLVi
 Bh+eDw4F1ffiQQnM9/uoti+joeWQPWkpVZ/s9entWJSuoM+CCiN5IqxeA65xJVTBppVF
 fY5JHGGd3Chu/gT8QE2Rg2A6UzFR59zILgsKOpQGD+EDGW16K+1jxDX3PuCVgFKGU35e
 q3uQ==
X-Gm-Message-State: AGi0Puapx5Ecg8hLuWjePNms538a2n3LofuqHVBRQiqKcZtL6SzUMF/n
 qW7ie9/irGQ6fnk69RDbYN2KQmAvfuOZ1biz3Fw=
X-Google-Smtp-Source: APiQypKJbz6ympLu5mBKVMUJIExt2To0so+daIMWav7I+2MTfMFzg+85brtXkKVJGP+RKuxO7yj1T6UDd4tMyptmr48=
X-Received: by 2002:a62:e107:: with SMTP id q7mr9081635pfh.190.1585929961827; 
 Fri, 03 Apr 2020 09:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <CADUS3onjS+T-SSYC6ocKNm3oXsCpiQbDa0eJobhOnts3gZ_gEw@mail.gmail.com>
 <CAFEAcA8tU58_Bdpp7tmpF+X4D5zyxpV4pA-wz97EpP41SQ7sqA@mail.gmail.com>
 <CADUS3o=1XSzi-DdK2gNm4-WEwPsEWc8Tfn4j9Fxy92JAg9Lktw@mail.gmail.com>
 <CAFEAcA94V+8qPyfMyvk8+F3_KpOG7sBcpc5DViDE+jZ1aEwA9A@mail.gmail.com>
 <CADUS3on6Dtk7+r2=d2nUJhz87xxJspYJhgDFEWgi3SLVmhHRUw@mail.gmail.com>
 <CAFEAcA9ai_WUE6Z+Le4AHGRtsPYkSo8W_hRJ2GTjAK+p6WRi4A@mail.gmail.com>
 <CADUS3ommYf+tDTRwPVKaXxhSBeja50KFS7K_q+WnKDnFchyGQg@mail.gmail.com>
In-Reply-To: <CADUS3ommYf+tDTRwPVKaXxhSBeja50KFS7K_q+WnKDnFchyGQg@mail.gmail.com>
From: yoma sophian <sophian.yoma@gmail.com>
Date: Sat, 4 Apr 2020 00:05:50 +0800
Message-ID: <CADUS3omyY2mafHiS4WQ4Wzw6VPjy_0e7gGFDuOHETEnyc2MOFw@mail.gmail.com>
Subject: Re: qemu-system-aarch64 windows binary run Arm64 defconfig kernel not
 working
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::432
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

hi Peter:
> unfortunately, 32-bit Windows qemu binary still fail on booting
> upstream arm64 defconfig kernel.

Is there any debug info of qemu could I provide?

Appreciate ur kind help,

