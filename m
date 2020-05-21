Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB804C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 23:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8171F207F9
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 23:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8171F207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbuLG-0005wq-N3
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 19:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jbuKh-0005LG-59; Thu, 21 May 2020 19:10:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1jbuKg-0002t4-2v; Thu, 21 May 2020 19:10:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04LN2ouX098143; Thu, 21 May 2020 19:10:24 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mhbptf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2020 19:10:23 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04LN4Q89012033;
 Thu, 21 May 2020 23:10:23 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01dal.us.ibm.com with ESMTP id 313x17w1rw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2020 23:10:23 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04LNAMlA39584254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 May 2020 23:10:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8A29B205F;
 Thu, 21 May 2020 23:10:21 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 767D3B2064;
 Thu, 21 May 2020 23:10:21 +0000 (GMT)
Received: from arbab-vm.localdomain (unknown [9.160.19.51])
 by b01ledav003.gho.pok.ibm.com (Postfix) with SMTP;
 Thu, 21 May 2020 23:10:21 +0000 (GMT)
Received: from arbab-vm (localhost [IPv6:::1])
 by arbab-vm.localdomain (Postfix) with ESMTP id D49A21003FE;
 Thu, 21 May 2020 18:10:18 -0500 (CDT)
Date: Thu, 21 May 2020 18:10:18 -0500
From: Reza Arbab <arbab@linux.ibm.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 1/2] spapr: Add associativity reference point count to
 machine info
Message-ID: <20200521231018.guehu24sndz7lzfl@arbab-vm>
Organization: IBM Linux Technology Center
References: <20200518214418.18248-1-arbab@linux.ibm.com>
 <20200521013437.5da898fb@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521013437.5da898fb@bahia.lan>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-21_16:2020-05-21,
 2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 suspectscore=5 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 cotscore=-2147483648 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=arbab@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 19:10:30
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 01:34:37AM +0200, Greg Kurz wrote:
>On Mon, 18 May 2020 16:44:17 -0500
>Reza Arbab <arbab@linux.ibm.com> wrote:
>> @@ -944,8 +946,9 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>>                       qemu_hypertas->str, qemu_hypertas->len));
>>      g_string_free(qemu_hypertas, TRUE);
>>
>> +    nr_refpoints = MIN(smc->nr_assoc_refpoints, ARRAY_SIZE(refpoints));
>
>Having the machine requesting more reference points than available
>would clearly be a bug. I'd rather add an assert() than silently
>clipping to the size of refpoints[].

I'll rework nr_assoc_refpoints into a bool as David suggested.  
Struggling for a name at the moment, but I'll think on it.

>>      _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
>> -                     refpoints, sizeof(refpoints)));
>> +                     refpoints, nr_refpoints * sizeof(uint32_t)));
>>
>
>Size can be expressed without yet another explicit reference to the
>uint32_t type:
>
>nr_refpoints * sizeof(refpoints[0])

Will do.

>> @@ -4541,6 +4544,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>      smc->linux_pci_probe = true;
>>      smc->smp_threads_vsmt = true;
>>      smc->nr_xirqs = SPAPR_NR_XIRQS;
>> +    smc->nr_assoc_refpoints = 2;
>
>When adding a new setting for the default machine type, we usually
>take care of older machine types at the same time, ie. folding this
>patch into the next one. Both patches are simple enough that it should
>be okay and this would avoid this line to be touched again.

No problem. I'll squash the patches together and work in that PHB compat 
property as well. 

Thanks for your feedback!

-- 
Reza Arbab

