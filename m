Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2531CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7F722482
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7F722482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxX1B-0004qv-81
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>)
 id 1jxX0a-0004JI-ME; Mon, 20 Jul 2020 10:43:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63062
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>)
 id 1jxX0Y-0006j4-M0; Mon, 20 Jul 2020 10:43:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06KEXwpp046693; Mon, 20 Jul 2020 10:43:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32dcyq8m1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2020 10:43:07 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06KEYJZl048848;
 Mon, 20 Jul 2020 10:43:07 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32dcyq8m0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2020 10:43:07 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KEbsoh006804;
 Mon, 20 Jul 2020 14:43:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma06fra.de.ibm.com with ESMTP id 32brbgsctq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2020 14:43:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06KEh2Dd43974682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jul 2020 14:43:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63B72AE057;
 Mon, 20 Jul 2020 14:43:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E20D7AE051;
 Mon, 20 Jul 2020 14:43:01 +0000 (GMT)
Received: from osiris (unknown [9.171.24.93])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 20 Jul 2020 14:43:01 +0000 (GMT)
Date: Mon, 20 Jul 2020 16:43:00 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
Message-ID: <20200720144300.GE49856@osiris>
References: <07E9FD5B-F07F-415B-9C00-A2A882F07CBC@redhat.com>
 <92b1a2a6-2348-d4ff-6d20-35f3bfef710a@de.ibm.com>
 <a0b52f65-d253-c51b-6dfc-0a61f939c759@redhat.com>
 <20200715104348.GB6927@osiris>
 <3c163740-6299-a3dd-8b4d-58a5be123b0e@redhat.com>
 <20200715113426.GD6927@osiris>
 <30ba06e7-5e84-9683-5b37-623f40b3a6db@redhat.com>
 <20200715161451.GB3934@osiris>
 <d612da2a-c8fb-ffa6-0913-6cc0ec9b0f7f@redhat.com>
 <f30637d2-cfc0-33f3-42ce-df1eaceded8e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f30637d2-cfc0-33f3-42ce-df1eaceded8e@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-20_09:2020-07-20,
 2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=689 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200099
Received-SPF: pass client-ip=148.163.158.5; envelope-from=hca@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 10:43:07
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 07:51:27PM +0200, David Hildenbrand wrote:
> > Regarding documentation (some linked in the cover letter), so far I have
> > (generic/x86-64)
> > 
> > 1. https://virtio-mem.gitlab.io/
> > 2. virtio spec proposal [1]
> > 3. QEMU 910b25766b33 ("virtio-mem: Paravirtualized memory hot(un)plug")
> > 4. Linux 5f1f79bbc9 ("virtio-mem: Paravirtualized memory hotplug")
> > 5. Linux cover letter [2]
> > 6. KVM forum talk [3] [4]
> > 
> > As your questions go quite into technical detail, and I don't feel like
> > rewriting the doc here :) , I suggest looking at [2], 1, and 5.
> 
> Sorry, I suggest looking at [3] (not [2]) first. Includes pictures and a
> comparison to memory ballooning (and DIMM-based memory hotplug).

Ok, thanks for the pointers!

So I would go for what you suggested with option 2: provide a new
diagnose which tells the kernel where the memory device area is
(probably just start + size?), and leave all other interfaces alone.

This looks to me like the by far "cleanest" solution which does not
add semantics to existing interfaces, where it is questionable if this
wouldn't cause problems in the future.

