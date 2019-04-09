Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20270C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0962084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9GHlwGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0962084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46283 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtow-0001J5-5D
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:42:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDtnk-0000aP-RX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDtnj-0007Ox-Gk
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:40:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDtnj-0007OP-4k
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:40:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id c16so16187210otn.4
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=qQqr++AOy+120H9HH8kxlyPTR8+nwK5yeB6Z7PI2KIY=;
	b=W9GHlwGfWfxwArJoLtzicQ+mMG7NDSy2Lv8yQA2w3e2JUusKSRs/KJiRcfhFOKxaCF
	v6DlIdXGDPeIYWwBWxdrSSaylrvqvCQQHMpsQk0w2JsboViEgG7guTVpIwJkc+fX+LVC
	PbM4XCYvbieprJMgJo7jcEaKWd6fDx5ySyl9YGkHCuEE0oIaP+TMKqAt7n6bdwLQubn8
	HQWIiTVbVytQlxxqn5S4YQU4PG2lhSNp2e3j7jwVEO3P1ZD9k/eEd9OKwYBmc+3qcCnk
	q8zu0CrFWetydVXDNsL1Rd+2VtCGnGOLA52oSzPIZGuLjcgj76OMEMCgHTZq2GL78NA/
	8sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=qQqr++AOy+120H9HH8kxlyPTR8+nwK5yeB6Z7PI2KIY=;
	b=kh9aEqHbHSg5JpghKg3gOtMYLlT6q6/4aqoC8zvsdJlaalxTQFzjBgngS6446yhe3g
	I0XVqPf++E5RZVru3cJHUYqJewn9Uvi7sNmQn/33FHjWdPKA7X4Nbs1PJsDfFdDrPOTo
	VQgK4gqhspKFc0NwjM5WHq40lrfgOuqO/EJBWhyp3EZ/Tfg2FnBiNFt/QIGMHJ7mM61J
	LBFbrhaHn7bpLfSW1NaXYLe92WdGPhv911VUQ+2MzJn7zO1hLarqjhn8Wb/zo9cZKHWQ
	mY63T7/fB9kgNXufjuX4ftCN8omcF3kquDLxrrze4oyg/r2FUzuE9uXVFistOkMtDqoK
	MxYg==
X-Gm-Message-State: APjAAAUazMKVHCJhNaWJOAjYBRuNiY7gpWreKB22+yiz1717lxJx/AI1
	//sugsJS0LNmc7MR+Wqq2wqqeAtHveMeQCrIAYJ+7A==
X-Google-Smtp-Source: APXvYqy86AKcb6Rcka4mGmd3b17IGnIx2uuakfcXs0uGNW4DKjsXl2DUEtSaBj371VCKO9MpSZR46OY+k+Zdqt8eb5o=
X-Received: by 2002:a05:6830:1497:: with SMTP id
	s23mr21067618otq.236.1554828045825; 
	Tue, 09 Apr 2019 09:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
In-Reply-To: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 17:40:34 +0100
Message-ID:
 <CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409164034.BKiajpApau8hXaB04H3Mt8lrbvNrdWSY5wrU-gYcGb8@z>

On Tue, 9 Apr 2019 at 16:58, Aruna Jayasena <aruna.15@cse.mrt.ac.lk> wrote:
>
> Removed unwanted includes from cpu-common.h
> This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
>
> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
>
> ---
>  include/exec/cpu-common.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index cef8b88a2a..a3594f3f50 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -7,8 +7,6 @@
>  #include "exec/hwaddr.h"
>  #endif
>
> -#include "qemu/bswap.h"
> -#include "qemu/queue.h"
>  #include "qemu/fprintf-fn.h"
>

I was surprised that no .c files are implicitly relying
on these includes, but apparently none are, so we can
safely remove them.

A couple of notes:
 * this doesn't need to go to qemu-stable as it's just a
   code cleanup
 * did something go wrong with your sending of this patch?
   Its subject is "PATCH 0/4" which would usually indicate
   a cover letter for a four-patch series, but this seems
   to be a stand-alone patch.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

