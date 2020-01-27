Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0A9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9FCA21739
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOP7rp6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FCA21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9Yy-0001W0-1O
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iw9YH-0000Qb-Pr
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iw9YG-000861-JG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:56:01 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iw9YG-000831-Aa
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:56:00 -0500
Received: by mail-lf1-x142.google.com with SMTP id f24so7023181lfh.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 10:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fOcmpA7CjpF4UC1ZwTqTRtGAwa4AqWGgXPV2264aN8s=;
 b=iOP7rp6XYotyyR+O/B3FnLfZ3+88zLNxiG5XYlXU5GfbFarfiAIeXBko9U5Si4+WSa
 8rGpYc97kgQZlGlGize382bR+c95sai0NLB2yHROzepdu8qbbjy9SBVAPejP2OQTwcSz
 0E3aLGZc5jOZPOIcUJ775csOvegtOUQeakLSACcQ7Yk39zBEkmfMC5xlGnA3CRmVU3lt
 kWFBoqxSYP+y8c10Cd4uPvl/uMTkm/lNqZcIO1fFXGHdRv4rhcyzKm9LicL4rTYcMWSH
 HexE6bLXJZ5Yn5rJYiaxaRkpNZdRq+LHcOWX/xEuNg7k5QJl6Rg4c5WtbTbL3jSP9Dvf
 3zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fOcmpA7CjpF4UC1ZwTqTRtGAwa4AqWGgXPV2264aN8s=;
 b=ThQWXEjkKrv3vTpbTqUhTezBh8pbtHxGeffYsPGjTAvbptnhbD7ZTG/A7ss/fMy7gR
 G7eA8ctiCVflyD9SIyDHAFf5d++FZisN3jrAMSfyAqrnBExG0PMjkYvDwg/PMl1Fs0Ym
 iT68wt7y7ceX2mP0cD0X71A0GdMAnJeiqyhbsAjZadKAInUCR7Aes8lIYnIaeuVkE/BD
 u8y+yNIypPucQnALiI/kLlPslUlOSeK0cKCbdbTCa2lssKAy/DN+DD+Yqoq1QY3ROF3h
 L0ryhfcJV8oYn+KGll8s/zW6kByYI+OsJ4j0nF6cAOoDIOYi6bO+Mm7N4s88V7YcVQKW
 AV+w==
X-Gm-Message-State: APjAAAWpEmMo8nbcEdLMmo3KtmCxLT4FrobxkSekVOnk09n7zp1DaePe
 LX9kk0vPkcQs3hPVzN5tstE531eBrtK1LkXB8wuprA==
X-Google-Smtp-Source: APXvYqxpC1lObaZYUfZp6sRs16x4Wz0fm5pCUFrti2k/FghTvJCRBYjp47t9JXIRoHBFReHrItEqB+bgQh6mCb33TU0=
X-Received: by 2002:a19:6445:: with SMTP id b5mr11776lfj.187.1580151358562;
 Mon, 27 Jan 2020 10:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-8-robert.foley@linaro.org>
 <87imkxeyew.fsf@linaro.org>
 <CAEyhzFtRV_4oss4gxYJi5ojGrXvNZExXfM+Ae-idLqidtcPpcQ@mail.gmail.com>
 <20200127172716.xvfkyhqznjlxefgn@kamzik.brq.redhat.com>
In-Reply-To: <20200127172716.xvfkyhqznjlxefgn@kamzik.brq.redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 13:55:47 -0500
Message-ID: <CAEyhzFs9-b4QzemPGY9+3KABV_maq7iCQ1u7m-HKcHWjTN3Cug@mail.gmail.com>
Subject: Re: [PATCH 7/8] tests/vm: Added a new script for ubuntu.aarch64.
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On Mon, 27 Jan 2020 at 12:27, Andrew Jones <drjones@redhat.com> wrote:

> >
> > I suppose we could check the version of QEMU and use the above
> > defaults only for earlier versions of QEMU.
> > This is something we will probably move to aarch64vm.py since it is common.
>
> What versions of QEMU do these tests *have* to support? Because we could
> just skip the tests for QEMU that doesn't support cpu=max,gic-version=max.
> 'max' is indeed the nicest selection for using the same command line on
> KVM (gicv2 and gicv3 hosts) and TCG.

I believe these test scripts which build/launch the VM have to support
the older version of QEMU since
this is the version of QEMU currently used when these VMs are
launched.  I don't know the history on
this, but it seems intentional that we use one older/different version
of QEMU to launch the VM,
while we test the 'current' build of QEMU inside the VM.
It also seems like a 'nice to have' to automatically support the
latest version where we could
use max as you pointed out.

Thanks & Regards,
-Rob

