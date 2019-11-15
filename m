Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36283C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 11:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F028F206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 11:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0G9aFS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F028F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVZPE-0004kb-2V
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 06:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVZOF-0003g3-Mv
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVZOE-0000jy-FR
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:03:47 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:41330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVZOE-0000hr-8s
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:03:46 -0500
Received: by mail-ot1-x335.google.com with SMTP id 94so7660907oty.8
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 03:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a3Q5QeECsTFvgIOCUHuFamBYXcMg+6EPDwlvsSShbaU=;
 b=N0G9aFS9xc8jbLhGDjKsSU6mtjl43Kc8byZnoAOlPTqPAnMR6t5bCDsbObxfmRLspd
 C+YNhilLOuupT2JXMIxrelG8lXfyP6TZMXQFCWYBfp+vYCJRUpFTTOhGkT59SdNeo5JO
 7IcSEA8M9zXpiv6OUpK/5ZuaTqpI69X93MBLJ4PKYcxlvkgKCqVLWfrhWZM4hVJXcDPd
 EtXIRnNg7dF85vL7cJB/I6SQmrpf1H2OAJr2vvaNkSZZHUhd9GKpWSA8/pjr144KWdbY
 YhJHD0+zHrnuF5Mg1I0WlOFwBv6tkxA1nZxHbRIWmmYyBBRA66LcJF/ek/7hgOoO5D6Z
 Ithg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a3Q5QeECsTFvgIOCUHuFamBYXcMg+6EPDwlvsSShbaU=;
 b=EkTDesP6gaVuBXDHsZlH8GEar0iAEHpti/3RLALhn4W+Z3aWi+yqx0VjN7N8HRMdvZ
 QunG7W1BBIYTcNqr85cbJbWzx2KWyU9LTXWWWxvvXTw5hUmFgwyEvEk1s4GJ37lxEo2+
 Xinwf76sywrQ5YrU2aD9eM1kcWyON8ZBhKyjpgDkM2fGo/vv5QO47b24md8O8LpMiHQD
 ngtQiyH5/9fo0pB19/5gc7zujVGr0XAqG0tgQvJ/OOUM89YRA5X3nEdNhav/enA+wGja
 ZQssNvdEI/esVR+jTv2utj7F+npHKRfs2fViw5DW/8nPz+84uAGJjCiyeug8J8s6pKMi
 ZdZw==
X-Gm-Message-State: APjAAAWUr3bfK4P+3BJsKtT/GwX1vCSHHWCumb6INsMHLt8DVaz1m6ID
 +NcYr5+V/r0f2+9mGsptZxnUoN6NHbn7dVknuq/R5w==
X-Google-Smtp-Source: APXvYqzvqNKDSt59kQAzZeIUKNam3zDmmfe0TaPYmivw7H5nk/gB3U27eLInPfJ9MLsHHKIJzgRqJGsx0b8R3q1FJ8M=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr9891005otq.221.1573815825144; 
 Fri, 15 Nov 2019 03:03:45 -0800 (PST)
MIME-Version: 1.0
References: <CAB-99Lv3LySps4MOoKEj7Sp0CBouv-KgZp2osbiokSq_Gdfj5Q@mail.gmail.com>
In-Reply-To: <CAB-99Lv3LySps4MOoKEj7Sp0CBouv-KgZp2osbiokSq_Gdfj5Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2019 11:03:34 +0000
Message-ID: <CAFEAcA-RXurz2OB24i1wypumCDWf5s__mC33mFzBA3SCsm4_VA@mail.gmail.com>
Subject: Re: Invalid ARM instruction for clang-compiled Android code
To: Michael Goffioul <michael.goffioul@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 qemu-discuss <qemu-discuss@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 at 05:03, Michael Goffioul
<michael.goffioul@gmail.com> wrote:
> When running QEMU user mode on some code compiled by clang (dynamic linker from AOSP-10), the emulator chokes on this instruction:
>
>    9aa92:       e8c0 2277       strexd  r7, r2, r2, [r0]

I think that ought to be a valid insn...

> From debugging, I determined that op_strex() calls unallocated_encoding(), which I think leads to the SIGILL signal generated.
>
> I run the emulator without specifying the ARM cpu type, I think it then defaults to "any", which should support all instructions, if I'm not mistaken.
>
> Is this instruction really invalid? Or am I doing something wrong?

Which version of QEMU are you using? (Looking at the code I
suspect we still have this bug in master, but it's always
useful to specify what version you're using in a bug report.)

Richard, I think we're tripping over the check you added
in commit af2882289951e. Specifically:

+    /* We UNDEF for these UNPREDICTABLE cases.  */
+    if (a->rd == 15 || a->rn == 15 || a->rt == 15
+        || a->rd == a->rn || a->rd == a->rt
+        || (s->thumb && (a->rd == 13 || a->rt == 13))
+        || (mop == MO_64
+            && (a->rt2 == 15
+                || a->rd == a->rt2 || a->rt == a->rt2
+                || (s->thumb && a->rt2 == 13)))) {
+        unallocated_encoding(s);
+        return true;
+    }

in the mop == MO_64 subclause we check for
 a->rt == a->rt2
so we will UNDEF for rt == rt2, as in this example. But the
pseudocode in the spec doesn't say that rt == rt2 is
an UNPREDICTABLE case. (It is an UNDPREDICTABLE
case for LDREXD, but STREXD lets you write the same
register twice if you want to.) Or am I misreading this?

thanks
-- PMM

