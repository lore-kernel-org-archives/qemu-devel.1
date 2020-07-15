Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C01DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8EF206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8EF206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvk5F-0008Oj-Gp
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 12:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>)
 id 1jvk3k-0007Wb-HQ; Wed, 15 Jul 2020 12:15:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>)
 id 1jvk3h-0007VM-Nz; Wed, 15 Jul 2020 12:15:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06FG3sAN138966; Wed, 15 Jul 2020 12:14:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 329uehkyg6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 12:14:59 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FG4ECX140665;
 Wed, 15 Jul 2020 12:14:58 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 329uehkyf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 12:14:58 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FGA7eb009897;
 Wed, 15 Jul 2020 16:14:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04fra.de.ibm.com with ESMTP id 327527jb7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 16:14:56 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06FGErXx11534354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2020 16:14:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 183EAA405C;
 Wed, 15 Jul 2020 16:14:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9706EA405F;
 Wed, 15 Jul 2020 16:14:52 +0000 (GMT)
Received: from osiris (unknown [9.171.64.221])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Jul 2020 16:14:52 +0000 (GMT)
Date: Wed, 15 Jul 2020 18:14:51 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
Message-ID: <20200715161451.GB3934@osiris>
References: <20200713091243.GB4359@osiris>
 <07E9FD5B-F07F-415B-9C00-A2A882F07CBC@redhat.com>
 <92b1a2a6-2348-d4ff-6d20-35f3bfef710a@de.ibm.com>
 <a0b52f65-d253-c51b-6dfc-0a61f939c759@redhat.com>
 <20200715104348.GB6927@osiris>
 <3c163740-6299-a3dd-8b4d-58a5be123b0e@redhat.com>
 <20200715113426.GD6927@osiris>
 <30ba06e7-5e84-9683-5b37-623f40b3a6db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ba06e7-5e84-9683-5b37-623f40b3a6db@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-15_12:2020-07-15,
 2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=hca@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 11:36:38
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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

On Wed, Jul 15, 2020 at 01:42:02PM +0200, David Hildenbrand wrote:
> > So, are you saying that even at IPL time there might already be memory
> > devices attached to the system? And the kernel should _not_ treat them
> > as normal memory?
> 
> Sorry if that was unclear. Yes, we can have such devices (including
> memory areas) on a cold boot/reboot/kexec. In addition, they might pop
> up at runtime (e.g., hotplugging a virtio-mem device). The device is in
> charge of exposing that area and deciding what to do with it.
> 
> The kernel should never treat them as normal memory (IOW, system RAM).
> Not during a cold boot, not during a reboot. The device driver is
> responsible for deciding how to use that memory (e.g., add it as system
> RAM), and which parts of that memory are actually valid to be used (even
> if a tprot might succeed it might not be valid to use just yet - I guess
> somewhat similar to doing a tport on a dcss area - AFAIK, you also don't
> want to use it like normal memory).
> 
> E.g., on x86-64, memory exposed via virtio-mem or virtio-pmem is never
> exposed via the e820 map. The only trace that there might be *something*
> now/in the future is indicated via ACPI SRAT tables. This takes
> currently care of indicating the maximum possible PFN.

Ok, but all of this needa to be documented somewhere. This raises a
couple of questions to me:

What happens on

- IPL Clear with this special memory? Will it be detached/away afterwards?
- IPL Normal? "Obviously" it must stay otherwise kdump would never see
  that memory.

And when you write it's up to the device driver what to with that
memory: is there any documentation available what all of this is good
for? I would assume _most likely_ this extra memory is going to be
added to ZONE_MOVABLE _somehow_ so that it can be taken away also. But
since it is not normal memory, like you say, I'm wondering how that is
supposed to work.

As far as I can tell there would be a lot of inconsistencies in
userspace interfaces which provide memory / zone information. Or I'm
not getting the point of all of this at all.

So please provide more information, or a pointer to documentation.

