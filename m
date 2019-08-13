Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456C9C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167C120665
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167C120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxRGy-0005tv-3b
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 03:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hxRGW-0005OF-O0
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hxRGV-00022r-Jr
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:30:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48436
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hxRGT-0001zx-0o; Tue, 13 Aug 2019 03:30:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7D7QqaD009483; Tue, 13 Aug 2019 03:30:30 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ubneuf281-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Aug 2019 03:30:30 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7D7OLqv026808;
 Tue, 13 Aug 2019 07:30:29 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03dal.us.ibm.com with ESMTP id 2u9nj6v905-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Aug 2019 07:30:29 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7D7UShC20971856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2019 07:30:28 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9BC1AC065;
 Tue, 13 Aug 2019 07:30:27 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE780AC05F;
 Tue, 13 Aug 2019 07:30:25 +0000 (GMT)
Received: from [9.85.81.164] (unknown [9.85.81.164])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 13 Aug 2019 07:30:25 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20190719024555.18845-1-aik@ozlabs.ru>
 <ae3e5bd1-c7dd-d893-5c0e-803f4e4f2325@linux.vnet.ibm.com>
 <20190812100849.GF3947@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <3722a768-c8bb-ed04-e450-b18cba8e6296@linux.vnet.ibm.com>
Date: Tue, 13 Aug 2019 13:00:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190812100849.GF3947@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-13_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130081
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries REPOST]
 pseries: Update SLOF firmware image
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Monday 12 August 2019 03:38 PM, David Gibson wrote:
> On Mon, Aug 05, 2019 at 02:14:39PM +0530, Aravinda Prasad wrote:
>> Alexey/David,
>>
>> With the SLOF changes, QEMU cannot resize the RTAS blob. Resizing is
>> required for FWNMI support which extends the RTAS blob to include an
>> error log upon a machine check.
>>
>> The check to valid RTAS buffer fails in the guest because the rtas-size
>> updated in QEMU is not reflecting in the guest.
>>
>> Any workaround for this?
> 
> Well, we should still be able to do it, it just means fwnmi would need
> a SLOF change.  It's an inconvenience, but not really a big deal.

Yes. Alexey and I were discussing about the following changes to SLOf:

diff --git a/lib/libhvcall/hvcall.S b/lib/libhvcall/hvcall.S
index b19f6dbeff2c..880d29a29122 100644
--- a/lib/libhvcall/hvcall.S
+++ b/lib/libhvcall/hvcall.S
@@ -134,6 +134,7 @@ ENTRY(hv_rtas)
        ori     r3,r3,KVMPPC_H_RTAS@l
        HVCALL
        blr
+    .space 2048
        .globl hv_rtas_size
 hv_rtas_size:
        .long . - hv_rtas;


But this will statically reserve space for RTAS even when
SPAPR_CAP_FWNMI_MCE is OFF.

Regards,
Aravinda

> 
>> The following FWNMI work which is under review modifies the rtas-size to
>> accommodate the error log:
>> https://lists.nongnu.org/archive/html/qemu-ppc/2019-06/msg00142.html
>>
>>
>> Regards,
>> Aravinda
>>
>> On Friday 19 July 2019 08:15 AM, Alexey Kardashevskiy wrote:
>>> I messed up with my local git so reposting.
>>>
>>> The following changes since commit 216965b20b04fbf74e0ce3a3175a9171dba210de:
>>>
>>>   ppc/pnv: update skiboot to v6.4 (2019-07-18 16:49:57 +1000)
>>>
>>> are available in the Git repository at:
>>>
>>>   git@github.com:aik/qemu.git tags/qemu-slof-20190719
>>>
>>> for you to fetch changes up to 300118db53cc454b049d64418c7b2588165a1c35:
>>>
>>>   pseries: Update SLOF firmware image (2019-07-19 12:43:27 +1000)
>>>
>>> ----------------------------------------------------------------
>>> Alexey Kardashevskiy (1):
>>>       pseries: Update SLOF firmware image
>>>
>>>  pc-bios/README   |   2 +-
>>>  pc-bios/slof.bin | Bin 926432 -> 926784 bytes
>>>  roms/SLOF        |   2 +-
>>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>>
>>> *** Note: this is not for master, this is for pseries
>>>
>>
> 

-- 
Regards,
Aravinda

