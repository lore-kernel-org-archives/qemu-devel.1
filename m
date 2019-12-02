Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1798C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECD320833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiV7tWWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECD320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibjgj-0003EF-Es
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 06:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibjfP-0002NF-L6
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:15:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibjfO-0008CG-G0
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:14:59 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibjfO-0008Bx-AV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:14:58 -0500
Received: by mail-oi1-x242.google.com with SMTP id k196so15668325oib.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 03:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xN2DMI7ujIHJDmHjQcTmxMXXC1w59NzaLVTz8uCIN04=;
 b=xiV7tWWoibjcZDYkMIDqkXiXMYwQCKblJ/ZFe6EVovM5woD8kjN1WRON36vxeVnn8d
 BDRsPARpuFvIKD0QrSwyu/2/ARUmUpy69V10/vOn/5JXjwEclFeeUcTluSAPi+4mEaOB
 1yLMMLFxp3Myfrwugb4PitEGGsqhEF/8cJpPaRLUp/PXNf8VUd0EAxSRf3qmHQuzJX2K
 /nH747q/4IPdw1rM/wWkSOVf23Ns60t+eKFxpkuBgS1BYDe4c8t6+wqr7/JkHDItXvTh
 /FDGseOA/NIAKOu64pMW+KHT9ygco/xPZT680GyAQBS7OjdllB5bFVy1urMAM7j6Doxz
 LHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xN2DMI7ujIHJDmHjQcTmxMXXC1w59NzaLVTz8uCIN04=;
 b=HuMu8P5aNYOovzsPaRSQPEIL2fWHIjXn+BlxTXqYvcVC9yyl3ff07Tj0oxMOec8aSd
 E/7opgEBtBZDNQ823TeUL4Hb32vOuvC7V60U1PcdrTbal1STanEEjneQW/cXw6AA5zEx
 oxRF0jamV6gYMloxz8bM7VBFQd38/alw9iB5DlU5EUtyJlwkvdoLZeGHYtBRTIqepkFq
 XBoW9DrBbVrf6wMIulLMxdA5fQpl3oKust8As1B4yeAVf13nqaOisYgFdBMB70dnkkz2
 dLgY8I4350Cj3tbGIgP5epOyBM9LE2bDMB+25ZjZsVTkhyLcsM0JEUnp/JJcnzQiYEja
 1kjQ==
X-Gm-Message-State: APjAAAXXY8LGWjn4IRfLuK/yfPQs0/b88yoR/nqFcD6ORyNdPpRJd6/m
 4S2BvPtn7oxGgpg9qaUGspron0lvz/xijX8+v7uQ4A==
X-Google-Smtp-Source: APXvYqwhdMvCsN7xbqAwL+fzv9rQtKSYdpsOk3oogHIaCpRpKhke0OVzeyJvgCyLrVkm/Dp4Reh7DAhro61e5TjTNPo=
X-Received: by 2002:aca:f5cc:: with SMTP id
 t195mr20322028oih.163.1575285297444; 
 Mon, 02 Dec 2019 03:14:57 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-4-damien.hedde@greensocs.com>
 <CAFEAcA9kc1-=DkYSqL6DOrLCNKt5uuxnf6-XYJ97g15T--1NvA@mail.gmail.com>
 <20402bef-d615-3258-bde9-12d42c9b1029@greensocs.com>
In-Reply-To: <20402bef-d615-3258-bde9-12d42c9b1029@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 11:14:46 +0000
Message-ID: <CAFEAcA_XqjUhYvKmr-dNJCL3w32WPegqLmTw5FSDwAPZ+HeGkQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/13] hw/core: create Resettable QOM interface
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 at 11:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
>
> On 11/29/19 7:32 PM, Peter Maydell wrote:
> > On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
> >> +/**
> >> + * enter_phase_in_progress:
> >> + * Flag telling whether we are currently in an enter phase where side
> >> + * effects are forbidden. This flag allows us to catch if reset is called
> >> + * again during during this phase.
> >> + */
> >> +static bool enter_phase_in_progress;
> >
> > This looks weird -- I don't think a global for this works,
> > because you might have several distinct subtrees of
> > devices, and be doing reset on them both at once.
> > I think that we only use this for an assert, though -- is
> > that right? If so, we could just drop this.
>
> We say that we need to own the iothread mutex for any reset, so global
> should be ok. Thought, I just checked, it's only mentioned in the
> documentation not in the header file. I should probably add a comment
> there too along with the link to the documentation file.

Ah, right, I hadn't considered that the mutex is effectively
restricting to only a single reset happening at once. If
you want to keep the asserts you can, if you add a comment
noting that these globals are (a) only for asserts and (b)
OK because we rely on the iothread mutex to ensure that only
one reset operation can be in progress at once.

thanks
-- PMM

