Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E506DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0051D21D1B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 09:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hfEFZ7uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0051D21D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI7cR-0007U7-Tj
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 05:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI7bT-0006cJ-Pr; Tue, 15 Sep 2020 05:50:24 -0400
Received: from mail-am6eur05on2103.outbound.protection.outlook.com
 ([40.107.22.103]:28512 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kI7bQ-0005ph-1F; Tue, 15 Sep 2020 05:50:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/Z8ztLqlkParqqkGJ1veklymd10qaQig9j3TPPt9Ka0tAoncnm66CRXBrEfIYOO/HaTzzRaAm4MDLxvzZ+eZHeW6HSSj8eNXodhtt/a8YFhUb2CjHzluzHv3/BCRrrP4u/+fo1q7pO+FeO1WO28mW3ZfzuZ+c9Aev9Zr1fFZxZiHELJw4B9+UhTFf816S6K3gY1Z3R4e0ZQ1/Pt25t+7/rq//85Y+99g5v46HU1DuFDpMjIKuXCccrKPLjJlPsYOapUoutBdtH40hgoUCe6u6t52K8uiFvSDdPoCCGLLFs1CrjZDhV7zWzBTYifmMD9hNstDoji5NhlNHZaLNzKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zyDAbQOF+1uFo+XXdbVL7WGZ+YJiBzXjmmdQ+b1TNA=;
 b=ZklScHRJdEqXGkjDdFNxqmPjJTkqk2z8xzqjPhmSQcsWRzL88PmHQX7Brh4oPhaSiE3bFacUBKyNAEKOFa3p3FAL7+olPWpyKFiEU7UakZT1uL52IFQmKkIcMEu0du0se8uZ2q3Rj169uUWGdcCyC8T7xw6+uKgHmQdA1eRWjXuHut1Io4QQk21D6gnIQsKn70N3PcVvXnOVqz3nOvXCsoyl2BfrBTi3oxl2tdW0kkBcne2cMHt9wfiRdOm1NbqRA/6ZvO8Lia0pbsxcy8909GLLr6VYbM1h+Fkhe3x1x+onJMgQ18UvGnFVVvQXyGVbnhzE5xrl8wbKdD4eYWYC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zyDAbQOF+1uFo+XXdbVL7WGZ+YJiBzXjmmdQ+b1TNA=;
 b=hfEFZ7uv8mBQl/ZhYe+qelpHpMdzWQ1nRL9jC41doWViL4A2Pd2JewQx1zzy0hS4D3HbyDkFNUUAqrwu14ifoNmUa8YffZPnI+npssgjaFBlLaezPm/UNva65o8QvOas96sUZPRmT1laJh3/gJqSmcYSiMKzARkm3D5dbD0tr+s=
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3029.eurprd08.prod.outlook.com (2603:10a6:209:48::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 09:50:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 09:50:13 +0000
Subject: Re: [PATCH 03/15] ppc: Fix return value in cpu_post_load() error path
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-4-groug@kaod.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ea2b6f96-7bc6-575f-927e-e063b3406f77@virtuozzo.com>
Date: Tue, 15 Sep 2020 12:50:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200914123505.612812-4-groug@kaod.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.75) by
 AM0PR10CA0117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 09:50:13 +0000
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff7552ec-2ac3-4f40-b002-08d8595cbe41
X-MS-TrafficTypeDiagnostic: AM6PR08MB3029:
X-Microsoft-Antispam-PRVS: <AM6PR08MB30292A5F8AF65D0DBF4ABD8CC1200@AM6PR08MB3029.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MR5Nr/H5plvrPwdbhmWnnmKu8Oa4YvTXx0RMFNBSeAyB9c6z2oqFRd+5qxDJYcL6m71ZoxUA2epKA10gjoKryWG4Le+T/akISWb8Ro0xBKg4GUCxk7rV5fQ5+SZfCe8qJ9P4TsqgZ4Py93/jP5MvUyDhev7nXgb52NPR88rATwbHC/hU+FEBnTK7mObk5UCfstE4LxQAN9DgJBFpEt1qFdzqIGQpe7/Kljk1CCDreYXMmKNZTIP63qu0T83Hxm9QKhsk65Z1eQ0QB+sp0sgK40jliuSFs5IwFx47VaHYlYv1Q/uMgOrJ4MgycEUf3ijFT71twWMt9Fd0PiC4Kwvi5MEKcZ4gAAMshopQ3zPdZYfH4J9bTlxTDMFLFq7awfFg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(39840400004)(376002)(478600001)(6486002)(186003)(31686004)(54906003)(8676002)(16576012)(5660300002)(16526019)(36756003)(66476007)(66946007)(66556008)(316002)(2906002)(52116002)(2616005)(956004)(86362001)(4744005)(8936002)(26005)(4326008)(83380400001)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dxTNcZ9j1RRfu20yq8wDRqJZWJOdstsGQB1/b1KuTukTJw72+U1FnZvqviHHqHQorlCGr+yBCLATyNeHNucvmXF1US0XHGZ20pBZ6AGuaqq/DgRoAJFNazUNxL/hrCz7qsG+pcyJn965+zdZmRWBKr8fhCDxO0Hk6sWPAeVNdwl62+zXNwt8RUHQIVmvHTqRRjTBLHAIAkAp9eitH4B3E7vN8o3V3u6+sBR6dLA598EffS83IzSZo//LGKeqZGZ5HiAQB+aIbUyJHoa8ctNUVRu3yhMg8bPrAvUzyHqb3PrLRCbYYfLXyYihRevqkD1x73+qAD4Ph+6jFUoy3fQRyQlBE2NeoUakBjztuPdp90bjc0cRoAVJwPzDM2qWTfM5kxnHo/bLuIiE6Cb9vc/9ZnpGuyyVbz/ZOT5bbP8bCrtHQ5PiQKomAfpzqrkX/5fUiGS9NJLUVihtNlep5M7br0+YytOHQVQIGApshJN14d1VJwXj86sfGVLhcpjR6c+R+KqyafvbJ+bhDZ88NnPic93V29uAyoR8jx6XQwTwErk95IE+sgoOQX+Bm/suBWJP7PCpSpdLXaxTxHmJzOv3ryEeYkPtc0uYomkeXHp2wCJp+JkuWRZqal3NDqaSZkqCtW2ynN+vs/XLKEUb59YgqQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7552ec-2ac3-4f40-b002-08d8595cbe41
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 09:50:13.8466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoWaynbJ+lnyloTDE3byNhIR/f7ahWsrOSd0X/dhRMEc4MtpYOT/O7btgtlD4E1oX8xBrIqZfaxRG9WwnVJO7RD7/jkPlQTmTK5uc8bFZVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3029
Received-SPF: pass client-ip=40.107.22.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 05:50:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

14.09.2020 15:34, Greg Kurz wrote:
> VMState handlers are supposed to return negative errno values on failure.

Even vmstate_load_state() itself hase both "return -EINVAL" and "return -1".. So, all it's a mess)

> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

