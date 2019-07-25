Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD1C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE26521901
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE26521901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqehv-0000hw-6i
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34233)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqehj-0000JC-Js
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqehi-0005eD-F1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:26:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqehi-0005dq-8d
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:26:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so25940787wrr.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1P1Mq+XGBHfGILBbSSWOCK0j+10yF7sSQLnFhC61beA=;
 b=gin0KjniE3XagymGRh3OP3UW0rxA+/R5mbtVmF1Y8TwjxPmnJN8CChNNhkPRC+dA5Z
 EA0QG+NRalDerEC+/aVSQ7B1kmqSPKBLyczay7Sb7G9fJ+M1HfwgPgMo+n/UjtKQ5Zxf
 NeHs5UpUNXyxxQoXMv8Kb2NTxpwGfP3KYdJM/d16f7wy/EM4j6cI53OG/ioJ8n4GBox5
 YfZ8W6674veebTkICWTw1Ev1VIuhZjtfg/ngUfm1kRbORm+eY5Lrr6Z5yzEIv6DAK3FR
 vr/QGjQe9XrpP5fB4kOfUFq9nR7CEbmJ8wzpTSRWgkiJtao7J89SR24lIS7JtiKUXedT
 m4dQ==
X-Gm-Message-State: APjAAAVskGNuKscp55rm8Oeb+Bch94s53k5xsMC+bK0FndD/ZPlYdUy7
 zbZFktPGteQucd4r7NGEDHAPug==
X-Google-Smtp-Source: APXvYqyRFasOisCLJbvgvWHJqY4e45iGggHqZh/SoMO0aJYQRkmsOsYFrAcVCmktQaPUlk+6ypSNQQ==
X-Received: by 2002:adf:f286:: with SMTP id k6mr549830wro.320.1564064805123;
 Thu, 25 Jul 2019 07:26:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id m7sm40378415wrx.65.2019.07.25.07.26.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 07:26:44 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com> <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
 <CAFEAcA-zBb0mXX1JLoWxz46JDAZFySUZpdONo5uw=KLgJqJ94w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <af3acd26-f114-5889-182a-7dbd025393b9@redhat.com>
Date: Thu, 25 Jul 2019 16:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-zBb0mXX1JLoWxz46JDAZFySUZpdONo5uw=KLgJqJ94w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 16:04, Peter Maydell wrote:
> On Thu, 25 Jul 2019 at 14:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> To me *maintainability is the biggest consideration* when introducing a
>> new feature.  "We can do just as well with q35" is a good reason to
>> deprecate and delete microvm, but not a good reason to reject it now as
>> long as microvm is good enough in terms of maintainability.
> 
> I think maintainability matters, but also important is "are
> we going in the right direction in the first place?".
> virtio-mmio is (variously deliberately and accidentally)
> quite a long way behind virtio-pci, and certain kinds of things
> (hotplug, extensibility beyond a certain number of endpoints)
> are not going to be possible (either ever, or without a lot
> of extra design and implementation work to reimplement stuff
> we have already today with PCI). Are we sure we're not going
> to end up with a stream of "oh, now we need to implement X for
> virtio-mmio (that virtio-pci already has)", "users want Y now
> (that virtio-pci already has)", etc?

I think this is part of maintainability in a wider sense.  For every
missing feature there should be a good reason why it's not needed.  And
if there is already code to do that in QEMU, then there should be an
excellent reason why it's not being used.  (This was the essence of the
firmware debate).

So for microvm you could do without hotplug because the idea is that you
just tear down the VM and restart it.  Lack of MSI is actually what
worries me the most, but we could say that microvm clients generally
have little multiprocessing so it's not common to have multiple network
flows at the same time and so you don't need multiqueue.

For microvm in particular there are two reasons why we can take some
shortcuts (but with care):

- we won't support versioned machine types for microvm.  microvm guests
die every time you upgrade QEMU, by design.  So this is not another QED,
which implemented more features than qcow2 but did so at the wrong place
of the stack.  In fact it's exactly the opposite (it implements less
features, so that the implementation of e.g. q35 or PCI is untouched and
does not need one-off boot time optimization hacks)

- we know that Amazon is using something very similar to microvm in
production, with virtio-mmio, so the feature set is at least usable for
something.

> The other thing is that once we've introduced something we're
> stuck with whatever it does, because we don't like breaking
> backwards compatibility. So I think getting the virtio-legacy
> vs virtio-1 story sorted out before we land microvm is
> important, at least to the point where we know we haven't
> backed ourselves into a corner or required a lot of extra
> effort on transitional-device support that we could have
> avoided.

Even though we won't support versioned machine types, I think there is
agreement that virtio 0.9 is a bad idea and should be fixed.

Paolo

> Which isn't to say that I'm against the microvm approach;
> just that I'd like us to consider and make a decision on
> these issues before landing it, rather than just saying
> "the patches in themselves look good, let's merge it".
> 
> thanks
> -- PMM
> 


