Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E71DC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DF522BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DF522BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbqO-0006e5-L5
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48149)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqbqE-0006Fp-T6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqbqD-0001zc-Rn
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:23:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqbqD-0001zJ-LO
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:23:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so50321488wru.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jPrqAgMdupI/7nEvSEhuNlAtiB6HInh2SkcKIxRnKJc=;
 b=qL614HKEr2Q+6LiXI+9qaUQE73xZhc5aoa5fShd36MLg1+VvWaMdVvjw//4TBYp/XI
 0OF/x4xkHXGF+QDgYnZgAbhP2dF4YHRWaHyAZXopy+Q32HSA+h+rRyj67W2QPl8dVd4W
 HMaSrbc4tkfNwiie1l1fWQ8EIL21LNFCNHMqTlTdgvDbmzXNpcn1P9J/CkAl+hAM6eoS
 1Ud6300cqiU3Ix9kE6cJq8WklWC9jEnDcW5vWS4HGTd2255NI3VS6B08JJtXUva99I2G
 hKFUkKpkcsMEu7hnsUcht9BYvzlgLQ4kOnCSx2GfQitfpsf8JlOI2cuEsvj/bMOLsQQA
 gFzg==
X-Gm-Message-State: APjAAAVdGtRWK3KXmYVzHy3atbl2Ut7EMGQcQFqsB09CoVfZpJBfx+nH
 m4Fk431sjrnihDhAfX9aYjC2xFCru40=
X-Google-Smtp-Source: APXvYqzIWxuQy4TVuDlYVPsO4UIS5f4sx8Tsm5I2yaCvT/82mY8vnBklh3/bgI+qydPzPLM2MQt1Ow==
X-Received: by 2002:adf:db46:: with SMTP id f6mr43490012wrj.212.1564053799666; 
 Thu, 25 Jul 2019 04:23:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id 5sm40995511wmg.42.2019.07.25.04.23.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 04:23:18 -0700 (PDT)
To: Sergio Lopez <slp@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
Date: Thu, 25 Jul 2019 13:23:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87pnlymm47.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, maran.wilson@oracle.com,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 12:42, Sergio Lopez wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Thu, 25 Jul 2019 at 10:59, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> OK so please start with adding virtio 1 support. Guest bits
>>> have been ready for years now.
>>
>> I'd still rather we just used pci virtio. If pci isn't
>> fast enough at startup, do something to make it faster...
> 
> Actually, removing PCI (and ACPI), is one of the main ways microvm has
> to reduce not only boot time, but also the exposed surface and the
> general footprint.
> 
> I think we need to discuss and settle whether using virtio-mmio (even if
> maintained and upgraded to virtio 1) for a new machine type is
> acceptable or not. Because if it isn't, we should probably just ditch
> the whole microvm idea and move to something else.

I agree.  IMNSHO the reduced attack surface from removing PCI is
(mostly) security theater, however the boot time numbers that Sergio
showed for microvm are quite extreme and I don't think there is any hope
of getting even close with a PCI-based virtual machine.

So I'd even go a step further: if using virtio-mmio for a new machine
type is not acceptable, we should admit that boot time optimization in
QEMU is basically as good as it can get---low-hanging fruit has been
picked with PVH and mmap is the logical next step, but all that's left
is optimizing the guest or something else.

I must say that -M microvm took a while to grow on me, but I think it's
a great example of how the infrastructure provided by QEMU provides
useful features for free, even for the simplest emulated hardware.  For
example, in v3 microvm could only boot from PVH kernels, but the next
firmware-enabled version reuses more of the PC code and thus supports
all of vmlinuz, multiboot and PVH.

Again: Sergio has been very receptive to feedback and has provided
numbers to back the design choices, and we should reciprocate or at
least be very clear on the constraints.

Paolo

