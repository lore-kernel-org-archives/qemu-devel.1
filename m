Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D4AC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FF62071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ltEWjMvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FF62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJfyj-0006FJ-1A
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJfxo-0005hU-Jx
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJfxn-0003Zg-6D
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:11:36 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com
 ([40.107.14.117]:12791 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJfxj-0003Ul-0S; Wed, 01 Apr 2020 12:11:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZxmX7UrDLs9uaj8e/e1vwQPo6ZLxtNBsGORqABoQH9WftlL16JrSCJwvd76n9gfFW0Ey/gu3L3Ds0IB74uo8KDGdI9BwzdLcYM7PN0BYzmgG/Mj9/6gDRIAWq3S834GhJfkyXPy/qLvPrZj6Bji6oU/E882v+xwge54XQdPGtXe8YCwe2sUySVO8c3Z9FIcdDd30pnheATf3jDAuyyY31yfPSv+cvBVFpWIN7n/CdoRQ6UoFs9McfvLbtwjsn54UGi0g3bJ1iVZQ7Q8NxqfT1KV5G1UYBg23sGbiAqKjngkWNe+iYy8E9EXcaNAGOuznXh9pZzLUVi2em4GXdn96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gP6+2SKdlv/LkzIlwD/fkkdmbT1EEIksqyYB84AMsg=;
 b=MZ6HN8Hvie0mGnS4GoZ10lw9JDC10wFUnAMpzUEnQxL3xHYB8ZJ8lmGuk5Ig0v4JxZB+Kz+MumFsZb3IgQ9IHPDFw0iMFyOaaIo1kKQ7RnLMEB5p2hkBWsmCG/C3BQLytiIKby8D7tBVX3G+gKMmLOvBDQIWQ9mB907KiqgXIgB0/0jZmpehll+78ZqQh4FX1YJrLhSFmou+DLQ9lHTZzA46jkTSdpz+Uact3LD1ENCyPH27cIn/WTUDfIXmmoOlSm0dOeH0CS48ozJbuj+6FtyApnJteMgszPpC2LK2FYRVIsHyrMWadHV6GVJkqjvwcsAuCNNl6IwC+YCZK8v0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gP6+2SKdlv/LkzIlwD/fkkdmbT1EEIksqyYB84AMsg=;
 b=ltEWjMvGe4QP6M6FcS4ux1aC8XoryBfWrdasWafIbk41IDBsW65RyKm07egu64qdiwbTB6papq4J7wno+ukFmkJoOQVFGY5ZNvXQlodzI3IFldIm8P32oDrPIQlJDPJw6oslOQENVXzsuu/sdOxIlDb3opK17tbcvsgKOCCWDKE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5413.eurprd08.prod.outlook.com (10.141.173.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Wed, 1 Apr 2020 16:11:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 16:11:27 +0000
Subject: Re: [PATCH v16 4/4] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200401143719.21639-1-dplotnikov@virtuozzo.com>
 <20200401143719.21639-5-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200401191118576
Message-ID: <85747d2b-f5c2-cb4c-1408-8df98b337c07@virtuozzo.com>
Date: Wed, 1 Apr 2020 19:11:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200401143719.21639-5-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.23) by
 FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 16:11:26 +0000
X-Tagtoolbar-Keys: D20200401191118576
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1742a9e1-cf2a-433a-b157-08d7d65754d4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5413F22D2BAEEDC7803450DBC1C90@AM7PR08MB5413.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(376002)(39850400004)(396003)(346002)(366004)(81156014)(8676002)(81166006)(186003)(16526019)(86362001)(66556008)(66476007)(66946007)(6486002)(31696002)(6666004)(478600001)(36756003)(5660300002)(316002)(16576012)(26005)(2906002)(8936002)(2616005)(52116002)(956004)(4326008)(31686004)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICN/kDuGA0/RoU34KcvsQQWo03ofN2uY9h4/VAyqwzuuv9vH8mGjODYg5IKRQQoyKEGeSX4A/c/D63jNc351lT69R4vTICBzQnQ5uaNB06ynq6Ct3r6m+pBf67QfIPRRQp7TsEE+9PQPkPfPef+Iji9MJdEAkKbfSHqdIqyPf9r/MAbhgskE7AqMuXTZrJ7vXHvankLH/hPUZFTZ5yV1yQYsMvtSUxonm+V0Dhigiy0ztY/BaJv63nQBHZc8/etJvp03orxkGQvpjjag9w3Y4PlSL7sAOGkN9259b1ohDr2jklbRJ57mHLlRe3k7MUEqFZ9OBYrsVFyh4y8uhL4F2J3j1qBwbcNFzirUidS0MpahbSS3cvccDHv0PxZ5+QPgALg+g8cZkDZSDxt3nHnHEKG4af7olF6atz1DiWIdRnAp5rs5Ze4mty+82/jfP0mG2q25mNncU6s8hmj01WcMucCORpzNm0GlvovG6iL15D2Ov8pFMsqLiLParKi+XWU9/N+CALaOviTUnBDDgIpeCW4czXsMA8aqNJrW+MjWbyq4XbfrKxieA+xj7hjrhQAS
X-MS-Exchange-AntiSpam-MessageData: gfGYtXGp9MRxwyzl92G95AWeDTtaisdnytzulBskwiqcfkga/osQd+BOngX3ufO0HS4QC31OovfpqvFEN4QbrYgiXkMtPxahp3Yf73ABwTIfDUadcVh2s8WfBLdx8qG03DyXwsuQYCrQFh9gmwzdQg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1742a9e1-cf2a-433a-b157-08d7d65754d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 16:11:27.1212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpUaYlO3StuJRmhdCX6Ic/9sejNNb+312ZHZYqYMewXI+XWFqdHErZY65mqLuQV1n3tKtanRZ0ct83N8DEidNLxpSYXPK0frZR7BeSU5foM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5413
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.117
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

01.04.2020 17:37, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requiriements for the compression
> type feature and zstd compression type operability.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/qemu-iotests/287     | 162 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/287.out |  70 ++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 233 insertions(+)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
> 
> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
> new file mode 100755
> index 0000000000..699dccd72c
> --- /dev/null
> +++ b/tests/qemu-iotests/287
> @@ -0,0 +1,162 @@
> +#!/usr/bin/env bash
> +#
> +# Test case for an image using zstd compression
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +# creator
> +owner=dplotnikov@virtuozzo.com
> +
> +seq="$(basename $0)"
> +echo "QA output created by $seq"
> +
> +status=1	# failure is the default!
> +
> +# standard environment
> +. ./common.rc
> +. ./common.filter
> +
> +# This tests qocw2-specific low-level functionality
> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux
> +
> +COMPR_IMG=$TEST_IMG.compressed
> +RAND_FILE=$TEST_DIR/rand_data

Always quote file paths, to don't worry about whitespaces.

> +
> +_cleanup()
> +{
> +	_cleanup_test_img
> +	rm -f $COMPR_IMG
> +	rm -f $RAND_FILE
> +}

[..]

  data should be identical
> +echo
> +echo "=== Testing incompressible cluster processing with zstd ==="
> +echo
> +
> +dd if=/dev/urandom of=$RAND_FILE bs=1M count=1
> +
> +_make_test_img 64M
> +# fill the image with likely incompressible and compressible clusters
> +$QEMU_IO -c "write -c -s "$RAND_FILE" 0 1M " "$TEST_IMG" | _filter_qemu_io

hmm quotes around RAND_FILE here doesn't make things better: if RAND_FILE variable has
whitespace inside, the argemunt after -c will be split into two arguments.

What we need here is to support quotes inside the string argument for qemu-io. It's a
separate thing to do. Let's just don't worry about whitespaces here now.


With the following squashed in:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--- a/tests/qemu-iotests/287
+++ b/tests/qemu-iotests/287
@@ -35,14 +35,14 @@ _supported_fmt qcow2
  _supported_proto file
  _supported_os Linux

-COMPR_IMG=$TEST_IMG.compressed
-RAND_FILE=$TEST_DIR/rand_data
+COMPR_IMG="$TEST_IMG.compressed"
+RAND_FILE="$TEST_DIR/rand_data"

  _cleanup()
  {
      _cleanup_test_img
-    rm -f $COMPR_IMG
-    rm -f $RAND_FILE
+    rm -f "$COMPR_IMG"
+    rm -f "$RAND_FILE"
  }
  trap "_cleanup; exit \$status" 0 1 2 3 15

@@ -146,11 +146,14 @@ echo
  echo "=== Testing incompressible cluster processing with zstd ==="
  echo

-dd if=/dev/urandom of=$RAND_FILE bs=1M count=1
+dd if=/dev/urandom of="$RAND_FILE" bs=1M count=1

  _make_test_img 64M
  # fill the image with likely incompressible and compressible clusters
-$QEMU_IO -c "write -c -s "$RAND_FILE" 0 1M " "$TEST_IMG" | _filter_qemu_io
+# TODO: if RAND_FILE variable contain a whitespace, the following will fail.
+# We need to support some kind of quotes to make possible file paths with
+# white spaces for -s option
+$QEMU_IO -c "write -c -s $RAND_FILE 0 1M " "$TEST_IMG" | _filter_qemu_io
  $QEMU_IO -c "write -c -P 0xFA 1M 1M " "$TEST_IMG" | _filter_qemu_io
  $QEMU_IMG convert -O $IMGFMT -c -o compression_type=zstd \
                    "$TEST_IMG" "$COMPR_IMG"


-- 
Best regards,
Vladimir

