Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F93C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6752520714
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rKw3n5ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6752520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPW8-0004PT-24
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGPUA-0002WL-Fq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGPU9-00055w-6u
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:59:30 -0400
Received: from mail-eopbgr140094.outbound.protection.outlook.com
 ([40.107.14.94]:14502 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGPU4-000546-EW; Mon, 23 Mar 2020 11:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/Mrjfj98LqCANvG8f9yudUR8EkHwlD3/1664gEI1TEedHyaFbAVPbxqoKw1sOc8WHLO/E/pKGvM1Tdsv3WSATXgJF+MS7R90ObY9312HIY6irUTEXuhH60blnUbhxtsHgl1wmBsxmv1B8JGXTSMTBMiCOCUz6m0Lhi+8CXLQMtOxxM7BHnV6hlcCRY2sU6Xw4R8tfg2w7XPlYEt8xmMa5PebBH1O7PSNIsUmDEboZjLGhZOKeTgjtVdYxgoXztjvFjnETd69LR/e5Q1It1b21V7pWkTFCH/sTafmi01x/aqaGWDxWWU7Wc6wXKlgL+9Y41bIiwaIu2sGvNEMcWDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFUJlrEZrYro2Dx+tmxXfmPzek3GcdTC2RzcIO5//UU=;
 b=Bcbm8rSo7tlTr5U5jHwXVB0nuejGU4g2MvvucDAlulSaoh+9eQtKeBOfaKK3aCWcdL8Mk34iYwdL2TJZrGw3xThwCjfeyLbmc/O40nhyz4QhTOt4arE+YhqLd0KSC5VgDszyrXXir/KD8q3WMgj+zCyp2qYbC4ccFIRYG6m+J/2Wm6DHzCPIfiPfA/nU7sX8iy/FF4iBL/eK5AcWefMuMdXJYwsaJjHir+NbtMs5OPTUbnPjKV59+prh/2Vmfdawxqcrd8/I7+nA2kYKHZH9gd7/Aay4gu7I6NQeh++RHCtBQl/gJ5OJi8BG4nU17vSAKP1CunX3PwkQv20ME9wxeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFUJlrEZrYro2Dx+tmxXfmPzek3GcdTC2RzcIO5//UU=;
 b=rKw3n5ed47VxJl9nUV6sevQtEm5FQ/PRk/MpgoUrLqCZQMkxgLvBD84cj3X6H6m7orZOU/MNtB0LL0OB0YCb12avFkEPmOLVXFRAiKf08a9lJ4Cmci9Ob6/mJDSWogUhL2IKEE+QiUh4hX+wkvnvP7LZRURpRU8SJN6fk/URkI4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5350.eurprd08.prod.outlook.com (10.255.191.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Mon, 23 Mar 2020 15:59:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 15:59:22 +0000
Subject: Re: [PATCH v9 1/4] qcow2: introduce compression type feature
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200323142558.15473-1-dplotnikov@virtuozzo.com>
 <20200323142558.15473-2-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200323185919275
Message-ID: <fc52eedf-fb1d-e036-fc51-e485038e2ddf@virtuozzo.com>
Date: Mon, 23 Mar 2020 18:59:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200323142558.15473-2-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0032.eurprd07.prod.outlook.com
 (2603:10a6:205:1::45) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.41) by
 AM4PR07CA0032.eurprd07.prod.outlook.com (2603:10a6:205:1::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.12 via Frontend Transport; Mon, 23 Mar 2020 15:59:21 +0000
X-Tagtoolbar-Keys: D20200323185919275
X-Originating-IP: [185.215.60.41]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4f123bc-6dd5-43be-138a-08d7cf4326dd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB535008D2E7315F6502313F12C1F00@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(39850400004)(346002)(366004)(136003)(199004)(36756003)(52116002)(16526019)(4326008)(26005)(31696002)(16576012)(86362001)(6486002)(956004)(19627235002)(66476007)(66556008)(316002)(186003)(31686004)(2616005)(478600001)(8936002)(81166006)(5660300002)(66946007)(81156014)(2906002)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5350;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOV0bz7qAre/O5Oi55jz/WYlCiNVNTqV1Fi6g4PhDGXd4d05ntKBSnj70bOeP7sWB+N40nw+dC0YD69mTNdvS5o3Tr8BvqUFOqHXSBmmcgf4FJ+KbnV8asXYYVTfk1d3vYUTC1Rp63F/H5vH1jAGEJ2v3LqHxprmM6NW75rDZ+CLmZWw6imiizN8dABJfqz/vMAE4pVD0p6wSoVUqZM5jRRkIkwB+EUnaaneCO0XaUE6hX8eIGdkd2mhM83XhD2XfPOofPDxA9NGC7SUfEse11I2V1ohmYKbGCjQtg1qhp2wmLwaLUYLM2hUAf6zEfrLoVackKXCTZ0eW9ZYICqhD+ByrQWYaVn4kHSMR+xoNCxIsHS6cw4vp5PCKCBwe6dd2GF6Ek52lPrWJQhLpk4mrfAc2H/+43m5qGcJlkbcTeqwZit5CuyvK0uZX4RBw1Vh
X-MS-Exchange-AntiSpam-MessageData: ltFm4MehE/XBO0a4I+Tj0q3rQoVTDrY4fXaUS1EIDW3xxUHoPHFTU/QD4fi5/ZQ4PZuSXqgVVZ8W1yjCjVQYdp8+UeS9xLF69Oa0TbUFZY3fi3mtlXo3mKNWENlJXwBDz5X8KGgqTErpXuqSWbELxw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f123bc-6dd5-43be-138a-08d7cf4326dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 15:59:21.9349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUFGsslnyLyYTcOWVka/TwMLcW+2IEKFTqsHeZPjoaWGh01Yz3XokZxzpOjML6b0MbSDR10VMYtyU8375PckDbXhxo/wCVo8icDXXkLL4d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.94
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

23.03.2020 17:25, Denis Plotnikov wrote:
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
>      * filter out compression_type for many tests
>      * fix header size, feature table size and backing file offset
>        affected tests: 031, 036, 061, 080
>        header_size +=8: 1 byte compression type
>                         7 bytes padding
>        feature_table += 48: incompatible feature compression type
>        backing_file_offset += 56 (8 + 48 -> header_change + feature_table_change)
>      * add "compression type" for test output matching when it isn't filtered
>        affected tests: 049, 060, 061, 065, 144, 182, 242, 255
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   qapi/block-core.json             |  22 +++++-
>   block/qcow2.h                    |  20 +++++-
>   include/block/block_int.h        |   1 +
>   block/qcow2.c                    | 113 +++++++++++++++++++++++++++++++
>   tests/qemu-iotests/031.out       |  14 ++--
>   tests/qemu-iotests/036.out       |   4 +-
>   tests/qemu-iotests/049.out       | 102 ++++++++++++++--------------
>   tests/qemu-iotests/060.out       |   1 +
>   tests/qemu-iotests/061.out       |  34 ++++++----
>   tests/qemu-iotests/065           |  28 +++++---
>   tests/qemu-iotests/080           |   2 +-
>   tests/qemu-iotests/144.out       |   4 +-
>   tests/qemu-iotests/182.out       |   2 +-
>   tests/qemu-iotests/242.out       |   5 ++
>   tests/qemu-iotests/255.out       |   8 +--
>   tests/qemu-iotests/common.filter |   3 +-
>   16 files changed, 267 insertions(+), 96 deletions(-)
> 


[..]

> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -146,8 +146,16 @@ typedef struct QCowHeader {
>   
>       uint32_t refcount_order;
>       uint32_t header_length;
> +
> +    /* Additional fields */
> +    uint8_t compression_type;
> +
> +    /* header must be a multiple of 8 */
> +    uint8_t padding[7];
>   } QEMU_PACKED QCowHeader;
>   
> +QEMU_BUILD_BUG_ON(sizeof(QCowHeader) % 8 != 0);

Better write

QEMU_BUILD_BUG_ON(QEMU_IS_ALIGNED(sizeof(QCowHeader), 8);

with or without this:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +
>   typedef struct QEMU_PACKED QCowSnapshotHeader {
>       /* header is 8 byte aligned */
>       uint64_t l1_table_offset;
> @@ -216,13 +224,16 @@ enum {
>       QCOW2_INCOMPAT_DIRTY_BITNR      = 0,
>       QCOW2_INCOMPAT_CORRUPT_BITNR    = 1,
>       QCOW2_INCOMPAT_DATA_FILE_BITNR  = 2,
> +    QCOW2_INCOMPAT_COMPRESSION_BITNR = 3,
>       QCOW2_INCOMPAT_DIRTY            = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
>       QCOW2_INCOMPAT_CORRUPT          = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
>       QCOW2_INCOMPAT_DATA_FILE        = 1 << QCOW2_INCOMPAT_DATA_FILE_BITNR,
> +    QCOW2_INCOMPAT_COMPRESSION      = 1 << QCOW2_INCOMPAT_COMPRESSION_BITNR,
>   
>       QCOW2_INCOMPAT_MASK             = QCOW2_INCOMPAT_DIRTY
>                                       | QCOW2_INCOMPAT_CORRUPT
> -                                    | QCOW2_INCOMPAT_DATA_FILE,
> +                                    | QCOW2_INCOMPAT_DATA_FILE
> +                                    | QCOW2_INCOMPAT_COMPRESSION,
>   };
>   
>   /* Compatible feature bits */
> @@ -369,6 +380,13 @@ typedef struct BDRVQcow2State {
>   
>       bool metadata_preallocation_checked;
>       bool metadata_preallocation;
> +    /*
> +     * Compression type used for the image. Default: 0 - ZLIB
> +     * The image compression type is set on image creation.
> +     * For now, the only way to change the compression type
> +     * is to convert the image with the desired compression type set.
> +     */
> +    Qcow2CompressionType compression_type;
>   } BDRVQcow2State;
>   
>   typedef struct Qcow2COWRegion {


[..]


-- 
Best regards,
Vladimir

