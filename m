Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E830C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A8620759
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A8620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyc5e-0001JN-C9
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 10:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jyc50-0000jN-9O
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:20:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jyc4y-0005sx-9V
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:20:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06NE3UWd101259
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 10:20:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32face3hrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 10:20:09 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06NE3iPH103191
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 10:20:08 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32face3hqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 10:20:08 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NEFWSp027777;
 Thu, 23 Jul 2020 14:20:07 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04wdc.us.ibm.com with ESMTP id 32brq9mxnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jul 2020 14:20:06 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06NEK6DC54002088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jul 2020 14:20:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84F0CB205F;
 Thu, 23 Jul 2020 14:20:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73D71B2064;
 Thu, 23 Jul 2020 14:20:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 23 Jul 2020 14:20:06 +0000 (GMT)
Subject: Re: [PATCH for-5.1 1/2] Revert "tpm: Clean up error reporting in
 tpm_init_tpmdev()"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200723115845.1865886-1-armbru@redhat.com>
 <20200723115845.1865886-2-armbru@redhat.com>
 <9b3d805f-6cb2-35ff-4f5d-879d3bbc00ab@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <618e09cd-5c07-ee7f-3088-e179815c87e8@linux.ibm.com>
Date: Thu, 23 Jul 2020 10:20:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9b3d805f-6cb2-35ff-4f5d-879d3bbc00ab@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-23_06:2020-07-23,
 2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 10:20:10
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 8:50 AM, Philippe Mathieu-Daudé wrote:
> On 7/23/20 1:58 PM, Markus Armbruster wrote:
>> This reverts commit d10e05f15d5c3dd5e5cc59c5dfff460d89d48580.
>>
>> We report some -tpmdev failures, but then continue as if all was fine.
>> Reproducer:
>>
>>      $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -chardev null,id=tpm0 -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0
>>      qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: tpm chardev 'chrtpm' not found.
>>      qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: Could not cleanly shutdown the TPM: No such file or directory
>>      QEMU 5.0.90 monitor - type 'help' for more information
>>      (qemu) qemu-system-x86_64: -device tpm-tis,tpmdev=tpm0: Property 'tpm-tis.tpmdev' can't find value 'tpm0'
>>      $ echo $?
>>      1
>>
>> This is a regression caused by commit d10e05f15d "tpm: Clean up error
>> reporting in tpm_init_tpmdev()".  It's incomplete: be->create(opts)
>> continues to use error_report(), and we don't set an error when it
>> fails.
>>
>> I figure converting the create() methods to Error would make some
>> sense, but I'm not sure it's worth the effort right now.  Revert the
>> broken commit instead, and add a comment to tpm_init_tpmdev().
>>
>> Straightforward conflict in tpm.c resolved.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



