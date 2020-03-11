Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA9C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738A7208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 07:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XwQbMGMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738A7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvqy-0006tb-MC
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 03:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jBvqI-0006QS-AS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jBvqH-0002TI-6e
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 03:31:50 -0400
Received: from mail-am6eur05on2121.outbound.protection.outlook.com
 ([40.107.22.121]:45576 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jBvqC-0002EU-P1; Wed, 11 Mar 2020 03:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtlMzEcc/7Nj4tB5nOqkIgZrHlzG6/+bqN30tSQfA7SOWh5zqdxJVpuIfbEAdjiAoHek9jln1k5jSsa3QIEa4lIlekbhBzG7f95JPNIhsMbw2fSZz94+MFBjLs0R+hQSXqlbliqDMh03P9IBjU3g9xmienWEaGV2DFmhOpPte9M0EP7Aa1R9jIQFPrLpoWwqiaH599uaMM0a4rmz6GIEuotURKuCEtgg5bdhdqwyPashgZiC70+bRTKnFlbfncx5q6oGmlb7SeMmQvFYeUD7xVp6l0ClGRtzW2OuMckLe1ID2cXv08OWKCRE5BCtodPhqvpCp7dVukUHaih02/rhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHCiFm/DpPL3q7NvE8eFBdu6le65mcvZqU3aPZsD7A0=;
 b=OAa2aV22ls6eOh8U1qrW7OLbITEpyjiJ29It5NT88CR/EHEfdRAoKBKyr2LQPV3N2PqsILihtl2RdBj2/07j/Zr94idsGVHfDfwDzgtlfQQbRtEJdM6el9QNMz28BloQiT3jOFHXML5q8TAURoPsFc3T9UyvVW35vTbWBonmJdyW7UAmio1xZTNkN0aBI7Yqo1viIRQcDVaS5VhraFnjdfIoGIdjWz0/ldy5yLI/WrGeqPrjbh/EeO7aGF7l6cSOi/QoXy30mNBrD1lUBHFjmnB9qHknrRHpzvjYgIoMsMiPipqPmZHTCExOM6JIRIvQufxFkJF4JTMRsjRdolAW0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHCiFm/DpPL3q7NvE8eFBdu6le65mcvZqU3aPZsD7A0=;
 b=XwQbMGMuAEAJ12sE8UUNdogB1kQlnZU839vMufn/Ny3avicBAUdIUzrgn9sPxmi9mITkq3xctn5377ZzbjXySBgx/xSwhsOg6QkgZ6m9iHsTmyP5n+kriITZWLPd6uMXucheLL8hm0bbd9/OeSBQVOVLPFiX803aSYZj+6SuZUY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3953.eurprd08.prod.outlook.com (20.178.117.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 07:31:41 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 07:31:41 +0000
Subject: Re: [PATCH v5 0/5] qcow2: Implement zstd cluster compression method
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
References: <20200304133538.9159-1-dplotnikov@virtuozzo.com>
Message-ID: <bbb15291-ffb5-80f1-ed27-583ac3cb98bb@virtuozzo.com>
Date: Wed, 11 Mar 2020 10:31:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200304133538.9159-1-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR09CA0043.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::11) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.44) by
 HE1PR09CA0043.eurprd09.prod.outlook.com (2603:10a6:7:3c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 07:31:40 +0000
X-Originating-IP: [178.34.151.44]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a20b32-5861-46d5-2455-08d7c58e3e0a
X-MS-TrafficTypeDiagnostic: AM0PR08MB3953:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3953590DDBDA9407D38268D4CFFC0@AM0PR08MB3953.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39850400004)(199004)(26005)(36756003)(316002)(107886003)(16576012)(8676002)(52116002)(8936002)(53546011)(81166006)(6486002)(5660300002)(2906002)(6916009)(81156014)(16526019)(66556008)(66476007)(31686004)(186003)(66946007)(86362001)(956004)(2616005)(31696002)(4326008)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3953;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+qLYNaOkManh87nhbrohPnEc+oPAkNvsncA8J5xopbTu/IJ/fLKB5CF97LgdZC8HCJLFxmnV9YYoEOAWISL1YD4HJMJ2A2fXPJCUJ/1/5ne5yuUpXbn/HfhmGLt/UvHNLmI/Ba6XUQbXObvzVrPeco9zcjDOtfONX1wM+9sKpY0xJDhAh56LNiJUVbrLAGqlz/NYO4Sw8AM6Yn6L2m6GwVeGfzjr1MP7TnAJeSC4U7TBF6SfQFRZV/cMzODvUASRItETOLOlPKCvc9qYH41Ekx/IETcKIfEJsMnUoZ31ij6JGluTjJLIkzCtdp/mST9q6+7fP+FpNzUMLCidnzUzBTXSIKTvAGtvHKL6w9duYv8qNx1+bmPW3IqXTG1HQGqvzrkEhFArkJaQi7L9UL/Fn5dvC/kZ0CkwRhFRshrc1Af0KBz298ufwTvVBCzAHSn
X-MS-Exchange-AntiSpam-MessageData: YPIwmMSWYwgn841rwtuBewam6lgIikjhQ1wHqAuzaMUsnz4NfVWjTwd5gDK5erGf8och0N+0gj7jTDJRAcXrjhjtaXRdXzlz9DdINhWQN1JkKiuxO/eN4rPgPm4sMNO5HYAZuegMoj9FR3y14Z5QuQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a20b32-5861-46d5-2455-08d7c58e3e0a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 07:31:41.6452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+yY9JqhSJaXss2nCDKzjWA5ARLVi0LlO9UR6aRLrXZqTV9bwyMqNljzE3Rq+BTYBq7SnSglVaVE+8bGqHS6mTold8sWV/LONGa54hkInOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3953
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.121
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

ping!

Is there any other comments/concerns/objections/suggestions according to 
the series except the minor ones from Alberto and Vladimir?
If not, please, let me know, so I can resend the series with the minor 
changes for applying to the corresponding branch.

Thanks!

Denis

On 04.03.2020 16:35, Denis Plotnikov wrote:
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
> Denis Plotnikov (4):
>    qcow2: introduce compression type feature
>    qcow2: rework the cluster compression routine
>    qcow2: add zstd cluster compression
>    iotests: 287: add qcow2 compression type test
>
> Vladimir Sementsov-Ogievskiy (1):
>    block/qcow2-threads: fix qcow2_decompress
>
>   docs/interop/qcow2.txt           |  20 +++
>   configure                        |   2 +-
>   qapi/block-core.json             |  23 +++-
>   block/qcow2.h                    |  18 ++-
>   include/block/block_int.h        |   1 +
>   block/qcow2-threads.c            | 206 ++++++++++++++++++++++++++++---
>   block/qcow2.c                    | 108 ++++++++++++++++
>   tests/qemu-iotests/031.out       |  14 +--
>   tests/qemu-iotests/036.out       |   4 +-
>   tests/qemu-iotests/049.out       | 102 +++++++--------
>   tests/qemu-iotests/060.out       |   1 +
>   tests/qemu-iotests/061.out       |  34 ++---
>   tests/qemu-iotests/065           |  28 +++--
>   tests/qemu-iotests/080           |   2 +-
>   tests/qemu-iotests/144.out       |   4 +-
>   tests/qemu-iotests/182.out       |   2 +-
>   tests/qemu-iotests/242.out       |   5 +
>   tests/qemu-iotests/255.out       |   8 +-
>   tests/qemu-iotests/287           | 128 +++++++++++++++++++
>   tests/qemu-iotests/287.out       |  43 +++++++
>   tests/qemu-iotests/common.filter |   3 +-
>   tests/qemu-iotests/group         |   1 +
>   22 files changed, 644 insertions(+), 113 deletions(-)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
>


