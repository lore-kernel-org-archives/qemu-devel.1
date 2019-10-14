Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1437DECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00FD2089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Je53wsFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00FD2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJza0-00063Y-PQ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iJzYj-0004k9-KK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iJzYe-0002rx-Uz
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:34:42 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iJzYc-0002ly-Qg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 08:34:38 -0400
Received: by mail-ot1-x341.google.com with SMTP id z6so13644236otb.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 05:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5+2HehZqnp5IZmuCABEWMKu6hwZjiCi14h8iCOAU+MU=;
 b=Je53wsFajxjKmCxUh06DYx0O3j77muiBS5+RccsI6/K0cKsw7bBdg8t2JNGkivoOU4
 Uu/i6YHqAgHOoXdOxTHjsFm6UKftXNY6cPpouVQxJCAA/4cHdJMQ47d81zpA+LM1bC2I
 ofkJE2f5SmZyJm9eSmFipLT4/QHeWEcWdlM0C0JY/lZrFvhim5skvZGh9UIxZ1HiDe2C
 VHXNMg3dLneuPNYSIlxKqxOMbY0zk9rDjJyQuUYCVmBlxezt0N84A/i1fKYGdBANDFnZ
 6FXQDGEX1KNQCzcFHwAiNQJ6/RWbnfWnrFzIIwnPMAeLbfkJgvU8l6MH6n17LDsaTRo+
 j2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5+2HehZqnp5IZmuCABEWMKu6hwZjiCi14h8iCOAU+MU=;
 b=mFwaSSMRUMhnCI1WlsVu108vPAx+tYeo4Jbnl4/QTFr/h3smoUhJ+tei/wFXA4Ot9m
 XUsXxaHeDnlCwntT/FLILTVZnh86B7bKSwGBreVOSpg4McmdDeA8Z4hRABGgUWVhKUlt
 JpA9nITbETl+UdO7THcRvLYRWPtTC10Hx2IHDI1VG84yVg42EjwS+ldFYtmwiO0JgXkb
 OdxI6cDVkWhymSuQ0mZo5iFa+iSyxQ3e06hfcGDpAgm894Rv/yGlpM7/faUhanAQBtcL
 ytO/MavhxqcYOxhEBTHHhfwZkwmastbfdLLbj7kAglWUG0U7eWL5JzROAo/zY20Xo48q
 07xg==
X-Gm-Message-State: APjAAAWP2TKQ0odDZ0wmTGGMATUUrB2RfrvOrETAH23UR2xoxKWPDeAn
 9JKQhdmXOeqkvjoREfolFhQSRKjME0YJEstPoo94WA==
X-Google-Smtp-Source: APXvYqwLaRJDqjaW442GrmePd+81OK9uBvgUEvLjnCtcGOI8n+SK0sRI0TGMn48TFbJy/EZQspfeOn6I0O3C0jXtP5E=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr24493227otj.135.1571056474850; 
 Mon, 14 Oct 2019 05:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191010114300.7746-1-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 13:34:23 +0100
Message-ID: <CAFEAcA-H7qwTe9NRP-r8caToRnwmD4+49436BtD4LH2vOBK6Fg@mail.gmail.com>
Subject: Re: [PULL 00/36] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Oct 2019 at 12:43, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-10-10
>
> for you to fetch changes up to 35f05b2e2ee59e077bf949057dc0959ddd6e5249:
>
>   iotests/162: Fix for newer Linux 5.3+ (2019-10-10 12:13:23 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - Parallelized request handling for qcow2
> - Backup job refactoring to use a filter node instead of before-write
>   notifiers
> - Add discard accounting information to file-posix nodes
> - Allow trivial reopening of nbd nodes
> - Some iotest fixes
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

