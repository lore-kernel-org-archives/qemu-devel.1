Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A5ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA80721835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVBABDWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA80721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8fi-0004h3-61
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL81E-0002hU-6V
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL81B-0007K7-Id
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:48:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL81B-0007Jj-DR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:48:49 -0400
Received: by mail-ot1-x341.google.com with SMTP id e11so2305876otl.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=94hQ4hS26Gc80H1gPDmnkPs72qalH6DjEZVes+qBZJE=;
 b=eVBABDWiCA1fnMq15WPL1NObVpdL5J7Sz7M3Z2xO2dqDgp0EDl2qbQjrhnMuyRtsr7
 9MQiDT3wj6KnvWWZ18eKyUUf0+E2i4BNUupY6tdeiGx3IrzT0zWc+rIw3pg/4W8aTKao
 7+dv6wEbCDftsNK+3HXacaM9pTAqE5Ms+4h0ilxMlaraVkAtGLDvNM115NFrR0Ga46jR
 6aWkWBGTCOJKVyo2WcPk8YlrTLvXsPotet1gEotoEE/ox9A5yHIOidej1Aba5GNS/JBg
 vTV1Vh0NeGG76NVrM9b8ojRrXm9EllqJwbu6c3PgXIsKsmFPH9DUE6pdt61c5pr6lvuS
 3OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=94hQ4hS26Gc80H1gPDmnkPs72qalH6DjEZVes+qBZJE=;
 b=tnHpPwO/ibShI7gqW/MecLlv5oTIGHtoUdGPTiHEd8f6JAHSsvmhG1vtmP3mYMxyre
 YQu3GDD2pC59RtKaLladYymc/TLtPUMc9NZ4CvFlCZCL/D5AUaCcmQygaZt4CaNujeVu
 fB6rZA/ka+5t/IiQh+lNXFB3XLzzwzmj23cAI6c3CxVPNYD3QOg2ZAc1Ep82jCFDgpIg
 VGtIN704zw9rpz8c7HFCqZ7Ocgg2kj7WU8qn3SOvwy1rkUgrknWOTuwvhy0OasPPE/ar
 cfCVX40luTWmnitplNll15pvAnwQx08uq7j0s+SU4T1/0qqI3fGt5L/P/yUGYoHQTnl1
 AbhQ==
X-Gm-Message-State: APjAAAWb8RxVSuK/zcRkdfiqz+ZfITwPNu2qoccaBpuFnQm1OchBpmRh
 tZ12ugmpUrWCFJjaoNlTejlERJmnEHlpX46mNUB45A==
X-Google-Smtp-Source: APXvYqxp1g1zDf3pD0c3cWMJ4st8Wf0Q2hwfTdZYGFttcslfSn5mw55e2DBrXDKfe+/x5Lsm2Fp+MbEdYDgVlAvtQpg=
X-Received: by 2002:a05:6830:4c1:: with SMTP id
 s1mr3787882otd.232.1571327326966; 
 Thu, 17 Oct 2019 08:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191005215508.28754-1-mst@redhat.com>
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 16:48:35 +0100
Message-ID: <CAFEAcA-_pATmTJPQF8CXGxR6tJbHwip++PWYckKKBc0HSDuo6Q@mail.gmail.com>
Subject: Re: [PULL 00/19] virtio, vhost, acpi: features, fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 5 Oct 2019 at 22:58, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> A couple of tweaks to the bios table test weren't
> reviewed yet but as they are really helpful to
> the arm tests I'm pushing, and affecting only the
> test so fairly benign (dropped assert + a comment),
> I cut a corner and pushed them straight away.
> Will be easy to tweak with a patch on top or revert.
>
> The following changes since commit 4f59102571fce49af180cfc6d4cdd2b5df7bdb14:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-oct-01-2019' into staging (2019-10-01 16:21:42 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 9d59bed1da5e5815987879346cf708344060ea63:
>
>   virtio: add vhost-user-fs-pci device (2019-10-05 17:43:55 -0400)
>
> ----------------------------------------------------------------
> virtio, vhost, acpi: features, fixes, tests
>
> Tests for arm/virt ACPI tables.
> Virtio fs support (no migration).
> A vhost-user reconnect bugfix.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.
(I put in an entry for the Arm parts:
  * The virt board now supports memory hotplugging, when used with a
UEFI guest BIOS and ACPI.
)

thanks
-- PMM

