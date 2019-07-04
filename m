Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF02C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94ADC2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94ADC2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiz5a-0002gQ-2n
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 06:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiz44-0001sU-J5
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiz41-0004ph-Hg
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:34:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41343)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiz3x-0004mr-LI
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:34:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so6046085wrm.8
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 03:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JecvzOILnil/5Py/J52CW2xh+6hPJhjlC3JAJqNvav0=;
 b=o6V7AhrKLyIqR1H6gfF6fa/I0YD1XJiA4zXtKXxU5eH1EFcfK2kN6ZpMfrBsY+/2S0
 IfWsY2FpAQq0NLRP0bbWRvOIdtevEIgOIbaxqAo6j2jWuTndftaP17sOyhmKX8KVH7MP
 yQ3lI5YOB99cCdI8tX9EgqJPKh8rVQ+k2a6f0l7lnswABy692qwsOUv6lJMd2hVlBdir
 ZW7v7j93M6srsS+fZ/D8O9hZN0mSIIAgad8tmCIOK/SCZJCqieXOxLFxSBGxvoFnxpq3
 6cN9gbJygskYfrkEWekajyocvshQ/1KkLp9h0SVqUnhklgG7fSy71jfKMJbXGyyytJPs
 GfCg==
X-Gm-Message-State: APjAAAXWrayqwdm5Vh3bouRIY6P2gEcbxIJRGwJdgIsnabwiuWFCBixZ
 ae0AQ41WwqnrRo44cXG4nvlGrhNPXjc=
X-Google-Smtp-Source: APXvYqzfLxK7XE3wwIL/E08m/VYLxtj+i0nfSs3GUQ4biCskWOkcZf2I/QdTUTd+TqIRyaaR7vVxkA==
X-Received: by 2002:adf:f186:: with SMTP id h6mr15765369wro.274.1562236440503; 
 Thu, 04 Jul 2019 03:34:00 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id 18sm4829527wmg.43.2019.07.04.03.33.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 03:33:59 -0700 (PDT)
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
References: <20190626122042.7656-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <dfa56995-6a66-1aeb-4461-fb2919e8b699@redhat.com>
Date: Thu, 4 Jul 2019 12:33:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626122042.7656-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 0/2] hw/timer/m48t59: Convert to trace
 events
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 6/26/19 2:20 PM, Philippe Mathieu-Daudé wrote:
> Another trivial cleanup series.
> 
> Philippe Mathieu-Daudé (2):
>   MAINTAINERS: Add missing m48t59 files to the PReP section
>   hw/timer/m48t59: Convert debug printf()s to trace events
> 
>  MAINTAINERS                |  2 ++
>  hw/timer/m48t59-internal.h |  5 -----
>  hw/timer/m48t59.c          | 11 +++++------
>  hw/timer/trace-events      |  6 ++++++
>  4 files changed, 13 insertions(+), 11 deletions(-)
> 

