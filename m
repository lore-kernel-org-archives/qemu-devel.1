Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF20C54FD5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44F820772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44F820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH85d-0006kt-U1
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH848-00055s-7E
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <muriloo@linux.ibm.com>) id 1jH846-0004SJ-EP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43542
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
 id 1jH846-0004Rk-7l
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:35:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02PFYd7a008807; Wed, 25 Mar 2020 11:35:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywewvh3nw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:32 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02PFYpbH010328;
 Wed, 25 Mar 2020 11:35:32 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywewvh3nd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 11:35:32 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02PFZB6e029626;
 Wed, 25 Mar 2020 15:35:31 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma04dal.us.ibm.com with ESMTP id 2ywawg2wjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Mar 2020 15:35:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02PFZUZB48234926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Mar 2020 15:35:30 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0BDBAC05F;
 Wed, 25 Mar 2020 15:35:30 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7DE3AC059;
 Wed, 25 Mar 2020 15:35:29 +0000 (GMT)
Received: from localhost (unknown [9.85.207.6])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 25 Mar 2020 15:35:29 +0000 (GMT)
From: Murilo Opsfelder =?ISO-8859-1?Q?Ara=FAjo?= <muriloo@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 12/15] util: vfio-helpers: Implement ram_block_resized()
Date: Wed, 25 Mar 2020 12:17:47 -0300
Message-ID: <2573379.2rWM1eQJ2q@kermit.br.ibm.com>
Organization: IBM
In-Reply-To: <20200305142945.216465-13-david@redhat.com>
References: <20200305142945.216465-1-david@redhat.com>
 <20200305142945.216465-13-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-25_07:2020-03-24,
 2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=5 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250123
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thursday, March 5, 2020 11:29:42 AM -03 David Hildenbrand wrote:
> Let's implement ram_block_resized(), allowing resizeable mappings.
>
> For resizeable mappings, we reserve $max_size IOVA address space, but only
> map $size of it. When resizing, unmap the old part and remap the new
> part. We'll need e.g., new ioctl to do this atomically (e.g., to resize
> while the guest is running).
>
> Right now, we only resize RAM blocks during incoming migration (when
> syncing RAM block sizes during the precopy phase) or after guest
> resets when building acpi tables. Any future user of resizeable RAM has to
> be aware that vfio has to be treated with care.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Acked-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

>  util/trace-events   |  7 ++--
>  util/vfio-helpers.c | 95 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 88 insertions(+), 14 deletions(-)
>
> diff --git a/util/trace-events b/util/trace-events
> index 83b6639018..a4d39eca5e 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -74,10 +74,11 @@ qemu_mutex_unlock(void *mutex, const char *file, const
> int line) "released mutex
>
>  # vfio-helpers.c
>  qemu_vfio_dma_reset_temporary(void *s) "s %p"
> -qemu_vfio_ram_block_added(void *s, void *p, size_t size) "s %p host %p size
> 0x%zx" -qemu_vfio_ram_block_removed(void *s, void *p, size_t size) "s %p
> host %p size 0x%zx" +qemu_vfio_ram_block_added(void *s, void *p, size_t
> size, size_t max_size) "s %p host %p size 0x%zx max_size 0x%zx"
> +qemu_vfio_ram_block_removed(void *s, void *p, size_t size, size_t
> max_size) "s %p host %p size 0x%zx max_size 0x%zx"
> +qemu_vfio_ram_block_resized(void *s, void *p, size_t old_size, size_t
> new_sizze) "s %p host %p old_size 0x%zx new_size 0x%zx"
> qemu_vfio_find_mapping(void *s, void *p) "s %p host %p"
> -qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t
> iova) "s %p host %p size %zu index %d iova 0x%"PRIx64
> +qemu_vfio_new_mapping(void *s, void *host, size_t size, size_t max_size,
> int index, uint64_t iova) "s %p host %p size %zu max_size %zu index %d iova
> 0x%"PRIx64 qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t
> iova) "s %p host %p size %zu iova 0x%"PRIx64 qemu_vfio_dma_map(void *s,
> void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size
> %zu temporary %d iova %p" qemu_vfio_dma_unmap(void *s, void *host) "s %p
> host %p"
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index f0c77f0d69..789faf38bd 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -36,6 +36,7 @@ typedef struct {
>      /* Page aligned addr. */
>      void *host;
>      size_t size;
> +    size_t max_size;
>      uint64_t iova;
>  } IOVAMapping;
>
> @@ -372,14 +373,20 @@ fail_container:
>      return ret;
>  }
>
> +static int qemu_vfio_dma_map_resizeable(QEMUVFIOState *s, void *host,
> +                                        size_t size, size_t max_size,
> +                                        bool temporary, uint64_t *iova);
> +static void qemu_vfio_dma_map_resize(QEMUVFIOState *s, void *host,
> +                                     size_t old_size, size_t new_size);
> +
>  static void qemu_vfio_ram_block_added(RAMBlockNotifier *n, void *host,
>                                        size_t size, size_t max_size)
>  {
>      QEMUVFIOState *s = container_of(n, QEMUVFIOState, ram_notifier);
>      int ret;
>
> -    trace_qemu_vfio_ram_block_added(s, host, max_size);
> -    ret = qemu_vfio_dma_map(s, host, max_size, false, NULL);
> +    trace_qemu_vfio_ram_block_added(s, host, size, max_size);
> +    ret = qemu_vfio_dma_map_resizeable(s, host, size, max_size, false,
> NULL); if (ret) {
>          error_report("qemu_vfio_dma_map(%p, %zu) failed: %s", host,
> max_size, strerror(-ret));
> @@ -391,16 +398,28 @@ static void
> qemu_vfio_ram_block_removed(RAMBlockNotifier *n, void *host, {
>      QEMUVFIOState *s = container_of(n, QEMUVFIOState, ram_notifier);
>      if (host) {
> -        trace_qemu_vfio_ram_block_removed(s, host, max_size);
> +        trace_qemu_vfio_ram_block_removed(s, host, size, max_size);
>          qemu_vfio_dma_unmap(s, host);
>      }
>  }
>
> +static void qemu_vfio_ram_block_resized(RAMBlockNotifier *n, void *host,
> +                                        size_t old_size, size_t new_size)
> +{
> +    QEMUVFIOState *s = container_of(n, QEMUVFIOState, ram_notifier);
> +
> +    if (host) {
> +        trace_qemu_vfio_ram_block_resized(s, host, old_size, new_size);
> +        qemu_vfio_dma_map_resize(s, host, old_size, new_size);
> +    }
> +}
> +
>  static void qemu_vfio_open_common(QEMUVFIOState *s)
>  {
>      qemu_mutex_init(&s->lock);
>      s->ram_notifier.ram_block_added = qemu_vfio_ram_block_added;
>      s->ram_notifier.ram_block_removed = qemu_vfio_ram_block_removed;
> +    s->ram_notifier.ram_block_resized = qemu_vfio_ram_block_resized;
>      s->low_water_mark = QEMU_VFIO_IOVA_MIN;
>      s->high_water_mark = QEMU_VFIO_IOVA_MAX;
>      ram_block_notifier_add(&s->ram_notifier);
> @@ -495,16 +514,23 @@ static IOVAMapping
> *qemu_vfio_find_mapping(QEMUVFIOState *s, void *host, */
>  static IOVAMapping *qemu_vfio_add_mapping(QEMUVFIOState *s,
>                                            void *host, size_t size,
> -                                          int index, uint64_t iova)
> +                                          size_t max_size, int index,
> +                                          uint64_t iova)
>  {
> +    const IOVAMapping m = {
> +        .host = host,
> +        .size = size,
> +        .max_size = max_size,
> +        .iova = iova,
> +    };
>      int shift;
> -    IOVAMapping m = {.host = host, .size = size, .iova = iova};
>      IOVAMapping *insert;
>
>      assert(QEMU_IS_ALIGNED(size, qemu_real_host_page_size));
> +    assert(size <= max_size);
>      assert(QEMU_IS_ALIGNED(s->low_water_mark, qemu_real_host_page_size));
>      assert(QEMU_IS_ALIGNED(s->high_water_mark, qemu_real_host_page_size));
> -    trace_qemu_vfio_new_mapping(s, host, size, index, iova);
> +    trace_qemu_vfio_new_mapping(s, host, size, max_size, index, iova);
>
>      assert(index >= 0);
>      s->nr_mappings++;
> @@ -597,9 +623,14 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOState *s)
> * the result in @iova if not NULL. The caller need to make sure the area is
> * aligned to page size, and mustn't overlap with existing mapping areas
> (split * mapping status within this area is not allowed).
> + *
> + * If size < max_size, a region of max_size in IOVA address is reserved,
> such + * that the mapping can later be resized. Resizeable mappings are
> only allowed + * for !temporary mappings.
>   */
> -int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
> -                      bool temporary, uint64_t *iova)
> +static int qemu_vfio_dma_map_resizeable(QEMUVFIOState *s, void *host,
> +                                        size_t size, size_t max_size,
> +                                        bool temporary, uint64_t *iova)
>  {
>      int ret = 0;
>      int index;
> @@ -608,19 +639,24 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host,
> size_t size,
>
>      assert(QEMU_PTR_IS_ALIGNED(host, qemu_real_host_page_size));
>      assert(QEMU_IS_ALIGNED(size, qemu_real_host_page_size));
> +    assert(QEMU_IS_ALIGNED(max_size, qemu_real_host_page_size));
> +    assert(size == max_size || !temporary);
> +    assert(size <= max_size);
> +
>      trace_qemu_vfio_dma_map(s, host, size, temporary, iova);
>      qemu_mutex_lock(&s->lock);
>      mapping = qemu_vfio_find_mapping(s, host, &index);
>      if (mapping) {
>          iova0 = mapping->iova + ((uint8_t *)host - (uint8_t
> *)mapping->host); } else {
> -        if (s->high_water_mark - s->low_water_mark + 1 < size) {
> +        if (s->high_water_mark - s->low_water_mark + 1 < max_size) {
>              ret = -ENOMEM;
>              goto out;
>          }
>          if (!temporary) {
>              iova0 = s->low_water_mark;
> -            mapping = qemu_vfio_add_mapping(s, host, size, index + 1,
> iova0); +            mapping = qemu_vfio_add_mapping(s, host, size,
> max_size, index + 1, +                                            iova0);
>              if (!mapping) {
>                  ret = -ENOMEM;
>                  goto out;
> @@ -631,7 +667,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host,
> size_t size, qemu_vfio_remove_mapping(s, mapping);
>                  goto out;
>              }
> -            s->low_water_mark += size;
> +            s->low_water_mark += max_size;
>              qemu_vfio_dump_mappings(s);
>          } else {
>              iova0 = s->high_water_mark - size;
> @@ -650,6 +686,12 @@ out:
>      return ret;
>  }
>
> +int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
> +                      bool temporary, uint64_t *iova)
> +{
> +    return qemu_vfio_dma_map_resizeable(s, host, size, size, temporary,
> iova); +}
> +
>  /* Reset the high watermark and free all "temporary" mappings. */
>  int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s)
>  {
> @@ -694,6 +736,37 @@ out:
>      qemu_mutex_unlock(&s->lock);
>  }
>
> +static void qemu_vfio_dma_map_resize(QEMUVFIOState *s, void *host,
> +                                     size_t old_size, size_t new_size)
> +{
> +    IOVAMapping *m;
> +    int index = 0;
> +
> +    qemu_mutex_lock(&s->lock);
> +    m = qemu_vfio_find_mapping(s, host, &index);
> +    if (!m) {
> +        return;
> +    }
> +    assert(m->size == old_size);
> +    assert(new_size <= m->max_size);
> +
> +    /*
> +     * For now, we must unmap the whole mapped range first and remap with
> +     * the new size. The reason is that VFIO_IOMMU_UNMAP_DMA might fail
> +     * when partially unmapping previous mappings. Although we could add
> +     * new mappings to extend the old range, we won't able to always
> +     * shrink. The side effect is that it's never safe to resize during VM
> +     * execution and we'll e.g., need a new IOCTL to make this work.
> +     */
> +    qemu_vfio_undo_mapping(s, m->iova, m->size);
> +    qemu_vfio_do_mapping(s, host, m->iova, new_size);
> +
> +    m->size = new_size;
> +    assert(qemu_vfio_verify_mappings(s));
> +
> +    qemu_mutex_unlock(&s->lock);
> +}
> +
>  static void qemu_vfio_reset(QEMUVFIOState *s)
>  {
>      ioctl(s->device, VFIO_DEVICE_RESET);


--
Murilo

