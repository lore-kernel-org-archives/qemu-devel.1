Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938F5C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C49D206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PfLHeSau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C49D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXnO-000657-G4
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52138 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jQXmV-000595-Do
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:52:20 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jQXmU-0002r1-M3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:52:19 -0400
Received: from mail-eopbgr130110.outbound.protection.outlook.com
 ([40.107.13.110]:23359 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jQXmR-0002om-Mj; Mon, 20 Apr 2020 10:52:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qct3u+uuCeG7VrWTnAqg2GFtP0TyEVCLCK2QWvNEhy/iTSzJ/jLtT2jjtt5bZvyOg88etu+7e6FcieKVR0BTHz1SX+xJWcTRPdBNrsmcdnbThYubWXvoduvxvdTntAbR3azdbCadsVob15q79Ic3XpDQEfK4pKh6Yh5QcpeOOpS7LkeNrzv1vthhlPeMdmlB/5Lu6/CNw13Fhgesxup5/HlI4k1PmOxN/q20LVKrnCgz4xcvURPb/KZLREFy/YgLCq8OBgey90QXJDa8Gon51x7509rSimQJjjC1Fti99xRcgFegkW7oAsY+7rGYXXOOqC+1kWo8tZRSO2DSsZoQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjsRJQ5h8HgGS3XmUS/4uJoZTxFRkOkuHmhedOXvL+w=;
 b=FE8hjtAcN3GfpGi4FGZgiGXLlGu12GLHi7QsDV3dsg80KZIHxylLpQiB6mTDfylNPdDACd2EHjZS7zbVdohmXKdrEiRYPazZ8t+nVgDfKYqyqDItqQYyAdTFkg7N2QQqzLX7FBVBN4p+555HgBUk2xDYi5+UinbYtQj8YaQneXOdwwpIVPyx+BbzQLi1sunqya7zG55/GbE9hfgj363d25lXPlpih+1VUS5Cdmmj+cUFAlbxwFwNxI6I+bv6Gay2VUmoXhgg2XVI9qwcW17TSnYv2q8/q0vbS36zP3TYPT8/IGT5kAmNmbPrBnd2pz31u4EIuZ/DsQWXEo2DoN/VKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjsRJQ5h8HgGS3XmUS/4uJoZTxFRkOkuHmhedOXvL+w=;
 b=PfLHeSauSEoJUUa4nK0n+awsSg/NgzZtOvok8GKba5tmlJqZ7JhdWCJhVII0aTEsLN9sG6kaeklXCmizdMJugzhZ6hEcBZdk7V5j2MEYY6XCAzeF79L9v8XHJROU3qRcRBrgzkvd9lzfQB185OkqpDDI91k3HQbWMHgbOjAh0XE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4273.eurprd08.prod.outlook.com (2603:10a6:208:144::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 14:52:12 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 14:52:12 +0000
Subject: Re: [PATCH v19 4/4] iotests: 287: add qcow2 compression type test
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200420091757.14102-1-dplotnikov@virtuozzo.com>
 <20200420091757.14102-5-dplotnikov@virtuozzo.com>
 <f7eb0e48-4c0d-4ae7-893f-dbb2064836d3@virtuozzo.com>
 <b9100519-21e0-3b2b-1b16-5896be22ed49@virtuozzo.com>
 <f4df7e10-86d1-d3de-2ace-83eda5e63f08@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <b816f0d5-e3b2-42a0-8539-90a6afd3e2d6@virtuozzo.com>
Date: Mon, 20 Apr 2020 17:52:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <f4df7e10-86d1-d3de-2ace-83eda5e63f08@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0084.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::25) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (5.138.121.5) by
 AM0PR06CA0084.eurprd06.prod.outlook.com (2603:10a6:208:fa::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Mon, 20 Apr 2020 14:52:11 +0000
X-Originating-IP: [5.138.121.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77fe701a-85fa-48bf-9945-08d7e53a68c8
X-MS-TrafficTypeDiagnostic: AM0PR08MB4273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4273BFE623697EBC9E2F53D2CFD40@AM0PR08MB4273.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(396003)(39850400004)(376002)(346002)(366004)(956004)(2616005)(4326008)(66476007)(6486002)(31696002)(66556008)(5660300002)(36756003)(66946007)(86362001)(31686004)(81156014)(53546011)(16576012)(26005)(8676002)(316002)(2906002)(52116002)(478600001)(16526019)(186003)(8936002)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNrxn+EIX7sAIoPboOM+EFdhRXMvB07rldryr9B9I+zOuGD391pVPXoctxbo9FzDZF0F1zFnv1Y9EuNnxTVI2cPo6xWvFFEOWjJoI1XgB9bJqV6Xp57cQRCWiHhjTLZ/ZK5bDBok1mS3hn5iAYTKUXdzflH7kWjLPJkr83StftTAnb8QQKmmte1P57kSkK3Rc0amCXZUVeTNtAbA9MUgmxfESOku+WtcPr+ipQZO21y1FGVQFTS6As1YD9mRaNJdnQ6xKX/XUhMoveLdX8B3xsiR+Stx6OcyyanXIiv6pmsyOGawoMkt1tcZswyALM6v3+JsYmnEGHoGSQHr0ZQWmIyfr0S9xshxRDjGtyaNNbWwr/Q0L+NnTG2SUlocyqpCu1CrvqljVHI/ndK1O/+G4HjOU9hvPhT6BC1lrKR8CZYbRKsf6jNIjXwrmgOX380v69CGiv5UhH2kAdFft9qATuCyJwtxNAEsZQOgw4mTXFKMtct1cFmiFw1s/xa6UeHl6VMlH/Q/Ievzy7+4PqgSQ6Nrk4vMsXk3ETK+N1twUXnEOQvpmDPaqn1PHHT5QhHE
X-MS-Exchange-AntiSpam-MessageData: 9uiq2LN4NUHtzl5+rqPSQ5gonW2ZMHsoEHa7ZTR1/l88DNYKiKG9ah7LVCQsvi7af438ciqaG3fQ/tS5WeuDQI83CvkQFHGG+0V9eD2pWrDq0E2ZR9d5k5wlIWyFs0+faDmFe+Bl1SXJRO5k7FV54w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fe701a-85fa-48bf-9945-08d7e53a68c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 14:52:12.6694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPs0fpP0DpivDTez2ccGGHjZ5qzt4s8tPXHpQKaZTM5va4Z95F8GZE9lt5g2osu3lwQQgycecAs4Oo8x3BpfaLroaiANtsPpENAKhRmHgC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4273
Received-SPF: pass client-ip=40.107.13.110;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 10:52:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.13.110
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



On 20.04.2020 17:47, Vladimir Sementsov-Ogievskiy wrote:
> 20.04.2020 17:30, Denis Plotnikov wrote:
>>
>>
>> On 20.04.2020 15:56, Vladimir Sementsov-Ogievskiy wrote:
>>> 20.04.2020 12:17, Denis Plotnikov wrote:
>>>> The test checks fulfilling qcow2 requirements for the compression
>>>> type feature and zstd compression type operability.
>>>>
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> ---
>>>>   tests/qemu-iotests/287     | 153 
>>>> +++++++++++++++++++++++++++++++++++++
>>>>   tests/qemu-iotests/287.out |  67 ++++++++++++++++
>>>>   tests/qemu-iotests/group   |   1 +
>>>>   3 files changed, 221 insertions(+)
>>>>   create mode 100755 tests/qemu-iotests/287
>>>>   create mode 100644 tests/qemu-iotests/287.out
>>>>
>>>> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
>>>> new file mode 100755
>>>> index 0000000000..44988bc14b
>>>> --- /dev/null
>>>> +++ b/tests/qemu-iotests/287
>>>> @@ -0,0 +1,153 @@
>>>> +#!/usr/bin/env bash
>>>> +#
>>>> +# Test case for an image using zstd compression
>>>> +#
>>>> +# Copyright (c) 2020 Virtuozzo International GmbH
>>>> +#
>>>> +# This program is free software; you can redistribute it and/or 
>>>> modify
>>>> +# it under the terms of the GNU General Public License as 
>>>> published by
>>>> +# the Free Software Foundation; either version 2 of the License, or
>>>> +# (at your option) any later version.
>>>> +#
>>>> +# This program is distributed in the hope that it will be useful,
>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> +# GNU General Public License for more details.
>>>> +#
>>>> +# You should have received a copy of the GNU General Public License
>>>> +# along with this program.  If not, see 
>>>> <http://www.gnu.org/licenses/>.
>>>> +#
>>>> +
>>>> +# creator
>>>> +owner=dplotnikov@virtuozzo.com
>>>> +
>>>> +seq="$(basename $0)"
>>>> +echo "QA output created by $seq"
>>>> +
>>>> +status=1    # failure is the default!
>>>> +
>>>> +# standard environment
>>>> +. ./common.rc
>>>> +. ./common.filter
>>>> +
>>>> +# This tests qocw2-specific low-level functionality
>>>> +_supported_fmt qcow2
>>>> +_supported_proto file
>>>> +_supported_os Linux
>>>> +
>>>> +# Sanity check: our use of $RAND_FILE fails if $TEST_DIR contains 
>>>> spaces
>>>> +# or other problems
>>>
>>> Hmm, but I see, you now don't use writing from file, but instead, 
>>> rewrite rand_file by 0xFA pattern. So, we don't have now any 
>>> restrictions on RAND_FILE now, and than, we should drop this check.
>>>
>>>> +case "$TEST_DIR" in
>>>> +    *[^-_a-zA-Z0-9/]*)
>>>> +        _notrun "Suspicious TEST_DIR='$TEST_DIR', cowardly 
>>>> refusing to run" ;;
>>>> +esac
>>>> +
>>>> +COMPR_IMG="$TEST_IMG.compressed"
>>>> +RAND_FILE="$TEST_DIR/rand_data"
>>>> +
>>>> +_cleanup()
>>>> +{
>>>> +    _cleanup_test_img
>>>> +    rm -f "$COMPR_IMG"
>>>> +    rm -f "$RAND_FILE"
>>>> +}
>>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>>> +
>>>> +# for all the cases
>>>> +CLUSTER_SIZE=65536
>>>> +
>>>> +# Check if we can run this test.
>>>> +if IMGOPTS='compression_type=zstd' _make_test_img 64M |
>>>> +    grep "Invalid parameter 'zstd'"; then
>>>> +    _notrun "ZSTD is disabled"
>>>> +fi
>>>> +
>>>> +echo
>>>> +echo "=== Testing compression type incompatible bit setting for 
>>>> zstd ==="
>>>> +echo
>>>> +# use the zstd image created on the test runnable check above.
>>>
>>> Hmm, but you don't? Should you also drop the following line?
>>>
>>>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>>>> +
>>>> +echo
>>>> +echo "=== Testing compression type incompatible bit setting for 
>>>> zlib ==="
>>>> +echo
>>>> +IMGOPTS='compression_type=zlib' _make_test_img 64M
>>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>>>> +
>>>> +echo
>>>> +echo "=== Testing zlib with incompatible bit set ==="
>>>> +echo
>>>> +IMGOPTS='compression_type=zlib' _make_test_img 64M
>>>> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
>>>> +# to make sure the bit was actually set
>>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>>>> +
>>>> +if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
>>>> +    echo "Error: The image opened successfully. The image must not 
>>>> be opened."
>>>> +fi
>>>> +
>>>> +echo
>>>> +echo "=== Testing zstd with incompatible bit unset ==="
>>>> +echo
>>>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>>>> +$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
>>>> +# to make sure the bit was actually unset
>>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>>>> +
>>>> +if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
>>>> +    echo "Error: The image opened successfully. The image must not 
>>>> be opened."
>>>> +fi
>>>> +
>>>> +echo
>>>> +echo "=== Testing compression type values ==="
>>>> +echo
>>>> +# zlib=0
>>>> +IMGOPTS='compression_type=zlib' _make_test_img 64M
>>>> +peek_file_be "$TEST_IMG" 104 1
>>>> +echo
>>>> +
>>>> +# zstd=1
>>>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>>>> +peek_file_be "$TEST_IMG" 104 1
>>>> +echo
>>>> +
>>>> +echo
>>>> +echo "=== Testing simple reading and writing with zstd ==="
>>>> +echo
>>>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>>>> +$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
>>>> +$QEMU_IO -c "read -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
>>>> +# read on the cluster boundaries
>>>> +$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
>>>> +$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
>>>> +
>>>> +echo
>>>> +echo "=== Testing adjacent clusters reading and writing with zstd 
>>>> ==="
>>>> +echo
>>>> +IMGOPTS='compression_type=zstd' _make_test_img 64M
>>>> +$QEMU_IO -c "write -c -P 0xAB 0 64K " "$TEST_IMG" | _filter_qemu_io
>>>> +$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
>>>> +$QEMU_IO -c "write -c -P 0xAD 128K 64K " "$TEST_IMG" | 
>>>> _filter_qemu_io
>>>> +
>>>> +$QEMU_IO -c "read -P 0xAB 0 64k " "$TEST_IMG" | _filter_qemu_io
>>>> +$QEMU_IO -c "read -P 0xAC 64K 64k " "$TEST_IMG" | _filter_qemu_io
>>>> +$QEMU_IO -c "read -P 0xAD 128K 64k " "$TEST_IMG" | _filter_qemu_io
>>>> +
>>>> +echo
>>>> +echo "=== Testing incompressible cluster processing with zstd ==="
>>>> +echo
>>>> +# create a 2M imgae and fill it with 1M likely incompressible data
>>>
>>> image
>>>
>>>> +# and 1M compressible data
>>>> +dd if=/dev/urandom of="$RAND_FILE" bs=2M count=1
>>>> +# rewrite the last 1M with compressible data
>>>> +$QEMU_IO -f raw -c "write -P 0xFA 1M 1M" "$RAND_FILE" | 
>>>> _filter_qemu_io
>>>
>>> So, we avoid problems with whitespaces  in RAND_FILE.
>>>
>>> Still, you may improve it a bit, by not generating extra 1M of 
>>> random data, for example,
>>> create 2M raw image, then write to it b dd only 1M, then the other 
>>> megabyte by pattern.
>> Would it be any significant improvement? This example 2 lines of 
>> code. Your example is 3 lines (create-dd-write).
>> You example demand more output in test.out file also because of 3 
>> command instead of 2.
>> We won't win anything significant in performance by reducing 2M rand 
>> data to 1M.
>> So, I don't really know
>
> No objections, I'm OK with it as is.
>
> If you want, you may instead write random data to the second megabyte, 
> and pattern to the first, keeping two lines of code:
>
> dd if=/dev/urandom of="$RAND_FILE" bs=1M count=1 seek=1
> QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS_NO_FMT" $QEMU_IO -f raw -c "write -P 
> 0xFA 0 1M" "$RAND_FILE" | _filter_qemu_io
>
> but, it's nitpicking anyway.
Ok, I'll do it! Thanks!
>
>>>
>>> Also, I believe, that it works as is, but passing two -f options to 
>>> qemu-io is not good
>>> thing, I think, actually, we'd better forbid it in qemu-io option 
>>> parsing (Haha, I'm
>>> sure, a lot of iotests will need a fix:).. So, more correct is 
>>> something like
>>>
>>> QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT $QEMU_IO -f raw [...]
>>>
>>>
>>>
>>
>
>


