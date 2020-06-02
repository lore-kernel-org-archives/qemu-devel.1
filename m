Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA64AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737E720674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPtI1gCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737E720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg7ra-0006lo-Oz
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 10:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jg7qL-0005by-Ts
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 10:24:41 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jg7qK-0001Ya-4K
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 10:24:41 -0400
Received: by mail-ot1-x344.google.com with SMTP id o13so11031644otl.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PJ40ExAxQCDlLWUftHWBthJM+Q+yX4wOOLAGhzhMp8U=;
 b=QPtI1gCXhSVqUzbohMUqyLsKszxi4JOnkZ9shDdl9ReyyVf9OP+dQmc3yhETHPRSQa
 UQvf1dbNQ9pgbzpLnbPbZJR1HAweoI8Ve0DGUIsCDqtyjpqsH/pR4mzdyK/mBe+P5t0b
 89yFvskU25oIgrLOBrrZl1QuFGuBrH+OWPyimOpa1bm6UqE0gQ4pYybhfYpmHoPFqN63
 dNdVImmqvfiVlmKRY/gSysWskZVMvWPk4YmoP87K1yIL49hxsRD8IeXjgYr0NcDMLQXx
 xt5zkVgFvLpN9iyD6s2rhXu+OmdECd26p3KP73+vcz0LnBS6aqbV+BME6Rxqm6OgWWWs
 e6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PJ40ExAxQCDlLWUftHWBthJM+Q+yX4wOOLAGhzhMp8U=;
 b=sDy4GZ9fmYm/ARhueqXsWszLFtHDDVzs9L2ezHCxWz9TXHKmlrI5SgJ07Ah4TRjEzU
 RNTGoC289HhYemBADOivrRNisPRJ3u7fTdzQwipE2aXRxxcXjXkMhrDScpRK+Vvx53CK
 oyIN1E2810PSuuChu6l6a58LdB9e54jfNh1H4bv5fHZt56xhsz/0/zGugN+6B117smmq
 Gur4NdSnr3jq+A8uIpelEhsNmRVn4rjZP/4ZwP/UjtzBEYK2qVnCQfDukHsnNsZeEofF
 6TAug3p90VWRbtItxGKczZPzUDOIBxjlX+wJUrcyMviRE6+sMEnxoR2AHfhHpuwp7ov/
 Du7w==
X-Gm-Message-State: AOAM530Y6jMvb1QhaJdmjaDkbOEoVPfUD/T+Lt31oVUMKktlnMP+NEC3
 F/ygAxgVMrBV3HpWDrHjN0awD5WCM5dsVOuhCn3ZYQ==
X-Google-Smtp-Source: ABdhPJxUNq7nIPdZiqE4b29H8/7p1XcESq3dWY1dSplLUkDlLd5ixTKM1TdACP5uzjMfJ/xk97cDLNwE2TJwLEGSZaU=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr3712251ote.135.1591107878866; 
 Tue, 02 Jun 2020 07:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-3-richard.henderson@linaro.org>
In-Reply-To: <20200518164052.18689-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 15:24:27 +0100
Message-ID: <CAFEAcA-1B_d5LzeKu+BgNamSHOri0tvgiiakM3z8-2vDnmXAtA@mail.gmail.com>
Subject: Re: [PATCH 2/8] decodetree: Tidy error_with_file
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 17:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use proper varargs to print the arguments.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

