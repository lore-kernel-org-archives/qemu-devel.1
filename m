Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85590C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50975206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ads+xutq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50975206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQLa-0006HC-Ia
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQFz-0003CX-AB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQFx-0000gy-NN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:00:22 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:38400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQFx-0000fI-FH
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:00:21 -0400
Received: by mail-oi1-x233.google.com with SMTP id k21so5983143oij.5
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=iL3HzDj6VkOCzT/Os5ZWveLqvia5sj0iC3FNWExKclo=;
 b=Ads+xutq60OKkhB7WT9kFrcR+73wKqoQmj3rOPTXuZBMacoE8y+7bTtGbft1QzFIyb
 +vtlU0up7WPHZkrPcdUcK6pucOkwjnXPN6IY73Ey0x/Fx/KGeY7Sk7dJfxZe+xLyw/NE
 YNjfVJxAMUxImnIu8VCjqk+BHaDCcL7Psya08VXC/u3COOFHLX10U4qvXD9fHNY5mof0
 eITTDTouhW49wvny1mIhP3Iy7dKC9cUfBDpnjU8/txF8NmQJbr+iV1eb7F9DhAF8NCKD
 8YY06XgBYfEWajR13Jm4PsGxT5/WIu0ZKvRX128ye5vjOsOV7o53rBXq9yAzMtT4v0gv
 /F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=iL3HzDj6VkOCzT/Os5ZWveLqvia5sj0iC3FNWExKclo=;
 b=Boozm3eoO6LWkqhCWn1rOgV5MN0hIHMoFGTsnlDgH8KjyrkR/+F87xtrDpB5buS9+f
 +24zShLlcS90UyHgtoZhW34S/RUxT1Nbu4JG3dn/btHcncYdY8CL74xmNYTPONjExbWk
 dZzEdOhGnAuRMOQI6P01XbrOGsy7rOEkicsfvXnwpJRtdjKtqU1yFS+TVq0DDxhQdn4d
 DCQBlpuQpp+7hADY2ow9z8fkdK0CVoJGc4Yj1UfxUAWtxVuS61ucWrzpH+ThmDUbuwWk
 QCX2TtAxFPTB1nnZKaAVJHGB3L4ln2ur5bv9r7vUq16RDaWoFHRKd6OJLg40+3y5HeEm
 79IA==
X-Gm-Message-State: ANhLgQ0x0ymzSwEzunXep+Sn7la6+XE5ivWvctPyBp+0grMXFvq3iKcY
 aF8FRM5zJTnnF3XoX9cI5iOj/+Of2yO8k1mKgcKKB/h2NIQ=
X-Google-Smtp-Source: ADFU+vtFHNmfeV2025ZMW24eKkdixrcVML0Jjn1yV4Yb50rsc0M7GEoj5XTZ2YZlKfD2f3IcmOPZFcvWh1dXDSOP/mg=
X-Received: by 2002:aca:c608:: with SMTP id w8mr3225157oif.163.1584028820050; 
 Thu, 12 Mar 2020 09:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200312114408.16891-1-peter.maydell@linaro.org>
In-Reply-To: <20200312114408.16891-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 16:00:08 +0000
Message-ID: <CAFEAcA-kkiFCT-A0D3CY4tpQkUXU74L3-0Z_GN5Ou_52FFEGuQ@mail.gmail.com>
Subject: Re: [PULL 00/12] docs queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 11:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Some documentation-related updates now that the main
> qemu-doc conversion is in master. Includes the splitting
> out of arm-specific info into subpages.
>
> thanks
> -- PMM
>
> The following changes since commit 5931ed5641ca6c4a237e82e4e5d2a08639865ce7:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-03-11' into staging (2020-03-11 17:06:40 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-docs-20200312
>
> for you to fetch changes up to 6fe6d6c9a953901251e1a85088f0a61ff5caf648:
>
>   docs: Be consistent about capitalization of 'Arm' (2020-03-12 11:20:20 +0000)
>
> ----------------------------------------------------------------
> docs queue:
>  * Remove some no longer needed texinfo infrastructure
>  * Reorder the top level index docs to put most useful manuals first
>  * Split the Arm target-specific info into sub-pages
>  * Improve the Arm documentation a bit with info previously
>    only on the wiki page


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

