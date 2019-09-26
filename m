Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEEBC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01751217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01751217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZXI-0006Z9-20
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDZFM-0003Rq-0e
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDZFJ-0006fq-Iq
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:16:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDZFJ-0006dY-AQ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 15:16:09 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5037D3B738
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 19:16:07 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id l6so57596wrn.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 12:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SglsKfXLtHg7WksTmSFUHA8AGjtHI09cghvVMDXR9Gg=;
 b=RfsOh/UgcX8rzKjz1JWeS6B/aWgPT+C7HWCnNj8n6zpBvNG1NL72u2tPghUsHtGoAQ
 nFq5MphQpryaY5xf3cduIVvXmic7EaH7dOYvLeHFZ9oO58VFRJNqSY0x+W1RCk+K78xo
 ZORlrAPLuwm0XOOQuVPvhXrkkzb69pqKYZCeTLlmW8kHtsoCZEOM6lVg5rVNnn/0wR6M
 V+WXbk++0oiu/A224zCzfwZnHE8La4NFKE2HhHGP/2AiVy65LxDJX4Rxozm2Ivry5E30
 z4eSGbqC9Ty8USBdov2f4Hdfzq8yqEc9HjcCBJdPDRwg5Zq/PKe/bRYLsAsZpeJSuUXp
 vA0w==
X-Gm-Message-State: APjAAAU6vMO/nbxDJhD6Azu3EJkglnQsMrhddj6OC7SZMBQm1KjnH6wv
 iyWQSeGjKwdz4ALUVxjrET4HJ/oDOC9AmXiaLSKfcECW33Uo0hPhIKnc2oAEI6s96MZo2J1/9Fw
 C8zh6rraNzsyPsR8=
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr4643908wmk.150.1569525366054; 
 Thu, 26 Sep 2019 12:16:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxY/uLEDX02upNV9rfEf80IIbAxc6dBO9wCQvCaEFaFzzcpyOTM7SB9LLQEMulLDoz6ilOcDQ==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr4643894wmk.150.1569525365819; 
 Thu, 26 Sep 2019 12:16:05 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id k24sm11857612wmi.1.2019.09.26.12.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 12:16:05 -0700 (PDT)
Subject: Re: [SeaBIOS] [PATCH v7 7/8] bootdevice: FW_CFG interface for LCHS
 values
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: John Snow <jsnow@redhat.com>, Sam Eiderman <sameid@google.com>,
 qemu-devel@nongnu.org
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
 <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
Date: Thu, 26 Sep 2019 21:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
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

On 9/26/19 9:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/26/19 8:26 PM, John Snow wrote:
>> On 9/26/19 5:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Sam,
>>>
>>> On 9/25/19 1:06 PM, Sam Eiderman wrote:
>>>> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>>>>
>>>> Using fw_cfg, supply logical CHS values directly from QEMU to the BI=
OS.
>>>>
>>>> Non-standard logical geometries break under QEMU.
>>>>
>>>> A virtual disk which contains an operating system which depends on
>>>> logical geometries (consistent values being reported from BIOS INT13
>>>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has non-sta=
ndard
>>>> logical geometries - for example 56 SPT (sectors per track).
>>>> No matter what QEMU will report - SeaBIOS, for large enough disks - =
will
>>>> use LBA translation, which will report 63 SPT instead.
>>>>
>>>> In addition we cannot force SeaBIOS to rely on physical geometries a=
t
>>>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads cannot
>>>> report more than 16 physical heads when moved to an IDE controller,
>>>> since the ATA spec allows a maximum of 16 heads - this is an artifac=
t of
>>>> virtualization.
>>>>
>>>> By supplying the logical geometries directly we are able to support =
such
>>>> "exotic" disks.
>>>>
>>>> We serialize this information in a similar way to the "bootorder"
>>>> interface.
>>>> The new fw_cfg entry is "bios-geometry".
>>>>
>>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>>>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>>>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
>>>> ---
>>>>  bootdevice.c            | 32 ++++++++++++++++++++++++++++++++
>>>>  hw/nvram/fw_cfg.c       | 14 +++++++++++---
>>>>  include/sysemu/sysemu.h |  1 +
>>>>  3 files changed, 44 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/bootdevice.c b/bootdevice.c
>>>> index 2b12fb85a4..b034ad7bdc 100644
>>>> --- a/bootdevice.c
>>>> +++ b/bootdevice.c
>>>> @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState *dev, con=
st char *suffix)
>>>>          }
>>>>      }
>>>>  }
>>>> +
>>>> +/* Serialized as: (device name\0 + lchs struct) x devices */
>>>> +char *get_boot_devices_lchs_list(size_t *size)
>>>> +{
>>>> +    FWLCHSEntry *i;
>>>> +    size_t total =3D 0;
>>>> +    char *list =3D NULL;
>>>> +
>>>> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
>>>> +        char *bootpath;
>>>> +        char *chs_string;
>>>> +        size_t len;
>>>> +
>>>> +        bootpath =3D get_boot_device_path(i->dev, false, i->suffix)=
;
>>>> +        chs_string =3D g_strdup_printf("%s %" PRIu32 " %" PRIu32 " =
%" PRIu32,
>>>> +                                     bootpath, i->lcyls, i->lheads,=
 i->lsecs);
>>>
>>> Hmm maybe we can g_free(bootpath) directly here.
>>>
>>
>> I think it's okay to do it at the bottom of the loop. No real benefit =
to
>> being that eager to free resources in my mind. I expect setup at the t=
op
>> of a block and teardown at the bottom of a block.
>>
>> Trying to do too much in the middle gets messy in my opinion, not that
>> it seems to matter here.
>=20
> No problem.
>=20
>>>> +
>>>> +        if (total) {
>>>> +            list[total - 1] =3D '\n';
>>>> +        }
>>>> +        len =3D strlen(chs_string) + 1;
>>>> +        list =3D g_realloc(list, total + len);
>>>> +        memcpy(&list[total], chs_string, len);
>>>> +        total +=3D len;
>>>> +        g_free(chs_string);
>>>> +        g_free(bootpath);
>>>> +    }
>>>> +
>>>> +    *size =3D total;
>>>> +
>>>> +    return list;
>>>> +}
>>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>>> index 7dc3ac378e..18aff658c0 100644
>>>> --- a/hw/nvram/fw_cfg.c
>>>> +++ b/hw/nvram/fw_cfg.c
>>>> @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s, const =
char *filename,
>>>> =20
>>>>  static void fw_cfg_machine_reset(void *opaque)
>>>>  {
>>>> +    MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>>>> +    FWCfgState *s =3D opaque;
>>>>      void *ptr;
>>>>      size_t len;
>>>> -    FWCfgState *s =3D opaque;
>>>> -    char *bootindex =3D get_boot_devices_list(&len);
>>>> +    char *buf;
>>>> =20
>>>> -    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex=
, len);
>>>> +    buf =3D get_boot_devices_list(&len);
>>>> +    ptr =3D fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len)=
;
>>>>      g_free(ptr);
>>>> +
>>>> +    if (!mc->legacy_fw_cfg_order) {
>>>> +        buf =3D get_boot_devices_lchs_list(&len);
>>>> +        ptr =3D fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)b=
uf, len);
>>>
>>> OK. Can you add a test in tests/fw_cfg-test.c please?
>>>
>>
>> :D
>>
>>>> +        g_free(ptr);
>>>> +    }
>>>>  }
>>>> =20
>>>>  static void fw_cfg_machine_ready(struct Notifier *n, void *data)
>>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>>> index 5bc5c79cbc..80c57fdc4e 100644
>>>> --- a/include/sysemu/sysemu.h
>>>> +++ b/include/sysemu/sysemu.h
>>>> @@ -106,6 +106,7 @@ void validate_bootdevices(const char *devices, E=
rror **errp);
>>>>  void add_boot_device_lchs(DeviceState *dev, const char *suffix,
>>>>                            uint32_t lcyls, uint32_t lheads, uint32_t=
 lsecs);
>>>>  void del_boot_device_lchs(DeviceState *dev, const char *suffix);
>>>> +char *get_boot_devices_lchs_list(size_t *size);
>>>
>>> Please add some documentation. At least 'size' must be non-NULL.
>>>
>>
>> Sure; but I wasn't going to gate on it because this series went unlove=
d
>> for so long. At this point, a follow-up patch is fine.
>=20
> OK
>=20
>>
>>> Ideally you should add doc for the other functions added in 3/8
>>> "bootdevice: Add interface to gather LCHS" too.
>>>
>>
>> Same thing here.
>>
>>> John, what do you think about extracting the *boot_device* functions =
out
>>> of "sysemu.h"?
>>>
>>
>> Potentially worthwhile; but not critical at the moment. The source tre=
e
>> is not the best-organized thing as-is and I don't think it's fair to
>> hold this series up for much longer for nice-to-haves, ultimately.
>>
>> More targeted improvements might avoid the "whose responsibility is it
>> to stage this?" hot potato we played with this one; so I'd rather have
>> smaller follow-up patches handled by the respective maintainers.
>=20
> Sure, fair enough.

I forgot:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

