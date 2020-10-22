Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB1AC55179
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B382072C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fAqTuOOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B382072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVcwE-0008Nj-Ns
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nshirokovskiy@virtuozzo.com>)
 id 1kVcvN-0007s6-4m; Thu, 22 Oct 2020 11:54:45 -0400
Received: from mail-eopbgr50126.outbound.protection.outlook.com
 ([40.107.5.126]:50437 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nshirokovskiy@virtuozzo.com>)
 id 1kVcvI-00006i-Kf; Thu, 22 Oct 2020 11:54:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjQEU3SFlHrXRU51JWRwLzjNVXe0rNL012mhSB+Lo1DkVq9d7iu4COnfhc++Dg1NlF+egFyr75QIjilaKG993L7F7Un9xDl/tVFqZrlLBvWP8jAKoGTnuiIUA6c2KlDysXIBpJibM7yyrEMHb03OLXLPQ+ixY/TFc99OgPRvUA5Q51mbmpWZH4j5FI4p+UNyeLjYLBw9pGs9o7jCw3qwGnGSRzD9rIHm3XB1jG8dzjRblzw1BnGzkNIOlC0ZCrlZZ9tj3oxWEi9nN6FQWpBg6+bswWgULocvwFRiVvKbWm1cGnqxAK4w5ItCB76jlYxtXS+YCj3b2ibN+kpmzWL3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OvloVZccptKVNopjo9sl980X6oPnD9guwflZRtgrcY=;
 b=LWAwfpwZFkNR9ellpvCYmqyFR8mZk4dFZ8K+WDQd3wX3n2XGv3FAMnz/MWD26oM87ir+hgt/Ifj89SgU8Kek+YDr2R1GOc3po/U1uVqGtyj1hU9qrTGLI32//Nj1u0+6VLlbM2cNBXzNuUuvYsXx4jGuWNFGD1LB+X5uo56u0+RfxHPkuANSlB6z9wUQXDE2qJruWzXZ2S4MiTgfz3/oTJrorjI925ue0uatf3ND5iGkYSXyUrYD8UVDlwCy3HQ3znKRL/FlckQVmp19G/VxBlk/XnnspKUyzFv+Y4A940rwTQLiosFAKz2xswhsTqfy18HlaTMlrWkeH/7Upl39gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OvloVZccptKVNopjo9sl980X6oPnD9guwflZRtgrcY=;
 b=fAqTuOOwNECl3UkrcaIrQERbAvGW1oCdTvvR3j4XuL/e/QdH1206TmmPT9/nxmleKFGAdBYgbp9wfZVCNcE7FxPv4yp1Zyx3icEd/BEqhYIYDCpN2jOlWPWHDdeBE1noQWQtA3Udb628a1K/Nd8nPOVVZNcuKI0/fYrLy3DECuM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2298.eurprd08.prod.outlook.com (2603:10a6:3:c4::16)
 by HE1PR08MB2634.eurprd08.prod.outlook.com (2603:10a6:7:30::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 15:54:33 +0000
Received: from HE1PR0802MB2298.eurprd08.prod.outlook.com
 ([fe80::d12a:7bcb:c813:55c1]) by HE1PR0802MB2298.eurprd08.prod.outlook.com
 ([fe80::d12a:7bcb:c813:55c1%10]) with mapi id 15.20.3499.018; Thu, 22 Oct
 2020 15:54:33 +0000
Subject: Re: RFC: tracking valid backing chain issue
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <3b99657c-2016-78cb-4314-27aacb30ca3c@virtuozzo.com>
 <20201020085029.GC4452@merkur.fritz.box>
 <a996a3cc-387a-8847-17b8-72a714d47776@virtuozzo.com>
 <3fe1dd27-7720-2846-2658-e4aadab9a9ff@virtuozzo.com>
 <20201021105612.GB8958@merkur.fritz.box>
From: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Message-ID: <3cfee0dd-f08a-d943-a8bf-bc85a827e6e4@virtuozzo.com>
Date: Thu, 22 Oct 2020 18:54:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20201021105612.GB8958@merkur.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.252.131.121]
X-ClientProxiedBy: AM0PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::47) To HE1PR0802MB2298.eurprd08.prod.outlook.com
 (2603:10a6:3:c4::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.38] (109.252.131.121) by
 AM0PR07CA0034.eurprd07.prod.outlook.com (2603:10a6:208:ac::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.11 via Frontend Transport; Thu, 22 Oct 2020 15:54:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 850f1517-13fb-482a-b566-08d876a2c498
X-MS-TrafficTypeDiagnostic: HE1PR08MB2634:
X-Microsoft-Antispam-PRVS: <HE1PR08MB26341296540538AE89C4B02FA21D0@HE1PR08MB2634.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdJZ/QcDbm9SoNpbmfz0tnEVcaOxRfkUAg2jmbBInAzAi7HUkIb7ZZponUkWI2PlpEORRDJJz1sTLPKDpB0+2HmCQMTinj8oIYSKsOY+vMrJGpS4rtk4B7xdk5DGnXWAgfQi18srjeoYoI6eVvcqE6ycNJEXA71mwxMfuCDuNfTv3XBYNXaeOigemtxCe3IrQ/zs1raT4eRm/TcB+qs/z6qSy3Ea8zbFLN3EH3DIzKTjemPT8glq1DUgYmT+ASsAO4Li2F1JuoSSSeVriJV0GzvZuo7D+HUn6nTvIEEek+kispkTExuGQUGs4ndgG8IHq0yf5fNaUgLdtR57jZqljC571SAJJ0T5uYLeu8G57MSwu+T970YELpX9H/7hH4nz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2298.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(39830400003)(396003)(5660300002)(6486002)(83380400001)(31696002)(86362001)(186003)(956004)(36756003)(31686004)(4326008)(53546011)(16526019)(26005)(66946007)(52116002)(66556008)(66476007)(8936002)(316002)(6916009)(8676002)(478600001)(2906002)(16576012)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uTtmpmxagMry/A9EBeXNX028wgOsTXyeP6tprqpv293lByhGzJICBsTE7v6tvT4GWazQGjreR9+deIqiP7b5rz3xRZWys1zSQARDbbhgfsGeW7X+k5tcMox0upv80Xx9TBH1bHQHru6GmQ6SiwPdPUcOEsCMLjYIMPU8KSB1lZ6KV0tdKvi2UxFGPT0OBcrk4DoKcZEcQnXPisUSaJ/t8s39QLBMWNoaa88cN9Zi/37mZGJWdXHMBo3I/qb9gEUvFMbkdu9sTu5GHgfwMzFYEHDQE4rPbfIufyUc0BKuRKV2ttWnDTG2h+qg4G51hKHYTiraALERmncatemFWr32H7Wd/LgWSONcvYJr0rr2+0PnsChpmFO3mIfp3XgceEp5eUKNdjfPos1gV3i407YF1HXEWJiKVsDpdnRnmV1krrG4GcRDxNa9Oh5lPUaZdQr+W5/S/G5dlJ8y9RMwluQNX3EAdWq1Ekku6al3zqXtCA0bfCGo2FvIKxBmKhqEWhZD5hocd2Xjhv04kktIIf6ns5ZbTOSGF9F2dcWV4PhDK7YevuK17OHuATl6kGP2wXVEZ3yu+ry77hRuuQ4fqSP93FPoHuHyPaiobVo9k/WdF1N0tTZx4PHq9voo7ZyB8EWQEV2NlWhzWIcoTkFWRi2KjQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850f1517-13fb-482a-b566-08d876a2c498
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2298.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 15:54:33.0875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yL1qTARNGVQjcD6fPkjMGJ/B7eeG45HXlAzVhit8Vl20riaRwTnTYCa9KmZxpc2lQkIG9ld6wq3QsJcS+HrIQJo50QP6pe6WhU1K2HulDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2634
Received-SPF: pass client-ip=40.107.5.126;
 envelope-from=nshirokovskiy@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 11:54:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 21.10.2020 13:56, Kevin Wolf wrote:
> Am 20.10.2020 um 12:29 hat Nikolay Shirokovskiy geschrieben:
>>
>>
>> On 20.10.2020 13:23, Nikolay Shirokovskiy wrote:
>>>
>>>
>>> On 20.10.2020 11:50, Kevin Wolf wrote:
>>>> Am 20.10.2020 um 10:21 hat Nikolay Shirokovskiy geschrieben:
>>>>> Hi, all.
>>>>>
>>>>> I recently found a corner case when it is impossible AFAIK to find out valid
>>>>> backing chain after block commit operation. Imagine committing top image. After
>>>>> commit ready state pivot is sent and then mgmt crashed. So far so good. Upon
>>>>> next start mgmt can either check block job status for non-autodissmised job or
>>>>> inspect backing chain to infer was pivot was successful or not in case of older
>>>>> qemu.
>>>>>
>>>>> But imagine after mgmt crash qemu process was destroyed too. In this case there
>>>>> is no option to know now what is valid backing chain. Yeah libvirt starts qemu
>>>>> process with -no-shutdown flags so process is not destroyed in case of shutdown
>>>>> but still process can crash.
>>>>
>>>> I don't think this is a problem.
>>>>
>>>> Between completion of the job and finalising it, both the base node and
>>>> the top node are equivalent. You can access either and you'll always get
>>>> the same data.
>>>>
>>>> So if libvirt didn't save that the job was already completed, it will
>>>> use the old image file, and it's fine. And if libvirt already sent the
>>>> job-finalize command, it will first have saved that the job was
>>>> completed and therefore use the new image, and it's fine, too.
>>>
>>> So finalizing can't fail? Otherwise libvirt can save that job is completed and
>>> graph is changed while is was really wasn't
>>
>> Hmm, it is even not the matter of qemu. Libvirt can save that job is completed
>> and then crash before sending command to finalize to qemu. So after qemu crash
>> and libvirt start libvirt would think that valid backing chain is without
>> top image which is not true.
> 
> Why not? During this time the top and base image are equally valid to be
> used as the active image.
> 
> If QEMU hadn't switched from top to base yet when it crashed, it's still
> no problem if libvirt does the switch when restarting QEMU.
> 

Now it clear. Thanx for explanation.

Nikolay

