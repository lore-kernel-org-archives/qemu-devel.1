Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F17C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8262075B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wG9WUbjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8262075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBF5U-0005Ym-P5
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBF4m-00059o-Sa
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:24:12 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:37868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBF4l-0002KQ-Ag
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:24:12 -0400
Received: by mail-ej1-x631.google.com with SMTP id e23so6162360ejb.4
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 03:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yxsibIE6t6cYvP0O82eAbuPaHRvynPS19W0//hA2scQ=;
 b=wG9WUbjjFkEvwuXHP7uuHqiqxLcp64XirEPD1WBqqm864LDgHL97dQO8ps/mEA3D2Z
 t5d0Tx5f67zqSsGtLquka7exIzJ1+aOhvO7r1NjHTB857FzF+7IhrlwHubwDxmknG8Ks
 kT62RFWHMA3RcKhgqRKG4zSvD/dlTbh9lGBNR0wShAFJTPPd2cKiYfh5QiH3gptGyMS8
 HeI1FULpg/ZiyngkzreKdZlgkRdlzReeM6hMdltTeUCch3uZkCNjHGMrXOIuVTJcJJLA
 ZUxPxbNRCgfLiWfjeylz8N4NB6HhRisjR+2khMqwf+mpwW0HJESafPemummwOZcxo2+r
 wDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yxsibIE6t6cYvP0O82eAbuPaHRvynPS19W0//hA2scQ=;
 b=oRqN0CJJfZgzkWT2FasXdpz13lze2qYTYUvlvzSvNkJHmjQNCzPcrmJ8AQSU4fEgwp
 iKrYF+PcyQNu/1lkFH77EyXT4tB/LhoZE6EXkYE1TkAOkhgSKn1V9yHyEoDlrzzxdEF4
 dqLSWQXPz5cHMil9pluP3d2ZEpR5B5FGhMM18RlQfOhZQksQ/zDiM7CWtNioXQ+cDyzT
 ocj0wcyk0pNQBXZIDuJ1t/XT9AWPiASEFul6YcNBpRrPr0imPN4tW7VOcriR4hJhmFDE
 /yLyJwL63evLcByzaYK303W7pKNOrVEZnB+wqgWUcaAuda9Quro5DW19ZdFTo3Ql9Sks
 wNnQ==
X-Gm-Message-State: AOAM533hfkQzZR2yCb0VmU2t1nN3M04SJEofGVe6hJx6gBS95Mkl7x2y
 liZDhbRcYG7Cv82VEix8Ie/sc05lCzbrBoGAHbICJQ==
X-Google-Smtp-Source: ABdhPJxenoGGkoEv7QfVx4qnJvQQWT7aka0VK/oPVz95oqt8/68TPvas9erzV3GR73yVxgmYI46NZF8v2z114yYS1CE=
X-Received: by 2002:a17:906:59b:: with SMTP id
 27mr21377107ejn.56.1598523849902; 
 Thu, 27 Aug 2020 03:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200825062008.6502-1-kraxel@redhat.com>
 <128e42b3-3b0f-744b-91be-f4c52837c3a2@redhat.com>
In-Reply-To: <128e42b3-3b0f-744b-91be-f4c52837c3a2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 11:23:58 +0100
Message-ID: <CAFEAcA8m13LKgeiBJGy=XKLzP8zOqqxeEG8R0w=0jG-GprBEVA@mail.gmail.com>
Subject: Re: [PULL 0/3] Fixes 20200825 patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 08:20, Thomas Huth <thuth@redhat.com> wrote:
> Peter, what is still missing that you could use the gitlab CI as gating
> tests, too?

I think we're waiting on a respin of the scripts from
Cleber, aren't we?

Also we need figure out how to handle the conflict between
"gitlab's git repo is mirrored (by perodic push?) from
git.qemu.org" and "test by pushing to the gitlab staging
branch", because the former overwrites the changes that
the latter makes.

thanks
-- PMM

