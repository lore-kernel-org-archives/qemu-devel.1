Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B628C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F4C24691
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 10:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g6UFaL+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F4C24691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7GRs-00052m-5R
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 05:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7GQE-0003Vr-4H
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7GQC-0001L7-87
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 05:29:38 -0500
Received: from mail-eopbgr50136.outbound.protection.outlook.com
 ([40.107.5.136]:58993 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7GQ5-0000zl-Bz; Thu, 27 Feb 2020 05:29:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y57EwZt1tCMYxBIQNhgWxy4Jthxrc6L7BCBgCBEvq2Hmp9U999Reo8p/Sj0M2sgjt9vJ5+5QfsKCq9wJkt0iuR03DMcq2wh1au/myFFIOqLG2UjT1FWdrD2MZTyAXFTb/gGbDac0eBLsfFyhsvJFgHFNwHqhKwwBrLBTu/XouKwS9iotBE2UMl/TJV2GM8JS53drTjWBM4mY3ZXVZUuk12Ij4aK6PTSuSzWhwaox0JN3Y3+qeBtNL2HqTqqaC3QOcpUBRzUUuitvdhSKTImMUVbBtqOzuPg7tRhcgmOfLIi4ntt8mRsX90MyOi14Wt+vHuAq7nxKLh/CCOjQdoZ1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3touxxZOTKVtNBdd7gMM8u56BDHUlM4q54XZ0ZvUzY=;
 b=ddacvW45BYdoF3nbTZpARF/d8kbeE0WVcjue35xyQncyfRWOrJ367vMWKtzA5PrMUDzy7e2gFXNXlmZ4uM2WBs0vT4QhMvMoHLy0/dr5wYG3sOU6yv4hTFgceCnT9flzDwG9d0aIL3/BouyyGJm8Mz9+tJEfrMdu9oqoxBRcmikwfPr6kNzGiNI4I21ljM6dIo/nCzIoDzNrUWjh3rwSqu4rPRbfAF1H1s2ws3sUx+O/iftUglNV9KEO4NC5Gx6ujo42KmtRrawuh2c+x3sZSmyAhnVlwZ2FO9zw8zvdBDkYAL7MnS0jOdCx7tYkI+UC4tzw61dBRISeKTF6TpfQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3touxxZOTKVtNBdd7gMM8u56BDHUlM4q54XZ0ZvUzY=;
 b=g6UFaL+aMaGHWOAKR4RYSqASCmRtHIjkLZtu/MsPf/+PViRPuEqnt3FTvYSKgL4vfHIW1Vs7CYEU+8fC9gQgNm6Lhln7mS/rbYRwL8ZEn70Xx6ZnsuEHGnY3dgEJQ724CHzQdE1PwlvYT7gejGJgvAKpYwMjcK0ByHhtFab4mRc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB3296.eurprd08.prod.outlook.com (52.134.31.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:29:26 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::91aa:2540:62c:aeda%5]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 10:29:26 +0000
Subject: Re: [PATCH v1 8/8] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-9-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200227132922816
Message-ID: <416ce145-9163-5397-356d-87401e346e77@virtuozzo.com>
Date: Thu, 27 Feb 2020 13:29:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200227072953.25445-9-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0102CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::37) To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0102CA0060.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Thu, 27 Feb 2020 10:29:25 +0000
X-Tagtoolbar-Keys: D20200227132922816
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c5fd464-19e7-4fcc-30a9-08d7bb6feb59
X-MS-TrafficTypeDiagnostic: VI1PR08MB3296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3296CE8DA183FDFBCE518C7FC1EB0@VI1PR08MB3296.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39840400004)(366004)(136003)(376002)(199004)(189003)(31696002)(86362001)(31686004)(2906002)(52116002)(66476007)(26005)(6486002)(66946007)(186003)(16526019)(81166006)(316002)(66556008)(81156014)(16576012)(8676002)(8936002)(6666004)(478600001)(5660300002)(4326008)(956004)(36756003)(2616005)(21314003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3296;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVjtHqvtRY+O3tjDxMXB4z3jL1IL0YTzcRkboCGG//Sy67mmCWAnN/MOjnyu3ik4OvP5IlMCigg0CnAKY9dqUsqUnlJmGd6MlVKHQIUWS02oG8jjU6y3JPRTIa+1HozbmlsYgQlww7gYGMlaVLnG2Z8yPrYyyKlI/4VQQ7woMf36ezrfYENmBq4iMDGonf2VCQfnqyE0ntpUi2PmopY8Y1ealHWuiqYpzRWtFeASZxxrZArOHlCB59Pm8EXFT+dJXgFHCc0+gfMsNv82ucRxp05SG1JCq2ryD5UI2S/MoYRij6nEAxAXuFTZ3y0LdbcSdA3qXlAzqK2UuneupWtzpYSlygq1b65WNxBpkZAMT8M4712gjWScLL79RhKIKaBTdcO8gA1yFza/a36CVlX8YJrbfPrikeTLXpdGcW4DDE8i2P5sue4E8UZhEtTffPQE5dp2n4jXXVcJAxrBS/0Vreg3QaIZmO4KNCpQUBuE7D44M8siXIFZaa3BFizlqKe2bYB4m+Nx4I3fwR3SbuaTOpegeSrrDrgEw+gDkyzG4gRoQbGyAHnR669n2cXCI5patmo5vFdcTv3ihtN5UoMVBw==
X-MS-Exchange-AntiSpam-MessageData: zCZLsppuwM5+6vWDSwuGjuLbNPmVirzXalOTLR85InXRR6vF3/mRL3zwq1HMmyjcbuQFqu1CyyNddQC4CNSyQQoK5jAaKM+YiAsj7WibjJ5fkMN9kgU2x9MRgcDG5ae8imfetOo/rF1e9QBYsU7sdQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5fd464-19e7-4fcc-30a9-08d7bb6feb59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:29:26.2718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3tl/56jBrBvxv1ST5+gLMETrpvIAxmcnDAdNekYSc5+eeubvBYmkzkYURdfDg2hZOoJTfyE0cQk08vYtmcFwW2HRc9uOmHhRM8oSNWQq8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3296
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.136
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, den@vrtuozzo.com,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.02.2020 10:29, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requiriements for the compression
> type feature and zstd compression type operability.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/qemu-iotests/287     | 123 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/287.out |  41 +++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 165 insertions(+)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
> 
> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
> new file mode 100755
> index 0000000000..41b916f690
> --- /dev/null
> +++ b/tests/qemu-iotests/287
> @@ -0,0 +1,123 @@
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
> +_cleanup()
> +{
> +	_cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
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
> +P=`echo "$QEMU_PROG" | sed "s/qemu-system-x86_64//"`
> +
> +grep "CONFIG_ZSTD=y" "$P"../config-host.mak >/dev/null
> +RES=$?

Hmm. This will not work for other architectures and for
out of tree builds. Also, it checks config but not current
binary (they may be out of sync, or even unrelated).

Probably better try to create image with zstd compression type
and handle expected error.


> +if (($RES)); then
> +    _notrun "ZSTD is disabled in the current configuration"
> +fi
> +
> +# Test: when compression is zlib the incompatible is unset
> +echo
> +echo "=== Testing compression type incompatible bit setting for zlib ==="
> +echo
> +
> +_make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +# Test: when compression differs from zlib the incompatible bit is set
> +echo
> +echo "=== Testing compression type incompatible bit setting for zstd ==="
> +echo
> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +# Test: an image can't be openned if compression type is zlib and

opened

> +#       incompatible feature compression type is set
> +echo
> +echo "=== Testing zlib with incompatible bit set  ==="
> +echo
> +
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
> +# to make sure the bit was actually set
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
> +if (($?==0)); then
> +    echo "Error: The image openned successfully. The image must not be openned"
> +fi

may be better to instead keep error output and just check it..

> +
> +# Test: an image can't be openned if compression type is NOT zlib and
> +#       incompatible feature compression type is UNSET
> +echo
> +echo "=== Testing zstd with incompatible bit unset  ==="
> +echo
> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
> +# to make sure the bit was actually unset
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
> +if (($?==0)); then
> +    echo "Error: The image openned successfully. The image must not be openned"
> +fi
> +# Test: check compression type values
> +echo
> +echo "=== Testing compression type values  ==="
> +echo
> +# zlib=0
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +od -j104 -N1 -An -vtu1 "$TEST_IMG"
> +
> +# zstd=1
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +od -j104 -N1 -An -vtu1 "$TEST_IMG"
> +
> +# Test: using zstd compression, write to and read from an image
> +echo
> +echo "=== Testing reading and writing with zstd ==="
> +echo
> +
> +CLUSTER_SIZE=65536
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$QEMU_IO -c "write -c 0 64k " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -v 0 10 " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -v 65530 8" "$TEST_IMG" | _filter_qemu_io

Hmm output depends on default pattern. Better use "write -c -P 0x11 0 64k"
  (or any pattern you want), to make it explicit.

> +
> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=0
> diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
> new file mode 100644
> index 0000000000..4218254ce0
> --- /dev/null
> +++ b/tests/qemu-iotests/287.out
> @@ -0,0 +1,41 @@
> +QA output created by 287
> +
> +=== Testing compression type incompatible bit setting for zlib ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +incompatible_features     []
> +
> +=== Testing compression type incompatible bit setting for zstd ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 compression_type=zstd
> +incompatible_features     [3]
> +
> +=== Testing zlib with incompatible bit set  ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +incompatible_features     [3]
> +
> +=== Testing zstd with incompatible bit unset  ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 compression_type=zstd
> +incompatible_features     []
> +
> +=== Testing compression type values  ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
> +   0
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 compression_type=zstd
> +   1
> +
> +=== Testing reading and writing with zstd ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 compression_type=zstd
> +wrote 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +00000000:  cd cd cd cd cd cd cd cd cd cd  ..........
> +read 10/10 bytes at offset 0
> +10 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +0000fffa:  cd cd cd cd cd cd 00 00  ........
> +read 8/8 bytes at offset 65530
> +8 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +*** done
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 0317667695..5edbadef40 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -293,3 +293,4 @@
>   283 auto quick
>   284 rw
>   286 rw quick
> +287 auto quick
> 


-- 
Best regards,
Vladimir

