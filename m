Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D147C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B593820735
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hR30ik99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B593820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXS9-0001jS-Si
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47424 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jQXRB-0000uz-9p
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:30:17 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jQXRA-0003h8-Ks
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:30:17 -0400
Received: from mail-eopbgr60137.outbound.protection.outlook.com
 ([40.107.6.137]:35903 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jQXR6-0003W8-JM; Mon, 20 Apr 2020 10:30:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfjTdNzP+tXBwscXWKqBIaCzUY7nZ2zScBbVeVOJDZrZxnb0Jip5M79cWLfQh5C1MWSUl0Xou5AHUYrUbiBUJHHhXPr7S+/Jr3FNSz5YNPT3Kjlbo+5fJg4RXWydrkUHxSdoHiSCfLc/paFTttI6URrJdhR8PRlHgiDRZ3oKz4VQPloPcnQnv5T001aW3aX7MVsoBpRTw5hbzWSXUWHqwJZjpne0suMdjCKZo5+sLCVaxqlrJPjEvfyh1jdswc32f6/YDjROIxnHbJRvQogBEjlbrGE/gw4Uj5WElTSkpvjHibThZeTlp8fIOx83KfRKdWz/TuTCfE06/crUydF9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOPWYU9ZHT2LxXxs/8x5ej2bZRmZHsAJgUvpydMZYuQ=;
 b=jLC6tf5lYcXkjBC0WYhlr/U3ViAmF+QUbQb7HZYM/0yQlul+fwxPnthqCeX4ms43CRfJSbNZsm8ss3z6/d6XYkt9YstMIz/Iru2ZIUn+W8h5CO/+5ydD2OKdndv4URdDju2YuqeMNSEERs90SjM7l7icd7Zc8SRhJr7M2MD7D0paUcWS6q30+jOttnjff+aUU0bWCXZwvPKgMgUGhJyMi4ik0wu7s8NSIDnxVuU7+Fx/ZXvFXNgR+FW5HHzOFRikrD02lh618JWxNmDi9c/xufd3dZf9xpcrETEHokB7dQ4oOTARLwO8y561Zf+Xn8XYoz1Nhl7BmOTErK1Hxp4vGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOPWYU9ZHT2LxXxs/8x5ej2bZRmZHsAJgUvpydMZYuQ=;
 b=hR30ik99PQ9P1NXVFHMqiBCz9q3dfiaIlzzz7d9yOHeNOV49P4qhGJZ0XjKLM1N5YlWvomsef1QQy6lKacohOFVAVbwOc3F48VmM0yHlgxhhycz0o0b4EOkYzTj2mEpe43n0xFZ6Mja928lGaS9f2yHOUE2wJHG14hnHF5wo9d4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4305.eurprd08.prod.outlook.com (2603:10a6:208:140::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 14:30:08 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 14:30:08 +0000
Subject: Re: [PATCH v19 4/4] iotests: 287: add qcow2 compression type test
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200420091757.14102-1-dplotnikov@virtuozzo.com>
 <20200420091757.14102-5-dplotnikov@virtuozzo.com>
 <f7eb0e48-4c0d-4ae7-893f-dbb2064836d3@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <b9100519-21e0-3b2b-1b16-5896be22ed49@virtuozzo.com>
Date: Mon, 20 Apr 2020 17:30:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <f7eb0e48-4c0d-4ae7-893f-dbb2064836d3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::35) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (5.138.121.5) by
 AM0PR06CA0094.eurprd06.prod.outlook.com (2603:10a6:208:fa::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Mon, 20 Apr 2020 14:30:07 +0000
X-Originating-IP: [5.138.121.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf7c5310-082d-421b-7ec0-08d7e537538a
X-MS-TrafficTypeDiagnostic: AM0PR08MB4305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB430515611C0D43FEBF144B24CFD40@AM0PR08MB4305.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(346002)(396003)(376002)(136003)(39840400004)(5660300002)(4326008)(31686004)(36756003)(16526019)(186003)(2616005)(31696002)(956004)(52116002)(26005)(2906002)(6666004)(16576012)(53546011)(81156014)(6486002)(316002)(66476007)(66556008)(66946007)(8676002)(86362001)(478600001)(8936002)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9v5XGiau24+waQUVaVy/t/yCTo23eNSC/u9/pfFUqaCQ3leqYMUiQHohBXmn8kTz/7ve19oqGxScjQDUJPlNk/vN8fZv1sXQ0krxQmST2RZMsbWZlC3EtqBU2veNJRUmtUWEcmUnSJ/MGimhepAThbtbSIctEsxVRqwT4jJLK8LDsD1389ZCNJozfvYrF7Gz0HPfYn8Q+tOGCoIXT36pdoTh2rmsLPfd707JiZ9RjtDi6uVbPKW9fE8NWhrMLun4ObNW1dlVC4DG6SbmnqC6yf9uUJSUJankHjOW7c5brw9rngVEfSt4SGin3WrLb98suqFkIYKuIF/VuxBqkVHSKEPtCiYO0xGKw/EBu3n5vQ3c7RpAoyEj1m9IRDEwI6VVUqnBteFXU704r+Sfr96zmRVbUtzka/JLwovKTfdS4GCpB226RxOa2Cq3M2Ud425sKqQFThPB52n6/TAZ0794iYrBnI6Bo6XLvS4pKneOYIPoOGpKwApGCED+0BNiPiahyqsaEBWKZ9wGfsgcXzh4bM1sgAT4kWKVCKvUKkXD1cBOXMQ66c4nGaQlos7HHD9
X-MS-Exchange-AntiSpam-MessageData: iNukS0eQIRKCUXGsZbi+xCDjFuit6XGx5D/ROGm6BH//P8ynkhaAleDVQ+GMWyABtnhEsiYYG+ecQK9d6vUNEViUXJ4a+divZPeFKNJXejIRSDh1OhXyJz7AKGsV4/1RJrOWqJ7c7emgkaItdZpMUQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7c5310-082d-421b-7ec0-08d7e537538a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 14:30:08.5590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp8DUfsBt6avyWBdg8AryQA2YiVxcE9J2lYQAwPDOVc75pbzgz8R7ycELUr6tmPgkjjJwekX5pcY+9UY+e6ll6xllPLaKBN4tRBZpNPbKN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4305
Received-SPF: pass client-ip=40.107.6.137;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 10:30:09
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.137
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



On 20.04.2020 15:56, Vladimir Sementsov-Ogievskiy wrote:
> 20.04.2020 12:17, Denis Plotnikov wrote:
>> The test checks fulfilling qcow2 requirements for the compression
>> type feature and zstd compression type operability.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/287     | 153 +++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/287.out |  67 ++++++++++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 221 insertions(+)
>>   create mode 100755 tests/qemu-iotests/287
>>   create mode 100644 tests/qemu-iotests/287.out
>>
>> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
>> new file mode 100755
>> index 0000000000..44988bc14b
>> --- /dev/null
>> +++ b/tests/qemu-iotests/287
>> @@ -0,0 +1,153 @@
>> +#!/usr/bin/env bash
>> +#
>> +# Test case for an image using zstd compression
>> +#
>> +# Copyright (c) 2020 Virtuozzo International GmbH
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +
>> +# creator
>> +owner=dplotnikov@virtuozzo.com
>> +
>> +seq="$(basename $0)"
>> +echo "QA output created by $seq"
>> +
>> +status=1    # failure is the default!
>> +
>> +# standard environment
>> +. ./common.rc
>> +. ./common.filter
>> +
>> +# This tests qocw2-specific low-level functionality
>> +_supported_fmt qcow2
>> +_supported_proto file
>> +_supported_os Linux
>> +
>> +# Sanity check: our use of $RAND_FILE fails if $TEST_DIR contains 
>> spaces
>> +# or other problems
>
> Hmm, but I see, you now don't use writing from file, but instead, 
> rewrite rand_file by 0xFA pattern. So, we don't have now any 
> restrictions on RAND_FILE now, and than, we should drop this check.
>
>> +case "$TEST_DIR" in
>> +    *[^-_a-zA-Z0-9/]*)
>> +        _notrun "Suspicious TEST_DIR='$TEST_DIR', cowardly refusing 
>> to run" ;;
>> +esac
>> +
>> +COMPR_IMG="$TEST_IMG.compressed"
>> +RAND_FILE="$TEST_DIR/rand_data"
>> +
>> +_cleanup()
>> +{
>> +    _cleanup_test_img
>> +    rm -f "$COMPR_IMG"
>> +    rm -f "$RAND_FILE"
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +# for all the cases
>> +CLUSTER_SIZE=65536
>> +
>> +# Check if we can run this test.
>> +if IMGOPTS='compression_type=zstd' _make_test_img 64M |
>> +    grep "Invalid parameter 'zstd'"; then
>> +    _notrun "ZSTD is disabled"
>> +fi
>> +
>> +echo
>> +echo "=== Testing compression type incompatible bit setting for zstd 
>> ==="
>> +echo
>> +# use the zstd image created on the test runnable check above.
>
> Hmm, but you don't? Should you also drop the following line?
>
>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>> +
>> +echo
>> +echo "=== Testing compression type incompatible bit setting for zlib 
>> ==="
>> +echo
>> +IMGOPTS='compression_type=zlib' _make_test_img 64M
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>> +
>> +echo
>> +echo "=== Testing zlib with incompatible bit set ==="
>> +echo
>> +IMGOPTS='compression_type=zlib' _make_test_img 64M
>> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
>> +# to make sure the bit was actually set
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>> +
>> +if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
>> +    echo "Error: The image opened successfully. The image must not 
>> be opened."
>> +fi
>> +
>> +echo
>> +echo "=== Testing zstd with incompatible bit unset ==="
>> +echo
>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>> +$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
>> +# to make sure the bit was actually unset
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>> +
>> +if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
>> +    echo "Error: The image opened successfully. The image must not 
>> be opened."
>> +fi
>> +
>> +echo
>> +echo "=== Testing compression type values ==="
>> +echo
>> +# zlib=0
>> +IMGOPTS='compression_type=zlib' _make_test_img 64M
>> +peek_file_be "$TEST_IMG" 104 1
>> +echo
>> +
>> +# zstd=1
>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>> +peek_file_be "$TEST_IMG" 104 1
>> +echo
>> +
>> +echo
>> +echo "=== Testing simple reading and writing with zstd ==="
>> +echo
>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>> +$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
>> +# read on the cluster boundaries
>> +$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
>> +
>> +echo
>> +echo "=== Testing adjacent clusters reading and writing with zstd ==="
>> +echo
>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>> +$QEMU_IO -c "write -c -P 0xAB 0 64K " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "write -c -P 0xAD 128K 64K " "$TEST_IMG" | _filter_qemu_io
>> +
>> +$QEMU_IO -c "read -P 0xAB 0 64k " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -P 0xAC 64K 64k " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -P 0xAD 128K 64k " "$TEST_IMG" | _filter_qemu_io
>> +
>> +echo
>> +echo "=== Testing incompressible cluster processing with zstd ==="
>> +echo
>> +# create a 2M imgae and fill it with 1M likely incompressible data
>
> image
>
>> +# and 1M compressible data
>> +dd if=/dev/urandom of="$RAND_FILE" bs=2M count=1
>> +# rewrite the last 1M with compressible data
>> +$QEMU_IO -f raw -c "write -P 0xFA 1M 1M" "$RAND_FILE" | _filter_qemu_io
>
> So, we avoid problems with whitespaces  in RAND_FILE.
>
> Still, you may improve it a bit, by not generating extra 1M of random 
> data, for example,
> create 2M raw image, then write to it b dd only 1M, then the other 
> megabyte by pattern.
Would it be any significant improvement? This example 2 lines of code. 
Your example is 3 lines (create-dd-write).
You example demand more output in test.out file also because of 3 
command instead of 2.
We won't win anything significant in performance by reducing 2M rand 
data to 1M.
So, I don't really know
>
> Also, I believe, that it works as is, but passing two -f options to 
> qemu-io is not good
> thing, I think, actually, we'd better forbid it in qemu-io option 
> parsing (Haha, I'm
> sure, a lot of iotests will need a fix:).. So, more correct is 
> something like
>
> QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT $QEMU_IO -f raw [...]
>
>
>


