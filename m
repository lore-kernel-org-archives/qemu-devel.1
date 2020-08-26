Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FB1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 20:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D7B2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 20:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHt4udhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D7B2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB1wR-0007V9-9I
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 16:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kB1vv-00075Y-3W
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 16:22:11 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kB1vt-0004zv-4w
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 16:22:10 -0400
Received: by mail-ej1-x641.google.com with SMTP id o18so4627771eje.7
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fnQGHSNPqYltpXxz4WtFm2hnsR/gOa/Cf6xE8CbQEI4=;
 b=LHt4udhT/z1LfgRd/fmkZkR5AG1nZu7g7s3EaC5Ct8d+c3/s2BtjNiYXGGR4vifJEU
 PcM/gLA12HRtHCSyZyHAIDELBVgOJ0rcj5BGtRaPsiOwYOd/IClc1uwnwjlrw93Ynvmz
 cz5JuCvt1YyTIzclC5C46odb2F+vsg6jvJil4obrmpLVSob5U85atGw0DNuxjwB8DC/b
 hlfz2S3DQPQgRAmgsyAaaHHPaUaeFnRgLY4zh78msVCHiknmUDCVOTn+8rvl45hinnc4
 svI5WCAS8zWa0FmeWnLvJ7Fx5/PqNimPXZpvw/yd/turrwSmuG7nvqaDZz4bxo8mfanU
 iKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fnQGHSNPqYltpXxz4WtFm2hnsR/gOa/Cf6xE8CbQEI4=;
 b=SPcTuje+i7XK9p6BTx1RB6Aps4lkipgL9MIX3D8ybw/hYau44V2lv4hS4fEPvXvRlU
 /YZG6xZr9bEiHxnEsP7kl3eL+UuuQ6A5XQBKuNmUWZ+LCKZMgzt/CIR6Q/KGmvKRx/WN
 wheULPtprBxshDO9sWCzDvdK51qGSTQYIvNBnsE8n/s6/Jop/9BNAecFfFI2iIPyhlnB
 iY/rQSJSzlJVUVHECoJCgySuMNSI5/4hbUsbTyxzRN190zEnzez/9lgP5pfyOxmUBPkj
 jwLbVN26X5ZwxEF/0UXO0ghvTpSCaGEkuKj/eGnoRTuniV6/+Kur9PRAvYsRI7oXROuS
 NhLQ==
X-Gm-Message-State: AOAM531Dc5dP2Mr+70OrInDY/kfPxPVFX+IUUZPtjLjh9fb9AO/clHvS
 22sjqSvwyPyS5ibec0ZBYwwEWaBdHnfpvTbZvsmswA==
X-Google-Smtp-Source: ABdhPJy23baBCoHmGsNe543d03pxueNxFqS/qCt+EKVycicL7iDH3ekEPlXcNvGE3OOPtKIDkAJ8NI159AXGiI23nQo=
X-Received: by 2002:a17:906:2b0b:: with SMTP id
 a11mr7713371ejg.250.1598473327160; 
 Wed, 26 Aug 2020 13:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200810132441.16551-1-deller@gmx.de>
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Aug 2020 21:21:55 +0100
Message-ID: <CAFEAcA_bQZwgZNJ3Zsc54chBSz+jvN403uvCFJkpJqh6MY43rQ@mail.gmail.com>
Subject: Re: [PULL v2 00/12] target-hppa fixes pull request v2
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 14:24, Helge Deller <deller@gmx.de> wrote:
>
> Please pull from
>     https://github.com/hdeller/qemu-hppa.git target-hppa
> to fix those bugs in target-hppa:
>
> * Fix the SeaBIOS-hppa firmware build with gcc-10 on Debian
>
> * Fix the SeaBIOS-hppa firmware to boot NetBSD again
>
> * Fix many artist framebuffer out-of-bounds accesses as found by Alexander Bulekov
>
> * Fix artist memory access bugs due to commit 5d971f9e6725 ("memory: Revert
>   "memory: accept mismatching sizes in memory_region_access_valid")
>
> * Fix various artist screen updates when running dtwm on HP-UX
>
> In addition the SeaBIOS-hppa firmware now includes a version check to prevent
> starting when it's incompatible to the emulated qemu hardware.

Hi; this (via the tag target-hppa-v2-pull-request) has
a format string issue on windows and 32bit:

In file included from ../../hw/hppa/lasi.c:14:0:
../../hw/hppa/lasi.c: In function 'lasi_chip_write_with_attrs':
../../hw/hppa/lasi.c:177:17: error: format '%lx' expects argument of
type 'long unsigned int', but argument 2 has type 'uint64_t {aka long
long unsigned int}' [-Werror=format=]
                 "LASI: tried to set invalid %lx IMR value.\n", val);
                 ^
/home/peter.maydell/qemu/include/qemu/log.h:120:22: note: in
definition of macro 'qemu_log_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^~~

PS: also I've just noticed that your pullreq email doesn't
have the standard git request-pull cover letter phrasing;
if you don't use that then my email filters will not notice
your pullreqs.

https://wiki.qemu.org/Contribute/SubmitAPullRequest is worth
reading if you haven't found it already.

thanks
-- PMM

