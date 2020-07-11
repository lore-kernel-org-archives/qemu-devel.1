Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469B1C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E5F20720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZmdpvNJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E5F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juKUV-0007RB-B1
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 14:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juKTy-000725-PC
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:44:18 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juKTw-0000nh-UO
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:44:18 -0400
Received: by mail-ot1-x343.google.com with SMTP id 5so6579224oty.11
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fr0HYMc0KK74eEvMA67oBvTwC/XXaD278hVtjzTdboQ=;
 b=ZmdpvNJfwxKfZPNxG3Ls+5RxH1gLvIEfMHqjTWO7yzDRtB3f5FBOkRGbZSBfCmKga6
 5gjBOxChu9TY5ZL32a9IWCZFY5Am2lI5PS6pDo0pz3fEYqxZGtup6w0/ayH2hNN9hclE
 T4WJGsZHMnfuTmMv4wXRRZ7aHL1lz9UspY8gO4ITgp7E9SW3d1s4TCWf7w9oyqQlNekS
 H4TFjQbzKwGxg9RE9OD4t9edKBaIWRf4AplzZUqXHxOwiIMAhVk7ExpfoQ9Ald8fJHoc
 7/PzNzFDJVzDKnxvcgwqrLgw6RFmZY+bz5NvdxfCUMFkmpmW680p1q/Q6AET4Qd7bowJ
 sGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fr0HYMc0KK74eEvMA67oBvTwC/XXaD278hVtjzTdboQ=;
 b=ttpCBsulxVjWNKcZh7Vm+JTA9Q0/OKhXrTKPqJRZOmUHawJYe0matgl1h4lynuv4lT
 /qal02CrTk2b/IUNMc9S/57FKMZvbVwo69ua+JcO002e7q8e6avPIJEsiZsph9lqskcS
 8BjH0nLfQwUKgvgOsuNxG81J28kuEtCXNhff08LLHFMqUbfmemsDBrOuRL30ItJX6gMZ
 viQKR+LQAKaVRYDXYvd3huJ9ATr2StfxOULhLqP7hp/6xeVIVe+HNUl5FpwQceZ931uy
 EAN1SjwrcBfxNoda7nUMknyPefN7Zxc7BUD9GnwAQJu94ZCpQItm+sIsARBzuQc7970M
 ODYg==
X-Gm-Message-State: AOAM5331zIYVtko1ugyZ9a9Dp6Bui0Yfo3KoDQ+X7MF1GeKcUKnn6QM2
 HgkvnyymDCRD1SAGeJ2yuY3JzXNMqK6HW9oycDjypOUk
X-Google-Smtp-Source: ABdhPJzITQnL7WRP/mACvBpAqHSI+ulCEPEgM5/jIHmJ4WN3KbFUS8ZyOp99p2wQ53Zk9qpRmzJ03QiAUHLg3CWTSLc=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr56385428oto.135.1594493055055; 
 Sat, 11 Jul 2020 11:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200703145614.16684-1-peter.maydell@linaro.org>
In-Reply-To: <20200703145614.16684-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Jul 2020 19:44:04 +0100
Message-ID: <CAFEAcA8UpTzG2Loc8sqLcHVHaYLQr9fR=-b28LYhVTgGC_RedQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Build fixes for Haiku
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 15:56, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset is essentially a resend of David Carlier's build fixes
> for the Haiku platform. I've taken David's patches and put them together
> into a set of emails threaded in the way our CI tools expect, as the
> easiest way to get the patchew robot to run the build tests so we can
> check they didn't accidentally break one of the BSDs. I've also put
> in the patch from Gerd that fixes the drm.c issue. I've also expanded
> on the commit messages for all the patches so that we have a record
> of why we made the changes if we need to look back at it in future.
>
> Assuming no issues turn up, I'll arrange to get these into master
> at some point before the 5.1 release.

I've made the minor renames from CONFIG_ to HAVE_ where suggested
and will put these into the tree via a target-arm pullreq I'm
planning for Monday.

thanks
-- PMM

