Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F06AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB260207DA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 08:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfy+0WuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB260207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHTq-0001nA-71
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 04:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrHSl-000165-4B
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:54:27 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:47015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrHSj-0002Ix-BR
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 04:54:26 -0400
Received: by mail-ot1-x330.google.com with SMTP id n24so23959222otr.13
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9ldSUPwq4HD9ooOU5ZVbWhBadRnDdx4mveJlDaVCIT0=;
 b=kfy+0WuLTeK0yLI4qI6H5qZrfSMFJWjkhKe0bQTjJOclxVBAja+wRBHDC5AlB+ibxr
 iqQUysceMxO5774VgvHe9Pd7qYvdASJpxiOsBpzFrJsaYOPYNrX8FIQNTIXmg3fpQbZn
 +m/rTcJsU4ZlujKDhXpsFx0b7ed2N6lF1C5oUx01lekzCQ+tCtb3r9DNhYlWNTs2YzH8
 BvCSsl4MfsNrodmfq7OHGkc8s5Bie+/A9GzQctX/PQepvvBabfobGvQbFz3kEIHZIAuD
 JGLuMHxxWrZXxMVukecRdcYbvkZ+If2vCsDxOUsMzkSN+KTKikA49Pr1TXJgpCAHVI+n
 Or+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9ldSUPwq4HD9ooOU5ZVbWhBadRnDdx4mveJlDaVCIT0=;
 b=JWKXMfMPQwm8XNkp5mgVGsrAK1tewW+6BAHAOBH9qXBO3qi+gUH2z+o0W6/upvEzH0
 jlsnXAfL5gT+pMAjRusxl5mD/WlpKgOImtTE/G+cRZUdC0p2rzs7V+0HZmWb8RofNRKp
 dyiTXfy3O8UcW6PxPH4aKq4UBxTweE/nd8kTOWhKWiCyAV8UiGBBD8Q8I0Il/aG/yCud
 rWb64wDU8jSdRnveZ/q+SsYHMPF16aU7KEE10xi6oWd7D77b6XRAgv2oJl6IBLCXP24N
 9Z/kewPJjrMDxz98Aqtwbr2vFOho9C3YxJtbc4qYbzEyVAjPmJpYGkmLID3mBzJHULOm
 gdSA==
X-Gm-Message-State: AOAM5303wMH144/JXHh8HjZ96k/xiO/2Kjc0T872tCesSEI9GsaZDyQd
 JUY27OYwzj+k0cHQY1oiLnp1rMbxuinp3oRRxhhGvw==
X-Google-Smtp-Source: ABdhPJwSAmQJxkTMLvifbJZ/DNIWamomJrKiGyxJO7PSnAxVUDihwG59114+ctQNBSQAhXHUX5aHphtKFIhUV0lbigU=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr23671725otk.221.1593766464012; 
 Fri, 03 Jul 2020 01:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200702122048.27798-1-kraxel@redhat.com>
In-Reply-To: <20200702122048.27798-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 09:54:13 +0100
Message-ID: <CAFEAcA9PVnKo8S7=bSggS2FpS5YoBexZD7nM54XFHto333_OhQ@mail.gmail.com>
Subject: Re: [PULL 00/10] Modules 20200702 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jul 2020 at 13:23, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>
>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/modules-20200702-pull-request
>
> for you to fetch changes up to 474a5d66036d18ee5ccaa88364660d05bf32127b:
>
>   chardev: enable modules, use for braille (2020-07-01 21:08:11 +0200)
>
> ----------------------------------------------------------------
> qom: add support for qom objects in modules.
> build some devices (qxl, virtio-gpu, ccid, usb-redir) as modules.
> build braille chardev as module.
>
> note: qemu doesn't rebuild objects on cflags changes (specifically
>       -fPIC being added when code is switched from builtin to module).
>       Workaround for resulting build errors: "make clean", rebuild.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (10):
>   module: qom module support
>   object: qom module support
>   qdev: device module support
>   build: fix device module builds
>   ccid: build smartcard as module
>   usb: build usb-redir as module
>   vga: build qxl as module
>   vga: build virtio-gpu only once
>   vga: build virtio-gpu as module
>   chardev: enable modules, use for braille

No code review at all? :-(   In particular the "build: fix device module
builds" commit (as you note in your commit message) does not look at
all right. I would much prefer if we could get some code review
for these changes before applying them.

thanks
-- PMM

