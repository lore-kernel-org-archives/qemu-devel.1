Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B639EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F65120781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nJPAeWBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F65120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6EgA-0000xS-Px
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 10:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6EfK-0008SX-9E; Thu, 13 Aug 2020 10:57:14 -0400
Received: from mail-eopbgr60091.outbound.protection.outlook.com
 ([40.107.6.91]:14048 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6EfH-0006Ab-3W; Thu, 13 Aug 2020 10:57:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntyuL2y+VuPHhkwmacf7EMLAIAHkScC+l2gBB5aSAWgOXt5qmERAZl6anSpdpDHxjWj/UnV/Pnn8zHQLI2Dy87u03UGCaTyJMP7zv6LC2lZ4k7imQJLGxH1l4/rcYvO3W7SmurX3vAS/8c/aNzQTEUFla3QciymLLGTNvWwBtDsUKiKhk/3H8N4UcmSumsbHz3CyBq/wGUF8ao1j3VCFxD09hHkmRwPnaNQ9vgr54q3fOLVMR+cGbFtsYfyQGRZ2z9Cyq94YNxsOYr1oufdNZ61vVdtFhEe3TMRtA1oJnLy44VJM/L7B/SRnJtQnYHOOoElBVyYjsfFXpx+byPU/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=626heHCIQRI/4NAzIv88UQlTus4S9lxM7eyy1pCrJ7U=;
 b=iweZF++pLL0zqrClz2S6RmkgN4O8JJsyQmuxuCi1B3yvhUil4lt+vG3tHPynX9ui96tkAETIxBZi9BZmAy6aJUHkBBPTUnmxkuYAgtNWuXjzN3YXFfoOitiN1QcfmUcGBD8UC/KekQxS9A9Jhg9XzYB06R9uJw/fH9xgDNcB4OJYnNlKpb31/Q5cz2+6QS/uTENluZXv779bC5PGHMjz93PeuOaUpt0xvl1CTLBirbAjm/md0d9Z265G1+Z+bWsg1u14fMPYUd7WYNzQbAAwYqyw9HAoprgP4eF2rjJARhvlWvnRTW+N/zeVQF4CzBjC8j55inrP0t/hIm00ddMQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=626heHCIQRI/4NAzIv88UQlTus4S9lxM7eyy1pCrJ7U=;
 b=nJPAeWBTR0EZibdK8bX+rtOrfr5jcd6+CgatvIGSp9xkY3uOuaIG2p1TRmTosAYiw99WN0RIkQasnuyBEUbdNCMs+ZJQk8FYvQIlqezH0797Q9eKAg14L9SuA+bdX6z1DNTCmznOpob0xOrtkny4IJ1JS/q1Pc1YEjpJr/NdFb8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2417.eurprd08.prod.outlook.com (2603:10a6:203:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Thu, 13 Aug
 2020 14:57:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 14:57:06 +0000
To: qemu block <qemu-block@nongnu.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: What is bs->reqs_lock for?
Message-ID: <ebea1375-8bc0-2b0a-051f-28b2afa02a1c@virtuozzo.com>
Date: Thu, 13 Aug 2020 17:57:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.139) by
 FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Thu, 13 Aug 2020 14:57:05 +0000
X-Originating-IP: [185.215.60.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25b73776-756e-45eb-5fa0-08d83f992523
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2417:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2417E9E8A7525B48BC4F2FE6C1430@AM5PR0802MB2417.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajaMeg+GfddtUOdlkWnRFb7TqGUvKSL1/AR8MFRAR6Msn32xUU6GAK+dWEcLvhTQZt/q0C09LQPAbPzzYulf3Ifmxvx8y2dWhD5QypqX5tpEZQ7Hb040p3RRf+W8dcQ/lmMQiel6bj0hkL5zOP7Sxdk5Lk3NvsaPkL8yAHKLQwEoK9pkqD+Kn9X8cpEyYDYzu/oCnIZL9OrlQQcuHOjjaQ7kGeydTboOuIFCXTrhEKkjtJ92gcsLKU5+RFLk+pAQamRFyMyG6fEqugXrOGovNOYLAygro79+4rHqHwf9y4UwSjYdyrhj2JlgEyB74FTcUCRJXyykOGdlbqOj61EbYpzKvDCKyPrMeAs6B8LCY+g/86iS9vmozPXjh/grhj8i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39840400004)(376002)(396003)(346002)(86362001)(31696002)(2906002)(4744005)(52116002)(66556008)(83380400001)(66946007)(66476007)(36756003)(5660300002)(31686004)(16576012)(54906003)(316002)(26005)(956004)(2616005)(6486002)(478600001)(6916009)(186003)(16526019)(8676002)(8936002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8oba31iN5muhmIJbq21FPKP6vQkZtQMY1L569mbzGNBZ1LOZXZrYtZ/xL698UvEdHLXcklDUmI9ZqqsyD2wVnLnQcuw7h5lOC1x0CPF/+a/2vexta0gPunT131piLQYo+NPj0e62/B+8yJdf0P1Oor+bq77GqBbsdQRWSTBzj8P7kFwwS9huY0QCw9240yeMG2X9DsnrMQ63Lcr1JiunoYY4BhydQ0/vgF3OWgac/OYBLmgGuyEcjt4kkAUs0UL09nEf4WHtNUt7susiTlBNFGnVcGPTd9qorr6TmAM1uqDtAVTmur+/oqtqJ8Gj+uO7H2qio9Xq1koEPJXMX30prd4ENg/RQZLa3oDYkbx+nXubh6wDXIOMuSFc4pZ5qyjK/bLw+MJUbGI3VavBTlwZs5+h0f9o6duGAK3dAcsaSOzATXGhz4xuT+tmufFm6FtHOPdbf/RA79q0+Q/VGc02UzOtJkQc9Cd2H8rWWCFfixshBD5yRysip5RfgFN8vFXVBZfJQbpXqU3Yuz/2Vhuc1UebfT23573rNNBTtWifnq2W2Ke/1JMzGgAiWmpLgRnAjjrNc8UFbeQ59NeakjVQgEaTaZrbMfAJmGtg02dCb+ipU/z+VJ3STTcEA1dLc/aP5Q2jj1HvB12sD9m7o4zpig==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b73776-756e-45eb-5fa0-08d83f992523
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 14:57:06.6929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DZcxkHb2cjMMUBKy7vfmTHhhD2LnAvrEOK9BwtHHk1/ZV3NKeg6aMuX3A04ZzItH3d9ZGT9BOrNQNjBWUND+DUITUD3JllMq1YE1O0EzyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2417
Received-SPF: pass client-ip=40.107.6.91;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 10:57:08
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

Sorry my stupid question, but which kind of concurrent access bs->reqs_lock prevents?

In my understanding the whole logic of request tracking for the bs is going in the coroutine, so, we don't have parallel access anyway? How can parallel access to bs->tracked_requests happen?


-- 
Best regards,
Vladimir

