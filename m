Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA8C433E6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 22:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B4120786
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 22:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wS94X7tF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B4120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBQ6M-0000tn-If
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 18:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBQ5X-0000Pl-KO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 18:09:43 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBQ5V-0004D0-Sj
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 18:09:43 -0400
Received: by mail-ej1-x641.google.com with SMTP id oz20so9744867ejb.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 15:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LrzJibJueYF5QfFD/h7mPNBBS2md/S6bwwJRBxWgZ9Y=;
 b=wS94X7tFBOL9bsrOIvuWwJuu6Xe6DzQZP5DuQeKoIihy19ai3SOdXeyoBc1FkbaVtb
 eqW86ERlXm81YotbwlpCS2QIjAFmAsJkcd4UyOlwfdb3tRWg3z/fjCRgx2VAxabiYRGJ
 6uFRlk8DOPgI6ZZwy3iTuKADVpv9z5yuRW5fj/yltQ0khOwFxtikPCNIq7c5fA9+Cehk
 ywQVDDkm0iK7xm9U4cBlqKzvPAYqPS1Hq0g4N8oSDGBchOI6onYAWiWIfpbbiVxvGD1q
 9Hq4nsuXw/N12CpP8qytkDobbcgddnj8itGuZSNkMm24nOM1QB0pKXYU89d5GrDIpjpM
 yRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LrzJibJueYF5QfFD/h7mPNBBS2md/S6bwwJRBxWgZ9Y=;
 b=iwt/LuASMcNP7DbwyT4YvSA264x16ko2+uYU8mnGMYUlE71G8KBa8RZoE2PinNRUDR
 V9LuxDtFee28R2HEIdTfGE4sWT9O1IEfZ4DWv8cg1NLeLKqhcDu++aVN8A1/USCCyqai
 b//5XSwvcQeya4aHOoeMaI+QQ3UHkXdVohLrH+ob7mzMYfrT91li9HDf6T5DMiRJjpgc
 jeyJCU56IbDd3R5qumb2JPPx3NVY7NtelS9nO516jS1BA0sJTKuj/ebss7iFdspvcjJE
 CGYre58bgk9F4Aat894w8f8UjwZnbpBVXjF/IkjbURnZbklLfuSSvpYF4qsOyn4duHoC
 C0Lw==
X-Gm-Message-State: AOAM532F+RGXyOHGJpTqPV6YOwZiIENObCtDZsNdw4z5kb2KTv0F1T4w
 yYBAH/PxsIRRtUplefJZVioqpC1V6RZm19jLJPyRfA==
X-Google-Smtp-Source: ABdhPJxheep/2EogTaBCJJB+OKYbOGVib6xRIrE5guI0OTl4SaeWqGsKQIIr9SNESPKtTWJ4JPQp5ATXa5xHAnKrfag=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr22450774ejb.407.1598566180175; 
 Thu, 27 Aug 2020 15:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200827133954.2118749-1-mst@redhat.com>
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 23:09:28 +0100
Message-ID: <CAFEAcA8_AOijcVPUcuVgtw7hPw2JXobxMG+6DMRmN9ABRP3P1A@mail.gmail.com>
Subject: Re: [PULL 00/13] virtio,pc,acpi: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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

On Thu, 27 Aug 2020 at 14:40, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 8e49197ca5e76fdb8928833b2649ef13fc5aab2f:
>
>   Merge remote-tracking branch 'remotes/hdeller/tags/target-hppa-v3-pull-request' into staging (2020-08-26 22:23:53 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to e1647539b1d04f121b70f1f6f438976477450f10:
>
>   tests/bios-tables-test: add smbios cpu speed test (2020-08-27 08:29:13 -0400)
>
> ----------------------------------------------------------------
> virtio,pc,acpi: features, fixes
>
> better number of queues for vhost
> smbios speed options
> acpi fixes
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

