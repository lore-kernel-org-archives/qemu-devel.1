Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B23C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 14:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5492083D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 14:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5492083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41905 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH7cU-0003iM-1U
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 10:02:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH7bX-0003MM-RU
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH7bS-0002cG-26
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:01:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39320
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH7bR-0002bh-TP
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:01:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IDk347183780
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 10:01:24 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rxqyt7pja-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 10:01:21 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 15:01:18 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 18 Apr 2019 15:01:16 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3IE1E4I39518324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 18 Apr 2019 14:01:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D898D42045;
	Thu, 18 Apr 2019 14:01:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 858A142041;
	Thu, 18 Apr 2019 14:01:14 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.131])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 18 Apr 2019 14:01:14 +0000 (GMT)
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-3-borntraeger@de.ibm.com>
	<295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
	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
	syiRa+UVlsKmx1hsEg==
Date: Thu, 18 Apr 2019 16:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <295ae226-a574-00e9-8dd5-6d95e47553ce@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041814-0012-0000-0000-000003103D34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041814-0013-0000-0000-000021488018
Message-Id: <ce51ef6e-b37f-1c4f-f2f2-70f0e999ee6a@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-18_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904180096
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH 02/10] s390x/cpumodel: remove CSSKE from
 base model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418140114.85Sat_wBSZbqrSAW1GthcbgSv0FM851gt6cMKT8ju8M@z>



On 18.04.19 14:45, David Hildenbrand wrote:
> On 18.04.19 13:31, Christian Borntraeger wrote:
>> conditional sske is deprecated and a distant future machine (will be one
>> where the IBC will not allow to fully go back to z14) will remove this
>> feature. To prepare for this and allow for the z14 and older cpu model
>> to still run on systems without csske, remove csske from the base (and
> 
> will csske feature be a default feature for zNext? Or is it not
> available *at all*.
> 
> In case it is not available, baselining and cpu model comparison have to
> be thought about "ignoring csske".
> 
>> thus the default models for z10..z14). For compat machines we have to
>> add those back.
> 
> Base models are machine-independent. That means, changing base models is
> not supported. Once we introduce new models like here, we can set the
> new base models into stone.
> 
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c  |  2 ++
>>  target/s390x/cpu_models.c   | 21 +++++++++++++++++++++
>>  target/s390x/cpu_models.h   |  1 +
>>  target/s390x/gen-features.c |  1 -
>>  4 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index d11069b860..3415948b2c 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -648,6 +648,8 @@ bool css_migration_enabled(void)
>>  
>>  static void ccw_machine_4_0_instance_options(MachineState *machine)
>>  {
>> +    /* re-enable csske for compat machines in the base model */
>> +    s390_cpumodel_fixup_csske();
>>  }
>>  
>>  static void ccw_machine_4_0_class_options(MachineClass *mc)
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index eb125d4d0d..4e5aa879f3 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -93,6 +93,27 @@ static S390FeatBitmap qemu_max_cpu_feat;
>>  /* features part of a base model but not relevant for finding a base model */
>>  S390FeatBitmap ignored_base_feat;
>>  
>> +/*
>> + * We removed CSSKE from the base features. This is a hook for compat machines
>> + * to put this back for gen10..gen14. As the base model is also part of the
>> + * default model to have to fixup both bitfields
>> + */
>> +void s390_cpumodel_fixup_csske(void)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
>> +        const S390CPUDef *def = &s390_cpu_defs[i];
>> +
>> +        if (def->gen < 10 || def->gen > 14) {
>> +            continue;
>> +        }
>> +
>> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->base_feat);
>> +        set_bit(S390_FEAT_CONDITIONAL_SSKE, (unsigned long *)&def->default_feat);
>> +    }
>> +}
> 
> I think that can be avoided by smarter generation of the models, which I
> would prefer.
> 

Very rough, but something like this (I have to find a nice way to use the qemu
clear_bit).

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 15cd9836c4..21c786127a 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -13,6 +13,7 @@
 
 #include <inttypes.h>
 #include <stdio.h>
+#include <string.h>
 #include "cpu_features_def.h"
 
 #define ARRAY_SIZE(array) (sizeof(array) / sizeof(array[0]))
@@ -833,6 +834,16 @@ static void set_bits(uint64_t list[], BitSpec bits)
     }
 }
 
+#define BIT_MASK(nr)            (1UL << ((nr) % 64))
+#define BIT_WORD(nr)            ((nr) / 64)
+static inline void clear_bit(long nr, uint64_t *addr)
+{
+    unsigned long mask = BIT_MASK(nr);
+    unsigned long *p = addr + BIT_WORD(nr);
+
+    *p &= ~mask;
+}
+
 static void print_feature_defs(void)
 {
     uint64_t base_feat[S390_FEAT_MAX / 64 + 1] = {};
@@ -843,6 +854,11 @@ static void print_feature_defs(void)
     printf("\n/* CPU model feature list data */\n");
 
     for (i = 0; i < ARRAY_SIZE(CpuFeatDef); i++) {
+       /* With gen15 CSSKE is deprecated */
+       if (strcmp(CpuFeatDef[i].name, "S390_FEAT_LIST_GEN15_GA1") == 0) {
+               clear_bit(S390_FEAT_CONDITIONAL_SSKE, base_feat);
+               clear_bit(S390_FEAT_CONDITIONAL_SSKE, default_feat);
+       }
         set_bits(base_feat, CpuFeatDef[i].base_bits);
         /* add the base to the default features */
         set_bits(default_feat, CpuFeatDef[i].base_bits);


