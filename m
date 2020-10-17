Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F35E2068E
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 18:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="THGcrhra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F35E2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTqhF-0005GT-HR
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 14:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luto@kernel.org>) id 1kTqfI-0003Ei-91
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 14:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luto@kernel.org>) id 1kTqfE-0005Rh-9O
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 14:10:47 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8AE48212CC
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602958239;
 bh=bNUjXzAtYTeF0xeyT4fVDlewqtbmx5JXgMhZlub6oWs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=THGcrhra0XvZn4Ey1MGpMDVxtKDNQHgmX2j9JxAUeoHswlBA6Cnm/zT4hTZODIzHR
 GIAP9ZD/E/9dmpMs96WF1G45M6M/NevjFPyBmIiwND5y72ADgjpFd1WGLuu3J/se7p
 O3hmHiqDp9e1W5jgnKbn1xURn1TnVQtFlfaePNuA=
Received: by mail-wm1-f49.google.com with SMTP id a72so6474498wme.5
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 11:10:39 -0700 (PDT)
X-Gm-Message-State: AOAM530HUxsYPSJNMzyU9ztsCFRIWssrtd3FT8ntzcR1hSSp2gc2K01g
 hQacFzfRoKpKg2mEZe15u14F7kWO4EGLu7ZhheUPBA==
X-Google-Smtp-Source: ABdhPJytCiWOtxm84RCgZCVoArKJ0KdKOuxfgPiMKVnnwQm0gaac8Rg/0NC502KkEJ0/X88L4LXO8HEf81QzCgT9VjQ=
X-Received: by 2002:a1c:6457:: with SMTP id y84mr9330642wmb.36.1602958237946; 
 Sat, 17 Oct 2020 11:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
In-Reply-To: <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 17 Oct 2020 11:10:26 -0700
X-Gmail-Original-Message-ID: <CALCETrViTg_BWvRa+nfDWq=_B_ithzL-anVJNpsgHaXe9VgCNQ@mail.gmail.com>
Message-ID: <CALCETrViTg_BWvRa+nfDWq=_B_ithzL-anVJNpsgHaXe9VgCNQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Jann Horn <jannh@google.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=198.145.29.99; envelope-from=luto@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 14:10:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "ghammer@redhat.com" <ghammer@redhat.com>, "Weiss, Radu" <raduweis@amazon.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>,
 "corbet@lwn.net" <corbet@lwn.net>, "mst@redhat.com" <mst@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Singh, Balbir" <sblbir@amazon.com>,
 "bonzini@gnu.org" <bonzini@gnu.org>, "Graf \(AWS\),
 Alexander" <graf@amazon.de>, Michal Hocko <mhocko@kernel.org>,
 "oridgar@gmail.com" <oridgar@gmail.com>, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 "MacCarthaigh, Colm" <colmmacc@amazon.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Willy Tarreau <w@1wt.eu>, "Woodhouse, David" <dwmw@amazon.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 6:40 PM Jann Horn <jannh@google.com> wrote:
>
> [adding some more people who are interested in RNG stuff: Andy, Jason,
> Theodore, Willy Tarreau, Eric Biggers. also linux-api@, because this
> concerns some pretty fundamental API stuff related to RNG usage]
>
> On Fri, Oct 16, 2020 at 4:33 PM Catangiu, Adrian Costin
> <acatan@amazon.com> wrote:
> > - Background
> >
> > The VM Generation ID is a feature defined by Microsoft (paper:
> > http://go.microsoft.com/fwlink/?LinkId=260709) and supported by
> > multiple hypervisor vendors.
> >
> > The feature is required in virtualized environments by apps that work
> > with local copies/caches of world-unique data such as random values,
> > uuids, monotonically increasing counters, etc.
> > Such apps can be negatively affected by VM snapshotting when the VM
> > is either cloned or returned to an earlier point in time.
> >
> > The VM Generation ID is a simple concept meant to alleviate the issue
> > by providing a unique ID that changes each time the VM is restored
> > from a snapshot. The hw provided UUID value can be used to
> > differentiate between VMs or different generations of the same VM.
> >
> > - Problem
> >
> > The VM Generation ID is exposed through an ACPI device by multiple
> > hypervisor vendors but neither the vendors or upstream Linux have no
> > default driver for it leaving users to fend for themselves.
> >
> > Furthermore, simply finding out about a VM generation change is only
> > the starting point of a process to renew internal states of possibly
> > multiple applications across the system. This process could benefit
> > from a driver that provides an interface through which orchestration
> > can be easily done.
> >
> > - Solution
> >
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
>
> An option might be to put that counter into the vDSO, instead of a
> separate VMA; but I don't know how the other folks feel about that.
> Andy, do you have opinions on this? That way, normal userspace code
> that uses this infrastructure wouldn't have to mess around with a
> special device at all. And it'd be usable in seccomp sandboxes and so
> on without needing special plumbing. And libraries wouldn't have to
> call open() and mess with file descriptor numbers.

The vDSO might be annoyingly slow for this.  Something like the rseq
page might make sense.  It could be a generic indication of "system
went through some form of suspend".

