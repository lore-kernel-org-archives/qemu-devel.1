Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FEC12465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEC12465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuH7o-0002ng-DQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1iuH6N-0001ZS-Ul
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1iuH6M-00081f-J1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:35:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1iuH6M-00080k-BP; Wed, 22 Jan 2020 09:35:26 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00MEXRtU125767; Wed, 22 Jan 2020 09:35:24 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xkxj08e21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2020 09:35:23 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00MEXRnx125743;
 Wed, 22 Jan 2020 09:35:22 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xkxj08dn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2020 09:35:17 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00MEYcA6018836;
 Wed, 22 Jan 2020 14:34:53 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 2xksn775qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jan 2020 14:34:53 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00MEYpcq34079178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2020 14:34:51 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BD4A78066;
 Wed, 22 Jan 2020 14:34:51 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD36878064;
 Wed, 22 Jan 2020 14:34:50 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.60.75.231])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 22 Jan 2020 14:34:50 +0000 (GMT)
Subject: Re: [PATCH v5] target/s390x/kvm: Enable adapter interruption
 suppression again
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20200122101437.5069-1-thuth@redhat.com>
 <20200122112910.5b8f74c9.cohuck@redhat.com>
 <f4e87ccf-5484-c305-aff1-13feccd5dabb@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <0e99f491-002f-c42b-edbe-892ea8c269df@linux.ibm.com>
Date: Wed, 22 Jan 2020 09:34:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f4e87ccf-5484-c305-aff1-13feccd5dabb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-17_05:2020-01-16,
 2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220132
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 5:33 AM, Thomas Huth wrote:
> On 22/01/2020 11.29, Cornelia Huck wrote:
>> On Wed, 22 Jan 2020 11:14:37 +0100
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> The AIS feature has been disabled late in the v2.10 development cycle since
>>> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
>>> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
>>> to enable it again for newer machine types, but apparently we forgot to do
>>> this so far. Let's do it now for the machines that support proper CPU models.
>>>
>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   v5: Use cpu_model_allowed() as suggested by David. Seems to work as far
>>>       as I can test it without PCI cards, but ping-pong migration with
>>>       "-cpu host" from/to an older version of QEMU is now not working
>>>       anymore - but I think that's kind of expected since "-cpu host"
>>>       is not migration-safe anyway.
>>
>> Ok, so I'll wait for test results with pci cards before queuing this :)
> 
> Ok, Matthew, could you please test one more time?
> 

Ran all of the same tests as before, looks good!

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

