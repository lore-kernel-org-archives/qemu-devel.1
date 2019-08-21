Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F8C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535532339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 20:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FsspSgt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535532339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0XIo-0000Ob-GO
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 16:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1i0XHE-00077c-Et
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1i0XHD-0007oN-Av
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:32:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1i0XHD-0007na-2q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 16:32:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d5daa4d0001>; Wed, 21 Aug 2019 13:32:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 21 Aug 2019 13:32:14 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 21 Aug 2019 13:32:14 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 20:32:13 +0000
Received: from [10.24.71.106] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 20:32:06 +0000
To: Cornelia Huck <cohuck@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-2-git-send-email-kwankhede@nvidia.com>
 <20190716145632.3b73b73d@x1.home> <20190723141357.7b10c4f2.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <c57e0ae6-566f-e895-5e07-14b0965f2d0f@nvidia.com>
Date: Thu, 22 Aug 2019 02:02:03 +0530
MIME-Version: 1.0
In-Reply-To: <20190723141357.7b10c4f2.cohuck@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL109.nvidia.com (172.20.187.15) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1566419534; bh=srGXPPz+dqxhjdVi7XRnuXJsOEOr2zN8R1EsuPc15wY=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=FsspSgt6igzkuTL12dDcHcalfrGi6WElcjc9zNDUpGas+FKKro3R8KZI6sTaHWQsP
 0VHNm/+PKdD2NeJ+avEwQC48Ztp3mt3VKYU4N3M6SVWPlcZtzijBBrfLd/T2brcp9+
 a9MznE0f//i7jp7ElvhBOtEqw6hvz2Onla0v6WVs3JfAVjepFvoQl7NzcNtsdCU+sa
 HK4qwJD1FGD15YiQJ/DSWT5N+4T+m/YAMzQDILkI03zyWOxSmtUH0fIll63Wj/Knc/
 zDXaz6fXm+4hThTRvaKHPTF6WgR91OR1fz+Q3Km478tJe9VCcOyg1lqPkwKkzlWFes
 7MzNwNXhufU7w==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: Re: [Qemu-devel] [PATCH v7 01/13] vfio: KABI for migration interface
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 eskultet@redhat.com, ziye.yang@intel.com, Ken.Xue@amd.com,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 yan.y.zhao@intel.com, mlevitsk@redhat.com, changpeng.liu@intel.com,
 zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/23/2019 5:43 PM, Cornelia Huck wrote:
> On Tue, 16 Jul 2019 14:56:32 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
>> On Tue, 9 Jul 2019 15:19:08 +0530
>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> I'm still a bit unsure about the device_state bit handling as well.
> 
>>> + * device_state: (read/write)
>>> + *      To indicate vendor driver the state VFIO device should be transitioned
>>> + *      to. If device state transition fails, write on this field return error.
> 
> Does 'device state transition fails' include 'the device state written
> was invalid'?
> 

Yes.

>>> + *      It consists of 3 bits:
>>> + *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
>>> + *        _STOPPED state. When device is changed to _STOPPED, driver should stop
>>> + *        device before write() returns.
> 
> So _STOPPED is always !_RUNNING, regardless of which other bits are set?
>

Yes.

>>> + *      - If bit 1 set, indicates _SAVING state.
>>> + *      - If bit 2 set, indicates _RESUMING state.
>>> + *      _SAVING and _RESUMING set at the same time is invalid state.  
> 
> What about _RUNNING | _RESUMING -- does that make sense?
>

I think this will be valid state in postcopy case, though I'm not very sure.


>>
>> I think in the previous version there was a question of how we handle
>> yet-to-be-defined bits.  For instance, if we defined a
>> SUBTYPE_MIGRATIONv2 with the intention of making it backwards
>> compatible with this version, do we declare the undefined bits as
>> preserved so that the user should do a read-modify-write operation?
> 
> Or can we state that undefined bits are ignored, and may or may not
> preserved, so that we can skip the read-modify-write requirement? v1
> and v2 can hopefully be distinguished in a different way.
> 

Updating comment in next version.

Thanks,
Kirti

> (...)
> 
>>> +struct vfio_device_migration_info {
>>> +        __u32 device_state;         /* VFIO device state */
>>> +#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
>>> +#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
>>> +#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
>>> +#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
>>> +                                     VFIO_DEVICE_STATE_SAVING | \
>>> +                                     VFIO_DEVICE_STATE_RESUMING)  
>>
>> Yes, we have the mask in here now, but no mention above how the user
>> should handle undefined bits.  Thanks,
>>
>> Alex
>>
>>> +#define VFIO_DEVICE_STATE_INVALID   (VFIO_DEVICE_STATE_SAVING | \
>>> +                                     VFIO_DEVICE_STATE_RESUMING)
> 
> As mentioned above, does _RESUMING | _RUNNING make sense?
> 

