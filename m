Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA8CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE4920774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v1FWZHts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE4920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6eVC-0002Bw-A7
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6eTx-0001WX-HG; Fri, 14 Aug 2020 14:31:13 -0400
Received: from mail-db8eur05on2094.outbound.protection.outlook.com
 ([40.107.20.94]:22697 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6eTt-00075p-SM; Fri, 14 Aug 2020 14:31:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcF8B3K6V6EIywKynfar7Wl0G0nt35qTpR2REfQlHrigdIOPmknZcTlvo5ortcAmfBZAY+NiGjs+Gw4Y8p/dazoQglLB/M9io6IT9k0vdCp3uAxkJivghZ8id5C/m/fnjBaGe8Ro/kHz3ZDYX0Nirjb8SW5ts7HKmI6Q5WVBdGLQUmJ1/x8qhXC3B32T4w5ORhDEhGouSFik+tBvCuTV8uBhGPBqup9wtuMNkj3OK5qgerIawUdsTveH1HMOCa7LOWVmFEbgjMaQGWDer+6xXs9d4yxdn6Vd+ClMG3bxIltV8kWUT9qGM3tE8v4t6pgpwnv482o17rD03geIoXeaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntJiEcRBn6wkrv5CfC3fBl0unVl9e/+327mgvEmsdgk=;
 b=i1HFVzLn+AyRetGjGBZVKGoRZQferJarwNBwapLfr/gIt0t90x6Zad5u7OPHXlPJmWvzXW57vm4D2VwxxmZmpfWjGTzW/WZd3DdHlHSFepn+Ap6pelFs8FFcfORAyoraEIQ6ysJAQLpFlQhj2qPssV3utWquJj6876EiNmsvu2uaNpzoPRsjOWxJxWj3VvmZCnD7LRYIbtSqUCUWpd48EG0ekPw07cQsdP3IL2n5rxBdDkdbblFDSp9/VLsvqFIZkaQTsoTwv206cyEE2ofJ+j2CE6xF+wREMjFsjqw3LfkgQ2OXWUnwsD+RPbqMPA6dcAWh24MLHktCCrW16UMeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntJiEcRBn6wkrv5CfC3fBl0unVl9e/+327mgvEmsdgk=;
 b=v1FWZHts95XRCb26xanZxQ0haxBdHaDlWYXE7+FRq/mlEV0YKV8xjWTzqEUgBz+8qKjyuLNiLcIMdTzT8b3Wi2rOPrUipDzagDNp/qhcDHXXVXOdswibBMhaNYk0NCHyrpT3zg15gviVIMWenWgEnotZTErepT0SmmbCYkjoQWY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4533.eurprd08.prod.outlook.com (2603:10a6:20b:b5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 18:31:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 18:31:01 +0000
Subject: DROP Re: [PATCH v2 0/9] preallocate filter
To: qemu-block@nongnu.org
References: <20200814130348.20625-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d7e1d33e-325a-588c-3ae2-350ffdbe1282@virtuozzo.com>
Date: Fri, 14 Aug 2020 21:30:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200814130348.20625-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0103.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.177) by
 AM0PR06CA0103.eurprd06.prod.outlook.com (2603:10a6:208:fa::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 18:31:00 +0000
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7438086f-9a3e-4b43-a7ca-08d840803215
X-MS-TrafficTypeDiagnostic: AM6PR08MB4533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB453383E0C437261BEDD17B50C1400@AM6PR08MB4533.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqMAmcM2kSbt2VmZT/Zk/U+tLDTzSC5WXQ36Ke7jf58mlzhEldwNJCDExRc3gF4Ivl+nICS4pI+REKuR8HqC589o3+kDAaje4UiVfKgBg9Frd8Zhq870hqZq6ipegyqSV5ACS2vFVIchKkLesaN+qMhB+2bev7ZZvxYNip5YN5i6TN4+5V2Fw7uLgANrX38J+lgwQ0rejA+559XaNKghbzKRmPLzUaZ0NHTEQLrY1Q71sp5TqA6svFteWte7pikbP1Affa9LvXMwOgfDVucM8gbCeM9RmppPngqC07YBy6UTAfWN8d+9peEK9aERepluWto+GYRwQO1f6p1oNsycv8B0ZhRpjL43xNVkaBC/sOdqAVbxPDjK+vd8jkWUriEbAAqNe4gun36rRo++pwWSNj+o4gi8K3fnz0k1kHonNgpkGzLkMFDPa0MUf79dFH2PMKVRglce8/NEbjUN+JTtqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39840400004)(376002)(366004)(136003)(396003)(966005)(4326008)(956004)(2616005)(86362001)(478600001)(31696002)(66946007)(31686004)(66476007)(66556008)(36756003)(16526019)(186003)(2906002)(8936002)(8676002)(83380400001)(5660300002)(16576012)(6916009)(6486002)(316002)(52116002)(107886003)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qN9xdCax4qj+NknDcRu+SNP2xFF5XYlwP6TBcudZY7KRLkrx4nh3GocX1TgfQzJTezl453FDJPW6lxIfZtMphY5DSK1g0zXRBVH7D65yqcqNYCeTl2JmUXkXOgFSXBm3kGYtmOKPWPbOeVejnTPzUVUEyqnxt9Q/lZFJwk/4ATevagLSrjSp/Xmoh/+0BRVGERXTXquZmK5XyN/V/glxrohdozTKTvt2CeruIqoI3lqSwiMI+FveH2jRtfmVIoB5F5lKzkDoIULfYug+UY+khnUO/U5IRgfAkrQgOAQY7ByoQb6aiGe8lWpGw64nPpc8EyXitR1FizA09jzNQpggceOH0PxJ5B1oYUyo54kOSPskf4m8C4n2dHXhzowEDtj6511SA7PIWbu+MsKMimwfbeluaLg5rx5n/GC9ovOg8DftsL1OMbhlbVZCczmh0SH1oFQERfcBTKvgvQ72EBFh5HRTUp9+V6gPg5sjkdCrSvqlh28ump5Jlh3PtF9qG6DzgQ7+utlHGk4VSjsWMJK5nhzToDDH8LyTjUAOn0if8a6W7llIyNby5Tux3yspGOzA4WiYE7sqYMKFcP5XpTJfXQdtJFjynX5sxuwLdAsAN81mbPGAD0J42a6x/yLqXs9h8y9e34wR59Fol+U6GvZavg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7438086f-9a3e-4b43-a7ca-08d840803215
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 18:31:01.5207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLHBlMvgRxdiAfMagwVgbbuCy5JSEzMbo+0I1NR3yCh72VjULH/fGwgcl42WP2ksEx73tITBK7yGuKb9SjUaO9xrAEHfUHn2HXCMJThI6BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4533
Received-SPF: pass client-ip=40.107.20.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 14:31:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3 will come soon, don't look at this.

14.08.2020 16:03, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here is a filter, which does preallocation on write.
> 
> In Virtuozzo we have to deal with some custom distributed storage
> solution, where allocation is relatively expensive operation. We have to
> workaround it in Qemu, so here is a new filter.
> 
> For the details refer to original cover-letter
> "[PATCH 0/5] preallocate filter"
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06443.html
> 
> v2:
> 1-6 are new and substitutes bdrv_co_range_try_lock mechanism used in v1
> 07: add note to docs/system/qemu-block-drivers.rst.inc
>      add open options
>      rebase on new BDRV_REQ_NO_WAIT flag
>      drop bs->file check in _co_flush()
> 08: new
> 09: use new iotests.verify_o_direct()
> 
> Vladimir Sementsov-Ogievskiy (9):
>    block: simplify comment to BDRV_REQ_SERIALISING
>    block/io.c: drop assertion on double waiting for request serialisation
>    block/io: split out bdrv_find_conflicting_request
>    block/io: bdrv_wait_serialising_requests_locked: drop extra bs arg
>    block: bdrv_mark_request_serialising: split non-waiting function
>    block: introduce BDRV_REQ_NO_WAIT flag
>    block: introduce preallocate filter
>    iotests.py: add verify_o_direct helper
>    iotests: add 298 to test new preallocate filter driver
> 
>   docs/system/qemu-block-drivers.rst.inc |  26 +++
>   qapi/block-core.json                   |  20 +-
>   include/block/block.h                  |  20 +-
>   include/block/block_int.h              |   3 +-
>   block/file-posix.c                     |   2 +-
>   block/io.c                             | 131 +++++++-----
>   block/preallocate.c                    | 264 +++++++++++++++++++++++++
>   block/Makefile.objs                    |   1 +
>   tests/qemu-iotests/298                 |  46 +++++
>   tests/qemu-iotests/298.out             |   5 +
>   tests/qemu-iotests/group               |   1 +
>   tests/qemu-iotests/iotests.py          |   6 +
>   12 files changed, 457 insertions(+), 68 deletions(-)
>   create mode 100644 block/preallocate.c
>   create mode 100644 tests/qemu-iotests/298
>   create mode 100644 tests/qemu-iotests/298.out
> 


-- 
Best regards,
Vladimir

