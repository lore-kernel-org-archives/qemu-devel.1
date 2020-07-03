Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4F9206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4F9206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLt8-0001fW-Il
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jrLsa-0001DW-4Z; Fri, 03 Jul 2020 09:37:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20898
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1jrLsY-0004bB-8g; Fri, 03 Jul 2020 09:37:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 063DVKtY029544; Fri, 3 Jul 2020 09:37:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3224vn1has-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2020 09:37:18 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 063DVI2x029269;
 Fri, 3 Jul 2020 09:37:18 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3224vn1h9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2020 09:37:18 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 063Dan4H022540;
 Fri, 3 Jul 2020 13:37:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma06ams.nl.ibm.com with ESMTP id 31wwch6v0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2020 13:37:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 063DbDaQ52560018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2020 13:37:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACCFB42042;
 Fri,  3 Jul 2020 13:37:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33FEC4203F;
 Fri,  3 Jul 2020 13:37:13 +0000 (GMT)
Received: from oc2783563651 (unknown [9.145.33.30])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2020 13:37:13 +0000 (GMT)
Date: Fri, 3 Jul 2020 15:37:11 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/2] two atomic_cmpxchg() related fixes
Message-ID: <20200703153711.3aa18ac7.pasic@linux.ibm.com>
In-Reply-To: <3674a552-fdf3-ffad-a729-efcb730adf1c@de.ibm.com>
References: <20200616045035.51641-1-pasic@linux.ibm.com>
 <20200701140106.004a3da2.cohuck@redhat.com>
 <3674a552-fdf3-ffad-a729-efcb730adf1c@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-03_06:2020-07-02,
 2020-07-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=824 clxscore=1015
 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007030091
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 09:37:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Jul 2020 14:06:11 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> 
> 
> On 01.07.20 14:01, Cornelia Huck wrote:
> > On Tue, 16 Jun 2020 06:50:33 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> > 
> >> The story short: compiler can generate code that does two
> >> distinct fetches of *ind_addr for old and _old. If that happens we can
> >> not figure out if we had the desired xchg or not.
> >>
> >> Halil Pasic (2):
> >>   virtio-ccw: fix virtio_set_ind_atomic
> >>   s390x/pci: fix set_ind_atomic
> >>
> >>  hw/s390x/s390-pci-bus.c | 16 +++++++++-------
> >>  hw/s390x/virtio-ccw.c   | 18 ++++++++++--------
> >>  2 files changed, 19 insertions(+), 15 deletions(-)
> >>
> >>
> >> base-commit: 7d3660e79830a069f1848bb4fa1cdf8f666424fb
> > 
> > Have we managed to reach any kind of agreement on this? (A v2?)
> > 
> > We can still get in fixes post-softfreeze, of course.
> 
> Unless Halil has a v2 ready, 
> I think the current patch is fine as is as a fix. I would suggest
> to go with that and we can then do more beautification later when
> necessary.
> 
> 

I think we were waiting for Paolo to chime in regarding the barrier().
The thing I could beautify is using atomic_read(), but frankly I'm not
sure about it, especially considering multi-proccess. My understanding of
volatile is better than my understanding of atomic_read(). On the other
hand, same multi-process question can be asked about atomic_cmpxchg()
and __atomic_compare_exchange_n()...

Regards,
Halil

