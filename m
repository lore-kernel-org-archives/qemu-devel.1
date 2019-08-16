Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B0C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1558E2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9Dyt7Hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1558E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52059 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyY4M-0006pa-8C
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 04:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyY3O-00067p-QY
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 04:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyY3N-0002WP-Ab
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 04:57:46 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyY3M-0002VA-4m
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 04:57:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id p124so4302992oig.5
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F/VignfD644W9m9MuiKKhm5HFSHse80KdACdxMIyICk=;
 b=w9Dyt7HiWFNGV7ag9WBn7uv0Bwk6AlpijxSoiJbtViKFv101pAdAUY42UQTMmSQUVu
 8x9Vk7yiCD07FLHoD6Hoq1ZkM8cwPOfawipAPy7Ddhdrh37ChuwcwVrqAT4BLm+zVzwb
 bCZmduOvDHGsh40MzqqUqN7J1jqP6cI2fV+sqpSstKPeJ7QuMCPAx3u163AGiVo5XuQJ
 08me0mdd99iJ1AW9i9iYumJGFRDcuX0faQja3U/1qIaJ983q65M312df+j5sapjHK2d0
 mEF8wZGF4xG1OHrsu2vKVCBb7kEYS/EyVpSlg41aktj/EFHQ7RG7jgFIRaKcnadyQNyb
 G7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F/VignfD644W9m9MuiKKhm5HFSHse80KdACdxMIyICk=;
 b=SHOUF/kbYCyTS3oDgyo2ZGEhRaFZxLEr9Wp6QI/ihjWtMfxC0vDnuHD3VtqvOTAdia
 JgS9UQVSeyQx0LvXpo4YDnq0xxZGSep+DFRMLxxa3byZ9bemg++3Py3YS1rEO01oh/Tu
 hLvkts5Z+LlOVINgGKwJWeri21MbXXJuFsOIexaN70HnXYR1kOZkpD7DRa6JNZ0oKFNw
 UxRdNZXY/+jWjuz3Js97AKLxBgLTPaZASZuv64efTtewdoY/7uZVTCOMOJB6Q3qsJpFo
 7ekoWRhJJMeqxRCJBNlSBr42+TY438cutEr729btHOxjjwMwfcRTAysrZGQ1gd5uyi9L
 dw4Q==
X-Gm-Message-State: APjAAAUdE+CzT2qpvNgFoaBCl1zT58OIjTjJtd+o2yimQ9q9qhYqQgIQ
 ihS2xxZO3Ktw5quFJtTlZGzITQrmuvIKphBIWJg3mw==
X-Google-Smtp-Source: APXvYqzyPfv/xecnWNFmgiV366iAdVLiDuHA+bTghxUmEyBN5dbrMCtBN/czALmovteMSXgRldjOu2lnyXKLEdDwr74=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr3994816oib.48.1565945862801; 
 Fri, 16 Aug 2019 01:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMyv8gt8Gb6y0DMktnWnSKBw4ePwOXBzWkEpw5GVmyG0A@mail.gmail.com>
 <mhng-f7096b78-f11e-425e-8ade-d20c77ee1de6@palmer-si-x1e>
In-Reply-To: <mhng-f7096b78-f11e-425e-8ade-d20c77ee1de6@palmer-si-x1e>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 09:57:31 +0100
Message-ID: <CAFEAcA_gpS3odPN_1sxCjV+0bRrNn+=xmS=5JgUFvz2A332LEw@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 04/32] target/riscv: Implement
 riscv_cpu_unassigned_access
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
Cc: Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Aug 2019 at 23:17, Palmer Dabbelt <palmer@sifive.com> wrote:
> You're more than welcome to take them over.  I've got something that boots
> Linux on my unassigned_access branch (github.com/palmer-dabbelt/qemu), but I
> haven't sanitized the whole port for physical accesses and I haven't convinced
> myself that my hook implementation is correct.

Rather than doing
   if (retaddr) {
       cpu_restore_state(cs, retaddr, true);
   }

at the start of the hook I think you just want to pass 'retaddr'
as the final argument to riscv_raise_exception() instead of
using GETPC(). Other than that I think the hook itself is right.

The 'git grep' regexes in docs/devel/loads-stores.rst are handy
for finding the places where the target code is doing physical
accesses. IIRC the only ones I found with a quick scan were the
PTE loads in get_physical_address() via ldl_phys/ldq_phys, which will
now return 0 and run into the 'invalid PTE' code path. I don't
know whether your architecture requires some different behaviour
for bus errors on page table walk than that (you might want to
specifically code the error path anyway or comment it even if the
behaviour is right, to be a bit more explicit that it can happen).

thanks
-- PMM

