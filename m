Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4AFC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7FC222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7FC222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDV6b-0005Yo-EA
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1iDV4Y-0004qc-RU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1iDV4W-0002HE-Tk
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:48:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25694
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1iDV4W-0002GQ-Q0; Thu, 26 Sep 2019 10:48:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8QEmQ2n114862; Thu, 26 Sep 2019 10:48:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v8x6dbvu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 10:48:34 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8QEmXS4115495;
 Thu, 26 Sep 2019 10:48:33 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v8x6dbvau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 10:48:33 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8QEj0Rv031425;
 Thu, 26 Sep 2019 14:47:38 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02dal.us.ibm.com with ESMTP id 2v5bg83t8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 14:47:38 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8QElaVw49414508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2019 14:47:36 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AC0EAC05B;
 Thu, 26 Sep 2019 14:47:36 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D75CFAC059;
 Thu, 26 Sep 2019 14:47:35 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.182.236])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 26 Sep 2019 14:47:35 +0000 (GMT)
Subject: Re: [PATCH] s390: PCI: fix IOMMU region init
To: Peter Maydell <peter.maydell@linaro.org>
References: <1569507036-15314-1-git-send-email-mjrosato@linux.ibm.com>
 <CAFEAcA9VFmeqGy0Rt7_8GEenQx_8M75=FQX4zbL+c904hNx0gg@mail.gmail.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Openpgp: preference=signencrypt
Message-ID: <7dffb24d-5ad3-4063-7743-44da7ce566fe@linux.ibm.com>
Date: Thu, 26 Sep 2019 10:47:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9VFmeqGy0Rt7_8GEenQx_8M75=FQX4zbL+c904hNx0gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-26_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Collin Walling <walling@linux.ibm.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, stzi@linux.ibm.com,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 10:34 AM, Peter Maydell wrote:
> On Thu, 26 Sep 2019 at 15:12, Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>>
>> The fix in dbe9cf606c shrinks the IOMMU memory region to a size
>> that seems reasonable on the surface, however is actually too
>> small as it is based against a 0-mapped address space.  This
>> causes breakage with small guests as they can overrun the IOMMU window.
>>
>> Let's go back to the prior method of initializing iommu for now.
>>
>> Fixes: dbe9cf606c ("s390x/pci: Set the iommu region size mpcifc request")
>> Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
>> Reported-by: Stefan Zimmerman <stzi@linux.ibm.com>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> So in commit f0a399dbae6a2d0e2 (Nov 2015) we used "pal - pba + 1".
> In commit f7c40aa1e7feb50bc4 (June 2016) we switched to "pal + 1".
> In commit dbe9cf606c (Jan 2019) we went back to "pal - pba + 1"
> Now we're on "pal + 1" again...
> 
> Are we really sure that this is correct and that we're not
> just going to keep looping around between these two formations
> forever? :-)
> 

Yes :) -- Pierre's RB comment sums it up pretty well, until we change
the way the address space is mapped it is not safe to use pal - pba + 1.
 This was noted in f7c40aa1e and then erroneously missed in dbe9cf606c.
 With this, small guests break immediately (PCI base is higher than the
IOMMU region can handle).  Larger guests don't break immediately but can
break later if their PCI space usage pushes high enough (their IOMMU
region can handle pba, but somewhere < pal).

The comment block added was to help assist in keeping further hands off
of this call until such a time where the address space mapping is changed.

> thanks
> -- PMM
> 


