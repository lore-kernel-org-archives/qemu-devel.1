Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B44C433ED
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F4520656
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDlqGd08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F4520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYVz-0003mW-L8
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxYVQ-0003Ka-L4
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:19:08 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxYVO-0004AI-T1
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 12:19:08 -0400
Received: by mail-oi1-x244.google.com with SMTP id 12so14804467oir.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gYab95KTlgSe0lUVDL6GmfEMJXEuwj3Vn709Sj92YRw=;
 b=YDlqGd08s5sQmRQB5zLbqKn0ayz4sY0Q9mMF6tt3ngcQzJ2ImJsUW4j2tZTW43qmAA
 v9YHVQ1HodxS2rulPMOhlqqY7X6t42mgxsTYpOZsJuCtJTf2DY6Y4+/5x4ZOr+2RJgGU
 fJovT1B+k7mRoG2d+rIMckKz6lv162Q62jozOLCeaB+ecNIMMxYOpIEtc860PD4vDaTt
 dj2IU4NWurUZ9KEkDAgLHgJ9HIJGDa0de8d8c5k7cGKEz7Or6FBmzj34ajRieXaGAxly
 29U/Qj12ngCztAd43Zd8O0E3X88uaONZKL9cF3YoYiNkGkRnVcPw479bgW/BUCxiHRiK
 qROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gYab95KTlgSe0lUVDL6GmfEMJXEuwj3Vn709Sj92YRw=;
 b=mIJH2R/xzn+rP/XRDI8lBX4EJ2HGdXclJ4ry36C2SYJXV2YssFX/b4tilKRO/qhhwB
 v6F0R+iwH4rJBogajw+MxINBys941eAOl+rubVnxYMUQncCxGVL9lmqRmDG7OU2A20Ie
 BovvEWnvr0D/4iWGv03kd8+WAntxeSvEVIBHHcK8Wu7pkTfjS+ZQ1f80Zhima+5/zAjK
 ddaVqT7igifl4/p07/7293QACxNW0BqNDgpN/C8BvRBKbZOXJD7igC0zdS6k6G0CAemK
 62m2eFHk1+2kCo5WnAH+A4xWYIZGG9sVeAy6adlcXsG3VSLwYy6bhF9ioTbu7OmkjHmu
 90gw==
X-Gm-Message-State: AOAM530Awtnzhf5ZsaBah5V1d2J7fJqR23CkNpqZdPNNfsSHStnHAOsD
 BfvKMAtVkNNTRjfNF4RN0Ve6EW71AgiMBQCRJzPisg==
X-Google-Smtp-Source: ABdhPJzNR7P9SBVfU8Bd0/+pn/7OizJwV09Jky07eLrayAcphxyQ8lHmr4xhSMFNzjjbuW404w1MEYbOTRBi0FD+ISQ=
X-Received: by 2002:aca:2819:: with SMTP id 25mr117704oix.48.1595261945323;
 Mon, 20 Jul 2020 09:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200709024657.2500558-1-crosa@redhat.com>
In-Reply-To: <20200709024657.2500558-1-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 17:18:54 +0100
Message-ID: <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 03:47, Cleber Rosa <crosa@redhat.com> wrote:
>
> The idea about a public facing Gating CI for QEMU was summarized in an
> RFC[1].  Since then, it was decided that a simpler version should be
> attempted first.
>
> At this point, there are two specific runners (an aarch64 and an s390)
> registered with GitLab, at https://gitlab.com/qemu-project, currently
> setup to the "qemu" repository.

Could I have a simple "this is the command you need to run to
test your staging branch with the project gitlab" set of
getting-started instructions, please?

thanks
-- PMM

