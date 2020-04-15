Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D9FC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9EC20768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YO+CLtMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9EC20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcCa-0004iQ-Gs
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOcBs-0003oo-6h
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOcBr-0005am-9g
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:10:32 -0400
Received: from mail-db8eur05on2090.outbound.protection.outlook.com
 ([40.107.20.90]:39936 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOcBm-0005W7-8h; Wed, 15 Apr 2020 03:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn3EbnCRHuPFthpm8M92FsknijiBuh3VWph/ThC0kbOnwMZDw5ZVxHDRUks8EVuVqzPlFGYx7cpaGGB0KqRQIj8wNqoc+FGPPB2yc8+mV8ljAsX24yCbN7G3qNl+YC2JR1SU4TFErsSucwIO0C3iHNhEeSzoLip77A99b/WmmfLo4GHmaZqSUuMzzIzLi4jw7yGVox74CkGwXNfgd6PDKOAwjr7b72irUBaFmjCyOt6cK/t7Of9JP9ovrQ9U2sTOOvMyymaCB7jIP2WvlZsTd69EfcE4RpO+1DHkVidMVlxXY046sYQ2D2DPckGEaZtIKdAPUHmwtOViW1/nau0lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFwBUbx4mZjjyE3Ufz0RC0biXPm7OS9KgVKjtfbciGg=;
 b=Ae3W5z0p5JwRCXlM9cU8r20XksAHnIOVcemzrdCECcrjL0DhNQwqJY9Cdjp4pGHXXlL943Myg3uUHUp5G107TGIJ0qTa3a7WiiE3VxxtybmZMA0rwQuC9aH7FzfGoE9K8u3adgRELkG5CkUa54/aFSXtdg72kWFJf1WznyzUfKlWGvvTIBxsB41dUg1g1L5jEVXHcGSXCjUXQZitsEtaPcpPg9KkBTK6ZsG6OyHJKe1/Ka3FDvGXgTCC05dH0q9/v13LWCQuvQTD8lillBL6sL9WF4olYF3ydl7Q9qYPpP8abbEfB3vh5Ao0d0C+z61ACnf/T9uqMkQCCK2A7mFzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFwBUbx4mZjjyE3Ufz0RC0biXPm7OS9KgVKjtfbciGg=;
 b=YO+CLtMfFyU1rFqyr6/795NKP5pvKs3JGUu7TrY9jOchdJYE6CKyLbKdkyBmVoPlUVBkEX0x7lyjezKQUuLy67czHCIo2rBBSnKUtuKYGoF8YPTOM/2exgCnIUs/39dxnVvfXEDGUCUja0yD/QIhI81UToR+YpajUXN5JgGRugg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5429.eurprd08.prod.outlook.com (2603:10a6:20b:107::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 07:10:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 07:10:23 +0000
Subject: Re: [PATCH v4 15/30] qcow2: Replace QCOW2_CLUSTER_* with
 QCOW2_SUBCLUSTER_*
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <8e28c82079d24482fce8e9422dc45503a0401b9b.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200415101022062
Message-ID: <99edbe48-8ab0-614c-67b9-cee22593c801@virtuozzo.com>
Date: Wed, 15 Apr 2020 10:10:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <8e28c82079d24482fce8e9422dc45503a0401b9b.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0043.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR10CA0043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Wed, 15 Apr 2020 07:10:23 +0000
X-Tagtoolbar-Keys: D20200415101022062
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1403ed8c-0a1b-4b76-6f14-08d7e10c10e3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB542914F772948EB7A32A00C3C1DB0@AM7PR08MB5429.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(366004)(136003)(376002)(396003)(346002)(956004)(2616005)(26005)(316002)(52116002)(16526019)(186003)(54906003)(5660300002)(31686004)(66556008)(4326008)(66946007)(107886003)(66476007)(81156014)(8936002)(8676002)(16576012)(19627235002)(36756003)(31696002)(6486002)(478600001)(2906002)(4744005)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGNxZvHTZ3V5FZxoWRspa6JGQe6G0wtsqtiJjN4kFT4bNjhFo1JuZR1Fw+a4pzbgNnDIGh12tGIIfhnjTz1icDtyZMvEQhxbKCaOhA4QGTxRWo32s9Fyg1rFqTw5FRklOLog2z4zUnpZkNkZ0Tcqi0nAvsITiOwxScNhvYWJbRKHa2fUD+jhwBfq7e6ypbbeEN2hm3N8kTrdT1GGflRSUEY58eN8jyuN0fNWM26x0sQCVCFKjSDSL0FK/wwM1ETgJVtZud1mnUC/54N8D/1rHU4Ah0CgQt1/HANjZ5rSAmpHIakpJXxqaZQQX400+UtBzMKJnKfweX+udcX0LCgwQW/kJDKrKNJwKIwgUQ9FgebVZWtch1FjH7LDRnvgSqyK4qbxK+uaAbN9INZQ0klLIwPYuMS1lV7xwqMl7vds2PGIOHkKOANbA2aJTjA7VS79
X-MS-Exchange-AntiSpam-MessageData: hk8b5+Kr3aGjhY41294pVnYDokGwot6oodG3YwcdPAbpZgJGyi6VHwK6ybvxnoCgZQweZKaEOTp6PxchVA1lTL4VMSq99r1SVueVaJozON/30qfBxdkY02NgpimW5c/ryCa8MQ7KxTZ9UHYxYPqyjQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1403ed8c-0a1b-4b76-6f14-08d7e10c10e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 07:10:23.7184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7ioxyhKcP+KCj8ZVTCUq6lKggcKxeFKPgPRNHP2blLAkNrrvQyJxDSM9Xg2uRxgnRfaIgBokPq8FVet2s7jbH4iBSqLYzmILyFACi0xUxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5429
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.90
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
> In order to support extended L2 entries some functions of the qcow2
> driver need to start dealing with subclusters instead of clusters.
> 
> qcow2_get_host_offset() is modified to return the subcluster type
> instead of the cluster type, and all callers are updated to replace
> all values of QCow2ClusterType with their QCow2SubclusterType
> equivalents.
> 
> This patch only changes the data types, there are no semantic changes.
> 
> Signed-off-by: Alberto Garcia<berto@igalia.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

