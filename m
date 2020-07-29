Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A06D20829
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2IfjTMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A06D20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ngC-0002Me-KN
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0nfS-0001vp-Tg
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:06:58 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:40117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0nfQ-0007yn-F6
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:06:54 -0400
Received: by mail-ot1-x329.google.com with SMTP id c25so17713100otf.7
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 08:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O3HAzAMUnypkxNQCaoz6nrCR30NpIJbnGP+nYlf82AA=;
 b=g2IfjTMQ1uOg/EoG/ylOfdTxoMSrc7QzWUIr1/91Y4ak4LtcrK7o/XJ7zl/lun7tmn
 G+h8o65hoLtjH4KRtd+JOUuXMR4H0ne7wn3JK2iO7PVMPzVaW8WOkYWwn04VhNn2snx7
 YQHU9Hmu+fuCQyK46rBxWdF0zlATPxX/9znzUCmLpLNR6hciQULikT3X4AsElqKhNBtS
 ME06KNbe91T14bBG5dpioHtHalEemcNop+dQ96+++l27uOnU5yb+hwiCDFhR6jrQCKux
 gnTH8n2yu0RqF8Si5fHFjJZ8P7RY6MVDP7LyKHQ6LfhtcVsuioWDhyEKNkSFBkjmysFT
 AFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O3HAzAMUnypkxNQCaoz6nrCR30NpIJbnGP+nYlf82AA=;
 b=VpnzjSTKW+Sg+5Jwx5K0lp5JleCWglXqluq885Pu85q4GDy725zNKh73DIAiq0anSp
 bGLu6DTR3aafnOlL1pmy22es7koie7SFg5P8e2q36OppHpFhdHktwYz6feMxUo9CcNY5
 BnMQCbPeyofUOnRAzGWzXc2i68TOgzKsm6ZTJK3FpVrI78aZ/odYTpaAT+xP2gOdQwAe
 KuJe3dYQYaaU01dnzc1aK+2ur3gySBGZrs1xO+feOJ3fgaR9z6hq002uUEwyXTzpumKP
 M2usGrKIMTOhKPTzx18LS7NXEjpHU6lR4b7LKHiTfE6XV9bxMHb0/1yUDdQLYB1KgndW
 3vmg==
X-Gm-Message-State: AOAM531HWte2loq8ldhuolocVMYAqPx7ohGFHjU8LXKAeOzsjfG3MYPn
 sfLlEQsmFyVw9g2j5SyN1bWp8im+ezoSXF/UDqWS+Q==
X-Google-Smtp-Source: ABdhPJxZDNQBYFbrQWErUXeVcpDSHezyybzBV4iOYTOkO0mJRiUCrv8QVy6RTLsPDb9OVc4EMykQw8ANhXWCTphq/6k=
X-Received: by 2002:a9d:3b61:: with SMTP id z88mr1806759otb.135.1596035210590; 
 Wed, 29 Jul 2020 08:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200728193550.3578-1-deller@gmx.de>
In-Reply-To: <20200728193550.3578-1-deller@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Jul 2020 16:06:39 +0100
Message-ID: <CAFEAcA9ON0UpPmLBhL4gRnH9eJf0Wz8H26sK_kQaau3-8ZA1-A@mail.gmail.com>
Subject: Re: [PULL 0/4] target-hppa fixes
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x329.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 20:35, Helge Deller <deller@gmx.de> wrote:
>
> Please pull to fix those two bugs in target-hppa:
>
> * Fix the SeaBIOS-hppa firmware build with gcc-10 on Debian
>
> * Fix the following runtime warning with artist framebuffer:
>   "write outside bounds: wants 1256x1023, max size 1280x1024"
>
> in addition the SeaBIOS-hppa firmware now includes a version check to prevent
> starting when it's incompatible to the emulated qemu hardware.

Hi. I'd rather not take a pull request from somebody who's
never submitted one before at rc2 with four patches none
of which have been reviewed, I'm afraid.

Richard, you're listed in MAINTAINERS for most of these
files, would you mind giving them a look over?

thanks
-- PMM

