Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79D6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFD7F217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD7F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZzZ-0006zI-QW
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1itZyj-0006Bf-Cj
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1itZyg-0007QL-My
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:32:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1itZyg-0007PX-29; Mon, 20 Jan 2020 11:32:38 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00KGR58O006835; Mon, 20 Jan 2020 11:32:37 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xmfyy0w40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jan 2020 11:32:36 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00KGRkKO012156;
 Mon, 20 Jan 2020 11:32:36 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xmfyy0w36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jan 2020 11:32:36 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00KGVqao030640;
 Mon, 20 Jan 2020 16:32:35 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03dal.us.ibm.com with ESMTP id 2xksn69bcv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jan 2020 16:32:35 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00KGWYIc23462270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jan 2020 16:32:34 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7025B112062;
 Mon, 20 Jan 2020 16:32:34 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FAE6112061;
 Mon, 20 Jan 2020 16:32:34 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.60.75.231])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 20 Jan 2020 16:32:33 +0000 (GMT)
Subject: Re: [PATCH v3] target/s390x/kvm: Enable adapter interruption
 suppression again
To: Cornelia Huck <cohuck@redhat.com>
References: <20200120132441.11884-1-thuth@redhat.com>
 <a4606ae6-1c74-d584-4bf1-9e4d11bb7a8e@linux.ibm.com>
 <20200120172918.26d5db9b.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <9ae9bd1e-f3f7-cc3b-ef7c-c0d678ca3f07@linux.ibm.com>
Date: Mon, 20 Jan 2020 11:32:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200120172918.26d5db9b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-20_07:2020-01-20,
 2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200138
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 11:29 AM, Cornelia Huck wrote:
> On Mon, 20 Jan 2020 11:23:37 -0500
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> On 1/20/20 8:24 AM, Thomas Huth wrote:
>>> The AIS feature has been disabled late in the v2.10 development cycle since
>>> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
>>> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
>>> to enable it again for newer machine types, but apparently we forgot to do
>>> this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.
>>>
>>> While at it, also add a more verbose comment why we need the *_allowed()
>>> wrappers in s390-virtio-ccw.c.
>>>
>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>
>> Took it for a spin with vfio-pci.  With this patch applied, I see the
>> appropriate change reflected in guest /proc/cpuinfo.  I did some tracing
>> and see the expected behavior changes (ex: hits in host
>> kvm_s390_injrect_airq that show suppression occurring).  Data transfer
>> tests worked fine.  Also sanity-tested that ais=off behaves as expected.
>>
>> Looks good to me.
>>
> 
> Excellent, thanks for testing!
> 
> Should I add a Tested-by: ?
> 

Sure, go ahead.

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

