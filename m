Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F3CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C6D2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhBeUytr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C6D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0LF-0003hv-6I
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1jm0KN-0003FD-Jq
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:35:59 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:42825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1jm0KM-0003uW-2s
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:35:59 -0400
Received: by mail-oi1-x236.google.com with SMTP id s21so6161110oic.9
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=L4LYgAOZH1CmiGFcvCK+r1RWVQSl0/6q9TwxuYBkiFI=;
 b=HhBeUytrarocStQWQ/8jySdGHvRUMIf2Jo8NsxGpdL18UMYsuFDyCODEQihP4bR80k
 FhuQXqPbdBwTv8nOOxZY7TbWQ72vwrw8K951FJN7V0c6VL4VIS2W9Lyf9RX3bszrzSx+
 /I9FlS01UiyXuyQkau1MlvTaU0hrFsNJS9V44MF0SADUtJcLg97w0aRV68EdF7PwHp0p
 AQ2L/1T8qp7zcMhvwej1L1mjWjN//hXBdeG6mv4lP8Zn/+JJMzzHi8kXwpvtXGIPfCS7
 yh3Rd9xCBpZFL3BkOAuTGnFZXvnSu/PPcC4pBydKGn/FB1RcX0e4XaMPgIPW2TCIsolJ
 Av1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=L4LYgAOZH1CmiGFcvCK+r1RWVQSl0/6q9TwxuYBkiFI=;
 b=OMbN9vG0CdanNSDkcUrn7YkCYWEtjUoFiptJPoNkbhmqk+LLM1+u2ixJGkCG7PM8Wz
 eMOoxXqtQ/EJViU/NDhsgN8ZOrnE6jYWJL8jlwBVTG0mijNDUjpNaYok20QL3dWX38H3
 LMAkTJw8e7I7u3jvXxb2O01c1QbGLXfIkEu7ONUOSEb9fiKgVG0/hjpwGCeN2DyJM3XG
 Ibjo7ql+2T7rsTZHKlUVs7EszsIKje1DePSIKXKA42GBoVvLrmh2KX9WtGTfA0IICPLi
 RGNivGHhXOOERscIz+Fy2VYoAE+qRKxrzopdrcKoMcSLOdn9tcLcZ7EbXuTX2aqDx9BN
 Gk8A==
X-Gm-Message-State: AOAM533SHoWBT6VPOwnop2Kit/8C6+Qu4tSHFt9bjkbVqBGebBokiMDz
 kW/ljl6UNvD/U5iUeeMaorDKe2e35ByFeWJjZRHbMcyC
X-Google-Smtp-Source: ABdhPJwGvr0NyEdj5pRioWmn/JHl5i500SQLSfGROacUY7st9GWk+Yn5y8Uroezyn0N+l5i7/lg+3xm+ridS2na7X9E=
X-Received: by 2002:aca:d10:: with SMTP id 16mr352908oin.106.1592508956394;
 Thu, 18 Jun 2020 12:35:56 -0700 (PDT)
MIME-Version: 1.0
From: Gautam Bhat <mindentropy@gmail.com>
Date: Fri, 19 Jun 2020 01:05:45 +0530
Message-ID: <CAM2a4uyW33vsUTNMPpKN=S-obPWf+EZwS3TiznJgq4Av7R-3tg@mail.gmail.com>
Subject: Usage of pci bus
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=mindentropy@gmail.com; helo=mail-oi1-x236.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I am confused with the usage of PCI bus for connecting different
peripherals. If I want to emulate an ARM board which doesn't have a
PCI controller how can I emulate it to be as close to the real board
as possible? Is there an ARM interconnect or something where I can
connect the peripheral controllers and the peripherals to these
controllers?

Thanks,
Gautam.

