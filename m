Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A75C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 21:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E4320760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 21:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E4320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwBtL-0007eV-H8
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 17:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jwBsZ-0006vL-GP
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 17:57:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jwBsX-0003D1-Gg
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 17:57:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06GLgt2w014315
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 17:57:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32auqudvyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 17:57:18 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GLpQk4036106
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 17:57:18 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32auqudvy4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2020 17:57:18 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GLjLWh023698;
 Thu, 16 Jul 2020 21:57:17 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma01wdc.us.ibm.com with ESMTP id 32752940yj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2020 21:57:17 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06GLvErI57606524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2020 21:57:14 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 333D96A04D;
 Thu, 16 Jul 2020 21:57:16 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0EDD6A047;
 Thu, 16 Jul 2020 21:57:15 +0000 (GMT)
Received: from [9.160.125.194] (unknown [9.160.125.194])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2020 21:57:15 +0000 (GMT)
Subject: Re: [PATCH 2/2] configure: add support for Control-Flow Integrity
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
 <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
 <20200702095252.GF1888119@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <67e3ea49-a19b-732f-233e-f9fc27391df0@linux.vnet.ibm.com>
Date: Thu, 16 Jul 2020 17:57:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702095252.GF1888119@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-16_11:2020-07-16,
 2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160140
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 17:57:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/2020 5:52 AM, Daniel P. Berrangé wrote:
> The need to maintain this list of functions makes me feel very
> uneasy.
> 
> How can we have any confidence that this list of functions is
> accurate ? How will maintainers ensure that they correctly update
> it as they are writing/changing code, and how will they test the
> result ?

Hi Daniel,

I gave it some thought and studied more of clang's options. It is 
possible to disable cfi on specific functions by using an __attribute__ 
keyword, instead of providing a list in an external file.
In terms of maintaining, this is much better since we are removing the 
need to update the list. I would suggest defining a macro, 
__disable_cfi__, that can be prepended to a function. The macro would 
expand to nothing if cfi is disabled, or to the proper attribute if it 
is enabled. Here's example code snippet

/* Disable CFI checks.
  * The callback function has been loaded from an external library so we 
do not
  * have type information */
__disable_cfi__
void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
{
...
}

This would take care of renaming and removal of functions that need cfi.
It would also probably be beneficial to the developers since they can 
see immediately that the function they are working with needs to have 
CFI checks disabled, and why.

If you think this is a better approach, I'll submit v2 with this 
approach instead of the external function list.


For new code, however, the best thing is proper education and testing.
I'll work on a document for docs/devel to detail what it is and how to 
make code cfi-safe.
A good approach should be to test code changes with CFI enabled. CFI is, 
after all, a sanitizer and therefore it makes sense to use it also 
during development, together with ASan, UBSan and the likes. 
Unfortunately, since it works only with clang, I don't think this can 
ever be a hard requirement.

Daniele

