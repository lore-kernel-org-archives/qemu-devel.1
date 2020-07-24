Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD00C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FF32074B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EJzPQNCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FF32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyvIa-0008IY-P5
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 06:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyvHQ-0007fK-Oz; Fri, 24 Jul 2020 06:50:21 -0400
Received: from mail-vi1eur05on2094.outbound.protection.outlook.com
 ([40.107.21.94]:5984 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyvHN-00043v-3A; Fri, 24 Jul 2020 06:50:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgiS5gQzusvAl3KgikVyz/9seq8qrxtlKvrT65AVn43WEvgyrYOvc4gmU7+Qs7nR6+CdZ1RRlGsp7kx7mZ1XTo6KnEIjKoTWdThoDWPiC6EfWifldjcfEGWQq+e9fVZU1uQifQ1cHMy2RnRjeAT7UWieyzVkWwrCKl+LdMWBJE5n0OpokEvCOhr8qgn3BzHUtRfrCke2CueJUU21cKMqHEM/xw1JR9d7ofTtBaW1RN8uU82x6oYrR6SRIbE1tyd3Ql4eMX45tDTcfsq57D8X+HqHpJCj/wr90Gd9KdyeqBy1K+z/ih11fxU3ubmLeIAGraQzLL29AucjrMUMPhFwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGTB7fX6GF/d/TeosBRRYUyky3wriyxZtYKvLgwWW7E=;
 b=B0ERuuYwrADfyGacL0QG1tnbC5Usv7LlssZp1MeBrSyI6zUWSAEntFSFeSDQphLU6m3b0Yyq5zsFiaT8T1I/R29uD6PIIgZUIXyFwpKLZGdqYsRlEVJ+gstGtRXciu7ZzigBR7r5jyjdN/V2s2DShbfqTZ2nFgyNMQPi5JKWo1hCN0ZPRyaMpMmjIKixuAJZoCf6GM+qho4oXHF5C0WQgJQ9VOKZ67BK+jKlDG8TqdhYtYZgTVUfplcOhCujCcjiYGMDv/4kmOv1jqgT0PZG8JQtGathLyT7vk3sKfFW4OfiCnNmEb4OC+7S5aFx8ZuwGuPaV3qTiMq8htwBkLWjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGTB7fX6GF/d/TeosBRRYUyky3wriyxZtYKvLgwWW7E=;
 b=EJzPQNCLIFQYbs+zRmdzq8pfhNMnAFv7PW6JkyZHe4MvNmnJFmPm0Qq/UZzy6CzyosDeK3RxujypISZiFSR2y3MJCtU8T6c39wFnyn77WbCKsFckkAxDh+uP/nzddTFD7J5p0SEdS/IKTKn3TC8mwxSUDOoctbcgi0qnk7RrDYc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:50:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 10:50:12 +0000
Subject: Re: [PATCH v11 00/11] iotests: Dump QCOW2 dirty bitmaps metadata
To: Eric Blake <eblake@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20743b55-8eeb-3cac-86db-eab8c2bcd4ea@redhat.com>
 <445af8f9-2749-480a-09dd-572172653f47@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <13e26eb5-a41a-c65a-04a1-9eda057ac157@virtuozzo.com>
Date: Fri, 24 Jul 2020 13:50:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <445af8f9-2749-480a-09dd-572172653f47@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0PR06CA0139.eurprd06.prod.outlook.com (2603:10a6:208:ab::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Fri, 24 Jul 2020 10:50:11 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b5947e3-6d8e-4f7c-4638-08d82fbf573c
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303261BFD9462832B8B793C9C1770@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUtXs4OsRWfbWr6LsofSHmGoKsQC1pX1CTaLsnsD2Be8jyWJSkGxJrlim0vkuNCxVik3oe1ewPYwsXayyO7Wd/m3va8V3c6ZVFPTQH+kPCZn/Yy+8wrrtt8LhM2CZFUv3q8kafiqzR5R3X4sl5MR+2Rw2Qr5DzLEqErJXB/m8qJ55g6SXkXG2QD8V7sufwnJNUXDmYC1hh5sbXEdN6c7D0YqRXUgRM1/Vb1hBkJeefalqWs8W7TfSbQ160SX+h4+OU7xDv9cUzZxNHruJt0cCS5s38wp6GL36vsEnVg+oQuErcR6Ecqbinaj3Vr2bp15OYKty1/B8Ubk04Y5oLJMD8wkJ+oDO15+5WG3KDuBCAUXqS8Z7kkiL5ZtzCD/GDhCx/uSDbMbqvXgwBmRVJNqgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39850400004)(83380400001)(86362001)(8676002)(6486002)(110136005)(36756003)(16576012)(316002)(8936002)(2906002)(956004)(2616005)(66946007)(66556008)(31696002)(66476007)(53546011)(5660300002)(31686004)(186003)(4326008)(52116002)(478600001)(16526019)(26005)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZJ/wQRUcdHTWWZMUCul1yJTGxptH12Blq2sq6Egp9eg84L+0TSs3TrjrlvziQKGCrM8lE2xDzTOSIBEUqWx3QhC+4nwodRFKKIoBPFKjOJ1Ax5k1esOnnb6V1XyuIMrs5T3tvI+OTe+zzN+YcXAIyYAlLPLyFxH34xc01hpUBt25ILTOCpvnKULB6nkb3wVxqRj0LzgHIjU1f7tMfbrJrDUx8VnEHKkDdQtqBFbcMd6YYVr+D7ZXbYk8Xq1JbdqRUY5/C1DsCDgawxb6vgSn8domnvK9zTVSR8as5sQ1jkWo8SLZcdcylgYa1OXbC8hWTT/pNfQAfZU7XSRmdglW8ToPHQPHO1OnYE5V36+4C44bK3dhgX0EqKgQQpKUU5XADLSxAzJ/pjhM7IL7E9lRMI85oHqNI5G3OvYhkgGfD0G9HO6Uqk/tnq4lFj6865oeF9enrKA/hTG14pEOnriQ5f90HWC9j4L7fAG/AfAMLY0mvMiYabjfMmH5rAjVc/SF
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5947e3-6d8e-4f7c-4638-08d82fbf573c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:50:12.3146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQ2fAjMIegOjv21jroasOMJuEC3I+vNm7KlJef4dNsu5AkG7+HsyRNvinA5B4go79x9e+xJHNsVvyYgPFjlWynz4zTaEQKMV2IsTH4tivFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:50:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.07.2020 23:18, Eric Blake wrote:
> On 7/23/20 2:42 PM, Eric Blake wrote:
>> On 7/17/20 3:14 AM, Andrey Shinkevich wrote:
>>> Add dirty bitmap information to QCOW2 metadata dump in the qcow2_format.py.
>>>
> 
>>>   block/qcow2.c                      |   2 +-
>>>   docs/interop/qcow2.txt             |   2 +-
>>>   tests/qemu-iotests/qcow2.py        |  18 ++-
>>>   tests/qemu-iotests/qcow2_format.py | 221 ++++++++++++++++++++++++++++++++++---
>>>   4 files changed, 220 insertions(+), 23 deletions(-)
>>
>> I still don't see any obvious coverage of the new output, which makes it harder to test (I have to manually run qcow2.py on a file rather than seeing what changes in a ???.out file).  I know we said back in v9 that test 291 is not the right test, but that does not stop you from adding a new test just for that purpose.
> 
> The bulk of this series is touching a non-installed utility. At this point, I feel safer deferring it to 5.2 (it is a feature addition for testsuite use only, and we missed soft freeze), even though it has no negative impact to installed binaries.
> 

Yes, it's absolutely OK to defer to 5.2.

Thanks a lot for taking a look at our series!

-- 
Best regards,
Vladimir

