Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E1AC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 20:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2804520753
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 20:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vg1u5aOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2804520753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFl5z-0005tp-99
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 16:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFl52-0004tU-6C
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 16:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFl50-0006wU-Oy
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 16:50:51 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:38965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFl50-0006vP-Er
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 16:50:50 -0400
Received: by mail-oi1-x22d.google.com with SMTP id d63so10527129oig.6
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=sWnqZE9uT1vmDyBo8aw3hK2K4I8vlaQG0yYSU/ctzGQ=;
 b=Vg1u5aOhg9pwwd8DJYO/f3vjLVkobxjKGkX7cqDMesHwDC9MKDeW4BsFu2wYAYVMGt
 CldCQQdZxZcc75y59FusrVn2VP1nCWCcIkHg9QkLInf530p2lSG7LwI+PB3lRgyJbEMR
 DvWe70HaFArhq9NmzU68rU5w1vkNUPUEmhcDfCHjbRCR0LiG+6gUKSLClDYyxC72VKWY
 lsi0k6gOQJKcCvahQfiw2oxYYH5SWYUxP1wEk2rDnPXiuNLSnGPZJSY63a1yAnnbnsVI
 30Kdud7PFMSLrPUz0lajNSLC/eleL14p+8299CxYbzZX6HOlZ/JY35kLEE554mYlMpsu
 ECug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=sWnqZE9uT1vmDyBo8aw3hK2K4I8vlaQG0yYSU/ctzGQ=;
 b=q5yenIKQoCMFXl4BpiIK4l4+4J3tL1j5/pXX1tCu4RftYjJFJyW6CudjvCXcayFUej
 peLsSULyLWq076QfskV2x98HPb8WMAbfLFnayDwdpZdloPoUbCk3rp5xSly7hqZEvsif
 +Lw1C6RkDfAbINCayixHgkjuLMCmdDiadZ1opOPwAOi6VQpgl+StmHth2bEeU7vi+U10
 MKl0WDVPUK5gXlzfM9pPSXvKTyjJgJkQdtC8v79r1WNxDB/cPBeiJAW9l1Ram8yf+C9g
 YFfnN0CD+UEz28Hf5xRZqwgxz4chVZrIj36amAQfgiId/dMf2XxrhfF17WyOgfQocWaS
 VIiw==
X-Gm-Message-State: ANhLgQ1rpGI1kcZWWCebolM+gyCxroQRn9uXvgq1eDe0T0qvHwQI4IzL
 n0CCB4Y3HlfAPmnc0J7yWMJi+VDYWpNKym7YJUkSnla5Dija0g==
X-Google-Smtp-Source: ADFU+vtFXPQp2K51GoZT/6fZAdmXJKN52LwOG0Fy0xUq3LK8d0KTiCMMKFcZYYUIo+2T8wK1oGAKkCkUjgLWY8xLFoM=
X-Received: by 2002:aca:c608:: with SMTP id w8mr11951680oif.163.1584823845564; 
 Sat, 21 Mar 2020 13:50:45 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Mar 2020 20:50:34 +0000
Message-ID: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
Subject: deprecation of in-tree builds
To: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

AIUI from Paolo, the intention is to deprecate and eventually
stop supporting "in-tree" builds, so that the only option is
building in a separate build directory. I thought we should
probably mention that in the 5.0 changelog, so I wrote up some
text:

https://wiki.qemu.org/ChangeLog/5.0#Build_Information

Suggestions for changes/comments etc welcome.

(One thing we will need to fix before we can do separate build
tree is the Coverity Scan build process, which (a) does an
in-tree build (b) can't be easily switched to a builddir because
all the source paths get baked into the scan results and moving
to a builddir changes them all...)

We could also make configure actively warn if used in
the source tree.

thanks
-- PMM

