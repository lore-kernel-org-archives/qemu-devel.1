Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DA1C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5286120652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAQOTBPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5286120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57869 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6fM-0003je-K3
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:49:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6cU-0001tN-Qd
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL6cT-0004lW-Tg
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:58 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL6cT-0004l9-OL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:46:57 -0400
Received: by mail-ot1-x335.google.com with SMTP id n15so2572383ota.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ETxdwI8xharwqIJbjovzf4Peli2sGivdGQ8wwz554Jg=;
	b=GAQOTBPLjUKb/pHkSwrKa0rCnS7X6smUdO29YQmEf7inxhTlOMA4Irbe7A2bw/FRHx
	rvNGoKz3OEnflXtDZC5V3lmp1ehp/6H8N0DrqHqozRV7+t1ZB06g7lepWkn2G3jf0ohf
	9nEW5uS5HwKUHd/f1Be8AmQQ23ZjskG5XWglUXyGMwoynMyENj2G7Q5FAPFwVWbcXk4F
	hNc9xd9iOVxawMIRg96yfUYeu0N6cis6HPx/y3vrm01sPbUsgeY4YEvkZS/ItTmHhM0N
	/dWI9ELEu1W3pJNiC+d9GT6iz67Uh/z82rgozP3qsguz2Zkof+YFaEQBYgvdnGMaCJR6
	yQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ETxdwI8xharwqIJbjovzf4Peli2sGivdGQ8wwz554Jg=;
	b=FlSxmeVBTZhrKsafSHhDd6SWgIo41RE0obmpglnCgQcLG0Lex5+PIqb78Rck7L4Hof
	fnW3bibtn+cxmm1I4nhcHzLlM3qbUXAYOjnkcuD2yLtewJiU/5wxGtMikuMVON4UMvID
	4uTP/QIVr9cZfTYrnqAnEYsWZhndKAj4Or/TDy+j9MOBugdNyhrMyaifPHLz2sIO9TJk
	HlZWamPmgmiSRvaPTvL4qGOT0y45Rotc4LHMi6XpkxQxQSBnIBNV8DR1HQvUcPka7Kz9
	h2CaiLOnRbc6YcKaEqphfVYoOOLRnJnsATwzUi0MPFZiZMEaZTJ/BhjbD6EwfaHewNaS
	wkAw==
X-Gm-Message-State: APjAAAVaatB96jGs4uCLtjZ3xOBpVOWizYO4X5P/lor8SbCJ1GF7m+4V
	fEF/VcCatoxezhUPiUtY9hW4afzAjZEni4ZzsYJv8mL3Id4=
X-Google-Smtp-Source: APXvYqwKr+j2uWnutw4UAmdlLxfaBWKhwp2Yj2h95vm01igJZ0nJ4L5rX19JfQY/nI0Ww9VOLbdNt7dA6lRGmvQs5dA=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr12100504otb.238.1556545616777;
	Mon, 29 Apr 2019 06:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-8-richard.henderson@linaro.org>
In-Reply-To: <20190328230404.12909-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 14:46:45 +0100
Message-ID:
 <CAFEAcA-wkLSXbONYQy33Lq6Tg+2FB=QX-BatCyzQFs+CrK9bzA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 07/36] cpu: Introduce env_archcpu
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
Message-ID: <20190429134645.4ALK1NIie4ehJ8fHGiiyc2Bfua7RsOWtrhjfCU_2Cu4@z>

On Thu, 28 Mar 2019 at 23:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This will foo_env_get_cpu with a generic definition.

This sentence no verb.

> No changes to the target specific code so far.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

