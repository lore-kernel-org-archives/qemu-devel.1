Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB4BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9BA2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9BA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuWj-0001Yv-Ta
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>)
 id 1juuW7-00012o-Eg; Mon, 13 Jul 2020 05:12:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54200
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>)
 id 1juuW5-0004U1-GC; Mon, 13 Jul 2020 05:12:55 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06D92YU8011410; Mon, 13 Jul 2020 05:12:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 327tn93vmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2020 05:12:50 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06D965Rl022758;
 Mon, 13 Jul 2020 05:12:50 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 327tn93vkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2020 05:12:50 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06D95dSE031229;
 Mon, 13 Jul 2020 09:12:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma04ams.nl.ibm.com with ESMTP id 32752820yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2020 09:12:48 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06D9CjrT57933840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jul 2020 09:12:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9C4B4C044;
 Mon, 13 Jul 2020 09:12:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 528574C050;
 Mon, 13 Jul 2020 09:12:45 +0000 (GMT)
Received: from osiris (unknown [9.171.14.89])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 13 Jul 2020 09:12:45 +0000 (GMT)
Date: Mon, 13 Jul 2020 11:12:43 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
Message-ID: <20200713091243.GB4359@osiris>
References: <20200708185135.46694-1-david@redhat.com>
 <20200708185135.46694-3-david@redhat.com>
 <efe7e845-2e0f-96ba-7e29-c6ac74db9e2f@de.ibm.com>
 <c86e5b12-883a-8522-a15c-9af3804e003c@redhat.com>
 <a337aa94-cd0a-de6f-70df-35428b3e3a3a@redhat.com>
 <0e04ce47-b761-27c3-bc80-ba8338d4253e@redhat.com>
 <20200710151816.GC14845@osiris>
 <10bdd986-c474-278d-ed6a-193d9a45fe33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bdd986-c474-278d-ed6a-193d9a45fe33@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-13_04:2020-07-10,
 2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=889 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=hca@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 04:43:47
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 05:24:07PM +0200, David Hildenbrand wrote:
> On 10.07.20 17:18, Heiko Carstens wrote:
> > On Fri, Jul 10, 2020 at 02:12:33PM +0200, David Hildenbrand wrote:
> >>> Note: Reading about diag260 subcode 0xc, we could modify Linux to query
> >>> the maximum possible pfn via diag260 0xc. Then, we maybe could avoid
> >>> indicating maxram size via SCLP, and keep diag260-unaware OSs keep
> >>> working as before. Thoughts?
> >>
> >> Implemented it, seems to work fine.
> > 
> > The returned value would not include standby/reserved memory within
> > z/VM. So this seems not to work.
> 
> Which value exactly are you referencing? diag 0xc returns two values.
> One of them seems to do exactly what we need.
> 
> See
> https://github.com/davidhildenbrand/linux/commit/a235f9fb20df7c04ae89bc0d134332d1a01842c7
> 
> for my current Linux approach.
> 
> > Also: why do you want to change this
> 
> Which change exactly do you mean?
> 
> If we limit the value returned via SCLP to initial memory, we cannot
> break any guest (e.g., Linux pre 4.2, kvm-unit-tests). diag260 is then
> purely optional.

Ok, now I see the context. Christian added my just to cc on this
specific patch.
So if I understand you correctly, then you want to use diag 260 in
order to figure out how much memory is _potentially_ available for a
guest?

This does not fit to the current semantics, since diag 260 returns the
address of the highest *currently* accessible address. That is: it
does explicitly *not* include standby memory or anything else that
might potentially be there.

So you would need a different interface to tell the guest about your
new hotplug memory interface. If sclp does not work, then maybe a new
diagnose(?).

