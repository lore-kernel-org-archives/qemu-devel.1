Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5A5C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC016206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4SNJs7iM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC016206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWpw-0007Qv-15
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iwWnq-0004hC-0x
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iwWno-0003gi-4I
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:45:37 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com
 ([40.107.236.46]:6223 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iwWnn-0003gJ-OQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:45:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTxRWc3BV5xxUygWMHHjwgfWfCxw44BVSO3MaXA+V3tyIdWl4M3iv4ilNY//dSWyJw4+6y5w8KMm3sTQzHCV8MKo7nJCguXXXR5K+vtd+lPTgS+JBN9RhHgLyWDe1KtZemzTpGAHm4qrDfq0FKmZlP59WohVJNLLY52tSaywnbSqvZTiWySr8dXYP2tP6HzpfvrpilHG47ZIcN37tJ3H5880jHyBcYXol+7OXYjTaOx8WZNEChCU899YrMpoePs5ArgGRvae8pVynI2BJR7E05OKtTeJBDl73rOeLR+T+e/NLRcrXi0vCWsrBh/1i1ASMNadZRscWy6pfqEZvujzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfOaLhCK7c6hwojxFacn5UUfLV9ANHh2Kz9lpJCoXcY=;
 b=Y8Eq50/Uc8ElZNhbxJ7fGZ2boQl9xpdEtowJbipv3e40A/iEfklfmKohHpuwWJJMbskm3wXJtDtnlUMEX3atsgJQaALjNp/bKVxOrdlIjg0NhKD7bNoZSTCr0+aKunuVdkcYK5AG3qeKGv05LX6jxJExWhF35aVNYl0qSKyeYphwyNcTCkd4rB7J4vnUkS3YoJCYfri9dhPrw1IxOo8qXDYCL9pvw4Etq3GNQS7nEhGndt41XqOY79QiP+IFp+NC91TMd040jWk12XxXLCUrjfDKeJc4IKE+5zjesYGPU/jyyzUcPgHa/DYfw1/QvKDQmTArPBL7wL+j8dsJrYNYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfOaLhCK7c6hwojxFacn5UUfLV9ANHh2Kz9lpJCoXcY=;
 b=4SNJs7iMRzUreyZjwVjnFxUx4C7WraldbuqB8t8ttVMS3OGlaYbcmNOORSdgI3g4P3osVxAADJUSf1Ugi9e51h9jKTcv4e11BA40oMAiOLQYYxQ8nOAoRfzimTBCX2A9mYdC4oDeDTfOp4kMVlVTbifahHBAWau4QJUWVqtUoCI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1271.namprd12.prod.outlook.com (10.168.167.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Tue, 28 Jan 2020 19:45:33 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 19:45:33 +0000
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
Date: Tue, 28 Jan 2020 13:45:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200128172919.4ecb5896@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19)
 To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.19 via Frontend Transport; Tue, 28 Jan 2020 19:45:32 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d581349-fe54-46e1-4be7-08d7a42aa353
X-MS-TrafficTypeDiagnostic: CY4PR12MB1271:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1271F5F14C3696CCC4237F43950A0@CY4PR12MB1271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(8936002)(53546011)(8676002)(81156014)(956004)(81166006)(52116002)(66556008)(186003)(26005)(16526019)(2616005)(66476007)(66946007)(6916009)(36756003)(316002)(44832011)(16576012)(5660300002)(31686004)(6486002)(2906002)(4326008)(31696002)(86362001)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1271;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEqVYVNwW0fsiFTsDrKVXo8vm/wPtcKwqfI7UbwwXZWuzUjFUGBihD26UZ2hvGqYdkJSazi9xEeM0dD0YcSwQbh68kkqQ4WdSKcFM+jvMMqrYFIgqdgON2rTW5RgtfiEZpgYsloG46AVqJsCtkDBWtsGCoZubrwxqbqF1MOfgu6YafbL2hSKzcEAR4Fw1w5GwzaxGRQlY2ti9PxGcp8slXq1aObbtbb2/amA8ciIC0T+YBZ08mFDKc4FuUHKRclw338pfqez7O/87Vcp7ISvTmOSo9wodPc0Ux0whoecIaRwQ+PmKvwNEHnIWZkIG3bE9WZs3BStgPjB/4+uctJqZm4o8IroGmloUvVOWWTR0YPYQZGrn/koWlqPIiJwNAGuj1vwtXNydOAaLG8+0NO7oM4k9Nd8Kr3anElPOHhfcVIANKI1UAlF4VMySYR6tB3J
X-MS-Exchange-AntiSpam-MessageData: sFgIWbh0Uaxvc+KpWzZgGDkt/qRAXe+OzW/swe0qhN9qWwkyx3vRvnqwfSI6l0ZLmMUSe+H3X6TUQY/fNHU3ollMwoTw5ovnhG+Yi43Xec1unwFNMYjRLn1tDyU5V+0tzfNvaYjTuBlxY48gxP4GCA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d581349-fe54-46e1-4be7-08d7a42aa353
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 19:45:33.4240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvVYIuuExtDTVd3qKFmmUiHZw9YSH8U6Jc9AwsirPzn3FBnTSDqLdnUwVT93XRE9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1271
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.46
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
Cc: ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/28/20 10:29 AM, Igor Mammedov wrote:
> On Tue, 03 Dec 2019 18:37:42 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> Add a new function init_apicid_fn in MachineClass to initialize the mode
>> specific handlers to decode the apic ids.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  include/hw/boards.h |    1 +
>>  vl.c                |    3 +++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index d4fab218e6..ce5aa365cb 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -238,6 +238,7 @@ struct MachineClass {
>>                                                           unsigned cpu_index);
>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>> +    void (*init_apicid_fn)(MachineState *ms);
> it's x86 specific, so why it wasn put into PCMachineClass?

Yes. It is x86 specific for now. I tried to make it generic function so
other OSes can use it if required(like we have done in
possible_cpu_arch_ids). It initializes functions required to build the
apicid for each CPUs. We need these functions much early in the
initialization. It should be initialized before parse_numa_opts or
machine_run_board_init(in v1.c) which are called from generic context. We
cannot use PCMachineClass at this time.

> 
> 
>>  };
>>  
>>  /**
>> diff --git a/vl.c b/vl.c
>> index a42c24a77f..b6af604e11 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4318,6 +4318,9 @@ int main(int argc, char **argv, char **envp)
>>      current_machine->cpu_type = machine_class->default_cpu_type;
>>      if (cpu_option) {
>>          current_machine->cpu_type = parse_cpu_option(cpu_option);
>> +        if (machine_class->init_apicid_fn) {
>> +            machine_class->init_apicid_fn(current_machine);
>> +        }
>>      }
>>      parse_numa_opts(current_machine);
>>  
>>
>>
> 

