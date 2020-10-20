Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283B8C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A562222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LEy7smrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A562222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUovD-0007lq-T9
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nshirokovskiy@virtuozzo.com>)
 id 1kUotx-0006u9-31; Tue, 20 Oct 2020 06:29:57 -0400
Received: from mail-vi1eur05on2094.outbound.protection.outlook.com
 ([40.107.21.94]:54624 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nshirokovskiy@virtuozzo.com>)
 id 1kUotn-0002DS-Lb; Tue, 20 Oct 2020 06:29:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQdsrfOlz3SS0p86t5/xRSm6RezF5iYFDFRFbgdTlDhoXw8hbuLBGIeKoVInhCIuS+vAUV6SlGU6n8abKfsi7dAzb93l6FhBa1NplNgIQx1/X4nhcERjbggwUOGOyJca2M1I8UNDFkdjjKYK9N0uIh1EkjV0x4t90R9lyFm3uTK3XFCI0u+qQUe4Bnkn2kOxgPl6kZKv/bVhsu0Y4Q7yjcDpN+wN+hot1/6Qf/J2mEkq8NFOsM58l/D6V9dysjnW9vuSfKKpD49jTsDzldxACRpkv3Ziqcn33MSqGT86boCmwo6xPl3ixc9/TtekcmAJGjgDNlpUBUah+4J/m7iSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+HdiLoW/MGeezO/KSfACeG1U2a44cdxS//5YenFK5Y=;
 b=dcg/kmjvmwgZewoUgKQAoroD4AUAIHsy1VZ3cjqbtgPo3tMZJdjglfojboznOwPF8QJFOLFbkAndMSSBcAYPnhkkOSYRoCbhEHWdshgna8BnnD18ZWRKQXD4YGw158w385MlQAVsEvGNgJ0xV6FSdKiEGusqO+399nn3dMAlrqaFblpGJ3kc+VgrEaQDDcxoGIEEZYomTuKPWLeK0PE5/6EY07LB94viP9TGKTZa3qbVbaDIl+r3m/Y7UDbza/HgEaOiT0RKwQxQOcDTeJC9ePTnuRgC1GLDTosfw9fSUUcutI2zJSPatxdDiusapZXzgN2fmARXjM2+ArIvxZ/AXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+HdiLoW/MGeezO/KSfACeG1U2a44cdxS//5YenFK5Y=;
 b=LEy7smrfR67WWJjNAWzbEe5HvkwWHd5MNvHKFjVGL1DTzgeH9r0wTVIg4rod85lqQUnKahoYHhiIo1/HndnxSR9p60zEFY5z0cSHODN+y4lwCM+ea1OXDcOfm9dGiLqFWmP60hrMrFRoTQ709IOQW+HFMb8JmNwz07TyeQE6n+k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2298.eurprd08.prod.outlook.com (2603:10a6:3:c4::16)
 by HE1PR08MB2937.eurprd08.prod.outlook.com (2603:10a6:7:2d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 10:29:42 +0000
Received: from HE1PR0802MB2298.eurprd08.prod.outlook.com
 ([fe80::d12a:7bcb:c813:55c1]) by HE1PR0802MB2298.eurprd08.prod.outlook.com
 ([fe80::d12a:7bcb:c813:55c1%10]) with mapi id 15.20.3477.028; Tue, 20 Oct
 2020 10:29:42 +0000
Subject: Re: RFC: tracking valid backing chain issue
From: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <3b99657c-2016-78cb-4314-27aacb30ca3c@virtuozzo.com>
 <20201020085029.GC4452@merkur.fritz.box>
 <a996a3cc-387a-8847-17b8-72a714d47776@virtuozzo.com>
Message-ID: <3fe1dd27-7720-2846-2658-e4aadab9a9ff@virtuozzo.com>
Date: Tue, 20 Oct 2020 13:29:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <a996a3cc-387a-8847-17b8-72a714d47776@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.252.131.121]
X-ClientProxiedBy: AM0PR06CA0134.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::39) To HE1PR0802MB2298.eurprd08.prod.outlook.com
 (2603:10a6:3:c4::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.38] (109.252.131.121) by
 AM0PR06CA0134.eurprd06.prod.outlook.com (2603:10a6:208:ab::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 10:29:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cd29b6d-40fb-40d5-faa1-08d874e30e5c
X-MS-TrafficTypeDiagnostic: HE1PR08MB2937:
X-Microsoft-Antispam-PRVS: <HE1PR08MB29374CC58617AC56ED165B9BA21F0@HE1PR08MB2937.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2D8NQay7ib61zCynHCGyUDolvm5Y5psLsgaHJmfWlIAseSVaWm998mD0hUgdc3X0ad/DHHUUHGiYXlieXsE1acSsxyFz+dWtqb16nfObXbHiOmqZ1eSn5j+s2C0LHcqsV4VtctCoPclVXm2T6DeowSPW5p92hEiTHdP/GCt9J8rZl4JeqWuWyuBGuZMYBuJsXTD52V97iEHEQpLH3wmx+P1p5+u2qY2WyeWQA14PXOZXgQ1rTVIhsnWTtVseP0OoX8V0UrWF5FvQIozkog0rCjnkLDHRnqRsMsV/o8/ePBBy7LnH6nQ9B88zm7H+GZFKCgKfyhg176EUmqHPnswY9q/Qsp1foOKbUWo1G/87Co2RySYVmEWyRTKPwEsminvB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2298.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(5660300002)(16576012)(2906002)(31686004)(6486002)(956004)(2616005)(86362001)(66476007)(4326008)(8936002)(8676002)(66946007)(66556008)(36756003)(186003)(26005)(52116002)(6916009)(16526019)(478600001)(53546011)(316002)(31696002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pCdubQP/ECRdYHHXgyNFKr8pWlKjyrsWdKIS02RUGV1mQRi1kS3AlHx2hkU46m/IP2KlLtLYVe6tBQ+6Wj45oJMkoQUEwDux3jhO7IBwrfj3xztpivLVN3LwL3J2ETZb6h/wJDcFEfMssCuzehvX/dc0RZfRHZxAXMbhaIlJ7+MZiNXB2/m6tAjFqC1UB1/kaswpZkzxRw2B06vyocm33M3YTdxtQEvTZM96jVfOVBDLEMN6ulPKuR7BpRkOl4INbdiIByaTW4U7Nbi1ZBpGGvFh9Kz/BcRYDBIAKXAcuaqk5ZbHI9xw58QP9+6UimY8ftCyL5VKWYdp5//sPXhzzUKdfRZR+uRZmxniETe7x/3Zbl/859a8hpeBFMSKtaxjfzZuzfckZyLsWGtLqz4ehgDfDsUmHO4TCAjidt7/pU57S27P5O91KvVqxE2X4Poon0mMfkZ85MS2ra6/2FOYHpF8zv3SRBf3vsgZB8+rP0Zu5IpHhzAJUzC0lWU/JTIBSxaAnE00Wyx2IPtB6n5iR0s3xNvmPJ/85jicAhcunTnUz7SekkYMkjOM9G1DGHwc2gbVfdvkvZ5bUUeUcCQ6r996NIFv5vD0I4LNF/+HUTGNy5k5+pUjUZAFbVRS5xnUCVZY6wFYiw4ZYLSZzYNZhg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd29b6d-40fb-40d5-faa1-08d874e30e5c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2298.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 10:29:42.2546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT3efigEOV1VvmyXgiw0omcyLPUNpI3QBsGoApUOORRaumPSl5INRiLAkSK814KBpscYdWsgCx14jzsImg5O7ZzD1q+6i/RomX7bcQxmO10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2937
Received-SPF: pass client-ip=40.107.21.94;
 envelope-from=nshirokovskiy@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 06:29:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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



On 20.10.2020 13:23, Nikolay Shirokovskiy wrote:
> 
> 
> On 20.10.2020 11:50, Kevin Wolf wrote:
>> Am 20.10.2020 um 10:21 hat Nikolay Shirokovskiy geschrieben:
>>> Hi, all.
>>>
>>> I recently found a corner case when it is impossible AFAIK to find out valid
>>> backing chain after block commit operation. Imagine committing top image. After
>>> commit ready state pivot is sent and then mgmt crashed. So far so good. Upon
>>> next start mgmt can either check block job status for non-autodissmised job or
>>> inspect backing chain to infer was pivot was successful or not in case of older
>>> qemu.
>>>
>>> But imagine after mgmt crash qemu process was destroyed too. In this case there
>>> is no option to know now what is valid backing chain. Yeah libvirt starts qemu
>>> process with -no-shutdown flags so process is not destroyed in case of shutdown
>>> but still process can crash.
>>
>> I don't think this is a problem.
>>
>> Between completion of the job and finalising it, both the base node and
>> the top node are equivalent. You can access either and you'll always get
>> the same data.
>>
>> So if libvirt didn't save that the job was already completed, it will
>> use the old image file, and it's fine. And if libvirt already sent the
>> job-finalize command, it will first have saved that the job was
>> completed and therefore use the new image, and it's fine, too.
> 
> So finalizing can't fail? Otherwise libvirt can save that job is completed and
> graph is changed while is was really wasn't
> 

Hmm, it is even not the matter of qemu. Libvirt can save that job is completed
and then crash before sending command to finalize to qemu. So after qemu crash
and libvirt start libvirt would think that valid backing chain is without
top image which is not true.

>>
>> Kevin
>>
>>> So corner case is very rare. Mgmt crash in a specific short moment and then
>>> qemu crash before mgmt is up again.
>>>
>>> I guess some 'invalidated' flag for image would help. And also qemu itself
>>> could check that mgmt is not trying to run on invalid backing chain based
>>> on this flag.
>>>
>>> Nikolay
>>>
>>

