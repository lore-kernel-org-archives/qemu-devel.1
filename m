Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9EB20842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LPeoJLo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9EB20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j98bs-0002vn-Kx
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j98bB-0002QF-Sy
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j98bA-0002EQ-Sy
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:32:41 -0500
Received: from mail-db8eur05on2096.outbound.protection.outlook.com
 ([40.107.20.96]:31329 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j98b7-0002Co-Fj; Tue, 03 Mar 2020 09:32:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5ZHg1wxXDeIq3AQzMcFCOc9d/0wnndbfkRpAAzOQOI4zNk0qI1uYofEKb3fMISrNgohjI6ne7wEB5y5eENRK4jmvQRG697YLatSkY3QI3zCXEOljVKHfKoMWDBBdPFPKKhO2z958+H9lSEbDVeEWNapk7a17iY37dw80yP/T/B0hxCrNr9/gABLuiytAYiq4Qq5+6hZEt7MUCGo4qqfUvkjoTL0TrEkA+GMkoPVIit/4bQgNGV+8hPa8/+k7lTPcqOh+311baZ3asU+XqreFixRH7a2r4swVIT2D8XL6J3b/54wU8LMXErHKkoISHl4h/4QCOSmfT5lltuGStS8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urRZPGBD2stQoh6e1kxic3Q5rICO67Z/YfkSmJB8+7I=;
 b=D/5hhTwawIKy0rU2NMklC9bg1KpCSK2Ft8xoAw68K/iCMinukZleGZxPvnmLlGabEt2VfV8HPpeIj68dsx06e5v/tRpXGa/P3BaK93AkBcY8kRfT9FuycHTJa6WXV8u9Qvw3uG4gLwIs59n7jwya1tMkO9sHA9yaBxX/3U6F48lf4EgZa9xJryK2FUkVkBh3Iu81T9mkg2/HLhbu1Sq9XfMVEoJjkzAGPDPBLgUO/Ra6RT8FIcnrL8ZAhQKxLPTLbxd1igJw8jQuSPDGwma8cfZEMhZmOw9k/rteTCldTE3WFoBaoji7PJSJMcZPTHwuFSgKJUexp3FCpQO9aNZaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urRZPGBD2stQoh6e1kxic3Q5rICO67Z/YfkSmJB8+7I=;
 b=LPeoJLo7wAjGhFnQYLisROnbJq0YB5j1oou2p/D1dO5q7bC/VI8sgQF8ufXW5Nc7BFw6qSfrxQ7YIYuduTRNsk6R5vpOvGZP1cYdOKyywn2pieiH9wJVe+2RSlN+dEIFtFDxGU6AdxMJ5Ub+Ka+5NHpo1F04krICXw1BQnarQeI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4054.eurprd08.prod.outlook.com (20.178.87.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 3 Mar 2020 14:32:33 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 14:32:33 +0000
Subject: Re: [PATCH v4 2/5] qcow2: introduce compression type feature
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200303133425.24471-1-dplotnikov@virtuozzo.com>
 <20200303133425.24471-3-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200303173230754
Message-ID: <fef2e677-8b7f-5e54-d640-398dfa677b97@virtuozzo.com>
Date: Tue, 3 Mar 2020 17:32:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200303133425.24471-3-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0032.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::21)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P190CA0032.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 14:32:32 +0000
X-Tagtoolbar-Keys: D20200303173230754
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc64ec6-ad60-4803-4f92-08d7bf7fb5e9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4054EE9C3917434D97E5F88AC1E40@AM6PR08MB4054.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(376002)(366004)(346002)(396003)(189003)(199004)(36756003)(4326008)(2616005)(956004)(31696002)(86362001)(66476007)(66556008)(66946007)(186003)(16576012)(81166006)(52116002)(81156014)(6486002)(5660300002)(26005)(16526019)(8676002)(478600001)(316002)(8936002)(31686004)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4054;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWp8/IhYilz+6bTziCHp8I7R98kVTGKs42bVFmsCjHzwJNQfMRvF5BVkqyWZcoCU9gM8eUJPlJ4I6gQ/vpmfLardJ+pTxxRAzBTmBlsYMyPOhpjwfkMc9bEg/YWSaK+uYtzLut7q7w7YaJ37ksp7UtfnaCg4UDrVCvOdMTNuBKdy/TcKyADttl1GXBIYHlhd4RWRz7D/5IkxBftWaDsWvdB0fKjph3aW8WgNsgXRhg7WuB3WuBM3jC8+V52gvzDCRGTE64WAnFWiDr7fAqfinAxa1OiKaGTXo2Ux+yyXHXy8uzU8D4ZlqO+SXZm8zcvofJ5hHhV7aOTDxF7fCpLQa7c/xymtuBQnG3V0BzUX0qNdPo43ntkxE9Sj/bhHs2G8woea4DaOYqYV1BQROQAEV4w9ndGrxB7vZMx076BM+y9xmYpzNhvBU1dxIEhTPCr3
X-MS-Exchange-AntiSpam-MessageData: x82RfZamkCyIG2LEjZ/DHk32+vC3B+qHbMAwhoQwfg3Jl9qFXbf+tF74afMOceYx7ngWdojctrLvOJbkVuIQryNDPaeRfM0xenA3jgfa7EBs/yDpyub/cAiV75qbFDnxGdX9oGgCcrWVmqINJ8NvXQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc64ec6-ad60-4803-4f92-08d7bf7fb5e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 14:32:33.1741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCZlGrSvpSJ42tLEa4RyR4SAQlcHN3JhyLyG7F4tifyJQFK4anWTEFMQ0NxlsxGeWlyIYOhiMOCGe4fBp9UeShpKhSIKU16PCy52fRojjwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4054
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.96
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.03.2020 16:34, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type
> feature to qcow2 allowing the use different compression methods for
> image clusters (de)compressing.
> 
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
> 
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> 
> The default compression is ZLIB. Images created with ZLIB compression type
> are backward compatible with older qemu versions.
> 
> Adding of the compression type breaks a number of tests because now the
> compression type is reported on image creation and there are some changes
> in the qcow2 header in size and offsets.
> 
> The tests are fixed in the following ways:
>      * filter out compression_type for all the tests
>      * fix header size, feature table size and backing file offset
>        affected tests: 031, 036, 061, 080
>        header_size +=8: 1 byte compression type
>                         7 bytes padding
>        feature_table += 48: incompatible feture compression type
>        backing_file_offset += 56 (8 + 48 -> header_change + fature_table_change)
>      * add "compression type" for test output matching when it isn't filtered
>        affected tests: 049, 060, 061, 065, 144, 182, 242, 255
> 
> Signed-off-by: Denis Plotnikov<dplotnikov@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

