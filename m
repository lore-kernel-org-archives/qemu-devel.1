Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF91BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF0B20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pX29mK53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF0B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywbs-0003yf-0s
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iywZO-0002ZD-4s
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iywZM-0002He-Sq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:40:41 -0500
Received: from mail-am6eur05on20731.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::731]:11009
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iywZM-00023B-8X; Tue, 04 Feb 2020 06:40:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF4gL5fW1/ky6fMAAvfhx7nM/GLRAoQRF8RtT1xsNtr82OVO3yxX6R+zyvrxaei3qLBFwainRcfGqH0zT7nFcdCW5CgOA03PCXWCt+B/pz1v7Ta0ECSwKUgasFJlZ5OzP5GGVkT06ZvVsXmn/LIZQj7dYMGos58s7FzkpOD6Ahn+u1StXgvOB/FDpYpxij148fqogRj3NcexCxsduxY7KkPCPZoqnG5uSJeMpuq8EAZAwa5ZKOFHDTq7eKygSRqqLK1RH/SupaJi4s2SYM90c+pmPyRX05+llR/oBKOmp4bkvu9kU6T2HLxuXWzTCrtuxZSLJJWEYHv/Bri4fu44cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpNh62No8brd9JuBY1kEZnyxxLv/vvVGfVAQk6S4OgA=;
 b=aVjCNTQTrXE3+CDcBEe+2VhTXU7c3xgMViWQi9c12TXi//3h3t2JPWmnbUwK91GWyOmvnhm2Avns0hifUluZRoECuQxoIaSsPxAp2C6djPkvkWDvWorOZQnCv4RF6U3q2UZUe1/QYwyzE7/n0deNN93x/MFIW2DFMEPe2fntyVO/L5fimWObzBQ8Yf3L54Wqeu0yUP92oXkQgbHuG1GTtOeqwQ1K2WQQtRiMrIW6xjX/RqMZMGs0Y6OBvhSArnUVGhtMPRB6NmZrpkpXb8WfnBrMuSYhWYVU1shWkowU2VlM8kGDB6M3zQt8yENf24zCHDoY63hiLGa16MjW2aQdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpNh62No8brd9JuBY1kEZnyxxLv/vvVGfVAQk6S4OgA=;
 b=pX29mK53HAZRBwM/5PUt7uuubSi4Jud8n6AuZPsPvoEwazsTNv/BZIBSzPm8cIjPzI+Zq19Tt08uMUJBf9UMPLeptOqaRQyF7QuB4ngu8gsDVEpD2ntVF834xO0rWsP2WnD9sfpCFXidG9VhhQGjt/5aaHtbFTpR13r1O54Szek=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4501.eurprd08.prod.outlook.com (20.179.5.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 11:40:38 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 11:40:38 +0000
Subject: Re: [PATCH v3 17/21] iotests/041: Drop superfluous shutdowns
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-18-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204144035146
Message-ID: <13dfe32b-db1f-3c18-ec85-c0cda2cdbe0c@virtuozzo.com>
Date: Tue, 4 Feb 2020 14:40:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200130214431.333510-18-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0061.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::29) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0061.eurprd07.prod.outlook.com (2603:10a6:3:9e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.12 via Frontend Transport; Tue, 4 Feb 2020 11:40:37 +0000
X-Tagtoolbar-Keys: D20200204144035146
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f550d5-f60f-4b2c-3f5e-08d7a9670e1f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4501:
X-Microsoft-Antispam-PRVS: <AM6PR08MB450186C4DD11C1138B866366C1030@AM6PR08MB4501.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(16526019)(8936002)(2616005)(26005)(186003)(8676002)(81156014)(956004)(4326008)(31686004)(36756003)(86362001)(81166006)(478600001)(66476007)(66556008)(31696002)(66946007)(4744005)(316002)(6486002)(2906002)(16576012)(5660300002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4501;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4MOAsUeLpyOCpCvv3S/kYBCtHCNWWyB5pmfmk/45/oYPlCmjVggfE44M4TxAniJPtgj7X4FIa1AXqn1R4cunTelOry2MtTNizhp5AY08mcFV2fcrycAGoSp0HWmWL/+Z6MJFcuKbmcPvuNHPGr4T59Mn34rYmZPfo+LjQFDHQN4DcRxOIG38oeHZ4ou4yP8z3IDS042xgojsie2HkGQQYlF4z4KoOj9vV8LvT4pkEph06yIgfUvPp/qfitLh3M1PtapWscbsyb6bPzcsyjiqe2CUwBSAXyEJY2zPOXATGUb2N+jFnHjskJo42H3rhjRonkpFbVTCbwyC54v9LU+6YtfOX9xBSEHZT4Adjc4HMWnsAPsbq7qiFswv4xuCh5M1krXtAGYRzHavxm8I5qpHs8yKQWazEpRsaqf9w/jWUjfWlo9JoPl0v5M8kwH6v/I
X-MS-Exchange-AntiSpam-MessageData: 1bpC9dzZTDvUV6gOEU7bV8SxGwd5dnDZgI+fY6eaKvwTT/F8bvNSYEbuQXfHOJXOPcpKGuf0ejy1PzOlXxJny1DSGvuSulHKUCth77BN/equv9FawxWuhPpXxSlNtCJcUVegBHablOY2fIz4yrM0Hg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f550d5-f60f-4b2c-3f5e-08d7a9670e1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 11:40:38.0938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftgc5f/EHVKJ30sUVz3MpW0cXnYpSOMLZEFZEmPClxKkWKTnVAqPPOuBABJZs5LWJVEgUZPfMxI8akCN/VBsrIvmrJHV5B3shz/ZG49JdBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4501
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e1b::731
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
> All tearDowns in 041 shutdown the VM.  Thus, test cases do not need to
> do it themselves (unless they need the VM to be down for some
> post-operation check).
> 
> Signed-off-by: Max Reitz<mreitz@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

