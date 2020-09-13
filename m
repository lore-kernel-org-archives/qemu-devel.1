Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16E4C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59043208C7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjDsFwgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59043208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHXg7-0006Q8-4K
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 15:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHXfN-0005lg-Eq
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:28:01 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:34555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHXfL-0007rd-Og
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:28:01 -0400
Received: by mail-ej1-x644.google.com with SMTP id gr14so20244877ejb.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fVD8/ijvd9x3TokaTFp7vxAe7gqKyc693wlFeTxVaGw=;
 b=YjDsFwgRp0NNXtBEpKWtHVyjBeyw2Of9bVafvrSxIPtSwUv/Y+aa9v7INi1zGpyLBW
 XBUvgluyVc4wnETU/GupTwEi1OmIsnuaE+B33dCC/wjbjeDC90HHNx2QpbwkgyDagpzR
 RwxRST878hzVNmdVcxbmMRp87cSwI+BZd2IY/0cnq/aPV+QrvBJqKYsE+a5Pu7T/+68G
 Wf7lgMpecrbqsUOVNG/xOq2k6PN5/VIUDrNEfeBN5iTWk2RwmzubBCrDsSi9Jerm1n/c
 +K4PkL2xdlEuXGQYzom/OzzUljuLnOsMpz3f1wdgKO7TaJwNLG//UW3H8LVCAl1+KJlB
 S3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fVD8/ijvd9x3TokaTFp7vxAe7gqKyc693wlFeTxVaGw=;
 b=lFHMlUvEiJ7CRK90SrC5alz2snnmLTHx7kUxNqX/0XuplEQr2JM4kC+WRchxImIE9y
 S6vEtpLQRxkAvdNWKMJSOmafHuM/4wju6ytN7fbhlAQ5dpg9iSRw2u1A17LZcP6eKAOi
 Hv4wNDmn5tW1BhFMx0tpXReoj/JUP2VTO0X1w5A98L824wQED4bSoE7/+LBImQLnajWn
 +XTglCYGX9EwGF1z5GCMtW8kHj3fMUhuqO5KTMmgW+s6T5khKYAd1TriOnAgYJHkUOV7
 hPf2Sl0+0fDGShjeoqedc4pFX0TlfXmtNzkF9COy8ONHSszaehuoUtQw4+SDRHb48xK2
 Xquw==
X-Gm-Message-State: AOAM530aWoExwJoDnD+dUuxymWy9CfPAFcb0My4GKLhklz7wHT4SGBRU
 6CuCYm2agZyxnbunblCxk1aBxCgWZr2Wh1cYuL4/vw==
X-Google-Smtp-Source: ABdhPJxwXU9Gx0pXaR49/pAYWWnQGHSq5HP3sL9D+CycajzfJgtA83a6vIrEGRhyEjlBrw+YKVWALOD0OeK6PVNtL5c=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr11922261ejv.56.1600025277392; 
 Sun, 13 Sep 2020 12:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200910131504.11341-1-alex.bennee@linaro.org>
In-Reply-To: <20200910131504.11341-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 13 Sep 2020 20:27:46 +0100
Message-ID: <CAFEAcA9s5j9DrDkrwBPmfK40FzeXsS6qLKD1Y3cTKgBFJbk_QQ@mail.gmail.com>
Subject: Re: [PULL 00/10] testing and other mix fixes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 14:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 9435a8b3dd35f1f926f1b9127e8a906217a551=
8a:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/sirius/ipxe-20200908-=
pull-request' into staging (2020-09-08 21:21:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-fixes-100920-1
>
> for you to fetch changes up to c17a386b6afe608086aa4d260e29662865680b7f:
>
>   plugins: move the more involved plugins to contrib (2020-09-10 10:47:03=
 +0100)
>
> ----------------------------------------------------------------
> Various misc and testing fixes:
>
>   - Expand CODING_STYLE.rst a little more
>   - usb-host build fix
>   - allow check-softfloat unit tests without TCG
>   - simplify mips imm_branch so compiler isn't confused
>   - mark ppc64abi32 for deprecation
>   - more compiler soothing in pch_rev_id
>   - allow acceptance to skip missing binaries
>   - more a bunch of plugins to contrib

Applied, thanks (we can tweak the config-deprecation code as
a followon patch).

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

