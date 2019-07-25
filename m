Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE42C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A07B22BE8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A07B22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqhhu-0003RE-7g
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqhhj-00032L-Mc
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqhhh-0002DL-GW
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:38:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqhhf-0002CP-LG
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:38:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id v22so37056519qkj.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u8BGMNY950ZO23qVBakK9/iI50jRXoU9AN/FrrQgGBY=;
 b=oKSQVSxcsqAmXpjvlI5fl27rczR33uUlOPmXsPVWJxSgE0sy4j/GMQU6lsmHiEC8M7
 4SO7YwYNTG/MfJo62XKnkApJmqLltR4Duuw1OQTa8yTdO52PrFjhv7KtC5j/9pD1uuPg
 ZLVC1+16Jqtav8IP43Xx0sWS5kWM22dlZ9aSgVt9Rb/msG9ARkIfP2wEJ9eGgjM5/xl8
 oN8okp63ARRYbrery/fCHoGlq3/wjaJ0Rc1fALLpuDm4h8xdModPIMBuW7VYKUf3Y+Ef
 5Pb2axXOq8ttFnnNJ57kR3hTrBvbREYUJukCPyFqEtQoqrZsLjnNl7lZx8xHLEQnFfF8
 HtMQ==
X-Gm-Message-State: APjAAAWO3RILCzOhtGxAdig8MyW0rJ45ZxZnFudHi4ZLwvJSRhk6bz7M
 XkFGH4n7itpR/xgPcYyb8moEFg==
X-Google-Smtp-Source: APXvYqw8OjpvVtSU1yYVmiAmQmjMmo5zF76k6+9Jtz4Z/5w6RmzO0Kt8/O2SvBoD7iYqOvC9Rf5J6g==
X-Received: by 2002:a37:62ca:: with SMTP id
 w193mr21076934qkb.363.1564076334400; 
 Thu, 25 Jul 2019 10:38:54 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 c192sm22287085qkg.33.2019.07.25.10.38.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 10:38:53 -0700 (PDT)
Date: Thu, 25 Jul 2019 13:38:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190725133500-mutt-send-email-mst@kernel.org>
References: <87pnlymm47.fsf@redhat.com>
 <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
 <87muh2mazh.fsf@redhat.com>
 <20190725104721-mutt-send-email-mst@kernel.org>
 <20190725110114-mutt-send-email-mst@kernel.org>
 <cdc6e86c-ce05-fd48-c8a3-0e6cec894d4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc6e86c-ce05-fd48-c8a3-0e6cec894d4e@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.193
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 05:39:39PM +0200, Paolo Bonzini wrote:
> On 25/07/19 17:01, Michael S. Tsirkin wrote:
> >> It would be educational to try to enable ACPI core but disable all
> >> optional features.
> 
> A lot of them are select'ed so it's not easy.
> 
> > Trying with ACPI_REDUCED_HARDWARE_ONLY would also be educational.
> 
> That's what the NEMU guys experimented with.  It's not supported by our
> DSDT since it uses ACPI GPE,

Well there are two GPE blocks in FADT. We could just switch to
these if necesary I think.

> and the reduction in code size is small
> (about 15000 lines of code in ACPICA, perhaps 100k if you're lucky?).
> 
> Paolo

Well ACPI is 150k loc I think, right?

linux]$ wc -l `find drivers/acpi/ -name '*.c' `|tail -1
 145926 total

So 100k wouldn't be too shabby.

-- 
MST

