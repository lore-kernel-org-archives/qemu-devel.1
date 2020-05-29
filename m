Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5D5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 05:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE804207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 05:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NYfj1NnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE804207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeXxi-0008ST-0R
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 01:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeXx7-0007vn-Ch
 for qemu-devel@nongnu.org; Fri, 29 May 2020 01:53:09 -0400
Received: from mail-db8eur05on2093.outbound.protection.outlook.com
 ([40.107.20.93]:21344 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeXx4-0007b2-G1
 for qemu-devel@nongnu.org; Fri, 29 May 2020 01:53:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nei/GBrTpaV70PXynks/rnjWyuazPHSk7n4QNiIPDM8M+CztJGxBSV7Qtf8R8XROkMg2CtIfQZstIZ/l2dEIJAd88LtltL4WF5kJ+93S4ihFuF4/6GXNQqr3veJIdNn74qu8MZjhJPxJUD6TnvTo9u92AhPOc3/PtqS5j+w7U/wc8Jwlc48Y366+smFo3P2+YBUhtmo9a3wmrKwOHIgnb0sQ7PdOMahbhZVVg9vQz+x+lKIFdMcZ270rkfxvch6bw7/vKNlH+fdycHr/3wEzTN8XK9oimwu7fhWsTOH0Z02sDNImdGhQQ0UB94HKcfINZs3naK47JQpYWwS5BrR0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I7T7OWbQqYx0M+e6NOfUcGFIDJvWZx8z8LAUNBf/1c=;
 b=Gu6CFhnzPQCjxR5dJE8mLcd77Tz2KzlfhqC3EonNGemKF4O6LjWzOA8vpcZeT4Eqy4UqSsMulUSg+Qm/yzW1EwYNUdOrfjeM82pjXYcYEo3kySKWpMjI5dzIFb2FwLHwiQyUyJo3CvGmlz1rKmN9U9iYNvt/Il9fmNUTeB5Wb/YJR4heq1p73kVFsk5rEhuLQo0nwInqiB/1p42pcHmEGUtfXwrua828XxIVj7mVqSGe+tcLZwlJXgapnklqIc5dGMVkuRVKo+q4c0ISxl7fcnTZnoy/d9yOE3ftl+Nm33NOKloqykIL8ZyLrN/6OnoQEm1E5PEgDNSHVpF9XPzesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I7T7OWbQqYx0M+e6NOfUcGFIDJvWZx8z8LAUNBf/1c=;
 b=NYfj1NnOsVPLIzw5ADMtRYe62akmYAqKkSxcwPAifl850PcwVBzlhdFhGCb4lk73tOafs8kIFNlODslxDgMiu4jRGVjqiPLpS1HUxnNYoLenT+92ppRvgPSfg6xTHOALj9t/lGYY7nVUO9/R6k/ldKg6z6NL/KvJMe9XK83ldvk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5383.eurprd08.prod.outlook.com (2603:10a6:20b:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 05:38:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 05:38:01 +0000
Subject: Re: [PULL v3 00/11] bitmaps patches for 2020-05-26
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200528181849.1823820-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9311ff39-d237-4d14-cc73-b4e38b7e40c1@virtuozzo.com>
Date: Fri, 29 May 2020 08:37:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200528181849.1823820-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM4PR0101CA0062.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend
 Transport; Fri, 29 May 2020 05:38:00 +0000
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311104f7-df77-4df6-dfd3-08d803927387
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5383DB7DDD6A8E0992109F6EC18F0@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ksBRp4ERSpulhlULHv/SkcAtOlVFs2s3s5i04BcTtptfGyPWbVp9IOZKvjO0QUFw3xrIla5IZTFGWdHPzA36zOF7Jth/9gL+hWpsFVwCFweTVIHouGCm/6Az7vC1ppyrYlAgp4y/yodXw4HyiWS/VdNkcZNelyeDU1iHCsbCEShMxl9QdsZoH1juFe3hZbhVQalCUdG+79H+OOteG1y2ISlF8J4FyG+O1N2J7+SO4NjlFMMzc3IhB5gGBvNYJyp9fOFNbMIXnLyKVJYIWvn1jY4vp/jvxjU2Cg4LR8t+oe7kpyZL0OasGzc8o8ANTfZp/eCQ91KQNMvbCZpWr4YBds0gUQKxTddgaEs2Za00zyQsXJJ437smtyVbjNSgv/5wh0GgngIx+ix1DrMp11FJRYCrT8S9R3fVuePVnaWbhVipgfnUFEPH1FpnwEVdNWxbpibMrSR5pME5oBim+oD1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(376002)(366004)(346002)(136003)(26005)(6486002)(5660300002)(52116002)(8936002)(478600001)(83380400001)(186003)(16576012)(966005)(16526019)(2616005)(316002)(31686004)(8676002)(36756003)(956004)(86362001)(66476007)(66556008)(66946007)(31696002)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nKRRSDrFwtpD50r01dZQQT1qtTnGy+fCtADYXkAGuH5XR7eJKTOsjmX+PwpPLOeAB0B94TYbMluXENjWjDId71U9YoMXlUYnLK6brReAzQ8nnc2YpCkkum/nyaIg82F8u6OcNXdxTTN1v2KXx9x/GMnsYOgmhmX3ttmOtmr6boP40sdgp7bjJ/09eFzbHkdopg7pBHGkg0hOGYn6z4s1oZBxdF/o6F4Cs0d9CcdzTumgj3602a3gTGoHoosxN0C4hEJlLh7G8IfM0ziRfYQ+QyKRisBryd9tya286KWDxp1dC/qysDt1xqmquvdIQCKEd7sv3IQ5v4ogvKcrQGbPIQGfkXtfs134WHIsKKJkyoc8u9eEbBXm2MucpvJYG3EZwJauGeVezNUP6rKRy2k1WoZrKoNvKVAJWajW7goLHaPZNsrzMUnBd8P8YSXwJe79p0DyMbx3Ameu2hh9lnHjK8DZsS8ZZJK6zCwfSbIawxLSlScX9VqHpFmsOThlosDW
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311104f7-df77-4df6-dfd3-08d803927387
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 05:38:01.3797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhUdlsB2/wuNLFzhi+3IqqZKw2tITiEAHtUmox7wQ12JmtzhY3xEq5fHhcXu6uGbOsdw8tJLoEfhuFx+TK6pj5b5gZDXzaN8hiwvLMGYKKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
Received-SPF: pass client-ip=40.107.20.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:53:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

Strange thing with your pull requests: I receive only small part of them.. I thought it's my problem of receiving part, but now I've checked that in mailing list archive there are same only two emails: 00/11 and 08/11 https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08061.html

28.05.2020 21:18, Eric Blake wrote:
> The following changes since commit a20ab81d22300cca80325c284f21eefee99aa740:
> 
>    Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-05-28' into staging (2020-05-28 16:18:06 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-26-v3
> 
> for you to fetch changes up to cf2d1203dcfc2bf964453d83a2302231ce77f2dc:
> 
>    iotests: Add test 291 to for qemu-img bitmap coverage (2020-05-28 13:16:30 -0500)
> 
> v3: port sed expression to BSD sed
> v2: fix iotest 190 to not be as sensitive to different sparseness of
> qcow2 file on various filesystems, such as FreeBSD (sending only the
> changed patch)
> 
> ----------------------------------------------------------------
> bitmaps patches for 2020-05-26
> 
> - fix non-blockdev migration of bitmaps when mirror job is in use
> - add bitmap sizing to 'qemu-img measure'
> - add 'qemu-img convert --bitmaps'
> 
> ----------------------------------------------------------------
> Eric Blake (5):
>        iotests: Fix test 178
>        qcow2: Expose bitmaps' size during measure
>        qemu-img: Factor out code for merging bitmaps
>        qemu-img: Add convert --bitmaps option
>        iotests: Add test 291 to for qemu-img bitmap coverage
> 
> Vladimir Sementsov-Ogievskiy (6):
>        migration: refactor init_dirty_bitmap_migration
>        block/dirty-bitmap: add bdrv_has_named_bitmaps helper
>        migration: fix bitmaps pre-blockdev migration with mirror job
>        iotests: 194: test also migration of dirty bitmap
>        migration: add_bitmaps_to_list: check disk name once
>        migration: forbid bitmap migration by generated node-name
> 
>   docs/tools/qemu-img.rst          |  13 +++-
>   qapi/block-core.json             |  16 +++--
>   block/qcow2.h                    |   2 +
>   include/block/dirty-bitmap.h     |   1 +
>   block/crypto.c                   |   2 +-
>   block/dirty-bitmap.c             |  13 ++++
>   block/qcow2-bitmap.c             |  36 ++++++++++
>   block/qcow2.c                    |  14 +++-
>   block/raw-format.c               |   2 +-
>   migration/block-dirty-bitmap.c   | 142 ++++++++++++++++++++++++++++-----------
>   qemu-img.c                       | 107 ++++++++++++++++++++++++-----
>   qemu-img-cmds.hx                 |   4 +-
>   tests/qemu-iotests/178.out.qcow2 |  18 ++++-
>   tests/qemu-iotests/178.out.raw   |   2 +-
>   tests/qemu-iotests/190           |  47 ++++++++++++-
>   tests/qemu-iotests/190.out       |  27 +++++++-
>   tests/qemu-iotests/194           |  14 ++--
>   tests/qemu-iotests/194.out       |   6 ++
>   tests/qemu-iotests/291           | 112 ++++++++++++++++++++++++++++++
>   tests/qemu-iotests/291.out       |  80 ++++++++++++++++++++++
>   tests/qemu-iotests/group         |   1 +
>   21 files changed, 582 insertions(+), 77 deletions(-)
>   create mode 100755 tests/qemu-iotests/291
>   create mode 100644 tests/qemu-iotests/291.out
> 


-- 
Best regards,
Vladimir

