Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CA1C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516D120684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SibG1+S4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516D120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECIs-00030B-Hs
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kECHD-0001fo-8m; Fri, 04 Sep 2020 10:01:15 -0400
Received: from mail-vi1eur05on2099.outbound.protection.outlook.com
 ([40.107.21.99]:52091 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kECH6-0000Mq-1P; Fri, 04 Sep 2020 10:01:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM3X/X3pTQ0QsO+nvEegeUdwv7aXIngC/69eWDK9Hcgrbu0KSzD2R1vft6Ow52+D0dm4k9ns6hn7ZCkatYswchUgq+uQcSp8JzoHupwHWGjzb15AzYwtbAlUiKmzCPTh3GtttUzOLGluyZzJfkJ+4xsOjW3WDbzR92UQ7Hz+2fefnfHfM4sRr7dqaLfvd6zhKlvI6ArnD5in9mp8yw3a+iKbreIrHcB9Sp1Ot2j3DCQZkbTurpagB3t77D3ynxlF97N80GvEwVlXpxLjotUVhnDK7wh016KPY/UcH2zMZ2NtT5VgSJgcjsTT4S1S7QvvEvDjsx0z606VDV8XFod/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN0N9SzHT+TRl0GRQ7pAZQCuwbfo2MZF7goVDbOGJBs=;
 b=Pevw97iJnVBrQtyxbSHOzQEHAtB40ivqwx9JHfvHijxQh7K4qzHDdXtuINND5dF9WXmbeRbCzd0YCSuRlMQd1AJrMTGH6J7+WlJ9B3eBJ+bxuZKhwJb8++RsNSp7Y5XXPo0sL19DvXjSUdAl5V92Cbt1UJaKAI5hX/XBzgd61/BFyXHCAgrTRoDmQfQWZTYopVAWqbc4nAmF/BHnHAVz5v7pztUL0VoF7cLDYGeMoI2c9VBUhwgKwUG1eIifTvCz6ucrsEpVce/M8Aq02m8l6kKH6UOtV9y7gSNFC/9LTZSTYSThQhDRCUPQ8YPYyA5hgKay9ADElNm3BaTwNqrFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN0N9SzHT+TRl0GRQ7pAZQCuwbfo2MZF7goVDbOGJBs=;
 b=SibG1+S43pMj8ORl+hmNR5HbtgkxpVlBd80sruR/BP2fAB1nNOLtll+TxbMRmhpT3BaXNogr0KHOnSPGe/7CxXcY5xW+C5HFbPtHwUzX+CSzje2LyR3U6UtI7F5uYI+W360HN+xb3KRLRCjGLQulmjD8NTRHSP9PG6FAYypH6lo=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4022.eurprd08.prod.outlook.com (2603:10a6:20b:b0::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Fri, 4 Sep
 2020 14:01:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.017; Fri, 4 Sep 2020
 14:01:04 +0000
Subject: Re: [PATCH 0/4] nbd reconnect new fixes
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <159922648029.11986.8450274273047302750@66eaa9a8a123>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2374528a-372e-919b-67ff-7d091ddfb357@virtuozzo.com>
Date: Fri, 4 Sep 2020 17:01:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <159922648029.11986.8450274273047302750@66eaa9a8a123>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0130.eurprd04.prod.outlook.com (2603:10a6:207::14)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.143) by
 AM3PR04CA0130.eurprd04.prod.outlook.com (2603:10a6:207::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.16 via Frontend Transport; Fri, 4 Sep 2020 14:01:03 +0000
X-Originating-IP: [185.215.60.143]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaabd662-e312-4bb1-a960-08d850daf698
X-MS-TrafficTypeDiagnostic: AM6PR08MB4022:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB40223A6703C63D2FAEB706D3C12D0@AM6PR08MB4022.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QJ6U4pKmBQ+KaliUQD4SS2QT6HKZoEsw6dhLHO1R8Cu0/+aAln62tOfJJcq/8IoXxGWB0SjP4o3eVg6QWsX7O6Y1GwV/C5U8Y0q4R3Vl86yOR/WFddoXgBOQsS0cY7WMMUJSmQqan9/9rmASV3WN+I9jatpPtqyFsgdogg+16KJk/rcVG1/dPEMdYTiRwzfClbs2V4OtoxUqYvRmSqRG949i1Poo2utaPqjojd4V8cp7qZT6oWzaO6TcZyGJaAlN/eUkclpvUjiSHqi1U5u1p49FqenuRynAWJ57oSnPwmKr7eUR3pwZzl5BVIPYRZ6Beah/hg2tR86XPcuALKx9V+ruzXfMjfd9ws9P2NylHEBewE6MkCItnZ33affOhzsY0KjnREfncVlfFVBMdL+ArVfAmr79RGukzlHRzBrP9VTXFtoCkzOSgDOr/sWOkl4MkCfvgyP+YxVMBnfkmOISw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39850400004)(396003)(366004)(136003)(26005)(16576012)(36756003)(52116002)(6486002)(478600001)(83380400001)(66556008)(2616005)(956004)(66946007)(66476007)(8676002)(316002)(4744005)(2906002)(16526019)(966005)(31686004)(186003)(4326008)(107886003)(6916009)(31696002)(5660300002)(86362001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: GGANYNNif0SsG1qHHXazhJvBDEQ2Qocv7sogYKK76DbsSFaNdQYacf8NfsE6bocswoRqOfe8UYUSDG0MTrd6S+zUGgkHLxNHDJjNCJzode/hdm9PJIi/TP++trS0Pbdja2+ah99YjDqMgG2uGQyGOgAKD/g+cYm9TR/Gf82A/hkyIJWXtBkB5m5JMpe1y6V71vGDJehqqNZEjqlcFDDp3IShB8HpfPxpkL/xFodRPnjHhVzpuQ04RDL6Bf+XdhPkTE01QA1H99QVtdFXo4twQyxPY42fMffkBWOaChyaWEr+6yBEW1HTMs0Bw/JaNCHDhb5izcHzV6VRhog8tcN0wW6oT2yeHlj9PqCfZt8KnrGMrIU5idBA6928j5CO956XeFLb5iiweAlDsH9rV3ZirnS6CBG349Zk3oXTyxXA+GCvu4qLl3wfnsWa3q/jr6HvErgEyUB2RCkIlsbbnHFO2w45ZvPynvT+YMB2pAyYq11fXYLZZ/Yv2uu6bPayZvtausMYkb5xFPjuAFC6L0P095NFcoCQTVgnYO00IEaIPBh5jUzbdCo7zsn5nzYrl3T/PeC9QYofhLlon8jUPIye9gE7BFNeofP/0zhothfQ6rHwk0Kdh7GSdm2mOWkMFglHxqaylEaN8u53bJWFgG12fg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaabd662-e312-4bb1-a960-08d850daf698
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 14:01:04.4432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5GEQvSaW+YAoyKVPC5ZgSJsz77jqBZjNoCNVci9L9m90DNNOBzZrOg87nPtNzMI1jiR5foSe5iyr92GD8soE7WyBzuriHgEItQfzMKqOKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4022
Received-SPF: pass client-ip=40.107.21.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:01:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_LOW=-0.7,
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

04.09.2020 16:34, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200903190301.367620-1-vsementsov@virtuozzo.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> 
> 
> 
> 
> 
> The full log is available at
> http://patchew.org/logs/20200903190301.367620-1-vsementsov@virtuozzo.com/testing.docker-mingw@fedora/?type=message.


bad link. it shows:

N/A. Internal error while reading log file

> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 


-- 
Best regards,
Vladimir

