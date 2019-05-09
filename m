Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E113C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E702B204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="azxAu7Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E702B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOen5-0007V3-7U
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:52:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOem6-0006oX-0o
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOem4-0004Vl-UH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:51:33 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:44232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOem2-0004UT-I3
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:51:31 -0400
Received: by mail-ot1-x32b.google.com with SMTP id g18so1351205otj.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=SUQDvLXub66SmTLB5kPWL99Xoj8+DJYO1pbuhVRCM0I=;
	b=azxAu7Ah77zyZ5qcsZ3Xg+kafzWPO8dl3NsLlgu001DHUz8k23yNy3VTt6WlKAeLtL
	1RCZiu4a/ZEvXfIJ24zlb38jNduqKmoTd3w+ACpyGT6QQs6xLMRDw7UieIeZR636H59Z
	YNvvAbw3ay7jfNZJpRxMlnJF03nY+YZlWrTCmfwN/2wHiJC7pbgjffNGx2Zplr+X1icv
	FaBZWBUnSMTqvTz9Gcm+06aUztFk1yLJ+1qGWggB748muChBCKS3eVUdV+F2vul0QNA4
	QE1i9NybiEuzRg8q7Gh83gjWkjsj4LuRrHwQV8p/LHGqm2d/j8d6fZb42wU6OzLd5h/9
	E4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=SUQDvLXub66SmTLB5kPWL99Xoj8+DJYO1pbuhVRCM0I=;
	b=Ic0a7bljEw28F2kY5j6aXNW/qLPO7CPVJIzNqPl1ZTGv2mB6X8iVCZHORm80m3pGyU
	WgltOZS17zQoEqIkkaX1gonNMXwPfNGUmBk7pXHfb9QadGW70ShLlAFnweooU56mDkDT
	AhrzJJyrTTbCt5kbt/x7/OATuUFBe08fiwNMSI4dO09WbTm35fLkLygNqtbvicRzQct7
	SoMokfOMo5t/ilhJ2wrHfykBwhUnbWGilaNYcya6yutp+opTJjlNRd7GBzonbGyySFFz
	GrqDnyKWyj4RmTxSZhffZT3kFxehVrGViRy+5thI9saYQ+1qkNRhoGizDZG1nzdouVgr
	zyiw==
X-Gm-Message-State: APjAAAVErBNOTXUfNckGm9mPCF7RcT7+OfY+bblmqHwyPe56DQypc0AF
	+8yEOpendZYVvGw4yGCjsX3LiR7VRtGSe9POn5GJ0T7giFk=
X-Google-Smtp-Source: APXvYqwElnrIdcRwCo8EjDOJbydhchynKxgGBKyQbPIFi1QQflz4KELYQgkQX7+0eqTiuy5SRbSZit7+b4xH2WeRXT4=
X-Received: by 2002:a9d:404:: with SMTP id 4mr1609953otc.352.1557391889796;
	Thu, 09 May 2019 01:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190503112654.4393-1-laurent@vivier.eu>
	<80fb3313-239a-5828-94fa-d27137bfcb05@vivier.eu>
	<CAFEAcA_y24gpugttDTR-QrJ0fA7JCQeC0XXsR6pjm2rQ19rfCA@mail.gmail.com>
In-Reply-To: <CAFEAcA_y24gpugttDTR-QrJ0fA7JCQeC0XXsR6pjm2rQ19rfCA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 09:51:18 +0100
Message-ID: <CAFEAcA9ZRSxPK17Zgx0WuhvjyVATL5-0Mp7LvBtv5O4+UGRVyg@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL v2 00/12] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 May 2019 at 21:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 7 May 2019 at 20:10, Laurent Vivier <laurent@vivier.eu> wrote:
> >
> > Ping ?
>
> This is in my queue to process, but there are still a bunch of
> other pullreqs in the queue too; I am working through them.

Wait, I'm confused now. Looking back through my emails you
said "Forget this series, the send has been aborted for an
unknown reason.". So should I be applying something ?

thanks
-- PMM

