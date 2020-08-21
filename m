Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A67C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A0D20656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0Hay3ob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A0D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99sg-00043O-2y
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k99rV-0002Tq-7R
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:25:53 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:38584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k99rS-0006LE-Aa
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:25:52 -0400
Received: by mail-ed1-x52e.google.com with SMTP id b2so1935770edw.5
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xAXLD9Q3otui5Bl43GWm+lD03Ind6e56MO+R8sX/WIg=;
 b=Z0Hay3obaNe2n5x2h+NUFpp6Sx+OQhlKfWnTEEL9DF0b7ErEeLcI7CSRCRcj5i0cXH
 zJCNj4ZejCrHoXniXIOTLpX2Y+I8QFj7iSC8IGL9cAD21NFS2TI6taDEmpjdXoH+BDIF
 WIp2IH6yzhMv9hoZbIYb5mjc+0bYFTmz4xUvRBGt7cx8jwjSM2lU04HfYB6xLR3QUoOr
 w4KP/nusjpFi9TApeGmcG4L4pnzIhig+hDXN9k6N79mc7FYdmNi/eeGDrtB3HlNjolHV
 f4buG4tjCeoem3KAbjz2uocQIQNjW67JylSTGh2aWSl7hAu+SuRjDam0WVlXHIMaHDxE
 4HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xAXLD9Q3otui5Bl43GWm+lD03Ind6e56MO+R8sX/WIg=;
 b=IrvEeJtpKBmCEveVXGzEN6wLKKP2dhHznsf6wW3O0ZEsRzJsA1QF3q+eUXTLBI2EWc
 8/w9aRorUsMTPg5LVYzbJz0Z6gO4Q1nU+xGM/OZ7giksMRAkbnQALgJ2rM5WxJhPOD3i
 LI0dQE8nliN2pjnF/dIKsa8VtlQBxGfIeQtpWC6egLm6eQxesBia0zh2LW9I4sh/dfjw
 zHL/8wOa3MToE3O538QKuSI3IJ+ObDW218heZkrGwv5K9SqkZndwcZNJ0pv0croZSG6t
 mIXvUoEl4UfoKRauK523Z7HmBlOlJG/exkz3w67+Z76cJTfeCSdG8kJMyt5CfxUiZS7N
 9LeA==
X-Gm-Message-State: AOAM530j2wMamRIV8vXfeT3ss0gc1sOtJ6K25XBek/Rf05pmT/7vIWa3
 XhIW8klVyxk8Bi7RsSKd86fDhAgGHJse0pXzTXOAGQ==
X-Google-Smtp-Source: ABdhPJxziEIIeu1aKpdsinXfXOJEK5gsVEydsQ5beNQnSYKspa7CvOr4xpYvT3D932+w+h5V1XSC3aLHckak5gJPKtQ=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr3732018edy.52.1598027148668;
 Fri, 21 Aug 2020 09:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200813052257.226142-1-stefanha@redhat.com>
In-Reply-To: <20200813052257.226142-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 17:25:37 +0100
Message-ID: <CAFEAcA-OMwaMbrp60Gd3URMykAxOxd0+_SogW13VCRCnhn6JHw@mail.gmail.com>
Subject: Re: [PULL 0/9] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Aug 2020 at 08:44, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to bd6c9e56aba2e1b9a307642c72375386afbcf1f2:
>
>   trace-events: Fix attribution of trace points to source (2020-08-12 20:28:5=
> 4 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> macOS dtrace support and cleanups.

Hi; this conflicts with the meson buildsystem merge, I'm
afraid -- can you rebase and resend, please?

thanks
-- PMM

