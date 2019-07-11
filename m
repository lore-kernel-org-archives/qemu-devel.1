Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13AEC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8E320872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuiMmOhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8E320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlaK5-0006ZX-Hz
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38911)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlaIk-0005iP-9Z
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlaIj-000471-7D
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:44:02 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlaIi-000460-UO
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:44:01 -0400
Received: by mail-ot1-x344.google.com with SMTP id z23so6069240ote.13
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=juWF7t80AMiUy6W/39UirWfnLso33OL7l6jDlGM6Yow=;
 b=LuiMmOhqnpI9XVRm72HVh+6hcQhkkX5lIqkfffDeBpuHJeglqdRI4F7SBDDGaqvX9C
 OPPIEHViGUwKIVQ+VY9fdwJvDwKV08gYCljHjE8m/Wr7DvvKwRcl1CkYDUrjBmpXskPW
 4k4PDvBmhjCvX6XU/bupLM4Qg9YqgDn2+Ci+J6zxmZzoEJSX0VH4ywHYIOFaXxc1ZJd4
 MANakSkCidvUY+QtQ4PZ7v9ihwUkCp/sAh36urwlbvMS6TO74Y3L8jVjyCLPSjU2BrDz
 oT4si2VCFSjMa6roLdFd/zlqJTr1J2axG+CSFusco3hHerKBnL0fv/r/p6EZI6OI2Axj
 521g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=juWF7t80AMiUy6W/39UirWfnLso33OL7l6jDlGM6Yow=;
 b=mUyZ6qbklC2WcnscFs/WHfyb1arS2SYjGJiGr5FCyA1ofgZXSDShL7IWL7N2J+PnNC
 9uXXpA4YOXLD1AGSMC3zNuUTHo3cCVll7AKD3NnquRJ7wbDqifSm5hcV+LElu8QrRXSV
 BXvXu6yKN7kKD2tPqT/KPWMa2oDTGivPcmFv17+eaRKpK0JNGlLtGViTok/TMh/UHPsU
 6c6JuVqrdDoPW64GPwAYHbTrOYamDVoU+xz9jvSmMF8p7A0HeBsl4WB4lfgW0lZkBsuD
 SleuXHPfNGQ56EulhX/4npMzOm+I3Mjnyv80IEZyaPE3UlkWtAzeS17UN6J62/g6286w
 4zGg==
X-Gm-Message-State: APjAAAU4G3P5qfMOtWEuhzNXw3mIg6lXpXnn6r6wGyGiEOJudSkjONjR
 uo1WfYswEop9rBVvkSpPWZIjqRB7fzQGJf2ZDQSGQw==
X-Google-Smtp-Source: APXvYqwmF1UnHM1ZF0FtaNoZyFKo8OPH0s+nKphsKNwRx+Ye2jwbp/AZSWa0HaYGhoMp3flH+bmD+E/oJbdgZyE0j8c=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr3902765otk.232.1562856239945; 
 Thu, 11 Jul 2019 07:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190709123240.16298-1-philmd@redhat.com>
In-Reply-To: <20190709123240.16298-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 15:43:49 +0100
Message-ID: <CAFEAcA8h-ghRdj+K9x-6559Djfpth1-s9aPargLkQjTDA5HsLA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] 
	=?utf-8?q?=5BPATCH-for-4=2E1_v6_0/3=5D_hw/ssi/xilin?=
	=?utf-8?q?x=5Fspips=3A_Avoid_NULL_dereference_and_out-of-bound_acc?=
	=?utf-8?b?ZXNz4oCL?=
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
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Prasad J Pandit <ppandit@redhat.com>,
 Lei Sun <slei.casper@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jul 2019 at 13:32, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01238.html
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01586.html
> v3: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01657.html
> v4: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01777.html
> v5: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01959.html
> v6:
> - fixed datasheet reference, added Francisco tags
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/ssi/xilinx_spips: Convert lqspi_read() to read_with_attrs
>   hw/ssi/xilinx_spips: Avoid AXI writes to the LQSPI linear memory
>   hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[]



Applied to target-arm.next, thanks.

-- PMM

