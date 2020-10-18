Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5E6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 03:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4765420866
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 03:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N/M37+za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4765420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTzAx-0006VC-A0
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 23:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5536cafaf=colmmacc@amazon.com>)
 id 1kTz9x-0005xV-1T
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 23:15:01 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:36001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5536cafaf=colmmacc@amazon.com>)
 id 1kTz9v-0004oo-8U
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 23:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1602990899; x=1634526899;
 h=from:to:cc:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding:subject;
 bh=kIh+rRe+DAK991cXZIDGGhSKZFK3HLJICasoN4MVkPs=;
 b=N/M37+zaHIUtnx7CiMhP+JtoxuPQsh2fLbcVB/sVwuaLFJ/uEvq2MBBe
 YdVGy74W1lqfG3a2HZ2U/wDeWRl+3jbTltNWf+V9q7Lo2obNjPpzGkdY7
 lNf+Wq+2O6TbXjeZ3XTvwXhFnjdahC9VCGRblw2DSDU8h88cqcogScMss c=;
X-IronPort-AV: E=Sophos;i="5.77,388,1596499200"; d="scan'208";a="85580626"
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 18 Oct 2020 03:14:50 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS
 id 3B7C8A1D8B; Sun, 18 Oct 2020 03:14:49 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 18 Oct 2020 03:14:48 +0000
Received: from [10.50.20.109] (10.43.160.125) by EX13d01UWA003.ant.amazon.com
 (10.43.160.107) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 18 Oct 2020 03:14:48 +0000
From: Colm MacCarthaigh <colmmacc@amazon.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Jann Horn <jannh@google.com>, Willy Tarreau <w@1wt.eu>, "Catangiu, Adrian
 Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 "Theodore Y.
 Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kernel list
 <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER"
 <virtualization@lists.linux-foundation.org>, "Graf (AWS), Alexander"
 <graf@amazon.de>, "Woodhouse, David" <dwmw@amazon.co.uk>, <bonzini@gnu.org>,
 "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>,
 <oridgar@gmail.com>, <ghammer@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, KVM list
 <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API
 <linux-api@vger.kernel.org>
Date: Sat, 17 Oct 2020 20:14:47 -0700
X-Mailer: MailMate Trial (1.13.2r5673)
Message-ID: <6A556D58-04B7-4FC6-A7F9-138BD7E41731@amazon.com>
In-Reply-To: <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.125]
X-ClientProxiedBy: EX13D36UWB002.ant.amazon.com (10.43.161.149) To
 EX13d01UWA003.ant.amazon.com (10.43.160.107)
Precedence: Bulk
Received-SPF: pass client-ip=207.171.184.29;
 envelope-from=prvs=5536cafaf=colmmacc@amazon.com; helo=smtp-fw-9102.amazon.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 23:14:56
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -145
X-Spam_score: -14.6
X-Spam_bar: --------------
X-Spam_report: (-14.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
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



On 17 Oct 2020, at 6:24, Jason A. Donenfeld wrote:

> There are a few design goals of notifying userspace: it should be
> fast, because people who are using userspace RNGs are usually doing so
> in the first place to completely avoid syscall overhead for whatever
> high performance application they have - e.g. I recall conversations
> with Colm about his TLS implementation needing to make random IVs
> _really_ fast.

That’s our old friend TLS1.1 in CBC mode, which needs a random 
explicit IV for every record sent. Speed is still a reason at the 
margins in cases like that, but getrandom() is really fast. A stickier 
problem is that getrandom() is not certified for use with every 
compliance standard, and those often dictate precise use of some NIST 
DRBG or NRBG construction. That keeps people proliferating user-space 
RNGs even when speed isn’t as important.

> It should also happen as early as possible, with no
> race or as minimal as possible race window, so that userspace doesn't
> begin using old randomness and then switch over after the damage is
> already done.

+1 to this, and I’d add that anyone making VM snapshots that they plan 
to restore from multiple times really needs to think this through top to 
bottom. The system would likely need to be put in to some kind of 
quiescent state when the snapshot is taken.

> So, anyway, here are a few options with some pros and cons for the
> kernel notifying userspace that its RNG should reseed.
>
> 1. SIGRND - a new signal. Lol.
>
> 2. Userspace opens a file descriptor that it can epoll on. Pros are
> that many notification mechanisms already use this. Cons is that this
> requires syscall and might be more racy than we want. Another con is
> that this a new thing for userspace programs to do.

A library like OpenSSL or BoringSSL also has to account for running 
inside a chroot, which also makes this hard.

> Any thoughts on 4c? Is that utterly insane, or does that actually get
> us somewhere close to what we want?

I still like 4c, and as a user-space crypto-person, and a VM person, 
they have a lot of appeal. Alex and Adrian’s replies get into some of 
the sufficiency challenge. But for user-space libraries like the *SSLs, 
the JVMs, and other runtimes where RNGs show up, it could plug in easily 
enough.

-
Colm

