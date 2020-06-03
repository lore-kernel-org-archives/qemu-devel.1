Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F072C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8665920679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbPP8nhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8665920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVdy-0006Cl-Jf
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgVdH-0005fM-1t
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:48:47 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgVdF-0005R6-Ou
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:48:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id v17so2269883ote.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RGSVkw+by29jobeefAjKGz09o1DcHzkjkLfD33X4tHM=;
 b=KbPP8nhKX5Ml5eWRgO+RAfNydB23yd4oNWp96OGOPsphgUz0UlJdc+ZV0hiL0GQOqN
 adHzk1yX6Xxaa9ZPXyw1nu7EMwhX8rQ2kSDBEq9Bh/YC7hjfSZVOG6ggAW9RU+tGMidm
 hQVuLEWBQymnvlizS2lCKNacEkMzEVg1BVIQUdSZLpValwK5slPwm50gcCfjWRA630bo
 Uel6475130rsKruZRoEmw6STkWRUSoQIP5DPGIn4BUsHpuiiumjYNbq2wn2pYUHTtgPV
 cdWWraGsgVeZlg9SZYaZizHC2VLqexy6ge8ZDie5rpBcVRo1jrRsUwbdcEiSg8boCO6J
 ziCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RGSVkw+by29jobeefAjKGz09o1DcHzkjkLfD33X4tHM=;
 b=DxXOiel7j+Xg/nbEhuld6NAuab1zdvcF5uUjJ8Z8QC+BJOl1V4vyfGODK5tq1E/QMf
 q6nu8HpeBPcnSEflP1b6G5T+FvLhvS8r9Hx2Nu7RdDEpWNulB7Its9N2dIrFavgpFX+y
 Cl+gW1Amr41F9yC8sKgsQ2jrTtZTyus8SN2NqalFaSI37xdNtA4ZQTgwMT74RRiHw1pK
 /DgrpLCFY8d4oAcj8wwpv9P4iOob37RLGfsotrpwTiDWv7OUMghZZivHCFYlth8sXlJ6
 1KJFfs9ZsPwmdVORClihGDc3trAqD+oW13cVf+wyuVa5H6zXMndbYfFJ6HwHlWbJ1OJ7
 iY4w==
X-Gm-Message-State: AOAM532aM9aqm7WqBe8mRow0BGCMljBPOpsXSGk7fX63faE2Excs/+7d
 nLFJHClzfjIyuShhFB/XkTWJZWPssFI3PXg2sxUX2Q==
X-Google-Smtp-Source: ABdhPJyabSEVGKB7rwJ89l8WxKQLpY40HTRfoh4gc+9H/SkgvcLjANCT+MWEK55rUU9Wf6DS54sWnCs5WrwlTpWVUvs=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr449076ote.135.1591199324408; 
 Wed, 03 Jun 2020 08:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-9-alex.bennee@linaro.org>
In-Reply-To: <20200602154624.4460-9-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jun 2020 16:48:33 +0100
Message-ID: <CAFEAcA-kPZoumxfLgjxPfCPDmPgsAFCjB-zdicsiGeqSOPOH7Q@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] plugins: new hwprofile plugin
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Robert Foley <robert.foley@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Robert Henry <robhenry@microsoft.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Peter Puhov <peter.puhov@linaro.org>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jun 2020 at 16:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> This is a plugin intended to help with profiling access to various
> bits of system hardware. It only really makes sense for system
> emulation.
>
> It takes advantage of the recently exposed helper API that allows us
> to see the device name (memory region name) associated with a device.

This feels like we've let the plugin API get slightly more
access to QEMU's internals than is ideal. Whether an area
of memory happens to be an IO memory region or a memory-backed
one (or whether a device is implemented with one region or
three, or what names we happened to assign them) is kind of
a QEMU internal implementation detail.

thanks
-- PMM

