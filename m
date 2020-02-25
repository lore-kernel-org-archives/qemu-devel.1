Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E06DC4BA09
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 23:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7558224680
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 23:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7558224680
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mborgerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6jiy-0008TU-L3
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 18:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mborgerson@gmail.com>) id 1j6h6Q-00013K-76
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mborgerson@gmail.com>) id 1j6h6O-0001rD-Tt
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:46:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mborgerson@gmail.com>)
 id 1j6h6O-0001l7-Me
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 15:46:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so416742ljh.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 12:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VAYazKpdQeEXlvMSuhH0O0iMMqzpIv56wJ1qUaJvcfQ=;
 b=QnadqdetqZChDMhcQkM4m+0uyUjKRLsc/bhOtnr4Q8QupPk/eSEOI9NaZS5RrFizzq
 uMLcgTwiIcf0WRY0iQXBpqIrzoBPvfV8EsPeIHkBI15QT/wBbQewqFHW6wK/9C5EaJ0o
 Rn+tDFtKEseaCAggWKEhLROA9x2v6PBFOPPRw8nGf3DEFfPwHXphT5ZzGTIxg1N2VFL4
 Ec4HChxgFuMoJVkXXXpcWyPZuhOtFDFQPpS2Mbo6tjOPD4Kbj6WIp638HgZelPJhh04P
 Afw6uHungQF5pyzZBkDJRrbFpAxrmvfdqCFIWG7wX2Ng01EAhnfFow4lz7Sbxnv9Oc0M
 MhCg==
X-Gm-Message-State: APjAAAUnkv7xPMkF6mPGN0OF33klhXm8Op5T91zLHCRa7wIm0DxeLtlN
 qutK62rZvl9VtpVD7TEWPkkoMsyq874=
X-Google-Smtp-Source: ADFU+vsCeuIajc/dOLsrv1r7/tCx1rY/aJ7p/4VIhsu1orJxtAsBko6z236Aj8nZYc+QrXPr4GCuiQ==
X-Received: by 2002:a2e:8755:: with SMTP id q21mr551514ljj.156.1582663605954; 
 Tue, 25 Feb 2020 12:46:45 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id z67sm2923844lfa.50.2020.02.25.12.46.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 12:46:45 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id z9so245933lfa.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 12:46:45 -0800 (PST)
X-Received: by 2002:a19:7616:: with SMTP id c22mr362529lff.131.1582663605005; 
 Tue, 25 Feb 2020 12:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20200218101910.6593-1-contact@mborgerson.com>
 <20200218165343.GB1408806@xz-x1>
In-Reply-To: <20200218165343.GB1408806@xz-x1>
From: Matt Borgerson <contact@mborgerson.com>
Date: Tue, 25 Feb 2020 13:46:34 -0700
X-Gmail-Original-Message-ID: <CADc=-s4nkB6ieakmiRuogygT7dzjb3q--noAWEALrrSOG+ZN2w@mail.gmail.com>
Message-ID: <CADc=-s4nkB6ieakmiRuogygT7dzjb3q--noAWEALrrSOG+ZN2w@mail.gmail.com>
Subject: Re: [PATCH] memory: Fix start offset for bitmap log_clear hook
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.194
X-Mailman-Approved-At: Tue, 25 Feb 2020 18:34:07 -0500
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[ ping ]

Hi Paolo, would you mind taking a quick look at this patch for
memory.c to consider
it for merge? This resolves an issue with dirty bits not being cleared
as expected.

Here's the Patchwork link: http://patchwork.ozlabs.org/patch/1240121/

Thanks for your time!

Matt

On Tue, Feb 18, 2020 at 9:53 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Feb 18, 2020 at 03:19:10AM -0700, Matt Borgerson wrote:
> > Currently only the final page offset is being passed to the `log_clear`
> > hook via `memory_region_clear_dirty_bitmap` after it is used as an
> > iterator in `cpu_physical_memory_test_and_clear_dirty`. This patch
> > corrects the start address and size of the region.
> >
> > Signed-off-by: Matt Borgerson <contact@mborgerson.com>
>
> Looks correct, thanks!
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> --
> Peter Xu
>

