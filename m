Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D29F20674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlJfO5T6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D29F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic97R-0001Sn-Lo
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ic8sZ-0003GB-Cm
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ic8sR-000817-6h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:10:09 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ic8qN-0001Nj-O0
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 09:10:07 -0500
Received: by mail-oi1-x242.google.com with SMTP id k196so3381342oib.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 06:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/CnwmbUFWRsqWL2N14UyvLbg9Cdi2y+1OqJISDKJtjw=;
 b=BlJfO5T6fkfYo1fKkjLYeImj5Q96TDjDI6FnqyphfcPqiN4MNwsZ2tbxNd8rOfEHys
 FyVbL8XqQ4NXLyKFt1f9Rjl/BAJ3fUJrCXJnVZylGOzLOPMOM8q4YstgwXFcyR/Etx9w
 6HWNyJqkQB40DhSlxb/12LkgHuoY5H/hf+4I3ERP/pz+sTNEJli7I7rOdY/m5gB2ikyl
 Eb6SEfRBl1aqKDkbp77oZtLFtSnfpULHMx/WSIQOPaaEhRI+gYxvsT81SSkOuWJbGxRt
 edQFqqZejHYb8vuVOWg61B9mh1M+bzaphg1Sq6RBUFfg6cxdpLoIWOSO9zE60p3yuTVK
 hFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/CnwmbUFWRsqWL2N14UyvLbg9Cdi2y+1OqJISDKJtjw=;
 b=MK1yNwxjnlCJN8OQI5BT33WRaCK4t+KMJ10pj/Gh6J70/aC97FNML8z4HF+/If2R09
 ZekiP8X1t0Jx+92QFMAyNXmaOMdSr8bXSnQGXSxX1ul/b164e4019ypxBolUAvwzJBcc
 rUnNinhpq3PLt4iDmaH+3ZFOlXfkwHIVvGBX1OUimfXsCOBZRr25M3nab8FxmIdB9igT
 y1p0lUJ5kaa5R49jS79Yuvz5WoJozNr493scXh16NeVDY90cJtxbAwQ6RqTB8lJ0GSHA
 8UdExUzRSr4BGrVA2TKB7M2g8D9Glqs711n5FFEya30MbmLruqExEpXtEmK0na7Y68aL
 JK7w==
X-Gm-Message-State: APjAAAWkl+QtS1eVPcoHmN7O/tRPvGbAcH/nFos36npcJ9tzOtRzC+SM
 uutZIHn7oMO50aymozOe2v80ZItvCttH3sfgBaC0/Q==
X-Google-Smtp-Source: APXvYqwFJQnHO1LQABxtrSdrdrgcEOZsuOrGVnYMXS9ocaRVq8MJK+19WwpfY3vXFPZhRRveWvtJx/kYnnR54TXyX1c=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr3760486oih.98.1575382075765; 
 Tue, 03 Dec 2019 06:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-6-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2019 14:07:44 +0000
Message-ID: <CAFEAcA9ps2JZHi2nTUrog7rgRc5gL8QbqYhSgFCS_-ARe_0T1Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/22] target/arm: Suppress tag check for sp+offset
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> R0078 specifies that base register, or base register plus immediate
> offset, is unchecked when the base register is SP.

It looks like rule-numbers didn't make it into the final Arm ARM,
so I guess the reference here would just be to section D6.8.1 ?

Also, this phrasing is slightly ambiguous about whether the
"when base is SP" condition applies to both "base register"
and "base register + immediate", or just to the last of the two;
the correct reading is the latter of these (and the D6.8.1
Arm ARM text is in error; trust the pseudocode here).

We could perhaps say something like:

D6.8.1 specifies that accesses are tag-unchecked for loads and
stores (including exclusives, compare-and-swap, etc) whose addresses are:
 * base-register only, where the base register is SP
 * base-register plus immediate, where the base register is SP
   (not including reg+imm with writeback addressing forms)
and also that literal (pc-relative) loads are tag-unchecked.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Include writeback addresses as checked.

The load-literal case is implicitly tag-unchecked because
the address calculation doesn't go via clean_data_tbi(), right?

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

