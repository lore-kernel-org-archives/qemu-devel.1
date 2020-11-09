Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027B3C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4064020702
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uVeOAW8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4064020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc2tx-0001q3-1V
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 03:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc2t1-0001Jy-4x; Mon, 09 Nov 2020 03:50:51 -0500
Received: from mail-am6eur05on2090.outbound.protection.outlook.com
 ([40.107.22.90]:4993 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc2sy-0000Gl-2u; Mon, 09 Nov 2020 03:50:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNmCGlIKY8TdyLZBUj2+pCPApR6u8TfGL6485i5k5rfEMTDkksp2rpy4LnVBdiFXy5lY3oyhVVqHGNkYmwiB5vI4IjSCuSGQYbG0eFsrQs2jNrZ8fvvobC6CemY3z5QmAMVU0Bp9mik0kq3CXWOfF4zQ6jEzGKAh9LbW0vxxLexORTuBKOljirHRQ0lQnvtSATIt+sgdCoZk2f09r6lxSU4FgKJXUTCimk2MUZvgYGpbQrLQUUxJHvOAHFuTgMwzExoCipc6cvLc6BaMbryTHVbji6GtK5HRkpjiScx5y//8vwubaDEne/q7edExH8bqaBEUHNciCj/xGwtxPPX8lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYKlV55abnO/XIflTdF61V2jnOkj/j32baiFEPY44bo=;
 b=STAF/BTfFmYGbO+hw762d2vq0W2jfTRZOd5doryZTYX32oOKHnSalbfvZTf5TQkS1OSlr1etB/QdnoT2gt4oYiFsbpUY39qma0SMrzYAG4vUuqUgBr7m1D0tOSbY9HNqHp5g/mVCrrn9BVbqFyMK0znQQJhWVyseZCMgQT7iETzt4TpyDV5OPLmgJdvec8faCdO3Iu+ijVY2J9GUQuEOE7janmBy3+9ZfpAiutKx8nGUDyFkdRM7faKX3eXvDAgam163ARTAiBT2vbUzE5U2B/LSjROLQRJQk+Eg6IdamUiA8pf8LWxWzs5RrGPxScjmwbp8rNqFnZcAeUGxNbGnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYKlV55abnO/XIflTdF61V2jnOkj/j32baiFEPY44bo=;
 b=uVeOAW8YCoTAylGybx7W1mfe6sN9ftc1zrcEmkRyFNkvC7Zd9uIND4emb8D8ViteAs3vc7aQ0yYrRvSpCl+o3DvNFkfKoNa+Fg7yRqoDLMv154t2TJEeBOcJtf6UhAmc/DaCchtwhrsacSr6Sqd2AaJk7o8LGpDMhYLuwBREaHA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4344.eurprd08.prod.outlook.com (2603:10a6:20b:74::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 08:50:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 08:50:43 +0000
Subject: Re: [PATCH 0/2] Increase amount of data for monitor to read
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, marcandre.lureau@redhat.com,
 den@openvz.org
References: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0f18a6c6-5eab-3ed2-98e3-04969da7bd7c@virtuozzo.com>
Date: Mon, 9 Nov 2020 11:50:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: AM0PR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 AM0PR01CA0081.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32 via Frontend
 Transport; Mon, 9 Nov 2020 08:50:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3f42d62-c952-4b78-6717-08d8848c8ada
X-MS-TrafficTypeDiagnostic: AM6PR08MB4344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4344D17E3A188FA8AE70DF4BC1EA0@AM6PR08MB4344.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOMyIohekgW06j88FQoXQzQicBcMfvb0jlW2SqXVY5QWB7/W2QF012pw+7pYUqRw3NgI+1Kj/G90dvxo6sn9Ue//FZ0kZjZ5xwFpeyFxfT+i06K0HS7E2Nc1pWg8ggFMNk83jDslYZ4njQX8BoyRXb43n0Fpb3iFNX3Q5XNjE6IWJaUOP0rqvSWAtJ9RvM8LlvnLmeEulDUXlA4rGzfYDjvi8tbTbVIjEhRcocOPPAmXRbnVamxvs+9v6Y9z50VS5AVXLYBGIhDSC/zdxaR4fvbON4jyK/r5ZLO4zkzR8zZqnJ0EF/ea5v7BWcWVQsyNR6j3tjEyBXKygHj+TzvATkZ5q7/cxY7/umfILxScjuZ0po4VHiZWjaNeJY+WCJTyiqkYsWgOPMqpqA+uHqVqzhB9Gbe+GtZ8sxebGBs8la6xMh8IGPN/h2W4iBusQLt2aXMBKr6dooFqIk6L1U08/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39840400004)(376002)(8936002)(26005)(83380400001)(31686004)(316002)(16576012)(8676002)(86362001)(5660300002)(36756003)(6486002)(966005)(956004)(2616005)(107886003)(52116002)(186003)(7416002)(478600001)(16526019)(31696002)(2906002)(4326008)(66556008)(66476007)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fyc78HExgvS1tRMScDhvlYN6wRoXfreJG4z0mGQmVfnH8hS0u/RlTo4X5dSfBaQ5FXaCeEYJGYlh4IZxJAXa116Ar37Hr84+rvM8C/t2zGbN7C5qhdkuokMYjOncHBb7lOOklPofRhnRsv45/+bSTnQVJjInNPGRLXM1L76JtIa05d4N9ycLvDwca2g+UhOLIsjNM9LGoyCCEQtsscQBmQirLf78j/BC7YhC/+cIx79S0PEmLsdCNkUT8+VqQI4x1eed0x6S2iZ2Nm+k9D7DaemnA+R39hmU6w1lLjgb5i7ZQWbrY3kTOJGiXiaG9yELM1rGdNH7rVjelsW8VS93o1BP7nj2SRZEBRAy3DPkHQsDE02W/F/em/ekHwNaiiDYkox2y10SPoyq7t01vJW6LbZgT2BFRnTgQ3VjOI6q688v2wz5zq3dije3dZvjK3DDDe+flBJsv1oYcjLIHXlolG0v8HVZ645zmff1LvGnBrOHmqZCRChynzypQccIxJH7vQ5kzc20ke5D1uyGNBVYa0LICgPYnXaScKAlnJU0qjmIo9FSMv7RktelA28S+qCDp6brZo/jk39gUpn1dyH/acn7lLQSYdwRsRfFdwLhWO4rvvzGGeJP4aJbYdvlGLCBTJal8ovbJZi2tkPPWOXUtA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f42d62-c952-4b78-6717-08d8848c8ada
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 08:50:43.4862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqPBEVxefnHmyT31MjVQfn+V+SGBHNUnCypka6LF1uYCkwy0zLV8494/7wUkngiTUflUMB1xfI0ghB8KJD8cWdKen3r6dJiFgtlcmJWA5Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4344
Received-SPF: pass client-ip=40.107.22.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 03:50:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

06.11.2020 15:42, Andrey Shinkevich wrote:
> The subject was discussed here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00206.html
> 
> This series is a solution for the issue with QMP monitor buffered input.
> A little parser is introduced to throttle JSON commands read from the
> buffer so that QMP requests do not overwhelm the monitor input queue.
> A side effect raised in the test #247 was managed in the first patch.
> It may be considered as a workaround. Any sane fix suggested will be
> appreciated.
> 
> Note:
> This series goes after the Vladimir's one:
> '[PATCH v3 00/25] backup performance: block_status + async"'
> To make the test #129 passed, the following patch should be applied first:
> '[PATCH v3 01/25] iotests: 129 don't check backup "busy"'.
> 

Hi!

I tried the following test:

start qemu:

   ./qemu-system-x86_64 -qmp stdio

type the following in one line:

   { 'execute': 'qmp_capabilities' }{ 'execute': 'quit' }

press Enter.

Without your patches, the qemu quits immediately, printing double "{"return": {}}".
With your patches applied qemu prints "{"return": {}}" only once and doesn't quit, until I press Enter the second time.


> Andrey Shinkevich (2):
>    iotests: add another bash sleep command to 247
>    monitor: increase amount of data for monitor to read
> 
>   chardev/char-fd.c          | 64 +++++++++++++++++++++++++++++++++++++++++++++-
>   chardev/char-socket.c      | 54 +++++++++++++++++++++++++++-----------
>   chardev/char.c             | 40 +++++++++++++++++++++++++++++
>   include/chardev/char.h     | 15 +++++++++++
>   monitor/monitor.c          |  2 +-
>   tests/qemu-iotests/247     |  2 ++
>   tests/qemu-iotests/247.out |  1 +
>   7 files changed, 161 insertions(+), 17 deletions(-)
> 


-- 
Best regards,
Vladimir

