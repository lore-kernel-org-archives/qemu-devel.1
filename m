Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0572AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AF820724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tq6o0oWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AF820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k96Du-0008JE-2K
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k96DI-0007oJ-OM; Fri, 21 Aug 2020 08:32:09 -0400
Received: from mail-eopbgr70137.outbound.protection.outlook.com
 ([40.107.7.137]:26758 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k96DF-00018R-PA; Fri, 21 Aug 2020 08:32:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOxbjpr5ZkhrqNxwXpPFWZJdX2HL3ajPP3CLwjV4BsbkTmqeQdtHuhZixfh6AnuK54DWphzNInapcZZtgyAfzwg1lUDNFkzj07O37xhhFOY1hkzC4KQyaU+ZPTimFoaQUMl9bH1G6+KtZlA1/I7VmoKgdLRAWPjtSSW58LlyFZ9N4haxa3TRJEQdctrsznPNTG1AXK+wZ8eAjGSW8RSYZj7QEI5tKHe4mMlMeyu/AU/U88dRdh2fVJnr6cxlwp7OCpkQhesx5dSIGnzifyRjYCa028C0kz4pcXnNE+vbQe3mftaT6Qe5BuaOiJzQ/bkLDdXjcEQQ0aOEf70ZJMkpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7P+AQ2TzRGYyZSDGACthGB/BhwsHctibB0YOzNZxBRg=;
 b=hah2y8eI2VhLBS3tIenoelgUaAAaLUdGp1Ru+n36dZshhBY9p1fMIsyYH/s3gr2Z6XHyrva53CciNJb2j+ClJmCbGNHCSlF9D8onSfxcQrEdSczeFgomIdfcUGS2U70FZ0ZcNqCSGzPMg5UN6bRHTLvxgVIaa3+/K6rmCUu0PvDB14O/BegxT3FfSslTXS4NSJxmKRrg9AmQxJOE9j4yFij0TVap9iG7Q6NjY54H/TDBI97bHZUU5oabWUbA6OlB/678djurFpiGPLvPIRGIEUldeV3ko8z/j71SdsuvInb3y1GBhlm6KoI8w39a44iQaDiHwipqIXnzvY1TGjMeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7P+AQ2TzRGYyZSDGACthGB/BhwsHctibB0YOzNZxBRg=;
 b=tq6o0oWrlONffNmxjqM+aKIJ5HKNFOt5Tw++Qx/TKSrZ41yIYpe3hEv1TH7YROwxba6R6ypp6Z9oey18ZflJx7Th3D/FEEhZIFDjAOHrMm9gD9R2eK4KwPHttDbP/3XNeSr1XqjRSrTkH4BnHNyDtoaFWsk50dP9JN1gPafOxww=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3224.eurprd08.prod.outlook.com (2603:10a6:209:47::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 21 Aug
 2020 12:32:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 12:32:02 +0000
To: qemu block <qemu-block@nongnu.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: qcow2 merge_cow() question
Message-ID: <b44aafbf-bd00-3bc0-68c4-5cc01a6b8b01@virtuozzo.com>
Date: Fri, 21 Aug 2020 15:32:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0109.eurprd07.prod.outlook.com
 (2603:10a6:207:7::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM3PR07CA0109.eurprd07.prod.outlook.com (2603:10a6:207:7::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Fri, 21 Aug 2020 12:32:01 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 268d406c-af6b-4cf1-dc3e-08d845ce347f
X-MS-TrafficTypeDiagnostic: AM6PR08MB3224:
X-Microsoft-Antispam-PRVS: <AM6PR08MB322431ABCD7F99853B324029C15B0@AM6PR08MB3224.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MKlwUxsRtDj52TdUHkrZxiZvDGkusJa9GntfnQ7qCxehTHE/ZTovP2lewRXe7Z4Nc95ZCrTGPMXqCgsLWucEZg69W4oR+KUiR0U6oRiqeGKv7HI+bA2jYQ9+oZQ4zLAuoQLas5eQ7wmeo8Eq/AsH3QWGDHXdgZeXQUhMAcX2oNxABjFR+5e5fHe4v9glhKlnpoWubG1hpL86kMqu7SU/UCX3n8zz+ZmwLb+emmefJ5vgq9FD9T+75Krsfo5K31A5WtDREnhrODelFYMuDDKWvk0kbMtaEND749Zns/XiTA/Ca/EsGaZYxaPg/BLS+9B6us8GS+yUvDQgMc3BTtwBn8kzBK5AndxLhmxfJJA89SYDKRMZJK3U0o6mnQgY8hL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39840400004)(366004)(346002)(26005)(31696002)(6916009)(2906002)(5660300002)(36756003)(8676002)(86362001)(66476007)(66946007)(54906003)(66556008)(8936002)(16576012)(186003)(31686004)(83380400001)(16526019)(478600001)(52116002)(316002)(956004)(6486002)(4744005)(4326008)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: uU6kGTsc1EVrCJChvN7FiylesecTsRiuvP8/xejqf7GNCp4FC6pqbr/6AkViYvAeEqScI/VT98Q42AuulPUQLznWKAm6GtINI6Yu5cXIOaR9PXDxPXZZd6UgN4Rj/F3SihfNrzrCDdcR7N0AyZ9BBSfmqMjtk/YcJyEmOHkg0t8vMClQYHsMCzivhotnARRhcKjPr3HSDs38xE4SdQjZNrBeR6/BIOBbhtEt+qOQTtl8Y/6+HOdFt6hUfnfLFCCp8DDBT5phLB1EdUSj74pcCdNxQz6Jwlo4YvWo82IvK6Kt87JxGFgWfmXcv8Ru3vZxBzC1g29haAzUr84tZRXrN+BsaXUURZruCBDx5dfPEsoFnbjKlAq02K9OCxsE5zON3jdokd7d6HdPmODqZ6U3RGyn/L68gfPcMLyHQ14Q/xH8fH/xIWCgddeyhTrW0WLa/NXoreqHTXo8jKPdZTldermARsIPeWy1AnU8FcGMXQ4sE13jp5SxhZBb45bM+42CdW1C4m9QvxnBd6FNsDnUrABCNfRaT+anfqC6czJs3zv3UavD18BMI/wyVgCF33CMzhiX9BmmrC90cSi1FzLqVni5tL8mbEggLgMhNwKKEkFai/0MSYYnvOoYh61lpzB14WlS/FhjfL4D5SlFeFiPnQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268d406c-af6b-4cf1-dc3e-08d845ce347f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 12:32:02.1101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9/kMlaIGPIg4doCeStybn0deHdVeXdUynHeWLhJBemlME3qmHdqsfiNOYyukT/jE73HAWzmxX+47+Ic3Qgb/Me4ZSyavCUae4NjQ7XTyQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3224
Received-SPF: pass client-ip=40.107.7.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 08:32:03
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

I'm sorry, I feel I already asked about it, but can't now find the answer.

What are these ifs for?

           /* The data (middle) region must be immediately after the
            * start region */
           if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
               continue;
           }
                                                                                                           
           /* The end region must be immediately after the data (middle)
            * region */
           if (m->offset + m->cow_end.offset != offset + bytes) {
               continue;
           }

How is it possible that data doesn't immediately follow start cow region or
end cow region doesn't immediately follow data region?


-- 
Best regards,
Vladimir

