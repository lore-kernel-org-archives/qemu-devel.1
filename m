Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1444C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 18:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9364F20833
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 18:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9364F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDvpd-0005BO-RK
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 14:50:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvoq-0004nN-B7
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvoo-0005h3-DU
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:50:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDvoh-0005eD-Fl
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:49:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so22290147wrp.0
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fZVF41ArWJMEn1HhbIQjaVKi7q24TLqnU2Akrk5tKe8=;
	b=DwxtqUACDGxJ0HJrOSlDZm7fDQNqfEjj9Hodldv/TP/KzxjY7z8HIujZ3Qv49P3sOd
	hVX2Bz8kcAap9QLCekT7mWIm1qdVsTVxFcaKYO95t8oyNIjW/XHtqr2ya6+rrhJ/wPqx
	TRKMmlPQU4YGvoU92zxBWPnz4GbIgtbizeC5koFUYlAR5cyUoEUUGITRkwP6VQTSixjR
	BSRD3CxrFXSlylddYlbsGYckT5GsHwEuILKfjGy5X7FcV8rtDmUJJLcxSTqqgXOUxDmZ
	ebKuIDMsraXn3FyVE0qIbmSsPazxwR5TN3hsNz50vzZ/ta6CNw2rPBJRKITAp9q8Ij4l
	m5Aw==
X-Gm-Message-State: APjAAAXpNJLuAWcN3P5nEWKOqYJQZplX2n2yaKvuyB8kQkWS0gRob3H2
	Zj/xt5O9E3lvAmnADsFIypLyAw==
X-Google-Smtp-Source: APXvYqyom94nTh/NymDM7iN1denCxEstsGGVKN1f+g/qzRqIcC3sYKm424VGOMU27vTMyyngeTQ+vQ==
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr14509373wrn.270.1554835790412; 
	Tue, 09 Apr 2019 11:49:50 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z14sm51907222wrv.78.2019.04.09.11.49.49
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 11:49:49 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190409151830.6024-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <585e8815-9c3c-d532-c32b-02bab712c315@redhat.com>
Date: Tue, 9 Apr 2019 20:49:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409151830.6024-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.0] migration/ram.c: Fix
 use-after-free in multifd_recv_unfill_packet()
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409184948.b3u-tbbY3nVgN7ZKkvruohwgkvMqOJ3V22pRO3FpCkE@z>

On 4/9/19 5:18 PM, Peter Maydell wrote:
> Coverity points out (CID 1400442) that in this code:
> 
>     if (packet->pages_alloc > p->pages->allocated) {
>         multifd_pages_clear(p->pages);
>         multifd_pages_init(packet->pages_alloc);
>     }
> 
> we free p->pages in multifd_pages_clear() but continue to
> use it in the following code. We also leak memory, because
> multifd_pages_init() returns the pointer to a new MultiFDPages_t
> struct but we are ignoring its return value.
> 
> Fix both of these bugs by adding the missing assignment of
> the newly created struct to p->pages.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> I don't know anything about the multifd code, but this seems like
> the obvious fix based on looking at what the clear and init
> functions are doing. I have only run 'make check' on this,
> so review and testing definitely in order. I think we should
> really put this into 4.0, which means ideally I'd like to
> commit it to master today or tomorrow, though...
> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index f68beeeeffc..1ca9ba77b6a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -851,7 +851,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>       */
>      if (packet->pages_alloc > p->pages->allocated) {
>          multifd_pages_clear(p->pages);
> -        multifd_pages_init(packet->pages_alloc);
> +        p->pages = multifd_pages_init(packet->pages_alloc);
>      }
>  
>      p->pages->used = be32_to_cpu(packet->pages_used);
> 

