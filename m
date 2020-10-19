Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3992231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iA8HNFoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3992231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWhp-0007Ql-73
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kUWel-0005eL-3S
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kUWed-0001CV-Sj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603119653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eeEwkWd2inwelOxnZFWrV6qJ4loEm7oC47tsgU5zrNE=;
 b=iA8HNFocT1/DkBga57FL/R8kedhw7xfgit+abZdmC0wkt7fqZrEsVKh4/Xj8Y48AyqxoVf
 6KnmXMwx6f/Q2yjJjUUeSylDIOOC1csSEdDgS848zWe0eavhXxJ/z1ksHfsrHsCNBZxR83
 3Fefa4962dSXPR2sxcVveSEm5L+7s6o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-gEySVzTQNgWs78SB8_3Iwg-1; Mon, 19 Oct 2020 11:00:52 -0400
X-MC-Unique: gEySVzTQNgWs78SB8_3Iwg-1
Received: by mail-wr1-f71.google.com with SMTP id p6so7473375wrm.23
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eeEwkWd2inwelOxnZFWrV6qJ4loEm7oC47tsgU5zrNE=;
 b=oT6vvnhC9yPom7UREKAE9oQVcjZF81BujF7WQPwtknXKOx1JMl8Nl1fEdDNHHUWZ0K
 7Az5v7CNraUiUYTx2AwM7i4ArjoZjwaOmtDn84sup6H/NcNIS00gE86yNvheBYsBxUp8
 d2IiCatXFh3dqOlyHzLkyLzCzs/0M5qgf4p2z6A1Riy4wS+RtyCVzxyaHTYOytOvo4Nt
 s66/8nDrlTY1uVoQwGOfcAQs4wqpfe306UkTUMgbj0dOSqKnm+u5uYglV/odWfaGJRfv
 godJBbqx4Cwivc8Ke5Ma+xt0d7aGMKmOqNDBY0jEo7t3VPs9JM3uIDRKIhbtV08Zcvam
 YLYw==
X-Gm-Message-State: AOAM532aP1lgi3U/rfQ4BNzcDN0dalkMl3jW7ffNUspga22wC5lGMu2z
 ivbR8Ngui5UiYzBKQ494goP8nmHVJ3BnjgVhM/aBW7hV30KkU2t+cOifGjLihxO4RBp5i68Lxwh
 9eDhQ2/PH0x/js2Y=
X-Received: by 2002:a7b:c081:: with SMTP id r1mr17940616wmh.158.1603119650859; 
 Mon, 19 Oct 2020 08:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1K7foO6zAsERSnzDbqpvWg8Yzks+2b30SB3/GCrweUhcJIelqhNOTssKhNwAEMU36/iuvgw==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr17940572wmh.158.1603119650551; 
 Mon, 19 Oct 2020 08:00:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id e15sm8898wro.13.2020.10.19.08.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:00:49 -0700 (PDT)
Date: Mon, 19 Oct 2020 11:00:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201019105118-mutt-send-email-mst@kernel.org>
References: <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <20201018114625-mutt-send-email-mst@kernel.org>
 <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
 <20201018115524-mutt-send-email-mst@kernel.org>
 <CALCETrUeRAhmEFR6EFXz8HzDYd2doZ2TMyZmu1pU_-yAPA6KDw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALCETrUeRAhmEFR6EFXz8HzDYd2doZ2TMyZmu1pU_-yAPA6KDw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Colm MacCarthaigh <colmmacc@amazon.com>,
 Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, "Singh, Balbir" <sblbir@amazon.com>,
 bonzini@gnu.org, "Graf \(AWS\), Alexander" <graf@amazon.de>,
 Jann Horn <jannh@google.com>, oridgar@gmail.com, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Michal Hocko <mhocko@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, Willy Tarreau <w@1wt.eu>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 18, 2020 at 09:14:00AM -0700, Andy Lutomirski wrote:
> On Sun, Oct 18, 2020 at 8:59 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Oct 18, 2020 at 08:54:36AM -0700, Andy Lutomirski wrote:
> > > On Sun, Oct 18, 2020 at 8:52 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Sat, Oct 17, 2020 at 03:24:08PM +0200, Jason A. Donenfeld wrote:
> > > > > 4c. The guest kernel maintains an array of physical addresses that are
> > > > > MADV_WIPEONFORK. The hypervisor knows about this array and its
> > > > > location through whatever protocol, and before resuming a
> > > > > moved/snapshotted/duplicated VM, it takes the responsibility for
> > > > > memzeroing this memory. The huge pro here would be that this
> > > > > eliminates all races, and reduces complexity quite a bit, because the
> > > > > hypervisor can perfectly synchronize its bringup (and SMP bringup)
> > > > > with this, and it can even optimize things like on-disk memory
> > > > > snapshots to simply not write out those pages to disk.
> > > > >
> > > > > A 4c-like approach seems like it'd be a lot of bang for the buck -- we
> > > > > reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
> > > > > userspace API to deal with, and it'd be race free, and eliminate a lot
> > > > > of kernel complexity.
> > > >
> > > > Clearly this has a chance to break applications, right?
> > > > If there's an app that uses this as a non-system-calls way
> > > > to find out whether there was a fork, it will break
> > > > when wipe triggers without a fork ...
> > > > For example, imagine:
> > > >
> > > > MADV_WIPEONFORK
> > > > copy secret data to MADV_DONTFORK
> > > > fork
> > > >
> > > >
> > > > used to work, with this change it gets 0s instead of the secret data.
> > > >
> > > >
> > > > I am also not sure it's wise to expose each guest process
> > > > to the hypervisor like this. E.g. each process needs a
> > > > guest physical address of its own then. This is a finite resource.
> > > >
> > > >
> > > > The mmap interface proposed here is somewhat baroque, but it is
> > > > certainly simple to implement ...
> > >
> > > Wipe of fork/vmgenid/whatever could end up being much more problematic
> > > than it naively appears -- it could be wiped in the middle of a read.
> > > Either the API needs to handle this cleanly, or we need something more
> > > aggressive like signal-on-fork.
> > >
> > > --Andy
> >
> >
> > Right, it's not on fork, it's actually when process is snapshotted.
> >
> > If we assume it's CRIU we care about, then I
> > wonder what's wrong with something like
> > MADV_CHANGEONPTRACE_SEIZE
> > and basically say it's X bytes which change the value...
> 
> I feel like we may be approaching this from the wrong end.  Rather
> than saying "what data structure can the kernel expose that might
> plausibly be useful", how about we try identifying some specific
> userspace needs and see what a good solution could look like.  I can
> identify two major cryptographic use cases:

Well, I'm aware of a non-cryptographic use-case:
https://bugzilla.redhat.com/show_bug.cgi?id=1118834

this seems to just ask for the guest to have a way to detect that
a VM cloning triggered.


-- 
MST


