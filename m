Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6105FC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 03:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8CC2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 03:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8CC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM2Rw-0004PH-3b
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 23:31:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hM2RB-00048G-9t
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hM2R9-0004zY-SA
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:31:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hM2R9-0004D2-J2
	for qemu-devel@nongnu.org; Wed, 01 May 2019 23:31:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so1121720wrb.9
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 20:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=PqM83i6/Me1T/RJcawSQAsaO+U8vHGIpd9Qe6tOZgWk=;
	b=q0WUFHuGzOvxtCbm2DFCYWjtr4mPphVIiHdyZIOHQjxuYzd0quNlhVnZVsudrZ1YUL
	wNrs9ObZzq4IYUPdsb4YQf8rSPIJoIJm5KayJOM90W6QXWecSxRyQoSQTCm2wEo3oAFY
	o5+Z6m1oC8P3TujLDNbFcHnqzEqYiJbZD2G+7uZJ6nvmUTR4/7YLK7p7sFlYhaRe+h6R
	dc9nEt2jab/edIqjHLc98vRfoubuoyR8UCM2CYfp6oLvoaYISdK4OgDo1GRmfTbrAPpE
	IT8hxrqJp45LTR83f47GeaJb8YRVaB2XKmkcDtWZg0TqNNTF/e2P2OHvjA6sD4mKUciD
	HPTg==
X-Gm-Message-State: APjAAAVUJoLbMtWGeff9NA6utdEGllJ6Qun4o1ATwUMtKH+i3h7xASk/
	LAupv06WQj6MAIUOx5A9MnIHug==
X-Google-Smtp-Source: APXvYqwJbmDsLcwWDkCsYQuVRc9v8UqdAsiFX5p5FPLr4MItur2cJUzYhHUpTfhXBbW7/O4DiAXRqA==
X-Received: by 2002:adf:ef8c:: with SMTP id d12mr947703wro.320.1556767764989; 
	Wed, 01 May 2019 20:29:24 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id o6sm3886938wrh.55.2019.05.01.20.29.23
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 20:29:23 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20190425145420.8888-1-stefanha@redhat.com>
	<CAJ+F1CLYjF8SQv0v8c-hfbPcFYgZdg1P-MVeB8nS_AXTy4eMDA@mail.gmail.com>
	<20190501170647.GC22391@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7d652656-121a-ca3d-0bc8-31638f0144ac@redhat.com>
Date: Thu, 2 May 2019 05:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501170647.GC22391@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502032922.djVkAJkKZRC72GzBkacnrBYfPCEx2_n6BEkSlRAWXNQ@z>

On 5/1/19 7:06 PM, Stefan Hajnoczi wrote:
> On Tue, Apr 30, 2019 at 04:53:08PM +0200, Marc-André Lureau wrote:
>> Hi
>>
>> On Thu, Apr 25, 2019 at 4:54 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>
>>> qemu.org hosts git repository mirrors of all submodules.  Update
>>> .gitmodules to use the mirrors and not the upstream repositories.
>>>
>>> Mirroring upstream repositories ensures that QEMU continues to build
>>> even when upstream repositories are deleted or temporarily offline.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Stefan, do you prepare a pullreq?
> 
> This patch isn't within the scope of my block or tracing trees.

Peter often applies those patches directly, see:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02073.html

> 
> Perhaps Peter is willing to apply it?
> 
> Stefan
> 

