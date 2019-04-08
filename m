Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B121C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BB020870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b13J3YEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BB020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQps-00044G-8Q
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:45:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDQoj-0003Ru-Tl
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDQoh-0007Rc-5o
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:53 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDQog-0007Qi-PX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:51 -0400
Received: by mail-ot1-x342.google.com with SMTP id t8so11393258otp.7
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=PEsWYR7q7GCRV0rDY4IjVdUNENI8piFrJ3/uOWByDZw=;
	b=b13J3YEY0pTBgbvWZeKn31y+72rnXbEtx2WzXncQooN7ixv8CBjuyZJW1tf+LIXD+Q
	YjFhDtF1KFy0tD6wIDkg3cFVBtLnWI/oFOE4QlpOjAHU3ybgxuWd/VtkdqmOnrtob+J3
	bgx659bkPqX+Y6Qrc2IKCvMlEpKCD+XBXES5Tg26UJcskdd0Oeom8RKTXrYcggbAs2yz
	pkkMssw8vOHZyjqbkn05Ie0KxYhLEG3JBJwxSvbNJSdvk2YIukptTcmJx4wHwTudHblz
	2QtuvNmOQ9MQMS8SKrBHmlHjQQn9ANheWs3wE9gmoS1TCuuqKE9rdJ4+XT/WeWRHXPO0
	dQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=PEsWYR7q7GCRV0rDY4IjVdUNENI8piFrJ3/uOWByDZw=;
	b=oI7RD7dTYK2BrJVbGblCFejEtXqLJumf3usvzp7sWZj7Dbs5ZVu+nv2wsu4ryPWnLv
	dMon+qXR5uBsZXpxaRHnRstX51dWyIsC8fKsgOwJB2QeBAqGMcqC289xsTGyCYTkkRZ2
	qdc55kZ5KZx/thn8MrZSRt6pR/2BnJqKfZdyIfOvMCsLIc4glpx4vtz184OB63XaDRav
	96RNb9saPz7F2xb+/tu/1QEfZiXiAocJbEthMsOkDVYNpbAeBvSYuTGwIBVCIBI1+qSE
	56RXuF4nRPw5S9RXUVc+cQadS5gtefF5YwtLuhZf0v14xjAwjjjCJ8jvHfRAneuKos3J
	pvaw==
X-Gm-Message-State: APjAAAVjUXhUsDPrqC/8cGxmug4npqxBkPn8pQDg13bKWXG8wPSmE+SN
	peeH1KqnUOKShRySrdzlY6HxWLeICrnDLK6adDwXRA==
X-Google-Smtp-Source: APXvYqyXbeFJg7VLK2cJouyxHrmqM6mFRB1fQQ7kVL0psCrBUizzUkeR4KZcjUjAdR9JqYyLpb9/cZhU4XVqvTUbmRI=
X-Received: by 2002:a05:6830:164a:: with SMTP id
	h10mr19313412otr.323.1554716628848; 
	Mon, 08 Apr 2019 02:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <1554624893-8363-1-git-send-email-guoheyi@huawei.com>
	<CAFEAcA-N=y3k41oexvYaQ+tKj1d2tCZh8MhPvdq8Uz7dh-eWWA@mail.gmail.com>
	<cb3534ef-2bd0-0518-c6ca-01c1f6511199@huawei.com>
In-Reply-To: <cb3534ef-2bd0-0518-c6ca-01c1f6511199@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2019 10:43:37 +0100
Message-ID:
 <CAFEAcA_7GVwQfiyJi-dRkCaoyGrGJQtCd6DdF1dgJcGPcCDTRw@mail.gmail.com>
To: Heyi Guo <guoheyi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [RFC] arm/virt: add one more uart for UEFI runtime
 debug
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
Cc: wanghaibin.wang@huawei.com, qemu-arm <qemu-arm@nongnu.org>,
	Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408094337.mFJmA6GhbsSwYX68awqo2-272Xzcia3MclkC7N4k6hM@z>

On Mon, 8 Apr 2019 at 02:45, Heyi Guo <guoheyi@huawei.com> wrote:
> On 2019/4/7 21:16, Peter Maydell wrote:
> > I don't think it makes much sense to keep adding UARTs for every
> > bit of the system software stack. We don't have an infinite
> > supply of UARTs on real hardware either -- how is this handled
> > there ?
> As you were in the edk2 mail thread, I supposed you also agreed to add one more UART. What did you mean by "I do still have a todo list item to add a 2nd UART"? How shall we do that?

That would be a simple second UART available to both secure
and non-secure and advertised in the device tree. It would
only be created if the user specifically asked for it on
the QEMU command line. I still need to investigate exactly
how that ought to work, though.

thanks
-- PMM

