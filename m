Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:30:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA2020BED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA2020BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXkk-0000qA-Kv
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1jsWFh-0003Cb-5Y; Mon, 06 Jul 2020 14:54:05 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1jsWFf-0000lB-EA; Mon, 06 Jul 2020 14:54:04 -0400
Received: by mail-il1-f196.google.com with SMTP id a6so17097928ilq.13;
 Mon, 06 Jul 2020 11:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BDH2XTEmxALIuYOJmsK3EcZD2CIyVBU3e1R/G1m3Jbc=;
 b=WIjpjLVI3nQm8h8CR+ueHwp9z2C3XwV/wYtLoN+xFkiLi+a4ZlgKpW7HlPtmlmI0bz
 +yW+GQwpD8G4t/izJyQ2/DWvctLtNknxfZI6/S9nL1TXDK/e0gxUJldOfgpRZYXfdLfu
 69C8Z6G2brOirpnLGYd9YsY3xVNDXCZiYpwEm3sga7eDae6o1yehe/Llq60R7lGPbDjf
 /LKBkzEfSgQ6I9bZQto1fY7JVqA50SvD1BpTq6fm+t+5I8NnHl3znjeYuNwRTiu3BDnJ
 qzkSHoEcPd+B45wQ920s7EVlEI6+cML6tN84iSkOQiE8hSKDxEX12+M2AAGIosoc8K6I
 k6ZA==
X-Gm-Message-State: AOAM532t672pgWK6Gm4yTBaRUm9W/rqX6qNT3p1MxPJO1XDeqpVHVqUf
 IQuk7muRVLgbuxd4lOiciz4kxYPNTHPy7Vg81r0hmg==
X-Google-Smtp-Source: ABdhPJxpXjz1Z7whO9ez78C1ShMrU2M57043Po+U/3i6fJWqPWs9ziq1wgy+zWHY/x3f4NyCtPGVGBWvhv9Oa/Emvxc=
X-Received: by 2002:a05:6e02:487:: with SMTP id
 b7mr32815804ils.100.1594061641235; 
 Mon, 06 Jul 2020 11:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200702173818.14651-1-f4bug@amsat.org>
 <159371348834.6440.15747631286416621479@d1fd068a5071>
In-Reply-To: <159371348834.6440.15747631286416621479@d1fd068a5071>
From: Ed Maste <emaste@freebsd.org>
Date: Mon, 6 Jul 2020 14:53:48 -0400
Message-ID: <CAPyFy2C8JuZrn0osR7F+GoG0s-M=KSprRg49Lfk3d8SDMsBtew@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] mailmap: Add more entries to sanitize 'git log'
 output
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.196; envelope-from=carpeddiem@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 14:54:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2020 16:29:29 -0400
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jul 2020 at 14:12, <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20200702173818.14651-1-f4bug@amsat.org/
>
> Hi,
>
> This series failed build test on FreeBSD host. Please find the details below.

I had a look at this (because it's a FreeBSD report); it appears to
have been a temporary connectivity issue.

> fatal: unable to access 'https://github.com/patchew-project/qemu/': Failed connect to github.com:443; Connection timed out

