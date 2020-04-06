Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5382AC2BABC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 12:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC0E22204
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 12:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTyPuxhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC0E22204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLRFk-0008Ty-Ad
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 08:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLRF2-0007si-5d
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 08:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLRF0-0007K9-JE
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 08:52:39 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLRF0-0007Jb-73
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 08:52:38 -0400
Received: by mail-ot1-x341.google.com with SMTP id r19so15130607otn.7
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=8Tw2ZKzXe0m4v78hh6UdCKpCVFPhn+c3/4+FVZ/dArU=;
 b=sTyPuxhjyPZTStaIB2szt3y1f1QQtbKbBGy6TfiG2KKwlqrWaTQNroPYJZTh8GxKtW
 8iKmnv+aM+hVDig18relzqTr99IffQrTtRzTUwYBNM/3lkOhj+i9NLkwD0OmrCjq4ClU
 vlUN8EMIzubLElsUp0LIfcEf1Flk6omxDE/9U7cAPeOpKlHWbc2YzI4237w80ExTBQJz
 HGNay3zyUi60mAoyNkxc7Fz6mWMu8yDnizdJMRi+FhYMDyLSp8aaLK+b0PDEpDKmV6S+
 mYRwai2nQFS7NWfYwpjqpPCVy3rNGn/t3nTY9sU23ZhRH3WnalPhlw08qc97gsRqLnwb
 9ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=8Tw2ZKzXe0m4v78hh6UdCKpCVFPhn+c3/4+FVZ/dArU=;
 b=iKAwiTTWFBtb5JUG6SEkJCbdY4VOqUH4GDTlesufzgnWcwIiZxbmw5z/+LBLTZyp6D
 pjkehihYrnfbgyIzZkR8XisMeai5a7o94+ZYTFClDhgLxFw6YE02VYYjdGGOgVrZJLH8
 PQ5ThcUosYHxBvf3yKfceaAGN32PQHtsl0UGs4X1XY4bcOzyNJANx+zSXbAF15GGCpsS
 Lz65Ta3mNzWJNT6QwKxkH45LdV5Zn3BDBcGvfivpTJhOWWAhBc7v37vLmBVYGRs3PbLC
 +8c3lYUzDDE6ecQa0euShbD35EMkBor58H324BoiaJpi0K8n7ObpUKo+nbikUnjx0Z/c
 ynuw==
X-Gm-Message-State: AGi0Puaa9FRvKDiCbqmAwemjRPCgPltMFvv134gJg8S53GjjE9PtAPtw
 YqwPTfv+B+MOU6LqaUmcswjONAhO4EFWnubz80I8wkIafwk=
X-Google-Smtp-Source: APiQypJkULmheFB27xUrpxx19WZ4oVmzaxiKM9HClA1GTJwSuf5J6m2sIFEGGrSsJaUodX/hMWYZ9PhabHv2868v4jI=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr16446205ota.221.1586177557080; 
 Mon, 06 Apr 2020 05:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200406101205.23027-1-peter.maydell@linaro.org>
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Apr 2020 13:52:25 +0100
Message-ID: <CAFEAcA8dQnKyOcQwk1JKksVeQtb9t2s+=H7YkH-77d4wfKfwxg@mail.gmail.com>
Subject: Re: [PULL 00/11] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Mon, 6 Apr 2020 at 11:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> A collection of bug fixes for rc2...
>
> The following changes since commit 146aa0f104bb3bf88e43c4082a0bfc4bbda4fbd8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-04-03 15:30:11 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200406
>
> for you to fetch changes up to 8893790966d9c964557ad01be4a68ef50696ace8:
>
>   dma/xlnx-zdma: Reorg to fix CUR_DSCR (2020-04-06 10:59:56 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * don't expose "ieee_half" via gdbstub (prevents gdb crashes or errors
>    with older GDB versions)
>  * hw/arm/collie: Put StrongARMState* into a CollieMachineState struct
>  * PSTATE.PAN should not clear exec bits
>  * hw/gpio/aspeed_gpio.c: Don't directly include assert.h
>    (fixes compilation on some Windows build scenarios)
>  * dump: Fix writing of ELF section
>  * dma/xlnx-zdma: various bug fixes
>  * target/arm/helperc. delete obsolete TODO comment


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

