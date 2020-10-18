Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 02:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5C0207FF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 02:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYBvkmsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5C0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTy8L-0005mx-7n
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 22:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTy7h-0005Mf-Tn
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 22:08:37 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTy7f-0005dR-GI
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 22:08:37 -0400
Received: by mail-lj1-x244.google.com with SMTP id c21so7213843ljn.13
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 19:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EoL7d0lHzdswPEFGsAEJJdNfE07sA8igVy5PEUcTbDQ=;
 b=JYBvkmsN9RysEeFQRgQMS2IGgQheKP8WCpVEITeoShBcDrScb2YzXJWCS9fBQBrxMO
 n86hAFDTEQHXskSLJ578m/TKYBOiwMg0z/aLu4hSKM9fzy3Bml2AtFnKiNFHXmC81ou5
 oLgoTyjjd7m8dU7zn1iDkaLBmUIFwukS3W1degboeUcB5xxmHAwJ7X7ZJjY5qLq4Uevz
 9565oX51vhmKmr/jiZRuPNAZjyZvYkS6kUYo9TyvCsqYY8xkBsy/gcixSZeElDfa4GKl
 lQjC5lLseYNii8XoYpb7znRj1djIzK3pwUzl9c71Hf2cfPLya0ovLXiar856omGyFgtc
 cBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EoL7d0lHzdswPEFGsAEJJdNfE07sA8igVy5PEUcTbDQ=;
 b=jXLkRx/cxWAcEIpL+4bsLmMEJpda2BrjZR6rkmgIpkiqz6hIklm8ia7i0KLlAaM0tM
 xUsy1Zpgd45ZIKT2V2lEmyyf3OOavf6osbWiIAFW5MDPvuwOqWT2zuVz/o388hAcwh0C
 WMlxw3whxZb7kJ01EmQZRsGqEz41EbWlGrk3c74wHDzobkyCC3zqUWq9PeZNPYGsxhPS
 Vz5J39FL7as0XFTYrqUiomTK6Fpf/PoTkODtljEe12uerGgCfknSowH7sA/AFo5zSDF4
 m8jlQobHtzZ1RJ+Ws55gA2YPnpZW7oP2VKrteCJ2tTP7bykOddPKcjC4w8/a+WKDFxha
 gIlw==
X-Gm-Message-State: AOAM531mFYz72/dwY59mrXChCXY2zuf2IDXGyHJggm/jHFbheJeFw5pG
 F26XvaLPsUmsYhtkbM8oCTWwpGsfVUB5fRH8mtgSEA==
X-Google-Smtp-Source: ABdhPJxVC4A8hz5Ph8xI5Lcuiwu6i49AGWglYFrVbrHYISFimwHqgN7R9bAY4u2r3Hi8cj+JpNCqLDs0HlkcXSFAtqI=
X-Received: by 2002:a05:651c:1313:: with SMTP id
 u19mr1073920lja.47.1602986911177; 
 Sat, 17 Oct 2020 19:08:31 -0700 (PDT)
MIME-Version: 1.0
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
 <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
In-Reply-To: <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
From: Jann Horn <jannh@google.com>
Date: Sun, 18 Oct 2020 04:08:04 +0200
Message-ID: <CAG48ez0JYK2_tk0DuEgKY2y0d38N+O5HJrH2je7RRk6o7XBixA@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Alexander Graf <graf@amazon.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Willy Tarreau <w@1wt.eu>,
 Colm MacCarthaigh <colmmacc@amazon.com>, 
 "Catangiu, Adrian Costin" <acatan@amazon.com>,
 Andy Lutomirski <luto@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Eric Biggers <ebiggers@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
 kernel list <linux-kernel@vger.kernel.org>, 
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, 
 "Woodhouse, David" <dwmw@amazon.co.uk>, bonzini@gnu.org, "Singh,
 Balbir" <sblbir@amazon.com>, 
 "Weiss, Radu" <raduweis@amazon.com>, oridgar@gmail.com, ghammer@redhat.com, 
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 KVM list <kvm@vger.kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>
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

On Sat, Oct 17, 2020 at 8:09 PM Alexander Graf <graf@amazon.de> wrote:
> There are applications way beyond that though. What do you do with
> applications that already consumed randomness? For example a cached pool
> of SSL keys. Or a higher level language primitive that consumes
> randomness and caches its seed somewhere in an internal data structure.

For deterministic protection, those would also have to poll some
memory location that tells them whether the VmGenID changed:

1. between reading entropy from their RNG pool and using it
2. between collecting data from external sources (user input, clock,
...) and encrypting it

and synchronously shoot down the connection if a change happened. If
e.g. an application inside the VM has an AES-GCM-encrypted TLS
connection and, directly after the VM is restored, triggers an
application-level timeout that sends some fixed message across the
connection, then the TLS library must guarantee that either the VM was
already committed to sending exactly that message before the VM was
forked or the message will be blocked. If we don't do that, an
attacker who captures both a single packet from the forked VM and
traffic from the old VM can decrypt the next message from the old VM
after the fork (because AES-GCM is like AES-CTR plus an authenticator,
and CTR means that when keystream reuse occurs and one of the
plaintexts is known, the attacker can simply recover the other
plaintext using XOR).

(Or maybe, in disaster failover environments, TLS 1.3 servers could
get away with rekeying the connection instead of shooting it down? Ask
your resident friendly cryptographer whether that would be secure, I
am not one.)

I don't think a mechanism based around asynchronously telling the
application and waiting for it to confirm the rotation at a later
point is going to cut it; we should have some hard semantics on when
an application needs to poll this value.

> Or even worse: your system's host ssh key.

Mmmh... I think I normally would not want a VM to reset its host ssh
key after merely restoring a snapshot though? And more importantly,
Microsoft's docs say that they also change the VmGenID on disaster
failover. I think you very much wouldn't want your server to lose its
host key every time disaster failover happens. On the other hand,
after importing a public VM image, it might be a good idea.

I guess you could push that responsibility on the user, by adding an
option to the sshd_config that tells OpenSSH whether the host key
should be rotated on an ID change or not... but that still would not
be particularly pretty.

Ideally we would have the host tell us what type of events happened to
the VM, or something like that... or maybe even get the host VM
management software to ask the user whether they're importing a public
image... I really feel like with Microsoft's current protocol, we
don't get enough information to figure out what we should do about
private long-term authentication keys.

