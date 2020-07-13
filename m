Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE77C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E52206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LwhXyN77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E52206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxxk-0003Sa-It
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juxx2-0002xb-20; Mon, 13 Jul 2020 08:52:56 -0400
Received: from mail-eopbgr60101.outbound.protection.outlook.com
 ([40.107.6.101]:32213 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juxwz-0003k9-LK; Mon, 13 Jul 2020 08:52:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWo6R04W6XYKryE1U0HFnJ5tHkMruZ1bD6lNuA6qibF+YKAOGG/dhRRxxt32UBSvRSRCA+q8kszIAKJ8lsY+2iM+ghBmvNya40q/EoIEeYlpZyLLmGexEFmryz0a1n4fSxmq8nziMIjnMZSA2rQ2U2DFoRcWMTWMY0W/uWZzmJOCXB4GuUJ2FCBjviB2PFVxcGEy69LnNoRpSDjFkioOe1Lu5Qv4T+FLMDOrE9iaNY8pH6+sJYK55+qTIkMbMEjTC72oXUGOtIttKOUwItYIXNCJc90UyAu2G//Ecff25pZkOGu7aCQ4pvOw0x7MG+CsPNe4o5zZpMJrz31YQZIkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoHvId224JbYeNnj6bgkleFUCKzmy7hnicQPfeUenho=;
 b=duH3g/GNGDRqui+02cddHVGsjnX1bOXpTdG/Er8+g0XP5EXA5A/KofVhdi6kyzMtiTrKXDyy4DLayW0ESyQRNmPe/N6ZUu8zeCMVYTYSfrAPWa3BdEXPLxe8ZU0RmrK+VRZ97SdrtNr/XkZmLZdQWleNzO/zNr5z9ZtBslZSyz42E06ROY2eU0mIKxd/pa2vHP7jDDbcI2zZjA5Ax6ojDU2SvDiZFyxWX2gzzWyYlx7HnTonsbqMwWFkN+uOWqY6d61QMRqXAaIDd6kejAzwPuS4udyQjblSIdOqVgRN1M7AMj3Kki/RcoCsemjkwhjqHMeW1Jk2Gc4Yz6O2oscitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoHvId224JbYeNnj6bgkleFUCKzmy7hnicQPfeUenho=;
 b=LwhXyN77r9s6rCZ8/l4FF5FBv2Ys/7XKeWOaifw7VLWqnNpwUR/BCqU8vOIhyLbGSNGHf2PTYz/zcFh7oXS5azlXAMW4zvqO+o46g7d1HMjmzSNTTqZ6iLp4QvkAhkDxTWIoe+EDKWCI27pmZadMS+suLsteueKfiLo+s+PUees=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4786.eurprd08.prod.outlook.com (2603:10a6:20b:cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 12:52:49 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 12:52:49 +0000
Subject: Re: [PATCH v9 00/10] iotests: Dump QCOW2 dirty bitmaps metadata
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <1594625276-134500-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <f3a12181-8344-90b9-8c78-4a33263a2d53@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <39b75655-f55a-598b-7c6d-5853599a4dc5@virtuozzo.com>
Date: Mon, 13 Jul 2020 15:52:44 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <f3a12181-8344-90b9-8c78-4a33263a2d53@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR05CA0117.eurprd05.prod.outlook.com
 (2603:10a6:207:2::19) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM3PR05CA0117.eurprd05.prod.outlook.com (2603:10a6:207:2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Mon, 13 Jul 2020 12:52:47 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 439e6772-0395-48e6-c053-08d8272ba58d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47864986A5B010F93BD69485F4600@AM6PR08MB4786.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBZ3Z09N9F2Z3U2b6lbfAL3r7LBSmJG2edYnMtTQ9Gf+PxhulWwZj7aKZnCXMkcSMZboiIpEQxQzjdOMeMpNcQo1PEy9P2fJmCXkxj2dJl31Op74/2UKlGfS5KzM322L+HPR9tqris0Dto87bI3mpllG16VtJB+HBWUW2sfRotbNDRriVrfnwDRcMGV4cSqWPAKBzIgCfSsgpbx+HKFNZSNH4XcsGTrTOGDNZBYojwI8SFZzi9ffXXiBIUiw/yQDaS7pp0X7FsKfvVe5mdzvP8V+Mo+G1rV2jOQRAgvpcbBblN0OJAcUB1fTH1LZgGlgiJADvExJO6y0/5ZFANXtRaMivn24rK6ts6J3ZfcJBoKMigE3JFrq143HjCYp4wwbSX3C0iSfnPiVMyhEyH7MtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(39840400004)(376002)(396003)(366004)(36756003)(6512007)(31686004)(107886003)(8936002)(956004)(2616005)(316002)(5660300002)(52116002)(83380400001)(16526019)(6486002)(53546011)(26005)(186003)(6666004)(2906002)(6506007)(31696002)(66556008)(44832011)(86362001)(66946007)(66476007)(4326008)(8676002)(478600001)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rLlypcdlyH0WAS+pxaNTlPyujl68Od+0mD53i40tM80/OraOnF78cEgdVIXZ+MoC3QkYwrIXMRKlr0NA0CBpFDM39WWC+UYbuT+yEOC7HedPu4J3yKr1lIQo2WSlUX/Iv3hwBbTe9UfD2woLsVFaU2NZzH3mqc9YWFdPqnbR9ljD2CGYqb6EDr64G0u5L40RZtD5GCnea/fiz1WcnMnRdNGQZZQMWjF5LUAPNV79h89xiNgsDFsIKHuqUcMqhCJxusa+o1S+/aQcnRrLzPotI+n+EVJZ9QDc5ljVDS7k6y5qh9Zxx8yaZ2MR/Q5QwydC6l6gZ308pP3URfJufZW83FKMZCwY7TGKIWUS2wZjEFErPWMejBwvVZQwbzSUlvmlbVFBz0bn195LoFUXQUbnnKA+L3WgUlWkCdouUNrLaJgpOxS1ubXvvD3BO9ORWIx8vwujuKuHFWqvlRXFw0u2Lgm63cC5qO6g5qbE5F6Eh1xN+GwZOdsDBEU/RtHz9v0F
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439e6772-0395-48e6-c053-08d8272ba58d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 12:52:48.9311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgxugeyd+v83pnO9ftdk07BisuvOI++rwi5nVUnjzPcmlDuCe5sGkgL1mp/13fRd9NT1vvLdUC/l82qFPKXQNIyjveFla2k1cBQwX+NUnVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4786
Received-SPF: pass client-ip=40.107.6.101;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 08:52:51
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13.07.2020 15:41, Eric Blake wrote:
> On 7/13/20 2:27 AM, Andrey Shinkevich wrote:
>> Add dirty bitmap information to QCOW2 metadata dump in the 
>> qcow2_format.py.
>>
>> v9:
>>    01: In patch 0003, removed explicit constructor in the class 
>> Qcow2BitmapExt.
>>    02: In patch 0004, the format string was changed.
>>
>> Andrey Shinkevich (10):
>>    qcow2: Fix capitalization of header extension constant.
>>    qcow2_format.py: make printable data an extension class member
>>    qcow2_format.py: change Qcow2BitmapExt initialization method
>>    qcow2_format.py: dump bitmap flags in human readable way.
>>    qcow2_format.py: Dump bitmap directory information
>>    qcow2_format.py: pass cluster size to substructures
>>    qcow2_format.py: Dump bitmap table serialized entries
>>    qcow2.py: Introduce '-j' key to dump in JSON format
>>    qcow2_format.py: collect fields to dump in JSON format
>>    qcow2_format.py: support dumping metadata in JSON format
>>
>>   block/qcow2.c                      |   2 +-
>>   docs/interop/qcow2.txt             |   2 +-
>>   tests/qemu-iotests/291.out         |  90 ++++++++++++++++
>
> Test 291 no longer outputs bitmap metadata (see commit 24b861c038); 
> which means your patches to 291.out don't make sense.  You'll want to 
> respin this to follow the advice in that commit of having a separate 
> iotest just for qcow2.py output testing.
>
I noted that #291 fails in the main stream branch and was not able to 
test my patch to 291.out with that. I will take a close look at the 
commit 24b861c038, thank you.

Andrey


