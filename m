Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB359C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECC220673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECC220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnrf-0000yg-Qh
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHnlV-00033G-F5
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHnlS-00029p-8k
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHnlS-00029C-1A
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:34:50 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B552D9B28D
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 11:34:48 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c188so853330wmd.9
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xBJ6ERQFWALn9874Evzf8nlBAaDpHH9xLZjMiCLmi54=;
 b=qcB2GWpFJKTuYnxXTKA2XSWlgLTUZCltoCIgT7rsJ73YwUAoo/MIXr+XkoNptunoyn
 6lP/LBJHGXYX/x7nW9yLSLo0EAn60Ri/+gVfdx43Pi3kiCx5lItnWvHNqVaP96/Dc1Cm
 2KyTxuzwCENgeuX6lZhiRTYFcA1XvIkPK2he4JS+MfYA7xbsEpEFHb2KvVVE6vCxspDE
 i5Ry1Er21W+jeW7G8NtzPejb7HAvWAxIZPoAThBLXK+CNylTrSbya65DGWKW3114ieYQ
 3xZ850vFBLkQpDwBdkcza4EMEHvEZEzagUUNVKrIS51KtURZZvy7rUEjfTj4/dwcS1QA
 TcMw==
X-Gm-Message-State: APjAAAWiUJnkIhvIHXtQuru33urm6tHNTvpzBjyoPGcvZpxY4K0X0CfG
 ywOguqvDopXsfKqXCRzUxh55q1/YaQjoYS/aDIKhKXd2tfHqDNHqjdqCXyILRhSUi+qAsD+Bjeh
 9xm2wwSdFaNzwpUI=
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr3644823wmc.113.1570534487401; 
 Tue, 08 Oct 2019 04:34:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxuTAlgPajzIjtdbI4g9tBJmU3nqc3nKKpl3OZU9JzzWJF7pCw5Hf33L5KInL2xd7/5If/iww==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr3644804wmc.113.1570534487100; 
 Tue, 08 Oct 2019 04:34:47 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id z9sm20305685wrp.26.2019.10.08.04.34.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 04:34:46 -0700 (PDT)
Subject: Re: [SeaBIOS] [PATCH v7 7/8] bootdevice: FW_CFG interface for LCHS
 values
To: Sam Eiderman <sameid@google.com>
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-8-sameid@google.com>
 <ffff9a59-3cbf-8b04-f4e5-8a01dad8d381@redhat.com>
 <7dc7b14c-8e89-4851-6d05-d69b1bf36e3e@redhat.com>
 <92b719a7-3838-b019-cd51-5f5b2120a431@redhat.com>
 <1d863ce2-0e45-63e4-ceb2-d2eb2d9aa03a@redhat.com>
 <CAFr6bU=2B9JcmfJZ25BTYkhnw2V+YAghyAyK9YHto18KRptPAg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1dc0c7cd-cf9f-0c33-04f5-ed8d89119c9f@redhat.com>
Date: Tue, 8 Oct 2019 13:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFr6bU=2B9JcmfJZ25BTYkhnw2V+YAghyAyK9YHto18KRptPAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
 Laszlo Ersek <lersek@redhat.com>, seabios@seabios.org, qemu-devel@nongnu.org,
 kraxel@redhat.com, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sam,

On 9/29/19 12:13 PM, Sam Eiderman wrote:
> Philippe, thanks for the fast review,

Fast is not always the friend of careful.

>=20
> John, thanks for picking up this hot potato :-)
>=20
> Sam
>=20
> On Thu, Sep 26, 2019 at 10:16 PM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     On 9/26/19 9:09 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>      > On 9/26/19 8:26 PM, John Snow wrote:
>      >> On 9/26/19 5:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>      >>> Hi Sam,
>      >>>
>      >>> On 9/25/19 1:06 PM, Sam Eiderman wrote:
>      >>>> From: Sam Eiderman <shmuel.eiderman@oracle.com
>     <mailto:shmuel.eiderman@oracle.com>>
>      >>>>
>      >>>> Using fw_cfg, supply logical CHS values directly from QEMU to
>     the BIOS.
>      >>>>
>      >>>> Non-standard logical geometries break under QEMU.
>      >>>>
>      >>>> A virtual disk which contains an operating system which depen=
ds on
>      >>>> logical geometries (consistent values being reported from BIO=
S
>     INT13
>      >>>> AH=3D08) will most likely break under QEMU/SeaBIOS if it has
>     non-standard
>      >>>> logical geometries - for example 56 SPT (sectors per track).
>      >>>> No matter what QEMU will report - SeaBIOS, for large enough
>     disks - will
>      >>>> use LBA translation, which will report 63 SPT instead.
>      >>>>
>      >>>> In addition we cannot force SeaBIOS to rely on physical
>     geometries at
>      >>>> all. A virtio-blk-pci virtual disk with 255 phyiscal heads ca=
nnot
>      >>>> report more than 16 physical heads when moved to an IDE
>     controller,
>      >>>> since the ATA spec allows a maximum of 16 heads - this is an
>     artifact of
>      >>>> virtualization.
>      >>>>
>      >>>> By supplying the logical geometries directly we are able to
>     support such
>      >>>> "exotic" disks.
>      >>>>
>      >>>> We serialize this information in a similar way to the "bootor=
der"
>      >>>> interface.
>      >>>> The new fw_cfg entry is "bios-geometry".
>      >>>>
>      >>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com
>     <mailto:karl.heubaum@oracle.com>>
>      >>>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com
>     <mailto:arbel.moshe@oracle.com>>
>      >>>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com
>     <mailto:shmuel.eiderman@oracle.com>>
>      >>>> ---
>      >>>>=C2=A0 bootdevice.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 32 ++++++++++++++++++++++++++++++++
>      >>>>=C2=A0 hw/nvram/fw_cfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 ++++++=
+++++---
>      >>>>=C2=A0 include/sysemu/sysemu.h |=C2=A0 1 +
>      >>>>=C2=A0 3 files changed, 44 insertions(+), 3 deletions(-)
>      >>>>
>      >>>> diff --git a/bootdevice.c b/bootdevice.c
>      >>>> index 2b12fb85a4..b034ad7bdc 100644
>      >>>> --- a/bootdevice.c
>      >>>> +++ b/bootdevice.c
>      >>>> @@ -405,3 +405,35 @@ void del_boot_device_lchs(DeviceState
>     *dev, const char *suffix)
>      >>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      >>>>=C2=A0 =C2=A0 =C2=A0 }
>      >>>>=C2=A0 }
>      >>>> +
>      >>>> +/* Serialized as: (device name\0 + lchs struct) x devices */

I suppose the lchs struct is serialized in little-endian.

>      >>>> +char *get_boot_devices_lchs_list(size_t *size)
>      >>>> +{
>      >>>> +=C2=A0 =C2=A0 FWLCHSEntry *i;
>      >>>> +=C2=A0 =C2=A0 size_t total =3D 0;
>      >>>> +=C2=A0 =C2=A0 char *list =3D NULL;
>      >>>> +
>      >>>> +=C2=A0 =C2=A0 QTAILQ_FOREACH(i, &fw_lchs, link) {
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *bootpath;
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *chs_string;
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len;
>      >>>> +
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bootpath =3D get_boot_device_pat=
h(i->dev, false,
>     i->suffix);
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 chs_string =3D g_strdup_printf("=
%s %" PRIu32 " %"
>     PRIu32 " %" PRIu32,
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boo=
tpath, i->lcyls,
>     i->lheads, i->lsecs);

Sam. can you check if you don't need endianness conversion here?

>      >>>
>      >>> Hmm maybe we can g_free(bootpath) directly here.
>      >>>
>      >>
>      >> I think it's okay to do it at the bottom of the loop. No real
>     benefit to
>      >> being that eager to free resources in my mind. I expect setup a=
t
>     the top
>      >> of a block and teardown at the bottom of a block.
>      >>
>      >> Trying to do too much in the middle gets messy in my opinion,
>     not that
>      >> it seems to matter here.
>      >
>      > No problem.
>      >
>      >>>> +
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (total) {
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list[total - 1] =3D=
 '\n';
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D strlen(chs_string) + 1;
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 list =3D g_realloc(list, total +=
 len);
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&list[total], chs_string,=
 len);
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 total +=3D len;
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(chs_string);
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(bootpath);
>      >>>> +=C2=A0 =C2=A0 }
>      >>>> +
>      >>>> +=C2=A0 =C2=A0 *size =3D total;
>      >>>> +
>      >>>> +=C2=A0 =C2=A0 return list;
>      >>>> +}
>      >>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>      >>>> index 7dc3ac378e..18aff658c0 100644
>      >>>> --- a/hw/nvram/fw_cfg.c
>      >>>> +++ b/hw/nvram/fw_cfg.c
>      >>>> @@ -920,13 +920,21 @@ void *fw_cfg_modify_file(FWCfgState *s,
>     const char *filename,
>      >>>>
>      >>>>=C2=A0 static void fw_cfg_machine_reset(void *opaque)
>      >>>>=C2=A0 {
>      >>>> +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_GET_CLASS(qdev_ge=
t_machine());
>      >>>> +=C2=A0 =C2=A0 FWCfgState *s =3D opaque;
>      >>>>=C2=A0 =C2=A0 =C2=A0 void *ptr;
>      >>>>=C2=A0 =C2=A0 =C2=A0 size_t len;
>      >>>> -=C2=A0 =C2=A0 FWCfgState *s =3D opaque;
>      >>>> -=C2=A0 =C2=A0 char *bootindex =3D get_boot_devices_list(&len=
);
>      >>>> +=C2=A0 =C2=A0 char *buf;
>      >>>>
>      >>>> -=C2=A0 =C2=A0 ptr =3D fw_cfg_modify_file(s, "bootorder", (ui=
nt8_t
>     *)bootindex, len);
>      >>>> +=C2=A0 =C2=A0 buf =3D get_boot_devices_list(&len);
>      >>>> +=C2=A0 =C2=A0 ptr =3D fw_cfg_modify_file(s, "bootorder", (ui=
nt8_t *)buf,
>     len);
>      >>>>=C2=A0 =C2=A0 =C2=A0 g_free(ptr);
>      >>>> +
>      >>>> +=C2=A0 =C2=A0 if (!mc->legacy_fw_cfg_order) {
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D get_boot_devices_lchs_li=
st(&len);
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D fw_cfg_modify_file(s, "b=
ios-geometry", (uint8_t
>     *)buf, len);
>      >>>
>      >>> OK. Can you add a test in tests/fw_cfg-test.c please?
>      >>>
>      >>
>      >> :D
>      >>
>      >>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(ptr);
>      >>>> +=C2=A0 =C2=A0 }
>      >>>>=C2=A0 }
>      >>>>
>      >>>>=C2=A0 static void fw_cfg_machine_ready(struct Notifier *n, vo=
id *data)
>      >>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.=
h
>      >>>> index 5bc5c79cbc..80c57fdc4e 100644
>      >>>> --- a/include/sysemu/sysemu.h
>      >>>> +++ b/include/sysemu/sysemu.h
>      >>>> @@ -106,6 +106,7 @@ void validate_bootdevices(const char
>     *devices, Error **errp);
>      >>>>=C2=A0 void add_boot_device_lchs(DeviceState *dev, const char =
*suffix,
>      >>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t lcyls, uint32_t lheads,
>     uint32_t lsecs);
>      >>>>=C2=A0 void del_boot_device_lchs(DeviceState *dev, const char =
*suffix);
>      >>>> +char *get_boot_devices_lchs_list(size_t *size);
>      >>>
>      >>> Please add some documentation. At least 'size' must be non-NUL=
L.
>      >>>
>      >>
>      >> Sure; but I wasn't going to gate on it because this series went
>     unloved
>      >> for so long. At this point, a follow-up patch is fine.
>      >
>      > OK
>      >
>      >>
>      >>> Ideally you should add doc for the other functions added in 3/=
8
>      >>> "bootdevice: Add interface to gather LCHS" too.
>      >>>
>      >>
>      >> Same thing here.
>      >>
>      >>> John, what do you think about extracting the *boot_device*
>     functions out
>      >>> of "sysemu.h"?
>      >>>
>      >>
>      >> Potentially worthwhile; but not critical at the moment. The
>     source tree
>      >> is not the best-organized thing as-is and I don't think it's fa=
ir to
>      >> hold this series up for much longer for nice-to-haves, ultimate=
ly.
>      >>
>      >> More targeted improvements might avoid the "whose responsibilit=
y
>     is it
>      >> to stage this?" hot potato we played with this one; so I'd
>     rather have
>      >> smaller follow-up patches handled by the respective maintainers=
.
>      >
>      > Sure, fair enough.
>=20
>     I forgot:
>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>

Meanwhile I withdraw my fast R-b :(

Regards,

Phil.

