Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872C8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A902070A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 09:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eo/cpqYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A902070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxodJ-0000e0-Fw
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 05:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxocT-00005W-RW
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:31:29 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxocO-0001lO-Q4
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 05:31:29 -0400
Received: by mail-oi1-x243.google.com with SMTP id k4so16676194oik.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SdjWLQxwJ9lcRVCMyhQG81rCPJgI1Azg9CE+k70h7QE=;
 b=Eo/cpqYU7r+nGkejYfWD84K4xWpuWUBgWQdXvjIc22C+6Z5lCYaVS6KhXkDZVCXIY2
 Ldo55oJjS9IJf4SSUYgFXP2FNw4teAnWHqxHb2CJhozXNLkD2gGdYNwsUOHE8V6oxRTI
 GTVO0xcmulVzkJkx445vRi0Lb1uLTHmFqDuxZz+pc77ZoiUbtodAvPhhcvcbQiK8qatC
 ao1wSUDdV5eOXf2bRP+fF8+aduZxsSl2w+KXh4wwrBlX/4JJEnGHT6NnVtK9hfhs04CY
 YEnKOPIfW7L4ajhItPvB68yN/A4LjITg9nUX7LjwsZehe7fpy4vvNjvGlMDfiBfX7APD
 MXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SdjWLQxwJ9lcRVCMyhQG81rCPJgI1Azg9CE+k70h7QE=;
 b=Y/fqBXxp3GF0wU56LGprODdeVVA9OjK6pQVH8xnJgRiOa9YkIyco3AGxbkwdYOFBDL
 6Fk6A7bUfzM6YxUjqS5PO7DMGFMB4+V0JkmcobgTlgmGno5JarqPDLf+ad2x2ig/B81t
 l1SdxU7S3NqZV4UMBv47pBYSDSYtg3IQs3rQ2bZ2VLm2XSLxZPBB1oF1/A5ZDvzsCNPu
 jTIOP8J+ocKVJIMHrKe96nO2uHo57kRd30I2wQnjuRjxJMYx/uXIf1/MPluvz9bhh5Uy
 qzuD7/EK676wYjnjfp3oe/pfEQRagr+WvcQVN270mV8pbiA4W7WapiZo1gHRqxq2uJMl
 dMBw==
X-Gm-Message-State: AOAM533J6HAFMJp22jGrZD+dq5K7hBwtXmztL2s5TNY31pXwfcQViSwd
 fPxRhexcZ/ZAqy66cfgTL9UF9blB272pxw1uGLXMRA==
X-Google-Smtp-Source: ABdhPJx0i0QtE/PVf+pzY/L4tmeASL4BVkD9LdbMDYiRmX5P9ya4daYmce97DEBmCatHdyFn69ms+HvUh4u71qu4/64=
X-Received: by 2002:aca:1706:: with SMTP id j6mr2206671oii.146.1595323883474; 
 Tue, 21 Jul 2020 02:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwtUrSpCqNGEETBijewzvmpno8OAX_PKSShDP_gUQ-3VQ@mail.gmail.com>
 <CAFEAcA96mh_4EkKz31HgzfPOEQvhta8VTcvMV=An8Us0+x=NfQ@mail.gmail.com>
 <20200720191318.GM2642@work-vm>
 <7b38e1a1-12a2-0158-45ab-8e5d7e287f2f@redhat.com>
In-Reply-To: <7b38e1a1-12a2-0158-45ab-8e5d7e287f2f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 10:31:12 +0100
Message-ID: <CAFEAcA_9CozpnhT9GDOQ=t=JXLW-dPLodr5WuXxNaT7Sx7MESA@mail.gmail.com>
Subject: Re: [PATCH 2/3] exec: posix_madvise usage on SunOS.
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, David CARLIER <devnexen@gmail.com>,
 David Hildenbrand <dhildenb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 09:22, David Hildenbrand <david@redhat.com> wrote:
> virtio-mem depends on Linux (hw/virtio/Kconfig). I guess
> userfaultfd/postcopy is also not relevant in the context of SunOS. So
> what remains is virtio-balloon.
>
> virito-balloon ideally wants to discard the actual mapped pages to free
> up memory. When memory is re-accessed, a fresh page is faulted in (->
> zero-page under Linux). Now, we already have other cases where it looks
> like "the balloon works" but it really doesn't. One example is using
> vfio+virtio-balloon under Linux - inflating the balloon is simply a NOP,
> no memory is actually discarded.
>
> I agree that POSIX_MADV_DONTNEED is not a proper match - different
> guarantees. If SunOS cannot implement ram_block_discard_range() as
> documented, we should disable it.

Could we also improve the documentation comment to make it clearer
what ram_block_discard_range() is actually supposed to be doing?
At the moment I don't think you can figure it out from the comments,
which are a confusing mix of claiming it unmaps memory and that it
zeroes it.

Is the Linux-specific stuff (userfaultfd) a *requirement* for the
function, or just a "this would be nice" extra and a valid
implementation would be eg "zero out the memory" ?

thanks
-- PMM

