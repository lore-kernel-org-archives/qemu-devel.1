Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472ABC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDBF206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 12:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDA0ro3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDBF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRII-000747-BP
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 08:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1joRHW-000638-DO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:47:06 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1joRHU-0007st-NN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:47:06 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh7so2737265plb.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CZT7KsVFJoXgYIQ3BDxgFCsw5gMPVNSQWfr6gj8r6+M=;
 b=gDA0ro3HinoNN646EZ526zz61wT6PxS1E89YrXZBcLxfqfjBdSZostB4M+CBoAYkjC
 LNqUusxHjzNDT0M1dKGCDQ9JKxXMZPFAZhgvXaBUuZReINPVR22ng2snepOPrnYT1Xc8
 8rNndyobkgcPJBiDGuKuoyir9rXk7W+ggWmGY/spcDvIJqY3hIs/lAh76+hC3YuaaCLA
 TcFjyisfbW8L/uUE/McxbuXVLigWXRVF48Fff1mWsvo/WkJD7Cuf85XMZjORSq7Bh7uX
 OEU63DghCkGmL7NM2sWxh+ldtAuICgXP02L0A2aKNsDDBO9UWPu7oOI8ts2VHFV+jN7L
 alRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CZT7KsVFJoXgYIQ3BDxgFCsw5gMPVNSQWfr6gj8r6+M=;
 b=mUkvLpm/3cnZjebQfY50ErxhIftUy1g/uOrCbcEGUjMPoABwA7b8CxbciSwAoUnD7r
 /sCjKDi+I0dABqSih0kLU1RuuO5JH3PcZ1wdi6zX9L1Ly+pK5wSFhF+41cqWWc+Ng1YL
 RAJBP49O0E+SspIFLgT8tYTICn0i8lLsO75DOyhr+i9/sssolwyS581U1bF3FZADIrk9
 MJzvs7s9fcuNBp5S18l2k+SE7RlNCWMNnSlajSB/xgdX/qv1nmT8kBMFg44OqN6Ofgmq
 zO9wZGE38BOk2F2tgAQcw0tQhmmooXWLzCgTFI9zPbkMa6QRKe4bCs/chfC2Jokk8mfl
 EjWQ==
X-Gm-Message-State: AOAM533AbhsviTcgrnk6dKx2Fq4ArAFDtrzZQ5dcf0oEGoILuh8nMiX8
 ahC16chgUhJmLkznqYH1wEc=
X-Google-Smtp-Source: ABdhPJwrbFNVGwgJUJvMcBbXPA+bgUMMHDdlMYQHvvTCQrbvam5M3xd7TOYskcsOfg8ZDRqD+vN3xQ==
X-Received: by 2002:a17:90a:2843:: with SMTP id
 p3mr2920281pjf.187.1593089222902; 
 Thu, 25 Jun 2020 05:47:02 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id z85sm23989743pfc.66.2020.06.25.05.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 05:47:02 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 25 Jun 2020 20:46:56 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200625124656.ddca4ofgfhdgoerj@Rk>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200619120746.GA2422025@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200619120746.GA2422025@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 01:07:46PM +0100, Stefan Hajnoczi wrote:
>On Mon, Jun 15, 2020 at 02:39:02AM +0800, Coiby Xu wrote:
>> v9
>>  - move logical block size check function to a utility function
>>  - fix issues regarding license, coding style, memory deallocation, etc.
>
>I have replied with patches that you can consider squashing into your
>series. I was testing this patch series and decided it was easier to
>send code than to go back and write review comments since I was already
>on a git branch.
>
>My patches can be combined into your original patches using "git rebase
>-i" and the "fixup" or "squash" directive.
>
>Please add my Signed-off-by: line to affected patches when squashing
>patches so that the git log records that I have confirmed that I have
>permission to contribute this code.
>
>If you have questions about any of the patches, please let me know.

Besides your Signed-off-by: line, shouldn't I also add copyright info to
the affected files as follows?

  * Copyright (c) 2020 Coiby Xu <coiby.xu@gmail.com>
  *
  * Copyright (c) 2020 Red Hat, Inc., Stefan Hajnoczi <stefanha@redhat.com>
  *


--
Best regards,
Coiby

