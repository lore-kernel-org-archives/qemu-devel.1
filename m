Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D19C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1062071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pP+Sznff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1062071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjAh-0007Nu-2m
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDj9p-0006oE-Ue; Thu, 03 Sep 2020 02:55:41 -0400
Received: from mail-db8eur05on2128.outbound.protection.outlook.com
 ([40.107.20.128]:26657 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kDj9n-0006d0-KR; Thu, 03 Sep 2020 02:55:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2K/hmD4+i+KLo15yChh2gtNg7EVcAArp8wRsee0XgJUbNH+ryYaa8Bow88aVwp/dv7O7KfmcQYyrhV26xXPnLAfZfpovvzpbySXAc7eRS9Nf1mSAd6xz1C5kTAGtRut0iHmIRjSuKp7xMWID41It0epZDrMtHpB0D+D4VdLlHeM6ac8MVPPoaRT5frY5IisvIJFRQ67J8wwr4EgUUdyPj3ZDgB/lqRrPpIsvyXp6S4tiibZx0ggf+Rd0KlmYZIn8M9FZhsSNqSFq8N3JeIrRAE5AUgR4VCWQp++QEkf7Mw+jtXMyhhwxxPlixqgPv7ADM9/ixdlSlIiU6LtH0t43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTD6vxyCrFif/ZiaUEWxx5rLoRgYKahcH8pqQ4YXlJM=;
 b=POcv8Gv9pgLBMGna9/aeYs8RL52g11oUPD4aO3WLYDGyHrMgn7cuVz51o0eOmuNaM2pAy2MOxvOcugYNC7D4TIDZu52tGXUP3hqWlVNf49G0L3bG010c3JqNhlc7374z2jGtl7LjCtBpvVc48SETNrEsX4Dto7ASIqn5X4s8xBy4OF/ffI/IcHvoAdYkNCTdue+i1S7ZyAh4vth3Lk8Qp/IW+btxAUw4UJCr/37Jwja2rWGVric/XfqI4XBm7NiL2CcaywpK3KjqF66YNFs4H8+LJ0xnmef+dLAo7D+08/UFWzNgZwHY1ZjLprYhCvfvQJf/FM/0YJ5/NY8zpv9VxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTD6vxyCrFif/ZiaUEWxx5rLoRgYKahcH8pqQ4YXlJM=;
 b=pP+Sznff2PNB7zM2Mwmyitmr0A2MsLDh/6DRcI1PyW6atrzNTCaVMtGmdhb+b8FRb0t7iZcsK/W03eGbJjyqXF0v/VIf969aBZOMnJGE3XYPxRZld8EAveyC03gHDSbCa7EeOR4Ze7cHL2TJTtnwtR5huHtJ7QVP5459AkqidDo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3286.eurprd08.prod.outlook.com (2603:10a6:209:40::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Thu, 3 Sep
 2020 06:55:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 06:55:35 +0000
Subject: Re: [PATCH v4 2/5] blockdev: combine DriveBackupState and
 BlockdevBackupState
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 pkrempa@redhat.com, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
References: <20200902181831.2570048-1-eblake@redhat.com>
 <20200902181831.2570048-3-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <df9c6678-2705-fc43-9d46-880083b21b70@virtuozzo.com>
Date: Thu, 3 Sep 2020 09:55:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200902181831.2570048-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 06:55:34 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2495274-e507-4051-f62d-08d84fd65bde
X-MS-TrafficTypeDiagnostic: AM6PR08MB3286:
X-Microsoft-Antispam-PRVS: <AM6PR08MB32869C872AACFF4E43407BD2C12C0@AM6PR08MB3286.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:359;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7Cdgw7VAiDF3/jDoo5l4G2DvVicH8V6WIdQW6xS57N13oWqUI44uW8yRvbgxsbRgRpNFQ7AWFOE78CqrRp7417EWcqCWUwta+uwGtv+6YulsqWYFYm2bGbrUe+GRTDMgBmVQUKhDMC85eEK7JYqPzTsVq179dhJiBGaKBkmiUfh0CCl80r0eV1BPPIZXAPtj8Bvm6BXhhz9LROuZm8pApyHNY49Rea5Zktu5Zi8jB20FvW7nMMfHEd+DB4X+2W9uqXhddmkC751SDXZALI4+5kMiVWF2RvfQEo/mReZtOkXc5iJzlHYIllP59Wlz4TdeNJoFdRM5sED9oMbDWE6LBif4jtuSDTbYcSfdPM0ukO7AlANAibN3iMqzuLIOQKl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(376002)(136003)(346002)(366004)(8676002)(26005)(956004)(478600001)(2616005)(558084003)(66476007)(66946007)(186003)(16576012)(83380400001)(31686004)(66556008)(8936002)(31696002)(316002)(5660300002)(6486002)(86362001)(2906002)(36756003)(52116002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sjN3K9BVCUgKh9qYABHLMl1aM6HYMwdLCO+sdm/MzXRrCNkdRmFzFT7eyhtAD9kR9JLng30VtRAd+LyJcQNYJ9Gi0lTifEIomAdIw7yN0Qz8abD194SNbAAGpU5CL8rXnyUYC1TjMJbMhyQ1ySZjKMOP71i3kv68UDGZUsKP7uViHL5FRGsWYZsYTJF8pWgk4Qys7Uqr2PunHAZzSXxDn+PgB2fSbqXP1AsL1wPBhmTeL4w9eFJqvWmaUDnmMrP5OnC/o5yDtahf1yBljpIJ9vhRvtePwW7qfSkvkD5HCaPahJd3RsVEhz+5m/WFg6+BUmTEXAXsSpV/7PIvaj0FPa5tZ9vISVlFbNx8XGbiM2blScO570GwJFJwKy/vWWjkTSpp/XCNfza2GgYKC/NHztEm+7qWaJRKa11aHVhe0v7eT10Huxsb8KkoZVV5+ct/rteepWXDEadlzEjbSlC1Qv4D1VCjlIxP18M7NYn0LIpz8Nd2W+vNwlVzlO0mPBILn5WLDJcDkEqSS29mv8/VXaaV9f2V+4SXshZ1qu3r/PJ5pH1VyIzVvFInikVG0Qe496DVINTG7oUSTV+JZKsb/3cugTdmzVhLTC1eAJJZHuyjGCy7XnIR25r1a+Tc8V2assXls2HfX/qP2P8IlXU6jw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2495274-e507-4051-f62d-08d84fd65bde
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 06:55:35.6755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boRnkBMToS/cGBrV3X/C5l++q5E4xDfbpxfM+U4Lfpr0zwDuFJ2iqiVbzyk6F2B35l00FXgxzATJnfuhosfctA+lZCf0TZ2OX+pPFYHDwzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3286
Received-SPF: pass client-ip=40.107.20.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 02:55:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.324, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.09.2020 21:18, Eric Blake wrote:
> From: John Snow<jsnow@redhat.com>
> 
> They have the same fields -- rename it BlockJobActionState.

commit/abort/clean functions are identical after it. I think better to combine them as well here

(no changes from v3)

-- 
Best regards,
Vladimir

