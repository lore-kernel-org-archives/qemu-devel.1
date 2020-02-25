Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126AC35E03
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865BE21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865BE21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6bKR-000841-LM
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mihajlov@linux.ibm.com>) id 1j6bJs-0007cA-26
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mihajlov@linux.ibm.com>) id 1j6bJr-0002hx-26
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:36:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mihajlov@linux.ibm.com>)
 id 1j6bJq-0002ga-RB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:36:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01PEYrRH124113
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 09:36:17 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yaygq21k8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 09:35:55 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mihajlov@linux.ibm.com>;
 Tue, 25 Feb 2020 14:35:52 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 25 Feb 2020 14:35:49 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01PEZmuJ50855986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2020 14:35:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 512D7AE051;
 Tue, 25 Feb 2020 14:35:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 042B3AE045;
 Tue, 25 Feb 2020 14:35:48 +0000 (GMT)
Received: from oc6604088431.ibm.com (unknown [9.152.222.39])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 25 Feb 2020 14:35:47 +0000 (GMT)
Subject: Re: [PATCH 1/1] s390/ipl: sync back loadparm
To: Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20200224150213.21253-1-pasic@linux.ibm.com>
 <05f7dcf7-a0c7-8811-6b88-df86d5fa0974@redhat.com>
 <20200225125641.72e8cc86.pasic@linux.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Date: Tue, 25 Feb 2020 15:35:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225125641.72e8cc86.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022514-0020-0000-0000-000003AD76ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022514-0021-0000-0000-000022058DAE
Message-Id: <853387e3-4425-731b-bb09-a7210ea6b299@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-25_05:2020-02-21,
 2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250114
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/25/20 12:56 PM, Halil Pasic wrote:
> On Tue, 25 Feb 2020 10:39:40 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 24.02.20 16:02, Halil Pasic wrote:
>>> We expose loadparm as a r/w machine property, but if loadparm is set by
>>> the guest via DIAG 308, we don't update the property. Having a
>>> disconnect between the guest view and the QEMU property is not nice in
>>> itself, but things get even worse for SCSI, where under certain
>>> circumstances (see 789b5a401b "s390: Ensure IPL from SCSI works as
>>> expected" for details) we call s390_gen_initial_iplb() on resets
>>> effectively overwriting the guest/user supplied loadparm with the stale
>>> value.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>> Fixes: 7104bae9de "hw/s390x: provide loadparm property for the machine"
>>> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
>>> Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>>> ---
>>>   hw/s390x/ipl.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
[...]
>>> +
>>> +    /* Sync loadparm */
>>> +    if (iplb->flags & DIAG308_FLAGS_LP_VALID) {
>>> +        char ascii_loadparm[8];
>>> +        uint8_t *ebcdic_loadparm = iplb->loadparm;
>>> +        int i;
>>> +
>>> +        for (i = 0; i < 8 && ebcdic_loadparm[i]; i++) {
>>> +            ascii_loadparm[i] = ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
>>> +        }
>>> +        ascii_loadparm[i] = 0;
>>> +        object_property_set_str(mo, ascii_loadparm, "loadparm", NULL);
>>> +    } else {
>>> +        object_property_set_str(mo, "", "loadparm", NULL);
>>> +    }
>>
>> &error_abort instead of NULL, we certainly want to know if this would
>> ever surprisingly fail.
> 
> IMHO this is a typical assert() situation where one would like to have
> a fast and obvious failure when testing, but not in production.
> 
> AFAIU the guest can trigger this code at any time, and crashing the
> whole (production) system seems a bit heavy handed to me. The setter
> should only fail if something is buggy.
> 
> But if the majority says &error_abort I can certainly do. Other opinions?
> 
We might consider to return 0x0402 (invalid parameter) from the diag308 
"set", which is less drastic and would allow the OS to do whatever it 
finds appropriate to deal with the failure. Not that Linux would care 
about that today :-).

[...]
-- 
Kind Regards,
    Viktor


