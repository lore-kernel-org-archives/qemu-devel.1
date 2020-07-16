Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723A4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3155B2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYusMheL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3155B2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwAIe-0000wx-Fe
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 16:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwAI0-0000SY-Q2
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:15:32 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32]:34351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwAHz-00013N-8n
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:15:32 -0400
Received: by mail-oo1-xc32.google.com with SMTP id v26so1439221ood.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UWTY//S7j0GNq97XPj7Ukrd4sqspyxmY7B4WRZhMe8c=;
 b=CYusMheLheupkDbVCtqWXwL6IpNTw9EPK+R3SOCQl667dDGiSW9oMxNJ4+toQfgruk
 Pwhy9OlmVczLtagIHRm4UgL5pJp+A6LcqPnTh/hKc0TrTfDTEs36JQLB4DfLsMEZ4jNZ
 VMi+u1q+BDb4j2Xzbcpal3qSrYRWUFJMOr0dtN60b8q4HHqjGhEeAt+gSJqDWe4H2UGo
 XJFI9AzgtuyCUyjCg/RZ/96ksxlgjg/q2O0dnC+h5cv4MU1YguN0AfokZpf1Gksm+Zd8
 DN4tY37gmC/OY0eo5PIEM6PAIoNakP7NG7hHSb7rVFJ/SmB3ViHJ0G1azGCHlQxXctkW
 7vXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UWTY//S7j0GNq97XPj7Ukrd4sqspyxmY7B4WRZhMe8c=;
 b=XLYSfrB+gAjgADiqAQ2hYZLiDxspcPP/o74T9WC2s8Q1JMd6C1+j1GTDs2nha8ji5t
 fEUfA/xPa9C/zD6LT2WjXKtWShd3fYPMRc5l1wALj5KydTSxE/+W6Q9zXg6R9SJPaXgU
 guB9BaQU/O8MXEKDISrYbGP+PM5TzVbSiBBTcZaOrv31of8gyG+9NM3xZsqvKoerSi9V
 37IcHl2f5nUWfhy3v7WTBag3gc/hGmLleAN75VWVtW+l0f6wAqNE1f1963h6fCnZt2cK
 zvXvyMSeajjy/PX0QTHJPL9X6+fdN7GSLiM+FcABIMmwQU4es0N6ULmdVJn7kHII6wlC
 NOUA==
X-Gm-Message-State: AOAM5303sS14SvGBFDZUwVTR3aSbrF3yK2ZRRqnzY5dxJu5n0vo0MQPM
 hgxT8BlF6W+NEOQ5uo6Gms/Jl+3USODuD0UTOG+FWA==
X-Google-Smtp-Source: ABdhPJxoxK5yzbbI5LloyKbc+YCBLbuvB3Mw/9aY0IZb2mGk8iMtBj3vcRT/dBEFcB6jYMAQYEwYCd91Hwh/KxUuft0=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr5768829oop.20.1594930529954; 
 Thu, 16 Jul 2020 13:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-reu8gKpBMgEffStTRA+M02OWj75riXqBYXjgtOh5Z_A@mail.gmail.com>
 <159492211230.15440.2651129078319986183@sif>
 <78b8c6b3-1710-da21-68ac-194bd19437b2@redhat.com>
 <159492915780.15440.8588802536547059593@sif>
In-Reply-To: <159492915780.15440.8588802536547059593@sif>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 21:15:18 +0100
Message-ID: <CAFEAcA9ejQjNMcChrGH4RMt9pERQpUx2titK527s+PQCmVUEkA@mail.gmail.com>
Subject: Re: qemu test-qga failure on mergebuild after VERSION file change:
 dependency issues??
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc32.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 20:52, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> But is it intermittent, environment-dependent? I'm trying to understand how to
> replicate Peter's result since it seems like it would be straightforward
> reproducer.

I blew away all my build trees and recreated them from
scratch, and the issue went away. I'm suspicious that the
complete lack of .d files was induced by a failed earlier
pullreq attempt and left the build tree in a messed up state
where it wouldn't notice that it needed to rebuild files.

-- PMM

