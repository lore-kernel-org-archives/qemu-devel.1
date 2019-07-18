Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526D7C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 05:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2261B2173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 05:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2261B2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnyXK-0005By-6L
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 01:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55718)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnyX3-0004fT-Kz
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnyX2-0001TL-G8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:00:41 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnyX2-0001S3-AT
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:00:40 -0400
Received: by mail-wr1-f54.google.com with SMTP id z1so27064601wru.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 22:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RhYmwq8h3xMbcd3OR4BevgWqshekCyMwdGzVAgyQOZQ=;
 b=qk8iJuHu1KlqCpc9a69PZBuEMoNEQi6rH4odglYn2g8VgzTtrf57waT+DEZOea6zHU
 pl/CDrHnbpdihbpzblXfH6smv+ZoDMjzEWsB/Jmsk6VzcJqPJM2IrWhO51wbqZzrw6lD
 NMyW5ABeMONbqlabgZwTMRAhfCDnLLYscRZ9llaEchPey6fs2Yf3LK5xPascognF42lO
 swSfQi7+xbVFYHrnwixEQKZjLO0/HV0yHzqjI6PvqquztLCUMZe7xHROaueOzwx0qzo0
 A7wrJMcoS8dbLANs+7tOXg9RqMgHavjJRYA9ZvZGDWYY3S8nn1sTCpmiR5unWxQLnjaa
 /Aow==
X-Gm-Message-State: APjAAAVjG22BImARPxhm7j7WfSpPaXfYo/FXwVI65Y1FGtbdjpLbBUBJ
 bgR7lZSzI0m+GrxrLWFL5rl/sw==
X-Google-Smtp-Source: APXvYqwLv07se88UI5zVemH31RG9YGCo+1/X3vY9UdXheC5lLvwlBs3JIvTa1YGylEH4ifEJn8VDPg==
X-Received: by 2002:adf:c613:: with SMTP id n19mr46572036wrg.109.1563426038974; 
 Wed, 17 Jul 2019 22:00:38 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id o24sm31172467wmh.2.2019.07.17.22.00.37
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 22:00:38 -0700 (PDT)
To: qemu-devel@nongnu.org, no-reply@patchew.org, pbonzini@redhat.com,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <156342034915.10055.15996927583486522727@c4a48874b076>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <413e6326-159c-f84a-ed5c-0918f8dd359c@redhat.com>
Date: Thu, 18 Jul 2019 07:00:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156342034915.10055.15996927583486522727@c4a48874b076>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.54
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: remove unused argument to
 virtio_scsi_common_realize
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-block@

On 7/18/19 5:25 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190717094728.31006-1-pbonzini@redhat.com/
[...]> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu
J=14 NETWORK=1
[...]
> PASS 18 test-bdrv-drain /bdrv-drain/iothread/drain_all
> =================================================================
> ==8106==ERROR: AddressSanitizer: heap-use-after-free on address 0x61200002c7f0 at pc 0x5622ea95c8b6 bp 0x7f174fdb8680 sp 0x7f174fdb8678
> WRITE of size 1 at 0x61200002c7f0 thread T9
> ==8108==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>     #0 0x5622ea95c8b5 in aio_notify /tmp/qemu-test/src/util/async.c:351:9
>     #1 0x5622ea95e4eb in qemu_bh_schedule /tmp/qemu-test/src/util/async.c:167:9
>     #2 0x5622ea9616f0 in aio_co_schedule /tmp/qemu-test/src/util/async.c:464:5
> ---
>   Right alloca redzone:    cb
>   Shadow gap:              cc
> ==8106==ABORTING
> ERROR - too few tests run (expected 39, got 18)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:904: check-unit] Error 1
> make: *** Waiting for unfinished jobs....
[...]
> The full log is available at
> http://patchew.org/logs/20190717094728.31006-1-pbonzini@redhat.com/testing.asan/?type=message.

