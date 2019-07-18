Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BE9C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 18:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0532173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 18:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0532173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoBIq-0007cW-5x
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 14:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hoBIf-0007B7-8h
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 14:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hoBIb-0004sf-GE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 14:38:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hoBIW-0004pI-5e; Thu, 18 Jul 2019 14:38:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF55730C31BD;
 Thu, 18 Jul 2019 18:38:29 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-25.ams2.redhat.com
 [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A08F600CC;
 Thu, 18 Jul 2019 18:38:21 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190718104837.13905-1-philmd@redhat.com>
 <20190718104837.13905-2-philmd@redhat.com>
 <5e6b8a67-8f8a-3e3b-4f42-db2a31c03ad1@redhat.com>
Message-ID: <d4d20337-b504-0610-8aaf-c8b0b13f0953@redhat.com>
Date: Thu, 18 Jul 2019 20:38:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5e6b8a67-8f8a-3e3b-4f42-db2a31c03ad1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 18 Jul 2019 18:38:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v7 1/1] hw/block/pflash_cfi01: Add
 missing DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/18/19 17:03, Laszlo Ersek wrote:
> On 07/18/19 12:48, Philippe Mathieu-Daud=C3=A9 wrote:
>> To avoid incoherent states when the machine resets (see but report
>=20
> (1) For the PULL request, please fix the typo: s/but/bug/
>=20
>> below), add the device reset callback.
>>
>> A "system reset" sets the device state machine in READ_ARRAY mode
>> and, after some delay, set the SR.7 READY bit.
>>
>> Since we do not model timings, we set the SR.7 bit directly.
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
>> Reported-by: Laszlo Ersek <lersek@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  hw/block/pflash_cfi01.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 435be1e35c..a1ec1faae5 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -865,6 +865,24 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
>>      pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
>>  }
>> =20
>> +static void pflash_cfi01_system_reset(DeviceState *dev)
>> +{
>> +    PFlashCFI01 *pfl =3D PFLASH_CFI01(dev);
>> +
>> +    /*
>> +     * The command 0x00 is not assigned by the CFI open standard,
>> +     * but QEMU historically uses it for the READ_ARRAY command (0xff=
).
>> +     */
>> +    pfl->cmd =3D 0x00;
>> +    pfl->wcycle =3D 0;
>> +    memory_region_rom_device_set_romd(&pfl->mem, true);
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
>> @@ -909,6 +927,7 @@ static void pflash_cfi01_class_init(ObjectClass *k=
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
> (2) Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>=20
> A *future* improvement (meant just for this surgical reset handler --
> not meaning any large cfi01 overhaul!) could be the addition of a trace
> point, at the top of pflash_cfi01_system_reset().
>=20
> But that is strictly "nice to have", and not necessary to include in th=
e
> present bugfix.
>=20
>=20
> (3) Using OVMF IA32X64 (including the edk2 SMM stack), I've
> regression-tested this patch, on top of v4.1.0-rc1, with KVM. As follow=
s:
>=20
> (3a) Normal reboot from the UEFI shell ("reset -c" command)
>=20
> (3b) Normal reboot from the Linux guest prompt ("reboot" command)
>=20
> (3c1) Reset as part of ACPI S3 suspend/resume
> (3c2) then use "efibootmgr -n / -N" to write to pflash (by virtue of
> setting / deleting the standardized BootNext UEFI variable)
>=20
> (3d1) Boot to setup TUI with SB enabled
> (3d2) erase Platform Key in setup TUI (disables SB)
> (3d3) reboot from within setup TUI
> (3d4) proceed to UEFI shell
> (3d5) enable SB with EnrollDefaultKeys.efi
> (3d6) reboot from UEFI shell
> (3d7) proceeed to Linux guest
> (3d8) verify SB enablement (dmesg, "mokutil --sb-state")
>=20
> (As an added exercise, step (3d4) triggered an "FTW" (fault tolerant
> write) "reclaim" (basically a defragmentation of the journaled
> "filesystem" that the firmware keeps in the flash, as a logical "middle
> layer"), and that worked fine too.)
>=20
> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
>=20
>=20
> (4) I plan to provide R-t-b in the evening from aarch64 KVM too, using
> the edk2 ArmVirtQemu firmware. Only the first two steps from (3) will b=
e
> covered (no ACPI S3, no SB).

Regression-tested-by: Laszlo Ersek <lersek@redhat.com>


