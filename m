Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4FEC433E4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD9D206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCuoMZlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD9D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtC5r-0007T3-Di
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtC5A-0006lR-Q2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:34:00 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30]:40063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtC59-0005M0-8R
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:34:00 -0400
Received: by mail-oo1-xc30.google.com with SMTP id p26so3041035oos.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 08:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R1NsK8wsUI1LVy3q9K75Q7Fr1NLUeXoNRv/7Fz1PrN0=;
 b=dCuoMZlJxyr0icXif1I7iIrFX+IMeaWFs9SnQ7TgAMzoqcCXmjSCQgFVNWaBAM1PiT
 3osOme97lPCwFC8LmNRXzH0slHz7m8NtoXlGiwkf29GnzndIy9HVF/h3ReQCMsfQdZ2X
 vshgenXE+PTlEtkr71vsALPlXVW2IohSPIvADuDduZ0Zm2h4nWxyffvOmKTJfZHb7WRM
 klBFu5Mb/bNbAnq9ER17TBe+T9ey0WiGUohXsdyxIT5+6yJtn9YVY+lppJk4795Hu+0F
 EvePRnqBk5AM7gbAxaxSwuiTOmqxItwmzuQ7VfTF1o4g9hUFEJuHie/N0HeDX38oQsjl
 Bfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R1NsK8wsUI1LVy3q9K75Q7Fr1NLUeXoNRv/7Fz1PrN0=;
 b=DChEIW3YkAp7REtq48ahKg+grJb2diRFcXzBzcYQg5gJf4WtvR/LCncgn6nAfBOcBz
 ZSuZyMN1CLpg75o2JqdcJoUe4uNCYwkA6TmJKPQbHoK/1S9SN/Bwshxa/MG1F9IDZL8r
 OfLtZGtR7dKDLybJMY4mgwx5qzfeDEj9IAwkXDitzlm8a75QBRv0HrAJ2BGnnn4PftKb
 4iBS8WDy4c6h3AYwns4tFlxrXTEWeSVL6Pdv5BYQOCYYi7/g/iXTG4m+IMiqB/OqoIZW
 2eMivKkXYP693QDlSGmsb6o0tjXmYPmSoWYPcMs6GDZ6vajU1gUTVC/yUgIKFitcK+z2
 5HTQ==
X-Gm-Message-State: AOAM5334Tf+mASyIQHe2HyJau67TqGcafl7U2vdU6RXLnuqQiBozst8+
 MJ+j3s5hSTsCTJrbh6UDzXfUBPIh0zu/vvic+gaq0A==
X-Google-Smtp-Source: ABdhPJwqsK9dZ6GRzWqlMIJhe2C0xtruzJicGWxjucGJvg10rbqGp6hhxmLaPAwITcJY2L42wVkMm+pWbsxRq14ykgE=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr28713758ooi.85.1594222438032; 
 Wed, 08 Jul 2020 08:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200706185248.118447-1-richard.henderson@linaro.org>
In-Reply-To: <20200706185248.118447-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2020 16:33:47 +0100
Message-ID: <CAFEAcA8jxs_fr-qB+qEfXQeuj92-SrJwXEF_zTkvc7y0UHBqtA@mail.gmail.com>
Subject: Re: [PULL 0/2] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc30.google.com
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

On Mon, 6 Jul 2020 at 19:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200703' into staging (2020-07-04 16:08:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200706
>
> for you to fetch changes up to 852f933e482518797f7785a2e017a215b88df815:
>
>   tcg: Fix do_nonatomic_op_* vs signed operations (2020-07-06 10:58:19 -0700)
>
> ----------------------------------------------------------------
> Fix for ppc shifts
> Fix for non-parallel atomic ops


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

