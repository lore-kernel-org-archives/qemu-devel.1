Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB25AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A444D2072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1ks/bWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A444D2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9ho-0006gU-Qm
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jA9gx-0005nT-OJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jA9gw-0004wC-D6
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:54:51 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jA9gw-0004tU-6v
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:54:50 -0500
Received: by mail-oi1-x244.google.com with SMTP id p125so1947802oif.10
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 01:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5mqvOeQPRdC0xpis/LcpEbxJY2rwTbFGI1AuPRFCDp4=;
 b=C1ks/bWdi4sJWrj8rP0VkhNTH9vBVhh0x5NLd2w5nsVJWijOTIWpvsPEspaKdMYcsG
 /D7q3Nmm+zQ4v/eR3gEnq5/ID5qme1f04xY+hZu7jkQ9qmovzlEf/GTrcimn7rguyXlZ
 ATO1wwprP1IkZiQtNEA/L7y35QcRYLtxcE2xvG53WPE8vvq3kValKG8FEW0mIQKrFZ2E
 8eSHTtUGfTgebWUxOG7Kvv+tVTTayEG9geYXrjYSpHoQJA0k62JSkClV0IxXX28i/9TB
 eXfz+o8h5Jr41kzrjKebB8FWGpnVSTrHkICLusVQMw2122zoifoNoxF8UuUUCaeCQ35u
 WM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5mqvOeQPRdC0xpis/LcpEbxJY2rwTbFGI1AuPRFCDp4=;
 b=XVhVckhKPUjQzmTJMUedIbBqsK45owBrozTz2zmDVo1WSQpy0dvSLRZfluZ+o0RqoW
 rVvmmUnGXEzLJqgbPHRRjhhTniMOeLKWP4XCCG+aWcY2DhpL2Dyvv3y6RhEPhldJXi2R
 c9gMIyKo/f+WQtQfx/nS5ehNvXe+M2RyZ+TNg1GMBq4QvAR7YnOXo1wDWtJlxbZv0Bi8
 7J2TWWNrWHrnMHCUvSqdm8Mt2HXYh6UOh7W7s43BB5VXAx0M4GhvA9V7VJgwhJP9uTJB
 2+yc/Isr8f6HboDhvDu6Rr69E/tWW6Fdv1NUFqOmDmejvFMLkcEPKq2IHFSWJsTSqkUP
 HknQ==
X-Gm-Message-State: ANhLgQ33SOz4jRUJx39g3OL2goOWAQvngw6le8wqEubehtr7lWbOBLd6
 pbmGpCVgMyj5H6PiPXCKv/WANaUTLSicbW0sYvTRFg==
X-Google-Smtp-Source: ADFU+vudnS6HLIw9sZOxbuyM7gYSDQ1TmH8IKV5dnmKszldvaXDN8HTQyHL2Shfi+Hq6cGAAlJQZLsK3tnoCfOJqWDY=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr1989658oid.98.1583488488963;
 Fri, 06 Mar 2020 01:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20200305200558.71104-1-palmerdabbelt@google.com>
In-Reply-To: <20200305200558.71104-1-palmerdabbelt@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2020 09:54:37 +0000
Message-ID: <CAFEAcA8vUdrYRbi+KxHDaMiE2enUWKEZujYGN6yJnUdrATMr-g@mail.gmail.com>
Subject: Re: [PULL] A single RISC-V fixup
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 at 20:06, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> merged tag 'pull-target-arm-20200305'
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200305' into staging (2020-03-05 16:47:37 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-5.0-sf4
>
> for you to fetch changes up to fd990e86a7c99f5c99d430160243a3bcc64b0dea:
>
>   RISC-V: Add a missing "," in riscv_excp_names (2020-03-05 12:01:43 -0800)
>
> ----------------------------------------------------------------
> A single RISC-V fixup
>
> This is just a single patch, which fixes a bug found by Coverity.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

