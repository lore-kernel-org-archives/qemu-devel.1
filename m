Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F3FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 18:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32F921974
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 18:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ej8zkajr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32F921974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHtDy-0000lq-Pl
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 14:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHtD2-00008J-4k
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 14:28:12 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHtCz-0006QN-Hp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 14:28:11 -0400
Received: by mail-ej1-x644.google.com with SMTP id p9so1348353ejf.6
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f6Psm0CDFeARB8GYOyl7OtHDWFku27SZ8wxbEK/WAg4=;
 b=Ej8zkajrtpMKLOUFn+ZZ8AW6nuw1SpCkIclVQvEBG7DjGC3Xi6tZCj9h+QaoFVH9i+
 X+vSo5ZGj3g4isZFhzO2iYRxzuQZrhQu1NWn27Im57dVrr1Uz/1VClAEzTADlJPQZVU0
 nEHq5/yHNTVDCPtdWa/qasnZXJkJm8rwQJmnuht6Ed1zIYWKEeXU0qH1wR49pFt/ZR0d
 llG0j7SiN3SnDuyAywUBL+lqH424b4ioATqZGiykeD2mbQnw16fYdFvpGwEXjoxzdP97
 9VaQJ/eHSr0txqdXFNc3G/zeNbMj9WNvvnP5t42aEcFXsGwHgXNKtsPla8ZlUdoHHFfB
 P4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f6Psm0CDFeARB8GYOyl7OtHDWFku27SZ8wxbEK/WAg4=;
 b=dYTc/DCidKOa70B2b+eZy+gPHtd4/ACvBeP5D/pLavSNyTIczrw4vYAwF636k81TVj
 MIr+QsbVkw9w44gYPOJZpkztBCaIKT0QYnzwCLzhB1Ziw0dQq/YyF5xYfL4V0FsJslO3
 aQxgapQvtOkaNx3kgbZ+m15aitR7GRIkemMgwF84IdeGSA8bnoF+fOASgdpeZjR6FU/K
 XqQ3PN0G7MbDYfAeVTcO9LLeQMqRbOBzX7r171iXxdM33GgYi96G2KN33bo4IThvoRup
 TPCveuDCoRbJxkH1dJ8yreIHBQS2/PyDg6DkGGJIUzd7+Vld4fnAhszXGdtA0gl+fZVN
 5JfA==
X-Gm-Message-State: AOAM531BJVDtb9KKsLqAutfbR1EKKvp01rnNWPnwoKuyTLw32wGurLTk
 KvM+Gp4gOn/YrAAc9o849Qh8H+T12+IvLRK2Nkfxxw==
X-Google-Smtp-Source: ABdhPJwKPu27gOsrROcUXkxVQAS37xEX2CFaxh7URLw0tyLsekydc6Vbv9Qm7/seIEscxNIr6ijxymGy8HNU/uvXHWs=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr15631408ejb.85.1600108087468; 
 Mon, 14 Sep 2020 11:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200909101642.17698-1-stefanha@redhat.com>
In-Reply-To: <20200909101642.17698-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 19:27:56 +0100
Message-ID: <CAFEAcA_OSc3eGfakXW33RbBf+4VppvpdainquwQLY_8Yz9N3PA@mail.gmail.com>
Subject: Re: [PATCH 0/3] gitmodules: add qboot, meson, and vbootrom mirrors
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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

On Wed, 9 Sep 2020 at 11:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> This patch series adds qemu.org mirrors for qboot, meson, and vbootrom.
>
> vbootrom is not yet used by qemu.git/master so you may wish to hold off on
> applying the final patch.

The Nuvoton board model that uses the vbootrom submodule is
now in git master (with the initial not-yet-qemu.git submodule URL).

thanks
-- PMM

