Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637AFC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD9A2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HKFLkMS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD9A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOL7-00026V-BI
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOOHn-0006VR-PJ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jOOHh-0004yv-10
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:19:42 -0400
Received: from mail-eopbgr80121.outbound.protection.outlook.com
 ([40.107.8.121]:27910 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jOOHT-0004uf-1M; Tue, 14 Apr 2020 12:19:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nljeRqhO9kob4MmUItCGG/uAJqiUAqk3PfpAMjD6wuuQNkcfUEHo0Dplq1Xekv0OMfE2BJ/wy2brg7RBCIvem1Z2uaERYYcTv7MwoO5HGinv/4tt9m7rIo0u7tYSgPRBZSDrFd56JRRhVyJziLUIho5LqqY+ogXZv8fHYCtCkjo0JdLCwECKoSj3gj9i+3BS+12DG5K0ncT3DTGIS9XsWXMGSaiFOq+1gxZO+P1PYItAq8jBvVX/AmZwt5J+X89ImkiG8JiBHkb3gzvpnhkQZ4WuYbeVohU9j8HEDbG2Pha8nUWRLpb8pqqUEF16kzhcEib+FW+rrMjf25keWSAjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmNRnjtBRxi9dY4qi2tjYoIQITmjbbAww6EiuF2iN0o=;
 b=XkR2wHwXIa1H/w5tgbpq+aKLcs4LtRwTWCuf15QlOM++jYCME/jIvfZC0vULOnA906kmBTlYA7ukGyKKU99BWMa0z8I/WmPpgtuWMe731rjFkDaWosO5mimC1izU3ByWGlcFRhuqwEm8Kd5UBmpYzK5G6/8zFighrAD8MSoyRVN3A2wL2zXUGDdDG/41onfqfBEbA3mCj3nwLMmlfLaFYpJxcKWc+LBsF/SESJfKwmX5nJKB98Oeh8pQFjyGLy/VD74IWWTtradB4lL1ptc9pibS1/1SSbOkvuc3SggqKzedzX+EaxrfjC/baisW63iCT6kDE3ESPzyieAQEfEv/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmNRnjtBRxi9dY4qi2tjYoIQITmjbbAww6EiuF2iN0o=;
 b=HKFLkMS0z3AWhp1bjwCR+ENM1z0EYOG+Ofhi1n41IQ+wYJ26RTUIiqmZ2Tm9eEzZuuOKSwKoLqbPKiaRNDlHIl45mydzP4GVkL7tZ7xIzPtYXLNYjZ5ba9rDiOb1POnIYz+xpo0qIwYtCwNfx4SZQgjV/I8L8zJDgBrX3edUvMw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5525.eurprd08.prod.outlook.com (2603:10a6:20b:107::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 16:19:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 16:19:21 +0000
Subject: Re: [PATCH v4 07/30] qcow2: Document the Extended L2 Entries feature
To: Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
 <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
 <781c734c-e53c-76ae-74de-26d9e827e1a2@virtuozzo.com>
 <w51o8ru5dg2.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200414191918469
Message-ID: <83922517-b5f5-2d4a-6518-c1912942ad27@virtuozzo.com>
Date: Tue, 14 Apr 2020 19:19:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <w51o8ru5dg2.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.131) by
 AM0PR06CA0105.eurprd06.prod.outlook.com (2603:10a6:208:fa::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 16:19:20 +0000
X-Tagtoolbar-Keys: D20200414191918469
X-Originating-IP: [185.215.60.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b74cf27e-64f5-4fda-9d21-08d7e08f96b1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB55254A821CD9A27CBBD2F11DC1DA0@AM7PR08MB5525.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(396003)(39840400004)(31696002)(31686004)(4326008)(26005)(16526019)(186003)(52116002)(107886003)(81156014)(8676002)(86362001)(6486002)(66476007)(66556008)(66946007)(110136005)(16576012)(54906003)(8936002)(5660300002)(956004)(2616005)(36756003)(2906002)(316002)(478600001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YAA2ToDpXIqn+BGIb01SJt8A5BLjvp/dr4qLuseu0Aywna1IS/CYN/zOQy0NPrvkTUnoQtkO8zjGkMU6RE/8zr2nrw7fRd+ajHTekDriFZnsUMNqRS8hVE/8bD5W14Q3nRaE2IEB6kg2P0BjK9GFVe5IVtwmAi/EqZzy1LTZmnX10MfW3i3F7XBtZJAusivm4HDEsLc6BZ3gOs50Cs0zm1UssaU06sMqmyPdzfQfEqQ27Bi7R1n0O4TDPXbkCZLGGPi7DKN+oixBd8xNPpVBTGOpjfkb8fKl/iyTTkn0dcVGAMMNuba21wbfvAaMs6rnxfApE8xbiN0PLvk/VfLTCxkdjC3ekSy+IrLIz7rMXmE6FPCR4m0O4/TiNKB1P5HEflZordrL9NLdQk/tEdMmZVijGOAq6xVwb4HZmBe3YPmQrk5tZSs11z1+kqWxRpg
X-MS-Exchange-AntiSpam-MessageData: RpozgzxOy0XMJsdMyqGL9RyboSk2fVS55BtN774+C3ZVCfCJ7dQtRnwMMsr+pQYOHA3eib1EE1OcdPeJrEDFRmpvg8DF4uSMBTXrq2VfNYrFUEWLy8ACmcnT/ZS8ttImDBmsVsrvelQ689YgUyNK4w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74cf27e-64f5-4fda-9d21-08d7e08f96b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 16:19:21.0626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ClCm1MPH+wX7HC4Z9Y4Lf2CqoFMvVQscocaPpeS1g3MDVNvGhVkm0RRLFw5ZTDcCM0j7I9pxYZtRP8weD+G6n1r8ZgdW+jA1TdKuW0cAGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5525
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.121
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.04.2020 17:50, Alberto Garcia wrote:
> On Fri 10 Apr 2020 11:29:59 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> Hmm - raw external files are incompatible with backing files. Should
>>> we also document that extended L2 entries are incompatible with raw
>>> external files? (The text here reminded me about it, but it would be
>>> the text earlier at the incompatible feature bits that we edit if we
>>> want that additional restriction; compare to the restriction in the
>>> autoclear bit 1). After all, when raw external file is enabled, the
>>> entire image is allocated, at which point subclusters don't make much
>>> sense.
>> It still may cache information about zeroed subclusters: gives more
>> detailed block-status. But we should mention somehow external
>> files. Hm. not only for raw external files, but it is documented that
>> cluster can't be unallocated when an external data file is used.
> 
> What do you mean by "cluster can't be unallocated" ?
> 


I mean this sentence from qcow2.txt:

                    "The offset may only be 0 with
                     bit 63 set (indicating a host cluster offset of 0) when an
                     external data file is used."

In other words, cluster can't be unallocated with data file in use.

-- 
Best regards,
Vladimir

