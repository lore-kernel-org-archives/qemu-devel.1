Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB12FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F44B2073E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FpCCWTmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F44B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhSpy-0007zN-6j
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 03:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhSoP-0007TZ-Lq; Sat, 06 Jun 2020 03:00:13 -0400
Received: from mail-eopbgr40139.outbound.protection.outlook.com
 ([40.107.4.139]:47726 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhSoM-0005Qs-VV; Sat, 06 Jun 2020 03:00:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pq9LvhrBWLBwD9wbPM5JStJI7YuevCAWwmVHgFi/wpJ189o5S9v7ZozoqSz989Qdhn5QoPyUKeOumjnSRmbNYlRZHZJl0ZEtqySPXAs1QyZZXYHR3UNrD3Tg7gUbW6TeoOEfaI4dA8DGi9FoLf5k01MzvUDfqLytKFao8T0pNPwh4GHSSpmKZCHVG4AU7CNKcIkBhzS8XlbNRrncwC03Ak7JtDUwTRgAuAXH8A8+JnOVOS67Ia5fBslnAT5SBRO7/rR25ifYZo1SRdxc1oQdlVZ9a9vXxPZDSi/KbRkXG4rkb7UmdNqp2/YxcjHgTRp+f9WLSY/N57scmBYW9BMutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61qGJh+BFrUlBmGhkjIaXilnXQZD/8G3tAXQkkhxl9w=;
 b=FEbJujOOJS360iAGW9ss6m1ksjTvMpSnZq7frrvvbTJgs1rnEf1T5onUX9bzgTXhSxY1F0dVT+8z36MqH8IQ6N3BdNI418lsge9Z9lGX5qYqrM1FCa0tvxTLSr9HZ0Ru9KU3FGXPZU7hobkH6yGPRUMjbTBt+yhKj+TUSAxvhVQ5CrEuGYyJ7jQ5XhvB5MCD9jda9r8hrCNegKQGyd7Fkk7odEaw9pKbPrlRXZ+Hyr890ZBctEL+0/mJM2Wc+kRmcjhabv4pK4dwdFBKEjaf6SX03jb6PIMPlLTe4W2I0x4ePsosLY45CsImVGkXyYgFbYsvlCa5AWPncapcpuPWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61qGJh+BFrUlBmGhkjIaXilnXQZD/8G3tAXQkkhxl9w=;
 b=FpCCWTmoQhppocRnYBMsWch8v8TjNvTMQ+G5bEMqTlaOV8M5QsUjs9JK3kjuZxd8fatQoz77bw2QEb7nbMVtO2bXxZSpD/aJixlKMozlM4z4g4smOSWc2n95KCaTdv9wxNqKp+hLtj03t9qJxRaITBisobVBNvNO1pJb47PFrtY=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 07:00:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 07:00:08 +0000
Subject: Re: [PATCH v4 01/12] qcow2.py: python style fixes
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
 <20200604174135.11042-2-vsementsov@virtuozzo.com>
 <7b0ae96a-e52f-d75d-cd17-e681258874b7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <db94f789-4cd1-623e-b17b-791b84dccd1d@virtuozzo.com>
Date: Sat, 6 Jun 2020 10:00:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <7b0ae96a-e52f-d75d-cd17-e681258874b7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0073.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.130) by
 AM0PR10CA0073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 07:00:07 +0000
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf2a8bb2-ce69-4192-e88d-08d809e73f9b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5526C6B9B327FE9C1F52A6EBC1870@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lELfwh0hiwlJk+DngcTDwKQtelmykCOOCZCjLbrY/eVXUFtyMIQa/aIYeylPK60Ki9Oma8+lI3m55p7DrNymRpJ7G+Qr+lkYZ6q0XU5dYMMZEY7lUVYy3RtKxjqhuX5o66zDpnPhhJNUE7t76wPnCkVKt8P8j5RLP+5casCHGcZPEngIuk1paWtS/Y92rEmbHknOLW9SL0QI1Lz/AEnMwwDf/jl1bXolpAQEjvStRUN0l9TJlNp7ODabIvrAS4A9/nhNWbUg8k0YRroJyhq5qAHS4mJtxsLiIqWfjtKGBUOA5JaMV/1COp4W+FVa9SfSbDNQthNZDb0EnHhMjn+uYr2J50ziiNIItUXt/0GviERpuni6udk0O+KivXhjiqJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39830400003)(396003)(346002)(376002)(136003)(366004)(316002)(86362001)(2616005)(956004)(16576012)(26005)(83380400001)(5660300002)(478600001)(16526019)(8936002)(186003)(8676002)(52116002)(53546011)(31686004)(66946007)(66556008)(66476007)(6486002)(107886003)(36756003)(4326008)(31696002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: e4B6qd0iep0a42Pp44hVkseeCfljjULGMzYbsgPCtWSYwzVH8tb+WA1dprwsAUcvAUbVqYjh+7VJ2mYHNOMOlrfIfLfYSOuIrc1FZQ7CY1cdzssxNTrB7X2bnaS/MKJy00MWapAh5Xe0L1ezSZH5L1f6yuR8rLwYoJWR9EkGoZ3itLDZHj9ZkdoBpcLpCk4Y2860G+lTT/fy4O2gmOC6lSVOdU3Ca66em9x1AHS886ahiLdg3x3HwloVkkaZ5lQHq6JpGZThQt3Jh1XnUfXpDnRZXg/5bTajeOiAIuxcawyhH1M0sgcv81O+IifNv/138MMukM40wePTazKbi/1UeKT/oX47TPLNEvMH3D/8BlmmSK2lb2BzkJi4WKdBaPkzHH9qlceT/NGrXAd0m/GWUFQy5c9QY1UdcU0RRGX2NdFwNUcuHNol5lDhyifrLsUvsk5YpxJmNIPrFnpmmItV9btZ5ifp/jBiqIUQJRwKKb3ppiccjJzg1vVpEFIffJ22
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2a8bb2-ce69-4192-e88d-08d809e73f9b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 07:00:08.3477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMsv/F9uQzpbrm0XglLQDFjPlkZLK/5rGSI/TPKsTFQAj6ZmNPzFxBrbq4Wde3ctCEWnrOWSjXMrgxVH9oahGRfPvFw0Adzs367ZSWguUpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
Received-SPF: pass client-ip=40.107.4.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 03:00:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

05.06.2020 22:43, Eric Blake wrote:
> On 6/4/20 12:41 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Fix flake8 complains. Leave the only chunk of lines over 79 characters:
> 
> complaints
> 
>> initialization of cmds variable. Leave it for another day, when it
>> should be refactored to utilize argparse instead of hand-written
>> parsing.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2.py | 92 +++++++++++++++++++++----------------
>>   1 file changed, 53 insertions(+), 39 deletions(-)
>>
> 
>>   cmds = [
>> -    [ 'dump-header',          cmd_dump_header,          0, 'Dump image header and header extensions' ],
>> -    [ 'dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image header extensions' ],
>> -    [ 'set-header',           cmd_set_header,           2, 'Set a field in the header'],
>> -    [ 'add-header-ext',       cmd_add_header_ext,       2, 'Add a header extension' ],
>> -    [ 'add-header-ext-stdio', cmd_add_header_ext_stdio, 1, 'Add a header extension, data from stdin' ],
>> -    [ 'del-header-ext',       cmd_del_header_ext,       1, 'Delete a header extension' ],
>> -    [ 'set-feature-bit',      cmd_set_feature_bit,      2, 'Set a feature bit'],
>> +    ['dump-header',          cmd_dump_header,          0, 'Dump image header and header extensions'],
> 
> I know you mentioned argparse as a later refactoring, but is it worth reflowing the table in the meantime?
> 
> ['dump-header', cmd_dump_header, 0,
>   'Dump image header and header extensions'],
> [...
>   '...'],
> 

Yes, now I think it worth doing, patchew emails never makes series more beautiful.

-- 
Best regards,
Vladimir

