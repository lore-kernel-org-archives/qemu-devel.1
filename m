Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D8C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24C52083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24C52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdyOA-0007JZ-6Q
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:50:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39353)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hdy9k-0004D8-Ky
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hdy9h-0006G6-Ho
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:35:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hdxTz-0006oi-Fl
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:52:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E40B308FC4A
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 13:52:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-226.ams2.redhat.com
 [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE0D21001E6F;
 Thu, 20 Jun 2019 13:51:51 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
References: <20190310004749.27029-1-philmd@redhat.com>
 <20190310004749.27029-3-philmd@redhat.com>
 <5e2f3651-5f00-0c93-353e-e58f079998e9@redhat.com>
 <124e54f9-c7e1-0157-61f1-673154872749@redhat.com>
 <88b7370c-1b6f-11e0-9fbe-d532e5726aa6@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c5fed053-5dcf-afef-010b-c261741c748f@redhat.com>
Date: Thu, 20 Jun 2019 15:51:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <88b7370c-1b6f-11e0-9fbe-d532e5726aa6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 20 Jun 2019 13:52:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/4] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/20/19 14:07, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Laszlo,
>=20
> On 3/13/19 11:11 AM, Laszlo Ersek wrote:
>> On 03/13/19 10:43, Laszlo Ersek wrote:
>>> On 03/10/19 01:47, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> The Edk2Crypto object is used to hold configuration values specific
>>>> to EDK2.
>>>>
>>>> The edk2_add_host_crypto_policy() function loads crypto policies
>>>> from the host, and register them as fw_cfg named file items.
>>>> So far only the 'https' policy is supported.
>>>>
>>>> A usercase example is the 'HTTPS Boof' feature of OVMF [*].
>>>>
>>>> Usage example:
>>>>
>>>>   $ qemu-system-x86_64 \
>>>>       --object edk2_crypto,id=3Dhttps,\
>>>>               ciphers=3D/etc/crypto-policies/back-ends/openssl.confi=
g,\
>>>>               cacerts=3D/etc/pki/ca-trust/extracted/edk2/cacerts.bin
>>>>
>>>> (On Fedora these files are provided by the ca-certificates and
>>>> crypto-policies packages).
>>>>
>>>> [*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>> v3:
>>>> - '-object' -> '--object' in commit description (Eric)
>>>> - reworded the 'TODO: g_free' comment
>>>> ---
>>>>  MAINTAINERS                             |   8 ++
>>>>  hw/Makefile.objs                        |   1 +
>>>>  hw/firmware/Makefile.objs               |   1 +
>>>>  hw/firmware/uefi_edk2_crypto_policies.c | 177 +++++++++++++++++++++=
+++
>>>>  include/hw/firmware/uefi_edk2.h         |  28 ++++
>>>>  5 files changed, 215 insertions(+)
>>>>  create mode 100644 hw/firmware/Makefile.objs
>>>>  create mode 100644 hw/firmware/uefi_edk2_crypto_policies.c
>>>>  create mode 100644 include/hw/firmware/uefi_edk2.h
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index cf09a4c127..70122b3d0d 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2206,6 +2206,14 @@ F: include/hw/i2c/smbus_master.h
>>>>  F: include/hw/i2c/smbus_slave.h
>>>>  F: include/hw/i2c/smbus_eeprom.h
>>>> =20
>>>> +EDK2 Firmware
>>>> +M: Laszlo Ersek <lersek@redhat.com>
>>>> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> +S: Maintained
>>>> +F: docs/interop/firmware.json
>>>> +F: hw/firmware/uefi_edk2_crypto_policies.c
>>>> +F: include/hw/firmware/uefi_edk2.h
>>>> +
>>>
>>> I'm not happy with this.
>>>
>>> First, "docs/interop/firmware.json" is meant for more than just EDK2.=
 We
>>> shouldn't list it in a section called "EDK2 Firmware". I can't sugges=
t
>>> an alternative (MAINTAINERS is *huge* -- 2500+ lines), but this one
>>> would be misleading.
>>>
>>> Second, we expose fw_cfg files to edk2 platform firmware from a bunch=
 of
>>> other places. For example -- and in this case I do mean to provide a
>>> complex example! --, see "etc/smi/supported-features",
>>> "etc/smi/requested-features", and "etc/smi/features-ok", in file
>>> "hw/isa/lpc_ich9.c". I'm unconvinced that the present feature merits =
new
>>> directories and new files.
>>>
>>> Then again, I also don't know where to put the logic. I guess I'll ha=
ve
>>> to defer to more experienced reviewers.
>>>
>>> [snipping lots of QOM boilerplate]
>>>
>>>> +void edk2_add_host_crypto_policy(FWCfgState *fw_cfg)
>>>> +{
>>>> +    Edk2Crypto *s;
>>>> +
>>>> +    s =3D edk2_crypto_by_id("https", NULL);
>>>> +    if (!s) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (s->ciphers_path) {
>>>> +        /*
>>>> +         * Note:
>>>> +         * Unlike with fw_cfg_add_file() where the allocated data h=
as
>>>> +         * to be valid for the lifetime of the FwCfg object, there =
is
>>>> +         * no such contract interface with fw_cfg_add_file_from_hos=
t().
>>>> +         * It would be easier that the FwCfg object keeps reference=
 of
>>>> +         * its allocated memory and releases it when destroy, but i=
t
>>>> +         * currently doesn't. Meanwhile we simply add this TODO com=
ment.
>>>> +         */
>>>> +        fw_cfg_add_file_from_host(fw_cfg, "etc/edk2/https/ciphers",
>>>> +                                  s->ciphers_path, NULL);
>>>> +    }
>>>> +
>>>> +    if (s->cacerts_path) {
>>>> +        /*
>>>> +         * TODO: g_free the returned pointer
>>>> +         * (see previous comment for ciphers_path in this function)=
.
>>>> +         */
>>>> +        fw_cfg_add_file_from_host(fw_cfg, "etc/edk2/https/cacerts",
>>>> +                                  s->cacerts_path, NULL);
>>>> +    }
>>>> +}
>>>
>>> Shouldn't we do some error checking here?
>>>
>>> I mean, printing an error message in fw_cfg_add_file_from_host(), and
>>> then continuing without exposing the named files in question to the
>>> firmware, could be OK if this was a "default on" feature. But (IIUC)
>>> here the user provided an explicit "-object" option, and we've just
>>> failed to construct the object. Doesn't such a situation usually prev=
ent
>>> QEMU startup?
>>
>> Wait, I could be totally confused here. (Returning to this patch after
>> seeing the rest of the series.)
>>
>> Is it actually the case that the Edk2Crypto object holds nothing more
>> than two pathnames -- and so its construction can virtually never fail=
?
>> While the actual fw_cfg population occurs separately, in a machine_don=
e
>> notifier?
>>
>> If that's the case, I don't think it's the right approach. Reading the
>> host files, and populating fw_cfg with them, should be part of the
>> object construction. And if those steps fail, the object should not be
>> possible to construct.
>>
>> We did something similar with the vmgenid device [hw/acpi/vmgenid.c], =
if
>> I remember correctly. It also has a dependency on fw_cfg...
>>
>> Ahh, no, I'm absolutely wrong about that. vmgenid_realize() doesn't do
>> anything with fw_cfg. Instead, we have acpi_setup() in
>> "hw/i386/acpi-build.c", which calls find_vmgenid_dev() and
>> vmgenid_add_fw_cfg(). And acpi_setup() is certainly called from
>> pc_machine_done().
>>
>> In other words, the pattern that you use here matches existing practic=
e.
>> Realize the device (or object) first, then add the fw_cfg thingies in
>> the "machine done" callback. OK.
>>
>> *Still*, I would like to see better error handling/reporting (or an
>> explanation why I'm wrong). How about reworking the edk2crypto class
>> itself -- it shouldn't just hold the pathnames of the files, but also
>> their contents. That is:
>>
>> - g_file_get_contents() should be called in the realize method
>> - the object would own the file contents
>> - the realize method would ensure that there wouldn't be any other
>> instance of the class (i.e. that it would be a singleton -- see the sa=
me
>> idea in vmgenid)
>> - there would be no need for the fw_cfg_add_file_from_host() API
>> - the machine done notifier would be extended to locate the object
>> (there could be zero or one instances), and if the one instance were
>> found, the machine done callback would hook the file contents into
>> fw_cfg. fw_cfg_add_file() cannot fail, so no errors to report at this =
stage.
>>
>> Again I think this would follow the pattern from vmgenid.
>=20
> I want to say I am impressed by your deep review. Your design is
> obviously way cleaner/safer. I think I was missing some part of the big
> picture here, thank you for your detailed comments!
>=20
> I did not know how vmgenid is processed. The only difference is I don't
> want the edk2crypto class to be a device, but rather a simple user
> object, and we already have an interface that does that:
> TYPE_USER_CREATABLE. Its UserCreatableClass::complete() method is
> similar to DeviceClass::realize() in managing errors at object
> instantiation, so the machine done notifier never fails.
> I'll respin.

Sounds good to me, thanks! Please do CC reviewers with QOM experience,
as I'm not familiar with TYPE_USER_CREATABLE.

Thanks!
Laszlo

