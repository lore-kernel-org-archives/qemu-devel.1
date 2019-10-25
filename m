Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC5BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074CC20663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGTfkeZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074CC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2Z5-0007e0-VE
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO2CL-0003qH-9R
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO2CJ-0005Ua-LJ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:12:20 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO2CJ-0005UD-Gp
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:12:19 -0400
Received: by mail-oi1-x230.google.com with SMTP id o205so1945414oib.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gXHKxg+CR5koGVWP1EQKxRo+QB+NP4/sHkue85G+Fog=;
 b=FGTfkeZG8oBvFyh5WKVsWOR72yTiNleMnxvFQf5LJO9gdCC3HnjnBsii7IHN7fm5yH
 C/2opX9PaSgbrI2lJsqi7APTZ9Zlgmkn+atho8oDgq2t6x36zBbypVNfbiOy8oTh4Z+8
 zyuwiuoq63ZxfgyBeVLcMMbNyxOY03ncg/mLITreXXkTp8+gqWJJbxKrukY5gfYJiLiE
 N/jZm4XzBtnEVlYu10nUEbR/pmmwjW2XZ1wqoCIaEjPNwxZYKIWsEZgn19A5g1clSgV5
 GzB54OszBFhDwB/PKFEALnw6coG71FowkD7Czu/C5xI7y9NAdyn7R9bWqQz6HCbKK+HJ
 IfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gXHKxg+CR5koGVWP1EQKxRo+QB+NP4/sHkue85G+Fog=;
 b=HeI5ehH+PGcdbGGcUxvogDWFhq16/OcK/ylESNw0AqKFTCy8lGphkiUMfgKFWl9BXI
 85e/MGNRwcCFZN4++p3On7Y6G8ZVRyZ7qoXN34CoPs5IXOZn8tbHeOsVLLyzF9L0TzOS
 Q5ktI7E2zUOi6/+q7CMs7qCkleFgVWg8cN34dEGTrNNkst3LsFCQA9zg2hnTu1U2nAsb
 45N0ZiEWhsPMrpqblLr+q+Zy3m9ax3UU9tcg3G3O3m5dSLlDfwu1AY3qU9d50Nm9bi2d
 i1nJbp4+jk4W/hj/iUQ+RWl1YN2dFZYqh6f9egjflIGaXnBfDNDrYVxugkyBQMBejUKB
 Buuw==
X-Gm-Message-State: APjAAAUNyPr1R4C59mx0DqHt8zKEfguUzKqsfdz8HsIdYAW19tsu7oFa
 uL07PL+tcR/yCH7khUQTCbTHm/WBi/87qI23o4SDYA==
X-Google-Smtp-Source: APXvYqzmHdg0h3J2ukg06oGV0fSQ7HLAUcYVM61FUKP0xdKE6KXfeGU7vwEqHHl/4oXCjryKZIdr3HcIgX4yDLTZF+I=
X-Received: by 2002:aca:2312:: with SMTP id e18mr2721371oie.98.1572019938621; 
 Fri, 25 Oct 2019 09:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191025142159.12459-1-richard.henderson@linaro.org>
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 17:12:07 +0100
Message-ID: <CAFEAcA_Wpn7uOs_GB5=ym+poSq=vVStp4EVPzaYoGGyEX90x2w@mail.gmail.com>
Subject: Re: [PULL 00/12] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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

On Fri, 25 Oct 2019 at 15:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit bad76ac319556dab2497429d473b49a237672e1c:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-10-25 14:17:08 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20191025
>
> for you to fetch changes up to 0ed1bfb046b740b70eed2cf3581e01768703b185:
>
>   translate-all: Remove tb_alloc (2019-10-25 10:15:25 -0400)
>
> ----------------------------------------------------------------
> Improvements for TARGET_PAGE_BITS_VARY
> Fix for TCI ld16u_i64.
> Fix for segv on icount execute from i/o memory.
> Two misc cleanups.
>
> ----------------------------------------------------------------

Compile failure, win32:

In file included from
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/lib/glib-2.0/include/glibconfig.h:9:0,
                 from
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gtypes.h:32,
                 from
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/galloca.h:32,
                 from
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib.h:30,
                 from /home/petmay01/qemu-for-merges/include/glib-compat.h:32,
                 from /home/petmay01/qemu-for-merges/include/qemu/osdep.h:140,
                 from /home/petmay01/qemu-for-merges/exec.c:20:
/home/petmay01/qemu-for-merges/include/exec/cpu-all.h: In function
'tlb_hit_page':
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gmacros.h:337:23:
error: expected expression befor
e 'do'
 #define G_STMT_START  do
                       ^
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/glib-2.0/glib/gtestutils.h:115:41:
note: in expansion of macro 'G_STMT_START'
 #define g_assert(expr)                  G_STMT_START { \
                                         ^
/home/petmay01/qemu-for-merges/include/qemu/osdep.h:152:20: note: in
expansion of macro 'g_assert'
 #define assert(x)  g_assert(x)
                    ^
/home/petmay01/qemu-for-merges/include/exec/cpu-all.h:225:29: note: in
expansion of macro 'assert'
 #  define TARGET_PAGE_MASK (assert(target_page.decided), target_page.mask)
                             ^
/home/petmay01/qemu-for-merges/include/exec/cpu-all.h:372:33: note: in
expansion of macro 'TARGET_PAGE_MASK'
     return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
                                 ^

(repeated in all the other places TARGET_PAGE_MASK is used;
similar for TARGET_PAGE_BITS.)

Also
/home/petmay01/qemu-for-merges/exec.c: In function 'iotlb_to_section':
/home/petmay01/qemu-for-merges/exec.c:2871:1: error: control reaches
end of non-void function [-Werror=return-type]
 }
 ^
/home/petmay01/qemu-for-merges/exec.c: In function 'qemu_target_page_size':
/home/petmay01/qemu-for-merges/exec.c:3791:1: error: control reaches
end of non-void function [-Werror=return-type]
 }
 ^
/home/petmay01/qemu-for-merges/exec.c: In function 'qemu_target_page_bits':
/home/petmay01/qemu-for-merges/exec.c:3796:1: error: control reaches
end of non-void function [-Werror=return-type]
 }
 ^
cc1: all warnings being treated as errors
/home/petmay01/qemu-for-merges/exec.c: In function 'last_ram_page':
/home/petmay01/qemu-for-merges/exec.c:1977:1: error: control reaches
end of non-void function [-Werror=return-type]
 }
 ^
/home/petmay01/qemu-for-merges/exec.c: In function 'iotlb_to_section':
/home/petmay01/qemu-for-merges/exec.c:2871:1: error: control reaches
end of non-void function [-Werror=return-type]
 }
 ^

Not sure if that's just follow-on errors from the earlier
ones, though.

thanks
-- PMM

