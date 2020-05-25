Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD22BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77FB2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OZhwxEW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77FB2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdDUB-0001HP-Su
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdDSg-00087r-Iq; Mon, 25 May 2020 09:48:18 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com
 ([40.107.8.118]:56837 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdDSd-0000xZ-8l; Mon, 25 May 2020 09:48:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEqWLMFlNEo+kLVIUWr/nIkGejvcsIr4SWRM4DSr+vb6ZHF7bl/wcOCjjfv1GG+JL+rMBM2/hx2/Q+Lne8yeOaFr4QtkYqtinRNNpoxpeuF89LdJ/vtX9u+4wqwoGVwXomwnG1e5GG+lLCspIZ/xJx5hAmMqeSGqCqB+9296kFfL5PJAUergcKnCFOQ6DYh5dqtUjzTzpTkN4TTcDiQs8Y4EiESnRuG3pkab4thUzAPrX0wLKQJTYdB7SKR6dyCd17zQ8BOzVa7C3AqvtuNXsWsz0sannlzpyysDSi/t83IiOMdWcgeVq522Uddtab81MX9JSr6Cj5uS7pCwdB1mLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9TzAnCzYHvHkvpwldLwxj76lgylgDyOO/6I2DloG7o=;
 b=HSL9ORIW7JR89uw5vXhnGzaZ13/DRKXikPwqF5oIpSqi9Vm4Hodd59E63cPI/XCGDM88ddV/7RY0S5eLgjt0RxVi5KZbtwps0qwJgvDEtWTe3021jPhKLet2PVuR4JDandUGdBgNn6bfeni2M8UuWv0epdMWBKF4DziwyHME7HjSKLkFr5Hvw5LOEmMUUGx38tUu8/mT8jPNdIYS/0hOqFMYHjSK9/UaXp3TTTWFubPNOBIJEWInqupWN2LPd+7JUKGTVk3lMdsfPjEwmN/ePNA11Ew4ONB7/PvxS8KervrSUeTQTvLWuNIdvx/MB/iIseK0toXTEsnp6DGlbvlSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9TzAnCzYHvHkvpwldLwxj76lgylgDyOO/6I2DloG7o=;
 b=OZhwxEW2+I2pnqCPzosYytPAj9t0MsW1FyyLTRkCL2SqbnontZnNT9YlJZXEimr4tMmlBbe7wvkTlUDj9sT95XUttvpfM7l3B4OJR/ArXtH3rUJ3yD9pywRukv1q1If4mFs7/0d1yx5mRntQLsHQag3CwCcDKCoc4tZ71N/eMGw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5526.eurprd08.prod.outlook.com (2603:10a6:20b:108::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 13:48:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 13:48:07 +0000
Subject: Re: [PATCH v4 0/5] coroutines: generate wrapper code
To: qemu-devel@nongnu.org
References: <159041246428.2646.2773751210145691653@45ef0f9c86ae>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <13e2fafe-8897-c55c-49f7-1d9283949615@virtuozzo.com>
Date: Mon, 25 May 2020 16:48:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <159041246428.2646.2773751210145691653@45ef0f9c86ae>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.147) by
 AM0P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 13:48:07 +0000
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edf7db68-10c9-487d-355f-08d800b24178
X-MS-TrafficTypeDiagnostic: AM7PR08MB5526:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55267F3BC92752577CBFBB78C1B30@AM7PR08MB5526.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FZOsCdawXocvnj8KoOjHoIqowpOLPiK7S4U5tOSnr00jaBn4o5+i/rMF2MJ0wt2i1YbBrv1dEx7wyG7bbbUlAZUER1Z4is5pgrOkF55aHAUioZj5ZVkQ8icwMUIKpb/cYcpVujrsXzYBqU7HzCBRJfG6ickr89rjdWSatEVcTk62HIBMDzCTkZoqIjJnJM9P6b8e2Q7kYM6KlDrL1M8UWGyHvqU9h86ZNuEg1bCy7IM1dWPGwaE/raEBqFDpPC84hgbYr2T0Wcp0TagVS6fl0qsP09HsMhyhjjYMc7YX1X+Ev5OMX99dfeSYX3DrCzuVU2Ao0ffaTbWWZk5YUedBca7ToZXbdNlodlfmT8TDJKxfkGcEQLk7/r8o/3tFTE4G3t5McAAdeHAnWnJTSbh8NgjpzZQa4/wHs7pq0nky1IJcJMDY5kgQAEZojA6rjYhnE2VsuTjVcZTKM99ka5ktw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(4744005)(31696002)(86362001)(186003)(16526019)(956004)(2616005)(8676002)(8936002)(66476007)(4326008)(36756003)(5660300002)(66946007)(2906002)(66556008)(52116002)(31686004)(26005)(6486002)(316002)(16576012)(107886003)(478600001)(6916009)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2ags5CUPtafGv++loDZ5KbXK/Gn/p31i9p5q8VvUGS4H+otfOIAfBaLTGwc1HfM82TrUTIeoDVh/eTKD7d5uLaVQl0syd0DfyeGHS55rlYu8ulbhBH8m6D0Pyjis5fOlZCqFmnVYDuPLDvgDtuRGDDb0Zxd68KL001Pi0Z4EuK4XnqMinMxNoGbsst4MTndPx6BfBuwofN97Gpci4MatPXJ9W44SPDRBuGIqAIo2rSamu15pqe5wU20ax1xcpCaEKab5rKFoyR1YNLQsMum6nOVbW5nTwemk3IMHjfpEVS23Vyoa0EICImnjwxqnshHXYFPiL451Gd3+bOMogcRySoJ57IcbbPltaipWCtkaDlSv2Ts2J6+nhfKf0MF5SyIv7FXwy6DnheM6gurEcJOrrTtHzOFyR7548XdDwaCRcsFvbkzZ2ZdAMRjCz/FPEGK+5LM4eMfKrbwtq8iSGO2XrG79gv5FBnWuPqQxjrRaYEai9uKGV0SwpPSJeKhBhzaA
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf7db68-10c9-487d-355f-08d800b24178
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 13:48:07.7233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXvS/xHZWkEG9mSNoaDkCQl97lxwrJkRePZoJ7fM5isArn5SI9fj8V6P0zmbwpN66FxJJ8o4Qljm3h/VO3XK2c98ZJ/rIvxShx0afHekAXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5526
Received-SPF: pass client-ip=40.107.8.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 09:48:08
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.05.2020 16:14, no-reply@patchew.org wrote:
> Patchew URL:https://patchew.org/QEMU/20200525100801.13859-1-vsementsov@virtuozzo.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
> block/vhdx-log.o: In function `vhdx_log_write_and_flush':
> /tmp/qemu-test/src/block/vhdx-log.c:1049: undefined reference to `bdrv_flush'
> /tmp/qemu-test/src/block/vhdx-log.c:1061: undefined reference to `bdrv_flush'
> collect2: error: ld returned 1 exit status
> make: *** [qemu-nbd] Error 1

Hmm. Who can help?

I assume, that this is because I've added block/block-gen.o into ./Makefile.objs, and not into block/Makefile.objs. I'll try it with next resend.

-- 
Best regards,
Vladimir

