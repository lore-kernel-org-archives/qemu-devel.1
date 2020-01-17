Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272E6C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62842083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwblN3/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62842083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isT32-0003O7-Vk
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isT2A-0002Wk-5A
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isT28-00068b-Fw
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:55:37 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isT28-000687-A7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:55:36 -0500
Received: by mail-oi1-x243.google.com with SMTP id q81so7572793oig.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YOWjZxws9cnr72+v57Rq52a3Iu8zw6hNtft9KidqYME=;
 b=hwblN3/x/uIeySr2mHNdzndBx0F0BqNIxWUbOwxmnPSGdv/igid4c3FfzYETwnVi4N
 ZwyYqJbgMru+Y2RQm5a7qAGnyHo/EDgC5vdXYZNPwVMy6xbN8QIPyy8QpI8NwGHkKyBK
 LrbsZGPUJYbsZ7pFe8Thlyyxx/SMFPLTjOoOOjD+60iORTMqdnqYfTnrt/87FCb29go/
 6vYSk1OGGayGyTWwZ6r/JST2tLgo4OleosOP8u8cuOe65vX7wgwL/8IWZZtzDmFnWPGd
 yKA6wfHaBpmV6FgHFSk7CceZo5OkqhK/Y/KnMYy7U1l7Reize8t5kCq3V8+XlQzeUE7c
 qEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YOWjZxws9cnr72+v57Rq52a3Iu8zw6hNtft9KidqYME=;
 b=Xw1yrJdwoLlUx+CbtVL3mP5ZnW1/HDLa0FHvTGRQ6NQnZiEa+7HBiAOBq7gS7870na
 4Hq9YajA0we90Clk7aNN/uGjK6gHJKf813la1yrpTOnWtD8Ru8CtUBGeqWGBFFyHMk/n
 BX+jTxnbg+smrirwkKTLr01KjkZxP1B6nW8WVhrEvxSQFZdSHXT6dVmXeIarmxXrLU+o
 naSfqLvsbYn5nkmPN8mP6iycgffKLJ1tWK5AVfKGCnO1uiDYFGcGwu/N5GxRnXF+B6j4
 qs7/WrLzcGMYPW3+wI/g+X1WhVcRq+UogTVg35PJB/PKi+yIVBrt6nx1MkBXKfPPA+wy
 to1w==
X-Gm-Message-State: APjAAAW1h97WN5hyNB09fd0vY6eTDNmp8FwcjAE3Q48EX7+9YuLMxvz9
 by8UGsjn+fuAEV+K/bZ3FvSPgdpbQ1mxEO2ECjGOGg==
X-Google-Smtp-Source: APXvYqzCtGRyJrqcdiKTxbW3Qegw7oHxlmvi/uzwgHhI/cyzjxdTeNu/WjEhV/IG+dPwjLcqAEm43dBes9FtZ7M1iPc=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr3733470oig.163.1579272935461; 
 Fri, 17 Jan 2020 06:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20200117005440.3524-1-richard.henderson@linaro.org>
In-Reply-To: <20200117005440.3524-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 14:55:24 +0000
Message-ID: <CAFEAcA8p8Gxs=qAh6D1T7x2ZPrDr1ZAZAx=SW73Wb=aHBTsdPw@mail.gmail.com>
Subject: Re: [PULL 0/1] target/openrisc patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 17 Jan 2020 at 00:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 28b58f19d269633b3d14b6aebf1e92b3cd3ab56e:
>
>   ui/gtk: Get display refresh rate with GDK version 3.22 or later (2020-01-16 14:03:45 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-or1k-20200116
>
> for you to fetch changes up to 97a254b3f03a184136e381c6d9fd80475e1795ac:
>
>   target/openrisc: Fix FPCSR mask to allow setting DZF (2020-01-16 14:50:43 -1000)
>
> ----------------------------------------------------------------
> Fix FPSCR masking
>
> ----------------------------------------------------------------
> Stafford Horne (1):
>       target/openrisc: Fix FPCSR mask to allow setting DZF
>
>  target/openrisc/fpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

