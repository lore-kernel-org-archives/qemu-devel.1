Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F6AC48BE7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD20214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+1wxGlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD20214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkodZ-0003OG-6L
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkoaK-0001yq-Bp
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkoaJ-0008Ld-E8
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:47:00 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:44823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkoaJ-0008KN-7j
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:46:59 -0400
Received: by mail-oi1-x232.google.com with SMTP id e189so15058926oib.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k8PnssnCVPfet5PgND8W9QwzkR8rptxcKJoSDLVOK5c=;
 b=q+1wxGlbYr9/bMDrRllc6VwerbA9YZOFo5udKsnMngGQlz5h86OolIoE5Bft7GwQzV
 j9XatgdJrfgw3WiluLDBB7uN7GQ3AegR3jHAdYVek/YnHSfbYUqtSGi2wlqHJNQWX+4h
 Jzzmfu38AZrotEwX5PILnI8A41YPIrWRTzY+i+An3GcVnIdphVnTSQg6hZ4us5IUn75s
 CRNPeXbbWH2x7TQM9VSqk/9v+ZOCPkSsWtrqr8IqGRke/PplnX/hUNbmhrelPIONLhM4
 KQX/Tma66TmPhLaUiqi68XwDyc2usW170tQxHjmrTPsAfqo2xp3LWIedZznhPMSlciTi
 5NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k8PnssnCVPfet5PgND8W9QwzkR8rptxcKJoSDLVOK5c=;
 b=omC8vL6d9DlGUFYb5jAgWehH8ZTJW8YeeZEOGqyn5JyK1MfrVMYZG+ZO2T9fDmL7+/
 0yhU1152+cpev9LsWMMY62khQ4GvDA5EhTKYR9xhqxYNkC/mEUl5GDzGSA0qNxP8SisL
 8kf9AFMswosEdOzRJAMrLQaBCPXCy7XeNCrcvrKH5rfZwScTyPNR7W5Q85SvTPlmUAye
 fOoDiPjPFE0aef+PpLyrLJhAXYqbaNYfjcgqYKe3qj4tbbCgXNgTeFZTMJLGu4yYP1fV
 G9DkojIzzJ5z21+/mPWjTh+Zx1+EsmT+xZ90JHkJspaHQ4HWnKk69svfCadopbUgD4bH
 Ytpw==
X-Gm-Message-State: APjAAAVYg/vxjWTQ8EPR6Xl6MrHi64JeOGLhY92xULR0SjowU+r4dTRc
 mwOAGcI00dwlkWaqw/FuCEoSTRaegh1mk76Wo8BfGw==
X-Google-Smtp-Source: APXvYqyU5kQqat0ZaeEBMmwbXLnzuYQDE8IgLfk2m/MXpnGLVceYQCk1me0QybK4hekTU/wrCDrrSyK6uBylLe3ItjU=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr12290154oij.98.1562672815285; 
 Tue, 09 Jul 2019 04:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190709075042.13941-1-richard.henderson@linaro.org>
In-Reply-To: <20190709075042.13941-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2019 12:46:44 +0100
Message-ID: <CAFEAcA-rj_O-EHkMTp0W7HuhJO7cyJhuNMA9-L2yC82ZZYpFtQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PULL v2 for-4.1 0/2] tcg patch queue
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

On Tue, 9 Jul 2019 at 08:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For v2, drop the PAGE_EXEC patch that appeared to cause
> problems during Peter's testing.
>
>
> r~
>
>
> The following changes since commit f34edbc760b0f689deddd175fc08732ecb46665f:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2019-07-08-1' into staging (2019-07-08 17:40:05 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190709
>
> for you to fetch changes up to 11978f6f58f1d3d66429f7ff897524f693d823ce:
>
>   tcg: Fix expansion of INDEX_op_not_vec (2019-07-09 08:26:11 +0200)
>
> ----------------------------------------------------------------
> Minor gvec fix for as-yet uncommitted altivec host.
> Build fix for riscv host.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

