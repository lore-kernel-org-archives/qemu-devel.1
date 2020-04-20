Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D78C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB73C206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XU7YiBoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB73C206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXzX-0001VF-U9
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55084 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQXyU-0000Pl-45
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:04:42 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQXyT-0006d9-I7
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:04:41 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com
 ([40.107.20.132]:4640 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQXyQ-0006Z3-O9; Mon, 20 Apr 2020 11:04:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbsoTblMcKq/eMhltumZn1SI2beiXV9hXaL+NOhIRf6d9WgWCDe9hH54g6xMoM5LWMObB3Bx/v5FLC4qNNNxQPyX0hjbeMad2xZputQSDjaAmBXttdwDcpkNlWCMX2D/n/3xXXdPNGmbNyes4ByAJI/RRDztyswKR6b8Etv4hICkroRIOpZHf4a1sAr9esyU3D8mJaM3FRoNLvIsYay4y4N2d4+kK21hdfaCaxcDbwAdLPCewUxYESAPztFfyu2Rzj97bpQVSRA8l41G4tT2o9OO7X5jvrp2v7ufoS3EJRlaJueqm15Uf9HrmN0H1r/4OZcrdCnxi5+B1Ap+zF+RLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLm8n40itjDUSed562fEzpJFDJn3LbPBqfVqX+hhaP4=;
 b=XFm2e9YavQPaIeEBH6upXY9pH05xL3w45kgQMAws4buN3IVJEX7RZmcMjE8XRn6e/qhNi88wLqN73ZbmUsrprIEYylppsSeGPjCThtd6Uk6l3VhUpynMswzD2HxskCWuY/lUcc8qbnoUAhxdpIMAD3R7oH5lAC3NYTsDHQo72VlTw2hndu+tvly7Fu7j5XmpNFoHzfsk22DQ955WDUBiwt8NppA2LSRyw6AogpCGtquC+jzwB55yikkrfnRPL9A1Jr7GLFbR0buu3LV5av9pLhFSqiwrknquzw03gEK+p9kVkaG4uZMSA34aKwyE6r6vOzRbZ4OYrXpPw71Z0+adFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLm8n40itjDUSed562fEzpJFDJn3LbPBqfVqX+hhaP4=;
 b=XU7YiBoRZPdh2/lfoDhCqp3A3NMSMsH1Fn97Kf45CeHw6CDFrIb5RxyLCfFL/ZEo8lMCyjLDZeCjGgboSyyycca6S7uTIIwTiTaiFMh4p4RVpuOuSbHLnTdqSut5PRtTvBk1EgyFmb6IaJzRUUEp2wXjF143ybBNciHhYIellkI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5302.eurprd08.prod.outlook.com (2603:10a6:20b:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 15:04:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:04:34 +0000
Subject: Re: Avoid copying unallocated clusters during full backup
To: Bryan S Rosenburg <rosnbrg@us.ibm.com>
References: <CAD_3s9Jnd9BzkZAe6SEKz7unuxJHY502pNdUgxrC3MOQAFj9Hw@mail.gmail.com>
 <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
 <7c722a98-29ab-ba65-2f19-088628ce8f00@redhat.com>
 <CAD_3s9KuB7QaXCTygRfOsscXbrhm0kHbHRpUjb51EiwRpEM5MA@mail.gmail.com>
 <93052f9b-6539-0d4a-c922-fff7618c542d@redhat.com>
 <CAD_3s9+pSepV76-wp_AQTB-EQGwmga1FS+fT-Cb4n0Z48Zhxpg@mail.gmail.com>
 <3399bbd8-a85b-9e42-cd16-a40c4a963e9e@virtuozzo.com>
 <OF6B6CB4FB.FFD51055-ON85258550.0049F242-85258550.004FD137@notes.na.collabserv.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200420180433005
Message-ID: <59e3fb48-b397-1e59-6f29-8e7f9148fe41@virtuozzo.com>
Date: Mon, 20 Apr 2020 18:04:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <OF6B6CB4FB.FFD51055-ON85258550.0049F242-85258550.004FD137@notes.na.collabserv.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0022.eurprd04.prod.outlook.com
 (2603:10a6:208:122::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0PR04CA0022.eurprd04.prod.outlook.com (2603:10a6:208:122::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 15:04:33 +0000
X-Tagtoolbar-Keys: D20200420180433005
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 249d41d5-8abe-4e2f-e707-08d7e53c22f5
X-MS-TrafficTypeDiagnostic: AM7PR08MB5302:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53022EE2D6AB3A4700639387C1D40@AM7PR08MB5302.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(39840400004)(346002)(366004)(396003)(136003)(54906003)(4326008)(52116002)(66946007)(66556008)(66476007)(478600001)(6486002)(6916009)(5660300002)(2906002)(31696002)(2616005)(16576012)(86362001)(16526019)(186003)(31686004)(81156014)(36756003)(26005)(8676002)(8936002)(956004)(316002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8U1ib9qsDw1ca6rehIFQ6kZ2BGsb6/x/Z1YctrAo9HaS+kZwi48WKdGQ4OkzpJxYkE5MSSyT+k+Hza4KcUy20AwBFYPyJqNW9qgHFX1V11Vwm+N/tpmECPlKvVEX3qGCFECKuqSffiYfnHFkZig7KTM+YasAnMO5/Dz5Ui/ewjC78qv3JiMJN1OEkWEVfsmxI13lz+KPhKjq68OTyNO90RfNqYX/eIWwH1o7HzhgMquMkguv25LGYGy2zc24gLO45WkYSYX5zk/eiNQypuQXsdLVFk0M4PQ/xulgPhglJSPZ1euibIjbvYBLHNI29pRacqBnq5cSQZ/G+FHweGOeFLkciNNx6gmcz56/Dmps4IXmcsi750aVce9eiNZKrp0JBrC9ZbvQXeni6mMtG6aH4ExUgg0pEVpgWaiUxlGamd9cmThxq9hLskIL0ZYIts0A
X-MS-Exchange-AntiSpam-MessageData: K+WjcbRvjejAjMyvZgKTdlhPKF6V+d2rV0pVKj7YTi5CgcwYbjrOMWrlvsLs/OvyvvkuB5uhO/CHRz87IS1r/T9x0ys6ZP9YbmZj5Ai7lLO3cbtvcdh619gf2cysEFzncKFUZkZGFaXOhlPe6KEosQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249d41d5-8abe-4e2f-e707-08d7e53c22f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 15:04:34.5336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GNMozKYIGFClpsyy0+IDY8Tzh/cDajlsDde1DyW3OYBm1YTCMzYZFY2jAF8MEZRxgRgwRcgj4CIbVSvPqm1KCA61B+CfsHJ7PmGg0CP6bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302
Received-SPF: pass client-ip=40.107.20.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 11:04:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.132
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
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Leo Luan <leoluan@gmail.com>,
 John Snow <jsnow@redhat.com>,
 Qemu-devel <qemu-devel-bounces+rosnbrg=us.ibm.com@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 17:31, Bryan S Rosenburg wrote:
> Vladimir, thank you for outlining the current state of affairs regarding efficient backup. I'd like to describe what we know about the image-expansion problem we're having using the current (qemu 4.2.0) code, just to be sure that your work is addressing it.
> 
> In our use case, the image-expansion problem occurs only when the source disk file and the target backup file are in different file systems. Both files are qcow2 files, and as long as they both reside in the same file system, the target file winds up with roughly the same size as the source. But if the target is in another file system (we've tried a second ext4 hard disk file system, a tmpfs file system, and fuse-based file systems such as s3fs), the target ends up with a size comparable to the nominal size of the source disk.
> 
> I think the expansion is related to this comment in qemu/include/block/block.h:
> 
> /**
> * bdrv_co_copy_range:
> . . . .
> * Note: block layer doesn't emulate or fallback to a bounce buffer approach
> * because usually the caller shouldn't attempt offloaded copy any more (e.g.
> * calling copy_file_range(2)) after the first error, thus it should fall back
> * to a read+write path in the caller level.
> 
> 
> 
> The bdrv_co_copy_range() service does the right things with respect to skipping unallocated ranges in the source disk and not writing zeros to the target. But qemu gives up on using this service the first time an underlying copy_file_range() system call fails, and copy_file_range() always fails with EXDEV when the source and destination files are on different file systems. In this specific case (at least), I think that falling back to a bounce buffer approach would make sense so that we don't lose the rest of the logic in bdrv_co_copy_range. As it is, qemu falls back on a very high-level loop reading from the source and writing to the target. At this high level, reading an unallocated range from the source simply returns a buffer full of zeroes, with no indication that the range was unallocated. The zeroes are then written to the target as if they were real data.
> 
> As a quick experiment, I tried a very localized fallback when copy_file_range returns EXDEV in handle_aiocb_copy_range() in qemu/block/file-posix.c. It's not a great fix because it has to allocate and free a buffer on the spot and it does not head off future calls to copy_file_range that will also fail, but it does fix the image-expansion problem when crossing file systems. I can provide the patch if anyone wants to see it.
> 
> I just wanted to get this aspect of the problem onto the table, to make sure it gets addressed in the current rework. Maybe it's a non-issue already.
> 

Yes, the problem is that copy_range subsystem handles block-status, when generic backup copying loop doesn't. I'm not sure that adding fallback into copy-range is a correct thing to do, at least it should be optional, enabled by flag.. But you don't need it for your problem,
as it is already fixed upstream:

You need to backport my commit 2d57511a88 "block/block-copy: use block_status" (together with 3 preparing patches before it, or with the whole series (including some refactoring after the 2d57511 commit)

Hope, it will help)

-- 
Best regards,
Vladimir

