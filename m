Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB99CC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4EC20656
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4EC20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCfW-0004e7-H0
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1iUCVN-0002BT-99
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1iUCVK-0005Xl-Nz
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:25:27 -0500
Received: from david.siemens.de ([192.35.17.14]:43638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1iUCVJ-0005SA-Vk
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:25:26 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by david.siemens.de (8.15.2/8.15.2) with ESMTPS id xABGP8Fw031243
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Nov 2019 17:25:08 +0100
Received: from [139.25.68.37] ([139.25.68.37])
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id xABGP8vd009037;
 Mon, 11 Nov 2019 17:25:08 +0100
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
 <20191111084327-mutt-send-email-mst@kernel.org>
 <0b0475c1-2564-f433-46d8-ff1a06c13569@siemens.com>
 <20191111100607-mutt-send-email-mst@kernel.org>
 <20191111152743.GM814211@redhat.com>
 <129c527c-1e61-8c0c-3ca1-fe93e26c8bd2@siemens.com>
 <20191111111203-mutt-send-email-mst@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <402f66c9-2038-7fa9-ce02-850b20edf36b@siemens.com>
Date: Mon, 11 Nov 2019 17:25:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111111203-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id
 xABGP8Fw031243
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 192.35.17.14
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11.11.19 17:14, Michael S. Tsirkin wrote:
> On Mon, Nov 11, 2019 at 04:42:52PM +0100, Jan Kiszka wrote:
>> On 11.11.19 16:27, Daniel P. Berrang=E9 wrote:
>>> On Mon, Nov 11, 2019 at 10:08:20AM -0500, Michael S. Tsirkin wrote:
>>>> On Mon, Nov 11, 2019 at 02:59:07PM +0100, Jan Kiszka wrote:
>>>>> On 11.11.19 14:45, Michael S. Tsirkin wrote:
>>>>>> On Mon, Nov 11, 2019 at 01:57:11PM +0100, Jan Kiszka wrote:
>>>>>>> +| Offset | Register               | Content                     =
                         |
>>>>>>> +|-------:|:-----------------------|:----------------------------=
-------------------------|
>>>>>>> +|    00h | Vendor ID              | 1AF4h                       =
                         |
>>>>>>> +|    02h | Device ID              | 1110h                       =
                         |
>>>>>>
>>>>>> Given it's a virtio vendor ID, please reserve a device ID
>>>>>> with the virtio TC.
>>>>>
>>>>> Yeah, QEMU's IVSHMEM was always using that. I'm happy to make this =
finally
>>>>> official.
>>>>>
>>>>
>>>> And I guess we will just mark it reserved or something right?
>>>> Since at least IVSHMEM 1 isn't a virtio device.
>>>> And will you be reusing same ID for IVSHMEM 2 or a new one?
>>>
>>> 1110h isn't under either of the virtio PCI device ID allowed ranges
>>> according to the spec:
>>>
>>>     "Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device
>>>      ID 0x1000 through 0x107F inclusive is a virtio device.
>>>      ...
>>>      Additionally, devices MAY utilize a Transitional PCI Device
>>>      ID range, 0x1000 to 0x103F depending on the device type. "
>>>
>>> So there's no need to reserve 0x1110h from the virtio spec POV.
>>
>> Indeed.
>>
>>>
>>> I have, however, ensured it is assigned to ivshmem from POV of
>>> Red Hat's own internal tracking of allocated device IDs, under
>>> its vendor ID.
>>>
>>> If ivshmem 2 is now a virtio device, then it is a good thing that
>>> it will get a new/different PCI device ID, to show that it is not
>>> compatible with the old device impl.
>>
>> At this stage, it is just a PCI device that may be used in combination=
 with
>> virtio (stacked on top), but it is not designed like a normal virtio (=
PCI)
>> device. That's because it lacks many properties of regular virtio devi=
ces,
>> like queues.
>>
>> So, if such a device could be come part of the virtio spec, it would b=
e
>> separate from the rest, and having an ID from the regular range would =
likely
>> not be helpful in this regard.
>>
>> Jan
>=20
> I agree it needs a separate ID not from the regular range.
> It's a distinct transport.
> Maybe even a distinct vendor ID - we could easily get another one
> if needed.

That might be useful because I've seen the kernel's virtio-pci driver=20
grabbing ivshmem devices from time to time. OTOH, that could likely also=20
be improved in Linux, at least for future versions.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

