Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8153DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FA8207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="g382EEra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FA8207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTsyX-00048W-Vb
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 16:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kTswn-0002NT-2R
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 16:37:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kTswk-0004jR-4M
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 16:37:00 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8b558d0000>; Sat, 17 Oct 2020 13:35:25 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Oct
 2020 20:36:39 +0000
Subject: Re: [PATCH v26 07/17] vfio: Register SaveVMHandlers for VFIO device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-8-git-send-email-kwankhede@nvidia.com>
 <bffa8dc8-917f-047c-d71a-d9ec5770bfbe@redhat.com>
 <20200929101935.GD2826@work-vm>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <87117267-2e5e-faf3-bee3-97e00954c95d@nvidia.com>
Date: Sun, 18 Oct 2020 02:06:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929101935.GD2826@work-vm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602966925; bh=EIMj+DsDObI4JN+yDNjO/JNEqVO0CxZp3SH+pb4tYlg=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=g382EEraGsCoXfD7lIrgbeVIqErHTmooV/vpE+Me+S4Ij6DKKp+5qnxOOQGgsSL+t
 ek7pTKMT3VobQ0Y9Kc+ixHPIqe5a1DRo/n4fuOS96G1Byi+HKqBC/MyH6peDzyTDWi
 Iqc6/ats/8GJ+4PMqLhrKTicICEmF1IwfBlTiLTtRBVDsM+J6iVlT+9GGa+Dhf954E
 mzBrDQNkFw8rIhJ5wJinZPBuULZiAgv1gfuPlx/T/UfqFxlKrG0bcBONfWF88ksGCj
 VIKlZCySdP50c8cX+m7TM+SaL84b4+h+4zGVHQcDGY8oIgaLmYqkgrJn9Kck0qjSFO
 JyA7oi8xQFDNQ==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 16:17:35
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.247, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 quintela@redhat.com, zhi.a.wang@intel.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/29/2020 3:49 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=83=C2=A9 (philmd@redhat.com) wrote:
>> On 9/23/20 1:24 AM, Kirti Wankhede wrote:
>>> Define flags to be used as delimeter in migration file stream.
>>
>> Typo "delimiter".
>>
>>> Added .save_setup and .save_cleanup functions. Mapped & unmapped migrat=
ion
>>> region from these functions at source during saving or pre-copy phase.
>>> Set VFIO device state depending on VM's state. During live migration, V=
M is
>>> running when .save_setup is called, _SAVING | _RUNNING state is set for=
 VFIO
>>> device. During save-restore, VM is paused, _SAVING state is set for VFI=
O device.
>>>
>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>>> ---
>>>   hw/vfio/migration.c  | 91 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>   hw/vfio/trace-events |  2 ++
>>>   2 files changed, 93 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index f650fe9fc3c8..8e8adaa25779 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -8,12 +8,15 @@
>>>    */
>>>  =20
>>>   #include "qemu/osdep.h"
>>> +#include "qemu/main-loop.h"
>>> +#include "qemu/cutils.h"
>>>   #include <linux/vfio.h>
>>>  =20
>>>   #include "sysemu/runstate.h"
>>>   #include "hw/vfio/vfio-common.h"
>>>   #include "cpu.h"
>>>   #include "migration/migration.h"
>>> +#include "migration/vmstate.h"
>>>   #include "migration/qemu-file.h"
>>>   #include "migration/register.h"
>>>   #include "migration/blocker.h"
>>> @@ -25,6 +28,17 @@
>>>   #include "trace.h"
>>>   #include "hw/hw.h"
>>>  =20
>>> +/*
>>> + * Flags used as delimiter:
>>> + * 0xffffffff =3D> MSB 32-bit all 1s
>>> + * 0xef10     =3D> emulated (virtual) function IO
>>> + * 0x0000     =3D> 16-bits reserved for flags
>>> + */
>>> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
>>> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
>>> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>>> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>>> +
>>>   static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, in=
t count,
>>>                                     off_t off, bool iswrite)
>>>   {
>>> @@ -166,6 +180,65 @@ static int vfio_migration_set_state(VFIODevice *vb=
asedev, uint32_t mask,
>>>       return 0;
>>>   }
>>>  =20
>>> +/* -------------------------------------------------------------------=
--- */
>>> +
>>> +static int vfio_save_setup(QEMUFile *f, void *opaque)
>>> +{
>>> +    VFIODevice *vbasedev =3D opaque;
>>> +    VFIOMigration *migration =3D vbasedev->migration;
>>> +    int ret;
>>> +
>>> +    trace_vfio_save_setup(vbasedev->name);
>>> +
>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>> +
>>> +    if (migration->region.mmaps) {
>>> +        qemu_mutex_lock_iothread();
>>> +        ret =3D vfio_region_mmap(&migration->region);
>>> +        qemu_mutex_unlock_iothread();
>>> +        if (ret) {
>>> +            error_report("%s: Failed to mmap VFIO migration region %d:=
 %s",
>>> +                         vbasedev->name, migration->region.nr,
>>> +                         strerror(-ret));
>>> +            error_report("%s: Falling back to slow path", vbasedev->na=
me);
>>> +        }
>>> +    }
>>> +
>>> +    ret =3D vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_MASK,
>>> +                                   VFIO_DEVICE_STATE_SAVING);
>>> +    if (ret) {
>>> +        error_report("%s: Failed to set state SAVING", vbasedev->name)=
;
>>> +        return ret;
>>> +    }
>>> +
>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>> +
>>> +    ret =3D qemu_file_get_error(f);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void vfio_save_cleanup(void *opaque)
>>> +{
>>> +    VFIODevice *vbasedev =3D opaque;
>>> +    VFIOMigration *migration =3D vbasedev->migration;
>>> +
>>> +    if (migration->region.mmaps) {
>>> +        vfio_region_unmap(&migration->region);
>>> +    }
>>> +    trace_vfio_save_cleanup(vbasedev->name);
>>> +}
>>> +
>>> +static SaveVMHandlers savevm_vfio_handlers =3D {
>>> +    .save_setup =3D vfio_save_setup,
>>> +    .save_cleanup =3D vfio_save_cleanup,
>>> +};
>>> +
>>> +/* -------------------------------------------------------------------=
--- */
>>> +
>>>   static void vfio_vmstate_change(void *opaque, int running, RunState s=
tate)
>>>   {
>>>       VFIODevice *vbasedev =3D opaque;
>>> @@ -225,6 +298,8 @@ static int vfio_migration_init(VFIODevice *vbasedev=
,
>>>                                  struct vfio_region_info *info)
>>>   {
>>>       int ret =3D -EINVAL;
>>> +    char id[256] =3D "";
>>> +    Object *obj;
>>>  =20
>>>       if (!vbasedev->ops->vfio_get_object) {
>>>           return ret;
>>> @@ -241,6 +316,22 @@ static int vfio_migration_init(VFIODevice *vbasede=
v,
>>>           return ret;
>>>       }
>>>  =20
>>> +    obj =3D vbasedev->ops->vfio_get_object(vbasedev);
>>> +
>>> +    if (obj) {
>>> +        DeviceState *dev =3D DEVICE(obj);
>>> +        char *oid =3D vmstate_if_get_id(VMSTATE_IF(dev));
>>> +
>>> +        if (oid) {
>>> +            pstrcpy(id, sizeof(id), oid);
>>> +            pstrcat(id, sizeof(id), "/");
>>> +            g_free(oid);
>>> +        }
>>> +    }
>>> +    pstrcat(id, sizeof(id), "vfio");
>>
>> Alternatively (easier to review, matter of taste):
>>
>>   g_autofree char *path =3D NULL;
>>
>>   if (oid) {
>>     path =3D g_strdup_printf("%s/vfio",
>>                            vmstate_if_get_id(VMSTATE_IF(obj)););
>>   } else {
>>     path =3D g_strdup("vfio");
>>   }
>>   strpadcpy(id, sizeof(id), path, '\0');
>=20
> Maybe, although it's a straight copy of the magic in unregister_savevm.
>=20

Ok. Changing it as Philippe suggested.

Thanks,
Kirti

> Dave
>=20
>>> +
>>> +    register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_=
handlers,
>>> +                         vbasedev);
>>>       vbasedev->vm_state =3D qemu_add_vm_change_state_handler(vfio_vmst=
ate_change,
>>>                                                             vbasedev);
>>>       vbasedev->migration_state.notify =3D vfio_migration_state_notifie=
r;
>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>> index bcb3fa7314d7..982d8dccb219 100644
>>> --- a/hw/vfio/trace-events
>>> +++ b/hw/vfio/trace-events
>>> @@ -152,3 +152,5 @@ vfio_migration_probe(const char *name, uint32_t ind=
ex) " (%s) Region %d"
>>>   vfio_migration_set_state(const char *name, uint32_t state) " (%s) sta=
te %d"
>>>   vfio_vmstate_change(const char *name, int running, const char *reason=
, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>>>   vfio_migration_state_notifier(const char *name, const char *state) " =
(%s) state %s"
>>> +vfio_save_setup(const char *name) " (%s)"
>>> +vfio_save_cleanup(const char *name) " (%s)"
>>>
>>

