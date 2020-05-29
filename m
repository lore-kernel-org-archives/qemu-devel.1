Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F74C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9DF206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9DF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jejSq-00025j-Lq
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 14:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jejSA-0001c5-Mc
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:09:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tobin@linux.vnet.ibm.com>)
 id 1jejS9-0001yn-In
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:09:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04TI3cxL107146
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 14:09:55 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31as1esrt3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 14:09:55 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TI19h3002016
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 18:09:53 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 31b3njk279-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 18:09:53 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04TI9oDJ50921924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 May 2020 18:09:50 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D482B7805E;
 Fri, 29 May 2020 18:09:50 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD28E7805C;
 Fri, 29 May 2020 18:09:50 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 29 May 2020 18:09:50 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 29 May 2020 14:09:50 -0400
From: tobin <tobin@linux.vnet.ibm.com>
To: jejb@linux.ibm.com
Subject: Re: [PATCH 1/2] sev: add sev-inject-launch-secret
In-Reply-To: <1590699601.3449.48.camel@linux.ibm.com>
References: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
 <20200528205114.42078-2-tobin@linux.vnet.ibm.com>
 <1590699601.3449.48.camel@linux.ibm.com>
Message-ID: <95c8a00846f4a8469e3bced1e80bc48d@linux.vnet.ibm.com>
X-Sender: tobin@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-29_09:2020-05-28,
 2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 cotscore=-2147483648 malwarescore=0 clxscore=1015 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290136
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=tobin@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 14:04:34
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: tobin@ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-05-28 17:00, James Bottomley wrote:
> On Thu, 2020-05-28 at 16:51 -0400, Tobin Feldman-Fitzthum wrote:
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -200,6 +200,26 @@
>>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>>    'if': 'defined(TARGET_I386)' }
>> 
>> +##
>> +# @sev-inject-launch-secret:
>> +#
>> +# This command injects a secret blob into memory of SEV guest.
>> +#
>> +# @packet-header: the launch secret packet header encoded in base64
>> +#
>> +# @secret: the launch secret data to be injected encoded in base64
>> +#
>> +# @gpa: the guest physical address where secret will be injected.
>> +        GPA provided here will be ignored if guest ROM specifies
>> +        the a launch secret GPA.
> 
> Shouldn't we eliminate the gpa argument to this now the gpa is
> extracted from OVMF?  You add it here but don't take it out in the next
> patch.
> 
I think having GPA as an optional argument might make the most sense.
Users may or may not know how to use the argument, but it is probably
a good idea to give another option besides sticking the GPA into the 
ROM.

>> +# Since: 5.0.0
>> +#
>> +##
>> +{ 'command': 'sev-inject-launch-secret',
>> +  'data': { 'packet_hdr': 'str', 'secret': 'str', 'gpa': 'uint64' },
> 
> Java (i.e. Json) people hate underscores and abbreviations.  I bet
> they'll want this to be 'packet-header'
> 
Happy to change this.

>> +  'if': 'defined(TARGET_I386)' }
>> +
>>  ##
>>  # @dump-skeys:
>>  #
>> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
>> index 27ebfa3ad2..5c2b7d2c17 100644
>> --- a/target/i386/monitor.c
>> +++ b/target/i386/monitor.c
>> @@ -736,3 +736,11 @@ SevCapability *qmp_query_sev_capabilities(Error
>> **errp)
>> 
>>      return data;
>>  }
>> +
>> +void qmp_sev_inject_launch_secret(const char *packet_hdr,
>> +                                  const char *secret, uint64_t gpa,
>> +                                  Error **errp)
>> +{
>> +    if (sev_inject_launch_secret(packet_hdr,secret,gpa) != 0)
>> +      error_setg(errp, "SEV inject secret failed");
>> +}
>> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
>> index e5ee13309c..2b8c5f1f53 100644
>> --- a/target/i386/sev-stub.c
>> +++ b/target/i386/sev-stub.c
>> @@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
>>  {
>>      return NULL;
>>  }
>> +int sev_inject_launch_secret(const char *hdr, const char *secret,
>> +		                             uint64_t gpa)
>> +{
>> +	    return 1;
>> +}
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index 846018a12d..774e47d9d1 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -28,6 +28,7 @@
>>  #include "sysemu/runstate.h"
>>  #include "trace.h"
>>  #include "migration/blocker.h"
>> +#include "exec/address-spaces.h"
>> 
>>  #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>>  #define DEFAULT_SEV_DEVICE      "/dev/sev"
>> @@ -743,6 +744,88 @@ sev_encrypt_data(void *handle, uint8_t *ptr,
>> uint64_t len)
>>      return 0;
>>  }
>> 
>> +
>> +static void *
>> +gpa2hva(hwaddr addr, uint64_t size)
>> +{
>> +    MemoryRegionSection mrs =
>> memory_region_find(get_system_memory(),
>> +                                                 addr, size);
>> +
>> +    if (!mrs.mr) {
>> +        error_report("No memory is mapped at address 0x%"
>> HWADDR_PRIx, addr);
>> +        return NULL;
>> +    }
>> +
>> +    if (!memory_region_is_ram(mrs.mr) &&
>> !memory_region_is_romd(mrs.mr)) {
>> +        error_report("Memory at address 0x%" HWADDR_PRIx "is not
>> RAM", addr);
>> +        memory_region_unref(mrs.mr);
>> +        return NULL;
>> +    }
> 
> We can still check this, but it should be like an assertion failure.
> Since the GPA is selected by the OVMF build there should be no way it
> can't be mapped into the host.
> 
> [...]
>> --- a/tests/qtest/qmp-cmd-test.c
>> +++ b/tests/qtest/qmp-cmd-test.c
>> @@ -93,10 +93,10 @@ static bool query_is_blacklisted(const char *cmd)
>>          /* Success depends on target-specific build configuration:
>> */
>>          "query-pci",              /* CONFIG_PCI */
>>          /* Success depends on launching SEV guest */
>> -        "query-sev-launch-measure",
>> +        // "query-sev-launch-measure",
>>          /* Success depends on Host or Hypervisor SEV support */
>> -        "query-sev",
>> -        "query-sev-capabilities",
>> +        // "query-sev",
>> +        // "query-sev-capabilities",
> 
> We're eliminating existing tests ... is that just a stray hunk that you
> forgot to remove?
> 
Yes.
> James

