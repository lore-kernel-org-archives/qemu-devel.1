Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD4CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F702332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F702332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LqA-0005xe-M3
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0LpU-0005Wb-EY
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0LpQ-0003W2-Sd
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:18:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0LpP-0003UO-7t
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:18:47 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4021810F09
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:18:46 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j16so867809wrn.5
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 01:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D4+CKsrsLflonCm5BXM+OBN8W4oYe7A0ZqjtWZstR1I=;
 b=KDHqIeHzMIv9rddS+BJVn0oY11mi4VrbXj4+R8CLr1eGyrYrKkG8V0X/PG8OuOSOkU
 HtNhFJyeyw2O97WoRewsBYHgp69KUYcMcAerfCEW8F/mDlFCCCRqOKmj5sv4NRYxzjg2
 jcVPDEGXC1K2zV+0ZaGadJRTEBqfVzWJTVKDMNA0cXJGnncPWwVXDfaBMoiiPOA8Yb5D
 8zmrbRXm+P1Lepd5EjQmuFaWvRQGpcenZLgM8D27xiS9kx5+bwoeKOQpMQD7pOkAlvLI
 1haGIXRplgg1jW+QO0ONSImZqHEQKkO0xPdcJIDhpkvbo3hXdb/6lJhNksR1BBJGKJaq
 Y2dw==
X-Gm-Message-State: APjAAAXZy22xmKTJebGXbsmLD47VzwpCKltJI09e6r5+BMLt1YTDhNIh
 kCKpCpoYcvR4WR9cYMkqMTDpEfm5CD7OrHSotzgEeRl3J3rFkp3XItg6WuBrlasv3D8UY+OOoHz
 nnfr/+pEX0XqKHvk=
X-Received: by 2002:adf:f042:: with SMTP id t2mr38925456wro.139.1566375524917; 
 Wed, 21 Aug 2019 01:18:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzx60lDyD/Bn2p028K5sXOzRZtI3Pyme36yZcvWoPCrJlUv/U011zGFHmAa5CDylfHOYlgYpw==
X-Received: by 2002:adf:f042:: with SMTP id t2mr38925420wro.139.1566375524646; 
 Wed, 21 Aug 2019 01:18:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0?
 ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id q124sm2286274wma.33.2019.08.21.01.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 01:18:44 -0700 (PDT)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <1565625509-404969-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4883fb10-5863-f260-5698-90b3a5e0a00c@redhat.com>
Date: Wed, 21 Aug 2019 10:18:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565625509-404969-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/2] char-socket: Fix race condition
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
Cc: den@openvz.org, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com,
 berrange@redhat.com, berto@igalia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/08/19 17:58, Andrey Shinkevich wrote:
> This fixes a race condition in which the tcp_chr_read() ioc handler
> can close a connection that is being written to from another thread.
> 
> v4:
>     The functions qemu_idle_add() and tcp_chr_be_event_closed() were removed
>     because the callback is invoked after the call to object_property_del_all()
>     so, the "chardev" object had been deleted and the segmentation fault occurs.
>     Let's please apply the Alberto's simplified series to avoid the race condition.
> 
> v3:
>     See the email thread with the Message ID
>     <cover.1550842915.git.berto@igalia.com>
> 
> Alberto Garcia (2):
>   main-loop: Fix GSource leak in qio_task_thread_worker()
>   char-socket: Lock tcp_chr_disconnect()
> 
>  chardev/char-socket.c | 16 +++++++++++++---
>  io/task.c             |  1 +
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 

Queued, thanks.

Paolo

