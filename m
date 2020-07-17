Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D430C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF10204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P/VPp0Qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF10204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwS99-0004gP-0f
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jwS85-0003Yr-HC; Fri, 17 Jul 2020 11:18:29 -0400
Received: from mail-db8eur05on2092.outbound.protection.outlook.com
 ([40.107.20.92]:5819 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jwS81-0004gm-Ur; Fri, 17 Jul 2020 11:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkXz+OEgLV8ASOfE/beDkBFGGb8Qt1l4iYrfos8e/dhvb075KY8krgmdnek5MLBztjezoTeN7Pj3rpKr1XWyy2GM9hX2giaRFSpdPtDcQ5zM474HdIGOnWd4LzkwivAWTZkAECPKw9Rs98UMEuwJcYdarxnpfJ/q5q56dJ9N0D0gfw/u6+vFOsbeWiBm7xITMXXT19X7lvwicx2xuvaJxI/XYrHysFRZEHhjnie/r9TxaqCODPWA/EHSxCJevoGEHC4slYeLAsYUG1lO3zctHK/OAYcZZAnwQ+7pVGHwxucQrlNpTBhO+12wDMRj01pnhb4zbHHCaefwWB6m4zhnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6RNB4AlNJKhvWNs2lsdlc7OaJ6+cgY3g0awKU/kQvo=;
 b=Fj+bDfu2Or8nkQtl8OI/mdJ2qdDIK4JiUxZ44ug5K0XEmmMNqVPfWtgSC1xHWu/omCxaniex/QMQOMrsamVu7euKtF87EN50r6g6d3ZH4BPqMZUrQ6Em46x66E1boOSptO0+pKLEO4bRuE7+EGgLRhe8gYou3Ro8u2MPyI7ogOydHFSF+ykEP9bAwUcpfPjPBVBXYwSZGsazp4xmcRFxZZMuhWCuOQk03uBPsNCOCoavbr/tMRI2KDcvTYj/OTPZci21yBBRpEXiD6WQcK6yOKJQU4BVaVbcxH5/X6EHdovAlilqbHlfCfSCgu9cHZYsvj3viNGTt5jA/hZ2H8YAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6RNB4AlNJKhvWNs2lsdlc7OaJ6+cgY3g0awKU/kQvo=;
 b=P/VPp0QesAw5TPk2SvvLomdzPXEIgcSmxu2q9OUZpA0jn2d7C+p483CKqzlipuyzlcfoHQQApYByslHcuQIGy7gEnd3RJVKWPg3Wpliv1tBLhs7EaQaDVQTQ44ILelBTCkcrbls3TqELFQZLmcfZWyg7kNHIWkSc8doHm/FNCIA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3894.eurprd08.prod.outlook.com (2603:10a6:20b:90::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 17 Jul
 2020 15:18:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 15:18:22 +0000
Subject: Re: [PATCH v2 03/20] qapi: backup: add x-use-copy-range parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-4-vsementsov@virtuozzo.com>
 <a18ed0cf-cd8a-1600-e821-82a94dd8a7be@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <086babe5-ebb6-495a-6dc7-343f4841b808@virtuozzo.com>
Date: Fri, 17 Jul 2020 18:18:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a18ed0cf-cd8a-1600-e821-82a94dd8a7be@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR10CA0023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend
 Transport; Fri, 17 Jul 2020 15:18:21 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f7a5254-39b7-4533-b836-08d82a64a47e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3894E4E8834A0229CC6F71A3C17C0@AM6PR08MB3894.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYLqtH2pfc+fuV+6bnrczc7BQV3Q627PU2rqt7UiTetxQWk/3nLhgQThEJ3+Q+pX4GR6DkT5Zq7fw+dPlwYRai9vMiuj2wN2lQnfhMLpUXXoJJgcxtULtILwNf45zXeWlHaG9V49cQvow58E/xyZyo6Bam8RBX7aBf+9HwqXwxfqiZtvOc1UiuIH6UmMSWQmmb1NPO7rSMqYlVlvkZrWJZzeeCUa0LF3+yHGSwCzMcVYqJO7KDyQudWykZsPzdB4VGdm3PwA/q/WoQp2tDwCjvLTn0rY0APb7Mye+G7fAF6qghamkCntt4NIBKYMz/NHZjCH3htsMlvPLuNKiz/akPWVJCePP805dKA+6L74nqaO4e2W5PiJWKQrh4bJLF27
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(396003)(376002)(346002)(956004)(31696002)(86362001)(36756003)(5660300002)(31686004)(2906002)(4326008)(66476007)(16576012)(66556008)(316002)(66946007)(107886003)(478600001)(52116002)(53546011)(186003)(26005)(2616005)(16526019)(8676002)(6486002)(8936002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +CYHxZXw5UCdg1Hm1mJg54rn/re/PVruZhIUo/1ur6tPnryDAyRNhby9rjhtP3EWSVd2InJpIfQCYYwQMBqUfS+B3vbY8XX2jiLpXCXlRH+X+NmBbFUVwJ2m5kAAJFjqnc1fNMto8wK4tXcK59lEtTW86AwdpKU2wR7tM0x1NZEFo5vlkZx7bLk0xGxUQcQuY+6jQZhgo15J+dzNNFJd1eMfkD3WXlQX67NpC7rJ5rofN3nr60hFQNpG0RM2zOVpAJaykf0jN/zE7J/TELr0toPquON2G9Kut8tcMqMkF3VP2JrF5eGhmxs1crh8MqvA58yrmhw9ruaVZrPOiWRMkBpJTCRveJ6RIJD/zwWvEjikQycC/Yro+wtjmlOglh8Ux16+/pqhz0qCUcODzpcDzCueDw4ljvJNCk8sbTDIZibDVGFLfJB6hu+peWW0UDY0cO6JHKZOTiQysKDR//yJhsGHn8AWdnLmAyAZLw2wBfagTT2EzRrSjORxclsDpmOt
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7a5254-39b7-4533-b836-08d82a64a47e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 15:18:21.9462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXAl7qBrKxm+l+KaTyVItwNfRBjNUAxxISsw3C2aVhAytTcqZ3TU7lo0PDt2p09Rcau52Vhz5XIBURXQ4dldwWqKJeKkyWejyHuTEveSEig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3894
Received-SPF: pass client-ip=40.107.20.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 11:18:23
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.07.2020 16:15, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> Add parameter to enable/disable copy_range. Keep current default for
>> now (enabled).
> 
> Why x-, though?  I can’t think of a reason why we would have to remove this.

I add some x- arguments in these series:

  1. I'm unsure about default values (still, it can be changed even without x- prefixes as I understand)
  2. Probably all this should be wrapped into common "block-copy" options, to not add same arguments to different block-jobs, when they all (I believe in bright future :) move on block-copy.

So, this series is not about API, but for new backup architecture, and experimental APIs are needed only to experiment with performance and adjust some iotests.

> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block-core.json       | 4 +++-
>>   block/backup-top.h         | 1 +
>>   include/block/block-copy.h | 2 +-
>>   include/block/block_int.h  | 1 +
>>   block/backup-top.c         | 4 +++-
>>   block/backup.c             | 4 +++-
>>   block/block-copy.c         | 4 ++--
>>   block/replication.c        | 1 +
>>   blockdev.c                 | 5 +++++
>>   9 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 6fbacddab2..0c7600e4ec 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1405,6 +1405,8 @@
>>   #                    above node specified by @drive. If this option is not given,
>>   #                    a node name is autogenerated. (Since: 4.2)
>>   #
>> +# @x-use-copy-range: use copy offloading if possible. Default true. (Since 5.1)
> 
> Would it make more sense to invert it to disable-copy-range?  First,
> this would make for a cleaner meaning, because it would allow dropping
> the “if possible” part.  Setting use-copy-range=true would intuitively
> imply to me that I get an error if copy-range cannot be used.  Sure,
> there’s this little “if possible” in the documentation, but it goes
> against my intuition.  disable-copy-range=true is intuitively clear.
> Second, this would give us a default of false, which is marginally nicer.
> 

Reasonable. But we also should consider disabling copy_range by default as I propose.. But yes, if we keep x- for now, and don't change default for copy_range in this series, I can invert it just for readability.

Thanks a lot for reviewing this!

-- 
Best regards,
Vladimir

