Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D3C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 21:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0358A21880
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 21:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0358A21880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr889-00078X-2s
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 17:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hr87x-0006g6-3a
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hr87v-0003tb-FR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:51:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hr87u-0003NM-Sj
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:51:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so48801436wmj.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 14:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y42NyBvQudU+/4iG5WVpuCQS0TEERIwAYrGuB50wlpA=;
 b=Wyf7AEhslxql8rxe02ZAOHtB9kIYrZmt+3SRB0LTCYtbDhNQSP2hppAsQp/1eeKi90
 jCsOdeNgf64n8k6FqUzOI7P8Db0Q7q/x3j8wQLWQEY0FtbwyO12Dn/A2eggDES1Gkm75
 MDvffFH2SysYszRMhsk6arbWTtKmnZ9T6wycDPPudaICqmUJFvQiQt3fi241AJf1cIMX
 EceeqKEVxTtp/AOYk/LzEdtQYoWhPLX/nGUGt7ng0qRxn7K3l8VnNIBD3EWFBDT8LkcK
 W5XFzbztjE1Q9OsBL3M1aYZIumzMk4pMtBCdWWjq4MjjYeooHiNjcn4oDI9VnTXQDxMs
 Vh+A==
X-Gm-Message-State: APjAAAW2lAU3kW9MXG+97gePWZP6LDq6M124XbDlh6qpPXsJjIdgMkFT
 bT+g4XKaomr1dk+vzleg03mMcQ==
X-Google-Smtp-Source: APXvYqyJLKRAqFhFQuNtxHh9DrWEsYOThB9CYagNgVlHiPkmm7kLqif++E/4xzGDW4QJLAjLVGc4VA==
X-Received: by 2002:a1c:a909:: with SMTP id s9mr85785662wme.20.1564177821065; 
 Fri, 26 Jul 2019 14:50:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9036:7130:d6ec:a346?
 ([2001:b07:6468:f312:9036:7130:d6ec:a346])
 by smtp.gmail.com with ESMTPSA id g8sm52294717wmf.17.2019.07.26.14.50.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 14:50:20 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>, "Oleinik, Alexander" <alxndr@bu.edu>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-8-alxndr@bu.edu>
 <20190726125633.GE25977@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fe918732-c8eb-61b6-b44f-01a47c77e4e5@redhat.com>
Date: Fri, 26 Jul 2019 23:50:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726125633.GE25977@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC 07/19] fuzz: Modify libqtest to directly
 invoke qtest.c
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/07/19 14:56, Stefan Hajnoczi wrote:
> This should use indirection: a function pointer to dispatch to either
> the socket or the internal qtest_process_inbuf() call.
> 
> With a bit of refactoring you can eliminate the #ifdefs and treat the
> socket fd as one backend and direct invocation as another backend.

My suggestion was a bit different (two files), but this also works.  In
fact it can also be combined to have three files:

- one defining libqtest's qtest_init and associated struct of function
pointers

- one defining the fuzzer's qtest_init and associated struct of function
pointers

- one with the remaining libqtest code, modified to use the struct of
function pointers for everything that you're #ifdef-ing here, and a
function qtest_client_init that receives the struct of function pointers
and stores them in QTestState.  The two qtest_init implementations in
the other files just call qtest_client_init.

Paolo

