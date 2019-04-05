Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1471EC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE11F217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ju+RM90K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE11F217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKwQ-0000Rx-QI
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:15:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCKvJ-0008Bp-Mi
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hCKvI-0001Bq-TN
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:14:09 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hCKvH-0001AK-S1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:14:08 -0400
Received: by mail-ot1-x343.google.com with SMTP id j10so5032422otq.0
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=kIHsoSWQ7xWl/T5Zil8IhTPkpwjLYX3wXTfAMDljL20=;
	b=Ju+RM90KFxdKrCj93g8hQgiokKCpzyjolHdbjp5kag3tofzbPbrH4AHqridFMdLhyj
	9yWPZTZjqGk6RwRuYnkDN8BLh3ar+EmFxT27Bav4VPNhTzO0dOBGbTFS3jpUlWPm53bO
	bFSXJ9KtIPI4D2wKqHNshBUKqYt09SsSOCLcx0UETFVr7FFMBtNU5WYGwd2U1wEgJolb
	jShAVViM34cxusDx94Qydg9Vae29aRZ27m2kmiuZUzkNd0igJAAMRICS0YxUCB8c/fLE
	TYvvpuQNNK2hQm+vvl1H1za7P4vMBymWx0bfXMANdHOpt4JmT21sOpfg7/v7TgIWXXNe
	IPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=kIHsoSWQ7xWl/T5Zil8IhTPkpwjLYX3wXTfAMDljL20=;
	b=rtwq3qpSIWIk1p6FdN02Zv02zPKdgygxHwR7/JPFckXeAWf9t56lmRdLFtYqVWYNMo
	yjUJ6QZn7GnoRSrDSueg/DH66DDxanJ6vMNmJ3F7HAhNj9dnrk4J0HdRN+PJNg/U1acj
	wMAGnoxTlWEooz+Pf7c4XTaXq8PnrxsVNrMJZ5topZ8i/TXrHI9fcpzm0Gyk+ws4TaK9
	jkom1qdX9h66CCt+yzaTDpR6ivpt19V+yRZ7PXMqE1qocbPjsvo6G/Tlzol+wRwCP0MJ
	grZzjxBDo9CZRamMP2NAY1qy3Qksh8E6BsM2gWKgcVqd0sWlKKSCyA0d5hyz01aBKzcc
	oJ2Q==
X-Gm-Message-State: APjAAAVY+HT3K/BYbsDSQTtyVo9Vytk1luiJqHE7TzHCAxPOEa/9Ui96
	+tHjNtPp68xw3HXab3ljt6Kk7XVZZ59m9cq9TY8mKA==
X-Google-Smtp-Source: APXvYqxHQ5cWVX6FrFiYUpUW6RaGeyp+vjBk4FJXD1mpjABK08yop4O1a/b3esU0fB2wcRmCyudBlh7iOUBnFzIdYpI=
X-Received: by 2002:a05:6830:1cb:: with SMTP id
	r11mr3414332ota.302.1554455646451; 
	Fri, 05 Apr 2019 02:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<20190405082613.GC6105@redhat.com>
	<457ec791-3691-2ebb-e225-bd42a7aee627@gmx.de>
In-Reply-To: <457ec791-3691-2ebb-e225-bd42a7aee627@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2019 16:13:55 +0700
Message-ID:
 <CAFEAcA8uXuQMRapv5ZvvQBFzR0VV++fYnZEm=ePc8Xe1=OCbMA@mail.gmail.com>
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405091355.1cLRp3OAnEpTg32qHgY6fZuT3O-mpO1PwjdApJNEsN8@z>

On Fri, 5 Apr 2019 at 16:02, Helge Deller <deller@gmx.de> wrote:
> Sadly such special treatment by projects makes life for me
> as an architecture maintainer much harder :-(

It's kind of inevitable for programs that aren't straightforwardly
architecture agnostic. gcc doesn't work for architectures which
don't have implemented backends either...

thanks
-- PMM

