Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA2CC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A67820679
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 10:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CvE2dPd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A67820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqal-0005By-L9
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 06:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQqa2-0004hf-9t
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQqZy-0004r7-KR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 06:56:40 -0400
Received: from mail-eopbgr60107.outbound.protection.outlook.com
 ([40.107.6.107]:22190 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQqZx-0004ld-NH; Tue, 21 Apr 2020 06:56:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkhUIFMZhK2mZLGsOQLZczuTbF85ZnEChb/H1bV0R6qT7ACw3jiNMd8Ek6XH0ki6eRseyXfrS22ZpkUnbuffTsTMCp4eJwD0zAbVJvt+2JYRehoIIqA9wdjg7gB4jlJuPSHE4NthKVm+70po3kNbUuT7TtFPoVykKYIJC+dRd0JqXpNJYIzbNU43Xrq4RrrcGoBydvo/u56/qkWQUBRcckBYUaf41h+WbanZlPcPbIKWI+VN4ZmQmlHaPHM0TNdkmhb5vM5fRTD55iB5ORZ+4FT/kV9Kz/aRD6bm/2rUA6oaXEMTArcQUReM5FVhrUZfmkLTrmdjJIpzsTiPfXereQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADecVudFptF0lRshISn3dr/tFT9ld7kdgMJJLygBBn0=;
 b=lyrJTGxFR8FgSjQ0ZzHGhUS5KImwXcyIDzdd4+by2aJjTmPAkdthmCDf7DKrQBp9rttxdyIC4+G4MD4GgzKvvEPV0VjTppk+MwDcfItY2PG7y8y5eCpO90NTWEY9RCwiEGUx0mly4hOmQm6NZECMy7k7ssQIrLE2bGmKYIwupO8UauWcjOkXEd+qf9wpIxTUI93yxlEz0ZI7p8ICUXaC/A16Y38aKvXFHHyjeezwkeq8j0pcI/Xh5ayrwWstVcEOOVWTV9kEFZ8B9B5Wnue18sJQ/MFhmAeZKOiud/s4xdXkkcvF2OqWf1GgVp9owYzh/Nnhx1G++cwVjiANj1ei8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADecVudFptF0lRshISn3dr/tFT9ld7kdgMJJLygBBn0=;
 b=CvE2dPd7EJcdSg/gtw7A82nZDc8GIuiidzceYzrJg7Xx6J/j2tyYbebhfzklRI5UQ+mZ4Y6xRcrTqWv6+FwslwFIsNHXI7p8RP8yNlg6K3FLhEenAPkP4uicMUI+3w0y0Q990rPBVQpbvht4VwjBRQTdLuvfupoxjwqkYQ3cvtQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5335.eurprd08.prod.outlook.com (2603:10a6:20b:101::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Tue, 21 Apr
 2020 10:56:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 10:56:32 +0000
Subject: Re: [PATCH v4 6/9] file-posix: Support BDRV_REQ_ZERO_WRITE for
 truncate
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-7-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421135631275
Message-ID: <4b6d4630-63a7-14a6-04ab-6f24c6326f80@virtuozzo.com>
Date: Tue, 21 Apr 2020 13:56:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420133214.28921-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM0PR10CA0006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Tue, 21 Apr 2020 10:56:32 +0000
X-Tagtoolbar-Keys: D20200421135631275
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b983fe1e-dab6-4f99-d48e-08d7e5e2a71d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5335:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5335F5EEA73097BB5531A502C1D50@AM7PR08MB5335.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(396003)(366004)(39850400004)(346002)(376002)(4326008)(36756003)(2616005)(956004)(16576012)(81156014)(8936002)(6486002)(2906002)(5660300002)(31686004)(316002)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(478600001)(4744005)(52116002)(86362001)(16526019)(31696002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbpGSQy1GF0zI3+U3vLYWgLHAadVBa2DphnxbJJFhjaeae3KGv2iaxF2PdHOG5NQmPAwbTAO98VqcII17S1GTVhULI3Rp5Ku0PIcIC25rx4q8LCGJlU/jdHuHMKL4f6oNZaFL+WUCCubJngCcMT/7zB6qnCSaUa476EUcB2GS8+xIbvzV7xdUiigFD8mQ/f2g/9ir+mywKA3X7Glyhl6NaRGxcyuRR3kkQ8o4WkNz54BnDf0Ki2BgCDEFnE0eELtd4NUsYlZ3rzWyYbSdw7/MGGogoe2PC8a/DcKFvW9NtcJBSNImy6wihy4R7yi+7cP4wp8sW6+ZsHEn97387tQ0i7j2tDpdrfr7GqN73KqizO/q4RbzNQh8PLt2aB/EI4q4oCpDgaPB6Iqkw7HLhmRV+mcPqXZPrQARrM7WfnaqJCUjzf5L77YCvl0xMauE5CY
X-MS-Exchange-AntiSpam-MessageData: mfKqfbV3kOD7EQRFQSExzI6sPKZGn1WgsVEYbvYOdIGnnt7DoJFNlXzB9D3yXbnqceS+HLT+ZyGFkleSQVM/NBDvQbacpQXaTyuiIpU0lX/O8Kc3Bzcq5CTXTDJbt4KsAcTQr9NrIqn+IpoqPmnQ0g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b983fe1e-dab6-4f99-d48e-08d7e5e2a71d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 10:56:32.7614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zg3IstG5P3EBY78KovQLw2llLXjVY1MTM35CIFkA65tKlytnxDlMnCLaZJB92nF6N1KR+FMYlw7gvlU3grNiwKwmcLRhoehv/NGAoDyuxjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5335
Received-SPF: pass client-ip=40.107.6.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 06:56:33
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.107
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 16:32, Kevin Wolf wrote:
> For regular files, we always get BDRV_REQ_ZERO_WRITE behaviour from the
> OS, so we can advertise the flag and just ignore it.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

