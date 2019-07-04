Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F219EC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF11E218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcE7IxBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF11E218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3uF-0005v0-2X
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 11:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj3tG-0004yL-BA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj3tE-0003Kn-AL
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:43:18 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:43067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj3tC-0003I5-Dp
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:43:14 -0400
Received: by mail-oi1-x22a.google.com with SMTP id w79so5203091oif.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nI/PXMmkLI7kWolI9ni1FJmQc/Tup1BwET3qaAmtqRw=;
 b=IcE7IxBAkUw2U8CDNwtLq+ou2/32JBPwZn5AmRX8XC5mOSaUt6QmlVyBGcBt3hnEcV
 UVMk5NqbroSAkBlwVztUSKEFd8PuS8qb0GLNv4ai9TUs9aSHAjoKbC01woUah6lvIO8a
 QIqU69JLw/U3VvPOhiBPkdE2ukbgjmx4SDIMKoSUb25VQPY13HGxqiUutpRyjur1YRGT
 nearkly5eRbzWYQIyLjHATQhIfUHIMgF98u278dEiSeUHLHnvAu9wjfbrnCiE9xkD8/I
 tg36oAo///7QwzQTZBOpbKcsIx4w287WqR+ncXk+PHe0XiI1V1kSqE7JmX8GgPKMQc5m
 0Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nI/PXMmkLI7kWolI9ni1FJmQc/Tup1BwET3qaAmtqRw=;
 b=TIzld58z8z593CArjylw66yp2EKvuhLAG7gPoMTxYo6Q6vNhaNTs5CPX4LihZ/5fAo
 HKHLJ2l3IW9WxYjdVohOOqBr22rMsBLRkDLgVRabJY5RWR3CvLs3xKKXoKtnTX6mxnhp
 im1q4ept9/CHNlFGlEV8FlzawYBYnQB9hR2J69RABamvLTuiPci2zkqjMDbWVpc/ePcR
 7Q29jFXAUrLANrcZMgIqtLDdno/2dl9ann7UDlMCEhB8sa4lN/Pp4QBnbII0ThTKCi0r
 1K4iia2Vaaq4RhlwOTdnLxR9VXM+GsKjDOtA/YTzi1OHJ0Q9YbFD9sPQz+UDqdGWZYYd
 lKlQ==
X-Gm-Message-State: APjAAAXXwefZ2shFqbWMS+qbuERqJiZBwosYfGC1ASM94Am7ZARIN4wc
 0C7R0kc9ayGQVwM/5YhKH0xuTx/i9RJHFdtb+iPu6w==
X-Google-Smtp-Source: APXvYqwn+KB54uH96B/evqsISHyofZIDhMIvabEZ/dnOnL8wQJU4gPLnACX9p8ZLErJEDRQg1KsztFEgukJUT5cOKKU=
X-Received: by 2002:aca:5cd7:: with SMTP id q206mr120054oib.146.1562254993192; 
 Thu, 04 Jul 2019 08:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190703114714.4234-1-armbru@redhat.com>
In-Reply-To: <20190703114714.4234-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 16:43:01 +0100
Message-ID: <CAFEAcA-A+MfKHyM44=TnzuOqHOrJB2Jenb_8TnAG4WT2NQfm6A@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
Subject: Re: [Qemu-devel] [PULL v2 0/4] Build system patches for 2019-07-02
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

On Wed, 3 Jul 2019 at 12:49, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit ab200dafc0e8a9925bb0ad0be478621f5f117c95:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-07-02 10:17:54 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-build-2019-07-02-v2
>
> for you to fetch changes up to 1338a4b72659ce08eacb9de0205fe16202a22d9c:
>
>   Makefile: Reuse all's recursion machinery for clean and install (2019-07-03 13:19:19 +0200)
>
> ----------------------------------------------------------------
> Build system patches for 2019-07-02
>
> v2:
> * PATCH 3: Add compatibility gunk to keep make working across the rename
>
> ----------------------------------------------------------------
> Markus Armbruster (4):
>       Makefile: Remove code to smooth transition to config.status
>       Makefile: Drop bogus cleaning of $(ALL_SUBDIRS)/qemu-options.def
>       Makefile: Rename targets for make recursion
>       Makefile: Reuse all's recursion machinery for clean and install


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

