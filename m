Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278DBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3EC32074F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EC32074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPET-0006lM-5k
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jsPDX-0005vv-2z; Mon, 06 Jul 2020 07:23:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jsPDU-00088N-HN; Mon, 06 Jul 2020 07:23:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 066B4eUj143761; Mon, 6 Jul 2020 07:23:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3236n98qjf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 07:23:18 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 066B6DWg005641;
 Mon, 6 Jul 2020 07:23:18 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3236n98qhw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 07:23:17 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 066BKO3O027186;
 Mon, 6 Jul 2020 11:23:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03fra.de.ibm.com with ESMTP id 322hd7s4j3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 11:23:15 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 066BNDfq29950030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2020 11:23:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D7E111C058;
 Mon,  6 Jul 2020 11:23:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C0C111C052;
 Mon,  6 Jul 2020 11:23:12 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.6.129])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2020 11:23:12 +0000 (GMT)
Date: Mon, 6 Jul 2020 13:23:11 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 13/14] virtio-ccw: fix virtio_set_ind_atomic
Message-ID: <20200706132311.2add044f.pasic@linux.ibm.com>
In-Reply-To: <20200703100650.621212-14-cohuck@redhat.com>
References: <20200703100650.621212-1-cohuck@redhat.com>
 <20200703100650.621212-14-cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-06_08:2020-07-06,
 2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 priorityscore=1501 cotscore=-2147483648 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007060086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 07:21:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Andre Wild <Andre.Wild1@ibm.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  3 Jul 2020 12:06:49 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> From: Halil Pasic <pasic@linux.ibm.com>
> 
> The atomic_cmpxchg() loop is broken because we occasionally end up with
> old and _old having different values (a legit compiler can generate code
> that accessed *ind_addr again to pick up a value for _old instead of
> using the value of old that was already fetched according to the
> rules of the abstract machine). This means the underlying CS instruction
> may use a different old (_old) than the one we intended to use if
> atomic_cmpxchg() performed the xchg part.
> 
> Let us use volatile to force the rules of the abstract machine for
> accesses to *ind_addr. Let us also rewrite the loop so, we that the

Michael T. Has pointed out that this sentence is ungrammatical. 

s/we// would IMHO solve the problem. Can we fix this before it gets
merged?

> new old is used to compute the new desired value if the xchg part
> is not performed.
> 
> Fixes: 7e7494627f ("s390x/virtio-ccw: Adapter interrupt support.")
> Reported-by: Andre Wild <Andre.Wild1@ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Message-Id: <20200616045035.51641-2-pasic@linux.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/virtio-ccw.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index c1f4bb1d331d..3c988a000b5b 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -786,9 +786,10 @@ static inline VirtioCcwDevice *to_virtio_ccw_dev_fast(DeviceState *d)
>  static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
>                                       uint8_t to_be_set)
>  {
> -    uint8_t ind_old, ind_new;
> +    uint8_t expected, actual;
>      hwaddr len = 1;
> -    uint8_t *ind_addr;
> +    /* avoid  multiple fetches */
> +    uint8_t volatile *ind_addr;
>  
>      ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
>      if (!ind_addr) {
> @@ -796,14 +797,15 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
>                       __func__, sch->cssid, sch->ssid, sch->schid);
>          return -1;
>      }
> +    actual = *ind_addr;
>      do {
> -        ind_old = *ind_addr;
> -        ind_new = ind_old | to_be_set;
> -    } while (atomic_cmpxchg(ind_addr, ind_old, ind_new) != ind_old);
> -    trace_virtio_ccw_set_ind(ind_loc, ind_old, ind_new);
> -    cpu_physical_memory_unmap(ind_addr, len, 1, len);
> +        expected = actual;
> +        actual = atomic_cmpxchg(ind_addr, expected, expected | to_be_set);
> +    } while (actual != expected);
> +    trace_virtio_ccw_set_ind(ind_loc, actual, actual | to_be_set);
> +    cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
>  
> -    return ind_old;
> +    return actual;
>  }
>  
>  static void virtio_ccw_notify(DeviceState *d, uint16_t vector)


