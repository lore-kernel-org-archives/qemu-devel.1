Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD327C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831DC20650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831DC20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9mTM-0000xK-El
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1i9mS2-0000QC-3L
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1i9mRz-0004Bk-Jr
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:33:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1i9mRz-0004Aq-DA
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:33:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED99310CC1F0;
 Mon, 16 Sep 2019 08:33:31 +0000 (UTC)
Received: from [10.72.12.103] (ovpn-12-103.pek2.redhat.com [10.72.12.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D6655D9DC;
 Mon, 16 Sep 2019 08:33:27 +0000 (UTC)
To: "Tian, Kevin" <kevin.tian@intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
Date: Mon, 16 Sep 2019 16:33:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 16 Sep 2019 08:33:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
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
Cc: "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/9/16 =E4=B8=8A=E5=8D=889:51, Tian, Kevin wrote:
> Hi, Jason
>
> We had a discussion about dirty page tracking in VFIO, when vIOMMU
> is enabled:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg02690.html
>
> It's actually a similar model as vhost - Qemu cannot interpose the fast=
-path
> DMAs thus relies on the kernel part to track and report dirty page info=
rmation.
> Currently Qemu tracks dirty pages in GFN level, thus demanding a transl=
ation
> from IOVA to GPA. Then the open in our discussion is where this transla=
tion
> should happen. Doing the translation in kernel implies a device iotlb f=
lavor,
> which is what vhost implements today. It requires potentially large tra=
cking
> structures in the host kernel, but leveraging the existing log_sync flo=
w in Qemu.
> On the other hand, Qemu may perform log_sync for every removal of IOVA
> mapping and then do the translation itself, then avoiding the GPA aware=
ness
> in the kernel side. It needs some change to current Qemu log-sync flow,=
 and
> may bring more overhead if IOVA is frequently unmapped.
>
> So we'd like to hear about your opinions, especially about how you came
> down to the current iotlb approach for vhost.


We don't consider too much in the point when introducing vhost. And=20
before IOTLB, vhost has already know GPA through its mem table=20
(GPA->HVA). So it's nature and easier to track dirty pages at GPA level=20
then it won't any changes in the existing ABI.

For VFIO case, the only advantages of using GPA is that the log can then=20
be shared among all the devices that belongs to the VM. Otherwise=20
syncing through IOVA is cleaner.

Thanks

>
> p.s. Alex's comment is also copied here from original thread.
>
>> So vhost must then be configuring a listener across system memory
>> rather than only against the device AddressSpace like we do in vfio,
>> such that it get's log_sync() callbacks for the actual GPA space rathe=
r
>> than only the IOVA space.  OTOH, QEMU could understand that the device
>> AddressSpace has a translate function and apply the IOVA dirty bits to
>> the system memory AddressSpace.  Wouldn't it make more sense for
>> QEMU
>> to perform a log_sync() prior to removing a MemoryRegionSection within
>> an AddressSpace and update the GPA rather than pushing GPA awareness
>> and potentially large tracking structures into the host kernel?
> Thanks
> Kevin
>

