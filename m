Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54999C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF6C2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olfGgIpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF6C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixC3U-0004Pe-Ay
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixC2u-0003yl-A3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixC2s-0003vr-1N
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:47:55 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:37031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixC2r-0003vI-RC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:47:53 -0500
Received: by mail-oi1-x22e.google.com with SMTP id q84so3949835oic.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 07:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CX8KNRAr6efF5mkxbTJw96YZ9CW8HBvzAO1CWYAidEg=;
 b=olfGgIpkWcnm8iDDqEHyWQpNrJiXopGg0IGiIVk6GcMYIxiNFt53tqu7Y8w7shaszs
 te05HqFIIOX4z2G47d0R56RvIYRJQsb4vFMtFBg3Y41XEUQNsYqmHNZpQW2aLEVVhp0D
 /8lYj5kTQg/IGNB0Kp8Wwk/mBZh37P+TiIHsCTr8Y5+87ifJd8BdKKwVQNVs2OXIw3kY
 mWOXtBXNSAVZa38qD8RFVEozHY8gZXEQRD4aeY8Wp0MZKIKGlMXVpSbEmyLY90io3sw4
 uJa+NHi2M88YjJ74wqzwpCWLnuATiwfbYsCSgAdoihCjhzUWX+z4xEPX+vtmolyjVfhE
 UcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CX8KNRAr6efF5mkxbTJw96YZ9CW8HBvzAO1CWYAidEg=;
 b=cP7oWH7iQtq+EWo7GqnvxrHUrpiArEOBBXOFMe/40r/yuX4Nb0LWMGRL9ALbPHAPXI
 jxz7zJurKdgHxRpOVmWuvqWzbsGxYDiGs6Tp41Z4yRDORUalSeyyCx0QS/9gyRSMRCao
 7P0L232xQ+rUCQyLpdqNxbSkSNq1BhBj/0kW96ANh1kAAaNdnyWQYOnWBfmh+almXATm
 b7ChrZ49Pr68+fCNxHtfdjJZisMG1XPGxSqzrOscJo81Sk6vG40L5lcRy0d7Pi3AjXcO
 myxgsro9FxA7dad4mgPwLOHu618RP22pjFSZqieWmznHC3MV9R5Qew3UCRVZRi39mOCY
 YnLg==
X-Gm-Message-State: APjAAAUYP6mL2kXtv6OUoIGewmhPhfP1Xjv4V1mNQnPK9brSxF3QvY7o
 Er81KobtXe727KDVVFbHqN0mCrsmZZIpCdzN2r5zeG36suA=
X-Google-Smtp-Source: APXvYqxDcAgiAe28g0ClVaKkpHOtb8cZVdcvZK7sIbxLMZrN/RMBREK7qybYPvYq7HK5mF9LMbhwarc5L8mxsQYU3JU=
X-Received: by 2002:aca:3182:: with SMTP id x124mr3372450oix.170.1580399272926; 
 Thu, 30 Jan 2020 07:47:52 -0800 (PST)
MIME-Version: 1.0
References: <1580322857-14331-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1580322857-14331-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 15:47:42 +0000
Message-ID: <CAFEAcA8UuqpK_MPhDER3sgN88q-xe5S0o0Z5aYj36uAHsdQuSA@mail.gmail.com>
Subject: Re: [PULL 0/6] MIPS queue for January 29th, 2020
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 at 18:34, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 4c60e3289875ae6c516a37523bcecb87f68ce67c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-pa-20200127' into staging (2020-01-28 15:11:04 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jan-29-2020
>
> for you to fetch changes up to 99029be1c2875cd857614397674bbf563ddb6f91:
>
>   target/mips: Add implementation of GINVT instruction (2020-01-29 19:28:52 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for January 29th, 2020
>
>   A diverse set of fixes and improvements:
>
>     - finalize documentation on deprecating r4k machine
>     - enable disassembler to receive target-specific data
>     - enable kernel loader to get e_flags from ELF header
>     - improve code flow in helper_do_semihosting()
>     - amend CP0 WatchHi register implementation
>     - add GINVT instruction emulation
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

