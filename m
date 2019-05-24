Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA3C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7749E2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7749E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUF3D-0008N5-L3
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:36:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUEyV-0004yd-Eo
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUEyU-0004bY-G8
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:31:27 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hUEyU-0004Yd-9u
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:31:26 -0400
Received: by mail-wm1-f52.google.com with SMTP id y3so10339178wmm.2
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 11:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kcsqvtHLnyL9plhmd5yKvId8xSVqdKer2Y58bsbd38M=;
	b=tn7pb+U5TqZV+gYQUv+K+vThJ8TMTeMs0mOQyn3QF03lwl1WaQ6bjDyUNHq+akqhGh
	jsUVrENwREKia9pjihWnhu7sQ2NxU/D853VoWgQpBLKj5B2tUILiuAUs0rhdkiOyqUVf
	9BelHEVlquPxiVZJfFUMLRx3PS0g2vsXEZeCm6j1/+9B5zyJClIU6FKtdXh2jGSnroyz
	BcI+WExNx4dxhqYCEfzgNlJn7/uQugBtfc5Zgq1nKL4imOFlIc9BZQyDOVhwh4dr5NIk
	pSd/1GTPTVGUSh5Xkv0n3oCd7exnXcQvP3n7Ti+RNru4FwnBmXiz4M3CSV7ceWhMT6zq
	95TA==
X-Gm-Message-State: APjAAAX430cyT/ktp0BZp17f4YDSg7gxcMSap7YPY+Arim+Kuu67z+dY
	uBQ2svLKnmLZlUHBR0anRSecKQ==
X-Google-Smtp-Source: APXvYqyWBq8luXkCpgF5S+Z8ZOHbs346VzLaqDV+8uCk6CZ76YuUeybEU60Ye62ccJgpyoDUO4tmVA==
X-Received: by 2002:a05:600c:2198:: with SMTP id
	e24mr4313045wme.92.1558722679142; 
	Fri, 24 May 2019 11:31:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4d53:18d:3ffd:370?
	([2001:b07:6468:f312:4d53:18d:3ffd:370])
	by smtp.gmail.com with ESMTPSA id
	v184sm4766737wma.6.2019.05.24.11.31.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 11:31:18 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87woihi1wl.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <564efcce-64ac-0a39-8899-f6b6d6d7984e@redhat.com>
Date: Fri, 24 May 2019 20:31:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87woihi1wl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.52
Subject: Re: [Qemu-devel] qapi/misc.json is too big,
 let's bite off a few chunks
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/05/19 18:14, Markus Armbruster wrote:
> * Machine core (Eduardo, Marcel)
> 
>   query-machines, query-current-machine, 
> 
>   ~60 lines.  Hardly worthwhile from a "let's shrink misc.json" point of
>   view.  Might be worthwhile from a "let's make get_maintainers.pl
>   work".
> 
> * CPUs (Paolo, Richard)
> 
>   query-cpus, query-cpus-fast
> 
>   ~300 lines.  The commands are implemented in cpus.c, which MAINTAINERS
>   covers both under "Main loop" and under "Guest CPU cores (TCG) /
>   Overall".  Neither feels right to me for these QMP commands.
> 
> * NUMA (Eduardo)
> 
>   query-memdev, set-numa-node
> 
>   ~200 lines.

I would move all three of these and add a new entry to MAINTAINERS.

Paoo

