Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5394FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6AA20885
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 14:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KnZDacPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6AA20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrio9-0003jN-Bt
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 10:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrinO-00038W-71
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 10:05:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrinM-0002YF-FA
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 10:05:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id 72so28549282otc.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sFUZCl0KMC9nTTAaIIN2Hx6Kvt8fNuST0u9ocgRC/YM=;
 b=KnZDacPnKuHkZ0PtuG/ipGtLvC7PPxTmZ63sA46EwoB9ADy2IQjCa+0P2dO/QZs/P9
 uSxFmxkePZ0PZ6/aKfdZ3S/iq2Z3M3++UJMEve2TDFUWJ3ovDl0+yeRceZvqhqPO34Ij
 dnpGL/5pUcTBJLQioIEik+inLjrasc+McXLwMI8RLNDxtHMm9oduruC2Fs9dNFII6jJX
 B5hgwX1jvB8RZgHjIgYbZun5Nbu3+4mboftkhjag2UUoDn9tS9CS0OWvdytK0HEkJNzk
 Vk5Or/e/2mZlcXdhNE8PMiHkN+KM2PRT9PwoZ8+/ErfGK29KofI/GK01mkJrz8rICNKL
 znuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sFUZCl0KMC9nTTAaIIN2Hx6Kvt8fNuST0u9ocgRC/YM=;
 b=ovoZ1zQ3VdVamNs0nz/o4oJa+VLXeVNf39LNEuWR0pNJsG4Ad0V+xkJtfZOTsAB7J9
 EQtC6gp5Gx6PbOgQw244cut009A/19FtvFjHPKvcMJoF90qY37zwk13v+dt7a2BcpfQ+
 OUN2xwXMhCaWBY1/ke4nSY/2J5bVXhl8UPUjCs8kPTd/X05zSMJFOtpE+s78f+Hogt5z
 JBOU6hfe0mJYjHFjzM/tav16EyFTqX+cC0C1jqUJn2hnkfPsLQaGXVbrnIjfQsHEPjU7
 50+XNf1PcAyzKxJ81qH+y60LB0JqmEJ3nlvGr7HUDCKPyr8bckIYwfor1WvEBsM6hvo+
 h1Jg==
X-Gm-Message-State: AOAM530uFOGN76Z+0wygDg6v+jZQMvaXWHePpOXO7Oo3oZNwDEaN8TZg
 3+vXqhEeFjCq3+BRpDZ721j6dj01iS+f7VL2pdYu9Uoyzj1WHw==
X-Google-Smtp-Source: ABdhPJz+LKVFzrxN0DQoBiY9+Dnue4JipesxRN5DHeH8bp1vuJGgsb4YyFQjGK58ESdCD9t2ec5GrrMklscMxkfXOQ0=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr27155945oto.135.1593871530841; 
 Sat, 04 Jul 2020 07:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200703090252.368694-1-mst@redhat.com>
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Jul 2020 15:05:19 +0100
Message-ID: <CAFEAcA8gW6yGD_g7LLR9BeuEehtSWb+x3iPvDg+zbVr77cn-pg@mail.gmail.com>
Subject: Re: [PULL 00/41] virtio,acpi: features, fixes, cleanups.
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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

On Fri, 3 Jul 2020 at 10:03, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>
>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 900ed7043750ae3cdf35c05da66e150a8821c3a0:
>
>   vhost-vdpa: introduce vhost-vdpa net client (2020-07-03 04:59:13 -0400)
>
> ----------------------------------------------------------------
> virtio,acpi: features, fixes, cleanups.
>
> vdpa support
> virtio-mem support
> a handy script for disassembling acpi tables
> misc fixes and cleanups
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Hi; this fails to build on OSX and the BSDs:

In file included from /home/qemu/qemu-test.TcQYno/src/hw/net/vhost_net.c:23:
/home/qemu/qemu-test.TcQYno/src/linux-headers/linux/vhost.h:14:10:
fatal error: 'linux/vhost_types.h' file not found
#include <linux/vhost_types.h>
         ^~~~~~~~~~~~~~~~~~~~~
1 error generated.

thanks
-- PMM

