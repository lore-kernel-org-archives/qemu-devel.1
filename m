Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673CDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D91E20758
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 04:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0aFMwnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D91E20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTdSX-0004zS-J5
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 00:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTdQy-0004Vx-KS
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:03:09 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTdQv-0004wB-SI
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:03:08 -0400
Received: by mail-lj1-x244.google.com with SMTP id x16so4928788ljh.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 21:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uR2yRSoFIyQFa85ZmyTeQWbKesy0kogveF0JOmK3HCU=;
 b=G0aFMwnXL3XlqQtltqTo0eoChMRvdBPFzMoicowzO+xAY5WA7wnecLBujcLmZah0k/
 e5mpG2PgiCXI5UV6aPxyJHgp+ak3mHqsIwGNyATLAY9IpyytJ/yv/eUNLEx8n5Z8IWxM
 5Ev81C4+GL/IiR5iIz/ra80OcP7ctuQ69Pj2L7/QrHYXrCEAAle4I31KIYWKOWdz7wXn
 M3HFOt505tL/bufF7RKhxyavqsmuktaYt6aLjMXM2bezAY35bwnHVGu6RsGL9aReXefA
 CUnwlpUOUePqMTfmrge6m16eiA1+eUvlxTaBEHUJphVGNMuBAicVc8kqC269vRlgE0G9
 pD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uR2yRSoFIyQFa85ZmyTeQWbKesy0kogveF0JOmK3HCU=;
 b=LM/AuZf5G6KwJz0hR9ER7njcckcfe+UumSDsH6VHobvmy9eq0olL4qNgeefXTQaTBB
 Qr+BQtayVj8t8Y9ZGU4Qnd6ZHzPhDR+UlbqNBuPjTBKmAhs/apu92hgUFoMAC7GAoOYF
 raPIk6S1tjIxkK1c213A5iITMiu60/uvYItxIodyY9S9colhvP3MUaAqgHUgPB4+ZpVF
 imReSQn9/nL6jdu+ONu2El4syaxLFJWmC1rYy2JiCD5scmlslRssYF4wrpXr8U2yCsmm
 Jc1K69MBFW7Pl2WpdV2aiTXjCbyWgKZ4o3nE7amF9E9flitdTjE6B6FGQwBlBxa/2KwZ
 9ktA==
X-Gm-Message-State: AOAM530TwRfwMOb03E7UD1oxRjOCqxsBvFLiwGl8isFUZgY9ihZdoHnK
 OSwdlDx8oHq+uCJWMaqepAkDQde5uW72qBsgUBz6wg==
X-Google-Smtp-Source: ABdhPJyWM+KuxWSKm+WZakQM1coYpvqzhvFBssVoo8yKJsSvLXOonodEkq1Mrj4Ytt2McNT6VBun6xj6Gc9/hPkEfDk=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr2543467ljh.377.1602907383409; 
 Fri, 16 Oct 2020 21:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
In-Reply-To: <20201017033606.GA14014@1wt.eu>
From: Jann Horn <jannh@google.com>
Date: Sat, 17 Oct 2020 06:02:36 +0200
Message-ID: <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Willy Tarreau <w@1wt.eu>
Cc: "Catangiu, Adrian Costin" <acatan@amazon.com>,
 Andy Lutomirski <luto@kernel.org>, 
 Jason Donenfeld <Jason@zx2c4.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Eric Biggers <ebiggers@kernel.org>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, 
 "Graf (AWS), Alexander" <graf@amazon.de>, "MacCarthaigh,
 Colm" <colmmacc@amazon.com>, 
 "Woodhouse, David" <dwmw@amazon.co.uk>, "bonzini@gnu.org" <bonzini@gnu.org>,
 "Singh, Balbir" <sblbir@amazon.com>, 
 "Weiss, Radu" <raduweis@amazon.com>, "oridgar@gmail.com" <oridgar@gmail.com>, 
 "ghammer@redhat.com" <ghammer@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "mst@redhat.com" <mst@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>,
 Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=jannh@google.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 17, 2020 at 5:36 AM Willy Tarreau <w@1wt.eu> wrote:
> On Sat, Oct 17, 2020 at 03:40:08AM +0200, Jann Horn wrote:
> > [adding some more people who are interested in RNG stuff: Andy, Jason,
> > Theodore, Willy Tarreau, Eric Biggers. also linux-api@, because this
> > concerns some pretty fundamental API stuff related to RNG usage]
> >
> > On Fri, Oct 16, 2020 at 4:33 PM Catangiu, Adrian Costin
> > <acatan@amazon.com> wrote:
> > > This patch is a driver which exposes the Virtual Machine Generation ID
> > > via a char-dev FS interface that provides ID update sync and async
> > > notification, retrieval and confirmation mechanisms:
> > >
> > > When the device is 'open()'ed a copy of the current vm UUID is
> > > associated with the file handle. 'read()' operations block until the
> > > associated UUID is no longer up to date - until HW vm gen id changes -
> > > at which point the new UUID is provided/returned. Nonblocking 'read()'
> > > uses EWOULDBLOCK to signal that there is no _new_ UUID available.
> > >
> > > 'poll()' is implemented to allow polling for UUID updates. Such
> > > updates result in 'EPOLLIN' events.
> > >
> > > Subsequent read()s following a UUID update no longer block, but return
> > > the updated UUID. The application needs to acknowledge the UUID update
> > > by confirming it through a 'write()'.
> > > Only on writing back to the driver the right/latest UUID, will the
> > > driver mark this "watcher" as up to date and remove EPOLLIN status.
> > >
> > > 'mmap()' support allows mapping a single read-only shared page which
> > > will always contain the latest UUID value at offset 0.
> >
> > It would be nicer if that page just contained an incrementing counter,
> > instead of a UUID. It's not like the application cares *what* the UUID
> > changed to, just that it *did* change and all RNGs state now needs to
> > be reseeded from the kernel, right? And an application can't reliably
> > read the entire UUID from the memory mapping anyway, because the VM
> > might be forked in the middle.
> >
> > So I think your kernel driver should detect UUID changes and then turn
> > those into a monotonically incrementing counter. (Probably 64 bits
> > wide?) (That's probably also a little bit faster than comparing an
> > entire UUID.)
>
> I agree with this. Further, I'm observing there is a very common
> confusion between "universally unique" and "random". Randoms are
> needed when seeking unpredictability. A random number generator
> *must* be able to return the same value multiple times in a row
> (though this is rare), otherwise it's not random.
[...]
> If the UUIDs used there are real UUIDs, it could be as simple as
> updating them according to their format, i.e. updating the timestamp,
> and if the timestamp is already the same, just increase the seq counter.
> Doing this doesn't require entropy, doesn't need to block and doesn't
> needlessly leak randoms that sometimes make people feel nervous.

Those UUIDs are supplied by existing hypervisor code; in that regard,
this is almost like a driver for a hardware device. It is written
against a fixed API provided by the underlying machine. Making sure
that the sequence of UUIDs, as seen from inside the machine, never
changes back to a previous one is the responsibility of the hypervisor
and out of scope for this driver.

Microsoft's spec document (which is a .docx file for reasons I don't
understand) actually promises us that it is a cryptographically random
128-bit integer value, which means that if you fork a VM 2^64 times,
the probability that any two of those VMs have the same counter is
2^-64. That should be good enough.

But in userspace, we just need a simple counter. There's no need for
us to worry about anything else, like timestamps or whatever. If we
repeatedly fork a paused VM, the forked VMs will see the same counter
value, but that's totally fine, because the only thing that matters to
userspace is that the counter changes when the VM is forked.

And actually, since the value is a cryptographically random 128-bit
value, I think that we should definitely use it to help reseed the
kernel's RNG, and keep it secret from userspace. That way, even if the
VM image is public, we can ensure that going forward, the kernel RNG
will return securely random data.

