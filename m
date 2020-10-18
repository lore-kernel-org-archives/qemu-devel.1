Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA883C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 15:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7562072D
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 15:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXW2s2cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7562072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUAzj-0005dE-9l
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 11:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kUAyp-0005CF-Cl
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 11:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kUAym-0003O9-Jw
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 11:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603036335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=98NF5I6kW3PEIcXhLOKqmMDjTo2gmlFaETZTllsyzbc=;
 b=eXW2s2cwTi3F4VGWSjbxrULm7vx2pqBo7Whj+hIXq++u8mHniFXW5Q1gYjpYGtP3FQMdBS
 P7X5fIKFbLSTuF3/Um9jfD3L8qBl7W/kAuX7rdPfgcvBIZW6krwibdxjOr/6VqVti4hIw3
 7/e7ngcdJ1zz64Krp6RkYXZM/Gx+tbo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-pZoC6XD7MayAPO0owT1iYg-1; Sun, 18 Oct 2020 11:52:13 -0400
X-MC-Unique: pZoC6XD7MayAPO0owT1iYg-1
Received: by mail-wr1-f71.google.com with SMTP id u15so6308817wrn.4
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 08:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=98NF5I6kW3PEIcXhLOKqmMDjTo2gmlFaETZTllsyzbc=;
 b=ei3oO/sLRPpNraXl+LGViqGPXba1HZfsKIYkyCw1HM1dzOfp6ps3zGnDNRd9ynshV8
 jTSgbgxE6ShVW0pqo0ccznVM8d5Cdv+BisB5oy7UMQNMjJj8ijWZJ2YPw+fatfrijTMx
 44LxlRsKhBA3pCt22XqjHNSjpWXL9Txi5rddmLFztnNAr6uSo0OYQkIYzpyuywSoFfme
 4o3Yv6RopLAoLlZpw6seS/Or5iGeAPNScQu/Qs0oUx9R36894vWV/9UXkI28km0yd12x
 D/Ym/LYE9HV3rr3FAMIDZMd1ia9qOqtnCIcZenSk6qutSm0o+M2YNG4/q2hrAXXYzX6M
 z+BA==
X-Gm-Message-State: AOAM5308Pa9W4jZuZoV5mKdklRsayW7mZPUKINa8kJ0Jzxe8bcGVr7lq
 NtiSk5D+sD8lLkqeuzamkvJEx+u8XokxChErQ0/LpqZsbxrCH1K4LLnCOKFiq69m67eofQnJGq/
 yV3roAKI2gpxx2pk=
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr14633155wrw.138.1603036332069; 
 Sun, 18 Oct 2020 08:52:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDk0m1PaAgQbG5uGn8JDuTOpRDE6IZs81q1mD08uCdggM28IdBmZmD2H7MRJNdhDzXVGo/nQ==
X-Received: by 2002:a05:6000:1084:: with SMTP id
 y4mr14633124wrw.138.1603036331866; 
 Sun, 18 Oct 2020 08:52:11 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id i8sm12624962wmd.14.2020.10.18.08.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 08:52:11 -0700 (PDT)
Date: Sun, 18 Oct 2020 11:52:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201018114625-mutt-send-email-mst@kernel.org>
References: <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 11:52:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Colm MacCarthaigh <colmmacc@amazon.com>,
 Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, "Singh, Balbir" <sblbir@amazon.com>,
 bonzini@gnu.org, "Graf \(AWS\), Alexander" <graf@amazon.de>,
 Jann Horn <jannh@google.com>, oridgar@gmail.com, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, Willy Tarreau <w@1wt.eu>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 17, 2020 at 03:24:08PM +0200, Jason A. Donenfeld wrote:
> 4c. The guest kernel maintains an array of physical addresses that are
> MADV_WIPEONFORK. The hypervisor knows about this array and its
> location through whatever protocol, and before resuming a
> moved/snapshotted/duplicated VM, it takes the responsibility for
> memzeroing this memory. The huge pro here would be that this
> eliminates all races, and reduces complexity quite a bit, because the
> hypervisor can perfectly synchronize its bringup (and SMP bringup)
> with this, and it can even optimize things like on-disk memory
> snapshots to simply not write out those pages to disk.
> 
> A 4c-like approach seems like it'd be a lot of bang for the buck -- we
> reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
> userspace API to deal with, and it'd be race free, and eliminate a lot
> of kernel complexity.

Clearly this has a chance to break applications, right?
If there's an app that uses this as a non-system-calls way
to find out whether there was a fork, it will break
when wipe triggers without a fork ...
For example, imagine:

MADV_WIPEONFORK
copy secret data to MADV_DONTFORK
fork


used to work, with this change it gets 0s instead of the secret data.


I am also not sure it's wise to expose each guest process
to the hypervisor like this. E.g. each process needs a
guest physical address of its own then. This is a finite resource.


The mmap interface proposed here is somewhat baroque, but it is
certainly simple to implement ...

-- 
MST


