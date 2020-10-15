Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79405C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9FE212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bvPYh/+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9FE212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4RN-0007Cw-JX
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brijesh.singh@amd.com>)
 id 1kT4QT-0006g0-S8
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:40:17 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com
 ([40.107.243.82]:4623 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brijesh.singh@amd.com>)
 id 1kT4QQ-0000IW-Gr
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:40:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fR33Bn+Bjg6O5SGMsHZ+rtKfpEZFYdK0k3NNOorrxOh4cdxiYmELl+VIE1MZBu5GCgNdq77Ux/0nA+kzKhm2/ib/RKKoagG9s+dCejLNNhvo6qQyd7z4WWN1wlQdR3xxz1zMFj9u/4QVu4yypkMi3zmclV9t+1Pq2VZQjQFZBevRGIgulx0LueQSBj6wkvhHhy27GeDl7u2dtISgfh5XVa1EIAExBLe7wdZfcZOXCyiIMYqUuKXBQB1stIPvQyulI02ubJn2PJeIO+yZqRueIQlivhnBzK2bcj3IbagaEb7cgrDLf94tNSgxyDuWbFHlQxmVP6xDxifbgF6eqvi1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XjwFSwWtg68BB7il9kuOL4HnSDLkHWeDLN8FqKQyZI=;
 b=b5WSi5PhxCDo2PiNaPaNEgFTz0WFn0xxLRIhAI+BNzR22YT4sbRCkVpczH2QfctxwOEAdkGm7Hp5PYE7ikEnndslAW/IZOI+wpxW9vvWoIfp01bcpYQitgRMRMMJtQ1JXpuf4U7dNy3Q7cCsJ9gHGOjv7afTHUXEtIEohYgtBpPgMNArFtU5KrlNtjFwaYI61AWvvfn49ASJSkYu35cK+2TqlSx5KC0J9kbTDOk7NA+5oeuraXWCaAmjMpONd4OP4ClFbq0RO5O8+cybmLSpSzIqpGiCKHoApAcO5CqVO6y4MpsnSWI4fRRXTRWs68W6EgKNpubS92JA3OEnxaiCJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XjwFSwWtg68BB7il9kuOL4HnSDLkHWeDLN8FqKQyZI=;
 b=bvPYh/+8K4OE2LTRJPO8+zQrleQtc/dsN2OMUJw9oK+zA9ASFnlrfcIrhSxXEIzxVXAMacqV1xB3ig5kUlcaTZhlFP3Rlq8GtdzWZZS43Iy9Qb+ztReN+YZLtBxhp2esYqzUc09+bfQcjdeAzAeSw7A9b/lA6erFrx85j71gp8I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 15 Oct
 2020 14:40:11 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::6d9c:78e0:e7cb:558f]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::6d9c:78e0:e7cb:558f%7]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 14:40:11 +0000
Subject: Re: [PATCH v5] sev: add sev-inject-launch-secret
To: tobin@linux.ibm.com, qemu-devel@nongnu.org
References: <20201015143713.14682-1-tobin@linux.ibm.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <84ddbbe2-dbc4-1812-9d4c-2b3267d922ed@amd.com>
Date: Thu, 15 Oct 2020 09:44:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <20201015143713.14682-1-tobin@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA9PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:6e::33) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 SA9PR11CA0028.namprd11.prod.outlook.com (2603:10b6:806:6e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Thu, 15 Oct 2020 14:40:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50caa375-a997-4498-f949-08d871183840
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382992D650E87F13C946EC5E5020@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3YMqr+/4LJNuxWvVpzYIKUYMmgDR8evYvUhXK/oq9qnebmCPp6cjobtGw1XW6ScALQAQyWb4VKeCroo5jrGP3xw0qylkuwkNjrQyDQSZtqRmxIWS2I70YJ2vvMT9aJzuu423brqHq4fX8S/aGSCiNDxsXv04/1+49tv/dq0PVMpvTkJGrzp8Bo/0ESHtKi3D6OvqtzZHSmCz8Tx8S8YaQCFypRRLDkSLerSTrCJrOXxf8UnokM4Eqq1DkG9Cu/vTNWs/Poj4eu+/aL07bYK3pt272n2PyRmYAd/SLBScnxOE1hEsFVNZx3MZftwtqHLCMSyxs5R9Af84wHViQHNP6R5ni7f/mwUP6GCpBtpt4F0p1E445EOSl5Z5GNn97o3jmt4j7PddB62su/2wxZLQbUpP3Kkjm7pNFQID/854aZX/Y2qa/KZ6d9nBsA33bGZd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2718.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(16526019)(8936002)(26005)(53546011)(6506007)(8676002)(186003)(34490700002)(52116002)(6486002)(478600001)(2616005)(956004)(316002)(66476007)(36756003)(5660300002)(66946007)(66556008)(2906002)(31686004)(6666004)(31696002)(6512007)(44832011)(4326008)(83380400001)(86362001)(219293001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sgVSEfXGxj7Dnqir6YsoxV6QoYm8uQtV6Hy6O25VC0nIX0GczW5Cd1zEIjIAvhQWTBSH6Y8zEuBoh+HAoTZ8xOEqu8hHWV9Trpwjf7ntbuQkPvIegO1MSYsRAVcGx+7xilb3stviCgCkjoiBvOEQMGujjKUnzJiwYzXfO9jeH2SHjeExzDj4j0W+hgbSYJo4Kv4/RIMozXwJrnDLa+VGnzxOOxdsW3Clrd9pxxNw1RWtN92ohqBSsn1hkVJvpFbbOwEuEtCgIbuCv3nk2PlD8B3VjJOubnjQESteShVg+aeMjflWtPuNPsj9GoI//gjbELL1zLT9vDQSDMnXuq0ocMznm0kFoWXkf7ihfz0xv2lrfIo7H69hf00LnnSDX2vmnaYBDwJwb7wv4uU6QFyK7dtsY12zE1jluaasVZFUTWsV+D7e/y2I3mr7BNUZagc1cZwgB5nUOX0+mWd/K5Eqr9wtndajJAFHJ/xsSTtS61zBJLaTdrS3kYWpkBy3aZkNwWpjPeWRTzwhzsWGyNjl7G/yqdcvScSVV5vW7CcAc/j+dDATFPVP3C33wu7UXYV3H3dFhulWmFhdZ140jXKwHqo6ut3FQunwiEW5qmXTFv/oP5Beo4MTv5pefONTGqY97D8EIsDgOoQSe9Vp6u8cDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50caa375-a997-4498-f949-08d871183840
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 14:40:11.2289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s8c4dwEu/+fiydKdvTiMCSBy9PgVa801J5VEylSykVRgA4t99fU0BWmXF6iSl2026CdiiGmwDovix//fnhypA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Received-SPF: none client-ip=40.107.243.82; envelope-from=brijesh.singh@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 10:40:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 10/15/20 9:37 AM, tobin@linux.ibm.com wrote:
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
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>

thanks


> ---
>  include/monitor/monitor.h |  3 ++
>  include/sysemu/sev.h      |  2 ++
>  monitor/misc.c            |  8 ++---
>  qapi/misc-target.json     | 18 +++++++++++
>  target/i386/monitor.c     |  7 +++++
>  target/i386/sev-stub.c    |  5 +++
>  target/i386/sev.c         | 65 +++++++++++++++++++++++++++++++++++++++
>  target/i386/trace-events  |  1 +
>  8 files changed, 105 insertions(+), 4 deletions(-)
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
> index 93c4d60b82..1546606811 100644
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
> @@ -785,6 +787,69 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
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
> +    if (!sev_guest) {
> +        error_setg(errp, "SEV: SEV not enabled.");
> +        return 1;
> +    }
> +
> +    /* secret can be injected only in this state */
> +    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
> +        error_setg(errp, "SEV: Not in correct state. (LSECRET) %x",
> +                     sev_guest->state);
> +        return 1;
> +    }
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

