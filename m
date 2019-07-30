Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198ADC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C8E20644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C8E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsUf2-00066c-NF
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 12:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50341)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hsUeK-0005Es-Fg
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hsUeJ-0007is-It
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:06:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hsUeJ-0007hN-Cy
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81819285AE;
 Tue, 30 Jul 2019 16:06:49 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF73160BF7;
 Tue, 30 Jul 2019 16:06:43 +0000 (UTC)
To: Sergio Lopez <slp@redhat.com>, mst@redhat.com
References: <20190729125755.45008-1-slp@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
Date: Tue, 30 Jul 2019 18:06:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190729125755.45008-1-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 30 Jul 2019 16:06:49 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/29/19 14:57, Sergio Lopez wrote:
> Implement the modern (v2) personality, according to the VirtIO 1.0
> specification.
> 
> Support for v2 among guests is not as widespread as it'd be
> desirable. While the Linux driver has had it for a while, support is
> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.

That's right; not only are there no plans to implement virtio-mmio/1.0
for OVMF (to my knowledge), I'd even argue against such efforts.

OVMF is a heavy-weight guest firmware, which I see entirely out of scope
for "micro VMs". And so virtio-mmio/1.0 would seem like a needless &
unwelcome complication, from the OVMF maintainership perspective.

(This should not be construed as an argument against "micro VMs" -- I
always say, identify your use case, then pick the right components for
it. I never try to convince people to use OVMF indiscriminately.)

> For this reason, the v2 personality is disabled, keeping the legacy
> behavior as default. Machine types willing to use v2, can enable it
> using MachineClass's compat_props.

This approach makes me happy (with the understanding that edk2 guest
firmware is not going to target the new machine type(s) in question).

Thanks!
Laszlo

