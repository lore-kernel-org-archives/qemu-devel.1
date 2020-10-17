Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7628BC43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0743C2073A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X/OoHF5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0743C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTfik-0003XA-Ti
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 02:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=552240a99=colmmacc@amazon.com>)
 id 1kTdvQ-0002C3-RM
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:34:36 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:46959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=552240a99=colmmacc@amazon.com>)
 id 1kTdvO-00084s-NM
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 00:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1602909275; x=1634445275;
 h=from:to:cc:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding:subject;
 bh=uj25hCmSfztFpgMGF7ruWI9HDVQUv0S72tdqASiD0As=;
 b=X/OoHF5ic11upnfUVEACQDUJhxBIsE5NvvVuXbC/PsHltov9qX3px4JV
 jA4TXGysqJfb6tB6az/mFvVupqsfKFzirZqLNYQnsPNmQuHhjRw0zm+IH
 rgFxP/cod7NEJeyVFnYb52IbkgINhdONZG/EKLPpE8eDzABK8YOj7QvJ+ M=;
X-IronPort-AV: E=Sophos;i="5.77,385,1596499200"; d="scan'208";a="85477025"
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP;
 17 Oct 2020 04:34:27 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS
 id C0267A1810; Sat, 17 Oct 2020 04:34:25 +0000 (UTC)
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 17 Oct 2020 04:34:25 +0000
Received: from [10.50.40.37] (10.43.162.231) by EX13d01UWA003.ant.amazon.com
 (10.43.160.107) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 17 Oct
 2020 04:34:24 +0000
From: Colm MacCarthaigh <colmmacc@amazon.com>
To: Jann Horn <jannh@google.com>
CC: Willy Tarreau <w@1wt.eu>, "Catangiu, Adrian Costin" <acatan@amazon.com>,
 Andy Lutomirski <luto@kernel.org>, Jason Donenfeld <Jason@zx2c4.com>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <virtualization@lists.linux-foundation.org>, "Graf (AWS), Alexander"
 <graf@amazon.de>, "Woodhouse, David" <dwmw@amazon.co.uk>, <bonzini@gnu.org>,
 "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>,
 <oridgar@gmail.com>, <ghammer@redhat.com>, <corbet@lwn.net>,
 <gregkh@linuxfoundation.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>, "KVM
 list" <kvm@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux API
 <linux-api@vger.kernel.org>
Date: Fri, 16 Oct 2020 21:34:24 -0700
X-Mailer: MailMate Trial (1.13.2r5673)
Message-ID: <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
In-Reply-To: <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.231]
X-ClientProxiedBy: EX13D44UWB002.ant.amazon.com (10.43.161.192) To
 EX13d01UWA003.ant.amazon.com (10.43.160.107)
Precedence: Bulk
Received-SPF: pass client-ip=207.171.184.29;
 envelope-from=prvs=552240a99=colmmacc@amazon.com; helo=smtp-fw-9102.amazon.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 00:34:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -145
X-Spam_score: -14.6
X-Spam_bar: --------------
X-Spam_report: (-14.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 17 Oct 2020 02:27:14 -0400
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



On 16 Oct 2020, at 21:02, Jann Horn wrote:
> On Sat, Oct 17, 2020 at 5:36 AM Willy Tarreau <w@1wt.eu> wrote:
> But in userspace, we just need a simple counter. There's no need for
> us to worry about anything else, like timestamps or whatever. If we
> repeatedly fork a paused VM, the forked VMs will see the same counter
> value, but that's totally fine, because the only thing that matters to
> userspace is that the counter changes when the VM is forked.

For user-space, even a single bit would do. We added MADVISE_WIPEONFORK 
so that userspace libraries can detect fork()/clone() robustly, for the 
same reasons. It just wipes a page as the indicator, which is 
effectively a single-bit signal, and it works well. On the user-space 
side of this, I’m keen to find a solution like that that we can use 
fairly easily inside of portable libraries and applications. The “have 
I forked” checks do end up in hot paths, so it’s nice if they can be 
CPU cache friendly. Comparing a whole 128-bit value wouldn’t be my 
favorite.

> And actually, since the value is a cryptographically random 128-bit
> value, I think that we should definitely use it to help reseed the
> kernel's RNG, and keep it secret from userspace. That way, even if the
> VM image is public, we can ensure that going forward, the kernel RNG
> will return securely random data.

If the image is public, you need some extra new raw entropy from 
somewhere. The gen-id could be mixed in, that can’t do any harm as 
long as rigorous cryptographic mixing with the prior state is used, but 
if that’s all you do then the final state is still deterministic and 
non-secret. The kernel would need to use the change as a trigger to 
measure some entropy (e.g. interrupts and RDRAND, or whatever). Our just 
define the machine contract as “this has to be unique random data and 
if it’s not unique, or if it’s pubic, you’re toast”.


-
Colm



