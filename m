Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24952C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2ED206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JvelaOwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2ED206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCLK-0003xV-3D
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgCKX-00036r-Ro
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:12:09 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgCKW-000229-Pc
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:12:09 -0400
Received: by mail-oi1-x242.google.com with SMTP id b8so2372689oic.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7OHcp8h7Z6ZzhagFhbtwh2wTcuEnlLY56sb30y87t84=;
 b=JvelaOwhjcB7uSciSr9xm/2E3fzcLNbcQh0nTruuIQ6EZPJ9yVQsYEKHtb9BSS2gwb
 jEnXgG64leFuTMR5AHB6abwaCs4ucngi5mWOxPiPYkzORWfyVaU9I95AJv/PJzmDhqlR
 ka1ZwnBIJ4vPbm5O3nLBKw36RVNzB8YhXjmShVJmmAllPAIsLWvXNl2GQKGrX+A/iohl
 aOdZoT53BU/LMR8LLnv4IH8PLs7H6uEV20aWqLyyCpmiK47tb/FsVnO00uafC9YbeLsV
 crAQova4NcfGGWI8t5yc/ooclQQwuWNt2epPSv2b5QRFS5zNhfbP2OSyXoHp+bQ1sEg4
 ywMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7OHcp8h7Z6ZzhagFhbtwh2wTcuEnlLY56sb30y87t84=;
 b=UQZbm2mqfDGawun3wNdWBqj5r18vr0TTp14V6kogaybR7eeppvmTMcZu55MndXijSG
 9/nMeiB/weFAbbbHMKUoiueyCEavwTrsBZoMkCbqku/YcwsOKma7xkKD+pUwGQUqMxlG
 WI7fmiUbJVP0bU0flfxt4eA1NI6/+IeEfTSUcw2ejdvW4fMLrP4cdDln1vrn9D2z3dRb
 XH2D+aDO8TTWcDqi7m1rN9nxDBSj/ZARib7cR8DWT3GVcbRRrRukWPtUy1Age3gMWBtP
 5LjvK1JZ+M/1zu+tUqeiyi66szKmMSwJbBpXBKNw4hyrgHWlhD49DvaTK/T/aCx5RQC/
 24ng==
X-Gm-Message-State: AOAM533PM419P/OMMpgVaHQyW8uRN7rO5IPwgcIqsaYeKKrixfDSDQJL
 /U2XbjqHoP6LmXapfm7X100bZCrK0yNSt8FCwBRuBg==
X-Google-Smtp-Source: ABdhPJwgA/0BmX/mo/gq+77HeNrma/uPThqGWLwAcvymR63F2OcUmYzV0yoGvY4V3fvel/QPW22XwdSs0zRx7AsZ9FI=
X-Received: by 2002:a54:469a:: with SMTP id k26mr3956717oic.163.1591125127459; 
 Tue, 02 Jun 2020 12:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-6-richard.henderson@linaro.org>
In-Reply-To: <20200518164052.18689-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 20:11:56 +0100
Message-ID: <CAFEAcA9hdb5uXV7bAS644LWyv27gk0E5DNTApAGfLgNw-Bh2Dw@mail.gmail.com>
Subject: Re: [PATCH 5/8] decodetree: Allow group covering the entire insn space
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Mon, 18 May 2020 at 17:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is an edge case for sure, but the logic that disallowed
> this case was faulty.  Further, a few fixes scattered about
> can allow this to work.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> --


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

