Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5F7C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937C12074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937C12074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTfyr-0003Lh-GJ
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 02:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w@1wt.eu>) id 1kTfxr-0002io-57
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 02:45:15 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43850 helo=1wt.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1) (envelope-from <w@1wt.eu>)
 id 1kTfxo-0002oT-Od
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 02:45:14 -0400
Received: (from willy@localhost)
 by pcw.home.local (8.15.2/8.15.2/Submit) id 09H6ignu014122;
 Sat, 17 Oct 2020 08:44:42 +0200
Date: Sat, 17 Oct 2020 08:44:42 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201017064442.GA14117@1wt.eu>
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Received-SPF: pass client-ip=62.212.114.60; envelope-from=w@1wt.eu; helo=1wt.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 01:37:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Colm MacCarthaigh <colmmacc@amazon.com>,
 Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Singh, Balbir" <sblbir@amazon.com>,
 bonzini@gnu.org, "Graf \(AWS\), Alexander" <graf@amazon.de>, oridgar@gmail.com,
 "Catangiu, Adrian Costin" <acatan@amazon.com>,
 Andy Lutomirski <luto@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 17, 2020 at 07:52:48AM +0200, Jann Horn wrote:
> On Sat, Oct 17, 2020 at 7:37 AM Willy Tarreau <w@1wt.eu> wrote:
> > On Sat, Oct 17, 2020 at 07:01:31AM +0200, Jann Horn wrote:
> > > Microsoft's documentation
> > > (http://go.microsoft.com/fwlink/?LinkId=260709) says that the VM
> > > Generation ID that we get after a fork "is a 128-bit,
> > > cryptographically random integer value". If multiple people use the
> > > same image, it guarantees that each use of the image gets its own,
> > > fresh ID:
> >
> > No. It cannot be more unique than the source that feeds that cryptographic
> > transformation. All it guarantees is that the entropy source is protected
> > from being guessed based on the output. Applying cryptography on a simple
> > counter provides apparently random numbers that will be unique for a long
> > period for the same source, but as soon as you duplicate that code between
> > users and they start from the same counter they'll get the same IDs.
> >
> > This is why I think that using a counter is better if you really need something
> > unique. Randoms only reduce predictability which helps avoiding collisions.
> 
> Microsoft's spec tells us that they're giving us cryptographically
> random numbers. Where they're getting those from is not our problem.
> (And if even the hypervisor is not able to collect enough entropy to
> securely generate random numbers, worrying about RNG reseeding in the
> guest would be kinda pointless, we'd be fairly screwed anyway.)

Sorry if I sound annoying, but it's a matter of terminology and needs.

Cryptograhically random means safe for use with cryptography in that it
is unguessable enough so that you can use it for encryption keys that
nobody will be able to guess. It in no ways guarantees uniqueness, just
like you don't really care if the symmetric crypto key of you VPN has
already been used once somewhere else as long as there's no way to know.
However with the good enough distribution that a CSPRNG provides,
collisions within a *same* generator are bound to a very low, predictable
rate which is by generally considered as acceptable for all use cases.

Something random (cryptographically or not) *cannot* be unique by
definition, otherwise it's not random anymore, since each draw has an
influence on the remaining list of possible draws, which is contrary to
randomness. And conversely something unique cannot be completely random
because if you know it's unique, you can already rule out all other known
values from the candidates, thus it's more predictable than random.

With this in mind, picking randoms from a same RNG is often highly
sufficient to consider they're highly likely unique within a long
period. But it's not a guarantee. And it's even less one between two
RNGs (e.g. if uniqueness is required between multiple hypervisors in
case VMs are migrated or centrally managed, which I don't know).

If what is sought here is a strong guarantee of uniqueness, using a
counter as you first suggested is better. If what is sought is pure
randomness (in the sense that it's unpredictable, which I don't think
is needed here), then randoms are better. If both are required, just
concatenate a counter and a random. And if you need them to be spatially
unique, just include a node identifier.

Now the initial needs in the forwarded message are not entirely clear
to me but I wanted to rule out the apparent mismatch between the expressed
needs for uniqueness and the proposed solutions solely based on randomness.

Cheers,
Willy

