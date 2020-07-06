Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7699C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD9B2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 11:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD9B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsPFc-0008F5-Ok
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 07:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jsPEJ-0006sb-2i; Mon, 06 Jul 2020 07:24:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jsPEH-0008KM-5k; Mon, 06 Jul 2020 07:24:10 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 066B2usl079464; Mon, 6 Jul 2020 07:24:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3237cfxrap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 07:24:07 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 066B2vZC079496;
 Mon, 6 Jul 2020 07:24:07 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3237cfxra4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 07:24:06 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 066BKnX2011294;
 Mon, 6 Jul 2020 11:24:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06ams.nl.ibm.com with ESMTP id 322h1h27ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2020 11:24:05 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 066BO2Cc28246042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2020 11:24:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E05CDA4040;
 Mon,  6 Jul 2020 11:24:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81110A4059;
 Mon,  6 Jul 2020 11:24:02 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.6.129])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2020 11:24:02 +0000 (GMT)
Date: Mon, 6 Jul 2020 13:23:41 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PULL 14/14] s390x/pci: fix set_ind_atomic
Message-ID: <20200706132341.2eb7255e.pasic@linux.ibm.com>
In-Reply-To: <20200703100650.621212-15-cohuck@redhat.com>
References: <20200703100650.621212-1-cohuck@redhat.com>
 <20200703100650.621212-15-cohuck@redhat.com>
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
 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 cotscore=-2147483648 malwarescore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 07:24:08
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  3 Jul 2020 12:06:50 +0200
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
> Fixes: 8cba80c3a0 ("s390: Add PCI bus support")
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Message-Id: <20200616045035.51641-3-pasic@linux.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 142e52a8ffdd..736965c9287f 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -637,22 +637,24 @@ static AddressSpace *s390_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>  
>  static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
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
>          s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
>          return -1;
>      }
> +    actual = *ind_addr;
>      do {
> -        ind_old = *ind_addr;
> -        ind_new = ind_old | to_be_set;
> -    } while (atomic_cmpxchg(ind_addr, ind_old, ind_new) != ind_old);
> -    cpu_physical_memory_unmap(ind_addr, len, 1, len);
> +        expected = actual;
> +        actual = atomic_cmpxchg(ind_addr, expected, expected | to_be_set);
> +    } while (actual != expected);
> +    cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
>  
> -    return ind_old;
> +    return actual;
>  }
>  
>  static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,


