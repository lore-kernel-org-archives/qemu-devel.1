Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CACC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B672086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9T9qcq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B672086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLnJ-0004Ls-M1
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBLT4-0002tE-MS
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBLT3-0003nO-1Q
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:09:10 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:43072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBLT2-0003nA-Py
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:09:08 -0400
Received: by mail-ot1-x329.google.com with SMTP id b2so6610505otq.10
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ca9D4n2lJb2pHAyPci+XJ8KDpp5YY/U6iggyXDj5qws=;
 b=W9T9qcq7tlFhbrdM0g9aI3NKxC8IFWl8Fl2P68+0LlsGbyXXDtfVpEGezKpt8taW+q
 jiItRtNZZas6WUuPviJk2sbWN9F8rmXfzLs7a8RvtP5d7q3DHOIgOdsza4hHfewnlJlH
 liFusTkS//QflSFPlnlGM4eCcDwdv2tqxRGGe+QJGJHW0AeVoe05bAKMP9vCobjB4/i5
 uDiN7y2EEDWgtyjPBM98G8h3iZrcuSfnqTtxJX/nwwiGlWmLm6uJ5J7X5J0RjUivgtpX
 7jCG9ChQ99GSstY2yv5fUll6WlfFQuYbsftLiV/OBrEiHAD6T+6iVgou58xdWg/AYgr7
 q9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ca9D4n2lJb2pHAyPci+XJ8KDpp5YY/U6iggyXDj5qws=;
 b=QURwBjEUB/zWrUYZQN6WQKfVTsCAZ+6nbEjKsu8UaUyzprVX4We+NU1+kPypLqRkHm
 0EaGqzJ6eH/7TeaSFmQDjbSzUlkLrO6eJsiFxlCB6HvehBFMp9Bl5qCHZKe/3enujjg4
 9zZRDKrHz0y301U+ywqGWE5wsZXU2DYVhIEQcQCmt8ySXJPExJVqrvKl4sjmEKWTzhFS
 yv5zCI99EzllmhOr3vlLU8M28MgQ7K/evWW3JalxzA6IX/1Lwk9bsbLFHcRsvu2dLLvK
 r5jg60zYldWMGHE5M0PiMvepy5pW48fHYRQ91ThgSdo1a4/rK1xWkhH1hPDfh9GeVuDH
 YhiQ==
X-Gm-Message-State: APjAAAUJkVw7q8Uq+dYNTEOqi2+J6hO9Am/lCwG0WqUdxkhdvTho5Mzc
 6uzp3FnmZ5hRLRWN4ytVzqJIav3W+JhvwCavYPxTom/OCQo=
X-Google-Smtp-Source: APXvYqzNE5Kl3xmsFBqfPUOyEKPbwKLhdAlhCnrPlzTDHOGL11lopthL5IguvU5CudkIfB9t2TwgphTkwJ2lbpm7Wrc=
X-Received: by 2002:a9d:562:: with SMTP id 89mr12738485otw.232.1568995747290; 
 Fri, 20 Sep 2019 09:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7BDD949D4C752E2A291A6A02@qq.com>
 <CAFEAcA9QDrwUAdZWX7n_gO9afnT4n9+i8ZdqOcxrNbvi6n9=sw@mail.gmail.com>
 <tencent_5378456F7A2F471F74C049FC@qq.com>
 <CAFEAcA87Pb4Mk8McdaZHe41s=Cc1EeCknKfikRm6F+QoxKsdgg@mail.gmail.com>
 <tencent_7D89E27172EB5C93465EFBB4@qq.com>
In-Reply-To: <tencent_7D89E27172EB5C93465EFBB4@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 17:08:54 +0100
Message-ID: <CAFEAcA-GEtZUVU838Cb0j7ekUzrQ9VTLFfFVL37BALzk_VQFBA@mail.gmail.com>
Subject: Re: Initialize data memory in user space emulation
To: Libo Zhou <zhlb29@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 16:26, Libo Zhou <zhlb29@foxmail.com> wrote:
>
> I actually thought about hacking it to mmap from file into guest memory b=
efore running ELF. In include/exec/memory.h, the function memory_region_ini=
t_ram_from_file sounds like what I need. But the entire memory.h source fil=
e is wrapped by #ifndef CONFIG_USER_ONLY, I cannot use that API in user spa=
ce emulation, right?

Correct, you don't want to use that. You want
to put some code in linux-user/main.c, probably
just after the call to signal_init(), which opens
the host file and then calls target_mmap() to mmap
it into the host.

If you happen to have the source for the guest program,
you could also just make it do the open and mmap() itself
as the first thing it does in main() -- this is basically
equivalent. Or if the guest program is dynamically linked
then you can use QEMU's -E option to set the LD_PRELOAD
environment variable for the guest to make it load a guest
shared library that has a constructor function that does
the open/mmap before the guest main() gets control.

thanks
-- PMM

