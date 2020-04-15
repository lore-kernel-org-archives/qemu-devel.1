Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F8C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414CF20775
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fvq8RM/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414CF20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcUk-0001RN-At
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOcTl-00006f-Qe
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOcTk-0005SY-Qs
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:29:01 -0400
Received: from mail-eopbgr80129.outbound.protection.outlook.com
 ([40.107.8.129]:52462 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOcTh-0005Qb-7F; Wed, 15 Apr 2020 03:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dY2/InPSgRvpCnektJFb5ubwxoQJJM0IZLM2NOn9ZJZJX22LLZ0mlL/ysUHDnzueX311TbKUihLx5v0oJrN89VcTMSVgVbTw2dqX5lj7hXq66+9ZYvWxkQdDSAZa6LNsqiF0FpoilrEjhpWNA0rReTk/XvfGaeUoTmvXtLT35QLFyd8vDYkDd2rbKTPzOjNGBvqwfWyflzK/VsuU5YhVcz6wUKZexdY5bSP9dPq4yEs3uOWVEO9gjLfGAwuB/EdcO87kfHo4PLpKJXw/X2Y2tINyz5kY2TU6oyt9gyP139TpgdYBaEL5cqUk2GEpZSTU17lBskqaKlMSCZisxKI/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPvOgyQKrDZExvENdjOFted8yga1rvnxaJy5Pwcbj/A=;
 b=bdmpnPch3wwi7lsQphFrFSWA9pQ0tv0fTlRfj+9MBD7GXiGohAmvJvq77ubdU0JOMFan2u1VecQaiHRNoudo6JigOAEhqoDMkv228ISPtHoH2GA3sJX5v0x8S8iptwtY7/uxVP69VWmnDS/wm0HckzwDhFM3u0bplVopPxeriaNchDzbtJ0AdKBFQHqSNBgO5Syr3mpgmhUA/6ZTzw4ICq2G85gIqLz8ko6DaO5KDH5wScp5bYIFKEgW3SMzmUb4IkM/EluwflXuoDT0uidWxbw+uPDfpqWIwMu4rY/RanEHz7b63haI12ZRwp0S5c39UMNVov6v4m8Xzu1vqT2Bfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPvOgyQKrDZExvENdjOFted8yga1rvnxaJy5Pwcbj/A=;
 b=fvq8RM/ZIHNvOAPFC1I6jMCsvAYy7wznRRIyuNjBXgMZbsn4MJqVyy2OEOAYus2tITwmjPviSveorUuTsZzrsWcNjC+BeOirsMvSAQKiXK06X1/k6eVQwKWU3DiI4SBDWMLZGYJ5wZ6SmvELezOgHdcEsJToJRS3qicZYu3RFSE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Wed, 15 Apr
 2020 07:28:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 07:28:55 +0000
Subject: Re: [PATCH v4 16/30] qcow2: Handle QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <8d7d7287935141177c6a6f92196acc638ea5225b.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200415102853462
Message-ID: <3772a73a-5739-2458-b65d-e67475a80499@virtuozzo.com>
Date: Wed, 15 Apr 2020 10:28:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <8d7d7287935141177c6a6f92196acc638ea5225b.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::36) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM4PR0101CA0068.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Wed, 15 Apr 2020 07:28:54 +0000
X-Tagtoolbar-Keys: D20200415102853462
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e72c3f71-a19f-456e-f538-08d7e10ea75c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53508FDEEC0D359BE0C721EDC1DB0@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(396003)(376002)(39840400004)(136003)(346002)(66946007)(6486002)(5660300002)(478600001)(16576012)(66476007)(66556008)(316002)(107886003)(4744005)(4326008)(2616005)(956004)(54906003)(8936002)(86362001)(26005)(2906002)(52116002)(8676002)(36756003)(31686004)(16526019)(31696002)(186003)(81156014);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSbZtziDFHr11fbhw2zAo8CmZSjilxtq7R4Ril4MaP13Nzp2DK1PIvGLXCy1XNui9j+iW5I1jFBbp4ZJI5vBT/hZbfYSP9QsqI+QouL1LVKII/8n0rlAUfQOh9eNiwTodhvqPNcv0HwuGL39QgctTroeML8PIt3iPOz+NbqxVZ+9gwAqOJ673Iw7uqSB94WWd/RjfE4rRhhUhlGTXKDdW1vYRfGwJnBgB/Zr2a6kmm+ydFSlHAMqJeTSYkWDWtlpLgYFQObU4Hu8id3E6+QbDHKKih2SXWcdTyfoBMLx5SbCspyaV05jIFX9Ms1pYkrQzCuDAny0k3R0UCpXB+HC9/Du7FQ6Gr/HFICv46sNHQBSm4eo1OunWRmzsTVR/ofn3ALSVzdQDlf6+rYrmV+UV6Q4cMFcVawjZWQxcDG7H2kC7pMnBlGcki6mUAjFY5AX
X-MS-Exchange-AntiSpam-MessageData: oCNlZWgntf1j8OEvA8yiImvP20xvmBMlkAKza0bjEliKJKKiOzOU8eooisSqo6tfDxIV6uZ5wvj9lOhwe9f4HenaAzOFIDB6soSQfemjI1h7rtu5i/S/8gmfjukt+GGYaBd4ZFTzc8jiROJGPT3lWQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72c3f71-a19f-456e-f538-08d7e10ea75c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 07:28:55.1177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRH1LBOp91fPpfDZ/EA0UGz2xncLLbz1ltAwQfLkm4SdAnwHzbJPKNl/G+tWKyugmrc0SqVkwAW/FjO8prmMU9r/JQAQZ9DLQfTSWjx519g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.129
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
> When dealing with subcluster types there is a new value called
> QCOW2_SUBCLUSTER_UNALLOCATED_ALLOC that has no equivalent in
> QCow2ClusterType.
> 
> This patch handles that value in all places where subcluster types
> are processed.
> 
> Signed-off-by: Alberto Garcia<berto@igalia.com>
> Reviewed-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

