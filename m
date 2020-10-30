Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A736CC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B95206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAPeOXPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B95206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYT1p-0004Om-Cr
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 07:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYT0r-0003eY-LV
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:56:09 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:35171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYT0n-0000Cv-Tm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:56:09 -0400
Received: by mail-ej1-x632.google.com with SMTP id p5so8246712ejj.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w76ug9Vvh3/zajPsWBr7mpXfub3RALxoES3JkktXPmM=;
 b=cAPeOXPl66cW3uFIBy8ls5y26Cbh9lcqycnJfHwHAN3wWxETBfK+1cDxz8gmiv4yTJ
 c6UMRvcxKEsJejiaisRXd8IuRAnC1wsx8ATktKreqqvi7D+2SXkwdecKer40qAT1nJXo
 gGxY22n76k6II/Rr6E1c0fAKQdHbWWQi/iWzoO+lvgWlYlfsgm3Ll/Y29Uo3mjh2WWed
 2HHYCD++r/njBDXBWYyZ+7qxDFSc+BKJRhJOnvt6+gMoSu5g8BxfaKaCJDhdvdCKmlyn
 jXT/bMcRcWZSbqjYTvI+PHL+d+9bXnicmneuIXUdPLli9F/lNrhZ52u6Xw0ZAnz5W0aN
 6gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w76ug9Vvh3/zajPsWBr7mpXfub3RALxoES3JkktXPmM=;
 b=re5aLZ+y9AI8OX3oSPIoqzKu3XHxbkG143pWO/2axIZZfPvFx96/tCzo5FsOoaIGjW
 2edrmLRLXedKeK/f/+eap9TLIimm4bDofPdn/f4J0C6a16aWimwfwXgdqFh9AE2FMdsl
 IOyHzriuiGtIX8R3NJiOGxn01LujFNieFJ7cV4IWEOGROA2ENUOODdmoqIQ1LU5xomsP
 X9RKXPmKnmKeBr4Vd2J+haQU4FqHrXdPWq8HerMqzVPGQJWcqiojadSUm5eBQXpuuDSA
 7XZI9jxChzg47DhpR310sc0oQT4KX/FP95WngpNJpDJt7M/86JgsWrd6zo+yP5OMLM6m
 Lupg==
X-Gm-Message-State: AOAM532nwjGQKYr/nsBOKdsPhd5Luo2Il+q/37c6OYIOMBnlTzYnrs2N
 yaDi+iI2X3CrxigokGRrnZfx7Iu2j02eIJxCElvJNwLCcOE=
X-Google-Smtp-Source: ABdhPJyQs1Gfr4TAXrTyj2FOLccG1FyYYqp67XsDh+QeRhBbySyPRHVSLFIV9fWaF+6VHovD/iyTOQeSAb2Uj1YUQhc=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr1966992ejb.85.1604058962820; 
 Fri, 30 Oct 2020 04:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 11:55:51 +0000
Message-ID: <CAFEAcA-a5tL6N6U0T_4bhG_jURRtm5Mmp2S_eGprtp8YBPGgqg@mail.gmail.com>
Subject: Re: [PULL 00/18] ppc-for-5.2 queue 20201028
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 14:17, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit d55450df995d6223486db11c66491cbf6c131523:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20201026a' into staging (2020-10-27 10:25:42 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20201028
>
> for you to fetch changes up to 136fbf654dd5fa88a5057dcc43947536f3b418df:
>
>   ppc/: fix some comment spelling errors (2020-10-28 01:08:53 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-10-28
>
> Here's the next pull request for ppc and spapr related patches, which
> should be the last things for soft freeze.  Includes:
>
>  * Numerous error handling cleanups from Greg Kurz
>  * Cleanups to cpu realization and hotplug handling from Greg Kurz
>  * A handful of other small fixes and cleanups
>
> This does include a change to pc_dimm_plug() that isn't in my normal
> areas of concern.  That's there as a a prerequisite for ppc specific
> changes, and has an ack from Igor.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

