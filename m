Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E37C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDAA2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDAA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD4P2-0006Ll-P1
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 06:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iD4O7-0005iC-Iq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iD4O5-00059F-S7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:19:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iD4O5-00058S-K8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:19:09 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C81589AC6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 10:19:07 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c188so1733713wmd.9
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 03:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K+rttGEecpHbq8Ld8mEd0xixgNyYzjAcykoYhYhc6C0=;
 b=ekc0G4DMlTWftgQNJnTlSrWsiUtvN7du32QEO93KZ5ViEizncsGF6YFKoByKeUD0hQ
 YV4QyWU3WU4cFKlqSSaf1yJ28GCOh5jzZns0e6fADYT1m20Vc3li1EnaSN5GWmpvqSN+
 x4OuZE3z4jLvsXQdwIrxGSQac3bIpvTnLMJXBlKZCUidGqSgEHT4Jbv7Can6EQhZMMti
 hH6lIgduMptUS+0Z5s/h7t07If3w4q7pZlWFHwWz64mGHUMVkIwB1PtQkuScZdlzgQYV
 Uh7qyZkICN+VOJDEFiUXoJh1ulTEk3/st78huIHUrU8iR43f22s6Rb4+Cs/jPq90xznL
 u5dA==
X-Gm-Message-State: APjAAAWs66eVmjTgYbSlml8mnB+hpJHLc2hQm0r/lsn+5tp1cALvEeii
 +NzM/+LpxkWRcg+usMUaZuiZ4fhTok4HdjDUQjcFCpjpNuDgnC4mD0uoNaT55yYhlBe+9qn2+uh
 6pjhnaD7n1KOBkvI=
X-Received: by 2002:adf:e849:: with SMTP id d9mr8437369wrn.358.1569406745825; 
 Wed, 25 Sep 2019 03:19:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwrvUr0qgn78HfJeD5ClbslLh48/3q2qowypmAsSIjSUOTWOFeFBhLzjofRh50aKkErmgHVsw==
X-Received: by 2002:adf:e849:: with SMTP id d9mr8437343wrn.358.1569406745538; 
 Wed, 25 Sep 2019 03:19:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id z3sm2871366wmi.30.2019.09.25.03.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 03:19:05 -0700 (PDT)
Subject: when to use virtio (was Re: [PATCH v4 0/8] Introduce the microvm
 machine type)
To: David Hildenbrand <david@redhat.com>, Sergio Lopez <slp@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com> <87h850ssnb.fsf@redhat.com>
 <b361be48-d490-ac6a-4b54-d977c20539c0@redhat.com>
 <231f9f20-ae88-c46b-44da-20b610420e0c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <77a157c4-5f43-5c70-981c-20e5a31a4dd1@redhat.com>
Date: Wed, 25 Sep 2019 12:19:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <231f9f20-ae88-c46b-44da-20b610420e0c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Pankaj Gupta <pagupta@redhat.com>, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, lersek@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a tangent, but I was a bit too harsh in my previous message (at
least it made you laugh rather than angry!) so I think I owe you an
explanation.

On 25/09/19 10:44, David Hildenbrand wrote:
> I consider virtio the silver bullet whenever we want a mature
> paravirtualized interface across architectures. And you can tell that
> I'm not the only one by the huge amount of virtio device people are
> crafting right now.

Given there are hardware implementation of virtio, I would refine that:
virtio is a silver bullet whenever we want a mature ring buffer
interface across architectures.  Being friendly to virtualization is by
now only a detail of virtio.  It is also not exclusive to virtio, for
example NVMe 1.3 has incorporated some ideas from Xen and virtio and is
also virtualization-friendly.

In turn, the ring buffer interface is great if you want to have mostly
asynchronous operation---if not, the ring buffer is just adding
complexity.  Sure, we have the luxury of abstractions and powerful
computers that hide most of the complexity, but some of it still lurks
in the form of race conditions.

So the question for virtio-mem is what makes asynchronous operation
important for memory hotplug?  If I understand the virtio-mem driver,
all interaction with the virtio device happens through a work item,
meaning that it is strictly synchronous.  At this point, you do not need
a ring buffer, you only need:

- a command register where you write the address of a command buffer.
The device will do DMA from the command block, do whatever it has to do,
DMA back the results, and trigger an interrupt.

- an interrupt mechanism.  It could be MSI, or it could be an interrupt
pending/interrupt acknowledge register if all the hardware offers is
level-triggered interrupts.

I do agree that virtio-mem's command buffer/DMA architecture is better
than the more traditional "bunch of hardware registers" architecture
that QEMU uses for its ACPI-based CPU and memory hotplug controllers.
But that's because command buffer/DMA is what actually defines a good
paravirtualized interface; virtio is a superset of that that may not be
always a good solution.

Paolo

