Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5F5C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51C02063F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jrCA7bbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51C02063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57276 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL5o7-0001Yx-Oq
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 08:54:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hL5nH-0001Ch-7e
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hL5nF-0005u5-Pp
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:54:03 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hL5nF-0005tg-C3; Mon, 29 Apr 2019 08:54:01 -0400
Received: by mail-qt1-x844.google.com with SMTP id p20so11668255qtc.9;
	Mon, 29 Apr 2019 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=lB18pEzl0Tg8zg65WCwpHy2hjsy9JyOMljdQvpZbb/c=;
	b=jrCA7bbsAL7pN2qn11KNcCfFC5kSUIyyFUFEIGjuSO/ANYSc/URbbDmvvemEJPVZF7
	kaiuYUoMD/f8VBTyooJT1QMylzeG5w971hR9IY5CKfOeQF9rBbvyNrnEq+BHTHpIZDCZ
	4FxRGYh/+0m/ZUGDuybf8k6HI/tT7V+Ld6Ukg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=lB18pEzl0Tg8zg65WCwpHy2hjsy9JyOMljdQvpZbb/c=;
	b=oY65irJpIB0cA1J3IPdNob/BhrX+ULRAtbqBc2WFSgpFPrVhsrr2jjKMZJnEK4R94s
	/e46aqK5YmjklempX+YEn00DB0N+ZvIYmflYQnMHPWq6fh++IqY8GmCCX8MC8OO5o1gt
	FSA7icsXKNmG4ED655QIQtXlhowcDvwFJktomT04xBGNYi8G3fiWxA0Nq5Vb7wxzfBqK
	RjIWX9/FeD+zx7nfxUdEBxC8J16q5E1UblvLO1ogg4s0HGll0kGejZWFiRVWqvZnhdQU
	lO37+BJjm+skxmjeGEhHmvUV2nH2EAl7Q2HiIF3xO6M/ZUgXuNpWfUeTCKIWfEgHIWNc
	vClg==
X-Gm-Message-State: APjAAAW9Ei2ckfwPfSqHDkglZK4PDesl5C74oxrSIuocsvBsMyc/J+uF
	D8Bi6eFaHcqCyVGIR2ozHoeVCYhQdWlYc5ESjww=
X-Google-Smtp-Source: APXvYqzEhJhjTKUMWByG/CtGyr2sIsU7aUNGY0W++RiIfDr3GdmLeSXbvwmCsngkwuGmleZExNAt5qwzA+603zeHUK4=
X-Received: by 2002:ac8:169b:: with SMTP id r27mr34536234qtj.235.1556542439964;
	Mon, 29 Apr 2019 05:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
In-Reply-To: <20190426091702.GA2071@stefanha-x1.localdomain>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 29 Apr 2019 12:53:48 +0000
Message-ID:
 <CACPK8Xc5KgiaYCTs=8ceRu_hV=vC3M6pGV0=7jJNsbuz2a6LDA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Jim Mussared <jim@groklearning.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>,
	Steffen Gortz <qemu.ml@steffen-goertz.de>,
	qemu-arm <qemu-arm@nongnu.org>, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429125348.RnoY9-HEPFM0GE9b9AzKiprlF1Zcui8M1qlFburilzU@z>

On Fri, 26 Apr 2019 at 09:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> A user-friendly error message is needed here.  The check for -kernel was
> too specific and is not desirable for microbit where we use -device
> loader.
>
> Old boards probably want to continue using -kernel.  New boards like
> microbit may use just -device loader.  Perhaps there is even a group
> that wants both options.

FWIW, I used -kernel exclusively when working on the microbit model.
Other users may chose to use the device loader/hex file.

I am all for usability, but getting rid of the ability to use -kernel
on some machine types would be a step in the wrong direction.

Cheers,

Joel

>
> A solution is to introduce explicit checks so that we can tell the user
> the appropriate option for the machine type.  I can work on this if you
> like, but probably won't be able to send a patch until Tuesday.
>
> Stefan

