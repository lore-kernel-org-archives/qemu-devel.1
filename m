Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CE9C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3795324658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHi3PQc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3795324658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlS5-0007g3-9d
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izlRB-0007EA-TC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:59:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izlRA-0001hK-QW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:59:37 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izlRA-0001b3-KC
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:59:36 -0500
Received: by mail-oi1-x242.google.com with SMTP id q84so5508849oic.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N2/oYlFkWfVyZJOGDslI+0cGWQxDV+A6a7l0p/C3vUA=;
 b=yHi3PQc9V8kEoF46euDxkspJ4NbWEro7HVe3kwH9vw1wvBFZyKqcGfRBg2U8wSav3x
 6pn6ChybENoEBn2P5fVuy4I8sJNJMIjoS7u4QN5LkXFeFho2vT7//nlqaBXqPHLdrPtS
 +FeW9eljY9XPDfWNeIILNW/eFl5IE6//8ReYZUJSTebwew+PyjOlhtrntvkAwmcq+3pn
 lW179L3N6+/qDMnMGItzXxzocokqoHiMgY+hu8HdeYs371dHL3OF/D7tCPre8z7a4PPF
 qKRldG5PqTfnFW1Bq4RbfjbDiQuEqPqOCGKDiLy4xLoaOiEZ99dj96femw1gKC61lSEN
 PjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N2/oYlFkWfVyZJOGDslI+0cGWQxDV+A6a7l0p/C3vUA=;
 b=q72GYr+ne0K2jxMI3MyQ1l6quhJaE8008/MpdERuHzbnop/T5msWHGwdqrr51jqReO
 YxhP5zJe9OTWE+Ct35H3OUby8CpJvrISE/KzN0D2ElfpeWmTk1lUr1w+zDd+rTipNlAa
 hfGn+xcP3YjJtSv6YNjGVz1HYienDLoFYoLsdBrf3VIZPMUlsBhRBATNWp5SLInZiKGh
 mnk/uMNb8M0nHcQh1ZJmQgr4/AVuZGgKlYRw6WuYp02SCWJDo+TEbBS+SJt3hnl+BlAl
 b0LC7fs5zoKslZyT6J4Kwi3HnKNXSIQTiHRDqlOY3YZwpX3mRHx48cRIQuof5YDAQsq1
 g2ug==
X-Gm-Message-State: APjAAAWT699v5Izflw8BIDKXVjF8XLNp6aiWRHlwOaN4oBsNwMyMNZ9N
 FZ2dLmBy55QsVUZ/8mtH9ZnKzVA4P7bA1jl0SK6V0Fq9
X-Google-Smtp-Source: APXvYqx+4pAy+prNrMGw1YqP2Sb5J4u35Zuqv/21hKZyqRRHEbA2djE6yCzOebDjA+ilebLVCieD/oxUPDJobc/ZRkU=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr7576809oie.146.1581011962698; 
 Thu, 06 Feb 2020 09:59:22 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-29-peter.maydell@linaro.org>
In-Reply-To: <20200206173040.17337-29-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2020 17:59:11 +0000
Message-ID: <CAFEAcA_gywzbhJTbTJyOQfi-WJgd20ajUGkNQ-6uiSXEjNtc=Q@mail.gmail.com>
Subject: Re: [PATCH 28/29] scripts/qapi: Remove texinfo generation support
To: QEMU Developers <qemu-devel@nongnu.org>
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Feb 2020 at 17:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> We no longer use the generated texinfo format documentation,
> so delete the code that generates it, and the test case for
> the generation.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile               |   1 -
>  tests/Makefile.include |  15 +-
>  scripts/qapi-gen.py    |   2 -
>  scripts/qapi/doc.py    | 303 -----------------------------------------
>  scripts/qapi/gen.py    |   7 -
>  5 files changed, 1 insertion(+), 327 deletions(-)
>  delete mode 100644 scripts/qapi/doc.py

Looks like I forgot to delete the no-longer-used golden
reference tests/qapi-schema/doc-good.texi -- I'll just fold
that 'git rm' into this patch, in the unlikely event that I don't
need to respin it for some other reason.

thanks
-- PMM

