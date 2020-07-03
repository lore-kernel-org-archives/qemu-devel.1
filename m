Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880D1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41105206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vqp0AVGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41105206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLvi-00038J-Ff
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brijesh.singh@amd.com>)
 id 1jrLv0-0002Q4-02
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:39:54 -0400
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com
 ([40.107.244.70]:38702 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brijesh.singh@amd.com>)
 id 1jrLux-0004tP-6U
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:39:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZT9mZBIVT8EG7dx3+HCRaRXGMzJCy8axXad0dmwMcaysT8ZNboShZTnr8spUrdLYUth8JlDjUgpKkCgqtNZVm4yHej14lnrPrfowmpXd2VrK4vC1OGXHs+AVXRIefvSOR5Jn2SEPZMZWiHA6s2+L6DnD0lUDJ4piHC1yRjjL+6FiDKbElqO9k57W5wFpiE0Ifxxc0WwntxSw4Z5NPVRkjjATkd4IzOjB6GvxyWYLaIHLBjfmQsuITRwirM8Nc1kwlkeGrNIUJbEeazbZ/3yeu9cAyPtAYB+ve0j2OUfGJTu04ypCrzhcuKnC0zg4WiYXJmQC6h0zl5S31MfRCiInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgcAoQd4uontqyYLXLMJHDSzF0QH75xtLTfUgZzBvlU=;
 b=gV9EJiutNPfNK8pekjnrHj1hFDkT5K0ZdZXmBPhtoxK7fnRoEPdBbJXa31DIHvFrV7DTr6mcsnI9Xv5WKF0lKEQFpxWjbRonDn61Dm1gxeIh4vqaNku8y0pc5gcylR3cJLSFUwPU9QnsOBH8aZLo4L6CWSuoNSFbIZt3vEjl60QPwyy27DRviiVFRCgNdW9f6pds6EwpCWOIdzVPv26k4Gq1wa1t+zH2Ksx2LrHpy9csT5IT87AgWbqArHVoY0CrL4gXyGdan465+2MiJsnEmBP3rTRHalqLAtMNFbEsd0twGXHW/qOAPuq9FHPux7bR73igW5w2btUIORojXZ4fAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgcAoQd4uontqyYLXLMJHDSzF0QH75xtLTfUgZzBvlU=;
 b=Vqp0AVGeJXW8Kv3aRDebptNcMpTwtoc94z/zatTa/8NVJUbYbgkuHTdeueljVQv/y2c2o+U5IbJB6Ql432h0pFFyq1Ip7fK+8HO5ksLOcSO1jXAM9ECZHl7zf53uxbehINBViktODZBDOP9iHwpeIOt75OxttqnMDEz+OnQso7I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Fri, 3 Jul
 2020 13:24:44 +0000
Received: from SA0PR12MB4400.namprd12.prod.outlook.com
 ([fe80::698e:73e7:484d:e3c9]) by SA0PR12MB4400.namprd12.prod.outlook.com
 ([fe80::698e:73e7:484d:e3c9%3]) with mapi id 15.20.3153.027; Fri, 3 Jul 2020
 13:24:44 +0000
Subject: Re: [PATCH v2] SEV: QMP support for Inject-Launch-Secret
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
References: <20200702194213.23272-1-tobin@linux.vnet.ibm.com>
 <20200703110929.GB6641@work-vm>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <a8ac2438-3f99-ed3b-98c1-3095f27e060a@amd.com>
Date: Fri, 3 Jul 2020 08:25:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200703110929.GB6641@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) To SA0PR12MB4400.namprd12.prod.outlook.com
 (2603:10b6:806:95::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 SN4PR0501CA0037.namprd05.prod.outlook.com (2603:10b6:803:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend
 Transport; Fri, 3 Jul 2020 13:24:43 +0000
X-Originating-IP: [70.112.153.56]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66235f5f-d229-4de7-1a77-08d81f547346
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB235074CAD806D76BE1F9145CE56A0@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Io9wSva9O0rKFkjLBtStpI+WqU1VF2MNi52rqZ2ocks77lDEcZeW9PEPlsO7JMkOjYMD2otCsheCaZRi3e+xozVuhTtdAWl0CqEBugUXzQ+hwLs25fob9Sr7sFA+kqV4hnnwDQe/mNbCHHYeaZOy8loRVVK9NkO+moEwyutlYHA1spHDgsjegBNrkKidNWBo2ClSsCkNW5Mwqv6k1NIEW93KjfG+0UVzmRQPf8mM9JdCjQuJRYmCv7bhDybzIBOzHr2jC8KGW4kpN+kgFWFGT7MSwMaBxqcjQkqnv5F4swPYC3pDFhHONb7PLJmn8VtoFTQyG9ALDfZsr0UKGR2vGJ/OJ2+ONcVMiIWRVdWuOGEbus1Gy+E3gou6t8luFR29KhsQyji76dBI1jZl6uvhOg/u/pDmmMu5yyuSPf0YLs91SJQAX5vgGh5Sisl/GNK9u8B+x/qqEf0+QFdqBnTyILJKXixbi4xExJkdKalUl9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4400.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(86362001)(83380400001)(316002)(5660300002)(66556008)(6486002)(110136005)(6666004)(186003)(16526019)(26005)(66476007)(31686004)(31696002)(6506007)(53546011)(66946007)(4326008)(52116002)(6512007)(478600001)(36756003)(966005)(8936002)(8676002)(2906002)(44832011)(2616005)(956004)(219293001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LVMFr839N3XVYmDcnOh2sVorFeSTBz8pW928LLRkurHUdyX6TF2YYqkXiFrWsjVVqrqDRCn1kFGeDkcw89WK7IEin/jgJb2wF/l8a2kuaqlWAHpsE0PL+HliUvLbdewXYi68mZdosJXQvqfbJvUyC5S7JF4JF9WbYkTwrkgpYfts9e/IGATN5AIT7ym7XFnFQkv123XS9VbkHVXl1xZSW0mPK7kUAemyjY3KKqIoYd/9dSQcQWhc86TzjyN3+gZJUm3cNWhTpaNjegM3QryuduP9iB9/zROnNd4SGDacSRb7s16Zo3aG59s9pcnGrl2Q5zArSa8r0XY/1th95flXCojA8RhFDzRVitRopsgjSGBy/nC6a3xkz4VGzTf31hTCj5aTzTHit12TrCt+6n05IP2V6h/2F2KrybJSQzWYdLVp5s9DM8L+cWUGt4k2DxBfNkAlrKkIblPRWg5hnQV02yluG7wHHp3c3CZ+kyGLV+A=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66235f5f-d229-4de7-1a77-08d81f547346
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 13:24:44.6206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIekmSZID4Sj/ynWODxJC3HhQ9c737LUXfiapCa0ltTmUTHCouOZGkZYyQpRpHiKHQ+dPNzYMVgOdhWaDrX7Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
Received-SPF: none client-ip=40.107.244.70; envelope-from=brijesh.singh@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 09:39:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 7/3/20 6:11 AM, Dr. David Alan Gilbert wrote:
> * Tobin Feldman-Fitzthum (tobin@linux.vnet.ibm.com) wrote:
>> From: Tobin Feldman-Fitzthum <tobin@ibm.com>
>>
>> AMD SEV allows a guest owner to inject a secret blob
>> into the memory of a virtual machine. The secret is
>> encrypted with the SEV Transport Encryption Key and
>> integrity is guaranteed with the Transport Integrity
>> Key. Although QEMU faciliates the injection of the
>> launch secret, it cannot access the secret.
>>
>> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>
>> ---
>>  include/monitor/monitor.h |  3 ++
>>  include/sysemu/sev.h      |  2 ++
>>  monitor/misc.c            |  8 ++---
>>  qapi/misc-target.json     | 18 +++++++++++
>>  target/i386/monitor.c     |  9 ++++++
>>  target/i386/sev-stub.c    |  5 +++
>>  target/i386/sev.c         | 66 +++++++++++++++++++++++++++++++++++++++
>>  target/i386/sev_i386.h    |  3 ++
>>  target/i386/trace-events  |  1 +
>>  9 files changed, 111 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
>> index 1018d754a6..bf049c5b00 100644
>> --- a/include/monitor/monitor.h
>> +++ b/include/monitor/monitor.h
>> @@ -4,6 +4,7 @@
>>  #include "block/block.h"
>>  #include "qapi/qapi-types-misc.h"
>>  #include "qemu/readline.h"
>> +#include "include/exec/hwaddr.h"
>>  
>>  extern __thread Monitor *cur_mon;
>>  typedef struct MonitorHMP MonitorHMP;
>> @@ -36,6 +37,8 @@ void monitor_flush(Monitor *mon);
>>  int monitor_set_cpu(int cpu_index);
>>  int monitor_get_cpu_index(void);
>>  
>> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
>> +
>>  void monitor_read_command(MonitorHMP *mon, int show_prompt);
>>  int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>>                            void *opaque);
>> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
>> index 98c1ec8d38..b279b293e8 100644
>> --- a/include/sysemu/sev.h
>> +++ b/include/sysemu/sev.h
>> @@ -18,4 +18,6 @@
>>  
>>  void *sev_guest_init(const char *id);
>>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
>> +int sev_inject_launch_secret(const char *hdr, const char *secret,
>> +                             uint64_t gpa);
>>  #endif
>> diff --git a/monitor/misc.c b/monitor/misc.c
>> index 89bb970b00..b9ec8ba410 100644
>> --- a/monitor/misc.c
>> +++ b/monitor/misc.c
>> @@ -674,10 +674,10 @@ static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
>>      memory_dump(mon, count, format, size, addr, 1);
>>  }
>>  
>> -static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
>> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
>>  {
>>      MemoryRegionSection mrs = memory_region_find(get_system_memory(),
>> -                                                 addr, 1);
>> +                                                 addr, size);
>>  
>>      if (!mrs.mr) {
>>          error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
>> @@ -701,7 +701,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>>      MemoryRegion *mr = NULL;
>>      void *ptr;
>>  
>> -    ptr = gpa2hva(&mr, addr, &local_err);
>> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>>      if (local_err) {
>>          error_report_err(local_err);
>>          return;
>> @@ -777,7 +777,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
>>      void *ptr;
>>      uint64_t physaddr;
>>  
>> -    ptr = gpa2hva(&mr, addr, &local_err);
>> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>>      if (local_err) {
>>          error_report_err(local_err);
>>          return;
>> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
>> index dee3b45930..d145f916b3 100644
>> --- a/qapi/misc-target.json
>> +++ b/qapi/misc-target.json
>> @@ -200,6 +200,24 @@
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
>> +#
>> +# Since: 5.1
>> +#
>> +##
>> +{ 'command': 'sev-inject-launch-secret',
>> +  'data': { 'packet-header': 'str', 'secret': 'str', 'gpa': 'uint64' },
>> +  'if': 'defined(TARGET_I386)' }
>> +
>>  ##
>>  # @dump-skeys:
>>  #
>> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
>> index 27ebfa3ad2..42bcfe6dc0 100644
>> --- a/target/i386/monitor.c
>> +++ b/target/i386/monitor.c
>> @@ -736,3 +736,12 @@ SevCapability *qmp_query_sev_capabilities(Error **errp)
>>  
>>      return data;
>>  }
>> +
>> +void qmp_sev_inject_launch_secret(const char *packet_hdr,
>> +                                  const char *secret, uint64_t gpa,
>> +                                  Error **errp)
>> +{
>> +    if (sev_inject_launch_secret(packet_hdr, secret, gpa) != 0) {
>> +        error_setg(errp, "SEV inject secret failed");
>> +    }
>> +}
>> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
>> index e5ee13309c..fed4588185 100644
>> --- a/target/i386/sev-stub.c
>> +++ b/target/i386/sev-stub.c
>> @@ -48,3 +48,8 @@ SevCapability *sev_get_capabilities(void)
>>  {
>>      return NULL;
>>  }
>> +int sev_inject_launch_secret(const char *hdr, const char *secret,
>> +                             uint64_t gpa)
>> +{
>> +    return 1;
>> +}
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index d273174ad3..3b2b3c8d8b 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -28,6 +28,8 @@
>>  #include "sysemu/runstate.h"
>>  #include "trace.h"
>>  #include "migration/blocker.h"
>> +#include "exec/address-spaces.h"
>> +#include "monitor/monitor.h"
>>  
>>  #define TYPE_SEV_GUEST "sev-guest"
>>  #define SEV_GUEST(obj)                                          \
>> @@ -769,6 +771,70 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>>      return 0;
>>  }
>>  
>> +int sev_inject_launch_secret(const char *packet_hdr,
>> +                             const char *secret, uint64_t gpa)
>> +{
>> +    struct kvm_sev_launch_secret input;
>> +    guchar *data = NULL, *hdr = NULL;
>> +    int error, ret = 1;
>> +    void *hva;
>> +    gsize hdr_sz = 0, data_sz = 0;
>> +    Error *local_err = NULL;
>> +    MemoryRegion *mr = NULL;
>> +
>> +    /* secret can be inject only in this state */
>> +    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
>> +        error_report("SEV: Not in correct state. (LSECRET) %x",
>> +                     sev_guest->state);
>> +        return 1;
>> +    }
>> +
>> +    hdr = g_base64_decode(packet_hdr, &hdr_sz);
>> +    if (!hdr || hdr_sz != SEV_SECRET_HEADER_LEN) {
>> +        error_report("SEV: Failed to decode sequence header");
>> +        return 1;
>> +    }
>> +
>> +    data = g_base64_decode(secret, &data_sz);
>> +    if (!data || data_sz <= 0 || data_sz > SEV_SECRET_MAX_LEN) {
>> +        error_report("SEV: Failed to decode data");
>> +        goto err;
>> +    }
>> +
>> +    hva = gpa2hva(&mr, gpa, data_sz, &local_err);
>> +    if (!hva) {
>> +        error_report("SEV: Failed to calculate guest address.");
>> +        goto err;
>> +    }
>> +
>> +    input.hdr_uaddr = (uint64_t)hdr;
>> +    input.hdr_len = hdr_sz;
>> +
>> +    input.trans_uaddr = (uint64_t)data;
>> +    input.trans_len = data_sz;
>> +
>> +    input.guest_uaddr = (uint64_t)hva;
> Thanks for changing these; although it fails a 32bit build (which is
> probably mostly pointless for SEV, but it fails the build rather than
> building it out). The easy fix here seems to be:
>    (uint64_t)(uintptr_t)
>
>> +    input.guest_len = data_sz;
>> +
>> +    trace_kvm_sev_launch_secret(gpa, input.guest_uaddr,
>> +                                input.trans_uaddr, input.trans_len);
>> +
>> +    ret = sev_ioctl(sev_guest->sev_fd, KVM_SEV_LAUNCH_SECRET,
>> +                    &input, &error);
>> +    if (ret) {
>> +        error_report("SEV: failed to inject secret ret=%d fw_error=%d '%s'",
>> +                     ret, error, fw_error_to_str(error));
>> +        goto err;
>> +    }
>> +
>> +    ret = 0;
>> +
>> +err:
>> +    g_free(data);
>> +    g_free(hdr);
>> +    return ret;
>> +}
>> +
>>  static void
>>  sev_register_types(void)
>>  {
>> diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
>> index 8eb7de1bef..b9ed89d48c 100644
>> --- a/target/i386/sev_i386.h
>> +++ b/target/i386/sev_i386.h
>> @@ -28,6 +28,9 @@
>>  #define SEV_POLICY_DOMAIN       0x10
>>  #define SEV_POLICY_SEV          0x20
>>  
>> +#define SEV_SECRET_HEADER_LEN   0x34
>> +#define SEV_SECRET_MAX_LEN      0x3E80
>> +
> Where does that maximum come from - I didn't find it in the spec.


The size of packet header is documented in Table 55 [1]. But, I am not
sure how Tobin calculated the size of the secret max length. FW spec
says that if it does not support the passed secret length then it will
error out with INVALID_LENGTH.

I would  avoid doing the header and secret length check in the Qemu.
From HV point of view we consider them as a opaque blob and pass them
as-is to the FW. We have seen that the size of the blob changed from one
version to another.

[1]
https://www.amd.com/system/files/TechDocs/55766_SEV-KM_API_Specification.pdf


-Brijesh

> Other than the 32bit ism above, and that minor question; I think this is
> fine.
>
> Dave
>
>>  extern bool sev_enabled(void);
>>  extern uint64_t sev_get_me_mask(void);
>>  extern SevInfo *sev_get_info(void);
>> diff --git a/target/i386/trace-events b/target/i386/trace-events
>> index 789c700d4a..9f299e94a2 100644
>> --- a/target/i386/trace-events
>> +++ b/target/i386/trace-events
>> @@ -15,3 +15,4 @@ kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session
>>  kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
>>  kvm_sev_launch_measurement(const char *value) "data %s"
>>  kvm_sev_launch_finish(void) ""
>> +kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
>> -- 
>> 2.20.1 (Apple Git-117)
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>

