Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89791C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B1A222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B1A222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZLf-000225-F2
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDZ8y-0002k5-6F
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDZ8v-00065z-Ke
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:09:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDZ8v-00064n-Cn
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:09:33 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4AB5918C37B
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 19:09:32 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id t185so1419135wmg.4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 12:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lFbCZ3cujd0+mwFAQ9ciIaXXpuOMNFCZNmeNjOWtGag=;
 b=PT3NbcTbh3kkXY2G/stA8a8y8vNJ0RxWeZQ9jUDOL6MiM9xtHY5t0kzWTec5OdITSm
 qla8XPH1eB4Rg4Ws3xBkIgyhkjLOHD0nFx+cpcdl2h3jHpLFNgFMIc1vfGw0EKoW8t3s
 rRF6pm0Sk+aqHBwF4pGk53he9oDL1s1woGTYM3bcW75KbnonhDABkmJlXbawbC4/QuNn
 2ppozB0w+2eS3tvooacnj6K9vCxN8O9zlHKcI3Zo+/XuIwB761sIfE/EfBJJ9NtCd8qL
 TY8oW+jTfLSRpN5o3RHNME7EPcKY6aoOVwyKPFYwWU/et1DYXHn5F/tGus/9e5b6AF9b
 X6Rw==
X-Gm-Message-State: APjAAAWafe0//5lgjPlsky2TZhuLA2W04T87+d2j0H32217mlT/NaXFp
 KDzqcY234vF6eYBGyvwjltYsLluYDX4CivF5HfunrvQqQNlaKEzPy6JMH4XhNiPooZMFVuk0SP2
 LyObKPDFTIot1QtM=
X-Received: by 2002:a1c:3904:: with SMTP id g4mr4457376wma.116.1569524970973; 
 Thu, 26 Sep 2019 12:09:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQanHpzIXwrJgfpEC1shajy/MtlBRcgILJiSdjI+B+yv0BbArbrGbtCBuZSOaoxUT4gpoC4A==
X-Received: by 2002:a1c:3904:: with SMTP id g4mr4457360wma.116.1569524970745; 
 Thu, 26 Sep 2019 12:09:30 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s10sm6018634wmf.48.2019.09.26.12.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 12:09:30 -0700 (PDT)
Subject: Re: [SeaBIOS] [PATCH v7 7/8] bootdevice: FW_CFG interface for LCHS
 values
To: John Snow <jsnow@redhat.com>, Sam Eiderman <sameid@google.com>,
 qemu-devel@nongnu.org
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
Date: Thu, 26 Sep 2019 21:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 9/26/19 8:26 PM, John Snow wrote:
> On 9/26/19 5:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Sam,
>>
>> On 9/25/19 1:06 PM, Sam Eiderman wrote:
>>> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>>>
>>> Using fw_cfg, supply logical CHS values directly from QEMU to the BIO=
S.
>>>
>>> Non-standard logical geometries break under QEMU.
>>>
>>> A virtual disk which contains an operating system which depends on
>>> logical geometries (consistent values being reported from BIOS INT13
>>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has non-stan=
dard
>>> logical geometries - for example 56 SPT (sectors per track).
>>> No matter what QEMU will report - SeaBIOS, for large enough disks - w=
ill
>>> use LBA translation, which will report 63 SPT instead.
>>>
>>> In addition we cannot force SeaBIOS to rely on physical geometries at
>>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
>>> report more than 16 physical heads when moved to an IDE controller,
>>> since the ATA spec allows a maximum of 16 heads - this is an artifact=
 of
>>> virtualization.
>>>
>>> By supplying the logical geometries directly we are able to support s=
uch
>>> "exotic" disks.
>>>
>>> We serialize this information in a similar way to the "bootorder"
>>> interface.
>>> The new fw_cfg entry is "bios-geometry".
>>>
>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
>>> ---
>>>  bootdevice.c            | 32 ++++++++++++++++++++++++++++++++
>>>  hw/nvram/fw_cfg.c       | 14 +++++++++++---
>>>  include/sysemu/sysemu.h |  1 +
>>>  3 files changed, 44 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/bootdevice.c b/bootdevice.c
>>> index 2b12fb85a4..b034ad7bdc 100644
>>> --- a/bootdevice.c
>>> +++ b/bootdevice.c
>>> @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState *dev, cons=
t char *suffix)
>>>          }
>>>      }
>>>  }
>>> +
>>> +/* Serialized as: (device name\0 + lchs struct) x devices */
>>> +char *get_boot_devices_lchs_list(size_t *size)
>>> +{
>>> +    FWLCHSEntry *i;
>>> +    size_t total =3D 0;
>>> +    char *list =3D NULL;
>>> +
>>> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
>>> +        char *bootpath;
>>> +        char *chs_string;
>>> +        size_t len;
>>> +
>>> +        bootpath =3D get_boot_device_path(i->dev, false, i->suffix);
>>> +        chs_string =3D g_strdup_printf("%s %" PRIu32 " %" PRIu32 " %=
" PRIu32,
>>> +                                     bootpath, i->lcyls, i->lheads, =
i->lsecs);
>>
>> Hmm maybe we can g_free(bootpath) directly here.
>>
>=20
> I think it's okay to do it at the bottom of the loop. No real benefit t=
o
> being that eager to free resources in my mind. I expect setup at the to=
p
> of a block and teardown at the bottom of a block.
>=20
> Trying to do too much in the middle gets messy in my opinion, not that
> it seems to matter here.

No problem.

>>> +
>>> +        if (total) {
>>> +            list[total - 1] =3D '\n';
>>> +        }
>>> +        len =3D strlen(chs_string) + 1;
>>> +        list =3D g_realloc(list, total + len);
>>> +        memcpy(&list[total], chs_string, len);
>>> +        total +=3D len;
>>> +        g_free(chs_string);
>>> +        g_free(bootpath);
>>> +    }
>>> +
>>> +    *size =3D total;
>>> +
>>> +    return list;
>>> +}
>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>> index 7dc3ac378e..18aff658c0 100644
>>> --- a/hw/nvram/fw_cfg.c
>>> +++ b/hw/nvram/fw_cfg.c
>>> @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const c=
har *filename,
>>> =20
>>>  static void fw_cfg_machine_reset(void *opaque)
>>>  {
>>> +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>>> +    FWCfgState *s =3D opaque;
>>>      void *ptr;
>>>      size_t len;
>>> -    FWCfgState *s =3D opaque;
>>> -    char *bootindex =3D get_boot_devices_list(&len);
>>> +    char *buf;
>>> =20
>>> -    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex,=
 len);
>>> +    buf =3D get_boot_devices_list(&len);
>>> +    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len);
>>>      g_free(ptr);
>>> +
>>> +    if (!mc->legacy_fw_cfg_order) {
>>> +        buf =3D get_boot_devices_lchs_list(&len);
>>> +        ptr =3D fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)bu=
f, len);
>>
>> OK. Can you add a test in tests/fw_cfg-test.c please?
>>
>=20
> :D
>=20
>>> +        g_free(ptr);
>>> +    }
>>>  }
>>> =20
>>>  static void fw_cfg_machine_ready(struct Notifier *n, void *data)
>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>> index 5bc5c79cbc..80c57fdc4e 100644
>>> --- a/include/sysemu/sysemu.h
>>> +++ b/include/sysemu/sysemu.h
>>> @@ -106,6 +106,7 @@ void validate_bootdevices(const char *devices, Er=
ror **errp);
>>>  void add_boot_device_lchs(DeviceState *dev, const char *suffix,
>>>                            uint32_t lcyls, uint32_t lheads, uint32_t =
lsecs);
>>>  void del_boot_device_lchs(DeviceState *dev, const char *suffix);
>>> +char *get_boot_devices_lchs_list(size_t *size);
>>
>> Please add some documentation. At least 'size' must be non-NULL.
>>
>=20
> Sure; but I wasn't going to gate on it because this series went unloved
> for so long. At this point, a follow-up patch is fine.

OK

>=20
>> Ideally you should add doc for the other functions added in 3/8
>> "bootdevice: Add interface to gather LCHS" too.
>>
>=20
> Same thing here.
>=20
>> John, what do you think about extracting the *boot_device* functions o=
ut
>> of "sysemu.h"?
>>
>=20
> Potentially worthwhile; but not critical at the moment. The source tree
> is not the best-organized thing as-is and I don't think it's fair to
> hold this series up for much longer for nice-to-haves, ultimately.
>=20
> More targeted improvements might avoid the "whose responsibility is it
> to stage this?" hot potato we played with this one; so I'd rather have
> smaller follow-up patches handled by the respective maintainers.

Sure, fair enough.

>=20
>> Thanks,
>>
>> Phil.
>>
> Thanks for the reviews :)

:)

