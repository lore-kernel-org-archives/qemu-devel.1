Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321ACC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F030E214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7UeSFjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F030E214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmKo-0008Ag-13
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTmJS-00079v-Pv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTmJS-0006Ov-4R
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:59:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46554
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jTmJQ-0006OY-1M
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588165178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VK/PiySJnjlpVcwV8ZVMvy7MkAoa0ylslX86Us317w=;
 b=Q7UeSFjDFBLMuui05HhJ1iJMmnKAYgp/RRYuFuJmBWxt9AUMUv/l2rQ6WbIgIN6fs0e7kY
 D5R9XYXzZl5DIZGMu/Wg1ZdyXwm35sQqK/EwVmGfe3YYb7oZ1KDYQcSI3StzajyhY2oiO+
 OYAs0pLfMPIcHGnohjMe6fUD9NOafI0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-DV8DeXGHNkSE_9MeIbfWkw-1; Wed, 29 Apr 2020 08:59:34 -0400
X-MC-Unique: DV8DeXGHNkSE_9MeIbfWkw-1
Received: by mail-wr1-f70.google.com with SMTP id m5so1672036wru.15
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 05:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lSpiT0TKTcUPYXNbDo/c+3ccvdzfA1chFaEGN0qb4MU=;
 b=qPJ7C1G7Q9IRahicBJA+CXVswoOKIpAdR1IlJrMJpgHcMaVbHQS/EK4hg/zKRLtaRk
 sHK2G1D7UChyRaIp7tL8uu+vtXVF4laoRWR5rQVkcOtutdCbV+Q6DRy2gx18LtTtfDpv
 jCZHgwSwilunnhUoFECMpHD0NjPMJCveRX6Z0pFHxft82SzA/o5Pmffq6/i0eyopRsd3
 L+4xACVtCWL2O2z/hV1+ojE3GmRT7KuRf1nvoqn0hTC+Q0wEpsIo9Ti7aBmem/h30j/v
 HlRuKth2U8E8DBc4aYLXt/pho4TLbpBJjOR4BrKR2etO6HvLkSrtD7hdnoVR0+LMLrxV
 zl3w==
X-Gm-Message-State: AGi0PuasXN9ZJJnA6q7gmLWW7hk5HMFPty4reIaKX3fyokTJomOXcFN8
 bwSjLviGz8A9x0AKqZSxol0mg+QCw6O3Xa5QidGouJCOKl6A+XRJnc+yTtRd7njMOOfK97njkPA
 HpQtXVw9RxRzjx/4=
X-Received: by 2002:a1c:b757:: with SMTP id h84mr3170155wmf.188.1588165173135; 
 Wed, 29 Apr 2020 05:59:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZ4SkKZFd/5EepEaGK9qtkLWpK5Q/1g2HuHaJ4WwKcPAVQGV4OBnRDRAmCD7gK77IWfJ3qeQ==
X-Received: by 2002:a1c:b757:: with SMTP id h84mr3170126wmf.188.1588165172835; 
 Wed, 29 Apr 2020 05:59:32 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id t67sm8465694wmg.40.2020.04.29.05.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 05:59:32 -0700 (PDT)
Subject: Re: [PATCH v3] block: make BlockConf.*_size properties 32-bit
To: Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin\"" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20200429091813.1469510-1-rvkagan@yandex-team.ru>
 <f80b44cf-5fe3-8e10-b928-b61f7940d3cf@redhat.com>
 <20200429121915.GA31415@rvkaganb>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <caedf222-3fef-ad92-3b03-f28d8019b7f0@redhat.com>
Date: Wed, 29 Apr 2020 14:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429121915.GA31415@rvkaganb>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 2:19 PM, Roman Kagan wrote:
> On Wed, Apr 29, 2020 at 11:41:04AM +0200, Philippe Mathieu-Daud=E9 wrote:
>> Cc'ing virtio-blk and scsi maintainers.
>>
>> On 4/29/20 11:18 AM, Roman Kagan wrote:
>>> Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
>>> 32-bit for logical_block_size, physical_block_size, and min_io_size.
>>> However, the properties in BlockConf are defined as uint16_t limiting
>>> the values to 32768.
>>>
>>> This appears unnecessary tight, and we've seen bigger block sizes handy
>>> at times.
>>>
>>> Make them 32 bit instead and lift the limitation up to 2 MiB which
>>> appears to be good enough for everybody, and matches the qcow2 cluster
>>> size limit.
>>>
>>> As the values can now be fairly big and awkward to type, make the
>>> property setter accept common size suffixes (k, m).
>>>
>>> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> ---
>>> v2 -> v3:
>>> - mention qcow2 cluster size limit in the log and comment [Eric]
>>>
>>> v1 -> v2:
>>> - cap the property at 2 MiB [Eric]
>>> - accept size suffixes
>>>
>>>    include/hw/block/block.h     |  8 ++++----
>>>    include/hw/qdev-properties.h |  2 +-
>>>    hw/core/qdev-properties.c    | 34 ++++++++++++++++++++++++----------
>>>    3 files changed, 29 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
>>> index d7246f3862..9dd6bba56a 100644
>>> --- a/include/hw/block/block.h
>>> +++ b/include/hw/block/block.h
>>> @@ -18,9 +18,9 @@
>>>    typedef struct BlockConf {
>>>        BlockBackend *blk;
>>> -    uint16_t physical_block_size;
>>> -    uint16_t logical_block_size;
>>> -    uint16_t min_io_size;
>>> +    uint32_t physical_block_size;
>>> +    uint32_t logical_block_size;
>>> +    uint32_t min_io_size;
>>>        uint32_t opt_io_size;
>>>        int32_t bootindex;
>>>        uint32_t discard_granularity;
>>> @@ -51,7 +51,7 @@ static inline unsigned int get_physical_block_exp(Blo=
ckConf *conf)
>>>                              _conf.logical_block_size),                =
    \
>>>        DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,            =
    \
>>>                              _conf.physical_block_size),               =
    \
>>> -    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),  =
  \
>>> +    DEFINE_PROP_UINT32("min_io_size", _state, _conf.min_io_size, 0),  =
  \
>>>        DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),=
    \
>>>        DEFINE_PROP_UINT32("discard_granularity", _state,               =
    \
>>>                           _conf.discard_granularity, -1),              =
    \
>>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.=
h
>>> index f161604fb6..f9e0f8c041 100644
>>> --- a/include/hw/qdev-properties.h
>>> +++ b/include/hw/qdev-properties.h
>>> @@ -197,7 +197,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width=
;
>>>    #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
>>>        DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int=
)
>>>    #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
>>> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
>>> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
>>>    #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
>>>        DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDevic=
eAddress)
>>>    #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index 2047114fca..e673f3c43f 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
>>> @@ -14,6 +14,7 @@
>>>    #include "qapi/visitor.h"
>>>    #include "chardev/char.h"
>>>    #include "qemu/uuid.h"
>>> +#include "qemu/units.h"
>>>    void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
>>>                                      Error **errp)
>>> @@ -729,30 +730,42 @@ const PropertyInfo qdev_prop_pci_devfn =3D {
>>>    /* --- blocksize --- */
>>> +/* lower limit is sector size */
>>> +#define MIN_BLOCK_SIZE          512
>>> +#define MIN_BLOCK_SIZE_STR      "512 B"
>>> +/*
>>> + * upper limit is arbitrary, 2 MiB looks sufficient for all sensible u=
ses, and
>>> + * matches qcow2 cluster size limit
>>> + */
>>> +#define MAX_BLOCK_SIZE          (2 * MiB)
>>> +#define MAX_BLOCK_SIZE_STR      "2 MiB"
>>> +
>>>    static void set_blocksize(Object *obj, Visitor *v, const char *name,
>>>                              void *opaque, Error **errp)
>>>    {
>>>        DeviceState *dev =3D DEVICE(obj);
>>>        Property *prop =3D opaque;
>>> -    uint16_t value, *ptr =3D qdev_get_prop_ptr(dev, prop);
>>> +    uint32_t *ptr =3D qdev_get_prop_ptr(dev, prop);
>>> +    uint64_t value;
>>>        Error *local_err =3D NULL;
>>> -    const int64_t min =3D 512;
>>> -    const int64_t max =3D 32768;
>>>        if (dev->realized) {
>>>            qdev_prop_set_after_realize(dev, name, errp);
>>>            return;
>>>        }
>>> -    visit_type_uint16(v, name, &value, &local_err);
>>> +    visit_type_size(v, name, &value, &local_err);
>>>        if (local_err) {
>>>            error_propagate(errp, local_err);
>>>            return;
>>>        }
>>>        /* value of 0 means "unset" */
>>> -    if (value && (value < min || value > max)) {
>>> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
>>> -                   dev->id ? : "", name, (int64_t)value, min, max);
>>> +    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
>>> +        error_setg(errp,
>>> +                   "Property %s.%s doesn't take value %" PRIu64
>>> +                   " (minimum: " MIN_BLOCK_SIZE_STR
>>> +                   ", maximum: " MAX_BLOCK_SIZE_STR ")",
>>> +                   dev->id ? : "", name, value);
>>>            return;
>>>        }
>>> @@ -768,9 +781,10 @@ static void set_blocksize(Object *obj, Visitor *v,=
 const char *name,
>>>    }
>>>    const PropertyInfo qdev_prop_blocksize =3D {
>>> -    .name  =3D "uint16",
>>> -    .description =3D "A power of two between 512 and 32768",
>>> -    .get   =3D get_uint16,
>>> +    .name  =3D "size",
>>> +    .description =3D "A power of two between " MIN_BLOCK_SIZE_STR
>>> +                   " and " MAX_BLOCK_SIZE_STR,
>>> +    .get   =3D get_uint32,
>>>        .set   =3D set_blocksize,
>>>        .set_default_value =3D set_default_value_uint,
>>>    };
>>>
>>
>> 1/ Don't you need to update SCSIBlockLimits too?
>=20
> I guess you mean SCSIBlockLimits.min_io_size which is the only uint16_t
> field there, do you?

Yes.

>=20
>> 2/ It seems hw/block/virtio-blk.c can get underflow now.
>=20
> Both SCSIBlockLimits.min_io_size and virtio_blk_config.min_io_size are
> expressed in logical blocks so there appears to be no problem here.
>=20
>> Maybe you miss this change:
>>
>> -- >8 --
>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>> --- a/hw/block/virtio-blk.c
>> +++ b/hw/block/virtio-blk.c
>> @@ -917,7 +917,7 @@ static void virtio_blk_update_config(VirtIODevice *v=
dev,
>> uint8_t *config)
>>                    s->conf.seg_max_adjust ? s->conf.queue_size - 2 : 128=
 -
>> 2);
>>       virtio_stw_p(vdev, &blkcfg.geometry.cylinders, conf->cyls);
>>       virtio_stl_p(vdev, &blkcfg.blk_size, blk_size);
>> -    virtio_stw_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_siz=
e);
>> +    virtio_stl_p(vdev, &blkcfg.min_io_size, conf->min_io_size / blk_siz=
e);
>=20
> The width of this field in the device's config space is defined in the
> spec and can't be changed.
>=20
> Nor is there any need due to this patch.

OK, thanks :)

>=20
> Thanks,
> Roman.
>=20
>>       virtio_stw_p(vdev, &blkcfg.opt_io_size, conf->opt_io_size / blk_si=
ze);
>>       blkcfg.geometry.heads =3D conf->heads;
>>       /*
>> ---
>>
>=20


