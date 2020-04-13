Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339D5C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 12:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8646206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 12:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MNHvTjlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8646206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNyCw-0004Zp-1N
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 08:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jNyC8-0003yX-RF
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jNyC7-0004rR-Db
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:28:08 -0400
Received: from mail-eopbgr50134.outbound.protection.outlook.com
 ([40.107.5.134]:33211 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jNyC3-0004kS-4t; Mon, 13 Apr 2020 08:28:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0dYX9inYypD7btEDLu5mhq/e9uo535uWP8UucbBf1LDeCfTqARXPdGHagQKVoYowB/NLS0+P2DIqtrf+wqCuuL6O7hI5GuziTknMH6PhMqatu5iBBQE+lLRKNqx6iyLQTmj+/TEDeLRBGx5cKtbSQ7aDS95uSg+83jHK4XUh6tI9u8ZLq343PeXpWQW+6OAUuEBcUAbOtgmqXSLshEyQIx1zPpDUys54LW4agZOOqonEy6PLUPn5GAAfZraCq6Z+Vy7Xuq3GmjNVhf/iLo3r0PE5Zk+bOlWjzfJYHLdS7fN395+2hfFZTOm4QJX5M1k/bdUvcvdVJ8FCSSEBsOkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Db4sKwJFjMDOQ44IIF0sXzVsnKjVB2aW+4o31xwEtA=;
 b=ZDTpbZNSgpAB7CKzRYFQ+iNG1XjzH5RGuFlL1FIeaUW8OiN43oeerLp1BkR/azX5tWxsu/XZCfBD2QEvX6lFpIDxb7Ojuq0VV4ZKaOnBLmvHz0WBBzFpGQob60lxS/nAZv3NOoPE1DbhCuOdDor6V226xvnZ19d6VYO023vdCMsDWtFyKhmiCdx9z23XssnMN8rlVCkplVZ+y4sA13KvbDJ744vz/Y8uIxSJmqnCcH391IUjrXbBPsuXynRSyx2sEfuLmo4a6Oq1uYH8/qUgWrJLKZig1/HzdSADdw5WpWNIXiUQDWzQ4pdM7pllElSLLYLnfWZtv3T3HqiPUwjMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Db4sKwJFjMDOQ44IIF0sXzVsnKjVB2aW+4o31xwEtA=;
 b=MNHvTjlBBlPHj7GKzVDWupeYvTRX+r7ZpyrhsHKRAKjkh9qlfHOWr1QyKxqQwQrHb5DiqFW8brcctDAbh2HEwEAafpHvfLpO23boNlMQksS9podtNvo77UwTV1y6IYHrzcmvv2dgx6UL1Nb50RB+KFursYg7ji8Fhg85ZbakV8g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4113.eurprd08.prod.outlook.com (2603:10a6:208:129::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Mon, 13 Apr
 2020 12:27:59 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 12:27:59 +0000
Subject: Re: [PATCH v18 0/4] qcow2: Implement zstd cluster compression method
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
References: <20200402063645.23685-1-dplotnikov@virtuozzo.com>
Message-ID: <6ca66868-04ed-9e41-71ed-57de99a31f03@virtuozzo.com>
Date: Mon, 13 Apr 2020 15:27:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200402063645.23685-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::30) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.160.244) by
 AM0PR01CA0125.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Mon, 13 Apr 2020 12:27:58 +0000
X-Originating-IP: [178.34.160.244]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9d053a9-e415-4ceb-1e75-08d7dfa61a48
X-MS-TrafficTypeDiagnostic: AM0PR08MB4113:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4113A6ECDB65C8BC61087CF0CFDD0@AM0PR08MB4113.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(136003)(39840400004)(346002)(376002)(396003)(6486002)(107886003)(8676002)(81156014)(66556008)(66476007)(2616005)(956004)(478600001)(31686004)(66946007)(8936002)(6916009)(5660300002)(31696002)(16576012)(16526019)(52116002)(86362001)(2906002)(186003)(53546011)(26005)(4326008)(36756003)(316002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjawVAHtPcpR3BBFFeFPAaDyE8Wr7H6lf97z2Gbzu4l8Bn962vc32mvIPvzywFONX/Sw7Vfw15xdLpItDZdrmmH56MHJeJuRGltOgOMBbOBsfbEqQPi2VHE/QLGC8609ko+QKBW6txleyzeap2gfmNATtL1wBP0Nrm7PSdPa6bBJV+43DQ0PiHHm1lmfgcYHIufa8M4Px/cScXP2qK8osndN5PMkoznIirwUVlMoBFsYkMrNgNoaX9Z1aJxEuZSnEk0p9UwJqtnqz0oh46C3RYWafGWLg4pe8/INDTAcM+Pdx6+o8B4lVl5WtNOp7C8/BTKBd7LbReJxLJ1XIJJ05qsX2P8hWpUbMKZ0u3KrsScbu2ulOc9uHcIf4hIszFmkt22myO8yqUEu+AmEfxr6cNjyC2B/l8AdY3lvC2lV49O7HkBz0b2kivI3PSE7Lh/q
X-MS-Exchange-AntiSpam-MessageData: 933W9Bk4nnu+kXZ7p81AqI+NiBwMWNaSrGZppd49SnyDbynZqeNTmwpVdBtuOJwaucTeHlEZqpXPkzO+WPU4SMY6eB9d72ZJB9GbwJjMTFA9NBTFpXCM1MMfS0Bag/y/+M8G/YPRxG1VeZswIJ2zSQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d053a9-e415-4ceb-1e75-08d7dfa61a48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 12:27:59.6552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmOyZiG5MdbbFXJvtAnSryQxqUyT5ewNqKy1bBTjtumd4YN0XCm+fcG+cjgJQy0rW37pMrBlAvce7OhtFxR5YpCpc3augbL8CXJaITjeiLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4113
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.134
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping! Is there something to be fixed in the series?

Thanks,
Denis

On 02.04.2020 09:36, Denis Plotnikov wrote:
> v18:
>     * 04: add quotes to all file name variables [Vladimir]
>     * 04: add Vladimir's comment according to "qemu-io write -s"
>           option issue.
>
> v17:
>     * 03: remove incorrect comment in zstd decompress [Vladimir]
>     * 03: remove "paraniod" and rewrite the comment on decompress [Vladimir]
>     * 03: fix dead assignment [Vladimir]
>     * 04: add and remove quotes [Vladimir]
>     * 04: replace long offset form with the short one [Vladimir]
>
> v16:
>     * 03: ssize_t for ret, size_t for zstd_ret [Vladimir]
>     * 04: small fixes according to the comments [Vladimir]
>
> v15:
>     * 01: aiming qemu 5.1 [Eric]
>     * 03: change zstd_res definition place [Vladimir]
>     * 04: add two new test cases [Eric]
>           1. test adjacent cluster compression with zstd
>           2. test incompressible cluster processing
>     * 03, 04: many rewording and gramma fixing [Eric]
>
> v14:
>     * fix bug on compression - looping until compress == 0 [Me]
>     * apply reworked Vladimir's suggestions:
>        1. not mixing ssize_t with size_t
>        2. safe check for ENOMEM in compression part - avoid overflow
>        3. tolerate sanity check allow zstd to make progress only
>           on one of the buffers
> v13:
>     * 03: add progress sanity check to decompression loop [Vladimir]
>       03: add successful decompression check [Me]
>
> v12:
>     * 03: again, rework compression and decompression loops
>           to make them more correct [Vladimir]
>       03: move assert in compression to more appropriate place
>               [Vladimir]
> v11:
>     * 03: the loops don't need "do{}while" form anymore and
>           the they were buggy (missed "do" in the beginning)
>           replace them with usual "while(){}" loops [Vladimir]
> v10:
>     * 03: fix zstd (de)compressed loops for multi-frame
>           cases [Vladimir]
> v9:
>     * 01: fix error checking and reporting in qcow2_amend compression type part [Vladimir]
>     * 03: replace asserts with -EIO in qcow2_zstd_decompression [Vladimir, Alberto]
>     * 03: reword/amend/add comments, fix typos [Vladimir]
>
> v8:
>     * 03: switch zstd API from simple to stream [Eric]
>           No need to state a special cluster layout for zstd
>           compressed clusters.
> v7:
>     * use qapi_enum_parse instead of the open-coding [Eric]
>     * fix wording, typos and spelling [Eric]
>
> v6:
>     * "block/qcow2-threads: fix qcow2_decompress" is removed from the series
>        since it has been accepted by Max already
>     * add compile time checking for Qcow2Header to be a multiple of 8 [Max, Alberto]
>     * report error on qcow2 amending when the compression type is actually chnged [Max]
>     * remove the extra space and the extra new line [Max]
>     * re-arrange acks and signed-off-s [Vladimir]
>
> v5:
>     * replace -ENOTSUP with abort in qcow2_co_decompress [Vladimir]
>     * set cluster size for all test cases in the beginning of the 287 test
>
> v4:
>     * the series is rebased on top of 01 "block/qcow2-threads: fix qcow2_decompress"
>     * 01 is just a no-change resend to avoid extra dependencies. Still, it may be merged in separate
>
> v3:
>     * remove redundant max compression type value check [Vladimir, Eric]
>       (the switch below checks everything)
>     * prevent compression type changing on "qemu-img amend" [Vladimir]
>     * remove zstd config setting, since it has been added already by
>       "migration" patches [Vladimir]
>     * change the compression type error message [Vladimir]
>     * fix alignment and 80-chars exceeding [Vladimir]
>
> v2:
>     * rework compression type setting [Vladimir]
>     * squash iotest changes to the compression type introduction patch [Vladimir, Eric]
>     * fix zstd availability checking in zstd iotest [Vladimir]
>     * remove unnecessry casting [Eric]
>     * remove rudundant checks [Eric]
>     * fix compressed cluster layout in qcow2 spec [Vladimir]
>     * fix wording [Eric, Vladimir]
>     * fix compression type filtering in iotests [Eric]
>
> v1:
>     the initial series
>
>
>
> Denis Plotnikov (4):
>    qcow2: introduce compression type feature
>    qcow2: rework the cluster compression routine
>    qcow2: add zstd cluster compression
>    iotests: 287: add qcow2 compression type test
>
>   docs/interop/qcow2.txt           |   1 +
>   configure                        |   2 +-
>   qapi/block-core.json             |  23 +++-
>   block/qcow2.h                    |  20 ++-
>   include/block/block_int.h        |   1 +
>   block/qcow2-threads.c            | 228 +++++++++++++++++++++++++++++--
>   block/qcow2.c                    | 120 ++++++++++++++++
>   tests/qemu-iotests/031.out       |  14 +-
>   tests/qemu-iotests/036.out       |   4 +-
>   tests/qemu-iotests/049.out       | 102 +++++++-------
>   tests/qemu-iotests/060.out       |   1 +
>   tests/qemu-iotests/061.out       |  34 +++--
>   tests/qemu-iotests/065           |  28 ++--
>   tests/qemu-iotests/080           |   2 +-
>   tests/qemu-iotests/144.out       |   4 +-
>   tests/qemu-iotests/182.out       |   2 +-
>   tests/qemu-iotests/242.out       |   5 +
>   tests/qemu-iotests/255.out       |   8 +-
>   tests/qemu-iotests/287           | 167 ++++++++++++++++++++++
>   tests/qemu-iotests/287.out       |  70 ++++++++++
>   tests/qemu-iotests/common.filter |   3 +-
>   tests/qemu-iotests/group         |   1 +
>   22 files changed, 732 insertions(+), 108 deletions(-)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
>


