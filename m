Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EA32073A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EA32073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTfi5-0002hU-9K
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 02:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w@1wt.eu>) id 1kTd1k-0000OV-0b
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 23:37:04 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43805 helo=1wt.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1) (envelope-from <w@1wt.eu>)
 id 1kTd1h-0004Nw-Ts
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 23:37:03 -0400
Received: (from willy@localhost)
 by pcw.home.local (8.15.2/8.15.2/Submit) id 09H3a6p1014024;
 Sat, 17 Oct 2020 05:36:06 +0200
Date: Sat, 17 Oct 2020 05:36:06 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201017033606.GA14014@1wt.eu>
References: <AQHWo8lIfZnFKGe8nkGmhTCXwq5R3w==>
 <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Received-SPF: pass client-ip=62.212.114.60; envelope-from=w@1wt.eu; helo=1wt.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 23:36:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 17 Oct 2020 02:27:08 -0400
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
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "ghammer@redhat.com" <ghammer@redhat.com>, "Weiss, Radu" <raduweis@amazon.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>,
 "MacCarthaigh, Colm" <colmmacc@amazon.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "mst@redhat.com" <mst@redhat.com>, Eric Biggers <ebiggers@kernel.org>, "Singh,
 Balbir" <sblbir@amazon.com>, "bonzini@gnu.org" <bonzini@gnu.org>,
 "Graf \(AWS\), Alexander" <graf@amazon.de>,
 "oridgar@gmail.com" <oridgar@gmail.com>, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 17, 2020 at 03:40:08AM +0200, Jann Horn wrote:
> [adding some more people who are interested in RNG stuff: Andy, Jason,
> Theodore, Willy Tarreau, Eric Biggers. also linux-api@, because this
> concerns some pretty fundamental API stuff related to RNG usage]
> 
> On Fri, Oct 16, 2020 at 4:33 PM Catangiu, Adrian Costin
> <acatan@amazon.com> wrote:
> > This patch is a driver which exposes the Virtual Machine Generation ID
> > via a char-dev FS interface that provides ID update sync and async
> > notification, retrieval and confirmation mechanisms:
> >
> > When the device is 'open()'ed a copy of the current vm UUID is
> > associated with the file handle. 'read()' operations block until the
> > associated UUID is no longer up to date - until HW vm gen id changes -
> > at which point the new UUID is provided/returned. Nonblocking 'read()'
> > uses EWOULDBLOCK to signal that there is no _new_ UUID available.
> >
> > 'poll()' is implemented to allow polling for UUID updates. Such
> > updates result in 'EPOLLIN' events.
> >
> > Subsequent read()s following a UUID update no longer block, but return
> > the updated UUID. The application needs to acknowledge the UUID update
> > by confirming it through a 'write()'.
> > Only on writing back to the driver the right/latest UUID, will the
> > driver mark this "watcher" as up to date and remove EPOLLIN status.
> >
> > 'mmap()' support allows mapping a single read-only shared page which
> > will always contain the latest UUID value at offset 0.
> 
> It would be nicer if that page just contained an incrementing counter,
> instead of a UUID. It's not like the application cares *what* the UUID
> changed to, just that it *did* change and all RNGs state now needs to
> be reseeded from the kernel, right? And an application can't reliably
> read the entire UUID from the memory mapping anyway, because the VM
> might be forked in the middle.
> 
> So I think your kernel driver should detect UUID changes and then turn
> those into a monotonically incrementing counter. (Probably 64 bits
> wide?) (That's probably also a little bit faster than comparing an
> entire UUID.)

I agree with this. Further, I'm observing there is a very common
confusion between "universally unique" and "random". Randoms are
needed when seeking unpredictability. A random number generator
*must* be able to return the same value multiple times in a row
(though this is rare), otherwise it's not random.

To illustrate this, a die has less than 3 bits of randomness and
is sufficient to play games with friends where a counter would allow
everyone to cheat. Conversely if you want to assign IDs to members
of your family you'd rather use a counter than a die for this or
you risk collisions and/or long series of retries to pick unique
IDs.

RFC4122 explains in great length how to produce guaranteed unique
IDs, and this only involves space, time and counters. There's
indeed a lazy variant that probably everyone uses nowadays,
consisting in picking random numbers, but this is not guaranteed
unique anymore.

If the UUIDs used there are real UUIDs, it could be as simple as
updating them according to their format, i.e. updating the timestamp,
and if the timestamp is already the same, just increase the seq counter.
Doing this doesn't require entropy, doesn't need to block and doesn't
needlessly leak randoms that sometimes make people feel nervous.

Just my two cents,
Willy

