Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78716C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3975520870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REX0GNfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3975520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQwS-0007EC-Hq
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:51:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDQvA-0006SU-PK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDQv4-0002Vp-8B
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:50:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDQux-0002GK-Qc
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:50:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id e5so11379739otk.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=5kEWywvhWGs0QztQEvhwHOU85PvoNt4iO3nA0Ynalo8=;
	b=REX0GNfGVfeMbUp4Yeu1BsXzsGSUS3LocUlO/vxPrI72LnxYSMgOHxLnfkz2pwejYp
	Hc3HxQE+jLdGoYdpiYG8IoTKKcx50tFsF0JqzikCcggp6+Xb/QAck2oEyt4xK0o/PeUq
	HZaJApEy2HC/8HWu/eZItYFG7WxqQsuf3oTrn2F8S8LwmSvabvjl7o5IfSveoZG/c0CO
	QY38ChT/biDAUo71UwYA3K8IibgvFnNsEK02g3aExws7/WdpBfW7auGhC517A8+XAuSy
	0TXDUtbg8OB9IPDnYuXCSntZveljXlMRHAI23k4lwalKRKjAA4AHBaVXpWoghgwnrF/g
	wDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=5kEWywvhWGs0QztQEvhwHOU85PvoNt4iO3nA0Ynalo8=;
	b=ofggjAzC3hYTZLacDA1jQwu/Qq5DXqqYCnpurcjjOgqNUurrHsbKdFO6UrAeIqHszL
	4XEDEFi1etAsPZWCNR0FimMqzK/BjJIhmh9I9zjvZn11GuZbAXVC34xOEM1EhW+MJl5c
	SPfVNMm532aeG7l1UFk8fAS+7g0nFEsRjJhP2/JwQgZ+rgUFyJ6nPnoNQ9JdMDvtWx46
	mU6fwqrW5ADc8CPMDJUVIoxHyTKgCoR4536+hnkTyyaWUz+mvD9oJ5lo3q1JfH8OHn9D
	GqoUmk6tfTQJsnJN4sunJyNlBY5HuzgYaao7hBaRmZM+sbNjXo0DpSfTyQUXhEoSrKGM
	Rstg==
X-Gm-Message-State: APjAAAWCrODlbR+PUtVAMtyy2HCPTurVCYHPNo/tTCArJJj1hWXK2BR7
	VmFvAGmH0pZrHPotxkv2Ifrn1rF/5D4HlmWS089JDg==
X-Google-Smtp-Source: APXvYqwdfckKaboQH0ReG9pO/bUqEvdupmmU/c36O2xyvgE5qcZEygcfb6my75cyaylZ3PZ3sniX8YPVo2lvvo7A/F0=
X-Received: by 2002:a05:6830:164a:: with SMTP id
	h10mr19327598otr.323.1554716983873; 
	Mon, 08 Apr 2019 02:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190405231225.30165-1-mst@redhat.com>
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 10:49:32 +0100
Message-ID:
 <CAFEAcA9SLSJBhZV1bfdv3wA80mDLZf1bTPvQgGA=Rk7OMOVfOg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 0/5] pci, pc, virtio: fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408094932.rVw0kQC5uzhm5s2QWY0f2ndDKOrTWWUp4EOBwLQVmCk@z>

On Sat, 6 Apr 2019 at 00:12, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 436960c95946007aca713330e7a488a6f2e0696f:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/filemon-next-pull-request' into staging (2019-04-02 14:52:17 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 81fb1e646e4da29f8e1639022241323b956b67e4:
>
>   intel_iommu: Drop extended root field (2019-04-02 11:49:14 -0400)
>
> ----------------------------------------------------------------
> pci, pc, virtio: fixes
>
> intel-iommu fixes
> virtio typo fixes
> linker: a couple of asserts for consistency/security
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

