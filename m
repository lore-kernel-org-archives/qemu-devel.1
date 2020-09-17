Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E65EC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A71206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v6eX/WMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A71206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwj1-0004Qw-HG
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kIwfv-0002WS-S5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:22:25 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com
 ([40.107.220.77]:49217 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1kIwfp-00086Z-Ul
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:22:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma7x7TswjP/5Fokw4ATgcV+OuNvFtJz7RdpOm7gcjUb15c/v3n1u1T5wNBqkrMFlhRsi5XOLsqMwhWAs4+OKXcGFkxVo2YbmYAVOg3s1AdgipLuEhRoLIQWqy+grSHh173Js4gaA6f69x29+tOUtw4wqxtP+OM5zUKoyJ8hagWSUKR5e7fDsbX7k8aln2e0kPBrIQBNu2u6F/aKyhCdsfhFIVIKXAlBaNgCGUJQW51lVlYYe513S23trdMtukmZJtXliMjU2Hsu6hFHYFaO+2CNYE6t07gN2Ow1cbgN9dRYNLcszsdeI6WDMt/rtQzwR5k7XphPJ0+6phem/E7qqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++fF/0IKAuyREH4cF9PuV/I1Qr1q5dQM811yLm4F3mc=;
 b=Aas+G7Xb8Hoht9srh+WrxkhMYLKDXmtIH+IvSvY6tTUppcLXZ7XVEpQlotxwYb7Z4z3W2/ce6zRvBQSrH+PwkeXPaORnOhAwQADnh8fPrsAP0ke4/7v0KP4o098pJqNVU5Ox8lKMrIxxDXQRhKCDJ6jypK8A0wGoKKf3FdQDOu0xKk5so3zmL0FhZ50tiJVOQhsaWldc2icFlOi+XfDI0O9MsS24PFCVjEFFHBaSmREksksdHFwiRk6luX6783POGdVu+sLmidKHtAYkbPUYmdGYtpu9uERgdM6pljloPVNXHuQzSZnUe8CqC239gvVOQ0o+QtE86Opdb3sNq3SpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++fF/0IKAuyREH4cF9PuV/I1Qr1q5dQM811yLm4F3mc=;
 b=v6eX/WMnu8X2bBUEWgrSIwU00E9gTwVBdAOPgw0n+oXGy/7PaFN0DfIJN+7Mc8zaFK1iNKSrb0/6rrGcL15H/A4rEcjuOt9/+ri1gknhfCEXlkM3WrWo7MA54Qi1dC0Ld4VBLrX0nYvb2CXgrgcDkNbMOpHgiWzdj2j7O1bQKf4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.17; Thu, 17 Sep 2020 16:07:08 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 16:07:08 +0000
Subject: Re: [PATCH v3 5/5] sev/i386: Enable an SEV-ES guest based on SEV
 policy
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <cover.1600205384.git.thomas.lendacky@amd.com>
 <8e560a8577066c07b5bf1e5993fbd6d697702384.1600205384.git.thomas.lendacky@amd.com>
 <20200917153429.GL2793@work-vm>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <81e64c83-f41c-d8f0-3268-ec6185f4a8dc@amd.com>
Date: Thu, 17 Sep 2020 11:07:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200917153429.GL2793@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0066.namprd12.prod.outlook.com
 (2603:10b6:802:20::37) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by
 SN1PR12CA0066.namprd12.prod.outlook.com (2603:10b6:802:20::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 17 Sep 2020 16:07:06 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9e99544-6148-4c09-baa2-08d85b23ba4e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36906B6C69703F8CDC4673A5EC3E0@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Zlw0tH+uu8dtWe29a54aYtqb4RngLitnkFyKNgGmJHXyD5lAEmynY60UaBdAEvmdBXVk+VIgG3lwpfd43QOxceMNpTWMSQnBThk1/rrCb9JBofbp9LkmC5Z58h70bq1wnayUR8Ekk7BXnfltfimvHJI6yP9rdBemSVMh5cVA64Rbo0Pcg0NAQ4snptEqo3+yMRDAsgG0qiq3uzqNXwJHT5WqhtooJ3BsxzbMYd6pJEMuF7SGV6U2DGhTfXAN7/LUvWpXzotDxptaZJjxMbJ4bI6eHWVq7RrANP7wxYFk4/TZyJjtfVBMkB076y25KXqFIe2mQCOY9VNbqtW82j8c1EQxGyquciL3DFLuvbmyNQD+FKAV8S6K0Fs5vqB0OdP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(66556008)(31696002)(66476007)(66946007)(2616005)(8676002)(86362001)(316002)(2906002)(8936002)(54906003)(956004)(186003)(52116002)(16526019)(26005)(4326008)(6506007)(5660300002)(6916009)(31686004)(53546011)(6486002)(6512007)(83380400001)(7416002)(478600001)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GQnDHWxPvVhBOHKd3OWbrflHyQmyYwiKMFUZ2pyeDs54UiiJbzY4ziFzCUEFVMNqxyDTh2QyuIFU2jMFZsZ7S6JCnrd9SrxGHpTz1EJORGzQxoQnCTV3ZVyE1GHg56LbHqZ1qFtM4enFx+Bhq+xdkyrodURNaV6jl82oHgc8WvZi0WbwNGrjh+92Kw6nZnWvpjMKo+zyKdnlSta3NcaeDfyBaT1k/ukuQK0ndHoztLzc5a2AFd5WDTxh65VfFk4NwjL7740DnhBkX6v/XYssOuExQM8LHie04xS5iC8MIS3ZJccvoe7aAU+ugtWEBMXpHKHrmROqIBrlKUREnB5neyPycBzE8dh2FCPk3sIAvTZG1Y+VtBRVIv571wu8R29yVAa+vRNRu+oDeafXfDDG5nzsxDO+LUh6wF8xUZYaqx0RTFvEeSsAKqhUB9IBbchOO/zy9CPfMvfoiLaFMyiQOZY/vPdjZ+4ldP7KnDzzcxJK1kIOs8r/A6BTHtuNvNwbp1JZxi/w11FZNp4l7q8DXTHxjpgtHY+XR0u2u9ynJVZpDnwmJl99zZUGrHBog3OocUjWwOGD56aThi4oPma1ORKdS0b08rt9yfxzSlUtyQKynQGmY3kiMmepb+3GiyCz6lybMUUzovfdPJRMSauEzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e99544-6148-4c09-baa2-08d85b23ba4e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 16:07:08.3228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sYMD20S5895Akp99uYC48lCkxCBAhsMT84I7TpSnLfdqRZKQmSgPXctm1gXogJ7+r7W0a0JMM79x00lOY0L4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
Received-SPF: none client-ip=40.107.220.77;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 12:22:15
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Connor Kuehl <ckuehl@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 10:34 AM, Dr. David Alan Gilbert wrote:
> * Tom Lendacky (thomas.lendacky@amd.com) wrote:
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> Update the sev_es_enabled() function return value to be based on the SEV
>> policy that has been specified. SEV-ES is enabled if SEV is enabled and
>> the SEV-ES policy bit is set in the policy object.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   target/i386/sev.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index 6ddefc65fa..bcaadaa2f9 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -70,6 +70,8 @@ struct SevGuestState {
>>   #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
>>   #define DEFAULT_SEV_DEVICE      "/dev/sev"
>>   
>> +#define GUEST_POLICY_SEV_ES_BIT (1 << 2)
>> +
> 
> I'm surprised that all the policy bits aren't defined in a header somewhere.

I have another version to be issued with changes to use QemuUUID, so I can 
look at moving the bits to a header.

Thanks,
Tom

> 
> But other than that,
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
>>   /* SEV Information Block GUID = 00f771de-1a7e-4fcb-890e-68c77e2fb44e */
>>   #define SEV_INFO_BLOCK_GUID \
>>       "\xde\x71\xf7\x00\x7e\x1a\xcb\x4f\x89\x0e\x68\xc7\x7e\x2f\xb4\x4e"
>> @@ -375,7 +377,7 @@ sev_enabled(void)
>>   bool
>>   sev_es_enabled(void)
>>   {
>> -    return false;
>> +    return sev_enabled() && (sev_guest->policy & GUEST_POLICY_SEV_ES_BIT);
>>   }
>>   
>>   uint64_t
>> -- 
>> 2.28.0
>>

