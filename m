Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A4AC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866C1206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866C1206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJtW-0004tk-HN
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50116)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hiJr0-0002Vy-UG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hiJqz-0005xR-T1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:33:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hiJql-0005gE-1g; Tue, 02 Jul 2019 10:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4D1D781DFC;
 Tue,  2 Jul 2019 14:33:18 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-172.ams2.redhat.com
 [10.36.117.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3BA01001DD5;
 Tue,  2 Jul 2019 14:32:37 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
References: <20190702001301.4768-1-philmd@redhat.com>
 <20190702001301.4768-6-philmd@redhat.com>
 <5163b3e4-f68e-dc6b-3fcc-e7927ebc58e7@redhat.com>
 <CAFEAcA_n3BpZuBPFS8y90XaOwzAo-tuKpO24_apz+9yzpxUxHQ@mail.gmail.com>
 <633b88d8-88d0-3fa0-ff25-63935d8806fe@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d70226ca-4c54-f3f7-5284-482f3207d76d@redhat.com>
Date: Tue, 2 Jul 2019 16:32:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <633b88d8-88d0-3fa0-ff25-63935d8806fe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 02 Jul 2019 14:33:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 5/9] hw/block/pflash_cfi01: Add the
 DeviceReset() handler
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc <qemu-ppc@nongnu.org>, Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/19 11:37, Philippe Mathieu-Daud=C3=A9 wrote:
> On 7/2/19 11:23 AM, Peter Maydell wrote:
>> On Tue, 2 Jul 2019 at 04:16, John Snow <jsnow@redhat.com> wrote:
>>> Does reset always get called as part of realize, really?
>>>
>>> Or are we just trusting that the device is probably going to get rese=
t
>>> by the guest during bringup?
>>
>> Reset is not called "as part of realize", but it is guaranteed
>> to be called after realize and before we try to run the guest,
>> as long as the device is in the qbus tree. Things are in the
>> qbus tree if either:
>>  * they're plugged into something already in the tree (eg
>>    pci devices, scsi disks)
>>  * they're a sysbus device (which is automatically plugged into
>>    the 'main system bus' which is effectively the root of the
>>    qbus tree)
>>
>> In this case TYPE_PFLASH_CFI01 is a subclass of TYPE_SYS_BUS_DEVICE,
>> so it will always be reset as part of system reset.
>>
>> (the main things which don't get automatically reset are direct
>> subclasses of TYPE_DEVICE, notably CPU objects.)
>=20
> Thanks for the clarification!
>=20
> I will update the commit description paraphrasing Peter:
>=20
>   The TYPE_DEVICE interface provides a DeviceReset handler.
>   This pflash device is a subclass of TYPE_SYS_BUS_DEVICE (which
>   is a subclass of TYPE_DEVICE).
>   SYS_BUS devices are automatically plugged into the 'main system
>   bus', which is the root of the qbus tree.
>   Devices in the qbus tree are guaranteed to have their reset()
>   handler called after realize() and before we try to run the guest.
>=20
>   To avoid incoherent states when the machine resets (see but report
>   below), factor out the reset code into pflash_cfi01_system_reset,
>   and register the method as a device reset callback.
>=20
> John, Laszlo, is that OK with you?

works for me, sure.

Thanks
Laszlo

