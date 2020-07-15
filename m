Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A41C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271C120656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 10:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271C120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvetw-0007wd-El
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 06:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>)
 id 1jvetL-0007WZ-UQ; Wed, 15 Jul 2020 06:43:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61786
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hca@linux.ibm.com>)
 id 1jvetK-0004rI-93; Wed, 15 Jul 2020 06:43:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06FAaaV2174284; Wed, 15 Jul 2020 06:43:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 329r1yvgyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 06:43:55 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FAbsWP177000;
 Wed, 15 Jul 2020 06:43:55 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 329r1yvgyk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 06:43:55 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FAel7l015943;
 Wed, 15 Jul 2020 10:43:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 327527vb1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 10:43:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 06FAhocd63308228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2020 10:43:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86DFBA404D;
 Wed, 15 Jul 2020 10:43:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08184A4053;
 Wed, 15 Jul 2020 10:43:50 +0000 (GMT)
Received: from osiris (unknown [9.171.91.154])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Jul 2020 10:43:49 +0000 (GMT)
Date: Wed, 15 Jul 2020 12:43:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
Message-ID: <20200715104348.GB6927@osiris>
References: <20200713091243.GB4359@osiris>
 <07E9FD5B-F07F-415B-9C00-A2A882F07CBC@redhat.com>
 <92b1a2a6-2348-d4ff-6d20-35f3bfef710a@de.ibm.com>
 <a0b52f65-d253-c51b-6dfc-0a61f939c759@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0b52f65-d253-c51b-6dfc-0a61f939c759@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-15_07:2020-07-15,
 2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=999 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007150084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=hca@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:27:14
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

On Wed, Jul 15, 2020 at 11:42:37AM +0200, David Hildenbrand wrote:
> So, in summary, we want to indicate to the guest a memory region that
> will be used to place memory devices ("device memory region"). The
> region might have holes and the memory within this region might have
> different semantics than ordinary system memory. Memory that belongs to
> memory devices should only be detected+used if the guest OS has support
> for them (e.g., virtio-mem, virtio-pmem, ...). An unmodified guest
> (e.g., no virtio-mem driver) should not accidentally make use of such
> memory.
> 
> We need a way to
> a) Tell the guest about boot memory (currently ram_size)
> b) Tell the guest about the maximum possible ram address, including
> device memory. (We could also indicate the special "device memory
> region" explicitly)
> 
> AFAIK, we have three options:
> 
> 1. Indicate maxram_size via SCLP, indicate ram_size via diag260(0x10)
> 
> This is what this series (RFCv1 does).
> 
> Advantages:
> - No need for a new diag. No need for memory sensing kernel changes.
> Disadvantages
> - Older guests without support for diag260 (<v4.2, kvm-unit-tests) will
>   assume all memory is accessible. Bad.

Why would old guests assume that?

At least in v4.1 the kernel will calculate the max address by using
increment size * increment number and then test if *each* increment is
available with tprot.

> - The semantics of the value returned in ry via diag260(0xc) is somewhat
>   unclear. Should we return the end address of the highest memory
>   device? OTOH, an unmodified guest OS (without support for memory
>   devices) should not have to care at all about any such memory.

I'm confused. The kernel currently only uses diag260(0x10). How is
diag260(0xc) relevant here?

> 3. Indicate maxram_size and ram_size via SCLP (using the SCLP standby
>    memory)
> 
> I did not look into the details, because -ENODOCUMENTATION. At least we
> would run into some alignment issues (again, having to align
> ram_size/maxram_size to storage increments - which would no longer be
> 1MB). We would run into issues later, trying to also support standby memory.

That doesn't make sense to me: either support memory hotplug via
sclp/standby memory, or with your new method. But trying to support
both.. what's the use case?

