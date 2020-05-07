Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB25C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C05C2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sWaM/Wuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C05C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcEe-0004Cs-5u
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcD9-0001vy-VP; Thu, 07 May 2020 04:48:57 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:2308 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcCs-0006ET-4n; Thu, 07 May 2020 04:48:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEl6om5VA27Rdz9C21YH1iGknC6aqdWwuTMvNWycWG9OSckfC7BbrjwvSy57r7wH05VFr+zdNXHin5XOLlurl2/rEtc6cL99+tcBlE0Ugmo/z2o6xrUfl3j/tdwIO1KEkuTIX05ymIYu4iYzzLBg6deLQMJ5UqTDAOfIX+59IB/gh3tHgQ7Oh9TDo1+tQTKkF76c14yc9GqeBVaUuge0k8XPBC+u9VA1n0UBNRlbnc/2BTr3+c37v651UUAhJiDLnd/IbD2WvaTLs58TDt2xZop/8laQtKzV1oMiMp8GxyX4XLzjSFzJSTk0GYbzguKZmTNhdPS0tFjLzcBBJbd4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T2U0BbAQLVp84ALKJHlPhxwtB1FnSttVtFGS1cxJRk=;
 b=WIHgK2Kz4ISR5IxvAQy7HNm96S3LI6O/RgmVU6+cVA7sZFdM9+pXnUrc8ysho78eFD99ibsdHaz68Ed+huivqmXavI6EcX+NuGXE5ULg7ttx3l8yn8v8x2eXsPnzhTrWRCXOeiWQkAoDcEfpN4NbBpqiw4SLQ/4GExPzmfIFgRrd/qD+d73yx0bn0CtUG2yxt1gHXy2Mv9SAUErd+J72ZQk+wkUCJ9cata8PGJxO/B+K/syzGFCpwggzzEaT5i/LGNOul+Li7qBy50zz7tnGzD1Xy1FQxIWeoDKic2/j88I80D6pD43vKJ0KxXnu1SIbB0KZyAQ2Obr5dbTkSgPZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T2U0BbAQLVp84ALKJHlPhxwtB1FnSttVtFGS1cxJRk=;
 b=sWaM/WuhLh/WWshEzgh3Txjt5Lw/n0a06bwNImRxHlvhSbuP1aAbgjPexbiA+fELYcOvYXwfNFFdWR0cHgpSq9+ozp6fSBIRehg62bjfzh+Mr/qWh5Abchp4ZFqmyIeauNxfI1Zt3YrKS1Y9YETHSCubdDcTwXJf2UqaOBn/fNg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/9] drop unallocated_blocks_are_zero
Date: Thu,  7 May 2020 11:47:51 +0300
Message-Id: <20200507084800.20596-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d60ec321-145b-4bd2-d855-08d7f2636d39
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54959EA6D53A875275A7BB37C1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FN+HV/qqo1tAUXNJZODPYxMyVPIh3so9LNjhADrElQdc8SnlzWhcExwO2n/rFJKy/hG3hUHXagnkYSt7P+6uMAxw0cZ7t57fEukDEHEsaSG42fBIRMJXs2wH1IlXEw1gyxO7+qDQp7APNaoV8jXRTYrJWStYZ+Mg0lnFN2m+iBxQY70tkjkFWpOLXfMztjFOCBdyFkogx6a/0gfmw4Pybr99iuULV3h7/ihj//GZEuXYqFA4JXQIJ99vSiJsQC2hR04nALjjFZMjzO+APopkdsO1Kq5uCuIlyRLGTa6Cg2pdjtFkrpzkYTVg1fjKaY45VyzRkgFWPWdz8LUhaLO+jh2AI4rKq8OdTu9Bm3JAt3uBlX6bnZnYL0HOvYU5blD+Oe3uQhbaiQvQVYsbpH1RkTqYGUWr80pOKmSTaQrlU0W6WAhujU9N3+5VMry+PrxVLIepEUO5P9T73AFLGhb3H24Kgo1e6k/47Xcgk2a9mqGzLGeo+Q3n0EJul0SZ8EEbfg8W8C2tAOMcwfFQ7wB+1w/RcYcnwLCCV2S9u3U9ncRSsYKlFzCdQBAGj0UlotIeC9ol0X5n2GpToR9uGofDVZakmizLXcsXPxMUvwHUoFs+jJCUPDxNNGaaCD0lr+Xf8HVIF5dKt3fn2e/wc24VtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(107886003)(66476007)(66946007)(66556008)(5660300002)(966005)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gRfnvW9kCL2GkueML27el/EVdy+Uv16t7trStePQnU9lYNZ8IIdSbCPwv9Jl62X5b61sNx1HGEEgL5IPOmFo46u7IePUdDmW8vNzVsXrQuuC9AtDPvFOCrv0xmk214tPDpwNeD3sP1ozqnnOSOQqv16ttgAhypar1jyQoMb6mnp08kExMH/951pI0IWHokBbreKUzHxyTJ2fM8h15/qAXrJYdFh2XpbYZFXTqK/ZSgd+6O5hnzYUX58pv4wzfV18aEFIXFLr91RJy+sACHqmbE47Izhzz7tWnswkqD83T/fKcBbAENHF1rnRphtU8vndOd/koe0U1Zo1kkimv/hVNb0hOXM0klPwNPQyjj+Mh/cF8cPUybCSFSYNtyZe3KLJQ4aZ+mpxD3vI/8rAYBGX25qCzC985nlWpahi4AKIyt1RmGnOC2hFiPZ2Xx6QcOfaoMIh++bZMuRLmRSLG4LGyq6nc7/bSVrnRLLhL51t5ptYjq8bNLjVaL9ySdHIkiPECvTSrxm+LPqAQTcsisC1JU15zTpLb/n0wv5sxsUzuH1mblpWHBQCBzEzHWExqsbcsf3jkC0EAggSBt93fAhwG+ypY6w/9R3QgBDN65aQlwZLM1ZLZle+Fm85VlnaYSmZesDjVmH+g3PFn9G+8A+lStbIa0iB6I+0QAV8JFPUl/EiUyDtCwchv7QOUhhHwezb/hRtwyT9xKbNlieiU8ZprnB1dDuzHxIBq45zKvmbHUDByE8rKEyo13P9TAmITgCpWPtUVZUwFhDGTep1DWfG3EnZfQqoLDRpJj1RDpQzGRs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60ec321-145b-4bd2-d855-08d7f2636d39
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:34.6825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGMCJMwMaxcWOeASiItcfTo++JRFhA5FIY68KstI4dxfukbamVCdkiEZ/8pQ+8UtxSCf424l18Hzo4OprIb2INI6oUg1taDpR7XIt38r7Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.4.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:35
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

v2 (by Eric's review):

01: moved to the start of the series, add Eric's r-b
02: new
03-04: improve commit message
05: add Eric's r-b
06-08: improve commit message a bit, add Eric's r-b
09: typos and wording, rebase on 02


This is first step to block-status refactoring, and solves most simple
problem mentioned in my investigation of block-status described in
the thread "backing chain & block status & filters":
  https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html


unallocated_blocks_are_zero doesn't simplify all the logic about
block-status, and happily it's not needed, as shown by the following
patches. So, let's get rid of it.

Vladimir Sementsov-Ogievskiy (9):
  qemu-img: convert: don't use unallocated_blocks_are_zero
  block: inline bdrv_unallocated_blocks_are_zero()
  block/vdi: return ZERO block-status when appropriate
  block/vpc: return ZERO block-status when appropriate
  block/crypto: drop unallocated_blocks_are_zero
  block/iscsi: drop unallocated_blocks_are_zero
  block/file-posix: drop unallocated_blocks_are_zero
  block/vhdx: drop unallocated_blocks_are_zero
  block: drop unallocated_blocks_are_zero

 include/block/block.h     |  6 ------
 include/block/block_int.h | 12 +++++++++++-
 block.c                   | 15 ---------------
 block/crypto.c            |  1 -
 block/file-posix.c        |  3 ---
 block/io.c                |  8 ++++----
 block/iscsi.c             |  1 -
 block/qcow2.c             |  1 -
 block/qed.c               |  1 -
 block/vdi.c               |  3 +--
 block/vhdx.c              |  3 ---
 block/vpc.c               |  3 +--
 qemu-img.c                |  4 +---
 13 files changed, 18 insertions(+), 43 deletions(-)

-- 
2.21.0


