Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0458C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70673207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PpL3i7q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70673207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdv7l-0007NW-L1
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdv6h-0006W4-GS; Wed, 27 May 2020 08:24:27 -0400
Received: from mail-eopbgr40114.outbound.protection.outlook.com
 ([40.107.4.114]:33029 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdv6e-0002r0-0c; Wed, 27 May 2020 08:24:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZctSpPlCT4Jh3wDw87PFeF/W8sRXWiG5ZYzdyk2+/sLZwwfeYuCWPv/UOf2GqLJS2gUq+W7Kvn+rESc97HPtrVKOP88GTTSq2fISXa38os0AO4eyGCDTNP0XWR6/zhSz1DWx3of1J9b5d/FBlVfBajFSgHg2voGoMweQq6n+hZFtcR8pOWfpGpsLqzozZhpK6ypJfqA7Jz6QUC74OYvCz+0MQrfj7j1ZyJWcGj/dVBtVwJZOH3sIRjWJ7IX+z4SIcPhJGkRE4qmvY4QmCsI/4TVP4C6BTR9vn8ef6aRjykBTwxgJ5xFIAICN8nrC8Q9mw3jxjouaoKaLKDMKdEJyKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aNJZEYQNIbq60xv43OLLR+UqbYzMWz0F8vz+w3seAU=;
 b=IwWei9kQDUkAV4yRBfWA1IO97zxxwtFp5ly34Z63Dc3VMKvV8S7FFYfxWWrNNhFpeqAv7xvki2Um0mttJmfPtzCyYl53rJks4XYxnqZV/qB77VMNQWJwZGlTn7vndBXv0znQtU4Jpp4m+b9dCamX9Ye+seKjgL3gnhCnIg78rYAAFQEndR8nIhwI/3F22kr1AEmYU6RQypk0xQjoCMoz/KqOppb8Nya8ZZ2fNqa2xQ+HfMIByNjzP5g/N8dG2NgzI8+HQuy5jR+PQ0733lMFgcUvSHxNpvnhuqq0dXx0BKEQ1dmnYM4ty6t4YP+lOA86I5pWUoi8pRjGFWHeNAkXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aNJZEYQNIbq60xv43OLLR+UqbYzMWz0F8vz+w3seAU=;
 b=PpL3i7q8lL89EeGueS5b7VYmDbZrMWsWHOwPRBhCxoll0Jhjx+w0oOh+H7M6yLWGqN2MQ6c62rqNcAB4IDjToF4deAiYEsaQY1Z4d/vTKkF38JC7Frt5WT68ev4tw8l0wvmjDfIYMs/E8qyN74fPkpuK02G5UmpvGNghGXLe9BA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5304.eurprd08.prod.outlook.com (2603:10a6:20b:10e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 27 May
 2020 12:24:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 12:24:19 +0000
Subject: Re: [PATCH v2] iotests: Dump QCOW2 dirty bitmaps metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1590524807-821646-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <59240395-f45d-435a-a534-a6e6e9bd109a@virtuozzo.com>
Date: Wed, 27 May 2020 15:24:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1590524807-821646-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:207:5::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.148) by
 AM3PR03CA0066.eurprd03.prod.outlook.com (2603:10a6:207:5::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 12:24:18 +0000
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acb86b87-9ea3-4055-d790-08d80238e148
X-MS-TrafficTypeDiagnostic: AM7PR08MB5304:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53044E8F1DB183D082324FA8C1B10@AM7PR08MB5304.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T8knMrNbHBLqv/dYa4OX2TA0frV/sdQq4iRbPWeGXrt2yns0TqLdxsfux/s+Igq0E3SVCUd9mGxzI4jRNcsF8TSquwQ3kWIW+yTM6hq/ghGKsqiR1392OH/Lxrz/rlwJeBoRy3F9qXpeAbtuD+N5OrK6aEh6Khu4mteCB5s9FTYj+Fl+uD5DijjK8R6Hn+iZCpQ2Sv1OpQ0cllQrhJc7f2KwatynyPWQw5MrOWI6hgt0OVTAJFAyKJc/2geHy1vk//G3Sgvfv7Dz0X4YBu5RzkSDPbKilk4xhYXitgWHrbBsDnTdN/xDiovUWQrFmHj9Y7EuEjH2au4Z2t+smLvekrKVPb/ytkxM9MPNFlcHm6RTetz6wVA+RMkdjpaOPt27cXzW7w/T90qnCJzhUmb+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39840400004)(366004)(136003)(5660300002)(36756003)(2616005)(30864003)(478600001)(31686004)(2906002)(316002)(16576012)(16526019)(52116002)(107886003)(186003)(4326008)(26005)(6486002)(956004)(83380400001)(8936002)(8676002)(66556008)(66476007)(66946007)(31696002)(86362001)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vQa2EHTsiC/YJuto+Hjirw3BYdBivebbFtuFroZ6M057ovnlHdQMLSKjcplRONMGkAInTcTaUWOeVGD+nl6vmIhSZXbZxZW0TOOGJi4Mz1M6RJG1hgL+YDXXyoWXWnoGgamVD9gN3iDZ1cOHdvjZ7i8xeRThXgTesXLhOWXs4SQPK/gIAIk88Gy+/QvwGv6MM5KUf6JVtpXSdgh007mVg3LfnMRCZG5tyDW9DHsWuS+ZDuqrc4IbZ4DtwBLQLx4BD7Y3wQ2f9KUUTl3hjH3ZET5sFSl8JqKNibKx/mhD6Q5cOQZqrKniBrjhD6D4Py5kWe9+wkXqrwi1Fxmrmf1csODNPqYDG0Gcq27WXIZQv/2G3sh6BeYEA0vcuhyfDw/lwCmSVG8s+VZzZoRN8iYA6tjYBQe6OTeZmBF84JKcgp8Pk6JN3g8looryIWqDL3rr0mKfonrMBi4BjEig4/2uWAK+r0Nfd8a9gMarlFGtKsLj2mZLlEKlwTTEicBqopO1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb86b87-9ea3-4055-d790-08d80238e148
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 12:24:19.5669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T70RRyH6M3qE8nFhDXB60szV86lz/5vsc9GHe7pFzynzpE8Mu/0l6mU43BxvCUhbmXwLua9/7gas+cDR1qXnMY/QxxiM9cIEdMGSIYlBIE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5304
Received-SPF: pass client-ip=40.107.4.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 08:24:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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

26.05.2020 23:26, Andrey Shinkevich wrote:
> Add dirty bitmap information to QCOW2 metadata dump in qcow2.py script.
> The sample output:
> 
> Header extension:         Bitmaps
> magic                     0x23852875
> length                    24
> nb_bitmaps                2
> reserved32                0
> bitmap_directory_size     0x40
> bitmap_directory_offset   0x100000
> 
> Bitmap name               bitmap-1
> flag                      "auto"
> bitmap_table_offset       0x90000
> bitmap_table_size         8
> flags                     2
> type                      1
> granularity_bits          15
> name_size                 8
> extra_data_size           0
> 
> Bitmap table
>     0     serialized, offset 0xa0000
>     1     all-zeroes, offset 0x0
>     2     all-zeroes, offset 0x0
>     3     all-zeroes, offset 0x0
>     4     all-zeroes, offset 0x0
>     5     all-zeroes, offset 0x0
>     6     all-zeroes, offset 0x0
>     7     all-zeroes, offset 0x0
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
> v2:
>    01: Refactoring of the Python code in the script qcow2.py.
>        New methods were added. The bitmap dictionary was instantiated.
>        The all of bitmaps information is read completely before
>        printing the dictionary.
>    02: The outputs of the tests 031, 036 and 061 were modified.
> 
>   tests/qemu-iotests/031.out  |  22 +++---
>   tests/qemu-iotests/036.out  |   4 +-
>   tests/qemu-iotests/061.out  |  14 ++--
>   tests/qemu-iotests/qcow2.py | 167 +++++++++++++++++++++++++++++++++++++++++---
>   4 files changed, 179 insertions(+), 28 deletions(-)
> 
> diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
> index 46f97c5..0383ebb 100644
> --- a/tests/qemu-iotests/031.out
> +++ b/tests/qemu-iotests/031.out
> @@ -24,7 +24,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             72
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -52,7 +52,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             72
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -80,12 +80,12 @@ autoclear_features        []
>   refcount_order            4
>   header_length             72
>   
> -Header extension:
> +Header extension:         Backing format
>   magic                     0xe2792aca
>   length                    11
>   data                      'host_device'
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -115,12 +115,12 @@ autoclear_features        []
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -148,12 +148,12 @@ autoclear_features        []
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> @@ -181,17 +181,17 @@ autoclear_features        []
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Backing format
>   magic                     0xe2792aca
>   length                    11
>   data                      'host_device'
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
>   
> -Header extension:
> +Header extension:         Unknown
>   magic                     0x12345678
>   length                    31
>   data                      'This is a test header extension'
> diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
> index 23b699c..d305f1a 100644
> --- a/tests/qemu-iotests/036.out
> +++ b/tests/qemu-iotests/036.out
> @@ -24,7 +24,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>   incompatible_features     []
>   compatible_features       []
>   autoclear_features        [63]
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
> @@ -36,7 +36,7 @@ No errors were found on the image.
>   incompatible_features     []
>   compatible_features       []
>   autoclear_features        []
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index 5a8d36d..bb4b236 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -24,7 +24,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
> @@ -82,7 +82,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
> @@ -138,7 +138,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
> @@ -193,7 +193,7 @@ autoclear_features        [42]
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
> @@ -262,7 +262,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
> @@ -324,7 +324,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
> @@ -353,7 +353,7 @@ autoclear_features        []
>   refcount_order            4
>   header_length             104
>   
> -Header extension:
> +Header extension:         Feature table
>   magic                     0x6803f857
>   length                    288
>   data                      <binary>
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index 94a07b2..483decb 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -4,6 +4,132 @@ import sys
>   import struct
>   import string
>   
> +
> +class Qcow2BitmapDirEntry:
> +
> +    name = ''
> +    BME_FLAG_IN_USE = 1
> +    BME_FLAG_AUTO = 1 << 1
> +
> +    uint8_t = 'B'
> +    uint16_t = 'H'
> +    uint32_t = 'I'
> +    uint64_t = 'Q'
> +
> +    fields = [
> +        [uint64_t, '%#x', 'bitmap_table_offset'],
> +        [uint32_t, '%d',  'bitmap_table_size'],
> +        [uint32_t, '%d',  'flags'],
> +        [uint8_t,  '%d',  'type'],
> +        [uint8_t,  '%d',  'granularity_bits'],
> +        [uint16_t, '%d',  'name_size'],
> +        [uint32_t, '%d',  'extra_data_size']
> +    ]
> +
> +    fmt = '>' + ''.join(field[0] for field in fields)
> +
> +    def __init__(self, data):
> +

extra empty line

> +        entry = struct.unpack(Qcow2BitmapDirEntry.fmt, data)
> +        self.__dict__ = dict((field[2], entry[i])
> +                             for i, field in enumerate(
> +                                 Qcow2BitmapDirEntry.fields))
> +
> +        self.bitmap_table_size = self.bitmap_table_size \
> +            * struct.calcsize(self.uint64_t)

hmm, you multiply it here [...]

> +
> +    def bitmap_dir_entry_raw_size(self):
> +        return struct.calcsize(self.fmt) + self.name_size + \
> +            self.extra_data_size
> +
> +    def dump_bitmap_dir_entry(self):
> +        print("%-25s" % 'Bitmap name', self.name)

I recommend to use .format() or f-strings instead of old % notation.

> +        if (self.flags & self.BME_FLAG_IN_USE) != 0:
> +            print("%-25s" % 'flag', '"in-use"')
> +        if (self.flags & self.BME_FLAG_AUTO) != 0:
> +            print("%-25s" % 'flag', '"auto"')

Some empty lines around if and for blocks will be nice, IMHO.

> +        for f in Qcow2BitmapDirEntry.fields:
> +            value = self.__dict__[f[2]]
> +            value_str = f[1] % value
> +
> +            print("%-25s" % f[2], value_str)
> +        print("")
> +
> +    def read_bitmap_table(self, fd):
> +        fd.seek(self.bitmap_table_offset)
> +        table_size = self.bitmap_table_size * struct.calcsize(self.uint64_t)

[...] and here. this seems wrong. I'd keep multiplication only here.

> +        table = [e[0] for e in struct.iter_unpack('>Q', fd.read(table_size))]
> +        self.bitmap_table = enumerate(table)

enumerate returns an iterator, I think you need list(enumerate(table))

> +
> +    def print_bitmap_table(self):
> +        BME_TABLE_ENTRY_OFFSET_MASK = 0x00fffffffffffe00
> +        BME_TABLE_ENTRY_FLAG_ALL_ONES = 1
> +        bmt_type = ['all-zeroes', 'all-ones', 'serialized']
> +
> +        print("Bitmap table")
> +        for i, entry in self.bitmap_table:
> +            offset = entry & BME_TABLE_ENTRY_OFFSET_MASK
> +            if offset != 0:
> +                index = 2
> +            else:
> +                index = entry & BME_TABLE_ENTRY_FLAG_ALL_ONES
> +            print("   %-4d  %s, offset %#x" % (i, bmt_type[index], offset))
> +        print("")
> +
> +
> +class Qcow2BitmapExt:
> +
> +    uint32_t = 'I'
> +    uint64_t = 'Q'
> +
> +    fields = [
> +        [uint32_t, '%d',  'nb_bitmaps'],
> +        [uint32_t, '%d',  'reserved32'],
> +        [uint64_t, '%#x', 'bitmap_directory_size'],
> +        [uint64_t, '%#x', 'bitmap_directory_offset']
> +    ]
> +
> +    fmt = '>' + ''.join(field[0] for field in fields)

Would be good to keep common functionality in a parent class somehow.

> +
> +    def __init__(self, data):
> +
> +        extension = struct.unpack(Qcow2BitmapExt.fmt, data)
> +        self.__dict__ = dict((field[2], extension[i])
> +                             for i, field in enumerate(Qcow2BitmapExt.fields))
> +
> +    def dump_bitmap_ext(self):
> +        for f in Qcow2BitmapExt.fields:
> +            value = self.__dict__[f[2]]
> +            value_str = f[1] % value
> +
> +            print("%-25s" % f[2], value_str)
> +        print("")
> +
> +    def read_bitmap_directory(self, fd):
> +        self.bitmaps = []
> +        fd.seek(self.bitmap_directory_offset)
> +        buf_size = struct.calcsize(Qcow2BitmapDirEntry.fmt)
> +
> +        for n in range(self.nb_bitmaps):
> +            buf = fd.read(buf_size)
> +            dir_entry = Qcow2BitmapDirEntry(buf)
> +            fd.seek(dir_entry.extra_data_size, 1)
> +            bitmap_name = fd.read(dir_entry.name_size)
> +            dir_entry.name = bitmap_name.decode('ascii')
> +            self.bitmaps.append(dir_entry)
> +            entry_raw_size = dir_entry.bitmap_dir_entry_raw_size()
> +            shift = ((entry_raw_size + 7) & ~7) - entry_raw_size
> +            fd.seek(shift, 1)
> +
> +        for bm in self.bitmaps:
> +            bm.read_bitmap_table(fd)
> +
> +    def print_bitmaps(self):
> +        for bm in self.bitmaps:
> +            bm.dump_bitmap_dir_entry()
> +            bm.print_bitmap_table()
> +
> +
>   class QcowHeaderExtension:
>   
>       def __init__(self, magic, length, data):
> @@ -21,6 +147,11 @@ class QcowHeaderExtension:
>   
>   class QcowHeader:
>   
> +    QCOW2_EXT_MAGIC_BACKING_FORMAT = 0xE2792ACA
> +    QCOW2_EXT_MAGIC_FEATURE_TABLE = 0x6803f857
> +    QCOW2_EXT_MAGIC_CRYPTO_HEADER = 0x0537be77
> +    QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
> +    QCOW2_EXT_MAGIC_DATA_FILE = 0x44415441
>       uint32_t = 'I'
>       uint64_t = 'Q'
>   
> @@ -127,6 +258,15 @@ class QcowHeader:
>           buf = buf[0:header_bytes-1]
>           fd.write(buf)
>   
> +    def extension_name(self, magic):
> +        return {
> +            self.QCOW2_EXT_MAGIC_BACKING_FORMAT: 'Backing format',
> +            self.QCOW2_EXT_MAGIC_FEATURE_TABLE: 'Feature table',
> +            self.QCOW2_EXT_MAGIC_CRYPTO_HEADER: 'Crypto header',
> +            self.QCOW2_EXT_MAGIC_BITMAPS: 'Bitmaps',
> +            self.QCOW2_EXT_MAGIC_DATA_FILE: 'Data file',
> +        }.get(magic, 'Unknown')
> +
>       def dump(self):
>           for f in QcowHeader.fields:
>               value = self.__dict__[f[2]]
> @@ -142,30 +282,41 @@ class QcowHeader:
>               print("%-25s" % f[2], value_str)
>           print("")
>   
> -    def dump_extensions(self):
> +    def dump_extensions(self, fd):
>           for ex in self.extensions:
>   
> +            print("%-25s %s" % ("Header extension:", self.extension_name(
> +                ex.magic)))

Could you do this improvement together with iotests change in a separate preparation patch?

> +            print("%-25s %#x" % ("magic", ex.magic))
> +            print("%-25s %d" % ("length", ex.length))
> +
>               data = ex.data[:ex.length]
>               if all(c in string.printable.encode('ascii') for c in data):
>                   data = "'%s'" % data.decode('ascii')
> +                print("%-25s %s" % ("data", data))
>               else:
> -                data = "<binary>"
> +                self.dump_extension_data(fd, ex)
>   
> -            print("Header extension:")
> -            print("%-25s %#x" % ("magic", ex.magic))
> -            print("%-25s %d" % ("length", ex.length))
> -            print("%-25s %s" % ("data", data))
>               print("")
>   
> +    def dump_extension_data(self, fd, ext):
> +        if ext.magic == self.QCOW2_EXT_MAGIC_BITMAPS:
> +            b_ext = Qcow2BitmapExt(ext.data)
> +            b_ext.dump_bitmap_ext()
> +            b_ext.read_bitmap_directory(fd)
> +            b_ext.print_bitmaps()
> +        else:
> +            print("%-25s %s" % ("data", "<binary>"))
> +
>   
>   def cmd_dump_header(fd):
>       h = QcowHeader(fd)
>       h.dump()
> -    h.dump_extensions()
> +    h.dump_extensions(fd)
>   
>   def cmd_dump_header_exts(fd):
>       h = QcowHeader(fd)
> -    h.dump_extensions()
> +    h.dump_extensions(fd)
>   
>   def cmd_set_header(fd, name, value):
>       try:
> 


-- 
Best regards,
Vladimir

