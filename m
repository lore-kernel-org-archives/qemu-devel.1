Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717DDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C70E2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7jiNO+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C70E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiacn-0006Ki-GH
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiaay-0004zP-8k
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:31:03 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiaaw-00022r-QP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:30:59 -0400
Received: by mail-ot1-x344.google.com with SMTP id n70so3611463ota.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 02:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cKMMXXwbLHd78C+kGo5FRovmeSLhLAAwRqhRG4WFOYc=;
 b=b7jiNO+f9hYtqzZyVmT6+qfbziyxfKB92rQFDgb8A2I5pbzuCzhzSGdXBumw04iGoN
 n0ldH1+KLEvC8nQOfQCf6jpEISRgvKofLzUK0WesX/pLs0qxmJXHaADTEE9lfyC2+YzF
 7f1gyMgwVYcerzx+gAJTN2TZB03C7F+ku5rLJCleL6H0MH9IWr+1APXJgXXydJ0R41db
 Geg93dd3liNAVuYti2pl/X8n/i0DWqnCv61DdNGheaEq49qnN5P4rDLQXwftpwhMPj6o
 HXthd7EfPXVKOT0G6QgIiAD3iR3hDEZ32W+23drU7aePaMCUjqWnlxd7aMebl9C49nPk
 AzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cKMMXXwbLHd78C+kGo5FRovmeSLhLAAwRqhRG4WFOYc=;
 b=k+FiyTho2sXwAR6A9QK/rnJcfUUgvfM7x9IHRaG6i7QLL+rhSM9WDf381+m4U2JPkS
 uLM3kVsd8yWtcZYTsO7cgFFwp8nBA15oqcRvqpkkn86Umx+KiE0qCYbCmFBgIihjlivz
 d0wT7BT66B/wr0yQe9Xrt4Ou1Zp7QUWarxkMWwCVEAfLzFBbv0OG23yqk+9n8vg4qTGd
 JKDFdn8d7nR8kJsWaPzB2cxNUQOv9uCBHOyrv8jUzGfpf9ypWGWkWoYbdz1/3FocCkpz
 il4nOP3h6lGxo/X+nLBtQNhkQUtojhw09DhBE4FDIAoDv8Bpil4OGGop/rvoStBgZDkV
 +Akw==
X-Gm-Message-State: AOAM531tEj7HAc0Ns+/betklPX91YcHn2qNVaUDudsc/oeXuE44fCJq1
 jM2PF2NPPdGncvJ7wPpJoFOpoHpoAN5/jZNVGPEbaA==
X-Google-Smtp-Source: ABdhPJyF8Rk7iqERFwRM99c5sx8T2nTZUxwqfEwfqugFKGXXCdxlpdJGSFNe96T49n0hEgqEkTuu/NLM3cEbTu43G6c=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr21439695ote.135.1591695057453; 
 Tue, 09 Jun 2020 02:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200608183652.661386-1-richard.henderson@linaro.org>
In-Reply-To: <20200608183652.661386-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2020 10:30:46 +0100
Message-ID: <CAFEAcA_jqCnU1aXBKk+xF5ZLBPBkyGjewfu=pz-y1DM77GqyJA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] decodetree: Add non-overlapping groups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 at 19:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is a feature that Peter requested for completing the
> neon decodetree conversion.
>
> Changes for v3:
>   - Remove check for less than 2 patterns in a group.
>
> Changes for v2:
>   - Rebase on master, which includes some generic python cleanups.
>   - Indentation error message restored.
>   - 4 new testcases
>
> Peter, do you want me to include the final patch in any
> decodetree pull request, or shall I leave that for you
> to pick up through the target-arm.next tree?

I think it's probably easier if you put the whole set into
a decodetree pullreq. I'm still a fair way from having the
next neon-conversion patchset ready to send out for review,
so if the set goes into master before then that would be
most convenient.

thanks
-- PMM

