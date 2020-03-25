Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DF2C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C16207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LU+Owh/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C16207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHDKD-0004gP-TB
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 17:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHDJ8-00048c-Er
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHDJ7-0002dq-5Z
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:11:26 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHDJ6-0002cl-Qk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:11:25 -0400
Received: by mail-oi1-x243.google.com with SMTP id d63so3535843oig.6
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pAs1/6rPZ7AOg4acfSkSNCqbuVv1mxi1YhxZHMCYXCs=;
 b=LU+Owh/txCIjf2uUpSQyaD5hsuVhTkSdf6JPycZ0mzUldMAL/BSwx+H/pEP3bgRFTr
 PdjOnFPDrprrAcxnmir24bfvxaHfaRkV4oY9VWx3V3s/F3gCw+YdJ5hzK0cJz+zO4S/T
 P9Wyh4/XOYkvskqcPIBgvOod5emnhw7wyiwlI5g/locN5V1qtBgnge9JHlEeGqTX65pZ
 T55luqaSkw2LHYFy7gxywNxocIA6wYQCQZEDXMu8TdiA5SfTfBD4SOv3LySiMk22l9xO
 NCT9S/WPMgHICSbRQWnZeOh1CK7P8e1oh9LTrpyR7zG2jKIVTPOMIyL6LXzVszfzT0HG
 PvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pAs1/6rPZ7AOg4acfSkSNCqbuVv1mxi1YhxZHMCYXCs=;
 b=q+GvJ6IVFWb0yYS2K+yOdckp8SGziMFa4K+uj175d8jadfcBvnoHdalOQY6JQC9n+z
 ohKuzmkAWjpYT6DEQwxDHuI/epjHDoucl5G8BE32RUu04iH3UB0bvFlmctCklBTrxuHG
 nD2QVACfHDwj/Ucbq0TwRSnNiTc68K6QRgvjpA9GR3q3gqBF0qv7xa8GFt8/RWQdbS2b
 Q49LBGxfECBPrPyeKoJk/ZIKp8kIm+k07ZX+Vs3xG3JtzkX7frxHBh2ZEUbslyNsLKUv
 A9yyD12vlAOCHIqp76Ng7tdeSIN6EMwGvAXKSSrMmfrjbdw7r1jMNYtc3/9hYuGv3jmU
 tq0w==
X-Gm-Message-State: ANhLgQ38l688UASV6OxwFQtHstuuwGDbU/RL47mby7OLTbRJHJ8DJyx2
 cDFObreIQUkJjtzDSD0t3r/tucix7qWD/pCykL9vQA==
X-Google-Smtp-Source: ADFU+vvudGmuEXbJzNNrv0mWkB56R7sDkPvCOI5DNCBHN2ROpmRH0Ym3oECIhsVBZVUOSU/kgxcXwXTpNTu0HIYJce8=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr3824023oih.146.1585170683403; 
 Wed, 25 Mar 2020 14:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200324212103.7616-1-peter.maydell@linaro.org>
 <CAPan3Wpr_ys2qZ_kTZPYyc3qfpvqPdhnDj6VYdbei8Y0_uTG2g@mail.gmail.com>
In-Reply-To: <CAPan3Wpr_ys2qZ_kTZPYyc3qfpvqPdhnDj6VYdbei8Y0_uTG2g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Mar 2020 21:11:11 +0000
Message-ID: <CAFEAcA_LaX19=wZRxP7YvATUVbJNQjCBSdGy13b7AhQPxpCPMQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW reads
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 21:03, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
> By the way, is the coverity output of master publically available by any chance?

We use the public 'coverity scan' service:
https://scan.coverity.com/projects/qemu
You can create an account and look at the defects if you
like, but we don't generally expect everybody to do that.
Some of us tend to triage new issues as they come in and
report the non-false-positives to the list.

thanks
-- PMM

