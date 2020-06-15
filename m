Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B91AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D5D2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 09:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vh0k3Z3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D5D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkleN-0006DN-8w
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 05:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkldk-0005i4-4J; Mon, 15 Jun 2020 05:42:52 -0400
Received: from mail-eopbgr130128.outbound.protection.outlook.com
 ([40.107.13.128]:40717 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jkldh-00066t-CG; Mon, 15 Jun 2020 05:42:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA6qddbx6+VRBnggaO5Yhyd6B0x7y/0MXvjTEjlJc+PuvSwOWYv2jDiABrwOHPLsq+7jC+iEI/lEV5WyhA5BDkVkVSjLimRvWrT6eyVWJs0DAdXLVwKe8hRpTvNAdeT2CleGp5ZHuizYZj2Kns2Qo89RQN/8ugIYPsx9s0AyH0NCUDOTlt5bxwbNw5LMA1pfpjGOu+KAJUrobcYuFRYtWMoJ5GQAy3RQ2/orcjbRh5aPM1xysALQoDyCo8G2hDrYiNj7XWSoL3KxysVmbo0IVnP91fIkaNNGx2aWk8HcIAVylEanIpdSqReHy0B5PTVsWjJus2jKdqjKcGuSVZ0bPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnsM+6foBlguwaV622mTFSgSllVNvqQfYhnxAZKliRE=;
 b=Ecq6gtHq1aaRwI6cNt0jLxAzAT+rVo+PuLDcPn7Sb+biZo3uoHqxy8ZMjAeS9Qmn68lgsREChp8LFU8Ux8N8ldWb7yW/EfJe5xlKOwpK+PmXAsxyj6ZZxrDnizq7vLC1mYOqP2K+JDtPth9ZPI/s4UytjVkwluPmtul84gij+5V8iEouSi4VaUp0a5PjBI8jFJGWXVo8cPgZGMK9WlQSPbS6cofFCGktW2+Z4s1QvKLG5S0H5Knzo4MEdod92Q/X5xqqnsfSf05n09V+r0zMSQzT4WqNWP/rka/MCO58s4QlFCqUJ/3UjBGgruQh0io0StugJOv1b9dAZ9UuG/ny/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnsM+6foBlguwaV622mTFSgSllVNvqQfYhnxAZKliRE=;
 b=vh0k3Z3G7ULbGSO54FscclC101WZF6wjFcl2wbnJcpid5K9bBEq1ykmjFVcJAJSvFATSVEGnW39Fb8UPiv4A5i4Wd+xrTIEvewUiyfbBP80kT7LmwRqOfoYL9oBWtav5ySiRXb3+21sZr7CnuOzTRcPHxCuZ9QgGJlRQmc+B4eI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Mon, 15 Jun
 2020 09:42:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 09:42:45 +0000
Subject: Re: [PATCH v7 0/9] iotests: Dump QCOW2 dirty bitmaps metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591920302-1002219-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7dbb9b84-cab3-8cbe-b5c4-e36d102c64f5@virtuozzo.com>
Date: Mon, 15 Jun 2020 12:42:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591920302-1002219-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.23 via Frontend Transport; Mon, 15 Jun 2020 09:42:45 +0000
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4a3b3b2-4058-4f31-6c5b-08d811107547
X-MS-TrafficTypeDiagnostic: AM7PR08MB5415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54154AE682DC135854E38ADFC19C0@AM7PR08MB5415.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJ4gae7tdslhHZbqSb/KauCzM+qf4UygYJWRam+NpJ2HH0gpU8CCQuUyV79CWjL9pHEvTIksgWQL5J+owTHYe6cyj7NOFXvB7E/KeDAcuvtiaPe/bt6mS0dp50m2He0d2yC7lkhOV+0ceHYPzA+4YkJks+k+I0pEy7poaXon3V6TjBT4RdM7fVSEHQWEHxlOf9PvFhG8G6folehvs6z1oWEdNkC5Eba/sZTDHlKsiDld8+R6VmJnr9VKNULkh1pNl54H5C1qDthwrCPFLOF6c231nayJ1nE8aMAFKdwf0J7sucaz+KsJaN4V0Y8ppMywuQmxwCVCrwbiMwO9BCr7luVGm26OBm4AKnURXkh5pD1ug3PaYcbLyrdGF6Z4n4g98hoPa4PS1PvVSXLeMXwDNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39840400004)(346002)(366004)(376002)(2906002)(83380400001)(4326008)(36756003)(107886003)(5660300002)(956004)(31686004)(2616005)(66556008)(52116002)(26005)(8936002)(186003)(316002)(66946007)(66476007)(6486002)(478600001)(31696002)(86362001)(16576012)(16526019)(8676002)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T6Myjaie0VAGRq3s2W+M0WPH192nycjlUlN462b5A69XacQ5/aLgSBU8RwZeFVw8tPKjoSo/+AqvHboIa8/SCC4KwKPWiJLs25RIsgFdL5jQzZJGyU+dOjEnPCYhMvVfsQs9jbjdu3+FhiwhvjkY4wgYcLmyrqrLRObKEzmK9kxAf16Pe2Q3bb0wePFosQ/KKD0NazGPG0u//BCQau1Dp/3OXTkY/+s4ApFPAs8cx++8avEW2N+57bEWGZaGWOW/teiGufAMUdGBOzuQn2qvnR0Rz7BnRgvIlFYoor/6xfYhRzYdXdJ5g55Kos1QJ+VkbPY72e2VjuNhO2n2NAU+jjjv66J4gNIO+zsuVj5QaI4F7+7fcJhGJu20ko92579Dwl6n37chwQJ2C5XQLDNyikkZtOi1JAEGt5bkOND7L09YBWqzwczrdXVrQ2Ypz+t4bjZX718jjRigMbVyKduGvGwVBcserbus3zc03grfKDlvY8sbANlcUdJOvD5qbPnN
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a3b3b2-4058-4f31-6c5b-08d811107547
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 09:42:45.9311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbPa4OUIItNU3S+NY3JYaBT63DW7Xbgln7/9+S7RWBkGtOXmAhYx2EkTwTE4JWjmjk48cplJimME4Hg4u08me2/7KgrYEGz/EAR5/8zpliY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
Received-SPF: pass client-ip=40.107.13.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 05:42:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

12.06.2020 03:04, Andrey Shinkevich wrote:
> Note: based on the Vladimir's series
>        [v5 00/13] iotests: Dump QCOW2 dirty bitmaps metadata

It's merged to master, so, based on master. (except for 01, which is not needed, thanks to Eric)

> 
> Add dirty bitmap information to QCOW2 metadata dump in the qcow2_format.py.
> 
> v7:
>    01: Fix for magic hexadecimal output in 291
>    02: Bitmap table output format improvement.
>    03: Incremental change in the test 291 output.
> 
> v6:
>    01: Fixing capitalization of header extension constant.
>        (Suggested by Eric)
>    02: The cluster size global variable discarded and passed as a parameter.
>    03: Re-based to Vladimir's v5 series.
>    04: The code of passing qcow2.py JSON format key moved to separate patch.
>    05: Making dict(s) for dumping in JSON format was substituted with a copy
>        of __dict__.
> 
> v5: The Vladimir's preliminary series
> v4: The Vladimir's preliminary series
> 
> Andrey Shinkevich (9):
>    iotests: Fix for magic hexadecimal output in 291
>    qcow2: Fix capitalization of header extension constant.
>    qcow2_format.py: make printable data an extension class member
>    qcow2_format.py: Dump bitmap directory information
>    qcow2_format.py: pass cluster size to substructures
>    qcow2_format.py: Dump bitmap table serialized entries
>    qcow2.py: Introduce '-j' key to dump in JSON format
>    qcow2_format.py: collect fields to dump in JSON format
>    qcow2_format.py: support dumping metadata in JSON format
> 
>   block/qcow2.c                      |   2 +-
>   docs/interop/qcow2.txt             |   2 +-
>   tests/qemu-iotests/291.out         | 112 ++++++++++++++++++-
>   tests/qemu-iotests/qcow2.py        |  20 +++-
>   tests/qemu-iotests/qcow2_format.py | 217 ++++++++++++++++++++++++++++++++++---
>   5 files changed, 327 insertions(+), 26 deletions(-)
> 


-- 
Best regards,
Vladimir

