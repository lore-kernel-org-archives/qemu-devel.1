Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E544C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E113F2067C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8jI6Z1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E113F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9rWk-00031n-6f
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 11:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k9rVj-0001vD-Ke
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 11:02:19 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k9rVh-0007PY-JV
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 11:02:18 -0400
Received: by mail-io1-xd42.google.com with SMTP id b16so6190523ioj.4
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Wl1v7yks1EYxKyvHpSMP9pYPn5zKIdcVIjJpgqd3QsA=;
 b=u8jI6Z1E8J9WFDv7Q1pTge8dQSVbKa1elJkAE8+TIcX5a3T6vVtW4Inz+NUNxKD3gF
 Ai8VPUK8SbyGO1rDoHsAdaC3yMOxUzNLmn9yez5A2iuzwBdhMBfpTvRJHzfVU/jZeJzW
 YqA1/zW6oG5Y+xpmjE0v2Rv+hAEr7cr/EaVqR1ZXNCWbAqyBwE5RSBuv1fTKCHrNbI97
 Ij/RaFLhKhKo8cW6hOI7LGWbf8iWcCO4k/wR7ogJv1cksMVwa6GWuzr+saNuYgYfCRvO
 W5UL9FxSnWeS7ndMElUBdtdOyw8dQP2J384Q2i9ntO++KyfCzATNQAN3nn8hg2yGcMni
 vGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Wl1v7yks1EYxKyvHpSMP9pYPn5zKIdcVIjJpgqd3QsA=;
 b=aucSRIK1QegZNEK1pwtyQ099oAiT6rdbYPHT/io7OH5WUHV8XQnR/QFu8ATCSmc2SR
 gefbypJB2+9Dpp3Sjim73Mkr3lbxuJv20gMC/3liaFb3fcKx81/uls6cNraoxIxfRuOS
 AqBsZ8B98IiRDmTPS/u9seKktXcO7wUjUq5QrnMqu+p9WoZY5MLUHdAdw5mMOMABUY7n
 K2EZDLEgyQBwlurRF4R3oySs1oyYNM5KSv3TKBFWKbr8WKbvS5kKjLON93+PbwQtj/fl
 kOwg1azUB2jut8ytR3kb0Agqc92bwwBX3w7Enu5uERQA+nkcysonobno7yhK967Qm1D2
 82GA==
X-Gm-Message-State: AOAM532QEIuSdcuNwi5Qf/E5r6OCjxfkpsySjL4aph9pAt1pYvYf7OV+
 RxS1Z4SfUX9AFwwCuPYcHsDNskH09PG0U9wwNFubCg==
X-Google-Smtp-Source: ABdhPJzGCW2ne1C+fzGrA6lLN+GmHs5j6Ier9pPU8upCAAARb8FtIadvkWGjmNS0oYeb0YCdcwp+GGEYstfbxi+kyyc=
X-Received: by 2002:a05:6602:58:: with SMTP id
 z24mr1384804ioz.76.1598194935908; 
 Sun, 23 Aug 2020 08:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200806150726.962-1-philmd@redhat.com>
 <20200807100256.GC600298@stefanha-x1.localdomain>
 <451a50f0-d0ce-5d3b-a38d-e1ca6c0f882f@redhat.com>
 <a3a263ba-68e1-2fd8-22ab-93e2cafdcdfd@redhat.com>
In-Reply-To: <a3a263ba-68e1-2fd8-22ab-93e2cafdcdfd@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Sun, 23 Aug 2020 11:02:43 -0400
Message-ID: <CAEyhzFtAssGdRHxDBnYgeWaJdM02Yby+SRvgm5wSuzi4Dvxo8Q@mail.gmail.com>
Subject: Re: [PATCH-for-5.2] exec: Remove MemoryRegion::global_locking field
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=robert.foley@linaro.org; helo=mail-io1-xd42.google.com
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
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 22 Aug 2020 at 16:13, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> +Robert
>
> On 8/7/20 12:16 PM, Paolo Bonzini wrote:
> > On 07/08/20 12:02, Stefan Hajnoczi wrote:
> >> On Thu, Aug 06, 2020 at 05:07:26PM +0200, Philippe Mathieu-Daud=C3=83=
=C2=A9 wrote:
> >>> Last uses of memory_region_clear_global_locking() have been
> >>> removed in commit 7070e085d4 ("acpi: mark PMTIMER as unlocked")
> >>> and commit 08565552f7 ("cputlb: Move NOTDIRTY handling from I/O
> >>> path to TLB path").
> >>> Remove memory_region_clear_global_locking() and the now unused
> >>> 'global_locking' field in MemoryRegion.
> >>>
> >>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> >>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
> >>> ---
> >>>  include/exec/memory.h | 14 --------------
> >>>  accel/tcg/cputlb.c    |  4 ++--
> >>>  exec.c                |  2 +-
> >>>  softmmu/memory.c      |  6 ------
> >>>  4 files changed, 3 insertions(+), 23 deletions(-)
> >>
> >> It can be added back in later, if necessary. For now let's drop the de=
ad
> >> code.
> >>
> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>
> >
> > I expect it will come back since Linaro is working on BQL-free interrup=
t
> > handling for TCG, but no objections.
>
> Robert, any comment on this patch?
>
> Thanks,
>
> Phil.
>
Phil, Thanks for the heads up on this !

No objections to removing this.  We can easily re-add it if/when needed.

Thanks,
-Rob

