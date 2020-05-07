Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C45C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600F02073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwqvkPVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600F02073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWgcQ-0003sg-It
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWgbN-0003Gh-F9
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:30:13 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:44350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWgbL-0003hG-2Q
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:30:13 -0400
Received: by mail-oi1-x22d.google.com with SMTP id a2so4936041oia.11
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K6JLBLcH0Ctp7znskHui3Cii+iUETON1EYGDPapIpmk=;
 b=bwqvkPVlEvmKAWBsG9BG4q2Fpe1QnnWhvDz0SaT4Tep4DU3ggJTMpNCVszPPMLskAo
 +qjr6lENlVQFhriWzO+jUVhbJlwxohoJc95OK/YmtjaYRpsO3kQFiVRiNXNVSoVg0MWD
 lDhgZdkQrIrboYG9fx2tTXGnTLxBi0FO+5ylDx2hVzde6m9EUTPaWgiRQ+0UX4ncePiS
 SAH2TohFJqVkqBxwMbRjBUSCmFZaZE7Ng01T9LcwuCxeCU0OBdIy/SeJaukS/otZsjtd
 8b5zTLZjK3kT84iQkLWsBEnAdacc+KbE+obd0xqDacd6OICRyeHuwfPjnvA2i4kW0tJ7
 jJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K6JLBLcH0Ctp7znskHui3Cii+iUETON1EYGDPapIpmk=;
 b=mLPbKwh1NTXmKtO/zlddZjcN5FCugBaqjeXZ+ER0h1WHb3WDO3cnGNmjcjPQBiweDo
 nxc6bYL3MgAyI0vZEQDIlRCtiVdyoRbunpc3lsZJ6l2piMLb9zouqR7EyvjEkz6Lq4N1
 p1W0Sg8XKGHAkzS8hUMu+3qwWEHHpbN4O0y3KZf82UOplFZNR+QdGo4gxhQXJa33wkxE
 wRl9tV02xcXscV6Sq5H6ixhUL7I1CZmHg8fk5XuJGbv00m7lHExArltmn/bYeGK/paXn
 3lvrmxCUXqIVQdOZwsDfeDM/zIgFvV7D7vVvj4vdNCOiGjNW6lT3TXySvbPOQpAu0Odn
 DRNw==
X-Gm-Message-State: AGi0PuYou5bwpFElckbZ8GTyBLNwgvFvbaIsXwyFK6h0aMLGQVtlxZtY
 mnlPtIQQMPlcDBm/6FOc3B72rbbzMWJvZnHUGtZ/ow==
X-Google-Smtp-Source: APiQypKEOgP092WQssEm+Ebxo/u4Rxl1d1FpyDip5DjzvP3I99bP/cVk1zCEDp1b1KEiyd98oDTL33c7gZc0jQHycwA=
X-Received: by 2002:a54:400c:: with SMTP id x12mr6318654oie.146.1588858209500; 
 Thu, 07 May 2020 06:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2020 14:29:58 +0100
Message-ID: <CAFEAcA_GXSkhDp4p+yOdv5FKympes+bB5VBurawOO=fFpOoR-A@mail.gmail.com>
Subject: Re: [PULL 00/18] ppc-for-5.1 queue 20200507
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 May 2020 at 06:04, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 570a9214827e3d42f7173c4d4c9f045b99834cf0:
>
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-reg-to-apply-20200505' into staging (2020-05-06 15:38:02 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.1-20200507
>
> for you to fetch changes up to c4f6a4a3dd5f2aa15329b8158de25f50b5ba3252:
>
>   target-ppc: fix rlwimi, rlwinm, rlwnm for Clang-9 (2020-05-07 11:10:50 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue for 2020-04-07
>
> First pull request for qemu-5.1.  This includes:
>  * Removal of all remaining cases where we had CAS triggered reboots
>  * A number of improvements to NMI injection
>  * Support for partition scoped radix translation in softmmu
>  * Some fixes for NVDIMM handling
>  * A handful of other minor fixes
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

