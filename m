Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD67C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4032230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKhJPGk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4032230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNbF-0003n5-4h
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNZp-0001sy-U5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNZo-0007sQ-IT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:51:13 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:32872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXNZo-0007rd-DN
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:51:12 -0500
Received: by mail-oi1-x244.google.com with SMTP id m193so22099396oig.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aal/ea6Sj9JcKtUdRuLSDnLxR0Gv/3zrPtNSuuc1hG0=;
 b=FKhJPGk5E7XI+A0j2tWIauXRiitLVMqxGCcz8X1UzDfHXfpM3quXBtlsKWaMxe5HTz
 PBDkcrPwpci26gCYA1VJJmkFiPsaDGzps5Um6yqiHulOKFBbbKUoG/recepJkZ6StTb1
 q0icwuGQDaU5sRHJXDIEhYLRe0u+0Brco1ME6kf8wGJHM1a4H5+g2h7rtkdSJwzQGDlj
 aY/9rZOScLGBY9taDJpuiy2peNXmayy2s68ex3ZPvUkptZwKlHb3XyysyNkfo/OTkbC+
 eb6U1lF3FY88iSay6iT8uD/ZHe/5w4ZcFYC/DxjaIUqSpA6hHR66JNUiUYTH9Jtn7hpP
 83Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aal/ea6Sj9JcKtUdRuLSDnLxR0Gv/3zrPtNSuuc1hG0=;
 b=CS4a59VjBAo/lrIwtnDWgeg+ZrDYC8IHmsdAmJqiweIT/EZFhJkc2sHAsVmGf3kloZ
 wMEisLB1qQifi9tGjcpxERtRTQ5oQGic7fpduuFqU8SRcYfh0nkFgDyovX25p6ZugogJ
 7iwtQtTNMRY/yNR8dM+5hYjJU349G5kh2qWKhKTtTJQ9+Ydiw3uftOUSJVYIO7M4MgZy
 Bf1JFMg7Q8hU0N8nREBn+AtHbnxQqgXStLQF056rsavEeaJ2zzdJS2nKa6k3QFn6qCeL
 3iM2RftESmbPfZkIzGLwUnTJbTnc82seR1PT/YtMheQc8ipigKOqw7p5MSlA3IZVJJgj
 1tnw==
X-Gm-Message-State: APjAAAWVxHjlp1prAagrhWJrjsPh23+GVAYFSMSm7KhZ+sB20Gc2f82P
 LEY6VzvcMBWFRZwfOMKlgsajSMv/NVJIRzQZwvrEZQ==
X-Google-Smtp-Source: APXvYqxQ0LOnPnMOlPNRo2pORqJlVhyrdeK+DIEjZdbmxM0JJtafzsA//rQk25cAUOV3ji1nmZOCI02JKdJKQyflC0w=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr2135547oig.48.1574247071497; 
 Wed, 20 Nov 2019 02:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-2-thuth@redhat.com>
In-Reply-To: <20191120091014.16883-2-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2019 10:51:00 +0000
Message-ID: <CAFEAcA_OpH_4rzpVN=v-HNadQm_Mh6yGBReKP4C_wic1ETq6kw@mail.gmail.com>
Subject: Re: [PATCH for-5.0 1/4] hw/arm/nseries: Replace the bluetooth chardev
 with a "null" chardev
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Libvirt <libvir-list@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 09:10, Thomas Huth <thuth@redhat.com> wrote:
>
> We are going to remove the bitrotten bluetooth backend, so we can
> not use it in the n800 and n810 machines anymore. Replace the chardev
> here with a "null" chardev and stop including the "hw/bt.h" header.
>
> I am not aware of a full working N8x0 environment that can be used to
> test these machines, but the Linux kernel from the Meego project that
> can be found on http://stskeeps.subnetmask.net/meego-n8x0/ still seems
> to boot as far as it did before.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

