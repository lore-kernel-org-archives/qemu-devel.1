Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CC1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69609217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iuXm7+hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69609217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv25-0005qS-JT
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyux1-0005b1-60
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyuwz-0007lu-Tk
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:56:58 -0500
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:15889 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyuwz-0007j5-Nk; Tue, 04 Feb 2020 04:56:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccCKVCm7/bamPlELwUiTpdAiGoMbN77Ziw7N8ofrA1op9lxS8CLSy1kQhf2lC1+qQ+5k5S2OxQwNSBnT7jhakeL8PtgUF9K0Qxo14Z8FXO7szJFqBzF/+X9vyIl8YgN82AZINxD7keSyGzJLsXCBxvwluJg1EYOBuazQl+mdgfb9j4EwHeSAoL+Vz2fL6TnDxVtgu6aigyiEy5o4PSSX09k1gUIVthF/wV4b1f1fFu60xdQ4kw2172aS5cfZdyB8iZcCk+eTFBnd3Ow8MlNLM5Ljn9tXIZ3L4UiHghYIgV5fAYm3R6SKyg1f2gr4NfGRgqQwcmp7U60yODOxu3MHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twOksCFA/yFOk85MTajzb+lRH7v6w6mC8QGhZdR+PTY=;
 b=PzYrA91LeoZs0ZLSFR4yPDz8ylE2Hmyb4FoVa8sS2INa4Y1A3ToB5dJs747ksDcRKtcIf1PRqOGXqJAQW3GMf61sw1BT70awDIvNDuY63YDwJr32oIYo0y1E0L7P95MC+4zyrbmABF0ddEO2mkQkDhQsjT8sE01Fgf/3zgj3eSz/9nbs1oszQDw9qwQz9AUNfniih1zuvylqPdUftdSoHpsPjGBF0ZoVCLiAdBd5Qf4PLT/D1EGlUFvS8sWxcGt4lr616mAjytBF296h3PL/djdHca9ExQPwSnafGin+8VdjWr66kGPw3jtnQmDfTcIOec7+9YKy8Bn2go/1NPHdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twOksCFA/yFOk85MTajzb+lRH7v6w6mC8QGhZdR+PTY=;
 b=iuXm7+hzHIDzIzdZ/rrW1N3fwucOZNLvHaLxkBHS2tGZh1SJW/0CekyAn7NEcqkY9ya0u+GmxAxaPceVd1Z+Jw+esNFR6vLXOja94kygqR+KSSwp8W6Kqh542b/ISoeCrEO0MfAdd/58xR4xLAhbVgtqaQpBRiJYLhTLfVJh9tY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3958.eurprd08.prod.outlook.com (20.179.1.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 09:56:55 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 09:56:55 +0000
Subject: Re: [PATCH v3 21/21] iotests: Check that @replaces can replace filters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-22-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204125653927
Message-ID: <0d5a3ef4-851f-9217-b879-55d1e0427708@virtuozzo.com>
Date: Tue, 4 Feb 2020 12:56:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200130214431.333510-22-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0084.eurprd07.prod.outlook.com
 (2603:10a6:3:64::28) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0701CA0084.eurprd07.prod.outlook.com (2603:10a6:3:64::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.12 via Frontend Transport; Tue, 4 Feb 2020 09:56:55 +0000
X-Tagtoolbar-Keys: D20200204125653927
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc95b862-40be-4668-418d-08d7a958913c
X-MS-TrafficTypeDiagnostic: AM6PR08MB3958:
X-Microsoft-Antispam-PRVS: <AM6PR08MB39587DF3D5648D9CDF664DB0C1030@AM6PR08MB3958.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:277;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39850400004)(136003)(396003)(366004)(189003)(199004)(956004)(31696002)(6486002)(5660300002)(478600001)(66946007)(86362001)(66476007)(31686004)(66556008)(26005)(2616005)(2906002)(316002)(4326008)(16526019)(186003)(16576012)(81156014)(81166006)(8936002)(558084003)(8676002)(52116002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3958;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XuslV2h8Tt8r61/Nt8vOppGQFPHIA/ggXN6r5dFgyV/nhSs3zhKUSNu7L6g7EpIyoGYrdfIfkecKG9eWpTOSqmDAeOiOp1fhQIGGwGz3PMOTEO5/xmKUum3295FUEsWS51+PCPzFBGO8ZzvQ/8RoB0Gf7vmhxDu9sMhuXO7QbpCGXw0m9bqk6q+VAJZBNZ25q9lwzWDmXGRWvDXf3KT4JaYzFstMiEKaBe7UjEMDVe1esAxl1Izjsyyf2mIXSJWLch5y+cHtk140+NUJEjgWGbzQnrV3UuQcvhZvBVywWtO5IngM3MPgReZZHsIJNXgXMCoMQt1XDOrCOX0SyOzacV1iVcnbPZERjeQwhC15IHxVjkAMP5ojgQsA2kJ7Si0EvKuPfJRfFwLbe7ypEQu2fmNPpxbTJiJiqqF1+JaHP3zrrgx9cIx9sDD9G5ioM2y
X-MS-Exchange-AntiSpam-MessageData: CluQiFKc5qn/8FkQ0aUFITSY9oXfvAzwO6k46V35x3zA+acZCBMBbvR3SG+KdC15Lt7+VwxukHTXICYnabjpCUianSASTbwehKRSftHmtnDERNe8jvSr83wkei9wSpVVFXyfGWBgaiF3hf7VIS2eCw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc95b862-40be-4668-418d-08d7a958913c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 09:56:55.6804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn/v0D+amv2yEXoHF2IXkYSsHGb07Y62+5fDcE/2GMhqB7c0mCosMI11TG74p1IkcKm5sQ5DLKxVvHOaSuV+UNgAOhFSvtNpQ21yKz3GnZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3958
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.108
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

You forget my r-b:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

