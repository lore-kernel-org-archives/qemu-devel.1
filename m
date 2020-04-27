Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8404C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817342063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwGeyyH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817342063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1YF-0007R5-MK
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT1V2-0004jT-RV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT1Uy-0002Ag-Bc
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:00:31 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT1Ux-00026T-Nr
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:00:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id c3so25362340otp.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VJq+mgb4XrzJF0lylAvz3yr03alybFogbUMfHKlJVxk=;
 b=QwGeyyH4BSISwo4j2POX2WlJeMi38MJ2SIfHC0TeoaBF7qoTjkwWoNBCjbdtDzjpEI
 kfkUSOGy9gBbQJDoBSndx3JFKlo9G+ejxGG5f+wj+qh9ZpasfnqhKAQ+Md5QYwt8AKCk
 o2NuhFh6zQ11IUvUklaoq/YGN+/NJceusAn6ecx74PUhKdLX9smrMGlQ6FPrQtzj1XrY
 M1KlwbS5bbxQs6BHcF+aH/9QWf/xZbAcX4rdeFG3MGFiGI/cg9HXbL2V0UbcTuaJXBiN
 4DZc5Fr74eIt3MG/zVFP6E877MyA/WkACvwVW7KY8cq0BMUKK9qcEL8EdOqa5Xm6VIyl
 68wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VJq+mgb4XrzJF0lylAvz3yr03alybFogbUMfHKlJVxk=;
 b=f25GDLymZPEi/kIcpP4neVBpQhq1WlJtz/U6JZ6uCF8VOld9xIskn9LjnAOlNCINQq
 Ei0i4OsmLugxz5Xo5O0AooIbJYi+isyyAKfaiWEe2z5NwiKSMJcwiwSJWyxYfZTq6bPH
 ZD8pP/jO46Kcii4UARMhR52SvfmSXbEP7o3k5q1w9yPhOTSmtPVE4M3ImfievckLT3o8
 wm3CDqDze52mMaK9DMauXItMG5WviVGowiUEBu9ArzkloG4AGM8WUN5LXGOa9p2xOq0L
 i4mMLCeHiasQ89Y4nupWTY0BjUzeArPl4CcEM7eHkmuf+9pQCRla9grM1JnTagy5I++Y
 kd+w==
X-Gm-Message-State: AGi0PuZN2Y58hvP4NQqj2Wre7+nhLH7vOhrHaVUwVxZFgl94tKixkVIp
 zydVzVSvTpfmYmPgBkwV8P3y91de9XsC5qMYZ9z4Yg==
X-Google-Smtp-Source: APiQypLn+DfZsQqNDDokxLPnxEof3YmqiZ6u1D5bX9RxZc96DF5Z2GWzmSDRB7mRrDFcwYQRtpWUWNY4Q2cdbsTT82E=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr17470258otj.91.1587985225067; 
 Mon, 27 Apr 2020 04:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-9-richard.henderson@linaro.org>
In-Reply-To: <20200422043309.18430-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 12:00:13 +0100
Message-ID: <CAFEAcA-TT3Omxk6B601bUxyXLR9m_y0O18ivR9FX5CEsoK+Smg@mail.gmail.com>
Subject: Re: [PATCH v3 08/18] target/arm: Add sve infrastructure for page
 lookup
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Apr 2020 at 05:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For contiguous predicated memory operations, we want to
> minimize the number of tlb lookups performed.  We have
> open-coded this for sve_ld1_r, but for correctness with
> MTE we will need this for all of the memory operations.
>
> Create a structure that holds the bounds of active elements,
> and metadata for two pages.  Add routines to find those
> active elements, lookup the pages, and run watchpoints
> for those pages.
>
> Temporarily mark the functions unused to avoid Werror.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

