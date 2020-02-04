Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA92C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B333620674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BMR3oB4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B333620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvWx-00018y-SE
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyvVz-0000JA-Gv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyvVy-0004rV-7T
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:33:07 -0500
Received: from mail-eopbgr20107.outbound.protection.outlook.com
 ([40.107.2.107]:63876 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyvVx-0004kd-Fx; Tue, 04 Feb 2020 05:33:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BenHwYIbQ3ctqvidc0JG2W0Acqc2eCApQB4wRWHwaswBbCDZ+9NNjXz5ZKmUaGoJvP7lK+yDB+2eCh4xlgD6DnM9WeozdUKR5ucbI2nf25mF2rpZ6oG42Tnv/c8wQ3BDo5dRIbYyzWsSH29QJoV+0iS1W7wpWABipwwmc0z6kVGX2e4uVL2nbz7yMeirvg7KcfaQZizv+lMKywMUDIN73oylcas//2Zhz4Vq0TLkSIOxvQLEwIEqVvj8SlOoJtifme8P6Yp6tGJp9EdcxyTpNBoBlfZqOPBpVwhBewLAlxCfYN0p8hcvjQWV/y9MVd4eQobJqNpR66JxkzHQkDb9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJW35SjyvW42Knwi5eJtnrwioDM049QSmgqr+5n0Vpc=;
 b=lK9NUin2GL9yrfL63TiO6ivM0zAUVrSKaPCLPvn73m2OW52A9XHRSQHrxHkX9gJHgJHViptIKRzvA5ZUsYeSTmLkxS6giKAVaYICJljlLfjy9huLXG7PI0A392HumOI8LLtPVoBOnwDZ5rrPXrqIE27E+tflruGoHfp4gxFRFBywysF58VAuVln8QnT0tiFGVXL4k+yZaTnl54+5qR/oyrsbO9j8okTeTjjONUtTNl8PGwVn23dBmN5gorAZbDRGg/L7MtLAGp/zaiyJiwVVjTm4cbX/jjKE8Bd6Dp7kx51afPGYU/yGPpPlwEELxYBko81eFtzFpGn1aDph9Q29mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJW35SjyvW42Knwi5eJtnrwioDM049QSmgqr+5n0Vpc=;
 b=BMR3oB4CltZkrvq37x4/S2kp7SLTqux73RWjRAccpDnzKT3GZf9f8mPD5QJBwzKBUebgR6mWGFA8yp5AoZBn576lKGXIBaoJtZw3vyobSr5m5Xr7bXPqK2ryCbO4d3HfgZuXSgpR6+zJ2cbnJtTfZSh6cSnCLDBmfjNvxSWL57U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5189.eurprd08.prod.outlook.com (10.255.121.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 4 Feb 2020 10:33:02 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 10:33:02 +0000
Subject: Re: [PATCH v3 16/21] iotests: Add VM.assert_block_path()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-17-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204133300359
Message-ID: <0e7b9df2-9744-e950-4fa7-5807a750529d@virtuozzo.com>
Date: Tue, 4 Feb 2020 13:33:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200130214431.333510-17-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0314.eurprd05.prod.outlook.com
 (2603:10a6:7:93::45) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0314.eurprd05.prod.outlook.com (2603:10a6:7:93::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34 via Frontend Transport; Tue, 4 Feb 2020 10:33:02 +0000
X-Tagtoolbar-Keys: D20200204133300359
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d97be96-575a-4345-01cd-08d7a95d9ce8
X-MS-TrafficTypeDiagnostic: AM6PR08MB5189:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5189DC13BC313D9936400CA0C1030@AM6PR08MB5189.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(39850400004)(136003)(346002)(199004)(189003)(31696002)(36756003)(2906002)(52116002)(478600001)(31686004)(6486002)(66476007)(86362001)(8676002)(81166006)(8936002)(81156014)(5660300002)(186003)(16526019)(26005)(956004)(4326008)(2616005)(16576012)(66556008)(558084003)(66946007)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5189;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DI0QSLpr4B4znFrt0elNW40NWtkBzLD5gbY3M7hTenKyunTyRkHN3nmLh+7j+nnno143cBmc8zf1FaIBRQjOGtAJB3W+SgTVdD88u1lVVU4BFIV+rNFMQPdR44b04/0jFzmwg+53Dhwa8jiKrOmH2tRenZlerwzY7Qwf5ttaFgICxr85yZSAtU3ZIy1E3t3oS8R3OSO9CIjG0wU0yI2XsF5ZPL4jqwtQZyYtJOJTKPL/dWjJAv3WDiMuX/09cxjOKGQmULTJeLlHVMOt84VsG4doWocn3OEMEkBBP88gCwgzfVAhBSvBGRVvp2Wvh1UyWPxRoCIjVwqgdHqaE+UnBgwreGe+YHAU792BCPnIRiqhkLdiOLtWc6T1Nc4uNjbBmqC4fAXP7ozgdMMIejY/2EqM0xFCHu0fThGg2lvhLgyRrg3wDoUWNPBRCH9xn63A
X-MS-Exchange-AntiSpam-MessageData: 9nk8SmgBCX4PaSlfAvW9Lv68GFSUmHNSlPaKEFLpMHv5Z8Ef1cgzl0OlZxqX2yyEl+jS9zEyJGr0cRuS/XY08tF35phbJ6dDzKxds+LeGPHVdD/BDjXpWLjRec6utfO0UHYmMz3F6aHH+NnOH9n4GQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d97be96-575a-4345-01cd-08d7a95d9ce8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 10:33:02.6717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5CIl3a1JmhawqRjSRuEUW6Xx+1GyPI9whhoY6luYvCKD9PO7Gc5aWv9a08KiIph35gR7syN2umKeqeqxgqbd6mxo6G31q25BlTilE7yOcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5189
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.107
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 0:44, Max Reitz wrote:
> Signed-off-by: Max Reitz<mreitz@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

