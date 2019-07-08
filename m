Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA30C606AC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 11:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3844020861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 11:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdiGmewd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3844020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkS92-0004gb-D7
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 07:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53558)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkS8C-0004F2-CQ
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 07:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkS8A-000492-Vd
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 07:48:28 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:36787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkS8A-00047r-B2
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 07:48:26 -0400
Received: by mail-ot1-x335.google.com with SMTP id r6so15874940oti.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k3d31IEq5qZXrX/F6lZvpvJGUfEUJBWkn2Qu2ibhuho=;
 b=KdiGmewdISH5G2aetgwbIUK9DrhathPbwHy/ZAmKsL85TS+F19Vad3Kn0N9QVdh2Ua
 enekEUtWsVxdkexUVMvQgso/nHTtnbovze5VUfHtnMgx1Rr5+Hv8UivWLvb5TGze50Cs
 YIHrYWCRGXcSLPxL5Xq9emohiYMtinmyRJ4y0S/YpZMXiTjBQZ6gztznHqpQ0E7agaNz
 7luqbNbTfcnVx5q/GnQx/SIt+OFhBOAQRhoDPCGf6wvyRuOW6+SJarXSLuMQ19y8oc9Q
 vjvBcdZNNLsAe3Z0tMl5ZDyC9BX5u4ijZaLQWuc+qe442wc5pOhc8V2Vip25dwdAdjI5
 5YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k3d31IEq5qZXrX/F6lZvpvJGUfEUJBWkn2Qu2ibhuho=;
 b=t5UTRXgC6OKjF3v2m5gPmc1id/RWn0QGFXexzbY49RHX8oArAjCnD4W8t+KJtO+DB5
 Ea2QketBd6GzOGta1dI2zFMC6Rhl69HcpnggCb/k0TtEwgETADlCVJ5x8WeZmiluUrQw
 KVog68sqA9ER1sB94bPfGat67OxFnE2/aqhJGdY1w234XRoDF5PTZUWjKmqCdBzeEENf
 zFXxaSoA+guT5Ywdx5kOfbbTNT16SGO8/Hw/weIyTlv0zyFaX5ARPuZS+CJh+eu7Cre4
 btiIMKjgeyXHwldvurur9BHB98PhR++A7GfL2rLkgTruOO5w0O+He+mMxUcfqHrXOAFH
 pBVw==
X-Gm-Message-State: APjAAAUiaMvNtqhaxUis/PqDqHsOYmSpdXlQu27WWpzIyoWwHwCyPpmN
 Tt23P3uZ8qgwiITJRqUlQVA1DBIsjhjfPkQ+mwoCSg==
X-Google-Smtp-Source: APXvYqxTTSneLLInZi3zno9X2v8VgdvFSygNfceGmw3/X8MTfTYnwzJ0qhr3vp5P3BS/YESpl88MDc8UGo9el7+BuRw=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr12989593otk.232.1562586504846; 
 Mon, 08 Jul 2019 04:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2019 12:48:13 +0100
Message-ID: <CAFEAcA-SB8gBVaCwiEncce5x-Ueiq0DdQRKsEMr-Nf+HosshaQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 00/12] Misc bugfixes for QEMU hard freeze
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

On Fri, 5 Jul 2019 at 21:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 39d1b92b810793e02558e05efa23059f67520bc9:
>
>   Merge remote-tracking branch 'remotes/bkoppelmann2/tags/pull-tricore-20190625' into staging (2019-07-01 13:47:21 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 03f990a5e31e28c9a2794729638f2117e028bfa5:
>
>   ioapic: use irq number instead of vector in ioapic_eoi_broadcast (2019-07-05 22:19:59 +0200)
>
> ----------------------------------------------------------------
> Bugfixes.
>

Applied v2, thanks (after checking that 11/12 had had
Julio's s-o-b line fixed.)

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

