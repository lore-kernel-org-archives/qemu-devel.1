Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7510C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2092622282
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Rleo5KpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2092622282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYm6-0000xQ-Rh
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <compudj@efficios.com>)
 id 1kUYkh-0000Q2-Gr
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:15:19 -0400
Received: from mail.efficios.com ([167.114.26.124]:43036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <compudj@efficios.com>)
 id 1kUYkZ-0002yV-Sm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:15:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AADCB2707BD;
 Mon, 19 Oct 2020 13:15:03 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id QTruwX3BYTn2; Mon, 19 Oct 2020 13:15:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 284FE270752;
 Mon, 19 Oct 2020 13:15:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 284FE270752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1603127703;
 bh=a4Kyq9ggmnqJgL1OMZgiL3YI8Vq7lTIeBQc5QZoN7D4=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=Rleo5KpYLxJL9bE+eS/IDKaOFoEmvkq70bRu+JU0FvBo/l/SmYGCBDQs+xaFOFVHh
 BJLQKLA6tCK8ZaIUWSrsP9eNGLLZGdYFBrCmdjHdnSkKFJRiWBCddq7bINqO1JrS6z
 LiDZeRjCGch2dLFOuXwqHnn+Ivxs2sOrIF5lAwNdQIXqAC1yn7Wcp2M95eK+hTAjh2
 2bA+wXNULdWuS9DpiktZT7bNyAwruDfMklfP+qTv7VM9LXYilPo5xXvaq8H58JbRBX
 xy5xAXA9Jfvdh96AGWs2I075RgU0Y4TmN5l6CqHVGnXdNU7ZWMEVZ3OrX5Vg/g/cFz
 WJ9MFFce5aMuQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id yP-ztTyztNwI; Mon, 19 Oct 2020 13:15:03 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 0FA782707BC;
 Mon, 19 Oct 2020 13:15:03 -0400 (EDT)
Date: Mon, 19 Oct 2020 13:15:02 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andy Lutomirski <luto@kernel.org>
Message-ID: <476895871.28084.1603127702969.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrViTg_BWvRa+nfDWq=_B_ithzL-anVJNpsgHaXe9VgCNQ@mail.gmail.com>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <CALCETrViTg_BWvRa+nfDWq=_B_ithzL-anVJNpsgHaXe9VgCNQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: drivers/virt: vmgenid: add vm generation id driver
Thread-Index: LGqdszkWAp7MsnjacXz6ZDq20p5wzw==
Received-SPF: pass client-ip=167.114.26.124; envelope-from=compudj@efficios.com;
 helo=mail.efficios.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 13:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Jason Donenfeld <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "open list, DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>,
 Jonathan Corbet <corbet@lwn.net>, mst@redhat.com,
 Eric Biggers <ebiggers@kernel.org>, "Singh, Balbir" <sblbir@amazon.com>,
 bonzini@gnu.org, "Graf \(AWS\), Alexander" <graf@amazon.de>,
 Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>,
 oridgar@gmail.com, "Catangiu, Adrian Costin" <acatan@amazon.com>,
 "MacCarthaigh, Colm" <colmmacc@amazon.com>, Theodore Tso <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Willy Tarreau <w@1wt.eu>, "Woodhouse, David" <dwmw@amazon.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- On Oct 17, 2020, at 2:10 PM, Andy Lutomirski luto@kernel.org wrote:

> On Fri, Oct 16, 2020 at 6:40 PM Jann Horn <jannh@google.com> wrote:
>>
>> [adding some more people who are interested in RNG stuff: Andy, Jason,
>> Theodore, Willy Tarreau, Eric Biggers. also linux-api@, because this
>> concerns some pretty fundamental API stuff related to RNG usage]
>>
>> On Fri, Oct 16, 2020 at 4:33 PM Catangiu, Adrian Costin
>> <acatan@amazon.com> wrote:
>> > - Background
>> >
>> > The VM Generation ID is a feature defined by Microsoft (paper:
>> > http://go.microsoft.com/fwlink/?LinkId=260709) and supported by
>> > multiple hypervisor vendors.
>> >
>> > The feature is required in virtualized environments by apps that work
>> > with local copies/caches of world-unique data such as random values,
>> > uuids, monotonically increasing counters, etc.
>> > Such apps can be negatively affected by VM snapshotting when the VM
>> > is either cloned or returned to an earlier point in time.
>> >
>> > The VM Generation ID is a simple concept meant to alleviate the issue
>> > by providing a unique ID that changes each time the VM is restored
>> > from a snapshot. The hw provided UUID value can be used to
>> > differentiate between VMs or different generations of the same VM.
>> >
>> > - Problem
>> >
>> > The VM Generation ID is exposed through an ACPI device by multiple
>> > hypervisor vendors but neither the vendors or upstream Linux have no
>> > default driver for it leaving users to fend for themselves.
>> >
>> > Furthermore, simply finding out about a VM generation change is only
>> > the starting point of a process to renew internal states of possibly
>> > multiple applications across the system. This process could benefit
>> > from a driver that provides an interface through which orchestration
>> > can be easily done.
>> >
>> > - Solution
>> >
>> > This patch is a driver which exposes the Virtual Machine Generation ID
>> > via a char-dev FS interface that provides ID update sync and async
>> > notification, retrieval and confirmation mechanisms:
>> >
>> > When the device is 'open()'ed a copy of the current vm UUID is
>> > associated with the file handle. 'read()' operations block until the
>> > associated UUID is no longer up to date - until HW vm gen id changes -
>> > at which point the new UUID is provided/returned. Nonblocking 'read()'
>> > uses EWOULDBLOCK to signal that there is no _new_ UUID available.
>> >
>> > 'poll()' is implemented to allow polling for UUID updates. Such
>> > updates result in 'EPOLLIN' events.
>> >
>> > Subsequent read()s following a UUID update no longer block, but return
>> > the updated UUID. The application needs to acknowledge the UUID update
>> > by confirming it through a 'write()'.
>> > Only on writing back to the driver the right/latest UUID, will the
>> > driver mark this "watcher" as up to date and remove EPOLLIN status.
>> >
>> > 'mmap()' support allows mapping a single read-only shared page which
>> > will always contain the latest UUID value at offset 0.
>>
>> It would be nicer if that page just contained an incrementing counter,
>> instead of a UUID. It's not like the application cares *what* the UUID
>> changed to, just that it *did* change and all RNGs state now needs to
>> be reseeded from the kernel, right? And an application can't reliably
>> read the entire UUID from the memory mapping anyway, because the VM
>> might be forked in the middle.
>>
>> So I think your kernel driver should detect UUID changes and then turn
>> those into a monotonically incrementing counter. (Probably 64 bits
>> wide?) (That's probably also a little bit faster than comparing an
>> entire UUID.)
>>
>> An option might be to put that counter into the vDSO, instead of a
>> separate VMA; but I don't know how the other folks feel about that.
>> Andy, do you have opinions on this? That way, normal userspace code
>> that uses this infrastructure wouldn't have to mess around with a
>> special device at all. And it'd be usable in seccomp sandboxes and so
>> on without needing special plumbing. And libraries wouldn't have to
>> call open() and mess with file descriptor numbers.
> 
> The vDSO might be annoyingly slow for this.  Something like the rseq
> page might make sense.  It could be a generic indication of "system
> went through some form of suspend".

This might indeed fit nicely as an extension of my KTLS prototype (extensible rseq):

https://lore.kernel.org/lkml/20200925181518.4141-1-mathieu.desnoyers@efficios.com/

There are a few ways we could wire things up. One might be to add the
UUID field into the extended KTLS structure (so it's always updated after it
changes on next return to user-space). For this I assume that the Linux scheduler
within the guest VM always preempts all threads before a VM is suspended (is that
indeed true ?).

This leads to one important question though: how is the UUID check vs commit operation
made atomic with respect to suspend ? Unless we use rseq critical sections in assembly,
where the kernel will abort the rseq critical section on preemption, I don't see how we
can ensure that the UUID value does not change right after it has been checked, before
the "commit" side-effect. And what is the expected "commit" side-effect ? Is it a store
to a variable in user-space memory, or is it issuing a system call which sends a packet over
the network ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

