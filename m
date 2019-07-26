Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134A4C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9842166E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9842166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqv7K-0006Pt-4Q
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 03:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36265)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqv75-00061Q-4Y
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqv6z-0000F7-0R
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:57:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqv6y-0008Uu-Op
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:57:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so46831491wme.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 00:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LfHzuMB3s+eGpvlfmGqfkmXev6wwXwHOdRrX3ziCCvY=;
 b=JNkQ02Yjp+uA5qaCbZZO8isM7sIvFVEWIGoQ0ZAniOuPx+vw5SKDPjP5OKBGrM3yyz
 4uZ5bgrxW9iQaRl2UmUHQ1vsk0dwaY4HAOmCqzYmIUc5Svf+rOaQl4YF1aYwWCWCNzOq
 ee0zcS/UJlYTNjv8zS8/NXJPBL43WMU/Bxaj5Z5fw2qeqeMCXztFTQBYLQJCcHYULtMz
 FNFcBvQBIKC5hnTAPSR/JUwVkdtBs3kE5WyNqEa4O7tw3q542wXgMZK4ZL2YFa23efXG
 FjYhKX0p5ZBR2UQWkojUHO3rUqc48f/2LI8sLoacXy28lbCX+I/7A8Rbh8LHrogVQzyG
 aNUw==
X-Gm-Message-State: APjAAAVrb7JVeZE0LRczRx09i2RZscMtFti16BYps51GHfZUkHlLQBm7
 rkrAvMMWlHu2nYXiIXYVnbsyYQ==
X-Google-Smtp-Source: APXvYqwfmbWlN6Kl5bwaAXzlPUS3VjOV0buwgIHiPnkovfz4SOE/ZNxE/JlbAYjbzKOaBu8bCWUuuw==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr3263070wmc.1.1564127873216;
 Fri, 26 Jul 2019 00:57:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id s63sm42176038wme.17.2019.07.26.00.57.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 00:57:52 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190719102915.GG18585@stefanha-x1.localdomain>
 <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
 <87tvbdrvin.fsf@redhat.com>
 <CAJSP0QW1NrYwC6a61jj_vgJOJO7ofJOVUcz6Bf4z720OiN_0rw@mail.gmail.com>
 <c1464003-38f9-95ee-c42a-fb1d370df0ab@redhat.com>
 <c9c811f4-6108-f5b1-31f5-3f757f51cf3c@redhat.com>
 <20190725104331-mutt-send-email-mst@kernel.org>
 <6d318abf-4afa-a1dc-a4e8-3a2d0a6de297@redhat.com>
 <20190725161646-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <65d0458b-02bf-0e40-2851-b4becc911e4f@redhat.com>
Date: Fri, 26 Jul 2019 09:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725161646-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>, "Montes,
 Julio" <julio.montes@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 22:30, Michael S. Tsirkin wrote:
> On Thu, Jul 25, 2019 at 05:35:01PM +0200, Paolo Bonzini wrote:
>> On 25/07/19 16:46, Michael S. Tsirkin wrote:
>>> Actually, I think I have a better idea.
>>> At the moment we just get an exit on these reads and return all-ones.
>>> Yes, in theory there could be a UR bit set in a bunch of
>>> registers but in practice no one cares about these,
>>> and I don't think we implement them.
>>> So how about mapping a single page, read-only, and filling it
>>> with all-ones?
>>
>> Yes, that's nice indeed. :)  But it does have some cost, in terms of
>> either number of VMAs or QEMU RSS since the MMCONFIG area is large.
>>
>> What breaks if we return all zeroes?  Zero is not a valid vendor ID.
>>
>> Paolo
> 
> I think I know what you are thinking of doing:
> map /dev/zero so we get a single VMA but all mapped to
> a single zero pte?

Yes, exactly.  You absolutely need to share the page because the guest
could easily touch 32*256 pages just to scan function 0 on every bus and
device, even if the VM has just 4 or 5 devices and all of them on the
root complex.  And that causes fragmentation so you have to map bigger
areas.

> - we can implement /dev/ones. in fact, we can implement
>   /dev/byteXX for each possible value, the cost will
>   be only 1M on a 4k page system.
>   it might come in handy for e.g. free page hinting:
>   at the moment if guest memory is poisoned
>   we can not unmap it, with this trick we can
>   map it to /dev/byteXX.

I also thought of /dev/ones, not sure how it would be accepted. :)  Also
you cannot map lazily on page fault, otherwise you get a vmexit and it's
slow again.  So /dev/ones needs to be written to use a huge page, possibly.

Paolo

