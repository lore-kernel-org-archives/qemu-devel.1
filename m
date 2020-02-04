Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFEEC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE712082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YoYYO6qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE712082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzNQ-0002se-Rk
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyzMe-0002NQ-Nr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyzMd-0004pI-Pk
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:39:44 -0500
Received: from mail-am6eur05on2129.outbound.protection.outlook.com
 ([40.107.22.129]:8033 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyzMa-0004lB-GQ; Tue, 04 Feb 2020 09:39:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSWXLzcHfQq9Qoz5OdIBIXXESIMZvPYo/Xxf1iwMAKG9WQt7nT0d1+PAihtn8FOpP6qWuB8ctqq4QbL/OF5nturV5CTalIEjlS1lXtyJiAWPLX+nEP10VBv/CNzEOMeu5XUFZNpgBXNz9n+9iBRZSRk2s47pvqG8MQvXHDAwiQkQtPf9k2usLN3hmF173QbafihQPjTWvjI84zRKqfr+IWe6+1M5oVHTrKcuGKxkVpcPhYYeEXIDuSjZcfykTzc18hvL+xJCkfLJUhoKez826U08F731OzaECohvBP3OCgFq3FzmL/bkI0O+AgahaDQSzOQtt9iMAloiX9DmVl7dTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQWNfsXs1Ee+h4Tq6O7jUTgaUobbBePmE1JDSevwwR8=;
 b=gfzoRVBaI+J7rudqkqVIpp/H6MnA8wWhGmNvaleuqDzkF+yT4WabMtXDUjxpZvegKvZk2/DN1wv+pEL+7GieuxXaIF/hxI+pSTFX5WoyamHtr76lbgPLb7ofRW+r3WWTwadsyf6g9xq7Bt8iOmNkAAW/LKBhEsFvfmuRw8k6KiBULF0FysWhf6CJ4KohHXnGvj9HgrAIvavlNPEDDbbSxYiMlLNLJadzOEWbnxTITYbv2b2z1qVaSXVEfTvdc3tua1mC0CCq49gCAnyRCkx4PYa8aesl1a4k2PqexOkpk/DRpNPZnQfHDLhJeCDXZbPs4H1AUmfLwtU+TCd4j8eYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQWNfsXs1Ee+h4Tq6O7jUTgaUobbBePmE1JDSevwwR8=;
 b=YoYYO6qg4uWyVU5WujcnD3XOHXlfhrWAvStZIKTWAEKMH/nNxVI/ADyu0vKwcL+Q/rQVXtREC8EYHFTmFHORCUkNNb17pWHpaYvet+I3o+ZEMyUToKIgwiokvgsUExhAoLt3eEych265VMKYM0mIkoMC0Di5L5hLoIhAvwx9c+Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4818.eurprd08.prod.outlook.com (10.255.98.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 14:39:37 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 14:39:37 +0000
Subject: Re: [PATCH 03/17] qcow2: Avoid feature name extension on small
 cluster size
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204173934762
Message-ID: <899d4d43-f5c6-63d0-d61a-8cec4a84cf7e@virtuozzo.com>
Date: Tue, 4 Feb 2020 17:39:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200131174436.2961874-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR09CA0070.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::14) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR09CA0070.eurprd09.prod.outlook.com (2603:10a6:7:3d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 4 Feb 2020 14:39:37 +0000
X-Tagtoolbar-Keys: D20200204173934762
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4a80411-cabf-47a7-b41e-08d7a9800f6a
X-MS-TrafficTypeDiagnostic: AM6PR08MB4818:
X-Microsoft-Antispam-PRVS: <AM6PR08MB481801A2E0A4470A720D2E4FC1030@AM6PR08MB4818.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(346002)(376002)(39850400004)(199004)(189003)(31686004)(4744005)(86362001)(52116002)(5660300002)(8676002)(8936002)(6666004)(478600001)(31696002)(81166006)(36756003)(956004)(81156014)(16576012)(66946007)(2906002)(26005)(316002)(186003)(66476007)(4326008)(16526019)(66556008)(6486002)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4818;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDZK4EO04MSFP0F5mtedfRvicYCFv/H/d3A0ECj8c2iV0YmnYLOHUFtY8R9aAyeRPqEHI+pu2gff6ka6IwQaeWkG1s5PslwDbRwg8vJ3tl/IWE27ITloikq7hEbz4GTnU8vTFTiVop9p2MfyCOPHGj+JvIGobJ2/ydLs/0wYJczRft0ECwG5LydQeSg7+r8sjGnT+uEJflixsTV+MRdy9oqFRANXry7YLEXu3grUTN7GHxOoF4EsgEN7rFBWADyWfC8/Krr2hXYvgqMTLv7S5KGtfZkxKRjKwLPnDGlQ1/kiPLwr5kBDyKWbYREdNYm2CozAg/onJ/2GwznqIY1PzTrLGRz/J4TLP3XF6i3CzBwGz1iTIIWprnNmr0FrZoY53ORpphJBQA/vh4qk/JJ9GS3ac4jb+T0Zp4GkV0ACVTVCw0/xzSyupyguc+9TpiH2
X-MS-Exchange-AntiSpam-MessageData: xbR+LKOvnstrGT5p9Oz+ySlhSsgf2dxa9Q9l1vBKJ9wBV/gonQB9a0r6H7GTbvU+O3FV+o+kpNPhXr7DGO6alOBG3O3v0zpUE2HXm7KE/NRBVM0kFhsH38qGvAeY0eDDU1M3Lyjc7ChCnfH3YSsH3g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a80411-cabf-47a7-b41e-08d7a9800f6a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 14:39:37.8042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: At4C+EJak/7+hKNfIVMw4u5YD9grNSr3ZidYJF469aCiqUmfxSHiDfmvCQZks3n1ocWWyi1LDFWthIJnEZpUV/lCCOwyX7qdGCYuXYnbF0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4818
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.129
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:44, Eric Blake wrote:
> As the feature name table can be quite large (over 9k if all 64 bits
> of all three feature fields have names; a mere 8 features leaves only
> 8 bytes for a backing file name in a 512-byte cluster), it is unwise
> to emit this optional header in images with small cluster sizes.
> 
> Update iotest 036 to skip running on small cluster sizes; meanwhile,
> note that iotest 061 never passed on alternative cluster sizes
> (however, I limited this patch to tests with output affected by adding
> feature names, rather than auditing for other tests that are not
> robust to alternative cluster sizes).
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

