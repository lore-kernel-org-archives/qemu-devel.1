Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EDECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686F12084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686F12084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ubuntu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wp1-0007Wy-Ci
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rafaeldtinoco@kernelpath.com>) id 1i7whI-00069I-0N
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rafaeldtinoco@kernelpath.com>) id 1i7whG-0005LX-Fy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:05:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rafaeldtinoco@kernelpath.com>)
 id 1i7whG-0005L1-Av
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:05:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id v11so23945252qto.13
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 00:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FFXSlN20ga+RJGqINNyyLVX7lC9sTWNqyPTOa8+ymJI=;
 b=RP2viqRFxx4z9PCZd2IzQPP/VxQi1tMszTZYLW1iW4zCKIY469/BQ4bHKgvBVEQssC
 qiziE5fskVNSt7VPQDCfOds0rDlDluJ+lNfcEbLYhn7nMfsI4CzkjEKLDEdOjkXdaSW4
 WEowzBDQxudOmgMhJ/SELqDl/2GnG4kc5HmCl4G1HLEArzLVctSTxLmfFeZGvDJ2A8xl
 yjHflyvU8xsTwVTciRE7kTqENm/FJ2v4v7YsPpz8RYeapTM2mwj/vvPzvL1yeQIWOEQx
 SXCZ8NvDOgX7pBr5bm3zIMpZkQiP4Wim4FIESxjLzkf+eCOw5gOeD6ULWySsyTx31R81
 e+sw==
X-Gm-Message-State: APjAAAXRzHxEkbDH9Md/cJSa4BPZEgD0sp5l1uW3uKqhMsS3inRTXf5Z
 HTEvaopY61wXr/FvjtqBzWdHDg==
X-Google-Smtp-Source: APXvYqxoO9mgm7kjXA2IoPM9WyYAJZVGN09G9mLaxqDOsLksa7kqpWBA/GBeHnacs1sdV+gSC87QdA==
X-Received: by 2002:ac8:6d03:: with SMTP id o3mr31938886qtt.97.1568185545412; 
 Wed, 11 Sep 2019 00:05:45 -0700 (PDT)
Received: from [192.168.100.24] ([191.177.180.119])
 by smtp.gmail.com with ESMTPSA id g194sm10716337qke.46.2019.09.11.00.05.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 00:05:45 -0700 (PDT)
From: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
Openpgp: preference=signencrypt
Autocrypt: addr=rafaeldtinoco@ubuntu.com; keydata=
 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
 m+Bc0IpWoGZLnE2VPg==
Message-ID: <c3bf1a4e-4fa7-2c13-35fb-f63429ee39d1@ubuntu.com>
Date: Wed, 11 Sep 2019 04:05:41 -0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cbe46ad6-ef6c-d155-e79a-672182c725ad@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible
 issues
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
Cc: Bug 1805256 <1805256@bugs.launchpad.net>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quick update...

> value INT_MAX (4294967295) seems WRONG for qemu_futex_wait():
> 
> - EV_BUSY, being -1, and passed as an argument qemu_futex_wait(void *,
> unsigned), is a two's complement, making argument into a INT_MAX when
> that's not what is expected (unless I missed something).
> 
> *** If that is the case, unsure if you, Paolo, prefer declaring
> *(QemuEvent)->value as an integer or changing EV_BUSY to "2" would okay
> here ***
> 
> BUG: description:
> https://bugs.launchpad.net/qemu/+bug/1805256/comments/15

I realized this might be intentional, but, still, I tried:

    https://pastebin.ubuntu.com/p/6rkkY6fJdm/

looking for anything that could have misbehaved in arm64 (specially
concerned on casting and type conversions between the functions).

> QUESTION:
> 
> - Should qemu_event_set() check return code from
> qemu_futex_wake()->qemu_futex()->syscall() in order to know if ANY
> waiter was ever woken up ? Maybe even loop until at least 1 is awaken ?

And I also tried:

-    qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
+    while(qemu_futex(pval, FUTEX_WAKE, val, NULL, NULL, 0) == 0)
+        continue;

and it made little difference (took way more time for me to reproduce
the issue though):

"""
(gdb) run
Starting program: /usr/bin/qemu-img convert -f qcow2 -O qcow2
./disk01.ext4.qcow2 ./output.qcow2

[New Thread 0xffffbec5ad90 (LWP 72839)]
[New Thread 0xffffbe459d90 (LWP 72840)]
[New Thread 0xffffbdb57d90 (LWP 72841)]
[New Thread 0xffffacac9d90 (LWP 72859)]
[New Thread 0xffffa7ffed90 (LWP 72860)]
[New Thread 0xffffa77fdd90 (LWP 72861)]
[New Thread 0xffffa6ffcd90 (LWP 72862)]
[New Thread 0xffffa67fbd90 (LWP 72863)]
[New Thread 0xffffa5ffad90 (LWP 72864)]

[Thread 0xffffa5ffad90 (LWP 72864) exited]
[Thread 0xffffa6ffcd90 (LWP 72862) exited]
[Thread 0xffffa77fdd90 (LWP 72861) exited]
[Thread 0xffffbdb57d90 (LWP 72841) exited]
[Thread 0xffffa67fbd90 (LWP 72863) exited]
[Thread 0xffffacac9d90 (LWP 72859) exited]
[Thread 0xffffa7ffed90 (LWP 72860) exited]

<HUNG w/ 3 threads in the stack trace showed before>
"""

All the tasks left are blocked in a system call, so no task left to call
qemu_futex_wake() to unblock thread #2 (in futex()), which would unblock
thread #1 (doing poll() in a pipe with thread #2).

Those 7 threads exit before disk conversion is complete (sometimes in
the beginning, sometimes at the end).

I'll try to check why those tasks exited.

Any thoughts ?

Tks

