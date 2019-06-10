Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D08DC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C392E207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwEciOJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C392E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKHN-0001Xe-I9
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haKFY-0000IG-57
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haKFW-0000ii-VX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:22:12 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:37565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haKFV-0000hT-Vx
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:22:10 -0400
Received: by mail-oi1-x22e.google.com with SMTP id t76so6202401oih.4
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7A1Twrk3AcfR9aQT2yMxTJy/U7TUyjgKs19ktPmdL+I=;
 b=ZwEciOJFqvGEi4FuQStWVUJ12eVqps6NgsNEq/Hf3RmT4WSriJLybvCeGAas0qy+Ru
 lMMMva82ZU1HcSYQW2RkSCC1UDYlWAFzmruYvsDw2ePSkJfJEbwyL1PpS6yGnv1DrjuV
 DnhXL7zmI/xVKFjyPfBRo/8o4ayes8BVMC+fZ4qC3eJt1q9IbRAc2/qReJQISfUjBRfg
 mASMXuaAB6PMSTKtkXYevPOzoxVTZYrmyWNB2ewm46zyE0xaHVc7H3xiKi5oc55z44gZ
 Z/fpsyrYDH+qqoKLcRr+amPMAV92g8dYDcDc0ym+bLQdGPcm4BVAudwPLmlaAOkie7W8
 weAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7A1Twrk3AcfR9aQT2yMxTJy/U7TUyjgKs19ktPmdL+I=;
 b=Dr2zucBXw7I73SUdQ+6+TFeCoCdxk93Ty4LFGiDXqihyLTtTtHOdEeVkK+qSytn1iB
 OaZ4VKI1Yz8gjRwYG6yoSzlDl/vgxRAQhdXx6/VoSl8g7gGG2VgWlqlZM6jYTmJWkFmL
 fkSoa/DOAJhTWQc7tT/MN5t6fUyzH5+Knv5PKZ2SUkMRrht6VPLAJVbQiIn1T0QMCpLG
 il4Lz6ZxPVV5CwfXxoB2yKAgPHQ/WOJnrAv9Lo5XcauQInzfzAbl6lmQ57LW3osV0PXW
 KJE3EoyrbOH5bMhIX860Hn8O9MY5VUltbyeGZcZsvn0zWq0PKRkh+UZAf65B2mn6h0C9
 uwag==
X-Gm-Message-State: APjAAAVVbWKK6hXy1XtPEQt8eZkCRHcL3wrFk36rijDfsW2axG4oH4LU
 LAnHHyk+AKCWNkHiifbsmMb0z3bNCy+ZIVLDX5jdaQ==
X-Google-Smtp-Source: APXvYqy5OacfM/DM/BXuJ6RBgMx8svIwdMTpF2WMCkuBFbiEqX56kwglwPto3HVjb29R8iAbFMPfqfA9IBl2QU/nbho=
X-Received: by 2002:aca:c786:: with SMTP id
 x128mr11628632oif.146.1560172928617; 
 Mon, 10 Jun 2019 06:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <20190610131105.GJ22416@habkost.net>
In-Reply-To: <20190610131105.GJ22416@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 14:21:57 +0100
Message-ID: <CAFEAcA_fBBN_854PznqJUniks0uemEite8Hxcw6cwTbUSr+aVg@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Jun 2019 at 14:11, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
> > Hi. This fails to build on one of my buildtest machines:
> >
> > ERROR: Cannot use 'python3', Python 2 >= 2.7 or Python 3 >= 3.5 is required.
> >        Use --python=/path/to/python to specify a supported Python.
> >
> > The machine has python 2.7.6 and 3.4.3. (It's an Ubuntu trusty
> > box; it's one of the gcc compile farm machines so upgrades to its
> > OS are not really under my control.)
>
> Ubuntu 16.04 LTS (Xenial) was released in April 2016.  Doesn't
> that mean Trusty is not a supported build platform since April
> 2018?

Possibly, but as I say the gcc compile farm is what it is.
Regardless of the strict letter of the deprecation policy,
when we start running into issues with the set of build test
machines I tend to feel we may be being a bit over-hasty in
deprecating things.

PS: re the BSD VMs, you probably want to start with Alex's
recent update which did a fairly major overhaul there (he
sent a pullreq but it didn't pass build tests so isn't merged yet).

thanks
-- PMM

