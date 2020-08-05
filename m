Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CEBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B7C2177B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U+9K42+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B7C2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3EbO-0003fZ-03
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3Eab-0003DU-Ir; Wed, 05 Aug 2020 04:15:57 -0400
Received: from mail-eopbgr50136.outbound.protection.outlook.com
 ([40.107.5.136]:7842 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3EaY-0004uC-7j; Wed, 05 Aug 2020 04:15:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXHU64nK1hl7aQSsNNrn2N6ORZGs/hN+evFUhqS2DltaO0K0XfkeEvRElPH/b4ZDfKXo1yIlbA8tf0+5WoqsEBGlAEerRgtkU0T2dOu5AfuvqyFWiU0J45j8Pz7BOLBwjbfSXa3D6l3j1tYWGzpf5OOoktwz4ZBNidRB2WDo5EKbEKXCIP3ivwgWaTGmvHxVmly4iYOVfUh5FSmVByLX9Bz/m+2btkFeThgiynqsdbppwUrWRdfLwbUJUx5knZOrjgE4y9KYAKp/KKkNmGZAW2JypTTNdqrS8+8rnmgk035ESaG1UcdIrRXC5AZDGC1MwgwSiX+vz8gTwJxay1sJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA/ZPhfe3zbkblIW4+u2EuizPQbSbdiaRLFrSBpkZHM=;
 b=mjWL0IbhIKKOeUp7omOduKA6xntVb5CTIemY/kGXq5JF7vikcBHH3Ax9WDPjDeYRJimHQI1V+boP1hP54rfCrEhMTZHJd3Eh3OCLzc6tC2jQRDvKGf7jNRGMC4VXRkhqHGh9AqAKy/cje48h6MGLeRGM7QuKy6zOl/cQOf/fqZVOWa7LhbCBNNv+AcGincVOrKKWa0pbOcA4OYpXjC0ENsxHmvLuASTdqwg+rtxmTShpx0EY8yeIA+eDSc85ILuYDdgWEvQS+xFJImuWap5mr2kroobjqtZvCg25yOsX+f7jGcVKUEOZZgEefIQW465L2XffMquBjv0ZcnVVD7LBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA/ZPhfe3zbkblIW4+u2EuizPQbSbdiaRLFrSBpkZHM=;
 b=U+9K42+TZlUhgz6twTDgq4EOjliplNk5LYzk2DacMGnapZ2lkW+pcRAeB+pi0M0RbqpDgVUsb/PEGnk1xjWL49O2Tp9DxBtqizh17SN8nrr17IiwnwgQj16eIplc19V7D4cvfbEkQCiMAtCL7WXeFYvMFypxAdPlGJ+7he1XfzA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5080.eurprd08.prod.outlook.com (2603:10a6:20b:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 08:15:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 08:15:49 +0000
Subject: Re: [PATCH 0/2] qcow2: Release read-only bitmaps when inactivated
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200730120234.49288-1-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f9c3d411-fe9b-91d5-3ef1-af9d0b5a8480@virtuozzo.com>
Date: Wed, 5 Aug 2020 11:15:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200730120234.49288-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0169.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM0PR01CA0169.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 5 Aug 2020 08:15:46 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc5988fc-8355-43fc-ff59-08d83917c2fb
X-MS-TrafficTypeDiagnostic: AM6PR08MB5080:
X-Microsoft-Antispam-PRVS: <AM6PR08MB50808DF556F33A04685F2825C14B0@AM6PR08MB5080.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3o2hOpinohHhYo2mPHHHZXk03RcgrC38ie/2Gu/DRh9UFJJObArzBmSf3qm2VvqeaCWc2Qa6B25JkXX6Gqa33nSYWLBGLewXsvtIC84Az5DS9GbpA/TfFF4YEK0ElPRSYIO/y37LW39VRu8jt5LvSUlchAx780ipQ3AV5uH9txFaHwU2Bq2D8GS06BU9dn+sS0nK7k4qmjss5ty5/V4sYyUmi/AqX8a7XlTyhjRF7826eWxE9zylspSiEV5Q8vJ/t40ORWFAdcQY2jzV+qrGgI1C33ywZiSbyY2a3wo3qeVnKx+nCO+KAS4t1aNA/Rmxm60qhCuuJnOReD/Q8KKPifd2nSo9+m+nCHp69yPI5MNcM3QpECKmyXU0F+MjqzAoWcoQMMiBT7ZgCJ4wYlDyogxE23qTaVBLPeAHema1thKpifTbjzz4kjawezkBi1H4ureAR5LzrrqJ3waCXO0BTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(366004)(396003)(376002)(346002)(16526019)(83380400001)(2906002)(26005)(6486002)(316002)(956004)(2616005)(66476007)(66556008)(186003)(5660300002)(52116002)(66946007)(16576012)(8676002)(86362001)(966005)(36756003)(31686004)(8936002)(31696002)(478600001)(4326008)(54906003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OwPKuL2wACIEHU6u89wY44b2htyX57LlcST/ojlxN9/malhqytTwwF7MZZLxKyEfW0l5igZmsA0afTSDHlyQzkZWYGHBhDczNY/IOcJWzgCyObDt3cghaaBc+IRdZF0mq+I47Ns3KzsLo5vDf1p9bv2be2px1mg3MifFTJaybyR6zZQAOVbM36ULTRay44RUmGYpmn7tlx8bR/oyKkz74svhH67DFClhv40PCcmU6rONPf4uAOiDo7SGFAEtB9ggRt62iaTjUDerNnYj8KsT5HYhRI3ikAGoWsYddCZapRlzRupC836CO7SDspcQS3rmcGrLtV/ToJoXcy98rABFX3xKJ7OPYaIDVEX1eNysuyLRwlhjdtVg4FRn62Klr/Vco0jbp/yJZWA6aTPZAhJ4eRNZvh3uUQC0hAtQ6/oeFRGTpexZuNoTkmiCr2kk/HZZf1NsfSsNfc5gN/hmMRzj84cAeZcbYNtqi2ny8CGyqXNjVi1BFSTKu1EH7yLWsz0+v3RYoDI6BBeBfNWZqIrSFMoDB4phVAHKz5GaOkjqsZDfT02dA83ez8KZ8bGqq9oORA8efRR+TlP2rXeZsaBj0JACf3boae2YxlqH3INYWkNvRYtPbQTUdC+FrrEdlOsJd/65qWQyDTCF7k6Ifli1Hw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5988fc-8355-43fc-ff59-08d83917c2fb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 08:15:49.1977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIYfClqpS4Chjr3l2WQ4tjujqz7uPKeufwlJKVgWK+ZJlmBvIw1scysGbORnuHICv5WtUrC1dX4pDG+9xlNWJ4TSH99leLCFhU/qJZzh28s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5080
Received-SPF: pass client-ip=40.107.5.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:15:50
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.07.2020 15:02, Max Reitz wrote:
> Hi,
> 
> When beginning migration, the qcow2 driver syncs all persistent bitmaps
> to disk and then releases them.  If the user decides to continue on the
> source after migration, those bitmaps are re-loaded from the qcow2
> image.
> 
> However, we only do this for bitmaps that were actively synced, i.e. R/W
> bitmaps.  RO bitmaps (those on backing images) are not written and thus
> not released.  However, we still try to re-load them when continuing,
> and that will then fail.
> 
> To fix this problem, I think we should just consider RO bitmaps to be in
> sync from the beginning, so we can release them just like bitmaps that
> we have actively written back to the image.  This is done by patch 1.
> 
> However, there’s a catch: Peter Krempa noted that it isn’t in libvirt’s
> interest for the bitmaps to be released before migration at all, because
> this makes them disappear from query-named-block-node’s dirty-bitmaps
> list, but libvirt needs the bitmaps to be there:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1858739#c3
> 
> If it’s really not feasible to keep the bitmaps around, then I suppose
> what might work for libvirt is to query
> image/format-specific/data/bitmaps in addition to dirty-bitmaps (every
> bitmap that we released before migration must be a persistent bitmap).
> 
> What are your thoughts on this?

Sorry, I was on vocation for a week, so missed this. I see, it was merged, still, I'll look through it now.

Hmm.

1. Why we sync bitmaps on inactivation: it's obvious, it's the last point when it is possible to store them

2. Why we release bitmaps on inactivation: after inactivation, the bitmaps are not owned by Qemu. The image is not locked, someone other can change persistent bitmaps (target Qemu for example)..

> 
> 
> Max Reitz (2):
>    qcow2: Release read-only bitmaps when inactivated
>    iotests/169: Test source cont with backing bmap
> 
>   block/qcow2-bitmap.c       | 23 +++++++++++---
>   tests/qemu-iotests/169     | 64 +++++++++++++++++++++++++++++++++++++-
>   tests/qemu-iotests/169.out |  4 +--
>   3 files changed, 84 insertions(+), 7 deletions(-)
> 


-- 
Best regards,
Vladimir

