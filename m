Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7043C2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905A7206A1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 20:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRNw2ib6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905A7206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNjdS-0000Li-QD
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 16:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNjcC-0007nC-0a
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNjcA-0006Vf-MN
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:54:03 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:38980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNjcA-0006VW-Hx
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 16:54:02 -0400
Received: by mail-ot1-x32c.google.com with SMTP id x11so7324840otp.6
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fBxixUsP4EZKd6scmf79jz4nJjZiGIzlSf09tfGEfyU=;
 b=WRNw2ib6J3LLfv7VV/AXbVvw67rmGUhsv/3Mx4RJE0v1IER5CMujw1Zu35mMmEaOxe
 BWyjGA2ztI4cohlaoSlRN1NFSXnAafdT2niP8fjt7h0s69uT6O1+sU11S9tWMby9aRrM
 RQWLkmFrjL0dXIhtDB/IL++U/+cMX+ksDV7Ge4vxPanqihrcHxhZukoAQJFkE9YWcRFF
 c2t8q8a/YDqH1XW0tB4u198Z+vSuiY6i297fadFfKES5pSJel9sUqD2IBXrVy0L8tim8
 Gsq18utul1ygX9EiqDUr03987JQqgFJxtL9nFwa9rUBww6e8kPi84xw4J1RiHWgbUIef
 hltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fBxixUsP4EZKd6scmf79jz4nJjZiGIzlSf09tfGEfyU=;
 b=PzLTzkNVQOFbfD/MdxkQdrgFJ4BwkRARSFeUhZcbDTU2wp9j5BfxWwj/tUQMkEr9pg
 sJqESsmrimxP0ubn9StgkMJ4PHkCeEt9z6s1cWOd07qoeYtsqawN0Y1IHaUdLJyc/ypb
 AX4aoygwCUavHrOKk5O3ONCCTb1CVuo6mTTmY8rgaBhM5auBQINfORyx7KAIhakf+tZS
 fE47vbU3tQCDtP41gjlTpjwg6sBzlyYQdRLpnOmvlL5syB0yHkx42XHT1g4adx15EFwe
 61Tb9MBQXj/QUbyYwxAJfalERs7G9SHhcSEjg7wtxO7Tw0MqLzdYD+1xfzi8rcpV176x
 FRMw==
X-Gm-Message-State: AGi0PuYrnwC66AFMTaMqgkPAcG4EAQgAzjnlBfJaHdavK0bLefqqIm2T
 k6uD1En9MR2e10iVo/BBMlgeYRItOa6yzB7VXK6msw==
X-Google-Smtp-Source: APiQypL2pS6VuWuRaC7hhkp5zHm2/dDCQJ7lsbuBJtn5J+9P2O1wUjwzhaie6frmJtBjV6qbMF/HXp2dyV7i6SGFqBU=
X-Received: by 2002:a4a:b241:: with SMTP id i1mr12010099ooo.64.1586724841301; 
 Sun, 12 Apr 2020 13:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJAyOaarDVp_Qaqn45ML+KqfidyCH=wQG36VZn=f1wh1+nBumw@mail.gmail.com>
In-Reply-To: <CAJAyOaarDVp_Qaqn45ML+KqfidyCH=wQG36VZn=f1wh1+nBumw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 12 Apr 2020 21:53:49 +0100
Message-ID: <CAFEAcA8Y50+c5Hub7Y=XHbdrFVv+rhaN_7mkEW9YB63LgS0=TQ@mail.gmail.com>
Subject: Re: Clarification of above code
To: Oliver Christopher <adultjiuice@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 12 Apr 2020 at 21:46, Oliver Christopher <adultjiuice@gmail.com> wrote:
>
> /*
>  * We default to false if we know other options have been enabled
>  * which are currently incompatible with MTTCG. Otherwise when each
>  * guest (target) has been updated to support:
>  *   - atomic instructions
>  *   - memory ordering primitives (barriers)
>  * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
>  *
>  * Once a guest architecture has been converted to the new primitives
>  * there are two remaining limitations to check.
>  *
>  * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
>  * - The host must have a stronger memory order than the guest
>  *
>  * It may be possible in future to support strong guests on weak hosts
>  * but that will require tagging all load/stores in a guest with their
>  * implicit memory order requirements which would likely slow things
>  * down a lot.
>  */

> I am asking for clarification because the above code will default
> x86 on ARM64 to disable MTTCG.

What clarification are you after? The comment says we won't
enable MTTCG if the host has a weaker memory model than
the guest; arm64 has a weaker memory model than x86,
and so we don't enable MTTCG for x86 guest on arm64 host.
The 'it may be possible' paragraph explains why MTTCG
on this combination would be tricky.

(Strictly the comment should say "host must have at least as
strong a memory order as the guest", but that makes no difference
in the case you're asking about.)

thanks
-- PMM

