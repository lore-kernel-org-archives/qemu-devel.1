Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6970C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7B22171F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7B22171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7MTq-0000no-SQ
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i7MPy-00057n-H1
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i7MPx-0000HF-5Y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:21:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1i7MPw-0000GF-U0; Mon, 09 Sep 2019 12:21:29 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x89GIbcl085576; Mon, 9 Sep 2019 12:21:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uv86v4am6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2019 12:21:24 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x89GIh9J085798;
 Mon, 9 Sep 2019 12:21:21 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uv86v4ahp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2019 12:21:21 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x89GKHHo020622;
 Mon, 9 Sep 2019 16:21:16 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma02wdc.us.ibm.com with ESMTP id 2uv466urfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2019 16:21:16 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x89GLFAu29229456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2019 16:21:15 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C59E2124052;
 Mon,  9 Sep 2019 16:21:15 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C43B124053;
 Mon,  9 Sep 2019 16:21:15 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.134.207])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2019 16:21:15 +0000 (GMT)
To: Thomas Huth <thuth@redhat.com>, cohuck@redhat.com
References: <1567815389-18229-1-git-send-email-mjrosato@linux.ibm.com>
 <1567815389-18229-4-git-send-email-mjrosato@linux.ibm.com>
 <0c29ba98-d404-d570-d1c0-5d1a3750f6ad@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Openpgp: preference=signencrypt
Message-ID: <8fec5bce-7408-05e4-9726-9e2fd531cccb@linux.ibm.com>
Date: Mon, 9 Sep 2019 12:21:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0c29ba98-d404-d570-d1c0-5d1a3750f6ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-09_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090165
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 3/5] s390: vfio_pci: Use a
 PCI Group structure
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
Cc: walling@linux.ibm.com, pmorel@linux.ibm.com, mst@redhat.com,
 qemu-s390x@nongnu.org, david@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/19 1:18 AM, Thomas Huth wrote:
> On 07/09/2019 02.16, Matthew Rosato wrote:
>> From: Pierre Morel <pmorel@linux.ibm.com>
>>
>> We use a S390PCIGroup structure to hold the information
>> related to zPCI Function group.
>>
>> This allows us to be ready to support multiple groups and to retrieve
>> the group information from the host.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>  hw/s390x/s390-pci-bus.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  hw/s390x/s390-pci-bus.h  | 11 ++++++++++-
>>  hw/s390x/s390-pci-inst.c | 22 +++++++++++++---------
>>  3 files changed, 65 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 963a41c..e625217 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -730,6 +730,46 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>>      object_unref(OBJECT(iommu));
>>  }
>>  
>> +static S390PCIGroup *s390_grp_create(int ug)
>> +{
>> +    S390PCIGroup *grp;
>> +    S390pciState *s = s390_get_phb();
>> +
>> +    grp = g_new0(S390PCIGroup, 1);
>> +    grp->ug = ug;
>> +    QTAILQ_INSERT_TAIL(&s->zpci_grps, grp, link);
>> +    return grp;
>> +}
> 
> Maybe an ignorant question, but shouldn't there also be some kind of
> clean up function that also frees the memory again, e.g. during a
> machine reset? Or are these groups supposed to survive a machine reset?

Hmm..  Well, I think it is in line with the way the devices themselves
are handled during reset (they are not removed during a reset unless
there was a pending unplug and their info persists).  But you have a
point in that it seems sketchy to leave the group information around,
particularly in cases where the last device associated with the group
has been unplugged.

So yes, I think there is some work to be done here.  I need to
investigate whether a precautionary wiping of the list (minus the
default group) at machine reset is really good enough or whether we need
to remove group info sooner (device unplug).

Thanks,
Matt

