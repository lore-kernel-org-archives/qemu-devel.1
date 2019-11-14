Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B632C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BCA206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cW1JpYcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BCA206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVB8Z-0001IB-BS
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iVB7w-0000qp-WE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iVB7u-0004Yg-T4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:09:19 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:35445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iVB7u-0004Xx-LF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:09:18 -0500
Received: by mail-qk1-x742.google.com with SMTP id i19so4362677qki.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1xUz7wUpE/TjWgjjSs5uS8XqPMnaH961nfuj7Ip5qgg=;
 b=cW1JpYcHa4Lm4Q+XlxwgZq4YXD3SRQPuFVgk41Ez5Y0/NTrJrmqzZePwghFe0VpXB+
 RgtJQu58C9vgwB+USC8yt+ZHNGoCiJdd4DbBPi45xpdmTPkqRYX+phMWiOBWa1rlLSwg
 dxZ14W39viYMIX+QCS508B1bn6EO1ARoOLBdftYhwNzSdmJ+8fFPBj9CVYuMe+v8p3jD
 HswR+h4tTM0LrYzA3fdfXqwPb2CRR3g+vnQGWX9HAIszR6u6LIxmPJOeIDYkBxwp5N/Y
 fFPYRVmG+CwwbJ4+eCmL8TK9ZdvQDl0j3ZCtdvhCPi8h0+psTpLGYMKzUhQgb4KxDk8l
 SWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1xUz7wUpE/TjWgjjSs5uS8XqPMnaH961nfuj7Ip5qgg=;
 b=Na0Z9DEDCj9aiHMhYfBnI7T/32lql4LjzOyfSvOiKlXSIN2ukztL/3Y9DqxUVNRWiI
 WfIaCf5UZdm828Av6nUq/ERlUidxSg6EZTLxMt8tAHNmSGYvSRtC6m9TQ3XSCyYs+ukv
 JPi+Q3blsOnEVz6P9C7vAvLwoJFuoXJQUYaJhp9nNzn7/80FrQuRE8cY+TIJZnavSfCb
 0cgs0aPLpPxgnlEQ5XwK5Xeq6Co3Wg+cPNEhfVEFl/OqJCoEjEHZ7SNnDvJSg++RUTmh
 6Gvuh4WNesnz3HyMzYQE71m9mEOzTISB7n7mjpOKE1ZN/mLJCDuOTAlfGP3c29Rfwcc0
 s8Fg==
X-Gm-Message-State: APjAAAWjZXa6yMnA+8l4xhkL3Yv1m+c0cR4AkKdAv1eRC30VOj+Woa9j
 vhTlJz6H9sDrB+cM8Ij7TdeVBS4tlACSS3vo5MqzXg==
X-Google-Smtp-Source: APXvYqwXAdWHbAKJ4ZdTN3s2JKkWD5Udli/PUEBJLaQ0BuJ4rUCHgTgMkCRlrORkVvBkQjDqzEP4JQhvfaLnSMTre7s=
X-Received: by 2002:a37:70c3:: with SMTP id l186mr6599021qkc.190.1573722550840; 
 Thu, 14 Nov 2019 01:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20191113091809.31365-1-kraxel@redhat.com>
 <84d3a1aa-bbb2-d831-0abc-fe1169f8a860@redhat.com>
 <20191113140057.2ocwfa3rqqfkbg3r@sirius.home.kraxel.org>
 <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
 <20191114072042.wuo572evuw4hyh3l@sirius.home.kraxel.org>
In-Reply-To: <20191114072042.wuo572evuw4hyh3l@sirius.home.kraxel.org>
From: Sam Eiderman <sameid@google.com>
Date: Thu, 14 Nov 2019 11:08:59 +0200
Message-ID: <CAFr6bUmUxN4k4AhNOZZxwXUY3uEZZHAwuno4bCvedKFJuuRp8w@mail.gmail.com>
Subject: Re: [SeaBIOS] Re: [PATCH] ahci: zero-initialize port struct
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, seabios@seabios.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do you want a single commit with the changes?

I am afraid it will be slightly unreadable when looking at file histories.
The only commit that didn't change was:
[SeaBIOS] [PATCH v4 2/5] boot: Reorder functions in boot.c

Sam

On Thu, Nov 14, 2019 at 9:20 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Nov 13, 2019 at 05:03:58PM +0200, Sam Eiderman wrote:
> > Hi,
> >
> > Does this fix a bug that actually happened?
>
> Yes, "make check-qtest" may fail.  It's kind of random though.
>
> > I just noticed that in my lchs patches I assumed that lchs struct is
> > zeroed out in all devices (not only ahci):
>
> ahci was the only one not zeroing out the struct (yes, I've reviewed
> them all).
>
> > Also Gerd it seems that my lchs patches were not committed in the
> > latest submitted version (v4)!!!
>
> Whoops.  Can you sent a patch seabios/master ... v4 please?
>
> IIRC there didn't change much, mostly the parser function, so that
> should be alot less churn than a full revert + v4 reapply.
>
> thanks,
>   Gerd
>

