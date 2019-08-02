Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003F0C0650F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 22:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44A22087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 22:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44A22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htg86-0002ll-55
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 18:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59104)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1htg7T-0002Ld-9J
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 18:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1htg7R-0006Me-GI
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 18:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1htg7R-0006MG-Ae
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 18:33:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 636932DD3B;
 Fri,  2 Aug 2019 22:33:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-36.ams2.redhat.com
 [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0593600C1;
 Fri,  2 Aug 2019 22:33:41 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190729125755.45008-1-slp@redhat.com>
 <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
 <9953cc99-80b3-814c-f75e-a16c987c23e5@redhat.com>
 <9b2acff6-8c6d-3aa0-8020-d6d831222496@redhat.com>
 <CAFEAcA9fHPpsvwXeKMnUbbHYu_=F+v+SF9ttAm+vOcXOmPVhMA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <665148f7-8b64-e6df-cd43-ee1306c7878a@redhat.com>
Date: Sat, 3 Aug 2019 00:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9fHPpsvwXeKMnUbbHYu_=F+v+SF9ttAm+vOcXOmPVhMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 02 Aug 2019 22:33:47 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Sergio Lopez Pascual <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/02/19 11:20, Peter Maydell wrote:
> On Fri, 2 Aug 2019 at 01:26, Laszlo Ersek <lersek@redhat.com> wrote:
>> But it's extra work, not entirely risk-free (regressions), and I can't
>> tell if someone out there still uses virtio-mmio (despite me thinking
>> that would be unreasonable). I wouldn't like to see more work sunk into
>> it either way :)
> 
> The main reasons I still see people using virtio-mmio for
> the 'virt' board are:
>  * still using old but working command lines
>  * newer setups that were put together working from older tutorials
>    that recommended virtio-mmio because they predated virtio-pci
>    support being widespread
>  * using older (eg distro) kernels -- for 32-bit kernels in
>    particular it was a while before the virtio-pci support
>    got built in the default configs I think, and then longer
>    again until those got into stable distro releases

There was one time when edk2 core modules gained a feature for marking
the DXE phase stack non-executable. We happily enabled it in OVMF. Then
people reported that UEFI grub in their old Debian guests had broken --
on their hosts carrying OVMF binaries built from upstream. :) We had to
flip the default off in OVMF, and we've stuck with that ever since...

  https://github.com/tianocore/edk2/commit/d20b06a3afdf

> I wouldn't be surprised if some of those applied also to
> via-OVMF boot setups as well as direct kernel boot. So it
> depends a bit what your tolerance for breaking existing
> user setups is.

Near zero. :)

Thanks
Laszlo

