Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F59C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EAA2222A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qPOLeycH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EAA2222A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSj6v-0002Ra-Gx
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brijesh.singh@amd.com>)
 id 1kSj5r-0001dU-Cn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:53:36 -0400
Received: from mail-dm6nam12on2049.outbound.protection.outlook.com
 ([40.107.243.49]:50177 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brijesh.singh@amd.com>)
 id 1kSj5n-0000Fc-Ml
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkOg5NxSPWArvlQ0v0UvIzfp9nrUpetpNeXiLpK0U7/Yzh/ti9Ku2faMzq3KmBejU8HJmaUHZaCCGJ5W6DSMvbeJmT9wiHzfr1ilQOeNqmnQUioheOA+jHBMq2mVKX1ySFde/iuSr+vTN4USp9Ea3alZJHEKPVduzf9CbxFMr2j9GP6vXwFphP+T+eWA3xuqKgGBfhIK+ZW+mWzKUWE78hFWR4+CHn+wdvzE6ufo+1YD9o9C0QRyqfwPl/AW2y21Z6mXNxZjQ+jXh48SsrtDAJX39W6XFqfZCle1U/kaemooHWMr+cxWSRpXu23KaGrMUPYQtsMO4PmBoDSlM6pqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTz6PVAYrIceUMXq7qLY+OqLY7dnmnpXis3EhsVpd1I=;
 b=aO9o7zub7PfpUJLq6mn3Iy/u4Xc2WZA/dD5P3Vhf/ub2HAvvIq9xA8/3dFaPr5sP8q1Pe7wHL9Eg75pqHyrO1Pu7O1I58ylbVXaxGfr6+jyC1YPe9i7PWxYQvtGH+TdJcEradxmp5CM37khDjcRUidArbEk7359kw1yCHc3UlTSlUa/Kr5ukcu2NRDitAWCeR9ebDdtkGH+HGAl1LVL8fed42nz4fbx5F3QNGXpCk5dIBmiK2UFEDdEdAkga0Y7hnsTm3xSDF7PAAwiGiwe81rY6YOjqB85uWFPJcs/OGd+VlPVOmkIummYgsr/cfvLeYugeTuIG2KN3nFjhAIC0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTz6PVAYrIceUMXq7qLY+OqLY7dnmnpXis3EhsVpd1I=;
 b=qPOLeycH7+Ash+08I/vaAj1DwciNMsKEIxMHzjREdnh5SPezTMMk14K99gxGViT9IlA8yfwO5bsvWxi1W8XLQCHNbWrSl6YzUwa9znqQgI7H3Xj3ILP2yPjZd0lUYijvW9zvhyroZG5Y6h8o4e5YEOEml4uZ9J3FmzMHxKLIs0M=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2448.namprd12.prod.outlook.com (2603:10b6:802:28::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 14 Oct
 2020 15:38:27 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::6d9c:78e0:e7cb:558f]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::6d9c:78e0:e7cb:558f%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 15:38:27 +0000
Subject: Re: [PATCH v4] sev: add sev-inject-launch-secret
To: tobin@linux.ibm.com, qemu-devel@nongnu.org
References: <20201014151739.4722-1-tobin@linux.ibm.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <3928c2fe-670a-9686-9778-444bf3191484@amd.com>
Date: Wed, 14 Oct 2020 10:42:14 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <20201014151739.4722-1-tobin@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA9PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:806:a7::20) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 SA9PR10CA0015.namprd10.prod.outlook.com (2603:10b6:806:a7::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Wed, 14 Oct 2020 15:38:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 748a83c2-52f7-4e48-c24e-08d8705731a1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2448B59633F19A730B98868BE5050@SN1PR12MB2448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLS/zE06GBtYD5hJkq/nx2NO4Ksre72PzP7vb08csuYTvUh0xoU7kSyb/FwcjBnHj5bwUXLkCIWnxTcyuOmlQREi9Dq8rmk10rUlJc1S69ka1+/5Mc9TLJZwSavbbdHRXySNsDdg0He0RtaOnrPD4R1WPHZiGOaT/zFuqm5F1ErC3no5vXmoTwfjWjcCp+Mod04OxbooLlkmRybapraxUmtxaUGt4zyW0t9ERdAr7noS3sFTurd7cMz3WGmQCGZD/1RsrsjHzk81TCGVstAFoSAh2/nbM2PCxbw2jZ42us4o/bk1XS2qTdi8N3bNqAr+SkPnJ7YFbuMt4VefxcFPn4CeVVnyBvuq8NR+n5uaKstZ9S41Eoa0DZUq8ZH+tAmTCn5VZ223dN46maN7gIoywA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2718.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(66556008)(44832011)(66476007)(16526019)(66946007)(52116002)(2906002)(316002)(83380400001)(186003)(478600001)(6506007)(26005)(6666004)(36756003)(53546011)(6486002)(8936002)(4326008)(5660300002)(31696002)(86362001)(2616005)(6512007)(31686004)(8676002)(956004)(219293001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PlVygU1ft/MDhG2/682NjLqolzsmtxiZc5Y/VobjoOI0m/iY5wH9icRYvEqPc1iFUjTac5P1XpT04LNW5NGXhdYvWgXraksJ0xEyyJqNu3fI0L2Ct/yQIL6ZEiU4KZYokOo2B1N3kF/hhergQkeLtZEHNfi8MyPgPhAFziC+rwqXFZaVUlgQDLKk6ETXhw8D8mMwcrUpqQTNKfnWOgfOOTrhfB01i8hWyt8NwE0kHziLmeIdaKHhXKGgI/Qt7GIYg+6S1u3b2P0pWqLa3vMQILgYG0au4eKEJGzqC0LH7Jlrjj588/AFWqbro+pu46PQY0HjhViq2hX2+Av4nB6a2n2SlwEBhVnunNbGyxL0l8Obk9d2971uvtysNJHCFvWmvBn7yBKNletFvSqYZukMujIdPM4v/xMzLwIgurCQqcoWzGDGFVIK4n6l0MBRs9aKxjThLe3/p0Lyqw13mQ7JPih2J9K4xpbuxf2oAnxVUIFO+yujKoKbqjnV7yMNwO8T4nAqcyP48pF65hHVoHAtnTdO9SM2ejlH/g/bbSkx70Idq5kKfbpaJxBAQV7nfTsCcBEielZZNAKbP4aOlD5Y6QyUAmHljm+U9upKnU2nkQLbh7AzP84HkFQxqY3ZduWEDYqejNJ9ksTojNppwGXH4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748a83c2-52f7-4e48-c24e-08d8705731a1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 15:38:27.2394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MpuJIHXNXaVExGK6w2k0VKP7g28c+cM4wjz9XllJTzV4pGiCj5WMKg4wdrZ+toJ/e7rM1AJnQ4QcPckKRuVoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2448
Received-SPF: none client-ip=40.107.243.49; envelope-from=brijesh.singh@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 11:53:30
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/14/20 10:17 AM, tobin@linux.ibm.com wrote:
> From: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
>
> AMD SEV allows a guest owner to inject a secret blob
> into the memory of a virtual machine. The secret is
> encrypted with the SEV Transport Encryption Key and
> integrity is guaranteed with the Transport Integrity
> Key. Although QEMU facilitates the injection of the
> launch secret, it cannot access the secret.
>
> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
> ---
>  include/monitor/monitor.h |  3 ++
>  include/sysemu/sev.h      |  2 ++
>  monitor/misc.c            |  8 +++---
>  qapi/misc-target.json     | 18 ++++++++++++
>  target/i386/monitor.c     |  7 +++++
>  target/i386/sev-stub.c    |  5 ++++
>  target/i386/sev.c         | 60 +++++++++++++++++++++++++++++++++++++++
>  target/i386/trace-events  |  1 +
>  8 files changed, 100 insertions(+), 4 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 348bfad3d5..af3887bb71 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -4,6 +4,7 @@
>  #include "block/block.h"
>  #include "qapi/qapi-types-misc.h"
>  #include "qemu/readline.h"
> +#include "include/exec/hwaddr.h"
>  
>  typedef struct MonitorHMP MonitorHMP;
>  typedef struct MonitorOptions MonitorOptions;
> @@ -37,6 +38,8 @@ void monitor_flush(Monitor *mon);
>  int monitor_set_cpu(Monitor *mon, int cpu_index);
>  int monitor_get_cpu_index(Monitor *mon);
>  
> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp);
> +
>  void monitor_read_command(MonitorHMP *mon, int show_prompt);
>  int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>                            void *opaque);
> diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> index 98c1ec8d38..7ab6e3e31d 100644
> --- a/include/sysemu/sev.h
> +++ b/include/sysemu/sev.h
> @@ -18,4 +18,6 @@
>  
>  void *sev_guest_init(const char *id);
>  int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
> +int sev_inject_launch_secret(const char *hdr, const char *secret,
> +                             uint64_t gpa, Error **errp);
>  #endif
> diff --git a/monitor/misc.c b/monitor/misc.c
> index 4a859fb24a..f1ade245d5 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -667,10 +667,10 @@ static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
>      memory_dump(mon, count, format, size, addr, 1);
>  }
>  
> -static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
> +void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
>  {
>      MemoryRegionSection mrs = memory_region_find(get_system_memory(),
> -                                                 addr, 1);
> +                                                 addr, size);
>  
>      if (!mrs.mr) {
>          error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
> @@ -694,7 +694,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
>      MemoryRegion *mr = NULL;
>      void *ptr;
>  
> -    ptr = gpa2hva(&mr, addr, &local_err);
> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>          return;
> @@ -770,7 +770,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
>      void *ptr;
>      uint64_t physaddr;
>  
> -    ptr = gpa2hva(&mr, addr, &local_err);
> +    ptr = gpa2hva(&mr, addr, 1, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>          return;
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 1e561fa97b..4486a543ae 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -201,6 +201,24 @@
>  { 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
>    'if': 'defined(TARGET_I386)' }
>  
> +##
> +# @sev-inject-launch-secret:
> +#
> +# This command injects a secret blob into memory of SEV guest.
> +#
> +# @packet-header: the launch secret packet header encoded in base64
> +#
> +# @secret: the launch secret data to be injected encoded in base64
> +#
> +# @gpa: the guest physical address where secret will be injected.
> +#
> +# Since: 5.2
> +#
> +##
> +{ 'command': 'sev-inject-launch-secret',
> +  'data': { 'packet-header': 'str', 'secret': 'str', 'gpa': 'uint64' },
> +  'if': 'defined(TARGET_I386)' }
> +
>  ##
>  # @dump-skeys:
>  #
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 7abae3c8df..f9d4951465 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -728,3 +728,10 @@ SevCapability *qmp_query_sev_capabilities(Error **errp)
>  {
>      return sev_get_capabilities(errp);
>  }
> +
> +void qmp_sev_inject_launch_secret(const char *packet_hdr,
> +                                  const char *secret, uint64_t gpa,
> +                                  Error **errp)
> +{
> +    sev_inject_launch_secret(packet_hdr, secret, gpa, errp);
> +}
> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> index 88e3f39a1e..2d2ee54cc6 100644
> --- a/target/i386/sev-stub.c
> +++ b/target/i386/sev-stub.c
> @@ -49,3 +49,8 @@ SevCapability *sev_get_capabilities(Error **errp)
>      error_setg(errp, "SEV is not available in this QEMU");
>      return NULL;
>  }
> +int sev_inject_launch_secret(const char *hdr, const char *secret,
> +                             uint64_t gpa)
> +{
> +    return 1;
> +}
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 93c4d60b82..5275a624b3 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -29,6 +29,8 @@
>  #include "trace.h"
>  #include "migration/blocker.h"
>  #include "qom/object.h"
> +#include "exec/address-spaces.h"
> +#include "monitor/monitor.h"
>  
>  #define TYPE_SEV_GUEST "sev-guest"
>  OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
> @@ -785,6 +787,64 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
>      return 0;
>  }
>  
> +int sev_inject_launch_secret(const char *packet_hdr, const char *secret,
> +                             uint64_t gpa, Error **errp)
> +{
> +    struct kvm_sev_launch_secret input;
> +    g_autofree guchar *data = NULL, *hdr = NULL;
> +    int error, ret = 1;
> +    void *hva;
> +    gsize hdr_sz = 0, data_sz = 0;
> +    MemoryRegion *mr = NULL;
> +
> +    /* secret can be injected only in this state */
> +    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
> +        error_setg(errp, "SEV: Not in correct state. (LSECRET) %x",
> +                     sev_guest->state);
> +        return 1;
> +    }


Should we be checking the sev_guest variable is assigned before the
state check ? This will prevent an assert() if user calls the
sev_inject_launch_secret on non-SEV guest.


> +
> +    hdr = g_base64_decode(packet_hdr, &hdr_sz);
> +    if (!hdr || !hdr_sz) {
> +        error_setg(errp, "SEV: Failed to decode sequence header");
> +        return 1;
> +    }
> +
> +    data = g_base64_decode(secret, &data_sz);
> +    if (!data || !data_sz) {
> +        error_setg(errp, "SEV: Failed to decode data");
> +        return 1;
> +    }
> +
> +    hva = gpa2hva(&mr, gpa, data_sz, errp);
> +    if (!hva) {
> +        error_prepend(errp, "SEV: Failed to calculate guest address: ");
> +        return 1;
> +    }
> +
> +    input.hdr_uaddr = (uint64_t)(unsigned long)hdr;
> +    input.hdr_len = hdr_sz;
> +
> +    input.trans_uaddr = (uint64_t)(unsigned long)data;
> +    input.trans_len = data_sz;
> +
> +    input.guest_uaddr = (uint64_t)(unsigned long)hva;
> +    input.guest_len = data_sz;
> +
> +    trace_kvm_sev_launch_secret(gpa, input.guest_uaddr,
> +                                input.trans_uaddr, input.trans_len);
> +
> +    ret = sev_ioctl(sev_guest->sev_fd, KVM_SEV_LAUNCH_SECRET,
> +                    &input, &error);
> +    if (ret) {
> +        error_setg(errp, "SEV: failed to inject secret ret=%d fw_error=%d '%s'",
> +                     ret, error, fw_error_to_str(error));
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
>  static void
>  sev_register_types(void)
>  {
> diff --git a/target/i386/trace-events b/target/i386/trace-events
> index 789c700d4a..9f299e94a2 100644
> --- a/target/i386/trace-events
> +++ b/target/i386/trace-events
> @@ -15,3 +15,4 @@ kvm_sev_launch_start(int policy, void *session, void *pdh) "policy 0x%x session
>  kvm_sev_launch_update_data(void *addr, uint64_t len) "addr %p len 0x%" PRIu64
>  kvm_sev_launch_measurement(const char *value) "data %s"
>  kvm_sev_launch_finish(void) ""
> +kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"

