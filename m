Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A13C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B5E20700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ke4DieyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B5E20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRym7-00077U-Av
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jRykj-0004si-Nl
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jRyki-0003te-OB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:52:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jRyki-0003rI-8T
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587736342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RHSIPL6/DF8EDLARcXYXyuiTsrEKUO709WzorUlhHUQ=;
 b=Ke4DieyCHoDeGewfmUfZlBnmbElnh9fjiGuYTmduq4tOE1e7uvLR3cmfy8cCGysiZQawff
 9nBICgu/+tzH8ENHTpn5hutVGrnBFOco53dpLgrFDn0+Qq9esMPGKwNGcarsswt6+z5HgD
 kt8X5RJqSOcAGQ2gaMf576EuWurAt8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-OjmIlslrOAK31hWpWJRo4Q-1; Fri, 24 Apr 2020 09:52:18 -0400
X-MC-Unique: OjmIlslrOAK31hWpWJRo4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83397463;
 Fri, 24 Apr 2020 13:52:16 +0000 (UTC)
Received: from [10.36.114.19] (ovpn-114-19.ams2.redhat.com [10.36.114.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD77A600E8;
 Fri, 24 Apr 2020 13:52:00 +0000 (UTC)
Subject: Re: [PATCH v9 8/9] virtio-iommu: Implement probe request
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bharat Bhushan <bbhushan2@marvell.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-9-bbhushan2@marvell.com>
 <20200423160952.GB645865@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <199e049a-99f0-7760-778f-b7c547f158e9@redhat.com>
Date: Fri, 24 Apr 2020 15:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200423160952.GB645865@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, drjones@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 bharatb.linux@gmail.com, linuc.decode@gmail.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,
On 4/23/20 6:09 PM, Jean-Philippe Brucker wrote:
> Hi Bharat,
>=20
> A few more things found while rebasing
>=20
> On Mon, Mar 23, 2020 at 02:16:16PM +0530, Bharat Bhushan wrote:
>> This patch implements the PROBE request. Currently supported
>> page size mask per endpoint is returned. Also append a NONE
>> property in the end.
>>
>> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  include/standard-headers/linux/virtio_iommu.h |   6 +
>>  hw/virtio/virtio-iommu.c                      | 161 +++++++++++++++++-
>>  hw/virtio/trace-events                        |   2 +
>>  3 files changed, 166 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/standard-headers/linux/virtio_iommu.h b/include/sta=
ndard-headers/linux/virtio_iommu.h
>> index b9443b83a1..8a0d47b907 100644
>> --- a/include/standard-headers/linux/virtio_iommu.h
>> +++ b/include/standard-headers/linux/virtio_iommu.h
>> @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
>> =20
>>  #define VIRTIO_IOMMU_PROBE_T_NONE=09=090
>>  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM=09=091
>> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK=092
>> =20
>>  #define VIRTIO_IOMMU_PROBE_T_MASK=09=090xfff
>> =20
>> @@ -130,6 +131,11 @@ struct virtio_iommu_probe_resv_mem {
>>  =09uint64_t=09=09=09=09=09end;
>>  };
>> =20
>> +struct virtio_iommu_probe_pgsize_mask {
>> +=09struct virtio_iommu_probe_property      head;
>> +=09uint64_t=09=09=09=09pgsize_bitmap;
>> +};
>> +
>>  struct virtio_iommu_req_probe {
>>  =09struct virtio_iommu_req_head=09=09head;
>>  =09uint32_t=09=09=09=09=09endpoint;
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 747e3cf1da..63fbacdcdc 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -38,6 +38,10 @@
>> =20
>>  /* Max size */
>>  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>> +#define VIOMMU_PROBE_SIZE 512
>> +
>> +#define SUPPORTED_PROBE_PROPERTIES (\
>> +    1 << VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK)
>> =20
>>  typedef struct VirtIOIOMMUDomain {
>>      uint32_t id;
>> @@ -62,6 +66,13 @@ typedef struct VirtIOIOMMUMapping {
>>      uint32_t flags;
>>  } VirtIOIOMMUMapping;
>> =20
>> +typedef struct VirtIOIOMMUPropBuffer {
>> +    VirtIOIOMMUEndpoint *endpoint;
>> +    size_t filled;
>> +    uint8_t *start;
>> +    bool error;
>=20
> It doesn't seem like bufstate->error gets used anywhere
maybe rebase your work on
[PATCH for-4.2 v10 10/15] virtio-iommu: Implement probe request
which tests it.

Also in
[Qemu-devel] [PATCH for-4.2 v10 10/15] virtio-iommu: Implement probe reques=
t
I changed the implementation to keep it simpler.

Thanks

Eric
>=20
>> +} VirtIOIOMMUPropBuffer;
>> +
>>  static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
>>  {
>>      return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
>> @@ -490,6 +501,114 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
>>      return ret;
>>  }
>> =20
>> +static int virtio_iommu_fill_none_prop(VirtIOIOMMUPropBuffer *bufstate)
>> +{
>> +    struct virtio_iommu_probe_property *prop;
>> +
>> +    prop =3D (struct virtio_iommu_probe_property *)
>> +                (bufstate->start + bufstate->filled);
>> +    prop->type =3D 0;
>> +    prop->length =3D 0;
>> +    bufstate->filled +=3D sizeof(*prop);
>> +    trace_virtio_iommu_fill_none_property(bufstate->endpoint->id);
>> +    return 0;
>> +}
>> +
>> +static int virtio_iommu_fill_page_size_mask(VirtIOIOMMUPropBuffer *bufs=
tate)
>> +{
>> +    struct virtio_iommu_probe_pgsize_mask *page_size_mask;
>> +    size_t prop_size =3D sizeof(*page_size_mask);
>> +    VirtIOIOMMUEndpoint *ep =3D bufstate->endpoint;
>> +    VirtIOIOMMU *s =3D ep->viommu;
>> +    IOMMUDevice *sdev;
>> +
>> +    if (bufstate->filled + prop_size >=3D VIOMMU_PROBE_SIZE) {
>> +        bufstate->error =3D true;
>> +        /* get the traversal stopped by returning true */
>> +        return true;
>> +    }
>> +
>> +    page_size_mask =3D (struct virtio_iommu_probe_pgsize_mask *)
>> +                     (bufstate->start + bufstate->filled);
>> +
>> +    page_size_mask->head.type =3D VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK;
>> +    page_size_mask->head.length =3D prop_size;
>> +    QLIST_FOREACH(sdev, &s->notifiers_list, next) {
>> +        if (ep->id =3D=3D sdev->devfn) {
>> +            page_size_mask->pgsize_bitmap =3D sdev->page_size_mask;
>=20
> Do we need a cpu_to_le64 here?
>=20
>> +=09}
>> +    }
>> +    bufstate->filled +=3D sizeof(*page_size_mask);
>> +    trace_virtio_iommu_fill_pgsize_mask_property(bufstate->endpoint->id=
,
>> +                                                 page_size_mask->pgsize=
_bitmap,
>> +                                                 bufstate->filled);
>> +    return false;
>> +}
>> +
>> +/* Fill the properties[] buffer with properties of type @type */
>> +static int virtio_iommu_fill_property(int type,
>> +                                      VirtIOIOMMUPropBuffer *bufstate)
>> +{
>> +    int ret =3D -ENOSPC;
>> +
>> +    if (bufstate->filled + sizeof(struct virtio_iommu_probe_property)
>> +            >=3D VIOMMU_PROBE_SIZE) {
>> +        /* no space left for the header */
>> +        bufstate->error =3D true;
>> +        goto out;
>> +    }
>> +
>> +    switch (type) {
>> +    case VIRTIO_IOMMU_PROBE_T_NONE:
>> +        ret =3D virtio_iommu_fill_none_prop(bufstate);
>> +        break;
>> +    case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
>> +    {
>> +        ret =3D virtio_iommu_fill_page_size_mask(bufstate);
>> +=09break;
>> +    }
>> +    default:
>> +        ret =3D -ENOENT;
>> +        break;
>> +    }
>> +out:
>> +    if (ret) {
>> +        error_report("%s property of type=3D%d could not be filled (%d)=
,"
>> +                     " remaining size =3D 0x%lx",
>> +                     __func__, type, ret, bufstate->filled);
>> +    }
>> +    return ret;
>> +}
>> +
>> +/**
>> + * virtio_iommu_probe - Fill the probe request buffer with all
>> + * the properties the device is able to return and add a NONE
>> + * property at the end. @buf points to properties[].
>> + */
>> +static int virtio_iommu_probe(VirtIOIOMMU *s,
>> +                              struct virtio_iommu_req_probe *req,
>> +                              uint8_t *buf)
>> +{
>> +    uint32_t ep_id =3D le32_to_cpu(req->endpoint);
>> +    VirtIOIOMMUEndpoint *ep =3D virtio_iommu_get_endpoint(s, ep_id);
>> +    int16_t prop_types =3D SUPPORTED_PROBE_PROPERTIES, type;
>> +    VirtIOIOMMUPropBuffer bufstate =3D {.start =3D buf, .filled =3D 0,
>> +                                       .error =3D false, .endpoint =3D =
ep};
>=20
> Probably need to check if ep is valid before going further
>=20
>> +
>> +    while ((type =3D ctz32(prop_types)) !=3D 32) {
>> +        if (virtio_iommu_fill_property(type, &bufstate)) {
>> +            goto failure;
>> +        }
>> +        prop_types &=3D ~(1 << type);
>> +    }
>> +    if (virtio_iommu_fill_property(VIRTIO_IOMMU_PROBE_T_NONE, &bufstate=
)) {
>> +        goto failure;
>> +    }
>=20
> We got rid of the NONE property in the spec, now there is:=20
>=20
>  "If the device doesn=E2=80=99t fill all probe_size bytes with properties=
, it
>   SHOULD fill the remaining bytes of properties with zeroes."
>=20
> So I think you can get rid of virtio_iommu_fill_none_prop() and fill the
> rest of the buffer with zeroes here instead.
>=20
> Thanks,
> Jean
>=20
>> +    return VIRTIO_IOMMU_S_OK;
>> +failure:
>> +    return VIRTIO_IOMMU_S_INVAL;
>> +}
>> +
>>  static int virtio_iommu_iov_to_req(struct iovec *iov,
>>                                     unsigned int iov_cnt,
>>                                     void *req, size_t req_sz)
>> @@ -519,6 +638,17 @@ virtio_iommu_handle_req(detach)
>>  virtio_iommu_handle_req(map)
>>  virtio_iommu_handle_req(unmap)
>> =20
>> +static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
>> +                                     struct iovec *iov,
>> +                                     unsigned int iov_cnt,
>> +                                     uint8_t *buf)
>> +{
>> +    struct virtio_iommu_req_probe req;
>> +    int ret =3D virtio_iommu_iov_to_req(iov, iov_cnt, &req, sizeof(req)=
);
>> +
>> +    return ret ? ret : virtio_iommu_probe(s, &req, buf);
>> +}
>> +
>>  static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *=
vq)
>>  {
>>      VirtIOIOMMU *s =3D VIRTIO_IOMMU(vdev);
>> @@ -564,17 +694,33 @@ static void virtio_iommu_handle_command(VirtIODevi=
ce *vdev, VirtQueue *vq)
>>          case VIRTIO_IOMMU_T_UNMAP:
>>              tail.status =3D virtio_iommu_handle_unmap(s, iov, iov_cnt);
>>              break;
>> +        case VIRTIO_IOMMU_T_PROBE:
>> +        {
>> +            struct virtio_iommu_req_tail *ptail;
>> +            uint8_t *buf =3D g_malloc0(s->config.probe_size + sizeof(ta=
il));
>> +
>> +            ptail =3D (struct virtio_iommu_req_tail *)
>> +                        (buf + s->config.probe_size);
>> +            ptail->status =3D virtio_iommu_handle_probe(s, iov, iov_cnt=
, buf);
>> +
>> +            sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
>> +                              buf, s->config.probe_size + sizeof(tail))=
;
>> +            g_free(buf);
>> +            assert(sz =3D=3D s->config.probe_size + sizeof(tail));
>> +            goto push;
>> +        }
>>          default:
>>              tail.status =3D VIRTIO_IOMMU_S_UNSUPP;
>>          }
>> -        qemu_mutex_unlock(&s->mutex);
>> =20
>>  out:
>>          sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
>>                            &tail, sizeof(tail));
>>          assert(sz =3D=3D sizeof(tail));
>> =20
>> -        virtqueue_push(vq, elem, sizeof(tail));
>> +push:
>> +        qemu_mutex_unlock(&s->mutex);
>> +        virtqueue_push(vq, elem, sz);
>>          virtio_notify(vdev, vq);
>>          g_free(elem);
>>      }
>> @@ -634,16 +780,23 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUM=
emoryRegion *mr, hwaddr addr,
>>      VirtIOIOMMUEndpoint *ep;
>>      uint32_t sid, flags;
>>      bool bypass_allowed;
>> +    hwaddr addr_mask;
>>      bool found;
>> =20
>>      interval.low =3D addr;
>>      interval.high =3D addr + 1;
>> =20
>> +    if (sdev->page_size_mask) {
>> +        addr_mask =3D (1 << ctz32(sdev->page_size_mask)) - 1;
>> +    } else {
>> +        addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1;
>> +    }
>> +
>>      IOMMUTLBEntry entry =3D {
>>          .target_as =3D &address_space_memory,
>>          .iova =3D addr,
>>          .translated_addr =3D addr,
>> -        .addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1,
>> +        .addr_mask =3D addr_mask,
>>          .perm =3D IOMMU_NONE,
>>      };
>> =20
>> @@ -831,6 +984,7 @@ static void virtio_iommu_device_realize(DeviceState =
*dev, Error **errp)
>>      s->config.page_size_mask =3D TARGET_PAGE_MASK;
>>      s->config.input_range.end =3D -1UL;
>>      s->config.domain_range.end =3D 32;
>> +    s->config.probe_size =3D VIOMMU_PROBE_SIZE;
>> =20
>>      virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
>>      virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
>> @@ -840,6 +994,7 @@ static void virtio_iommu_device_realize(DeviceState =
*dev, Error **errp)
>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
>>      virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
>> +    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
>> =20
>>      qemu_mutex_init(&s->mutex);
>> =20
>> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>> index 8bae651191..b0a6e4bda3 100644
>> --- a/hw/virtio/trace-events
>> +++ b/hw/virtio/trace-events
>> @@ -76,3 +76,5 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t fla=
gs, uint32_t endpoint, uin
>>  virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr=
, uint64_t map_size) "mr=3D%s iova=3D0x%"PRIx64" pa=3D0x%" PRIx64" size=3D0=
x%"PRIx64
>>  virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map=
_size) "mr=3D%s iova=3D0x%"PRIx64" size=3D0x%"PRIx64
>>  virtio_iommu_remap(uint64_t iova, uint64_t pa, uint64_t size) "iova=3D0=
x%"PRIx64" pa=3D0x%" PRIx64" size=3D0x%"PRIx64""
>> +virtio_iommu_fill_none_property(uint32_t devid) "devid=3D%d"
>> +virtio_iommu_fill_pgsize_mask_property(uint32_t devid, uint64_t pgsize_=
mask, size_t filled) "dev=3D %d, pgsize_mask=3D0x%"PRIx64" filled=3D0x%lx"
>> --=20
>> 2.17.1
>>
>=20


