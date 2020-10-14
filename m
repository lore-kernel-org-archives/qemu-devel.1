Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D5DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6367F2222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ko6L+2ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6367F2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiyt-0006sZ-DA
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSiwk-0005Wr-3Z; Wed, 14 Oct 2020 11:44:10 -0400
Received: from mail-eopbgr70121.outbound.protection.outlook.com
 ([40.107.7.121]:23364 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSiwd-0007U7-D8; Wed, 14 Oct 2020 11:44:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL4Aoa10c1AK/h/FWapuDgeeixqcp6ZZzV4Xnv/TlR9FQyEEL69cK1hSy/l4EOHlpbPEUX/B7JkBHGzdVncGMtOiVt4p5z6eaTHrLuV3kw4FiMqpw5g8m62F2lDOzBoxyGqmXjurJ7/yRd7B2huG2Ah/4V4h1HXDlEGzo0rYTgN8tkQh+D459hJVMMA+zt51vFboE6DPOTu6pJapVD0UdUuUWNGrVA/f0wF8m87n312dsUDbgyt3aJJ005eaRHT8KKgaT7hFKPvffPHj9Ly7qYXD0eq9j1ufnAVxZERfflnE53eJxFkyMSBBtMCKubHvAa6nXV2wUmNkO4PTawhWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUxDdmUCMXFa8yipkTMpvu9SRBGO2pNy00P52aw6NZQ=;
 b=CuG/afKk5M500gFyyQfrN8ttgEUNt6zDs1Y8SLIQNlqz6S4rQOtSlzTdLnV58rB9SFR3joBDFbwThDUxnavXth4rvhJCEyZA3tohtYYFfX5KqRf9f9cs4k8vTMRHJmMnBCnmrHqSww9lKQq7etEawG8lHC2K02x4eF38gMH/p34T5MJcHE1TwfrJPU0amFuuO0t0xYXUwr3hPQ2k8suNNd9AmCT+KE2HEggoSaGeHKvwsghAZ81DOugkUtwI0qy17fh8+MzOohdzTMlcf3JLsHKdoQK1Y+Y6Jjtne9q9HlA/h6NSMNjb8ndTdLbZbV68CGq7+YIgm+x+MmZOnjI5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUxDdmUCMXFa8yipkTMpvu9SRBGO2pNy00P52aw6NZQ=;
 b=ko6L+2ESHtp7os6oV+Nd7eCvIZPTfvmpWSjMwhWXAq/UgopJJu/LUQTuAkSKtTyzsPRsoCG+pmY2hZj6MXVw1AXgquE4SgFqFn0Gem/FpvfnNs7O+GORU5crjg/Cag3FaYYADepONiTNWhz/9MCRi+0cyMv7bBQSp5IfZli5iYs=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1651.eurprd08.prod.outlook.com (2603:10a6:203:39::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 15:44:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 15:44:00 +0000
Subject: Re: [PATCH v11 11/13] stream: mark backing-file argument as deprecated
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-12-git-send-email-andrey.shinkevich@virtuozzo.com>
 <c309607e-d6a0-7a7f-05e6-9e1beb388419@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f8d6f6e3-f6eb-4ffa-1a2f-624c06462bbb@virtuozzo.com>
Date: Wed, 14 Oct 2020 18:43:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <c309607e-d6a0-7a7f-05e6-9e1beb388419@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM0PR06CA0089.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM0PR06CA0089.eurprd06.prod.outlook.com (2603:10a6:208:fa::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 15:43:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a994d43f-ae18-4b8e-f310-08d87057f82a
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1651:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1651F2B56C83D068CE3F84C3C1050@AM5PR0801MB1651.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMQXdFZyiTiH6RKA/Rq3vOboV0DYmyAfzWHKMbMOWFUS1p+A7h8gvxE8W0hXfI84BZciEi92AQDcpETWvl9IrQELoGPcqr22klQTKtoYLvH9ToL2Oxu34MOJHKWENjetBJlbYx2TL0zeHgMdDsan4aLFcO/1Jf6+Q8kJBTIWzs8/pM1saSQNkVJfKww29p16pB5MPwMxIsJ89rH9H6zdUQNQqaZID0OeQoUA1QIIwFaGMpZsKdqU+aVRibg7qXbXbtGe9rp0j4OuP0ecGYNkarRMCxyLvLAiIz+Uo2+KQ5D6o+R+Dgv7MeNgK1yXF0LFyIZF5tl1yt44DL5Y2ZfqXHEKLdrtAL62heA+GlhDNCMPs0WdD092nuBhYRv9SPx3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39830400003)(376002)(136003)(366004)(16526019)(4326008)(6486002)(107886003)(31696002)(478600001)(16576012)(31686004)(186003)(8676002)(2906002)(36756003)(110136005)(26005)(5660300002)(66946007)(86362001)(2616005)(53546011)(956004)(316002)(8936002)(52116002)(66556008)(66476007)(7416002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cdlrXmmb2p3wg/MXwuxKurRX644Q4k74fjR1LNkvykpK8FxRh+7aOnNXVtVYMvGE4i7X779sMbhaTPmYxDeKLGspzHLTFAnYdiTlCKq9bIeXBs8zLIa4+zDVHNV9oBb148VmmoIUgno1g7D5gLk3FkLgH8zOOOrIdnYxcqza88KXUvs7HHhCxX86tAV67XLs4BadEKWswb0vYUEfgeUkvUApNPtBrNiYf7UfY/5pBF23GK9ICojYJ3XLn6M3MpkhdfVxGPz/AdMUvLQrgNr2tvcf3onAvzalCU/+yF8C2lEGt90y54x/KEA2EGOsgUB0GCQF96C7Ls+Y/9qMQJnxg9RD3GBiMoYsDIAT8iSnf/qN26RGOj6pMCl8QeiFAmo2ianZxXtUCUSlmg33WjV8KwUJzn5eH4A/WCZtg6VaSi7cCmMvOcVVpjgBeMupKMNNd2gzZ9Ne0Foj0x5jv/zsC0CqFg7/YxZC+GPHe8iqtV13HtD/OZE0JrlUX/025KwLPlnhJW6fm/QMLQxrHAY1gvBSATm+8TTNAMlnyzANQxOqw6zUqEtyeBprLeYWFR/ozThV3edr0jlkR6NOOnPgkf4xyi9909PH0xbkdBKG/OT0KFgVzSRuK2lxzp2jRRycKJ6wBSVooUt05VsMUpUCjA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a994d43f-ae18-4b8e-f310-08d87057f82a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 15:44:00.2568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf9CGHUhyabnWBoADQ2HbfAXW7pdQ6P5cP2qhidFUVb/IGuGFTKqhhqnnCBxc6mqHNd/oeCMrJKqchBPJYnKFva/nSkWGKueZ7IOLD/Zyes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1651
Received-SPF: pass client-ip=40.107.7.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 11:44:01
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

14.10.2020 18:03, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> Whereas the block-stream job starts using a backing file name of the
>> base node overlay after the block-stream job completes, mark the QMP
>> 'backing-file' argument as deprecated.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   docs/system/deprecated.rst | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
>> index 8b3ab5b..7491fcf 100644
>> --- a/docs/system/deprecated.rst
>> +++ b/docs/system/deprecated.rst
>> @@ -285,6 +285,12 @@ details.
>>   The ``query-events`` command has been superseded by the more powerful
>>   and accurate ``query-qmp-schema`` command.
>>   
>> +``block-stream`` argument ``backing-file`` (since 5.2)
>> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The argument ``backing-file`` is deprecated. QEMU uses a backing file
>> +name of the base node overlay after the block-stream job completes.
>> +
> 
> Hm, why?  I don’t see the problem with it.
> 

My wrong idea, sorry. I believed that the argument is unused when I were reviewing v10. But it actually become unused during the series and it is wrong.

-- 
Best regards,
Vladimir

