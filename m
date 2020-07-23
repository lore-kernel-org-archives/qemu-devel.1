Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E34C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F39520737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vg6yhYod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F39520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfZ7-0003Mf-R0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 14:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyfWR-0001X8-RT
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:00:47 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyfWO-0006I3-7G
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 14:00:47 -0400
Received: by mail-oi1-x242.google.com with SMTP id 12so5792287oir.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C5Qeeh3Xrr9lSXusSjeaWTqvUpzCVgdQM8wgfZFQdTc=;
 b=Vg6yhYodMnFkqJHqbkQhUkq22OpfNP4CzcUbAp7FNw0qfqjEf/b7fEgfh8wpdNw1BJ
 pFRZOzx74PIw3rAkJagujnoHkEE6J6Lb9VRw/q7b3Hy5lW8caGWsX7u4UkMdTJMP1X4B
 /SqczUdSM9zRqXSy46iTJxFWR8XrxxcL7Ydqcjz7QLfMBDypqoA/ROlhX22Yp37XpSMS
 qsGVtJQLXZJmzsf7Exc2t81JhyFERO/3odJoKo+khOwxUtWno2KrGo+iOLsOFGRqxhF/
 y1LKQ50LA9hOFw5R6eOmiZfMfzH8BFmV+O96/Z9G9/MjbKMMWfXxDhTl4wq9DOUBhwiW
 TnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C5Qeeh3Xrr9lSXusSjeaWTqvUpzCVgdQM8wgfZFQdTc=;
 b=a2OfpVKdSFsJK7CWA8WWdSpMdQ2w9xPrVvDHSe+AztvA4FTyOktA9RdRs4XbstESOr
 SGcZXnGbhu++nD0DmeIZDpZgc4jUD/9m+0HUx55HMnWMTSbho5Vmb47MIW8J35qQFvzx
 661hGlbEWNxb0zpbhEurr3MGhQsoPDyMa3QQxAhTfIBC+s5LxLQWXjN9D4Q8+TUQ92lE
 1b5w+XjpRIbNaYGL9g5khIWiGyOTM9q0qE7XNMLMeK7cjIFxShOrP7GJQv1AqvAAIOzL
 933QvJrr1XWWbWgFZPT29uwEZNmLTk4DYP5P09UK8LQPkfNQWyGrSHDTeS95XB4/S2eI
 VopA==
X-Gm-Message-State: AOAM531ME3uC69ICDLF6AR9r9QPyks5RRlSFfbwbe+YIFxiprhhES5Ut
 OmXsGMvBDyHIkPVe4UqLLPlrHrUU2fWpkFjMhO/mxA==
X-Google-Smtp-Source: ABdhPJxmdVp2Nt5nLtnainsF96fbOOQhLTM0HPD/ciM3ZpUM7qm5AWIZZPXJ2k4RUYO61yrDMe54Lelm0CdgAzA89S8=
X-Received: by 2002:aca:1706:: with SMTP id j6mr4708277oii.146.1595527240591; 
 Thu, 23 Jul 2020 11:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200722120853.9144-1-mst@redhat.com>
In-Reply-To: <20200722120853.9144-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2020 19:00:29 +0100
Message-ID: <CAFEAcA9nWHFO+5AvR3kUNxgYWy=Gf4mM94Uz3jfPXvM+dCw6RA@mail.gmail.com>
Subject: Re: [PULL 0/9] acpi,virtio,pc: bugfixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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

On Wed, 22 Jul 2020 at 13:09, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit c8004fe6bbfc0d9c2e7b942c418a85efb3ac4b00:
>
>   Update version for v5.1.0-rc1 release (2020-07-21 20:28:59 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to ccec7e9603f446fe75c6c563ba335c00cfda6a06:
>
>   virtio-pci: Changed vdev to proxy for VirtIO PCI BAR callbacks. (2020-07-22 08:05:37 -0400)
>
> ----------------------------------------------------------------
> acpi,virtio,pc: bugfixes
>
> Fix bug in ACPI which were tripping up guests.
> Fix a use-after-free with hotplug of virtio devices.
> Block ability to create legacy devices which shouldn't have been
> there in the first place.
> Fix migration error handling with balloon.
> Drop some dead code in virtio.
> vtd emulation fixup.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

