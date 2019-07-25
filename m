Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3134C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1C221852
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3UZGhJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1C221852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZoc-0004Dr-RF
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33096)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqZoS-0003pS-7s
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqZoR-0000e2-81
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:13:24 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqZoR-0000dW-2D
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:13:23 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so50945775oth.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xsb586Ud5tcmlp49yCb/9Z036nOcFfEwPx/jnyoZ/24=;
 b=v3UZGhJfjo5fSgbzwRLHnFPdLZAPhUkQU2vpihtDcxiUzcGVl8Ene2WkaYP8p63qat
 uFG22jvSSrtY3+D9lAGESLyAoyCdb0HrIMD3sa0edPEFyeTvqhz0zVVZumq1B2OW+EeX
 yrOO714Ria1Wo+nRxZDWnLTFU6o6UTpNfEH7kJssXVTAyvbYVmvr88xW6UqFXmQICeCF
 gul75qx1u5sqQhP5dx07lFI+4zAbESea8TlZcymXZEOOFU6EC9NHVAKhZ5rg39KB1iKi
 VmKxRd4rWuOhaxcz0TAP1N2CWhrWUykQ59lnf/UR5mCgQz0ehdO9X2Bt8OiGN3ucTBZj
 pg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xsb586Ud5tcmlp49yCb/9Z036nOcFfEwPx/jnyoZ/24=;
 b=FYnkXgnOkpNya2zsv+I4oF3MqeJMcjDEHHWlx5ZlGu/Gurarzk5C94RLLfKVVBZGfx
 +oI+P4bsHJ2ZN13PRQBKvfbFHa5ttsq7DUsEV3CWIOK8NNVY2ZOYVDvW/yxjCdCtx95p
 zLoy1+1WBHv97tzbYI2rbHCYfuIzUuOKX1+XAnwR0jhTtro0Fp5xg1m6fcG7cRxmkjpm
 0GFtR74rKhxyM3ZwdyaHKD4+3ZBMVHe5HOpXAY8181iRlchm/ICaP8VgVTLhqf10Eybm
 rtCbyYdbt3vdaCaRxfimBdhBd2eUWw4HHgFgQDmzhX0rU9wEhFnOrjpP4DgA2W+4uxdt
 hyLw==
X-Gm-Message-State: APjAAAVdDSTeHwQBtEQi4d3x7IO5w6N0LeVEbI2X0Hk/UuSQUQBof5ls
 +EAXq1B4X+LpdO4y3oV9UtCbTOP2FiQFtgUiLINUUw==
X-Google-Smtp-Source: APXvYqz70h9TMJMMbUiMZIHoicW8aQxn3+WbU1IikFaGMGWqQw/V/scrlApw2M+cQPcDiCbDB8zMkcaRnrKu6C2S8CM=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr5946892oti.91.1564046002422; 
 Thu, 25 Jul 2019 02:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190723154856.17348-1-berrange@redhat.com>
In-Reply-To: <20190723154856.17348-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 10:13:11 +0100
Message-ID: <CAFEAcA-jz2Dsso1cBxEhCu7kq++T1vH--Q_AuBTYzxQxttDNCw@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for 4.2 0/3] require newer glib2 to enable
 autofree'ing of stack variables exiting scope
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

On Tue, 23 Jul 2019 at 16:49, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Both GCC and CLang support a C extension attribute((cleanup)) which
> allows you to define a function that is invoked when a stack variable
> exits scope. This typically used to free the memory allocated to it,
> though you're not restricted to this. For example it could be used to
> unlock a mutex.

Does Coverity handle this? Can it be made to wire up this kind
of deallocation into checks of use-after-free/memory leaks/etc?

thanks
- PMM

