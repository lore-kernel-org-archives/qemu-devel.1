Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE13EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF5E2074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qT5tSTup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF5E2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTg9E-0007Q9-RR
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 02:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTg8N-00071D-Pd
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 02:56:07 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jannh@google.com>) id 1kTg8J-0006mM-Fv
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 02:56:07 -0400
Received: by mail-lj1-x243.google.com with SMTP id h20so5128107lji.9
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wzkWOoKjInRI+O5FvJvA/t/AUj8a5RTpGl8TvIyMwpk=;
 b=qT5tSTupKtI9+LV08l4NhIywJjENbE/1819qMpMZ4wleQCC2UZcegHiJKzfH1HMZ3e
 VQ39ggQjsnoUsTrwcVQ97D1zQSE6mutGso5Q8ogf39SUNsMEKhaYEUFy/VRoirOjmt9b
 37fnHoejXu8BkEr6+HM11CFBIeNasDURFIHxGHoIweZ8GffWeTWMHjs1yf08SJ9aElhz
 uVubdWIw6/aHW+WMsmF6jE1F+EA14IbVZRX4CbiaSO5HESQkyn+DtfxAcYY1TXnDXa3y
 L0xoXUEVvRAwv4QmP1JweP+0D8VJwUznxwhWGyWIOZuxwKsIs2yP+PPDqRQknJmj0Lnw
 LbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wzkWOoKjInRI+O5FvJvA/t/AUj8a5RTpGl8TvIyMwpk=;
 b=PgZy1JsqicGWDTZsGIIm+3QQQU4ISgG+aFeyfL/bNqUZZWv8bqzAK2fiCQi80Hzdw8
 OIqgSRZde2R/WNYBDT0xCsg+nychmPDsImcbzM+1S31RhNFriC1Ot/DViTRhjsLSeFDo
 MEZYCWyD+EvhMp9TbdE+FXi59BeJCr1SVL0OC6b427Juuddw/5o2VeDBBf8z18CqeGHr
 aV5YrT+/sQA6hBpaFruBfHwBPscpmQpbBu1jkQ+uiFN2Kt9/29dc1OYo2cBWZ/Q8qERD
 BxQ8mhs9we0l+55xYIlo9wDr/ja+L9TCfwFeK/DzdOMrbz0Gwb39Ml639L2vP+m+IsWC
 sKOw==
X-Gm-Message-State: AOAM530dGPJSOmBBlMZhDzZwYj7UIDrJMhwcy1Hp7M4GM1Vpvr8tFtmb
 k35PZ32RJ0R4/O2pwaCwn3sZY4I8vE1CVNpcDyVM5w==
X-Google-Smtp-Source: ABdhPJy+7ndzZeyQ/tSwJHmtK1PTCVWdHHr1LWw9yj8KnDosvV+fAVJTuHJyVyhRpmky/WIBh3xN8Pb/8hbCqMiC0A0=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr2697080ljh.377.1602917761335; 
 Fri, 16 Oct 2020 23:56:01 -0700 (PDT)
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
In-Reply-To: <20201017064442.GA14117@1wt.eu>
From: Jann Horn <jannh@google.com>
Date: Sat, 17 Oct 2020 08:55:34 +0200
Message-ID: <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Willy Tarreau <w@1wt.eu>
Cc: Colm MacCarthaigh <colmmacc@amazon.com>, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, 
 Andy Lutomirski <luto@kernel.org>, Jason Donenfeld <Jason@zx2c4.com>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Eric Biggers <ebiggers@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
 kernel list <linux-kernel@vger.kernel.org>, 
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, 
 "Graf (AWS), Alexander" <graf@amazon.de>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, bonzini@gnu.org, 
 "Singh, Balbir" <sblbir@amazon.com>, "Weiss, Radu" <raduweis@amazon.com>,
 oridgar@gmail.com, ghammer@redhat.com, Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Qemu Developers <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=jannh@google.com; helo=mail-lj1-x243.google.com
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

On Sat, Oct 17, 2020 at 8:44 AM Willy Tarreau <w@1wt.eu> wrote:
> On Sat, Oct 17, 2020 at 07:52:48AM +0200, Jann Horn wrote:
> > On Sat, Oct 17, 2020 at 7:37 AM Willy Tarreau <w@1wt.eu> wrote:
> > > On Sat, Oct 17, 2020 at 07:01:31AM +0200, Jann Horn wrote:
> > > > Microsoft's documentation
> > > > (http://go.microsoft.com/fwlink/?LinkId=260709) says that the VM
> > > > Generation ID that we get after a fork "is a 128-bit,
> > > > cryptographically random integer value". If multiple people use the
> > > > same image, it guarantees that each use of the image gets its own,
> > > > fresh ID:
> > >
> > > No. It cannot be more unique than the source that feeds that cryptographic
> > > transformation. All it guarantees is that the entropy source is protected
> > > from being guessed based on the output. Applying cryptography on a simple
> > > counter provides apparently random numbers that will be unique for a long
> > > period for the same source, but as soon as you duplicate that code between
> > > users and they start from the same counter they'll get the same IDs.
> > >
> > > This is why I think that using a counter is better if you really need something
> > > unique. Randoms only reduce predictability which helps avoiding collisions.
> >
> > Microsoft's spec tells us that they're giving us cryptographically
> > random numbers. Where they're getting those from is not our problem.
> > (And if even the hypervisor is not able to collect enough entropy to
> > securely generate random numbers, worrying about RNG reseeding in the
> > guest would be kinda pointless, we'd be fairly screwed anyway.)
>
> Sorry if I sound annoying, but it's a matter of terminology and needs.
>
> Cryptograhically random means safe for use with cryptography in that it
> is unguessable enough so that you can use it for encryption keys that
> nobody will be able to guess. It in no ways guarantees uniqueness, just
> like you don't really care if the symmetric crypto key of you VPN has
> already been used once somewhere else as long as there's no way to know.
> However with the good enough distribution that a CSPRNG provides,
> collisions within a *same* generator are bound to a very low, predictable
> rate which is by generally considered as acceptable for all use cases.

Yes.

> Something random (cryptographically or not) *cannot* be unique by
> definition, otherwise it's not random anymore, since each draw has an
> influence on the remaining list of possible draws, which is contrary to
> randomness. And conversely something unique cannot be completely random
> because if you know it's unique, you can already rule out all other known
> values from the candidates, thus it's more predictable than random.

Yes.

> With this in mind, picking randoms from a same RNG is often highly
> sufficient to consider they're highly likely unique within a long
> period. But it's not a guarantee. And it's even less one between two
> RNGs (e.g. if uniqueness is required between multiple hypervisors in
> case VMs are migrated or centrally managed, which I don't know).
>
> If what is sought here is a strong guarantee of uniqueness, using a
> counter as you first suggested is better.

My suggestion is to use a counter *in the UAPI*, not in the hypervisor
protocol. (And as long as that counter can only miss increments in a
cryptographically negligible fraction of cases, everything's fine.)

> If what is sought is pure
> randomness (in the sense that it's unpredictable, which I don't think
> is needed here), then randoms are better.

And this is what *the hypervisor protocol* gives us (which could be
very useful for reseeding the kernel RNG).

> If both are required, just
> concatenate a counter and a random. And if you need them to be spatially
> unique, just include a node identifier.
>
> Now the initial needs in the forwarded message are not entirely clear
> to me but I wanted to rule out the apparent mismatch between the expressed
> needs for uniqueness and the proposed solutions solely based on randomness.

Sure, from a theoretical standpoint, it would be a little bit nicer if
the hypervisor protocol included a generation number along with the
128-bit random value. But AFAIU it doesn't, so if we want this to just
work under Microsoft's existing hypervisor, we'll have to make do with
checking whether the random value changed. :P

