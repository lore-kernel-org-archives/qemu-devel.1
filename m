Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580BFC4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:25:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BEA23A62
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0qo27rB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BEA23A62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKUFK-00019D-Kr
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kKU5I-0004YY-4C
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:14:57 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com
 ([40.107.93.87]:11712 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kKU5F-0001sH-83
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:14:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K41jTDIoGpWqzLSivih93lGWTauXurWy1YcqbJXZk+7JHy/DMFGAPGTRNKumvSO9ro1OmLLWKaWq6lZa8hkWsYxCbYjn7RiM3PJU1qMejKh3Skv2j8pxGvFrKAJcF2ZrtEoPVV65ky4zHgf3XvuRkZQm4fVGQ4UT80hsEIfATYio4sqtpwPurM9UiQjrwux2rJw4SWVU01JICmD/Mo76UaDRoNFQuRPHoLMMU3WvDpThIds49PIrY3xKQ527QFR7HTjvxIUKjinrLUXddLWqq5WsPC39DDZG4cqfMC5zCeS5NnItR7AGgw7w8b5tByISi95zSq8sED917YWKU+nyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+aCiMhNep/lcoVO9RQSivcFxmWShufeBeS+VQWX3/U=;
 b=hBOFWXBcT25cjfCHR6KpeUX/K9KQfNdYtI0Dyy00WRxFlwrKr9Z67LXIlLunyq5I6cFEQbWdCWHw4VEPIzy9Va7Vq7353XYmDWImuV9Wo6TSC+9H7cyN1yWbqQhOsUrl50k7nvcjhmgcB9In/BAQibfmmd0B2rIrfvXi8Aw0zTARf92JA2QQ6fpxtBXusDRwSIAWOdM5kQfAzpque/gNS+pSwrlH8CmpnUvZu/4EE9zizun4Ps8e98FCl98cU/jApxTMicOqqT6/JKZThc2di/UZxyCS7ifkOGZ/IQY4APeiC9pnhlbRGTd2npTuWUWBSplC/BeOUXlFpcB8d+h7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+aCiMhNep/lcoVO9RQSivcFxmWShufeBeS+VQWX3/U=;
 b=0qo27rB2Tpte27tgbM4dtFeDWLYeXBAEQFUWeNnOaICsLaXrx5JGJUjcyIudfIffiL05VGvUKMhY54byk/dkPlvANcd3GZ1oIK7rjPcauO3VX7fzrHLTli2A1xig8nNeZI7HCI5tMjPZGlmiBQb1Nq6KH6tMLCWJjAXXBT1ByX4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3467.namprd12.prod.outlook.com (2603:10b6:5:3c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Mon, 21 Sep 2020 22:14:49 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 22:14:49 +0000
Subject: Re: [PATCH v3] SEV: QMP support for Inject-Launch-Secret
To: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200706215451.59179-1-tobin@linux.vnet.ibm.com>
 <20200921190800.GA32491@work-vm>
 <b7faab72e909b709797e6098ec894c72@linux.vnet.ibm.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <d70d7e31-9ce2-00c0-ff6f-27b0a69b9d26@amd.com>
Date: Mon, 21 Sep 2020 17:14:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <b7faab72e909b709797e6098ec894c72@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0034.namprd05.prod.outlook.com
 (2603:10b6:803:40::47) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by
 SN4PR0501CA0034.namprd05.prod.outlook.com (2603:10b6:803:40::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.17 via Frontend
 Transport; Mon, 21 Sep 2020 22:14:48 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7521b1a-7546-4226-19cf-08d85e7bc189
X-MS-TrafficTypeDiagnostic: DM6PR12MB3467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB346742E6D5A48BFE731E96EFEC3A0@DM6PR12MB3467.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2glIfsdEkq33KwPR4Bkg89WYAZww6o+7/NEtPROwotSTClAp2FPzjal+4rWJ1fmfGAAnNrDaz/PDZdwDSwfPRBjuCliViRbAi5baSkqeA5U2A7yNXF3HouKHYM+0ERJqH8c/5y1ICj/Ehofx8jWNQOtm1ICWVKJWov/eXe+i7ejeta2PjuqFKiJkH/ju1Gg1/x9fHg2xJz6ElXF/QOVUZZIo+EvDGnAutYdznSi4F9Sgebt4tINkwG3qMIPzKip+sGMltohBQu3OcJpjda++th51GVMghmnW+vve2f2YOakIMjbhjFAoxLQ3fX+aumVdGS8TNutK0i537qcrWI3yjQ2fzmzkMb32IniNzgrgMSAxYPz4HxntNZV2GLPFTqxVQ6ctLduG9RLfw0+6N7mKHPujJaczwpSRc39iNsH8UBZKr/rNNNHm7UwivuWAMjre/3Z35YnhSfQQnNVnn7NBnsygCvwxZP6Fsm0ZPm7ZNBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(2616005)(36756003)(66946007)(110136005)(2906002)(52116002)(66556008)(83380400001)(66476007)(8676002)(53546011)(5660300002)(966005)(16576012)(478600001)(4326008)(86362001)(26005)(6486002)(16526019)(31696002)(31686004)(8936002)(956004)(316002)(186003)(219293001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kk29AljpeEeEJyA3ZChwFV9222uDE8zYPVgrCO89q67i2wjc0Wz1PBBkRrulxrGUU4v4sZO/0HMGNB11zSwkzank5qrMbf4WhgD0pA/JI+zX7mDeZf+oIDQR+r/DZ39JOIB7ZVJkzwJBNMSLhlrXo88SlK1e2Ap7+jXZwMbwqAtIRS9N7HIiumnJdjBwsPGCLkmutICV1ov64i1OmgUe7M35ZqWaUI429GQFnALTdonwMDzuYCJ0uZJlr2INWjgJotXrB0GWwj1xyTil3MlMg/pF70wpLHyCAV04o2faZO7b0hHPKODs4oCjJchhBwQ0tuImNjqmJXWgHL4GYfH23JUlVThu4FtPfhu4pVng4VBXfifoQqWoe9tf2qrBOI7k19jh/hyenPWm6FPLamiPvwaMlWRqqWjg5NcZlmLpUHX2yRAR0KJeDFe9Bw67kJ7trO31/4jOtSYj2CgtaxklCBOiCvJSjx+AXm2olD+YFl/GeOZkF7HrkFGkZ2UNvD1I4yMw3t1ZkOziUWCZPhtle73+uJuFfkv9x4ty+EUrbClTrbJf2/6u9vtUxu/PmtPYOA4bQvvPZAlDr0r5P0hZLuNLaGjyrV9FDPKoLtyYDFVYPBvvlGhu4ukavQtCb14xlEdfBi1E8IISbzYawP0k0Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7521b1a-7546-4226-19cf-08d85e7bc189
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 22:14:49.6310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0a/yeUGG0L0NNru6QTymMp6dIBGIUimXEGTRQIw1OlqusxJfDDMFRFdciStzexS/qkFdKpdCUiODp+x/x40Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3467
Received-SPF: none client-ip=40.107.93.87;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 18:14:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: brijesh.singh@amd.com, jejb@linux.ibm.com, tobin@ibm.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 3:33 PM, Tobin Feldman-Fitzthum wrote:
> On 2020-09-21 15:16, Dr. David Alan Gilbert wrote:
>> * Tobin Feldman-Fitzthum (tobin@linux.vnet.ibm.com) wrote:
>>> AMD SEV allows a guest owner to inject a secret blob
>>> into the memory of a virtual machine. The secret is
>>> encrypted with the SEV Transport Encryption Key and
>>> integrity is guaranteed with the Transport Integrity
>>> Key. Although QEMU faciliates the injection of the
>>> launch secret, it cannot access the secret.
>>>
>>> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
>>
>> Hi Tobin,
>>   Did the ovmf stuff for agreeing the GUID for automating this ever
>> happen?
>>
> OVMF patches have not been upstreamed yet. I think we are planning
> to do that relatively soon.

The SEV-ES code was recently accepted and uses a GUID for locating SEV
related information. You can probably build upon that GUID or stack
another GUID above that. The GUID block has a size indicator that can help
determine what information is available or for tracking stacked GUIDs.

https://github.com/tianocore/edk2/commit/30937f2f98c42496f2f143fe8374ae7f7e684847

Thanks,
Tom

> 
> -Tobin
>> Dave
>>
>>> ---
>>>  include/monitor/monitor.h |  3 ++
>>>  include/sysemu/sev.h      |  2 ++
>>>  monitor/misc.c            |  8 ++---
>>>  qapi/misc-target.json     | 18 +++++++++++
>>>  target/i386/monitor.c     |  9 ++++++
>>>  target/i386/sev-stub.c    |  5 +++
>>>  target/i386/sev.c         | 66 +++++++++++++++++++++++++++++++++++++++
>>>  target/i386/trace-events  |  1 +
>>>  8 files changed, 108 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
>>> index 1018d754a6..bf049c5b00 100644
>>> --- a/include/monitor/monitor.h
>>> +++ b/include/monitor/monitor.h
>>> @@ -4,6 +4,7 @@
>>>  #include "block/block.h"
>>>  #include "qapi/qapi-types-misc.h"
>>>  #include "qemu/readline.h"
>>> +#include "include/exec/hwaddr.h"
>>>
>>>  extern __thread Monitor *cur_mon;
>>>  typedef struct MonitorHMP MonitorHMP;
>>> @@ -36,6 +37,8 @@ void monitor_flush(Monitor *mon);
>>>  int monitor_set_cpu(int cpu_index);
>>>  int monitor_get_cpu_index(void);
>>>
>>> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error
>>> **errp);
>>> +
>>>  void monitor_read_command(MonitorHMP *mon, int show_prompt);
>>>  int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>>>                            void *opaque);
>>> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
>>> index 98c1ec8d38..b279b293e8 100644
>>> --- a/include/sysemu/sev.h
>>> +++ b/include/sysemu/sev.h
>>> @@ -18,4 +18,6 @@
>>>
>>>  void *sev_guest_init(const char *id);
>>>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
>>> +int sev_inject_launch_secret(const char *hdr, const char *secret,
>>> +                             uint64_t gpa);
>>>  #endif
>>> diff --git a/monitor/misc.c b/monitor/misc.c
>>> index 89bb970b00..b9ec8ba410 100644
>>> --- a/monitor/misc.c
>>> +++ b/monitor/misc.c
>>> @@ -674,10 +674,10 @@ static void hmp_physical_memory_dump(Monitor
>>> *mon, const QDict *qdict)
>>>      memory_dump(mon, count, format, size, addr, 1);
>>>  }
>>>
>>> -static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
>>> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error
>>> **errp)
>>>  {
>>>      MemoryRegionSection mrs = memory_region_find(get_system_memory(),
>>> -                                                 addr, 1);
>>> +                                                 addr, size);
>>>
>>>      if (!mrs.mr) {
>>>          error_setg(errp, "No memory is mapped at address 0x%"
>>> HWADDR_PRIx, addr);
>>> @@ -701,7 +701,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict
>>> *qdict)
>>>      MemoryRegion *mr = NULL;
>>>      void *ptr;
>>>
>>> -    ptr = gpa2hva(&mr, addr, &local_err);
>>> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>>>      if (local_err) {
>>>          error_report_err(local_err);
>>>          return;
>>> @@ -777,7 +777,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict
>>> *qdict)
>>>      void *ptr;
>>>      uint64_t physaddr;
>>>
>>> -    ptr = gpa2hva(&mr, addr, &local_err);
>>> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>>>      if (local_err) {
>>>          error_report_err(local_err);
>>>          return;
>>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>>> index dee3b45930..d145f916b3 100644
>>> --- a/qapi/misc-target.json
>>> +++ b/qapi/misc-target.json
>>> @@ -200,6 +200,24 @@
>>>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>>>    'if': 'defined(TARGET_I386)' }
>>>
>>> +##
>>> +# @sev-inject-launch-secret:
>>> +#
>>> +# This command injects a secret blob into memory of SEV guest.
>>> +#
>>> +# @packet-header: the launch secret packet header encoded in base64
>>> +#
>>> +# @secret: the launch secret data to be injected encoded in base64
>>> +#
>>> +# @gpa: the guest physical address where secret will be injected.
>>> +#
>>> +# Since: 5.1
>>> +#
>>> +##
>>> +{ 'command': 'sev-inject-launch-secret',
>>> +  'data': { 'packet-header': 'str', 'secret': 'str', 'gpa': 'uint64' },
>>> +  'if': 'defined(TARGET_I386)' }
>>> +
>>>  ##
>>>  # @dump-skeys:
>>>  #
>>> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
>>> index 27ebfa3ad2..42bcfe6dc0 100644
>>> --- a/target/i386/monitor.c
>>> +++ b/target/i386/monitor.c
>>> @@ -736,3 +736,12 @@ SevCapability *qmp_query_sev_capabilities(Error
>>> **errp)
>>>
>>>      return data;
>>>  }
>>> +
>>> +void qmp_sev_inject_launch_secret(const char *packet_hdr,
>>> +                                  const char *secret, uint64_t gpa,
>>> +                                  Error **errp)
>>> +{
>>> +    if (sev_inject_launch_secret(packet_hdr, secret, gpa) != 0) {
>>> +        error_setg(errp, "SEV inject secret failed");
>>> +    }
>>> +}
>>> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
>>> index e5ee13309c..fed4588185 100644
>>> --- a/target/i386/sev-stub.c
>>> +++ b/target/i386/sev-stub.c
>>> @@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
>>>  {
>>>      return NULL;
>>>  }
>>> +int sev_inject_launch_secret(const char *hdr, const char *secret,
>>> +                             uint64_t gpa)
>>> +{
>>> +    return 1;
>>> +}
>>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>>> index d273174ad3..cbeb8f2e02 100644
>>> --- a/target/i386/sev.c
>>> +++ b/target/i386/sev.c
>>> @@ -28,6 +28,8 @@
>>>  #include "sysemu/runstate.h"
>>>  #include "trace.h"
>>>  #include "migration/blocker.h"
>>> +#include "exec/address-spaces.h"
>>> +#include "monitor/monitor.h"
>>>
>>>  #define TYPE_SEV_GUEST "sev-guest"
>>>  #define SEV_GUEST(obj)                                          \
>>> @@ -769,6 +771,70 @@ sev_encrypt_data(void *handle, uint8_t *ptr,
>>> uint64_t len)
>>>      return 0;
>>>  }
>>>
>>> +int sev_inject_launch_secret(const char *packet_hdr,
>>> +                             const char *secret, uint64_t gpa)
>>> +{
>>> +    struct kvm_sev_launch_secret input;
>>> +    guchar *data = NULL, *hdr = NULL;
>>> +    int error, ret = 1;
>>> +    void *hva;
>>> +    gsize hdr_sz = 0, data_sz = 0;
>>> +    Error *local_err = NULL;
>>> +    MemoryRegion *mr = NULL;
>>> +
>>> +    /* secret can be inject only in this state */
>>> +    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
>>> +        error_report("SEV: Not in correct state. (LSECRET) %x",
>>> +                     sev_guest->state);
>>> +        return 1;
>>> +    }
>>> +
>>> +    hdr = g_base64_decode(packet_hdr, &hdr_sz);
>>> +    if (!hdr || !hdr_sz) {
>>> +        error_report("SEV: Failed to decode sequence header");
>>> +        return 1;
>>> +    }
>>> +
>>> +    data = g_base64_decode(secret, &data_sz);
>>> +    if (!data || !data_sz) {
>>> +        error_report("SEV: Failed to decode data");
>>> +        goto err;
>>> +    }
>>> +
>>> +    hva = gpa2hva(&mr, gpa, data_sz, &local_err);
>>> +    if (!hva) {
>>> +        error_report("SEV: Failed to calculate guest address.");
>>> +        goto err;
>>> +    }
>>> +
>>> +    input.hdr_uaddr = (uint64_t)(unsigned long)hdr;
>>> +    input.hdr_len = hdr_sz;
>>> +
>>> +    input.trans_uaddr = (uint64_t)(unsigned long)data;
>>> +    input.trans_len = data_sz;
>>> +
>>> +    input.guest_uaddr = (uint64_t)(unsigned long)hva;
>>> +    input.guest_len = data_sz;
>>> +
>>> +    trace_kvm_sev_launch_secret(gpa, input.guest_uaddr,
>>> +                                input.trans_uaddr, input.trans_len);
>>> +
>>> +    ret = sev_ioctl(sev_guest->sev_fd, KVM_SEV_LAUNCH_SECRET,
>>> +                    &input, &error);
>>> +    if (ret) {
>>> +        error_report("SEV: failed to inject secret ret=%d fw_error=%d
>>> '%s'",
>>> +                     ret, error, fw_error_to_str(error));
>>> +        goto err;
>>> +    }
>>> +
>>> +    ret = 0;
>>> +
>>> +err:
>>> +    g_free(data);
>>> +    g_free(hdr);
>>> +    return ret;
>>> +}
>>> +
>>>  static void
>>>  sev_register_types(void)
>>>  {
>>> diff --git a/target/i386/trace-events b/target/i386/trace-events
>>> index 789c700d4a..9f299e94a2 100644
>>> --- a/target/i386/trace-events
>>> +++ b/target/i386/trace-events
>>> @@ -15,3 +15,4 @@ kvm_sev_launch_start(int policy, void *session, void
>>> *pdh) "policy 0x%x session
>>>  kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%"
>>> PRIu64
>>>  kvm_sev_launch_measurement(const char *value) "data %s"
>>>  kvm_sev_launch_finish(void) ""
>>> +kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int
>>> len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
>>> -- 
>>> 2.20.1 (Apple Git-117)
>>>

