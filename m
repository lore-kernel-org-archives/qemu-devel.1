Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D40CC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F52208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F52208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYU4-0002wu-36
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iDYTK-0002B6-1W
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iDYTI-0000Jw-Jp
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:26:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iDYT6-0000Ch-Aq; Thu, 26 Sep 2019 14:26:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B7483082B45;
 Thu, 26 Sep 2019 18:26:19 +0000 (UTC)
Received: from [10.18.17.231] (dhcp-17-231.bos.redhat.com [10.18.17.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9646C194B2;
 Thu, 26 Sep 2019 18:26:11 +0000 (UTC)
Subject: Re: [SeaBIOS] [PATCH v7 7/8] bootdevice: FW_CFG interface for LCHS
 values
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
Date: Thu, 26 Sep 2019 14:26:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 26 Sep 2019 18:26:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, kraxel@redhat.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/26/19 5:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Sam,
>=20
> On 9/25/19 1:06 PM, Sam Eiderman wrote:
>> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>>
>> Using fw_cfg, supply logical CHS values directly from QEMU to the BIOS=
.
>>
>> Non-standard logical geometries break under QEMU.
>>
>> A virtual disk which contains an operating system which depends on
>> logical geometries (consistent values being reported from BIOS INT13
>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has non-stand=
ard
>> logical geometries - for example 56 SPT (sectors per track).
>> No matter what QEMU will report - SeaBIOS, for large enough disks - wi=
ll
>> use LBA translation, which will report 63 SPT instead.
>>
>> In addition we cannot force SeaBIOS to rely on physical geometries at
>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
>> report more than 16 physical heads when moved to an IDE controller,
>> since the ATA spec allows a maximum of 16 heads - this is an artifact =
of
>> virtualization.
>>
>> By supplying the logical geometries directly we are able to support su=
ch
>> "exotic" disks.
>>
>> We serialize this information in a similar way to the "bootorder"
>> interface.
>> The new fw_cfg entry is "bios-geometry".
>>
>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
>> ---
>>  bootdevice.c            | 32 ++++++++++++++++++++++++++++++++
>>  hw/nvram/fw_cfg.c       | 14 +++++++++++---
>>  include/sysemu/sysemu.h |  1 +
>>  3 files changed, 44 insertions(+), 3 deletions(-)
>>
>> diff --git a/bootdevice.c b/bootdevice.c
>> index 2b12fb85a4..b034ad7bdc 100644
>> --- a/bootdevice.c
>> +++ b/bootdevice.c
>> @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState *dev, const=
 char *suffix)
>>          }
>>      }
>>  }
>> +
>> +/* Serialized as: (device name\0 + lchs struct) x devices */
>> +char *get_boot_devices_lchs_list(size_t *size)
>> +{
>> +    FWLCHSEntry *i;
>> +    size_t total =3D 0;
>> +    char *list =3D NULL;
>> +
>> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
>> +        char *bootpath;
>> +        char *chs_string;
>> +        size_t len;
>> +
>> +        bootpath =3D get_boot_device_path(i->dev, false, i->suffix);
>> +        chs_string =3D g_strdup_printf("%s %" PRIu32 " %" PRIu32 " %"=
 PRIu32,
>> +                                     bootpath, i->lcyls, i->lheads, i=
->lsecs);
>=20
> Hmm maybe we can g_free(bootpath) directly here.
>=20

I think it's okay to do it at the bottom of the loop. No real benefit to
being that eager to free resources in my mind. I expect setup at the top
of a block and teardown at the bottom of a block.

Trying to do too much in the middle gets messy in my opinion, not that
it seems to matter here.

>> +
>> +        if (total) {
>> +            list[total - 1] =3D '\n';
>> +        }
>> +        len =3D strlen(chs_string) + 1;
>> +        list =3D g_realloc(list, total + len);
>> +        memcpy(&list[total], chs_string, len);
>> +        total +=3D len;
>> +        g_free(chs_string);
>> +        g_free(bootpath);
>> +    }
>> +
>> +    *size =3D total;
>> +
>> +    return list;
>> +}
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 7dc3ac378e..18aff658c0 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const ch=
ar *filename,
>> =20
>>  static void fw_cfg_machine_reset(void *opaque)
>>  {
>> +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>> +    FWCfgState *s =3D opaque;
>>      void *ptr;
>>      size_t len;
>> -    FWCfgState *s =3D opaque;
>> -    char *bootindex =3D get_boot_devices_list(&len);
>> +    char *buf;
>> =20
>> -    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, =
len);
>> +    buf =3D get_boot_devices_list(&len);
>> +    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len);
>>      g_free(ptr);
>> +
>> +    if (!mc->legacy_fw_cfg_order) {
>> +        buf =3D get_boot_devices_lchs_list(&len);
>> +        ptr =3D fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)buf=
, len);
>=20
> OK. Can you add a test in tests/fw_cfg-test.c please?
>=20

:D

>> +        g_free(ptr);
>> +    }
>>  }
>> =20
>>  static void fw_cfg_machine_ready(struct Notifier *n, void *data)
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 5bc5c79cbc..80c57fdc4e 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -106,6 +106,7 @@ void validate_bootdevices(const char *devices, Err=
or **errp);
>>  void add_boot_device_lchs(DeviceState *dev, const char *suffix,
>>                            uint32_t lcyls, uint32_t lheads, uint32_t l=
secs);
>>  void del_boot_device_lchs(DeviceState *dev, const char *suffix);
>> +char *get_boot_devices_lchs_list(size_t *size);
>=20
> Please add some documentation. At least 'size' must be non-NULL.
>=20

Sure; but I wasn't going to gate on it because this series went unloved
for so long. At this point, a follow-up patch is fine.

> Ideally you should add doc for the other functions added in 3/8
> "bootdevice: Add interface to gather LCHS" too.
>=20

Same thing here.

> John, what do you think about extracting the *boot_device* functions ou=
t
> of "sysemu.h"?
>=20

Potentially worthwhile; but not critical at the moment. The source tree
is not the best-organized thing as-is and I don't think it's fair to
hold this series up for much longer for nice-to-haves, ultimately.

More targeted improvements might avoid the "whose responsibility is it
to stage this?" hot potato we played with this one; so I'd rather have
smaller follow-up patches handled by the respective maintainers.

> Thanks,
>=20
> Phil.
>=20
Thanks for the reviews :)

--js

