Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD90C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9906206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iIFfw8iu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9906206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDkO-0003cA-1b
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDjV-0002M3-V4; Wed, 06 May 2020 02:40:41 -0400
Received: from mail-eopbgr00112.outbound.protection.outlook.com
 ([40.107.0.112]:33101 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWDjV-00089m-2d; Wed, 06 May 2020 02:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOPbQf7NDoHFdWEKcB5mIqra5bF3rYt1ajhpPEGLqBUecR5DU1Vey8XnObAStN1vu7Zd5+94GnltbUa01dXPB0RUyEOvlJ8xUVn2ZJj6pnk0P5NBpnOPCcfCPv7UCEp1X8D9bQCWMvZx61yVaUVJDrdhxvUIw+Yx1sKT/q/qROPo/BijtiHuwsWvbOVpJkP31XrPLo8WKw6t7TrFang69hmDtujRzdlqM3U/y+UCLCHkQxWNa7RlTi2v8qlobfNt5A/7162AQtzcFjMnAPdwq2O+fvkNm3khrSnLtgnwLsdjtrNX4e24hHT5TbbmrL7R3sB39k3gyBVwWk7ymsdwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNCLTulSU+mPNKRI08iRXMMh7C4CE22CjCN2tZeMhr4=;
 b=buohPoVd04CDHGiDNFORnhfjCsfuaPXAsB22+wJIgLiF2nF1wPYwUZuHsb6IPg7h4WxCk/FQCqyUSIM2RlrocLZLRcnP0zcvFzKEl91oYlk75CpFDUiKgeS8ZzPZ4VpBVs3MnnRlbHGuZ9e1R7xAuKBspYkgfcbAr/G6e2eDfWNleciwop7YGvw1JFc8GRzKgo92kQtfo+Y1x+w2VPXA9EKl1LEAsNB3w4HhK5E15NUmqQxJrOALee3yzu/In5Y0kwD8YjQhBvN1g7VRJc2qeZ+MuR5EcHAYf5vs0BvOiqABEbPXvk+UDFUGLX51h/b2e77k0ENy2zol9WZMpAatWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNCLTulSU+mPNKRI08iRXMMh7C4CE22CjCN2tZeMhr4=;
 b=iIFfw8iub2sR8xhYpQvWevj4woEU6KyQ/s0r9ZxmU8Enh8Ef5YlCDNuG53h9JnkHJlMrIylLt3Ct0aq2Kz8YIFpkldYre+MkNT1pjWS8vqq6wA9levpkbhJudg2U3Is0cZsrs0D4B2DSaC+EPTBepWRr/5Oaqw1Y7r5HR1nB26M=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Wed, 6 May
 2020 06:40:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 06:40:38 +0000
Subject: Re: [PATCH v3 17/17] block: use int64_t instead of int in driver
 discard handlers
To: qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-18-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506094036486
Message-ID: <257a2630-7c36-5e48-bef8-804b0b0926b2@virtuozzo.com>
Date: Wed, 6 May 2020 09:40:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200430111033.29980-18-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0050.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR0101CA0050.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Wed, 6 May 2020 06:40:37 +0000
X-Tagtoolbar-Keys: D20200506094036486
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07d76351-01b1-429b-df64-08d7f188639b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336D634FBDD212F0EC8F538C1A40@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOE4huJva9DDQD0eh4SgKZ/OUVtC5gCdodUeSjlPGI9JOwq5s4ttEj7OOfLZHuhwphCAKjs1+uP16788JBgN+7uqkUwVUxQbgA8fkVg2p2kZ9PWTTJAOiRRNh1L1P4SdD6N/d8lLonQTlDqmnpSSerz4L4GeLrSJd+oZ5gGLeRDELVH+NPU0F59NcY1cVlKVOUfXtqsesb5KLY2yJK+AXSUCDCMjqs813wwi5Yx/E2Ich1SzSUtYa6cfrrdHyk89FdvlM6syIkXu8Vhhdo18W2DLBbOAF3SUQSASUdHlSnXnC6viUpfjds/Q4x6FdxpJGn4Ea5m87C8MosVLRHIyKGwJM3h4hwTyq9cJQKmccl7TWNz3I4w20ZYiHxl1IxwJnXvwe4GheYWL7OUJ/1zQx6R3dgOpWR2ycYpoWLOAAMl5lsR5k+YkHlJMFxXSVO8d3XzYKsrDbMBxPsxi6IwW0tLXmXVKwol31+qbvFfjypq08tkwNTZkbgLOEdjcmifHTw3HfiN38sHQHsIbqHWaPqYROpmua2jMmrZHXbHi5ZtHrepz41F0mp/w1/q9azxQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39840400004)(136003)(33430700001)(316002)(66556008)(66946007)(478600001)(66476007)(2906002)(8676002)(16576012)(956004)(8936002)(36756003)(2616005)(7416002)(6916009)(4326008)(26005)(5660300002)(6486002)(107886003)(31686004)(86362001)(52116002)(16526019)(31696002)(33440700001)(186003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DYzfjZTEjkxzUrZIkXDDjG13/TZbkd7q2QEm+yGKseQ2q7y7YabEVSEzlroWVFF4uSHfLEMTjmpF56i8vlzEqUlr+KatQ/nq41+ZaHVfDoAJum23iF1kMnoC6pkoHldUvl8t/M84D1+KPaDSmoR66ysacZXs2kTpB1Km0HEuwr/vSmYj2zhG8m1l37elQG0Ch3CQbPMHp0BBkii4avqWnOoFYZcC0nzOQpH3fRgWXKjwsQkMvIxmGXXKxWbX7WJhnePRIHp16dOXY0N5gjF8sZTjxw6hsq3vt2B2kvBoqs3njmwD2MtbA47rWD7H9jkoBo9VpYpySqAkUoI6xhczTSGLA+PH20kYtOZabAli0EcLXJQN6XH/8JNWgHbHOq4tB+fT8dVqRvsh9Kq/Dhv1jPwYrpD5madGOWFqO49Ouz6EbrBIopQLZGXqpV/7gTq67ZLF3FJFrvxOG2VsmkIrdN8z54VMHnvgvelUyehqAvpgPlOOjI3YnV0ljGgKcGb2jw3cfuWZmeCDFBUASDB0NKcq/9Vnp08f4/YCc5UVQDWf7sDoA6Io3AzhOklq5JC2zh7TSfF3X30SCsJkshrIdH4ucPK16cSF6M6ASoLRbn1Lfg9pebB4Hx7S2JmpJkqXOgnCCAl0ht08/5Eb7+iTfQquP5SZ6CPn6PjOzlXcopeXXR5bCgbITm87fdofL+qXUKpBnUyrpUZ9+W1N1Jsns4/cGZ8LfBQTGNmVvN/d4TH9y7xo8r82MLhdCDFUy4DMzLdDv1L6LiQNPao73VocppjCkdIN3n3qroQRJlLVtA0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d76351-01b1-429b-df64-08d7f188639b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:40:38.6804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NE7Zg0kLVopqwbVhblBCN8SmJnFd/MfLm6W/hmnlmiZFY7aIs3Q+6Ym0U1jbJ6YMapDWMG3/5pLfeTAfzzpcj3XgYKA3EfoAhqc/yFAHCQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.0.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:40:39
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.04.2020 14:10, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths.
> 
> Main motivation is realization of 64-bit write_zeroes operation for
> fast zeroing large disk chunks, up to the whole disk.
> 
> We chose signed type, to be consistent with off_t (which is signed) and
> with possibility for signed return type (where negative value means
> error).
> 
> So, convert driver discard handlers bytes parameter to int64_t.
> 
> This patch just converts handlers where it is obvious that bytes
> parameter is passed further to 64bit interfaces, and add simple
> wrappers where it is not obvious.
> 
> Series: 64bit-block-status
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>


squash in:

--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -48,7 +48,7 @@ static int coroutine_fn bdrv_test_co_pwritev(BlockDriverState *bs,
  }
  
  static int coroutine_fn bdrv_test_co_pdiscard(BlockDriverState *bs,
-                                              int64_t offset, int bytes)
+                                              int64_t offset, int64_t bytes)
  {
      return 0;
  }

