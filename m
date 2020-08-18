Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F841C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7CD20786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rz43fvx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7CD20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83gt-0003kX-Cw
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k82WK-0000YM-8L
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:23:24 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:38923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k82WG-0000WB-SR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:23:23 -0400
Received: by mail-ed1-x52f.google.com with SMTP id c10so15398184edk.6
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BgkDkDVqteK9iA2RZ2fDhwQtX5EsnZF4D/rxYpoq7l4=;
 b=rz43fvx/U5Mmt9MpPGigXdMZ+V6UjHjAf6oAbc3hAUzFPXHF8z9uyF12ZFsg0Svv/e
 iWANE/ytGLw/TVsQ9QEazW+o/aZSjRdDVpyPkDAYVMESdMuHpc7A/Gyw+T9zF6/Yl5as
 Dcz/h+T+NdA4SBOuBx0qGVw7w3ifiBEnbW8hHzRH0NfIMq4nJn7VIqlUWzn7p5XB7B/m
 APTxhtcOw89Hpl2C03H4UKFrpVU0kxGJe7iibtDXwMT8H4ldpNCUVb1MXz0V8aWaNSSE
 e0KfHzZukj3kCadAHeO9NQd409rVnrtG4j1H189zveyYcdIq580eUnuLZ7cIDgK7WAl9
 BiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BgkDkDVqteK9iA2RZ2fDhwQtX5EsnZF4D/rxYpoq7l4=;
 b=ekS/3wnz9ObF4B1YicUyXRtIzKJ5wmDgzitPQ23maOrGNcXPWCZuT6+BJ6Gqyq5Uhp
 nvfeWNV7apTmb4QTAJemHS9neUdaGv0YFNazPWRKfX1K5ADca4A8mXGIm0L5sKBM6W8r
 M2Ztd1kWqDoO6m/DkGpabWU+8XvoX17suQQeyB5NB0bRzvPwi+R5YdQt7Q6Wb4v2bRs2
 zNw81nts7z2a/yTcQjqMSvcIbpMjLkrP0B5KLCSWVmW0IpUKbOtPG8db8vT46Q9fydRn
 4iJ6tnG79LqA/hLNAKM7a9NOC07QDQQDpMFNk6aB6rojCdwefXlbEIfJhfZobtJ4NI9u
 uE7w==
X-Gm-Message-State: AOAM5331sjyoOTtLWXKP6TSHW759O9+z5rpVRJzR6dzi6GhvmV6n8bnR
 aDaRwI8ELZS4NSkV4BbRnusYOdoSBaFaiIq3sQw5Qw==
X-Google-Smtp-Source: ABdhPJzN1VAwobRaVl7BuRrY1D4pkWmzpW3wLCBhykZoj4Txinhn/mo+RGR6U5eQrUtsis6qI69FX9SGJZtkXp8KayM=
X-Received: by 2002:a05:6402:17a4:: with SMTP id
 j4mr7716524edy.52.1597760599016; 
 Tue, 18 Aug 2020 07:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200818141025.21608-1-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2020 15:23:08 +0100
Message-ID: <CAFEAcA_ZzZcWzSj3v+KmWU3EpG3AUKjmTs=evjRfNvzGx=Ko1g@mail.gmail.com>
Subject: Re: [PULL 000/150] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 18 Aug 2020 at 15:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3aecbe785d65e3b92a3617c60e4d226362d9bdd5:
>
>   docs: convert build system documentation to rST (2020-08-18 10:02:43 -0400)
>
> New since v3:
> * C include files renamed from .inc to .c.inc
> * fixed pc-bios/s390-ccw clean targets
> * fixed error splat when doing "make" from unconfigured build directory
> * use --native-file to list tools chosen by configure
> * fixes for Windows (SDL, Wixl)
> * C++ compiler not mandatory anymore
> * remove useless .. search path for modules
>
> ----------------------------------------------------------------

Build failure, x86-64 Linux. It looks like this version can't
handle configure --cc='ccache gcc'. Full configure line;
'../../configure' '--cc=ccache gcc' '--enable-debug' '--python=python3'


make: *** Deleting file 'config-host.mak'
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/alldbg'
config-host.mak is out-of-date, running configure
cross containers  docker

NOTE: guest cross-compilers enabled: aarch64-linux-gnu-gcc
arm-linux-gnueabihf-gcc m68k-linux-gnu-gcc powerpc-linux-gnu-gcc
powerpc64-linux-gnu-gcc cc aarch64-linux-gnu-gcc
arm-linux-gnueabihf-gcc m68k-linux-gnu-gcc powerpc-linux-gnu-gcc
powerpc64-linux-gnu-gcc powerpc-linux-gnu-gcc
powerpc64le-linux-gnu-gcc cc
The Meson build system
Version: 0.55.0
Source dir: /home/petmay01/linaro/qemu-for-merges
Build dir: /home/petmay01/linaro/qemu-for-merges/build/alldbg
Build type: native build
Project name: qemu
Project version: 5.1.50

../../meson.build:1:0: ERROR: Unknown compiler(s): [['ccache gcc']]
The follow exceptions were encountered:
Running "ccache gcc --version" gave "[Errno 2] No such file or
directory: 'ccache gcc': 'ccache gcc'"

A full log can be found at
/home/petmay01/linaro/qemu-for-merges/build/alldbg/meson-logs/meson-log.txt

ERROR: meson setup failed

thanks
-- PMM

