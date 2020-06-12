Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C87C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 22:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFF3206DC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 22:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbWIFIHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFF3206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjrkt-0006w8-7T
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 18:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjrkE-0006VO-HQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 18:01:51 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44722)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjrk8-0002P6-PQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 18:01:49 -0400
Received: by mail-oi1-x243.google.com with SMTP id x202so10098614oix.11
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PmXbcWuFJtMPmChUXvokUqiIjpTxVqioY94tjVySeHk=;
 b=SbWIFIHR8/2YKdbyZYV3wF3G+Iqy+37ZkSjkOfkJwYS6ypVzcSEUP6DbJw1uXK6MbB
 9/sDQ0VHBtsJRwr0P7fBSZUuU923yIt8h3gQK9fZOk8Ip9zdMWugnVuQN7tj85YI4bZa
 ofo3zNytMNoFVU+7VFv4N7290OpYhnz0jnDfquNSDhhDPYrlEItien5S/M6ILDtqFpG7
 Z8Okd6ZygaN93xR/jsRy1JvGrh9xVQRKe/3S2e0HuxlC7c3Ej/pinQVqLR0TmkvVKvOx
 UOV2u87dg4xddREjyTVdSQx8dIH7mxFMytCPYPh+h+QQ/iHBDARNDAamLPPjfWHJHcbC
 2Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PmXbcWuFJtMPmChUXvokUqiIjpTxVqioY94tjVySeHk=;
 b=RvNibciMV7qs26rYsIH66oz5SJEEroRAHXrLedkQg51/Rbrbuxv0rxDT6Cnp7PNkYY
 8Xdb49Jwe/b/GSxUM/+ZZiObh9/GmOYNaIuXDpbMF3pRoJKmBc9ehHUQ5HwViIZq8awr
 sXInl8+eCyNK63MEc+LHMmz8fRd5rZthu8LuVv/3t3jEQLprswuEQXwCBjOB4Pa7U3kH
 yMN++fQNONWDuKqFixa+QznP3wv3apw+TdW7uiV4+HcFlzJeIzgpWRBZZlqE7U52jz9D
 aEjpixhqfnKzXF8krptVnyEkOhw2jDBgP3DBCfoShVzuXBGPalRyTvgzGXu8Tft/jpJT
 Tx8Q==
X-Gm-Message-State: AOAM533sfGUKDFeH36Dy/LMsEYzO4wz0b8k74lXJ3cDhILRAagOxgxtR
 KD1FUSXzpS+e9/KtFYaSTt1WghGlu05bI3oKPvszgw==
X-Google-Smtp-Source: ABdhPJzNMpbStE7o3+9Da5G1REQkKxYAS+bG9IjgRK1SFDPme9MwBn8PHVKcqJVShlBXU3Jo6SPXV6BsgwYDbhgzyY8=
X-Received: by 2002:aca:568c:: with SMTP id k134mr772362oib.48.1591999296864; 
 Fri, 12 Jun 2020 15:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200612141917.9446-1-mst@redhat.com>
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jun 2020 23:01:25 +0100
Message-ID: <CAFEAcA8Pz56wKQeVFBTY7jE2G-fHG1kPmE49SSNqPCET0qZ_Ww@mail.gmail.com>
Subject: Re: [PULL v2 00/58] virtio, acpi, pci: features, fixes, cleanups,
 tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Fri, 12 Jun 2020 at 15:51, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> changes from v1:
> - printf format fixed for 32 bit hosts
> - a couple of bugfixes added
>
> The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-06-08 11:04:57 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 10d35e581901c09ee3817ac7cddd296d05291a9d:
>
>   virtio-pci: fix queue_enable write (2020-06-12 10:17:06 -0400)
>
> ----------------------------------------------------------------
> virtio,acpi,pci: features, fixes, cleanups, tests
>
> Max slots negotiation for vhost-user.
> Free page reporting for balloon.
> Partial TPM2 ACPI support for ARM.
> Support for NVDIMMs having their own proximity domains.
> New vhost-user-vsock device.
>
> Fixes, cleanups in ACPI, PCI, virtio.
> New tests for TPM ACPI.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

