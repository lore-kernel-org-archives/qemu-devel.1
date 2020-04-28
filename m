Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BB5C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E256820663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pi/UiPgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E256820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMU7-0000LI-0h
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTMPq-0002AJ-G9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTMMf-0000su-MK
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:20:33 -0400
Received: from mail-eopbgr140098.outbound.protection.outlook.com
 ([40.107.14.98]:22631 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTMMe-0000sY-RY; Tue, 28 Apr 2020 05:17:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC12H12A5G55UnlzHgrncPlM6bagFyWwya5EyO+p46tl5OI/SB9LkYZxV3fCVxh0NfhlEm6L+XNIinEujAxvrWqQ+jpvKq62CVUdfAL/HWqgMrhFLX14GYevV6EsHyiRCS6Lfk9CvLCb06sUUSfZQaWQGk8Pp+I4lK75IpBZOuyC2yXFxVR3Roy2MvX3Cn/xblcFgqWd4/iuhKyngnYQZLbpwmOfqzFwgrxyjjBLIBo9Dn+nOyEttIl+r2OmKdvKeI69LZTRdG9DHkRJ3D5NuBfPmPyDl9B2IPhDocRSE5qc06ndeNViK9Mr9ptFXciCSOO67SHPeT5R3wexzEpgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfUNAOL9NY2v1Bdc94tU+oCTjE5Bdziivmy39UMaI+E=;
 b=TJ0HYwf+U2sfV5wHzgzdAdairJmRBcA853cPUW9LQsr5bfpnoJhDJNQxwvuz2/LkfBcLOyGqhwmKdxooTFk4fhX7J/5/9RyHKIk2fcwIX8pXuAkSPRSX/ynIiJa/Ga/Do7ndxAxEPr2rhTcHhh67B36JnUefIXlUNMw2CzaC8BJM37vF0GLVrcCu50YJrux+MKAsixYRSo0LJdflT+zeZ25pp574QwX14gHREWOMcSbXw8bRGG/ChDQupOwb6gh5hjftIZeLons+/6WXcY8uU3IPHFXMP1pSOS2aPVgt/EmQqYqDV040fLTz6bfCAYpreT+puDOZwVrpVSAlq6S2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfUNAOL9NY2v1Bdc94tU+oCTjE5Bdziivmy39UMaI+E=;
 b=pi/UiPgrHKbZvzp8JQIZEKme8bR7AhI24bQgtrB3PMrDIBu11f2EiQTuwT/rDShHPeh5l19sZu2Y3aWkPUZwLDI8LAoKQ9pFkLcMMkJhFgRycJUUDoaLvLAi1c7uo3JF+LeiY2prFfwxPdUW9OcYSqdAAnKr1epAVG4bBJ4GooQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 09:17:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 09:17:11 +0000
Subject: Re: [PATCH v2 5/6] block/block-copy: move block_copy_task_create down
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
 <20200325134639.16337-6-vsementsov@virtuozzo.com>
 <ae040bc6-7c0e-4b55-0723-c5e892570fb9@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200428121709825
Message-ID: <9fd7f07e-d297-15a5-1bd1-355e8c8b013e@virtuozzo.com>
Date: Tue, 28 Apr 2020 12:17:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ae040bc6-7c0e-4b55-0723-c5e892570fb9@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.155) by
 ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 09:17:11 +0000
X-Tagtoolbar-Keys: D20200428121709825
X-Originating-IP: [185.215.60.155]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c425c00-30fc-4210-87da-08d7eb54ef1d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53814FC05594BF3CFB30DE68C1AC0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39840400004)(2906002)(4326008)(5660300002)(107886003)(6486002)(36756003)(478600001)(16576012)(66476007)(66556008)(956004)(31686004)(2616005)(186003)(316002)(4744005)(26005)(81156014)(16526019)(31696002)(8676002)(8936002)(52116002)(86362001)(66946007)(53546011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BmSDVW0nEGqSlJaNS/yEs5yPtoOLIEunNWLvi8IliCOwYmmFfe61yhkWfk2y7lkgFD/esuNuLtLPtrM22kobg1nnpXI7NYw2cTvmB0h2e5lSOYakypLfr+tFNikVroR6PMEuO3MiBcS7FHdHgon56OifG+magESMdRNjhn73rnSJjbLkaqvN7y2SKPw3OjugruBAtAAgjvipfKti8LZNhEBT+/B7OeEYp91hTuDX7m7WRBmQsVUG4vj6PxXFJjt1RnbySfmCeMf0G9oYQlizZL7xOQhHeEeRCqEeT0wgvKDVs+KI/t43Tadw820hRPb4NkVUbSsJALbUh7VpZFmi69AzGvsnWjdw7sc0Gfm69W2uhz2R/uknQlvMbmRolBU3TmthrwUopEGKM6sS1/+LsGB0WkjHrDxcU+M+DVCJqfucclFGMD+1nnXby0tMvNkE
X-MS-Exchange-AntiSpam-MessageData: GHX8BdzSKkxqtRt35EPXWDzivSmob5OpgDFVbax15SNZNrPCLQ3kAM4OG03ESjm4SomsIvdxZtLv1I6oAYBhU6C7f3CLDDihdksN8hEO9R9YecbxUfT4noUpvEswGccPDuT2bnmMgI7LMMBXihx9d9C7Xx1aiNDgntdHGJG/MnWhFPJhyg5RJ8x7G6nEy7/E6/3fGN39QWMht4NaKVEo+aYIjDba9xcYlZzp1rLtNJaI7L7xJTG+FjrXNwtxysESZL4JjuzOF9QnwVCns074XATQXogkT9k4qPz/p5Eh5a5nn+C56mzZP3toQQSnSniKOYLtSic00czyMoqQ7X9WK4xYfdrirDCLaFcQsGPdXQmqYz6ejhsLqAwQBLsBebytuh1JzWAKAejot2J3vc/93Z0bg3PXyfUJIfF6BKIrbbsWc730b3TMfYkFwkvK5vO5fKxuT+O2J9uQgk2+2t+FRLt1sf1p256LHzamf+iETgDDxGvk3HoYaSTfhVkggCduUrrQ0wpmXE9GpDWLSJJYIkVEoeh+WwgVdgxx1E2oDVdJcyGRJBnGndTZ/lwVUDMJyglkwhOoRe8fJ3fSx5RPCEAURhXrsvXiqA7CzySCVBe7IQGXFto38BY/Dt7Eglw3rht9934Ghzbdww6AMn3CMvyYMzYpJcTQkNG+yLYZ3N1gRPIolVVXb3eBjNAzNFEzdiSQcg/9VGdnWO/PKjmyxqQiqDl6UVK7EtEHatRN97TRy91Wv8XV7EbzpUU63CTdSj+42WrHLglnflkoppxFJ3a2wMkfqq1KO7d40OktDVU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c425c00-30fc-4210-87da-08d7eb54ef1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 09:17:11.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLS4h0FPO+nVwUCdqhqkTvnI1jzVdfqnbWs5880LH5aZrUM7IcabufHCRQCNTMuba2ogvzIWVDq0Y4e3BTVykyYtG+yGecoDELejLSA0FMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.14.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 05:17:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.14.98
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.04.2020 12:06, Max Reitz wrote:
> On 25.03.20 14:46, Vladimir Sementsov-Ogievskiy wrote:
>> Simple movement without any change. It's needed for the following
>> patch, as this function will need to use some staff which is currently
> 
> *stuff
> 
>> below it.
> 
> Wouldn’t it be simpler to just declare block_copy_task_entry()?
> 

I just think, that it's good to keep native order of functions and avoid extra declarations. Still, may be I care too much. No actual difference, if you prefer declaration, I can drop this patch.

> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/block-copy.c | 66 +++++++++++++++++++++++-----------------------
>>   1 file changed, 33 insertions(+), 33 deletions(-)
> 


-- 
Best regards,
Vladimir

