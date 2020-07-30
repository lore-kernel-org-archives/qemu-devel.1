Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD6BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C673206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 08:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HgT3JLH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C673206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k14PI-0003vK-EH
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 04:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k14OZ-0003Ty-Vr
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:58:36 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k14OY-0001fr-CR
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 04:58:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id p25so10191644oto.6
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ymw4K8AkuTbcQRjI6IoqmRadpzLWLizc23boAkK7D9o=;
 b=HgT3JLH0vw4FSo+8dI6cO+FFg3pJW1sw+YwAqBxKVXGcSco4QXL69KpfzXqh1Knbhd
 UDL5MwYd3D3Yf8gJYM4jPFDqtEngahNwjJwpPF8qFNi3xxqTURWgJSEQsZrI+05up6qx
 QWm7Pgb9rFSoGWX6fTRtxOZ5fC+povLIbIQtr8MweedQdK/hE3eO7KvBHdOxchBzDiyF
 afJgYBEY96/Uy0f96Ylhi2d0yP8KN/t9vdT/kqvQO1zYWo10sh9cuNrb4xO995IS4nAq
 Ihu0wYYljCcrU9IeU5ayAYDeQVtjPS60eWgo5/KbECjk/66uizzEMCMVMOGolLOieVS9
 S1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ymw4K8AkuTbcQRjI6IoqmRadpzLWLizc23boAkK7D9o=;
 b=IV2LJnwxsyjsAT7m12Y01Xg0hxgiqoV/Btmphvqs039dOGgdu9nrVlXpT7U930PRw6
 pZ06EbsqfWZ496Ik9hQ2Ru26kadTBSu1x8IF9IqHg/kRL9V3v7hipOsM/rsIHd0KTbNw
 Y0jiC2oTO77ZezuGwMDY9LEv6ggBKh9KZkkXGDYjxpWIg6FUtLzJn2geZZcTm0b/XcqL
 diwu1/6qwN51/N7RLcwMuMVieZascw7v3a0uTkysGbFtFwzJpbRw6WVOvoXVIRJZcVb7
 bTqJymty4vsA1wjQhbctnlYXd+ugH8oCBwRj33EXo0Ofd8pNqdYrc0VvYwKJ1eKqIit+
 h08g==
X-Gm-Message-State: AOAM531gJBX/snKkZPGOoYItM3Kv723oInZzethnL9ZVtn1swRtgEElW
 AdsCoeqMPuZjUmzatrbSIOqH97E6/S0/bl8b+VVa6g==
X-Google-Smtp-Source: ABdhPJzE1hm95JZmPUCP6UdHbok+BngJTGqeuUXPSfXv6C68L4nARNNK/88D1h8MIFeo/dwnOjrykNJPPsLJJODCl0U=
X-Received: by 2002:a9d:5504:: with SMTP id l4mr1402204oth.221.1596099512247; 
 Thu, 30 Jul 2020 01:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200729221732.29041-1-e.emanuelegiuseppe@gmail.com>
 <20200730074146.b66tur2v7tx4uo3d@steredhat.lan>
In-Reply-To: <20200730074146.b66tur2v7tx4uo3d@steredhat.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 09:58:21 +0100
Message-ID: <CAFEAcA9A6_S0NEzjmjvxJofFQVKgZS2U_YjgW7jwEo--irNQyw@mail.gmail.com>
Subject: Re: [PATCH] pci_dma_rw: return correct value instead of 0
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 08:42, Stefano Garzarella <sgarzare@redhat.com> wrote:
> I agree that it is better to return the dma_memory_rw() return value, but
> at first look, no one seems to check the return value of pci_dma_rw(),
> pci_dma_read(), andpci_dma_write().
>
> Should we make them void?

In general code (eg device models) that issues memory transactions
need to have a mechanism for finding out whether the transaction
succeeds. Traditionally QEMU didn't have the concept of a
transaction failing, but we have added it, starting with the
APIs at the bottom level (the address_space_* ones). We haven't
always plumbed the error-handling (or the memory-transaction
input, for that matter) through to some of these other APIs.
I think for consistency we should do that, and ideally we
should make all these APIs look the same as the base-level
address_space* ones, which would mean returning a MemTxError
rather than a bool.

We should also figure out why the dma_* functions exist at all:
they include some calls to dma_barrier(), but not all devices
do DMA with the dma_* functions, so we have an inconsistency
that should be sorted out...

thanks
-- PMM

