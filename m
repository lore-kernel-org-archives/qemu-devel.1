Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82EFC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704A520767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6l85Olp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704A520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7MJ-0005Mp-Fz
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD77g-0007O1-Vb
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:18:57 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:35983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD77f-0004x3-0Q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:18:56 -0400
Received: by mail-ej1-x62f.google.com with SMTP id e23so1920608eja.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HfmJ14nq1E+h5MjNapEskP2pqInyQFUNAulZpfgirY4=;
 b=n6l85OlpiLcFzVBA0jnn8uVrm6EWaU7W67Ok4MYTGwphZRbzb654/4pLYtqtE+nNIw
 iK99o94BP3lo/fE90ZGbgL9A4+i5gI0R6tTXXhsxFbQLHgKp6RVp3Lmb4fx0kWz/CVGL
 +pZzDHA87gmrMYy5J55M6KyhE3BNQNn1T/j5TWPoRMC4EKHaMSST+19ssZ7DCsxMfiOx
 ICI9WKfPqDzmWeLy6hHRGeaptMPPrU/8wgZ6LdhkFP0pAxqny3h6Q4eCAyIt5Kr/zvWV
 VgMeLCm8cBUWIRCswYTR8USRlOHQhzCImGBRKd3kjpgCj/ZMDE2dkXzxa1C4e2wPiOUZ
 d0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HfmJ14nq1E+h5MjNapEskP2pqInyQFUNAulZpfgirY4=;
 b=U/HB9rndleagn64H8Ru386NgvzcowgJ9fsNpiVrusP+6IuKxrzUhOHdj2ZnlSnjnAG
 Dx9wBHnLGk603d1fgGygBj4Rvf1zP9aQbHgVHpKAJxLaVpLONgVTUJXjwUEomrAXR7iM
 hSC8uvfeZkDymx30KdAT22vKLlxf8HUuJyGuGw2aAhU3JaZkq8TEffVTA7OVwnN3hRdm
 WZdAiRrtXFfhvE0+MkUcazWPJtepAnSIN0xvXVPQ8FDtz5OAnHGauN20PT7+YMJAx3FK
 c+zx4klhiQre7oPptzdJJMQw6n22cPTIhkFDS97FdfCyQ4RxkzxXmDbxELoIJRGkAl83
 xL9Q==
X-Gm-Message-State: AOAM530jeOCJ+/V15feNgIF677Ny2pZw+HG4/wKYsYPr1aTtbHnAS/B/
 HtGIg+Xmp6CMIa7wC68Fgp3eNCzAyqxhnf1HUsTu5sOW0V1RkUHy
X-Google-Smtp-Source: ABdhPJy3RrACytt27AqE1rmSXWpzVJ1mFQ3ylSAG9GOBGPZxqSFZks7agfBG75zLQUS3OEiDW/HTc/tbB+7pSfFrNw4=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr1655592ejr.482.1598969932985; 
 Tue, 01 Sep 2020 07:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200901095924.21738-1-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20200901095924.21738-1-kbastian@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 15:18:40 +0100
Message-ID: <CAFEAcA-ikpjOz4rfbhqG=RisDAiLD9GcuQfdzAvg-+Pc09jXoQ@mail.gmail.com>
Subject: Re: [PULL 0/1] tricore queue
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Tue, 1 Sep 2020 at 10:59, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20200901
>
> for you to fetch changes up to 2c15af48abb71b3cddadd63c5bb416b250f53fef:
>
>   tricore: added triboard with tc27x_soc (2020-09-01 11:54:11 +0200)
>
> ----------------------------------------------------------------
> Add the Infineon Aurix D-Step board
>
> ----------------------------------------------------------------
> Andreas Konopik (1):
>       tricore: added triboard with tc27x_soc

This fails "make check" (all platforms):

OSX fails like this:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_IMG=./qemu-img
G_TEST_DBUS_DAEMON=/Users/pm215/src/qemu-for-merges/tests/dbus-vmstate-daemon.sh
QTEST_QEMU_BINARY=./qemu-system-tricore
tests/qtest/device-introspect-test --tap -k
PASS 1 qtest-tricore: device-introspect-test /tricore/device/introspect/list
PASS 2 qtest-tricore: device-introspect-test
/tricore/device/introspect/list-fields
PASS 3 qtest-tricore: device-introspect-test /tricore/device/introspect/none
PASS 4 qtest-tricore: device-introspect-test /tricore/device/introspect/abstract
PASS 5 qtest-tricore: device-introspect-test
/tricore/device/introspect/abstract-interfaces
RAMBlock "CPU0.DSPR" already registered, abort!
Broken pipe
../../tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from
signal 6 (Abort trap: 6)
ERROR qtest-tricore: device-introspect-test - too few tests run
(expected 6, got 5)
make: *** [Makefile.mtest:1429: check-qtest] Error 1

others like this:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_IMG=./qemu-img
G_TEST_DBUS_DAEMON=/home/pm/qemu/tests/dbus-vmstate-daemon.sh
QTEST_QEMU_BINARY=./qemu-system-tricore
tests/qtest/device-introspect-test --tap -k
PASS 1 qtest-tricore: device-introspect-test /tricore/device/introspect/list
PASS 2 qtest-tricore: device-introspect-test
/tricore/device/introspect/list-fields
PASS 3 qtest-tricore: device-introspect-test /tricore/device/introspect/none
PASS 4 qtest-tricore: device-introspect-test /tricore/device/introspect/abstract
PASS 5 qtest-tricore: device-introspect-test
/tricore/device/introspect/abstract-interfaces
Broken pipe
../../tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from
signal 11 (Segmentation fault)
Aborted
ERROR qtest-tricore: device-introspect-test - too few tests run
(expected 6, got 5)

thanks
-- PMM

