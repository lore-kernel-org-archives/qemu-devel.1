Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C5FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 00:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773D1206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 00:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773D1206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htLPl-0001Qa-JW
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 20:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37390)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1htLP4-00010k-GA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 20:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1htLP3-0001yb-Dh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 20:26:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1htLP3-0001vp-6x
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 20:26:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC7513092669;
 Fri,  2 Aug 2019 00:26:34 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C96260925;
 Fri,  2 Aug 2019 00:26:28 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
References: <20190729125755.45008-1-slp@redhat.com>
 <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
 <9953cc99-80b3-814c-f75e-a16c987c23e5@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9b2acff6-8c6d-3aa0-8020-d6d831222496@redhat.com>
Date: Fri, 2 Aug 2019 02:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9953cc99-80b3-814c-f75e-a16c987c23e5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 02 Aug 2019 00:26:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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

On 08/01/19 01:58, Paolo Bonzini wrote:
> On 30/07/19 18:06, Laszlo Ersek wrote:
>> On 07/29/19 14:57, Sergio Lopez wrote:
>>> Implement the modern (v2) personality, according to the VirtIO 1.0
>>> specification.
>>>
>>> Support for v2 among guests is not as widespread as it'd be
>>> desirable. While the Linux driver has had it for a while, support is
>>> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.
>>
>> That's right; not only are there no plans to implement virtio-mmio/1.0
>> for OVMF (to my knowledge), I'd even argue against such efforts.
>>
>> OVMF is a heavy-weight guest firmware, which I see entirely out of scope
>> for "micro VMs". And so virtio-mmio/1.0 would seem like a needless &
>> unwelcome complication, from the OVMF maintainership perspective.
> 
> But given that, why not rip out virtio-mmio completely?

Virtio-mmio used to be necessary because "qemu-system-aarch64 -M virt"
lacked a PCI host originally. (The relevant commit is 4ab29b8214cc,
"arm: Add PCIe host bridge in virt machine", 2015-02-13; part of v2.3.0.)

Indeed I don't expect anyone to use virtio-mmio nowadays, and removing
it would simplify both our home-grown VIRTIO_DEVICE_PROTOCOL, and the
virtio drivers.

But it's extra work, not entirely risk-free (regressions), and I can't
tell if someone out there still uses virtio-mmio (despite me thinking
that would be unreasonable). I wouldn't like to see more work sunk into
it either way :)

Laszlo

