Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED61C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4932121835
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 20:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4932121835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHwIh-0002un-Fb
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 16:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iHwHs-0002LK-5z
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iHwHq-00026o-TB
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:40:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iHwHq-00025n-Ml
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 16:40:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so71750pff.6
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 13:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=f3kudtvGYxlXh3MAOnee5/ieD/uknhf/2EwfZfkIDgE=;
 b=SuMacqMpBuYVT6IEisA0vc/aJxLUB82ul9G5MKgO5oHvcpqdfgqjqr6q7HzFXNW482
 1BBwsrCS6GWfoEzNZSEvdGhQcbNqStQq7kQx3xDGfCAHLj/jqcEB4YIwNa1qEBRxd97S
 aT7UoBGe95iLdD0LsY1C4kksGEmWR50QfJwAoSqbQE3Pnvg6IHBuRlNGdSnZDcnGAdgx
 r4QkdlAZtjijxVWas7hnrePKXaz/wmZnPYKEK4NA18jXks3Z83Ndl7LanKvvynuGeQ2n
 rWWg8R5YP8NOM+tR1D1IoVAjKTl77kNT+9xsBF9XsbLbXHRGrMWQp4n/ZYCKLuvHBZCL
 I2fQ==
X-Gm-Message-State: APjAAAW+qT8SPO/dnEeiIS6uOr9rrf/tbCkdwo+Wo7eYRP0yLUyoFdXt
 Yp2GrA5GyKRGSblUn841Anu3yA==
X-Google-Smtp-Source: APXvYqyzhIGuhFt1ZDQsmHRXZwV+9RVGAZgxmpGIZqC74rU24LhaZI9YA+rh+gyYMU6cWuFBGVokjA==
X-Received: by 2002:a17:90a:9318:: with SMTP id
 p24mr7950258pjo.31.1570567249069; 
 Tue, 08 Oct 2019 13:40:49 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id c14sm14088pfm.179.2019.10.08.13.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 13:40:48 -0700 (PDT)
Date: Tue, 08 Oct 2019 13:40:48 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 13:40:35 PDT (-0700)
Subject: Re: [PATCH] memory: Replace DEBUG_UNASSIGNED printf calls by trace
 events
In-Reply-To: <CAFEAcA-O6b5zc=Qp-49Fc9_tQ+a+Stk6DfnwwzDON+RZfSDSfA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-86e6be44-c5dd-4ecb-bdcb-1f490db0f2cf@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
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
Cc: laurent.desnogues@gmail.com, pbonzini@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 07:20:34 PDT (-0700), Peter Maydell wrote:
> On Fri, 20 Sep 2019 at 15:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> I think it's simplest if all series (RISC-V, remove unassigned_access,
>> this one) go through the RISC-V tree.
>
> I don't inherently object but IME the risc-v tree tends to move
> comparatively slowly. The initial risc-v conversion patchset
> should definitely go via the risc-v tree, anyway.

We still don't have the riscv_cpu_unassigned_access() removal patches in, which 
IIRC got blocked on review but I can no longer dig out of my inbox.  IIRC the 
patches Alistair sent were still "From: Palmer", which means I can't review 
them.

I'm fine taking this on top of those, but it looks like there's still some 
debate about the patch itself.  I don't see a v2.

