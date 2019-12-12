Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E35DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2119206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnYEC7TK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2119206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTX0-00071v-US
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifTTw-0004qy-A4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifTTv-0005tR-B4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:46:36 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ifTTv-0005nd-3J
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 13:46:35 -0500
Received: by mail-pf1-x441.google.com with SMTP id h14so1238743pfe.10
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d3hN3crFgargNwf6dP5mibCcgUskG+IJPCcHFmzqCA8=;
 b=cnYEC7TKTa8nVhve5gqYBeVHgsRVe9bqxWfdqp/2Ut7qQMyF1Po8szjHIFvGq+Z+EN
 am30C7P4noVmdKIMYm9ko8oIqf0MZLP8vYQ8dgoQ/4SzUxad29zwYgKR+gJ3NEvPqeAr
 vSxnKlyQ6WSGKRvCLN6ZEGB0MpBSBgrahA43/2lTvRDUZAsjMq7j4PTwL+e2OBMeVdmx
 MpIjQPpjOD0Crpk/twRI2fFFi8eFzBryVkb/NqQS7VomNqSr7zIRff1OKHDQu1rN6FpJ
 o+hdfxIizFKnU3V8MV0ui/SPtiDfX1+7C/yPDR+Wiwctw2SRRb16wSpLXoQ85iuhD9ri
 Ytsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d3hN3crFgargNwf6dP5mibCcgUskG+IJPCcHFmzqCA8=;
 b=SE2kaDC6i4NUlzhHjg5c/JVf7GOeCST14xE5Q92ch2B0icv4fVukQIlyuHh7W9r7Sw
 ZyPLtdUaOUMKiNs1IAY68YA6aTH2Hmgaotir9WOviMIY80+oGhbySJzkG5Jaqk+QjZKu
 tcjqApjLmg/fNWacwg4Cb8RvvlP0zB1FVONkusgvFBTNYzV1oMUvoiMcd6lrHyKR2YNe
 S8k99jMxEIPpHOaHd1R2SX+5EdmLgWnmEHxmzepgZBN/HkwjG4kIMK39cOKTGPR7i5V4
 CrxTBkZQ9Xo8ayytSEqFblGat4XdFK3BpAlS/XmDJdiS9OrMK5ZXr4MKPU6Z32qw4tBz
 S4Aw==
X-Gm-Message-State: APjAAAXu0MfnnSA2fFk8L+R2JLot4dfmS80+tJ4wQtrWmTT1XuJdzxCY
 18ZSHNfnm8/TGjmBvsQKzau7+NJJrcA+DeV4/FM=
X-Google-Smtp-Source: APXvYqx3lh2v0DqCM82wmgHzrWLRbqh11S56/ubPNlGyPROcHazOjssL1WWP85gHJVNzmkMyyF3sxEzKw7xIwK6uBcE=
X-Received: by 2002:a63:5062:: with SMTP id q34mr12091412pgl.378.1576176390444; 
 Thu, 12 Dec 2019 10:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20191212040039.26546-1-richard.henderson@linaro.org>
 <20191212040039.26546-23-richard.henderson@linaro.org>
In-Reply-To: <20191212040039.26546-23-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 12 Dec 2019 10:46:18 -0800
Message-ID: <CAMo8BfKX=aqWOWrFx14Oy_UwSYnHqFPnFvNo9v-hVVXhhMPkog@mail.gmail.com>
Subject: Re: [PATCH 22/28] target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 8:01 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The functions generated by these macros are unused.
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/cpu.h | 4 ----
>  1 file changed, 4 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

