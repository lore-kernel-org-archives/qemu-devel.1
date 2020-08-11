Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AEE20781
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1eC9AQVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AEE20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5bgP-0001yS-5N
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 17:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k5bfo-0001Z5-L8
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:19:08 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com
 ([40.107.236.60]:7392 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k5bfm-0003K0-JW
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:19:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW8GWPBFyFdz/i0lGVhcF4AQmNDe3KJYIjze36W+WsIRmo6ftWLVjHoioM6mBmBYXqGEx1+LEPtibpH7u5LMS69ZaZ9ABlJfeTnapP2CuaSJd4bm3swCz8bNwL0D6qlJ/D70NvDMJn9NiRvnG+g8cCxYfnwOYdtaNlnExNB4BL+UswDLJBAAhLClsCUTZwAdWV8A0ZjIiReB2w+8cbjxciZ2V77g24p1ecEqd0qR49fhX4Wvt8WjFGDYNh4QQ0/lKsYyOJGhQAyCrqCTK7bfbTp+YP8xXFOIc8Xp6FDavSwSMNJvB0owWHyTO8bES8T8hQOt9k9fOCY5Ojt0gVQeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ1W8Rqw49BK2R+bP9B4DGjbXGOf7kecIWdMlfT4OP8=;
 b=MZfO+HdhEzH5jrZztKKVtgrCtiIxu/MESNOR2ZI8pkC9dz2kPoWQFkCag6gYUV4ObMvAJlTaVEuTyLDuDyAmNvQgitvRJen0yeoLRB1svII1UZzJ02KQSeG9uB+HgE/y3cyGblZN6rOjN0dlvxz4+6OlzbfJz1CuQc6tby4Y/CbJ3n/wxfG/0nqp0Bh6SgR+Xkjqtn8gyMsipY+eUJdu2kObmTFOqoTKErvy468RMOxaktAcaOjNIDM5J2mjJ/yNrwmjSvzPhedOGtcI9qzhhPlQ+mZxpjAdXnl/1YaXCRx7Xtv95kjeRCxpIsN4P2vWttqnOghgQOlGv3q8Do9Q5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ1W8Rqw49BK2R+bP9B4DGjbXGOf7kecIWdMlfT4OP8=;
 b=1eC9AQVBtByWxzQRjFL+VbIRJS67rru9tEpBCqSM88AHy3C5pPsDp6stofusv6UPaMpmMrl0RN9HAzcJeE9UCb+D8249LnwU/q2Q7G2/7n/fEAJHzKGo/6tPHTLQQdbnQIaYZ5SLBs4MzSuJmV01F6x++qa3BKIalsYhlfquFso=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 21:04:02 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 21:04:00 +0000
Subject: Re: [PATCH v3 2/3] hw/i386: Add a new check to configure smp dies for
 EPYC
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
 <159681797161.9679.5653247810916709875.stgit@naples-babu.amd.com>
 <20200807165222.GB120942@redhat.com> <20200807211148.77749e6c@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <9793a0d9-3152-6e40-4a1b-cb1aff7cfe38@amd.com>
Date: Tue, 11 Aug 2020 16:03:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200807211148.77749e6c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:5:74::14) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM6PR07CA0037.namprd07.prod.outlook.com (2603:10b6:5:74::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Tue, 11 Aug 2020 21:03:59 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 667ec52c-098c-4b99-ecc9-08d83e3a11de
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:
X-Microsoft-Antispam-PRVS: <SA0PR12MB441417E6E8CB9E3F44489A7A95450@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMvhB2er+3Ba1V5qC0joNmUBiBn0a6co9fhmR1KHwP/CWR3xar+QksoiNSqGCIVHUDisPAtrHiyFj/fcgj8o/ZY4TpwIDtFY7XOI92utqoZG31VWXx5fR151cv2mLuQQxgBX8GaFCn58d+vYRrijlqQBsiPwqUhn1JXROKTl0ntgt65ueAOYTM4fWVCVIw6uo000GDEhp5Ilo7pMDIB1o4kty3GmQf5409dnie6Rj3zz3vcbSp90QNnwk1RKOYoibkW0KbmiLU56uEPtd2lN7O7C/nTrXSD49hRaWyYHhJQkfv9SHdILz7zD5+7tYhZ0a824rLeH2ebii0X92eatnps1K48O9/ATnHG1P5PnShuMjVrbA/KUNYzkIYVRkOKr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(31686004)(36756003)(66556008)(66946007)(186003)(66476007)(44832011)(956004)(2616005)(6486002)(5660300002)(83380400001)(26005)(16526019)(316002)(16576012)(110136005)(31696002)(8936002)(2906002)(52116002)(86362001)(53546011)(478600001)(4326008)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BmXRFm4ZLn5S7W1xwl7XWjUrxrwZLMmw5H5+EzXDUUDsKgtLSEaGhJZd02OXh7FYwJN9QRwb6gPADBwSP8ERAyozCE1wzCmTqntvcTr62guo9mSNt0Pp8v5PHM651/xLeRyraJCBLRx0qPhpAAcqS8B+D5ADvqRIIozQH3rZTufltR72VNRFpxoKNCDkQwD0iTqv+XXFxHDKPiZuQ90QbsNl5QJcrx9VGTh8VvItAFaRapEa/70S6YrlQZ/JmSZWUmlEL6uJ1kkHkwrl2QyBhke2aqE+ASivDhaMYml+WEo2tL5mnIYq9nf83GGkC/RmwfbfhM4Ya3jtmm+FlNDNZiVrwybFIx0ivvQAKoJE9CO2Wj/WhCtD1FNwwF3J6+gMIJVYjW0NN6unsvRSA0l5xqTMbVW5wtLl5BKSgFK3GOOAtZPNsV4SbEquvM3AcTeZnKI2cO0zcRHPY8hYsiuNJHopB/AIGKz2snqrhIECd5XMs4deBHTS+4zqZDQ1dttqIDj9eW+MnmC8BgfZH6lEajXDXUl8rhu9f4aByhAI6L6gHSLS25tNoc4tHXy9Xx9tFFi4mvYrgPhe5m71WudBDkDLlF0vwFGq0BBtuiKwQ1JHT0OBYnR+I0WwYio4BYk+X41ffkbGRc9BtWslYVNMjQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667ec52c-098c-4b99-ecc9-08d83e3a11de
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 21:04:00.3141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tTqzHq7Jj09tpDzVQNjyDQ1iRrOTs/3F19gkh7Yxf/KIYl9BvdZ9l9C1sDGBl8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
Received-SPF: none client-ip=40.107.236.60; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 17:19:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/7/20 2:11 PM, Igor Mammedov wrote:
> On Fri, 7 Aug 2020 17:52:22 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
>> On Fri, Aug 07, 2020 at 11:32:51AM -0500, Babu Moger wrote:
>>> Adding a new check to warn the users to configure 'dies' when
>>> topology is numa configured. It makes it easy to build the
>>> topology for EPYC models.  
>>
>> This says you're adding a warning....
>>
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>>  hw/i386/x86.c |    7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>>> index 67bee1bcb8..2a6ce56ef1 100644
>>> --- a/hw/i386/x86.c
>>> +++ b/hw/i386/x86.c
>>> @@ -138,6 +138,13 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>>>  
>>>      /* Check for apicid encoding */
>>>      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
>>> +        if ((ms->numa_state->num_nodes > 0) &&
>>> +            ms->numa_state->num_nodes != (ms->smp.sockets * x86ms->smp_dies)) {
>>> +            error_setg(&error_fatal, "Numa configuration requires smp 'dies' "
>>> +                       "parameter. Configure the cpu topology properly with "
>>> +                       "max_cpus = sockets * dies * cores * threads");  
>>
>> ...but you're actually making this a fatal error, not a warning.
>>
>> I'm not sure this is really OK. Wouldn't this mean that existing VMs
>> deployed today, risk triggering this fatal error next time they
>> are booted, or live migrated.  If it is possible someone is using
>> such a config today, I don't think we can break it.
> 
> to begin with, users shouldn't have used 'dies' with initial impl. at all.
> (it was Intel introduced option and EPYC's added very similar internal node_id
> (removed by the next patch)).
> Now we are trying to consolidate this mess and reuse dies for EPYC.
> 
> EPYC was out in the since with 5.0 (though broken), users could start a VM with
> such config but that would not be correct EPYC from apicid and cpuid point of view.
> Guest OS might run if it doesn't know about EPYCs or behave wierdly (sub optimal|crash|whatever)
> on seeing unexpected values.
> 
> If we are hell bound on keeping bugs of initial impl, then we should keep it to 5.1<=
> machine version and do the right thing for newer ones.
> Though I'm not sure we should keep broken variant around (all we would get from it is
> bug reports*/complains from users with end result of their config anyways).
> I'd rather error out with clear error message so user could fix their broken config.
> 
> *) there is at least one thread/bz on qemu-devel where users are trying to run
> with EPYC and pick up options combination so it would produce sensible topology.


I am still not sure what is the right approach here.  I can think of
couple of options.
1. If smp_dies != num_nodes then go ahead create the configuration with as
 many smp_dies and warn(but not error out) users about the mis-configuration.

2. Introduce it as a fix based on  machine version(5.1 >) like Igor
mentioned. I am not sure how to achieve that. I can look into that.

Thanks
Babu

> 
> 
>> Regards,
>> Daniel
> 

