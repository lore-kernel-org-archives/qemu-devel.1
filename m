Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC848C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A4220823
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A4220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc9iz-0007oC-M2
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 11:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jc9iC-000740-Vm
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:35:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jc9i8-0006rF-Uu
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:35:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04MFX8nv088630
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 11:35:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mubh4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 11:35:47 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04MFYYJB093110
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 11:35:46 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3160mubh40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 11:35:46 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04MFKvqQ030728;
 Fri, 22 May 2020 15:35:45 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 314wxpsree-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2020 15:35:45 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04MFZgsu29163852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2020 15:35:42 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED7776A047;
 Fri, 22 May 2020 15:35:43 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2269E6A04D;
 Fri, 22 May 2020 15:35:43 +0000 (GMT)
Received: from [9.160.66.72] (unknown [9.160.66.72])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2020 15:35:42 +0000 (GMT)
Subject: Re: [PATCH 4/4] check-block: Enable iotests with SafeStack
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <20200429194420.21147-5-dbuono@linux.vnet.ibm.com>
 <20200521095902.GD251811@stefanha-x1.localdomain>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <dc422d29-131b-a5a8-ee10-6dccff7caea4@linux.vnet.ibm.com>
Date: Fri, 22 May 2020 11:35:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521095902.GD251811@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-22_05:2020-05-22,
 2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005220125
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:18:25
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, thuth@redhat.com,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 5/21/2020 5:59 AM, Stefan Hajnoczi wrote:
> On Wed, Apr 29, 2020 at 03:44:20PM -0400, Daniele Buono wrote:
>> SafeStack is a stack protection technique implemented in llvm. It is
>> enabled with a -fsanitize flag.
>> iotests are currently disabled when any -fsanitize option is used.
>> Since SafeStack is useful on production environments, and its
>> implementation may break the binary, filter it out when the check is
>> performed, so that if SafeStack was the only -fsanitize option, iotests
>> are still performed.
> 
> I can't parse this sentence. What does "its implementation may break the
> binary" mean? Do you mean it's worth running tests with SafeStack
> enabled because it exposes failures that go unnoticed without SafeStack?

What I meant is that, without proper changes, SafeStack breaks 
co-routines. Since they are heavily used in the io subsystem, this is 
probably the best class of tests to make sure co-routines are working 
fine with SafeStack.

I initially re-enabled the iotests for my internal testing.

Since I wasn't seeing any issue, I thought it would be useful to keep 
running this to make sure future implementations of SafeStack won't 
break co-routines again.

> 
>>
>> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
>> ---
>>   tests/check-block.sh | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/check-block.sh b/tests/check-block.sh
>> index ad320c21ba..8e29c868e5 100755
>> --- a/tests/check-block.sh
>> +++ b/tests/check-block.sh
>> @@ -21,7 +21,17 @@ if grep -q "CONFIG_GPROF=y" config-host.mak 2>/dev/null ; then
>>       exit 0
>>   fi
>>   
>> -if grep -q "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null ; then
>> +# Disable tests with any sanitizer except for SafeStack
>> +CFLAGS=$( grep "CFLAGS.*-fsanitize" config-host.mak 2>/dev/null )
>> +SANITIZE_FLAGS=""
>> +#Remove all occurrencies of -fsanitize=safe-stack
>> +for i in ${CFLAGS}; do
>> +        if [ "${i}" != "-fsanitize=safe-stack" ]; then
>> +                SANITIZE_FLAGS="${SANITIZE_FLAGS} ${i}"
>> +        fi
>> +done
>> +if echo ${SANITIZE_FLAGS} | grep -q "\-fsanitize" 2>/dev/null; then
>> +    # Have a sanitize flag that is not allowed, stop
>>       echo "Sanitizers are enabled ==> Not running the qemu-iotests."
>>       exit 0
>>   fi
> 
> The commit that disabled check-block.sh with sanitizers said:
> 
>    The sanitizers (especially the address sanitizer from Clang) are
>    sometimes printing out warnings or false positives - this spoils
>    the output of the iotests, causing some of the tests to fail.
> 
> It seems fine to allow SafeStack if check-block.sh currently passes with
> it enabled. Does it pass and produce no extra output?
> 
Yes, that was the idea. SafeStack should pass the tests without extra 
output.

It did (pass) on my testing machine. However I don't remember if I did 
the full (slow) check or only the partial one.

Will check again before I submit v2
> Stefan
> 

