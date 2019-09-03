Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C03C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA69121881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jn9Mk32t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA69121881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i54MX-0005hK-Jt
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i54Lf-0005Dg-RO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i54Le-0004zH-Ih
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:39:35 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:38922)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i54Le-0004y4-Do
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:39:34 -0400
Received: by mail-oi1-x234.google.com with SMTP id w144so5167380oia.6
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E/7T7rtCU+2sx7uKDZjDoAcD95MZLYf9/DK4RRW0rPU=;
 b=jn9Mk32toN8zLJlkd/VfgbhjhGDv7MaQvQ5N2zrZZYLpzZciQPZsPNhVpqnBauhAlC
 /VMZ2O3ZrVm0S9iuJ8EZd/7U86qE+URm+pK4njP6UUEf9WkA8lZ6YbPtK0rE+k7FSFsA
 UjCor3xuoEl60AvDzvCBci15AJkUnGxM+PAzu3Ia7qSeAt68tw3/UHAjp3Ye5IFnad/2
 NYtXlqFxpWbzZEFtobZc2P8m/oJ7OAr1cNcaZ0AhEOxxc4jrvQepPGSnF5Hypw2Hv75v
 VXVoDSbd66Pvq12rzw0xRIQXb0IRPb1pCNmpDckTbNU3WmmuWrANwU45ZDP2lJjZeZRZ
 D5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E/7T7rtCU+2sx7uKDZjDoAcD95MZLYf9/DK4RRW0rPU=;
 b=tRvM3LLAQ0F7/FeBOcLdFhw4WGTqRPgTv87nTfpJPpPxaCNyCSb4/TYhWRUXhjSzYe
 C7gKgbZx5x8xJhOsjnugqXJ+V0XmUL2UU0E+BbsE++vExXfdZnxfqy1hymtpDjUTSE+P
 oKyNWHXDEboNNHXDbClSyUXWPxUuunDJ8XHEAtWtJGNfjt3sZoaTbiUEJEbb7masFtDV
 xWgs4kcXw1zfhQdQeIP0wgS8juGVIPHBetAxSkKZ5yv/+q15lY2yix0nJnYjkK/Lj+lQ
 yZwIo/ShKOtXqEi1IkukkwWU66RVLobwmyLJmzX60GIKkaJ73HaHywD7TRNhlo6291zA
 mutg==
X-Gm-Message-State: APjAAAWCo0YteZCd1H+QqP7hUquaKpL9BCgw76xUDVUwyM8K8EyEcL2g
 CnAKYxL0aYGFIrsMonk2nk+XLUTjxy+QkAZ+2/jUYA==
X-Google-Smtp-Source: APXvYqy8ccE9GGB94QgMc4FF68CYPjuvYIFU8qhmhiwchp5e4av0P394PFNmXTJX886KXZrYGAlc0P+G4MRpye2S7z8=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr13536096oih.170.1567499973438; 
 Tue, 03 Sep 2019 01:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190827182313.25983-1-mreitz@redhat.com>
In-Reply-To: <20190827182313.25983-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 09:39:22 +0100
Message-ID: <CAFEAcA-bt1GYfjUh0aRE6gwni1bzu8WJzNhbpQxrdc47ZYQkCg@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PULL 00/15] Block patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 19:23, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595f024f4:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190827' into staging (2019-08-27 15:52:36 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-08-27
>
> for you to fetch changes up to bb043c056cffcc2f3ce88bfdaf2e76e455c09e2c:
>
>   iotests: Unify cache mode quoting (2019-08-27 19:48:44 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - qemu-io now accepts a file to read a write pattern from
> - Ensure that raw files have their first block allocated so we can probe
>   the O_DIRECT alignment if necessary
> - Various fixes

Fails make check running the iotests (on some platforms,
including x86-64 Linux):

Not run: 220
Failures: 071 099 120 184 186
Failed 5 of 105 tests
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:1100:
recipe for target 'check-tests/check-block.sh' failed

The printed diff output for the failures generally looks like:
--- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/071.out
 2018-12-19 15:31:00.523062228 +0000
+++ /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/071.out.bad
     2019-09-03 09:01:43.665180692 +0100
@@ -1,4 +1,5 @@
 QA output created by 071
+Unable to init server: Could not connect: Connection refused

thanks
-- PMM

