Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C39C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63EF2166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WOQ/sSlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C63EF2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyubl-0007Go-13
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyuas-0006AN-Hz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyuaq-0008G5-VF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:34:05 -0500
Received: from mail-eopbgr140107.outbound.protection.outlook.com
 ([40.107.14.107]:10244 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyuaq-00084V-9F; Tue, 04 Feb 2020 04:34:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msSgGuMi+erA8wjJ3A2tfEHc4VsJu6yiD/ePx9SSwvC0WujG1Qj+FJzonu9JbPY/6V9r0UgwUTKs+uzkGZpoy6nif+xh+/WpCwRMHeoMwEKhYf0ak8oZAldFISMoKM8MmcqpIN3Aqx87KMUNmVzVvZaNzwUTRFkH4JqpxKtewuiHqlYabXYaotYLXTYRxPjHRLycS0N3fL0+bRq8tPyt+44bDsrdfiUJFMCnN4kMvd5x6yjqHc98esHhEjzVV0L+6M6PWWJmBBqLXIf1aXZHbjYyzOW1vmx8hG1qkJ6mP99FrBmy2R6cvQISGaEpW+o8XlZOo5Rg0ge5HHTFgvB7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkZWOQaEWM6jYlOLHB481Sti1nXSn4E6N4V/4HALmkI=;
 b=Qy5KdHs0B4zi9RFvM6SsHWEJEfJ723GJ74GxUfutjGZIf4ujh40gNRVULR/A1eoOUfZLW+1XjubQcZfsOs7aa5W6JB8eO05tirUH4xiop+plwni7IRIBKpebe0zMULetYA7IWkr/MjBs1GGIQWvHZ2iTpIcWSXNlReyI/QNzB2CawC2ON/mjTGXXamxQPTgkEiftQDRYEOkZXuezDRxRrZvunDBOwgQRzbAZLxgo+HAKhCGNQf58prP2y1SVNSDUSRj0tnkGn4kQUCYeXa6YN/7eY2ZXeXuxovxNFmA42C9gWVRFklKTJVU5EkiyQXnxahbhGt4vgoKYIVO08ByAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkZWOQaEWM6jYlOLHB481Sti1nXSn4E6N4V/4HALmkI=;
 b=WOQ/sSlBlcCD/+9lhj/VaCVES9j2GT1JD4e/FGl+5hIdIkLFrM1wCAw2wMF1nVRsgdUh/Td4bXpIWIwbiwR6ve5CfnhiHEx+6MWFBFg1f7pASO2aJA0mWNoVtXo6anFxYz59L1odmI+F1uED9lmOdDHxS7HITicsTSIH8rJyDEU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3463.eurprd08.prod.outlook.com (20.177.112.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Tue, 4 Feb 2020 09:34:01 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 09:34:01 +0000
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204123359542
Message-ID: <fa1a42e0-bd13-8def-0ddc-3947ce89f460@virtuozzo.com>
Date: Tue, 4 Feb 2020 12:33:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200130214431.333510-10-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0301CA0022.eurprd03.prod.outlook.com
 (2603:10a6:3:76::32) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0301CA0022.eurprd03.prod.outlook.com (2603:10a6:3:76::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 4 Feb 2020 09:34:01 +0000
X-Tagtoolbar-Keys: D20200204123359542
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f4c293-c2c1-4c1d-8d58-08d7a9555e4c
X-MS-TrafficTypeDiagnostic: AM6PR08MB3463:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3463F330DA2554FA7DE83CE2C1030@AM6PR08MB3463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(316002)(16576012)(478600001)(31696002)(36756003)(558084003)(6486002)(186003)(16526019)(2906002)(2616005)(26005)(31686004)(52116002)(956004)(86362001)(5660300002)(81156014)(66556008)(81166006)(66946007)(8936002)(8676002)(66476007)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3463;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kb5AuvCbnIRtXmk+li5e5phhNsEkuXF3XtyUaa4xKualXWgKDA8mG6bd0vC3WnCk7wJO1I7bSUEr+jtSx4n/ik8KYjfU2grU5L9kPEgX90dpzkYzsqoXzEw+2Ba+SnHapJ8Ezbv63u1vajNuXqDT88Qzqf63Ikf6yTxxWufGUztRRFLxSxIeoF7wO53iZUXn+GCll5d278bVVQXZKXNN2yu4fiXpZqv7Ancb+Bvm0YkxSmm+ZVUNddRncw6rxwLBdMqbfc/TH+JbxuFEVpj40jipWApb17gJAmHM6EE23mCsT1b1wTdDzz00Z7JXOhPwwWiB5PzMcbuFExYTCsnXmtsW5rSNSFQV9HCFt5G0rb0jpeBjDWDy30SbYkQVodnfqGvmW6YPw3ozuzVJIyaMoSH1nv4H/agyrMCHmqRLJ1UF67XyKLo8h+7ZydJeFGo
X-MS-Exchange-AntiSpam-MessageData: oUhu8SKe7jYLMWv8K+VVOWQsIHH4nLU7S8yW8zB7ndk3HTgW5n1hlMh4niv/dedDutHLgHtBrdYA8zFivgxjQxkylT+T2AYU88JV6eCV/2tU7L1bAbY9tV1kBXluk+Y/0+ks9pJq9Qzjv3BgR8mrjg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f4c293-c2c1-4c1d-8d58-08d7a9555e4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 09:34:01.7043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /spWgim8DJ+MySdk/5zNwj6Dp/yQH1dyGUYxSY1K7ZV6+OZeiLmYaJtZQroxAsCmEpOYEwn7cS+NmOlHW2hSwlrtfTlpiepAxHMyU+2II0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3463
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.107
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
> We will need this to verify that Quorum can let one of its children be
> replaced without breaking anything else.
> 
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

