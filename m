Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E15C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752072073A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WZLQYGBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752072073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTfiP-0002oT-Gd
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 02:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=552240a99=colmmacc@amazon.com>)
 id 1kTemV-0006rI-Fm
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 01:29:27 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:12830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=552240a99=colmmacc@amazon.com>)
 id 1kTemS-0001rm-Lz
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 01:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1602912564; x=1634448564;
 h=from:to:cc:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding:subject;
 bh=4D+RWh/5beB78lRbdCD/b83sagLyNZAat88yYlEo6kY=;
 b=WZLQYGBWK+iOjX5embXIBibMHHDEjiR5XmXCkFKLFxMR62mNdtNUI4N4
 FAKbEDcONXCZW6GQZasw7Rgm0ZTlfIfzk26kr2Gq/nQrQfTdPGJR4xOQf
 MisOMiIYqZ5hFEc5fc5OUyBlENRmcyHS1WImuWnFWAwnOi0iUvSGQfdtU Y=;
X-IronPort-AV: E=Sophos;i="5.77,385,1596499200"; d="scan'208";a="77295793"
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 17 Oct 2020 05:29:17 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
 by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS
 id 5414EA26D1; Sat, 17 Oct 2020 05:29:16 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 17 Oct 2020 05:29:15 +0000
Received: from [10.50.40.37] (10.43.161.237) by EX13d01UWA003.ant.amazon.com
 (10.43.160.107) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 17 Oct
 2020 05:29:14 +0000
From: Colm MacCarthaigh <colmmacc@amazon.com>
To: Jann Horn <jannh@google.com>
CC: Willy Tarreau <w@1wt.eu>, "Catangiu, Adrian Costin" <acatan@amazon.com>,
 Andy Lutomirski <luto@kernel.org>, Jason Donenfeld <Jason@zx2c4.com>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>, "open
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
Date: Fri, 16 Oct 2020 22:29:14 -0700
X-Mailer: MailMate Trial (1.13.2r5673)
Message-ID: <FF2CCC35-87DD-4311-A3CF-4943B29DBEE3@amazon.com>
In-Reply-To: <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13d09UWC002.ant.amazon.com (10.43.162.102) To
 EX13d01UWA003.ant.amazon.com (10.43.160.107)
Precedence: Bulk
Received-SPF: pass client-ip=207.171.184.25;
 envelope-from=prvs=552240a99=colmmacc@amazon.com; helo=smtp-fw-9101.amazon.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 01:29:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -145
X-Spam_score: -14.6
X-Spam_bar: --------------
X-Spam_report: (-14.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 17 Oct 2020 02:27:17 -0400
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



On 16 Oct 2020, at 22:01, Jann Horn wrote:
>
> On Sat, Oct 17, 2020 at 6:34 AM Colm MacCarthaigh 
> <colmmacc@amazon.com> wrote:
>> For user-space, even a single bit would do. We added 
>> MADVISE_WIPEONFORK
>> so that userspace libraries can detect fork()/clone() robustly, for 
>> the
>> same reasons. It just wipes a page as the indicator, which is
>> effectively a single-bit signal, and it works well. On the user-space
>> side of this, I’m keen to find a solution like that that we can use
>> fairly easily inside of portable libraries and applications. The 
>> “have
>> I forked” checks do end up in hot paths, so it’s nice if they can 
>> be
>> CPU cache friendly. Comparing a whole 128-bit value wouldn’t be my
>> favorite.
>
> I'm pretty sure a single bit is not enough if you want to have a
> single page, shared across the entire system, that stores the VM
> forking state; you need a counter for that.

You’re right. WIPEONFORK is more like a single-bit per use. If it’s 
something system wide then a counter is better.

> So the RNG state after mixing in the new VM Generation ID would
> contain 128 bits of secret entropy not known to anyone else, including
> people with access to the VM image.
>
> Now, 128 bits of cryptographically random data aren't _optimal_; I
> think something on the order of 256 bits would be nicer from a
> theoretical standpoint. But in practice I think we'll be good with the
> 128 bits we're getting (since the number of users who fork a VM image
> is probably not going to be so large that worst-case collision
> probabilities matter).

This reminds me on key/IV usage limits for AES encryption, where the 
same birthday bounds apply, and even though 256-bits would be better, we 
routinely make 128-bit birthday bounds work for massively scalable 
systems.

>> The kernel would need to use the change as a trigger to
>> measure some entropy (e.g. interrupts and RDRAND, or whatever). Our 
>> just
>> define the machine contract as “this has to be unique random data 
>> and
>> if it’s not unique, or if it’s pubic, you’re toast”.
>
> As far as I can tell from Microsoft's spec, that is a guarantee we're
> already getting.

Neat.

-
Colm

