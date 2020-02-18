Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E04C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFE721D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UvHCEL16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFE721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j495o-0006cy-40
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j494V-0005aC-Rf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j494U-00036J-6X
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:02:19 -0500
Received: from mail-vi1eur05on2102.outbound.protection.outlook.com
 ([40.107.21.102]:3168 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j494M-0002hb-Nv; Tue, 18 Feb 2020 15:02:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boVz1Wa4O4LFxRVb0Qfuztj9WuvCTZcAIMkHonLCYJqeSY9R9/iOKiKBFJCejdSgQYdwhTwVgfjNYOBRhUIekimqQPJ5JjJ69hwyE9GcylhkylY++/9nNKi1LjkPX5SE8dSMREBSTlwKJDzwcxZsdDCMXdpzYL82haGPtdLO5FzF0NuZut3m6JsCryeS/jK6KyQiByY2s9O7OE65g/n8aSKdmHMjyL6KU41RIHlG30VfpPDeUN8dIJTknrwM2OMQ5cm26hqe5uyXg0C4hHiJ1ZxoMAB5IAKRlXPpIkFKmVSAm9oxl94i3V7/NLFqJHDD6qYXFH2L4ubbVHUMJvHswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VKlKukWKqJjwrai5W9mS6gmrLUwQiHoakQWnQAdcS4=;
 b=JzkDBU6BHcGnlhLbSzriSZAp3CoXCEO8ymfRRcN/s6w5NmajXVU0apnFwcnfkDvJLc8AYMZXlZifQRjxw1DMbn5L24Y3hRnX2C/2V1eyGuVyFPKHyU8RhPlZNc61jmRgnDQKb0AUexvPCEUsYHU93c9BcUgDGKYQAs/jSeAht1kRYbVsfMKPnyYlggDbboQAVVs7JH9B1xPyV9s4WRwm2lNa11K2DKMlI+DmQRL1OIuudQTr65lA4dA+pUspTUq1C8OMQkCV8CtsB7IDpIIwL+WYVbhOQungov54AN5EdowXqxhl2K+Na8MIA9qaawrgDgQ03dlk+X0sg+FLCYAKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VKlKukWKqJjwrai5W9mS6gmrLUwQiHoakQWnQAdcS4=;
 b=UvHCEL16yBexkljqJO1WRraxk9BOIrqMmgt19R3cYbbiYudoPHBsa6y/2j73yS+TzeoDKvCceGMIF5eLkNt+4EF43tJUNmyLC6lD0E1rq8r0dhLB2JsX3zT31TKicJsSUciDC3VULy/tx/uRcxor53AcdTRJO+95zgNgDFeF2+E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4803.eurprd08.prod.outlook.com (10.255.96.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 20:02:07 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 20:02:07 +0000
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <33fa0ba7-714f-c78d-8ca5-1e15dcef5ac4@virtuozzo.com>
Date: Tue, 18 Feb 2020 23:02:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0042.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::31)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P190CA0042.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Tue, 18 Feb 2020 20:02:06 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67347694-ed3a-41f3-3f91-08d7b4ad6e76
X-MS-TrafficTypeDiagnostic: AM6PR08MB4803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4803B9A1FEBC9054038B2696F4110@AM6PR08MB4803.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(136003)(366004)(39850400004)(189003)(199004)(956004)(53546011)(44832011)(31696002)(26005)(86362001)(81156014)(8676002)(5660300002)(7416002)(36756003)(81166006)(16526019)(186003)(54906003)(2906002)(36916002)(52116002)(8936002)(31686004)(16576012)(2616005)(478600001)(66556008)(316002)(6486002)(66946007)(66476007)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4803;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4TTbLXDVyX0TzJixUDDiQBrcI/ViE8ec2B3r8nfT1/Cx+3sK7NKNS3aIeSn5GfQ3wJJfG13s55I8RCNqVjZBJ3t41YWWFSkSDm6BEggjo6flpt4I7t+pvhk6K3xg+lpEQaFJuo9EIunBkl11Am/hv+cdd3xgxSN++bDmRFUievBfb6e6Mvt5vr33NhNdN4YvSCu7XgWhY6Pf22Cz3NIzPKU+8ZsRGcR+e091xkplkyKOllXjyg8C04AGsGDxsqgEEsGSLuFHxRYbQWVGI7Xl3flqJRlbOBCFef9nJ9BeERkGviLqXl+BXoShz3ryp1gLwMjYmV1ffhVsF0WszMo2OgwaPASSgAlWbWN/B4JLlmVW6pVhwNPuZ7F0cv+0114EgJ/kfAYcKm+byJMFFCQBs82167jt96lBwqRZP5xJtEWJ0GhGbJKupWQJ2PUvhC+
X-MS-Exchange-AntiSpam-MessageData: YvZyhcDzYAcRZjvTfICK/rlHdOoYbDdzdg76LVe2C5wbkxIQqbh9Wxnbbd9N5z6FfHtX70qor5jNr0p3iVmd3oIhL278lQB9coaJk8GBrhCxKjXsN9Vn42Hpnq9K7as06DCK5IMlJelCqCuPB0krGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67347694-ed3a-41f3-3f91-08d7b4ad6e76
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 20:02:07.3618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V16s1se2b+oMmAPDmcTQ3ddvrq7Ca2OMrJ5qYFqe0IIKTOC13NJ7LJPKMHfjK3UbmW5vTj+cGPRXnTEDUJSrLrSbiSVGTZcbd2BC68jRIUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4803
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.102
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-stable@nongnu.org, dgilbert@redhat.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-iotests:$ ./check -qcow2
PASSED
(except always failed 261 and 272)

Andrey

On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Original idea of bitmaps postcopy migration is that bitmaps are non
> critical data, and their loss is not serious problem. So, using postcopy
> method on any failure we should just drop unfinished bitmaps and
> continue guest execution.
> 
> However, it doesn't work so. It crashes, fails, it goes to
> postcopy-recovery feature. It does anything except for behavior we want.
> These series fixes at least some problems with error handling during
> bitmaps migration postcopy.
> 
> v1 was "[PATCH 0/7] Fix crashes on early shutdown during bitmaps postcopy"
> 
> v2:
> 
> Most of patches are new or changed a lot.
> Only patches 06,07 mostly unchanged, just rebased on refactorings.
> 
> Vladimir Sementsov-Ogievskiy (22):
>    migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_start
>    migration/block-dirty-bitmap: rename state structure types
>    migration/block-dirty-bitmap: rename dirty_bitmap_mig_cleanup
>    migration/block-dirty-bitmap: move mutex init to dirty_bitmap_mig_init
>    migration/block-dirty-bitmap: refactor state global variables
>    migration/block-dirty-bitmap: rename finish_lock to just lock
>    migration/block-dirty-bitmap: simplify dirty_bitmap_load_complete
>    migration/block-dirty-bitmap: keep bitmap state for all bitmaps
>    migration/block-dirty-bitmap: relax error handling in incoming part
>    migration/block-dirty-bitmap: cancel migration on shutdown
>    migration/savevm: don't worry if bitmap migration postcopy failed
>    qemu-iotests/199: fix style
>    qemu-iotests/199: drop extra constraints
>    qemu-iotests/199: better catch postcopy time
>    qemu-iotests/199: improve performance: set bitmap by discard
>    qemu-iotests/199: change discard patterns
>    qemu-iotests/199: increase postcopy period
>    python/qemu/machine: add kill() method
>    qemu-iotests/199: prepare for new test-cases addition
>    qemu-iotests/199: check persistent bitmaps
>    qemu-iotests/199: add early shutdown case to bitmaps postcopy
>    qemu-iotests/199: add source-killed case to bitmaps postcopy
> 
> Cc: John Snow <jsnow@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Cleber Rosa <crosa@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: qemu-devel@nongnu.org
> Cc: qemu-stable@nongnu.org # for patch 01
> 
>   migration/migration.h          |   3 +-
>   migration/block-dirty-bitmap.c | 444 +++++++++++++++++++++------------
>   migration/migration.c          |  15 +-
>   migration/savevm.c             |  37 ++-
>   python/qemu/machine.py         |  12 +-
>   tests/qemu-iotests/199         | 244 ++++++++++++++----
>   tests/qemu-iotests/199.out     |   4 +-
>   7 files changed, 529 insertions(+), 230 deletions(-)
> 

-- 
With the best regards,
Andrey Shinkevich

