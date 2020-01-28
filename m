Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE1C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EC620702
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EC620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwS1m-0000J0-ND
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 09:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <walling@linux.ibm.com>) id 1iwS10-0007pT-CW
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1iwS0z-0005NK-Gp
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:38:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1iwS0z-0005MG-8n; Tue, 28 Jan 2020 09:38:53 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00SEbAEi009382; Tue, 28 Jan 2020 09:38:52 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrj72k8x7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2020 09:38:50 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00SEbBhd009451;
 Tue, 28 Jan 2020 09:38:26 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrj72k7yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2020 09:38:26 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00SEU8Au002070;
 Tue, 28 Jan 2020 14:37:48 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma04wdc.us.ibm.com with ESMTP id 2xrda6a22t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2020 14:37:48 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00SEblHU19988758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2020 14:37:47 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A71D2C605A;
 Tue, 28 Jan 2020 14:37:47 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89B6BC6059;
 Tue, 28 Jan 2020 14:37:46 +0000 (GMT)
Received: from [9.56.58.87] (unknown [9.56.58.87])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2020 14:37:46 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
To: Cornelia Huck <cohuck@redhat.com>
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <20200127124756.3627f754.cohuck@redhat.com>
 <1cbd5354-d9ca-a10e-0053-a61a00223f53@linux.ibm.com>
 <20200127183504.2de2654f.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Organization: IBM
Message-ID: <4c7cfd8f-3994-404e-1587-293e19f471de@linux.ibm.com>
Date: Tue, 28 Jan 2020 09:37:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200127183504.2de2654f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-28_03:2020-01-28,
 2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280117
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, david@redhat.com,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 12:35 PM, Cornelia Huck wrote:
> On Mon, 27 Jan 2020 11:39:02 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> On 1/27/20 6:47 AM, Cornelia Huck wrote:
>>> On Fri, 24 Jan 2020 17:14:04 -0500
>>> Collin Walling <walling@linux.ibm.com> wrote:
>>>   
>>>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>>>> be intercepted by SIE and handled via KVM. Let's introduce some
>>>> functions to communicate between QEMU and KVM via ioctls. These
>>>> will be used to get/set the diag318 information.  
>>>
>>> Do you want to give a hint what diag 318 actually does?
>>>   
>>
>> For the sake of completeness, I'll have to get back to you on this.
>>

The DIAGNOSE 318 instruction allows the guest to store diagnostic data
that is collected by the firmware in the case of hardware/firmware
service events. The instruction is invoked in the Linux kernel and
intercepted in KVM. QEMU needs to collect this data for migration
so that this data is consistent on the destination host.

Perhaps I should add this to the patch description as well? :)

[...]


-- 
Respectfully,
- Collin Walling

