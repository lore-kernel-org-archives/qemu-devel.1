Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8C9C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0C721721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0C721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHow-0003PQ-2A
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41074)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hiHgI-0004ao-Ur
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hiHgH-0002cj-Eu
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:14:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hiHgB-0002UV-HY; Tue, 02 Jul 2019 08:14:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A5F16749D;
 Tue,  2 Jul 2019 12:14:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-172.ams2.redhat.com
 [10.36.117.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51CA360C67;
 Tue,  2 Jul 2019 12:14:06 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <20190702001301.4768-1-philmd@redhat.com>
 <20190702001301.4768-6-philmd@redhat.com>
 <5163b3e4-f68e-dc6b-3fcc-e7927ebc58e7@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f147ac70-298c-f323-360b-6a48857293d3@redhat.com>
Date: Tue, 2 Jul 2019 14:14:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5163b3e4-f68e-dc6b-3fcc-e7927ebc58e7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 02 Jul 2019 12:14:34 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/02/19 05:16, John Snow wrote:
>=20
>=20
> On 7/1/19 8:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> A "system reset" sets the device state machine in READ_ARRAY mode
>> and, after some delay, set the SR.7 READY bit.
>>
>> We do not model timings, so we set the SR.7 bit directly.
>>
>> This pflash device is a child of TYPE_DEVICE.
>> The TYPE_DEVICE interface provide a DeviceReset handler which will
>> be called after the device is realized, and each time the machine
>> resets itself.
>>
>> To avoid incoherent states when the machine resets (see but report
>> below), factor out the reset code into pflash_cfi01_system_reset,
>> and register the method as a device reset callback.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Does reset always get called as part of realize, really?

I'm not an expert on this, but I believe the following happens.

(1) When a device is hotplugged, the device is reset as part of realize
in the following call stack:

device_set_realized() [hw/core/qdev.c]
  device_reset()      [hw/core/qdev.c]


(2) For when the device is cold-plugged, we have, in main()
[hw/core/qdev.c]:

    /* TODO: once all bus devices are qdevified, this should be done
     * when bus is created by qdev.c */
    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());

and then a bit later

    qemu_system_reset(SHUTDOWN_CAUSE_NONE);

AIUI it results in a recursive traversal / reset,

qbus_reset_all_fn()      [hw/core/qdev.c]
  qbus_reset_all()       [hw/core/qdev.c]
    qbus_walk_children() [hw/core/bus.c]
      qdev_reset_one()   [hw/core/qdev.c]
        device_reset()   [hw/core/qdev.c]


In other words, I think you have a point about clarifying the commit
message. It's likely not that the device is re-set (a) after it is
realized *and* (b) each time the machine is re-set. Because, pflash is
not hot-plugged, so reset-on-hotplug does not apply, and so case (a)
falls away. Instead, case (b), "each time the machine is re-set",
includes the initial launch of the machine, and that is why pflash is
ultimately re-set at startup. It does happen after realize, but not as
part of it.

Anyway, Phil can verify this easily: just set a breakpoint on
pflash_cfi01_system_reset() in gdb before launching qemu, and get a
backtrace once the breakpoint fires. :)

Thanks
Laszlo

> Or are we just trusting that the device is probably going to get reset
> by the guest during bringup?
>=20
>> ---
>>  hw/block/pflash_cfi01.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index dd1dfd266b..8d632ea941 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -763,8 +763,6 @@ static void pflash_cfi01_realize(DeviceState *dev,=
 Error **errp)
>>          pfl->max_device_width =3D pfl->device_width;
>>      }
>> =20
>> -    pflash_mode_read_array(pfl);
>> -    pfl->status =3D 0x80; /* WSM ready */
>>      /* Hardcoded CFI table */
>>      /* Standard "QRY" string */
>>      pfl->cfi_table[0x10] =3D 'Q';
>> @@ -852,6 +850,18 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
>>      pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
>>  }
>> =20
>> +static void pflash_cfi01_system_reset(DeviceState *dev)
>> +{
>> +    PFlashCFI01 *pfl =3D PFLASH_CFI01(dev);
>> +
>> +    pflash_mode_read_array(pfl);
>> +    /*
>> +     * The WSM ready timer occurs at most 150ns after system reset.
>> +     * This model deliberately ignores this delay.
>> +     */
>> +    pfl->status =3D 0x80;
>> +}
>> +
>>  static Property pflash_cfi01_properties[] =3D {
>>      DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
>>      /* num-blocks is the number of blocks actually visible to the gue=
st,
>> @@ -896,6 +906,7 @@ static void pflash_cfi01_class_init(ObjectClass *k=
lass, void *data)
>>  {
>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>> =20
>> +    dc->reset =3D pflash_cfi01_system_reset;
>>      dc->realize =3D pflash_cfi01_realize;
>>      dc->props =3D pflash_cfi01_properties;
>>      dc->vmsd =3D &vmstate_pflash;
>>
>=20


