Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35E5C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B120426C17
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+U531D7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B120426C17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrhh-0000d5-1K
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:29:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXrX2-0001Lt-Bx
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXrX1-0000hO-FD
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:18:04 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:42300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hXrX1-0000g6-7v
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:18:03 -0400
Received: by mail-ot1-x32c.google.com with SMTP id i2so16003882otr.9
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zW5+ft4DHrr5jZwJj0gH36zDo/eTD6o3CbEgSk7iPqc=;
	b=d+U531D7qClca9qVeRPy/32TSKqYhBh2Yp6jaSGVhSwfuFI6qEnG39eBeDrQbNMsE8
	ylWN6vAQ6jm4t5Ao4lw9yirp/gDITWHg+bn5nmmk9itPhRcCX68+Q44OmtfX3DgZWUCp
	AFaq+yDQlMsKOmENXyUx113vfi3B5nh8AGgJ4c5X8mH8ryCAQmF6DT4DuAJ/xrlKysNo
	I15L4O/MQzbE0bOLWH0/pLO68wTZaHuI1pUX28qPcdPK/n6EOuSqM/F9waBoQlsjGou4
	iKk37TjOjnynXLJQNOz2olQxR0J8G1TLNRlWT1EDB+qEdjk3a81/QaaHy78BXTcBBL1K
	W/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=zW5+ft4DHrr5jZwJj0gH36zDo/eTD6o3CbEgSk7iPqc=;
	b=ICo1MguHNthngXA9+6Y4zrXRp5DqDDarUxiegPB5FUSy2ybLOOMDQbS1uk1/YzmmJG
	jmIdKS4IC+rUvORGqrGNVQ9BFkPwS9x8mEGym3HYyyjm9Lt5ycUIUKf1jwb0aGgU/28u
	PVptVCvzVnwvQccvPFy0KUKQXjCJQCZTsbDUfImM0RMt1+uaSn0TOqkmFce28hS6U0lK
	KRLpr/qLREd7GvBiTiystZMDtvF4/4xU64eb5bcRmz8bDvMA+AmMCgfMLBetiH22KORx
	8ZdWN1HbZEHDUp5PzB+7oZ1yZx3aQd2b5dQbWn9FGYkY8g65hqSnKP/R7OG4uhzccTLt
	ypGw==
X-Gm-Message-State: APjAAAXcjH2KfqDL5zoVe2ajheiLL2V+S6A3vgKIyxlgL5cs40ID9crb
	dkMpAfxCyyT5i1M9m4Z/T/Rg2cEru7n8ORdX12N/dg==
X-Google-Smtp-Source: APXvYqzAnIeXJWdYB+93b50awDnoffhJXu5S9ndXkn6H4CbRgJkyiwj9h7AKJO2fLp4mDJfGaMimRf6mZxny9J7VJlM=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr2090452oti.221.1559585882253;
	Mon, 03 Jun 2019 11:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org>
	<236db86d-52df-5537-4f33-f3c09bbb6289@redhat.com>
In-Reply-To: <236db86d-52df-5537-4f33-f3c09bbb6289@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2019 19:17:51 +0100
Message-ID: <CAFEAcA_bSzWYu5Oa_knq2SAK9Z3RN3LZjxeirVncgRQ9FsDZXA@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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

On Mon, 3 Jun 2019 at 19:02, John Snow <jsnow@redhat.com> wrote:
> That policy strikes me as weird, because RHEL7 is not going to be, in
> general, using the latest and greatest QEMU. Usually stable versions of
> distros stick with the versions of the programs that came out at the time.
>
> What's the benefit of making sure that stable platforms can continue to
> run the *newest* QEMU? Is this even a reasonable restriction? If you are
> running RHEL7, how many projects do you expect to be able to git clone
> and build and have that work with the rest of your legacy/stable
> dependencies?

The benefit is that in general people who want to build QEMU
from source can do so. I don't want us to be the kind of
project that needs latest-and-greatest-foo for everything
to build, because that sort of project is pretty infuriating
to try to work with if you're an occasional contributor.
"Builds on LTS distros" is an easy-to-express way to keep
things from getting out of hand.

Plus a bunch of the build machines we do testing on are
not running bleeding edge distros, and as Connie says plenty
of developers do QEMU development on non-bleeding-edge versions
(my primary dev box run an LTS Ubuntu).

thanks
-- PMM

