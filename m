Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92EBC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36424270E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5DSJV/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36424270E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrwM-0007Db-9Z
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:44:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXrrO-0002fN-7d
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXrfw-0007dU-3S
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:27:17 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:46632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hXrfu-0007WX-Nz
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:27:15 -0400
Received: by mail-ot1-x336.google.com with SMTP id z23so2057865ote.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=GtzhnxJPfvR3BFHdR2jF6zhNGrLrYRK46/mV4PixzNY=;
	b=F5DSJV/8++1qIcJhcKLVdDjjWKrjvcM46UkbNRx+okbeFeAP0V9i0CSIM4CO8rJqgx
	MF0iEMEkFlPrI3XXne1xDEPHvk80pvPKdqxaPrlWDmI7AlIYrkkC4BOeo6zAafQXwuQL
	1Aav7rLIeLJRiz88xyvkn+UMkfFjAri1JueOq4sGOvkf1AHXdZq2FocNx5Na0zhGLqLe
	5EKBV2/fX0p0x7gZw6DKkCSU7LjWJDkxs0QSx/PuVOoh6+OAjHdrqQm/wD4BgdNMIzsK
	ikz+upvMT+pRxGPTH4D8DnQrLOrChJtgHy1AJ9VRNhc7izLDdSrxgwOrg2cWSxmWJpEl
	qdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=GtzhnxJPfvR3BFHdR2jF6zhNGrLrYRK46/mV4PixzNY=;
	b=gaXeUScc5qhuJgEDxECv9Qi3W6gdb91wRrrG8YQAfmOUrCZoTYPNTtNZlOv6DSUtX3
	Nzy2hhXypPCFdTdfUUhtXFoSs5DOBqtezeGZInl9AjZZ9Nz5Gk4ek67Xja0NnYQmsKgx
	+xR77hwkHrhYW4/gKkGK21CnNpGpoCDYyzF56ZSmFxC60P3/nkfQqb7Z64zBJG+3Stom
	z9d8koNDKbqPUKrcIstJH1jqx/nP8Gu1orzmaVX1rtybqry9rqZHJUt6dd2S4SB8V/G7
	1uzE/EC5BiVdz/dAdKB827piG7Mk3B7XMEn8mkrg4JQ2CL8FRBYXWHW5zVrtrgRcesl1
	k6qA==
X-Gm-Message-State: APjAAAUBxOWOZCcQCXQKRlJK5ocNDOxiL6gVWQD3J28AAzFIeSF65Ho/
	roUR9yU/xtBI7JEUcr7FsMj0IEfZhnuSYAN4a1byYw==
X-Google-Smtp-Source: APXvYqysLBdtV/d2/8JFuq0cHXBLrywM8XD8Qhe5OVN48OZxd8quoD+jgnS1fPWnmGszgVJhQk9UcdCLRNuf0WQV+tg=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr2226002otk.232.1559586431312; 
	Mon, 03 Jun 2019 11:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org>
	<236db86d-52df-5537-4f33-f3c09bbb6289@redhat.com>
	<CAFEAcA_bSzWYu5Oa_knq2SAK9Z3RN3LZjxeirVncgRQ9FsDZXA@mail.gmail.com>
	<b4de3161-7b9c-debc-a652-21832612ebf4@redhat.com>
In-Reply-To: <b4de3161-7b9c-debc-a652-21832612ebf4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2019 19:27:00 +0100
Message-ID: <CAFEAcA-+2Csn4wW8xLaogJrQiqc2xHrGKFc_zdaOMKNn-yas9g@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] Deprecation policy and build dependencies
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Jun 2019 at 19:21, John Snow <jsnow@redhat.com> wrote:
> I get it, we don't want to require Python 3.8 because some dev wanted
> assignment conditionals -- but we're talking about Python 2 here, which
> suffers its EOL by the end of this calendar year.
>
> So do we think it's reasonable to drop support for Python2 for the
> release that comes out after Python2's EOL, or do we insist on 2x3
> simultaneous support for years more?

I don't have a strong opinion on Python in particular, but
I think it would be nicer to avoid the "python is a special
snowflake" effect. Would it really be so bad for it to just
be "drop it when it falls off the last LTS distro" like the
rest of our dependencies ?

thanks
-- PMM

