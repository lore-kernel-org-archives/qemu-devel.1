Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6CFC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 01:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825672171F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 01:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJ9SMmyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825672171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33732 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCDlU-000080-MR
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 21:35:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCDkf-0008Fv-9R
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCDke-0002d0-Ac
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:34:41 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hCDke-0002Zf-2W
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 21:34:40 -0400
Received: by mail-oi1-x244.google.com with SMTP id v84so3586455oif.4
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 18:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=R7LhU1mUZhzaAg1dgTFUmoo1SX8T+A7gYbFE93tsQug=;
	b=KJ9SMmyo0e5RzjwKjGiM+I6MeR71f5Y5BgtJZ3msRv/4dXEyj3hKEK1ZiDtJ+sbJXz
	HhnLmgThBNvcrq8Pbe0pPysSfqxeSep4P8EyKofUW2bLrf89e1qS54J1zY40irc5eztT
	PAfzY+S53mg0gEfhDol5ufKV4k4GM7a7dNk/Eu0AioETzZpSqxWJ7snEUX7tc0WQIwrl
	ycWkNhNbpBSvOkGgPbmh9x1COLBALzChCSkQrSC0NVeDbkmlFzeToqGEcnSWrYOWEbCK
	wDKHIK3hswxy/o+qDquSEBTgvcPn3qk2oTYdHpx0YYio+QFJ3pfM/+zsTDV8uObTCfA8
	TKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=R7LhU1mUZhzaAg1dgTFUmoo1SX8T+A7gYbFE93tsQug=;
	b=qYpBQ6slBb1Hhs+owrc5EPEd2DvEFkxZiHrUHnwAA6WJ3YyX7+SeSbygCajcAG80Ng
	pYpMgWT+TxbEmCRl+OcfLsNLhYNIdF+WajylH9sVCW3fCo/QPObguFC5kXsP7Gy772J+
	6pInmeveeTDrqWM6pU3fIIWSw91B/UWikux7+FQijdgKSbusF94TETKqsIrhNbrRDCaU
	ApP8ar31G6WQ7GgSMvKSrrWe9X1AN2QBZi0m+LosSlUWF92B8cOtcZ3hOs9DpS7tZETh
	Wt0FKieUgqHBc1dWWb/83xsvKkJn/ERC9n2DCSq35vaKqsW7ZyqFWU5Rc1iiO/hUupjp
	lBig==
X-Gm-Message-State: APjAAAVvat5cKOORSEBNQ92hrKMx6etF8JaY5qNkUzT4MgKT0TuxvdSL
	aRhwYzBLTurdeV2iSmybH1PpCgOO9kKxwUb1C5pwEw==
X-Google-Smtp-Source: APXvYqx3ET4q6jlkmufyHt4C38Qgi3+2qvHgweVrwu8SK/PE8KNOEHdXQnj5qwedkS19wVoTitSSJq4zLhK68hLf7u4=
X-Received: by 2002:aca:4c88:: with SMTP id z130mr5565753oia.170.1554428077941;
	Thu, 04 Apr 2019 18:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190404185730.GA22512@ls3530.dellerweb.de>
In-Reply-To: <20190404185730.GA22512@ls3530.dellerweb.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2019 08:34:26 +0700
Message-ID:
 <CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
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
Message-ID: <20190405013426.eW_LXEYM-fhFyoEXeBJXwah6_2dumSjOUN-ZTtoSlaU@z>

On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
> If a non-release architecture is found, and it's known that there is no
> native TCG support for that CPU, automatically fall back to the TCI
> implementation instead of requesting the user to run configure again
> with the --enable-tcg-interpreter option.
>
> This change simplifies building qemu in automatic build environments
> (like in my case the debian buildds) because one does not need to
> special case on the architectures.

I don't think we should do this. TCI is unmaintained, has several
known flaws, does not provide the level of performance that
people expect from QEMU, and we've talked about removing it
altogether. In particular, distros should not automatically ship
a TCI QEMU -- it's something that a user can use if they
explicitly opt into but which I don't think we want to surprise
anybody with.

If we care about a host architecture we should support it
with a proper TCG backend. If we don't care that much we
shouldn't support it.

thanks
-- PMM

