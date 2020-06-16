Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3F0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 04:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A550C2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 04:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A550C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl3Zg-0007ro-Uz
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 00:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jl3Yn-00071F-QO; Tue, 16 Jun 2020 00:50:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jl3Yl-0004i3-VV; Tue, 16 Jun 2020 00:50:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05G4XXfD083834; Tue, 16 Jun 2020 00:50:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31pc7q1nxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 00:50:54 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05G4orn0130439;
 Tue, 16 Jun 2020 00:50:53 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31pc7q1nx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 00:50:53 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05G4jnEe023711;
 Tue, 16 Jun 2020 04:50:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma01fra.de.ibm.com with ESMTP id 31mpe7hw2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2020 04:50:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05G4nVD361145386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2020 04:49:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D424A404D;
 Tue, 16 Jun 2020 04:50:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02D5DA4040;
 Tue, 16 Jun 2020 04:50:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jun 2020 04:50:47 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] virtio-ccw: fix virtio_set_ind_atomic
Date: Tue, 16 Jun 2020 06:50:34 +0200
Message-Id: <20200616045035.51641-2-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616045035.51641-1-pasic@linux.ibm.com>
References: <20200616045035.51641-1-pasic@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_11:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 clxscore=1015 cotscore=-2147483648 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160033
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 00:50:54
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The atomic_cmpxchg() loop is broken because we occasionally end up with
old and _old having different values (a legit compiler can generate code
that accessed *ind_addr again to pick up a value for _old instead of
using the value of old that was already fetched according to the
rules of the abstract machine). This means the underlying CS instruction
may use a different old (_old) than the one we intended to use if
atomic_cmpxchg() performed the xchg part.

Let us use volatile to force the rules of the abstract machine for
accesses to *ind_addr. Let us also rewrite the loop so, we that the
new old is used to compute the new desired value if the xchg part
is not performed.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Andre Wild <Andre.Wild1@ibm.com>
Fixes: 7e7494627f ("s390x/virtio-ccw: Adapter interrupt support.")
---
 hw/s390x/virtio-ccw.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index c1f4bb1d33..3c988a000b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -786,9 +786,10 @@ static inline VirtioCcwDevice *to_virtio_ccw_dev_fast(DeviceState *d)
 static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
                                      uint8_t to_be_set)
 {
-    uint8_t ind_old, ind_new;
+    uint8_t expected, actual;
     hwaddr len = 1;
-    uint8_t *ind_addr;
+    /* avoid  multiple fetches */
+    uint8_t volatile *ind_addr;
 
     ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
@@ -796,14 +797,15 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
                      __func__, sch->cssid, sch->ssid, sch->schid);
         return -1;
     }
+    actual = *ind_addr;
     do {
-        ind_old = *ind_addr;
-        ind_new = ind_old | to_be_set;
-    } while (atomic_cmpxchg(ind_addr, ind_old, ind_new) != ind_old);
-    trace_virtio_ccw_set_ind(ind_loc, ind_old, ind_new);
-    cpu_physical_memory_unmap(ind_addr, len, 1, len);
+        expected = actual;
+        actual = atomic_cmpxchg(ind_addr, expected, expected | to_be_set);
+    } while (actual != expected);
+    trace_virtio_ccw_set_ind(ind_loc, actual, actual | to_be_set);
+    cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
 
-    return ind_old;
+    return actual;
 }
 
 static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
-- 
2.17.1


