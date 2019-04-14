Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFBCC10F11
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 01:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B812148E
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 01:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFz/CH5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B812148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57829 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFTlL-0008SO-Mt
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 21:16:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hFTkT-00088N-SO
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 21:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hFTkS-0000X1-LP
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 21:15:57 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33]:34179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hFTkS-0000Wf-9s
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 21:15:56 -0400
Received: by mail-yb1-xb33.google.com with SMTP id a3so5095715ybr.1
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 18:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=7tbVPsFDHCF6Ku6P81wzS2uVF1qnwtBkpDfbtPCo7lQ=;
	b=dFz/CH5l92Jo21e+kwgbKNLnWMeV487ceK7xpgAHSIiKuGMb5TcskfmQUW7D0XWUHy
	iJVxG0gWQoWwA9UuwoScW4CRqVWIoNCjppxPpBtFYDBSsu/A0AcBLaBYtJ1uDRN6kDAy
	pOKQKdcs+dqFSg73zUGUY70/T9DgG36uhgLDjbIRTiXAXW1wHl51ansi+PxF1HtAbmV7
	1VEDm2Y+jmOTd/HGz5XtgKE1gMt533s31zFFf4+GFb1F93sGdBfyvw5zGLE6JUz0FHxs
	3NRcqw/f2Lgl52KKL7gCNDmDElWPD0/RqNqhDovGzUUGzsolsRt7Pb6WFz8yumYdcQpZ
	hjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7tbVPsFDHCF6Ku6P81wzS2uVF1qnwtBkpDfbtPCo7lQ=;
	b=pcOLP5kk0/n3EvlPAq/zUdF+Tk169nzX+DOuPyE39o8RWgd/qAArKwSY0+7S/6oj7/
	H4Tkw0clFGsylkjNSg8ylL/OZfu70H/Z3ZZlNhOpUXt21AX0if9kxKQ2Ruui3/O/qOYE
	rau4ob3xkJvgrsMozmxu29gHwfJsPE/0bShap3qge0A4iXRn8GVJw7eNm/W+E7Mx6FiS
	WznGhGfZAgyQX++qP284HB/tj/LRIz//CPeDRupcKL1vpHhoezbapx2C8q+IZiwkUmpD
	2pptxW/4fJe895vVqkWYMUi/oGMKp0/L9s5kOtmFUYmv3ktj2gz/3X4AXhodjbb0Abm4
	4qvQ==
X-Gm-Message-State: APjAAAW9dfVuEQ9r3EF8htxSHEmL8UUcpYnZOX7MeL2M8oCIGK3GnQXb
	IKVCqotkq000b5ZTl3KawHBzq1MDiRjxKPlXaE86Iw==
X-Google-Smtp-Source: APXvYqyzTaEkE/CaTGxBdH8FALNbVftFC2jUYtuV+bTRrD5eB005LSYyhVW1mfWqGbKJtKnE8CXyXrKXabcwZZct+XY=
X-Received: by 2002:a25:6c46:: with SMTP id h67mr53183509ybc.200.1555204554434;
	Sat, 13 Apr 2019 18:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
In-Reply-To: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 13 Apr 2019 18:15:43 -0700
Message-ID:
 <CAMo8BfLEEF2_FVU88ydBWVmcRbCJ9T0ULrDEKRa-+hmCYo9cmg@mail.gmail.com>
To: Joachim Durchholz <jo@durchholz.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b33
Subject: Re: [Qemu-devel] How to I trigger a rebuild?
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414011543.VLNfq9J40u-V3cWpaUqAKKH3GaqaiK1myNk6t7WqANM@z>

On Sat, Apr 13, 2019 at 8:28 AM Joachim Durchholz <jo@durchholz.org> wrote:
> I did the usual ./configure; make dance.
> Then modified a source file (ui/curses.c), called make again, but didn't
> see curses.c recompiled, and the change was indeed ineffective.
> make clean; make didn't help either.

Perhaps you don't have CONFIG_CURSES enabled?
Did you call configure with --enable-curses ?

> Is there a list of make targets anywhere?

Typically in a Makefile.objs in each directory.

-- 
Thanks.
-- Max

