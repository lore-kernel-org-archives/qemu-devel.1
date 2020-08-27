Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEDAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EC52080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EXMRiFhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EC52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBE4i-0000PU-Ly
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kBE43-0007vo-FW; Thu, 27 Aug 2020 05:19:23 -0400
Received: from mail-eopbgr130124.outbound.protection.outlook.com
 ([40.107.13.124]:38612 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kBE40-0002oh-5y; Thu, 27 Aug 2020 05:19:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnzU6fodLEW5GwONxENvSJYT+OAP5/ndblt2IOWdOWubYmuuyX+hYxitCWidxOOmJ4T3YK3wgzl5fItm5X5Rg49UjTKyu1+bgDzw0wpR2JqkEYEuszKu4xBmExeSBg4x5FCFEKNXONHu436/b/d9JtfdOYM05q7TIbaA2BTFBUoOE0L+ONv0mYE9TMpshhquUeMFk67xpLtedCwIEcx0DtPHAQY3TkDb0gfd/dK3C4jXwBtyKiU9Hn34CaeLQp1TtLq2CwvpdjVXYBWJKSS1wSwyP94g/Njy6SVt9mS7qDVrbfKxKx7dZWDw12qlqHqQhnkKRyBxk1Ly5hjsHPsoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK9hAnE5AcVdZ68RkaesMIsyg0PxoHHx3e1r/bkdWx4=;
 b=PBytvYarjgIL0zObl92OQG3MuJZT+Y3b/hxub1Tr+zgQSCvgiainklqKvVDmwQIcxmEC6MIItfK5gcvWNZhh1wCdaueMpQEl8C5W2Ch65Q44FYc1cWrT1Z2Rbf0BmtEuEIPOqR4YF6DIQjQIDLmIXa/sNn21kMh22xVdwqtaV4swJKv2yBI0U2DbVU8r5hXUqBxILA3G9dqC8thIYjf2uhrk6JgV95H2Niah/mqiwNprXy7LWTElaXJ/et+Y/cR5Z+0/rby570Y/DdFMdohEGsFgkorcVPGqyWgOqNK1OnkMawNlGltm+vci7HKx+XLxHg/9HuEDkbc3ysSpAVbu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK9hAnE5AcVdZ68RkaesMIsyg0PxoHHx3e1r/bkdWx4=;
 b=EXMRiFhYtJWNHS0u07r5/lG1lTxfqTfmtkX3TxB1g6JYjlrg7lM9XqJbxrC+eCfoVL3n/1Gr2wDbUz7TXzABpxv4dT7FSIkLap9U51V+v6NZRZuaQ46MxYRdQ6CMrQzV+d74mV2/D3bmwdzh2uY/l/3kLvP6KjeBl6Xqy3XlBYQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1650.eurprd08.prod.outlook.com (2603:10a6:203:2f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 09:19:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%9]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 09:19:15 +0000
Subject: Re: [PATCH v5 07/10] block: introduce preallocate filter
To: David Edmondson <dme@dme.org>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-8-vsementsov@virtuozzo.com>
 <9d22c3be-df5f-0bd1-0634-6217889670ec@redhat.com> <m2o8mxjz0q.fsf@dme.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a53e1a1f-0589-fd9c-e039-1ac1b3a68b7b@virtuozzo.com>
Date: Thu, 27 Aug 2020 12:19:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <m2o8mxjz0q.fsf@dme.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR08CA0030.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR08CA0030.eurprd08.prod.outlook.com (2603:10a6:208:d2::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 09:19:14 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 779bf4ef-d6a9-43a6-5241-08d84a6a44c8
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1650:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB165091C0FF1791EE4F95A78AC1550@AM5PR0801MB1650.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJYUtyMwYi6nHu1Doeg8/Hz3hLkx7Nsahuxtw/bt5d+EmNZl1yAUwL0lg/m3pEEMRDKiu1LTeYa9w5J/kc2nwy8EyXLRFWg8KMtIETGIidgd0FJt6OhsSZpJhnti38QNdwYy8QEMZKe2RVQmcmSlfrb86DgkuBXR4ggK5vaBT+sBzXuc6sUzqv0tnPFQrO9lt1vLukB8M2FQJ/el5jLqH+OMCbt2W65t/58ZRfxtXODDopVGpb64VpfBf6r7GGYCAjc1GTJB6EnsCvgB7eMayQAq4LKSHJNLRou6MfZZTLDjKrqwymqwTKWW8knre11Ks0lWnM3EjxF3PS36Tp1yd35VxshrVGO0zM45c+NLurbZmre05wAOGhKejV2/h/Tp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39840400004)(8936002)(8676002)(2616005)(36756003)(66476007)(956004)(66946007)(31696002)(66556008)(6486002)(478600001)(186003)(5660300002)(107886003)(52116002)(16526019)(2906002)(316002)(31686004)(86362001)(16576012)(4326008)(26005)(4744005)(110136005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EOW/6gmAzZWGMKkL1l4k6i8NDeUsepB4AraMacdfqUqv0QGK+UcToKexxqworMp9hQQKswXWRaOg0dTjNTXNsLvHA79N0VxzS5ksI2sj9B+Kyexz5D3SE9G26XDThDQi2nziADt9tPh0tpKNUCUg9DOKVTVA0Vut28Az2w1lNysxj8yqgqlCYcspF4yBMsFzAs0gCoZDD7El7hDv2YSGb1wV7N7Iwdr+vBZ/pVV0DG6PlfbR2Y4YJKQSJRP36hamlUlYWUm3RKTeelvTr9SXDycc1Iu6c3UqsrLh7nsP14pfWjTYk2pPjxkEnL3tKHjxS/qmALau1ATNmH1hfK971j4hX9XD4eEKzAgeA5rEWypGonhtUKqZet9UPtrWKvsV9QrA6Vc+x4O9nep5RjTrkxYTSNrmvVgm7/tiTQ8I8xgeRt24kyuQn4pBSoECZ+2xzKKGAuaMxS6k7bxHbVOoRz6pU5qpTF3kg2JRbhpKY5ce81pvBgPteAROtRXNwZiLvEWEEJU6UhuinXx3VFOWsFsFvtLsCbLXDUWImDOyPtpHcVcua3S9uQ2QjEH0GE/QkR2ce7wz1TfNwr6lNCy8A5D19Xpt3NUq09sp5UzkWWxqsUeVrUC+PrI1CVFuYWC+tKyNwIcFKOa5joBuPQetKg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779bf4ef-d6a9-43a6-5241-08d84a6a44c8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 09:19:15.6053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvfXGJv0dXHgt09hP+RRKQpZdpsRsrRiLz/sKg5MQEl7choGdnpsIYK9cApkkxTEVTTsfTjgDFy9QFAY3rJ1IAhwPemUUoHqGTzwWiF6d4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1650
Received-SPF: pass client-ip=40.107.13.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 05:19:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001,
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

26.08.2020 16:51, David Edmondson wrote:
>>> +  file-systems with slow allocation.
>>> +
>>> +  Supported options:
>>> +
>>> +  .. program:: preallocate
>>> +  .. option:: prealloc-align
>>> +
>>> +    On preallocation, align file length to this number, default 1M.
>> *the file length
>>
>> As for “number”...  Well, it is a number.  But “value” might fit better.
>>   Or “length (in bytes)”?
> Isn't it really:
> 
> "On preallocation, ensure that the file length is aligned to a multiple
> of this value, default 1M."
> 

Sounds good, thanks!


-- 
Best regards,
Vladimir

