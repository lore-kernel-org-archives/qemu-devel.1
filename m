Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE0C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6A320656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBANjA8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6A320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8F5-00075g-Ml
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:30:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8EJ-0006fc-G4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8EH-0000i7-Ky
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:30:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:32813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8EF-0000ey-VY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:30:04 -0400
Received: by mail-oi1-x241.google.com with SMTP id l1so6777706oib.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=e0xZv97x378DQZI179inVJSToMc+t8NyvyXNI/V9gpQ=;
	b=cBANjA8K/V4dhv8LOyeBeT31pYcrJP0y6a1bllAvYiNMco2SZR+KXWEjBuaQhUaS75
	f+YcF5uljPDZuo/fNfkhD7i5SqmWXrqz3gVu6vB5jnjprGrnPW2c6/o9A9fgZOOjipm1
	BseOf67FlwafsMmPQ9JBZ3uALqplt0+tT6Yu8Sx5jU6qfwXXyb54Cw4fdwu6XqltXbGm
	2GPJsasHME3JQ/PC7QQGfgU7GYoIIQ7bW5Rzcea5E8fwMPPosiqhGa+lp7GU5zoNfVpS
	PZ3vs3zUP1sSwUqlpTyMRFbKeHl6KlEVaPvv70SuXyoa0/0SXyydnTDfJButDw4dfaSU
	WZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=e0xZv97x378DQZI179inVJSToMc+t8NyvyXNI/V9gpQ=;
	b=SVr6xyY5IOIliGXKXP5R13ay5zl9b2rBBmfh3UQoTZOkZnspqZEnjAFDEK8GbBJa+H
	zsdgx5PM2fzYptMmcqB7mlkfV/kYi/HTvRIaKmsXG79zwQm2nCArhm5wnOxCEzC+Xc7d
	p0ehr7aQ8JHSVB9HRZTNuV97L6oaJmHLPC5ArH2cAdU4xdZ+Z0MzsFIw+IUGVoYTuUPB
	gPKIJtGwnzkS/xQ3Ai32Td9VHGVZ9XcovpHLc6uSOZ+HmuY5QWjGgEBtsdoKqyEcjyzD
	FyBckQPIbo0K+1filbkSIrYVtagOFrVUfOJKC6ma4Rpkm/1b4wuYHL0/FJca99LtvWGb
	9itw==
X-Gm-Message-State: APjAAAXyXDvng+7ymb9HTCGUI4flCNAsa2TAVfFvCrf3HtDLqwFCKH0L
	pB42Em95fGwlKlIfuirO/sX6i31AaLDTKGkd8ZUILw==
X-Google-Smtp-Source: APXvYqyYPea7sRHGKo4a16elbDg5VcBySnMaNeK4YbGBG2tXztZ+ALqQdeo6i1bKAQId3l7mi61c6RG+VJvvwCr+XzQ=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr17176035oif.98.1556551801438;
	Mon, 29 Apr 2019 08:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-29-richard.henderson@linaro.org>
	<CAFEAcA8=Tq4txdRkv2x04ZaaHBUnc1DCvvXOwdjOZj4JiQNVgw@mail.gmail.com>
	<84ca26c6-fe25-092c-2c18-5d5ecbcbd481@linaro.org>
In-Reply-To: <84ca26c6-fe25-092c-2c18-5d5ecbcbd481@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:29:50 +0100
Message-ID:
 <CAFEAcA88Rg+QEdwJ+32SWAAUzZ+_hq85ECZiO4uELN30+=XZMQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 28/36] target/xtensa: Use
 env_cpu, env_archcpu
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429152950.yJ3k9jewOFCYuuIELIA23Xx2-zP_21pX6ou1q3rO1Os@z>

On Mon, 29 Apr 2019 at 16:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/29/19 7:36 AM, Peter Maydell wrote:
> > On Thu, 28 Mar 2019 at 23:38, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >> @@ -712,10 +707,15 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
> >>  #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
> >>  #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
> >>
> >> +typedef CPUXtensaState CPUArchState;
> >> +typedef XtensaCPU ArchCPU;
> >> +
> >> +#include "exec/cpu-all.h"
> >
> > Shouldn't this bit be in an earlier patch ?
>
> The diff is just funny here.
>
> As with cris, it's really moving the following function below
> exec/cpu-all.h, so that env_archcpu is defined.

Oh, I see. With a note in the commit message about the
function definition moving

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

