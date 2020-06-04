Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20FFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 15:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76099207D8
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 15:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76099207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgrtc-00015O-Oy
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 11:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@linux.ibm.com>)
 id 1jgrsC-0000DW-0L
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:33:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@linux.ibm.com>)
 id 1jgrsA-0004td-6M
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 11:33:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 054F4Tj4143510; Thu, 4 Jun 2020 11:32:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31eq5vycjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2020 11:32:25 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 054F4nGo145480;
 Thu, 4 Jun 2020 11:32:25 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31eq5vychx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2020 11:32:24 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 054FKCjZ017271;
 Thu, 4 Jun 2020 15:32:23 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02dal.us.ibm.com with ESMTP id 31bf4aeudb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2020 15:32:23 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 054FWMdi43319612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 4 Jun 2020 15:32:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8B24BE068;
 Thu,  4 Jun 2020 15:32:22 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E199EBE04F;
 Thu,  4 Jun 2020 15:32:21 +0000 (GMT)
Received: from localhost (unknown [9.80.221.55])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu,  4 Jun 2020 15:32:21 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
In-Reply-To: <20200604134022.10564-1-alex.bennee@linaro.org>
References: <20200604134022.10564-1-alex.bennee@linaro.org>
Date: Thu, 04 Jun 2020 12:32:19 -0300
Message-ID: <87bllyvocc.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-04_10:2020-06-02,
 2020-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 malwarescore=0 cotscore=-2147483648 suspectscore=1 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farosas@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 11:32:27
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> The purpose of vhost_section is to identify RAM regions that need to
> be made available to a vhost client. However when running under TCG
> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
> down the line.
>
> Re-factor the code so:
>
>   - steps are clearer to follow
>   - reason for rejection is recorded in the trace point
>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
>
> We expand the comment to explain that kernel based vhost has specific
> support for migration tracking.
>

Hi, I tested this with virtio-fs in x86_64 and ppc64le. Both TCG and KVM
(just in case).

With this patch the call to vhost_set_mem_table succeeds and the device
is set up properly:

# mount -t virtiofs myfs /mnt
# ls /mnt      <--- previously this would hang in TCG
a  b

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>

Tested-by: Fabiano Rosas <farosas@linux.ibm.com>

> ---
> v2
>   - drop enum, add trace_vhost_reject_section
>   - return false at any fail point
>   - unconditionally add DIRTY_MEMORY_CODE to handled cases
>   - slightly re-word the explanatory comment and commit message
> ---
>  hw/virtio/vhost.c      | 55 ++++++++++++++++++++++++++++++------------
>  hw/virtio/trace-events |  3 ++-
>  2 files changed, 41 insertions(+), 17 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index aff98a0ede5..120c0cc747b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -27,6 +27,7 @@
>  #include "migration/blocker.h"
>  #include "migration/qemu-file-types.h"
>  #include "sysemu/dma.h"
> +#include "sysemu/tcg.h"
>  #include "trace.h"
>=20=20
>  /* enabled until disconnected backend stabilizes */
> @@ -403,26 +404,48 @@ static int vhost_verify_ring_mappings(struct vhost_=
dev *dev,
>      return r;
>  }
>=20=20
> +/*
> + * vhost_section: identify sections needed for vhost access
> + *
> + * We only care about RAM sections here (where virtqueue can live). If
> + * we find one we still allow the backend to potentially filter it out
> + * of our list.
> + */
>  static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *se=
ction)
>  {
> -    bool result;
> -    bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) &
> -                     ~(1 << DIRTY_MEMORY_MIGRATION);
> -    result =3D memory_region_is_ram(section->mr) &&
> -        !memory_region_is_rom(section->mr);
> -
> -    /* Vhost doesn't handle any block which is doing dirty-tracking other
> -     * than migration; this typically fires on VGA areas.
> -     */
> -    result &=3D !log_dirty;
> +    MemoryRegion *mr =3D section->mr;
> +
> +    if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
> +        uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr);
> +        uint8_t handled_dirty;
> +
> +        /*
> +         * Kernel based vhost doesn't handle any block which is doing
> +         * dirty-tracking other than migration for which it has
> +         * specific logging support. However for TCG the kernel never
> +         * gets involved anyway so we can also ignore it's
> +         * self-modiying code detection flags.
> +         */
> +        handled_dirty =3D (1 << DIRTY_MEMORY_MIGRATION);
> +        handled_dirty |=3D (1 << DIRTY_MEMORY_CODE);
>=20=20
> -    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
> -        result &=3D
> -            dev->vhost_ops->vhost_backend_mem_section_filter(dev, sectio=
n);
> -    }
> +        if (dirty_mask & ~handled_dirty) {
> +            trace_vhost_reject_section(mr->name, 1);
> +            return false;
> +        }
> +
> +        if (dev->vhost_ops->vhost_backend_mem_section_filter &&
> +            !dev->vhost_ops->vhost_backend_mem_section_filter(dev, secti=
on)) {
> +            trace_vhost_reject_section(mr->name, 2);
> +            return false;
> +        }
>=20=20
> -    trace_vhost_section(section->mr->name, result);
> -    return result;
> +        trace_vhost_section(mr->name);
> +        return true;
> +    } else {
> +        trace_vhost_reject_section(mr->name, 3);
> +        return false;
> +    }
>  }
>=20=20
>  static void vhost_begin(MemoryListener *listener)
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 84ecb85d445..22427126b97 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -5,7 +5,8 @@ vhost_commit(bool started, bool changed) "Started: %d Cha=
nged: %d"
>  vhost_region_add_section(const char *name, uint64_t gpa, uint64_t size, =
uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
>  vhost_region_add_section_merge(const char *name, uint64_t new_size, uint=
64_t gpa, uint64_t owr) "%s: size: 0x%"PRIx64 " gpa: 0x%"PRIx64 " owr: 0x%"=
PRIx64
>  vhost_region_add_section_aligned(const char *name, uint64_t gpa, uint64_=
t size, uint64_t host) "%s: 0x%"PRIx64"+0x%"PRIx64" @ 0x%"PRIx64
> -vhost_section(const char *name, int r) "%s:%d"
> +vhost_section(const char *name) "%s"
> +vhost_reject_section(const char *name, int d) "%s:%d"
>  vhost_iotlb_miss(void *dev, int step) "%p step %d"
>=20=20
>  # vhost-user.c

