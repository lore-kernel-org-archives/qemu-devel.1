Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3185DC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB4E2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jqJpPimf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB4E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOICe-0006KY-3n
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOIC1-0005rE-IF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOIC0-0003Fb-HG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:49:21 -0400
Received: from mail-eopbgr130090.outbound.protection.outlook.com
 ([40.107.13.90]:1440 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOIBy-0003Eg-Ft; Tue, 14 Apr 2020 05:49:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njghQDsdWCNlub206vVulyxvKAxZzABq/OBbuYifKbzu0L/qvX7cQnC5bZQVX1J05LRcP4B1lk6l/3HoTwVx7gOv8ORzo6W88sTdYMjbGTWN+JwZohvknVE+h30x51Z3QhLKkwInePCqmaWsStmvGNekq05S0KgySUIu1GUMK8lhdC/AzfggaSzhtBgUUUQ+VCgMwrnEQPvXKyOchB2wthsrIs+eR/7v9iGvda26YU5kNaj4ZYkHpJoBqe/dxPXNNOyaFfuu/Z+kn6cFBuK9huK4ZPum4gE5KCICOh/IeUhLhGaykrVqmP9l9dclOxwPHGa8BC87pO10nudTZjlsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfrlrtXvjVYu2l2d5u0DZ37xQDeGqOa9liaPteoVYq8=;
 b=AvCmPrKpjSJ17CmQnGAKw8rSSuOoPY3UkSNNKCvysK406ox68haARSjydrfkRVY2s3hvme5DYuwHu3VizFdBTKAxdqfyBlB40KlKz87VD7Hu0ptkOhfPOsuTOMws32R4Mgy7/MJvEAukBJL3yrVgEerqtlbUBRvTN/RWNDoBcUulHLX23va1fvm1ufwmr4o7xY1/tQMkM18D+DGa3dZVF9KlAeb0nOfhgbTgb6qZSkqDB3IGl/vfd2do0B0uNgXOxhKWAh9UZB86hPLXCrfb6dGN+kO2eDijyVhIArDBgimT214a3719Jngdls6cTcoA3YKuNTo9XobLc+juAm1iRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfrlrtXvjVYu2l2d5u0DZ37xQDeGqOa9liaPteoVYq8=;
 b=jqJpPimfs/p6XMlgcXxl6+7Wf0S7fGfPu9HTa8gj3OTTuQRRsPJF56HwfJyPp8/IofeG9tTGk+IuWqS/bFrOtCZz4XUiHF5aib7X0RtxDIb2dJ5dbmyi3IB3UvFNJR8/+79A8UInoeHyOy3eYbYTBsN+sCqmuHKEDP/qPdJZAyc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 09:49:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 09:49:15 +0000
Subject: Re: [PATCH v4 12/30] qcow2: Update get/set_l2_entry() and add
 get/set_l2_bitmap()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <c3d6c8e03c353a694b6415d9f6ae253f22a620ea.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200414124904047
Message-ID: <d90d3140-5456-a28c-134c-0beb0b7ea93b@virtuozzo.com>
Date: Tue, 14 Apr 2020 12:49:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <c3d6c8e03c353a694b6415d9f6ae253f22a620ea.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:208:122::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.131) by
 AM0PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:208:122::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Tue, 14 Apr 2020 09:49:11 +0000
X-Tagtoolbar-Keys: D20200414124904047
X-Originating-IP: [185.215.60.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ef098b1-11c2-44a1-3afb-08d7e0591811
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5429F3BA6C62E2B0724546BCC1DA0@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(2616005)(956004)(16576012)(316002)(26005)(15650500001)(52116002)(4326008)(16526019)(54906003)(66556008)(107886003)(5660300002)(186003)(31686004)(66946007)(66476007)(4744005)(8936002)(8676002)(2906002)(81156014)(36756003)(478600001)(86362001)(31696002)(6486002)(6666004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z62hGMeOYitjymLcTo+J3dE4tpp4NVOCm+UUYbzKlTV+Z+6MEGOeR3vN5c3DdzF0qmey0+7GZJ0C+K58/7Fwz8pJZgo4i/7JNspak0OkE3YJYb0qsSKVN+kIC8xqjI1OPA39JFcXVq2aVfuJ57TimIM/7FeIEfm9WPcBfFACuK5eS9pTrJMgZo769UPIXGAUiH9V23rFdiJpxVaMMN5sXZsbugQBKdpaGGWw530WwIdhje29q3FL4G6yrRg+TCLgu92tvdcVIYbg++YJUlq2ndf3v3zP+VxVZQOWdXvo38lcu6lhIx0lDRPHjErW/yYnAd0ZvAd9rrTZxGuaCAP6BrEL7y5S1WRvZkxVGmccTZB3gfAUwKUn701KAeLkfIPuJhwYaLhvYiorBV9W/vKwDsVn0xkklpFnrTNMZI/Y/KpkYc59pKkIP8jDOHGzoAo3
X-MS-Exchange-AntiSpam-MessageData: liBLdMVYBZN2KJgEspEXzLVU2N8GW+zmzmRXVXHhPZBFNWoHb2xPDy3TSuTZSUrnDVrU9QsFQgxsr3gjc4GMNTocXpZrnVj/7b0DawNAb+jwzcM/5YQUWzNyrBTsFraPx+iRIJw1S3DKkxWAn1IRbA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef098b1-11c2-44a1-3afb-08d7e0591811
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 09:49:15.8161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM5szPvCm7zceuc50is8lybUMCVmrEGvIeC2+nsDm+jEY4XvtWiXoZFNsNiq2XAsvsFVg73UpTlwZmUA7TrKbK+sIMrVAqfr2vEMo24a4uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.90
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> Extended L2 entries are 128-bit wide: 64 bits for the entry itself and
> 64 bits for the subcluster allocation bitmap.
> 
> In order to support them correctly get/set_l2_entry() need to be
> updated so they take the entry width into account in order to
> calculate the correct offset.
> 
> This patch also adds the get/set_l2_bitmap() functions that are
> used to access the bitmaps. For convenience we allow calling
> get_l2_bitmap() on images without subclusters, although the caller
> does not need and should ignore the returned value.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

