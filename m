Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF9C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB292419B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGto292y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB292419B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVXfk-0001ek-Ln
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 06:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVXf5-000188-Ql
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 06:17:35 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:46232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVXf2-00059Y-Aa
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 06:17:35 -0400
Received: by mail-ed1-x544.google.com with SMTP id 33so1173861edq.13
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 03:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QFzLAVFg71xZHtSAhr5mU3I4yr1lHCqIqwegSIR+/hk=;
 b=JGto292y6CONsksTla2UU+VEPc0yCVPSh90VoPmL3P5LTtz/QxWGxFWlOMas6sKtIk
 CpdULVVrPcFlHWznOOTlAVTw0Zcv8Ezyy0cw0PDjy5Z30SqGSDVrlGFZ0zoGbKiR1+hL
 7PhjdMb65qg34gewnBh/0YTSBNvUrhB/gCKXQWbZQ+p2O12czyBryffiG3UH2YfB1Nss
 Y/JXTz6trwN0nkDgqWdMpg2Hgt6u4xY6v1V8DkXXV5pESSI3RQa2+srV45GGcPJCrzCi
 S9k4qge6E3qKWy07bf4E6Q4UUHCJwvdsS+iOOx4ju5jsySDvkOrNhSEyOoBwUVXI/jmV
 GUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QFzLAVFg71xZHtSAhr5mU3I4yr1lHCqIqwegSIR+/hk=;
 b=NJcGPHGSsga75ZnYU08mfoHYP7TuW9zlAhW9CZpkTWgB/5NTnirIjEH1m8bnXL8Tg6
 R7a/+K1pTurZql2CdTtb94ybpVJlTrlneSxH85xVucPZjXjttlPv0vzwHvpJ6WbePsWp
 sC+1Ro3XgvJcyJwqJgNNPHiuDNcmyrHpgtTk0Dm97CdbUJJLqbPrHxEqjtMyiyBFEC/P
 Zpj+AVhTxOhX3kEXPfjvVGIbDh69JvnQDpsZxtkAKniMrZ4ThXzGoc/hqLgmgsahq+NN
 K3SEJ5hpHk/vurldgmnaE0UY38YIPCPQdS3isucOLHAGEd2IW1H5ifcLFnJ5TlZjGJ0l
 ea6Q==
X-Gm-Message-State: AOAM5313fA3UggE6QSqCMhEd1fwkEl8qWKVlCL5bwt8Apytxq0JZnxxV
 1Nvd7xo1Mv1u3/3EwpJPCQl99OUnrchjwiFkXU6AsA==
X-Google-Smtp-Source: ABdhPJzpLJa/XcRMMJrEdoy/3P57hQ7+oHuL6i3OFVz5sAvgZCE7yHlGkEpHNS9HFEUw9f8QCfQEoYrghrPZlwmL+Xg=
X-Received: by 2002:a05:6402:4c6:: with SMTP id
 n6mr262427edw.204.1603361850220; 
 Thu, 22 Oct 2020 03:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <1603352576-21671-1-git-send-email-mihai.carabas@oracle.com>
In-Reply-To: <1603352576-21671-1-git-send-email-mihai.carabas@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2020 11:17:19 +0100
Message-ID: <CAFEAcA9n3T5MrBp2RbOQGWBptV5ObCssF00ygK8TDieP+V1Srg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add support for pvpanic mmio device
To: Mihai Carabas <mihai.carabas@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Oct 2020 at 09:25, Mihai Carabas <mihai.carabas@oracle.com> wrote:
> The patchset was assembled from chuncks from some old patches from 2018 [1]
> which were left unmerged and some additions from me. Surprisingly their Linux
> kernel counterpart were merged (so the pvpanic driver from the kernel supports
> mmio).
>
> I have seen the discussions about moving the pvpanic to PCI [1]. Those patches
> were sent but nothing happened. Also they are not trivial and require major
> modifications at the driver level also. Given the fact that we already have
> mmio driver support for pvpanic in the Linux kernel, I have sent these patches
> to ask again the maintainers if this can be merged.

I'm afraid the answer is still the same. You need to provide
a convincing argument for why this needs to be an MMIO
device rather than a PCI device. I really don't want to
add MMIO devices to the virt board if I can avoid it,
because they're all extra code and potential extra
security boundary attack surface. PCI devices are guest
probeable and user-pluggable so they're almost always
nicer to use than MMIO.

thanks
-- PMM

