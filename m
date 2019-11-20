Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7167C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6182089D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 18:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6182089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUWl-00033N-Ox
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 13:16:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1iXUVn-0002Cd-I5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1iXUVm-0004Lr-AW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:15:31 -0500
Received: from gecko.sbs.de ([194.138.37.40]:45664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1iXUVm-0004Jt-1X
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 13:15:30 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id xAKIFQ8o022684
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 19:15:26 +0100
Received: from [139.25.68.37] ([139.25.68.37])
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id xAKIFMnn032384;
 Wed, 20 Nov 2019 19:15:23 +0100
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
 <20191111084327-mutt-send-email-mst@kernel.org>
 <0b0475c1-2564-f433-46d8-ff1a06c13569@siemens.com>
 <20191111100607-mutt-send-email-mst@kernel.org>
 <20191111152743.GM814211@redhat.com>
 <20191111105850-mutt-send-email-mst@kernel.org>
 <ef21ed49-d315-4ee5-716b-096d8af1d79c@siemens.com>
 <20191112024400-mutt-send-email-mst@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <78228aba-6e30-806b-2d17-0d18238b84cc@siemens.com>
Date: Wed, 20 Nov 2019 19:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191112024400-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gecko.sbs.de id
 xAKIFQ8o022684
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.138.37.40
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

On 12.11.19 09:04, Michael S. Tsirkin wrote:
> On Mon, Nov 11, 2019 at 05:38:29PM +0100, Jan Kiszka wrote:
>> On 11.11.19 17:11, Michael S. Tsirkin wrote:
>>> On Mon, Nov 11, 2019 at 03:27:43PM +0000, Daniel P. Berrang=E9 wrote:
>>>> On Mon, Nov 11, 2019 at 10:08:20AM -0500, Michael S. Tsirkin wrote:
>>>>> On Mon, Nov 11, 2019 at 02:59:07PM +0100, Jan Kiszka wrote:
>>>>>> On 11.11.19 14:45, Michael S. Tsirkin wrote:
>>>>>>> On Mon, Nov 11, 2019 at 01:57:11PM +0100, Jan Kiszka wrote:
>>>>>>>> +| Offset | Register               | Content                    =
                          |
>>>>>>>> +|-------:|:-----------------------|:---------------------------=
--------------------------|
>>>>>>>> +|    00h | Vendor ID              | 1AF4h                      =
                          |
>>>>>>>> +|    02h | Device ID              | 1110h                      =
                          |
>>>>>>>
>>>>>>> Given it's a virtio vendor ID, please reserve a device ID
>>>>>>> with the virtio TC.
>>>>>>
>>>>>> Yeah, QEMU's IVSHMEM was always using that. I'm happy to make this=
 finally
>>>>>> official.
>>>>>>
>>>>>
>>>>> And I guess we will just mark it reserved or something right?
>>>>> Since at least IVSHMEM 1 isn't a virtio device.
>>>>> And will you be reusing same ID for IVSHMEM 2 or a new one?
>>>>
>>>> 1110h isn't under either of the virtio PCI device ID allowed ranges
>>>> according to the spec:
>>>>
>>>>     "Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device
>>>>      ID 0x1000 through 0x107F inclusive is a virtio device.
>>>>      ...
>>>>      Additionally, devices MAY utilize a Transitional PCI Device
>>>>      ID range, 0x1000 to 0x103F depending on the device type. "
>>>>
>>>> So there's no need to reserve 0x1110h from the virtio spec POV.
>>>
>>> Well we do have:
>>>
>>> 	B.3
>>> 	What Device Number?
>>> 	Device numbers can be reserved by the OASIS committee: email virtio-=
dev@lists.oasis-open.org to secure
>>> 	a unique one.
>>> 	Meanwhile for experimental drivers, use 65535 and work backwards.
>>>
>>> So it seems it can  in theory conflict at least with experimental vir=
tio devices.
>>>
>>> Really it's messy that people are reusing the virtio vendor ID for
>>> random stuff - getting a vendor ID is only hard for a hobbyist, any b=
ig
>>> company already has an ID - but if it is a hobbyist and they at least
>>> register then doesn't cause much harm.
>>
>> Note that ivshmem came from a research environment. I do know if there=
 was a
>> check for the IDs at the point the code was merged.
>>
>> That said, I may get a device ID here as well, provided I can explain =
that
>> not a single "product" will own it, but rather an open specification.
>>
>> Jan
>=20
> OK, up to you - if you decide you want an ID reserved, pls let us know.
>=20

Turned out to be much simpler than expect:

I reserved device ID 4106h under the vendor ID 110Ah (Siemens AG) for=20
the purpose of specifying a shared memory device via the VIRTIO TC. Will=20
update this "detail" in the next revision of the patches, also resetting=20
the device revision ID to 0 as no longer need to tell us apart from the=20
current implementation this way.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

