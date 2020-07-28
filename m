Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C76C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7381A206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wQcDsag3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7381A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Odg-0007eW-M8
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0OcT-0006PH-Ii; Tue, 28 Jul 2020 08:22:09 -0400
Received: from mail-eopbgr30104.outbound.protection.outlook.com
 ([40.107.3.104]:48514 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0OcQ-0008S5-0F; Tue, 28 Jul 2020 08:22:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGSgm1l7/WVcmEoIoDDzMz6c5uAXOIkhd8jj69G7VcrZF0QHkiebNZ3M56/DQcamfweSRAT8b+Ms8nkS3fX1JMgeLB4xUbkJzbjnCAQWut6ZFUNpuMU0Bv+S4G7rxltw6I9XfIVKlI5wiBj669nF+qwwyzHc11+tlvr+5BayF4EpBlZOqwx4oIPHm5nKxmJUwPDBs/A13LXrHM0qTJctWDr+L+6vNWUB/5drLg/HHhETLbt+vtiME0aN1dtIRzbl5mcTC6RQtAkpT5bFDSdhEVs9cS0Cp3zUdIFWanmuX+x3q+vnWXfCLYQz9X29Bl8UT8L7eUsHoIFV1aTTZjAFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOJnfoSjXk8SiJWxil6hb6odLx5Iojea3d1T9NAEVTs=;
 b=nHzYN6pBYsusuyF5wkn7RdCFgAKPnZgRWIX92zpUlQv12u6zoGX5tI3uJ3j4FBo6EAPQaeZG8Meo8J4JXa+5mpdJbH821emxUUE9wPELMi9LH6yEJopziaBnNKd7gJWRcKiUGieqkQg5FV7S5V4W9TauYnv7HCD2PGxmF258Em4dA4bdkq1D5rOpSY9bx/aDC3MKLxrC+/+wNk6P3c4ZUdBncJcIGF86hu/2M5zOgcqQcNx+nctiqSUeri54K3aA7Ajnu2cp+c3RrWD+G+j+MCovQLDRmWDqgBIixyt2Q9kEf3jpuGgnLJP9fBxv2hkGPvm7Rt6f8t18G0msk9pfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOJnfoSjXk8SiJWxil6hb6odLx5Iojea3d1T9NAEVTs=;
 b=wQcDsag3K7rR0wF2zD0+u9ycx/73PHhvR70ppFWCwV5YIIMqdqWgfgW0mzR8AmGXhuE8Xr2DSg4K3iG9PVqC0i1KXsPSLc/49H3dfHTYBgwTfw4mREa5kL65BVXXewZbRB1IiEfKgdkzZoi4m5WuF2RjhpgD+Tt2DEF9RUQBqJ8=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2449.eurprd08.prod.outlook.com (2603:10a6:203:9c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 12:22:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:22:02 +0000
Subject: Re: [PATCH for-5.1 2/2] iotests/028: Add test for cross-base-EOF reads
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200728120806.265916-1-mreitz@redhat.com>
 <20200728120806.265916-3-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <917dd504-294f-183c-19f7-4daafa13fe7a@virtuozzo.com>
Date: Tue, 28 Jul 2020 15:22:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728120806.265916-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0123.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::40) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM0PR10CA0123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 12:22:02 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59cb6476-d66d-48f9-1e19-08d832f0d574
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2449AFB3E639DD9755DC72BAC1730@AM5PR0802MB2449.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fvdEJLVcBVdXxSra/gYr8V8kennnH4Bn14eD/K8P/6g6YWY5aCP4ZwSOEf2I2TnSwDBt6aBhr/Shh/hCfANoL/PiaKLGHLeJmLAX+tu6OBqcqsqZ5RjdSmYNktsLNXc6Mwk1qy9fALt8nx9/GW+PrQ5bBaHCQ9ssy1j61gZ1+Y3gtGfZ0HbEJoD/hrWLvleeg4yqO8twdPQ8IDq7PE3h6Sjjj3yfoCKwkeiivuKrWpvCJJRGmhsus8p1kkN4p+EmBluvCJTdJiJWTa9kkvcXV9/iOcKgLa2kfzB1r5GLvlt5XKinLbgIARQZ9rqhcxVjOgCG46WfJbRZcitR8QDUlnUkaPC8dW7OsLbjtgZHVBi+AxQSjwSUtXspC3fvSfz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39840400004)(396003)(376002)(136003)(31686004)(31696002)(5660300002)(6486002)(86362001)(316002)(36756003)(54906003)(2616005)(956004)(8936002)(16576012)(558084003)(16526019)(26005)(66556008)(478600001)(66476007)(2906002)(186003)(8676002)(66946007)(4326008)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HNph3/V2gROe8jNNU1t7nn1mtwdmleOVeMRuq3DD2AA0fvo4wkHPdWhW1qTGHf8pgDXHSD7tZek7dIuLX8dQ2DWZz84zQsSA+eO6UTjLjpai39nCKn51SAGYjzYH5U+hstq3/vLAvpKMpxs8n2V7dZAcNJQvlN6C5XjAo8/pxgsgFrPA5l53ZsfCIHI9mvu0h5O4N4Df6ok0Bre+TqZFzgEK/oEm0A2vSYjblkfHTTKN/gvELztEFrjUvOz0M97fWYk4c+W80blrb1Rce97j411xc07AgyYGDOJsTOQJZkq9xt6XxkVHKUmP9GtFA2EqN/b4aA8Mc4OiFNEAwK9ol/D9DRhslu7tDdA9nCn9d4x/KpRYHCfYHYg1D8Yo15yxXBYje9ldA4qk4/6SUyOQ667P7jmaoiBzJFJC+NA1QNVcq8BiVI750O5antqoyJCH+zSLJLvrnNXYl81PfeR1A94c+8zaNEvuF2ZfTP0hNCHVzNlXkBcHSS/OFKEqpPxC
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59cb6476-d66d-48f9-1e19-08d832f0d574
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 12:22:02.8318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDR43H8MyeU7ZeOCFsp3cS7Kz/G6UqnBAcP9inYNMHGMRvpVAIWYp1vd5Knynz2JBOjGxgZ6yQzGUkyy/l2Qrx5NxPxn28CMJDZq4b+mK00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2449
Received-SPF: pass client-ip=40.107.3.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 08:22:03
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Bruce Rogers <brogers@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.07.2020 15:08, Max Reitz wrote:
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

