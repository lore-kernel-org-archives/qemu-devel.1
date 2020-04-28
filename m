Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A8CC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC472206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kzDpydmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC472206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTOkX-0001gN-PR
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 07:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTOj1-0000H5-3m
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTOeS-0007Gh-4Z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:48:30 -0400
Received: from mail-eopbgr70101.outbound.protection.outlook.com
 ([40.107.7.101]:13353 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTOcb-0004OT-0N; Tue, 28 Apr 2020 07:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLQIwIJCY+tcmKlVePYNn9XSHC3oqrOP5QuL7JZDrO1RH05TXe/ZEJhHjPfWuXytPVn6CCQOrffPPmPqRFXqSd3cUSBxp0l33Gj+MyIP6E7KdvssZt89qkYIHCRVtXMKiVYlPOp031ZY9Df1W27OKPSSPxrbSjVVMCmGA7h2SQmTpO98znPVGlP6LkAMWDMQDtGu95xr4d4oG2jlq1tVaRzctjgXiFd+i3Ab+STsph4/C07mcnELdA0GDTPkJ9Q5ji1TXqHA2jA3+rdG6+6PCj7WdEZYehk6PwIRiifJ/+uyedIYvk0hDhocf/+ZbDTvGA7WJ32UFgomnUY1/949CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hZWqZwvQd1lerA/sONSaz9/zxceFr+u9PWzVCW+fMk=;
 b=fODm5BsDsgjcJwABmvXF9DRfGg4LL0bTcrYnL/7oRYBCrzmKKUmwaeLbcOBSaukWt0OPlzv2xRdZThSYbIHQXSNhHShMchcdL1nYabQ4wHNFufkwx2Z8JBjsvrjUl47VYp1M7nokshFBTxqUjuIE2jaCu9K5KcHEFIL91wKmCFj3Bttu0u+DA281IjNR8vCtd37XTE/mQQVlmsgUoZfm48jDL+eH2/iLElj8KBZEUjEblS2HTXGL1nxSsKU5A20DNowQfo97bTGPA+o5fJMqyxMexaLndhhJ5GIKHJQ9BK25p6T22jQ3OSa4CNv7DqD8F44X4fOXlQqvt8FF5x3AJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hZWqZwvQd1lerA/sONSaz9/zxceFr+u9PWzVCW+fMk=;
 b=kzDpydmtIghu8CBXlVWccpnnz2PYIOnIbHOzCyTSXD6IGp0XhH8c7GvkRSd4wrub9Zg3cmIhmxB/hYYoOFO513ckKnpJV/CoCF+rv9naHxeLQSWvOB30kOUoYC8hScu9iXqgqmTNAROwjKMhwX8svpx6cZ1OZcsR5Og5kI/bPo8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB3601.eurprd08.prod.outlook.com (2603:10a6:208:e1::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 11:41:48 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 11:41:47 +0000
Subject: Re: [PATCH v20 4/4] iotests: 287: add qcow2 compression type test
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-5-dplotnikov@virtuozzo.com>
 <c0fdc097-dabd-4661-fce9-a63a24a8d792@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <64471c60-6bdd-fc7a-2dec-ff480137fec8@virtuozzo.com>
Date: Tue, 28 Apr 2020 14:41:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <c0fdc097-dabd-4661-fce9-a63a24a8d792@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:207::32)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.204) by
 AM3PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:207::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 11:41:46 +0000
X-Originating-IP: [178.34.151.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dcb526d-022d-4c43-fcf1-08d7eb692257
X-MS-TrafficTypeDiagnostic: AM0PR08MB3601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB36016B839674050D91190801CFAC0@AM0PR08MB3601.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(39840400004)(396003)(346002)(5660300002)(2906002)(478600001)(31696002)(86362001)(2616005)(53546011)(4326008)(956004)(186003)(66946007)(6486002)(66556008)(66476007)(36756003)(81156014)(31686004)(8936002)(52116002)(16576012)(26005)(8676002)(16526019)(316002)(2004002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10YlEAIB9t9HKquaEWi6FJpn13kX9Iu3yJVo4u9xGFWW4cr5Ufy2DNWX7dModh/IYNnaq1qvYv8P1If3+biDC6bL7sUJqDwcAXZ791JArwgQ9nx7HXUDd0LaTj6FeJYS8a2jIjWjsXmpBlkw1VLz6nT0YGpWNOnTC56CRQFyUBo6ScPVA7xw07ewM52W/4lUQMcJEgMG6cvR6/d9t1bM0X6HnxUn8X4hmRYvUKN6HHfbk7HE3OrKltgomKU1DzF/L5umWG0H3vDlQRtmpUmdBfjlRW/ixbNoWuswmpBRNL+J/lxC5Xkj1iYQzWtf1/bD680Du8N7SGLAtTsa4q4A4zBQCTRryXZpmA/JCTG1p9Yz3bdBoYDyO6WIZmad2czhUomnVDSTWI2ejVQZfoydUyjCh0O4NQ9rvgNFN+ohgslbo42eO9yEn9TQNqI4r8P/vuEsQ3eff5ueuS22Gxsg05o7VvIPpCbYD1iBYqwpCd0Wg3+aAxCJhhH1fSNppVHmTLiI25he3ygneCIFXGGLBQk+FOZXZiOWW/Jkg26CgDspllmXeACcxCYNgUe1R62b
X-MS-Exchange-AntiSpam-MessageData: eFoyqhgdarzV1FctPy1DS/Gu6/iMlEXYOoYISmKm7Kbjnnv2sBAZ0QgQzrdcmoij0yqJEUb5AX4B6bi0gaqoo9Crkv5KzF9+WyEPciCvORoA/YKRatAXJZLXjV1W2272kXKDvTrWR5n5nADwb/xvUiJ26VQDaf7xSVkpwF0xw1q0JQ7cAuIq45sNdQtzVt0Enlz5HsATWVfic9YgaCvoL6Jba/1uD3eAgt/7cgOffp80HVa2Ib1RKpO7RKgfwVEnMLHtECJsdtTb40iaTlWm8L47E41ef74SxJu1AFXHD095oxwEuL2VzxecP6UQDCpBWQnUBD3HEu7ET8DyZAncLV0GvSHcMv4q+Y4N7T+MwskyUxkreA5+9NfvpIjYYIOFyGMGPGSshixyhh7Gsk18vnkQ8T1zuKjc+fzV7tS/WbL8KEaL4/w2e3gUYDnrTjEwqmstMx3FQJWkBmxWVOF/CKbEi9/1cnWvWQp9v2mWC1wMnxR8GaO1ZgYnwDluKn3h1Hp25vX4oR8EhsvLw8vUx8I/eFDGwQTmNe47LeGWkvcIrtaaJQAp98WvoRn63nAvq0O68vszibRtN9iqvo0dlGCDJnkqLVDwXpvidOzAnse/fMAgH68BbTDujmJDeGp2DzuImrWGcRETAxTclhNG4ZjXAbim3terIvx8IDjOjEcpZT23PRBmJSd4NaTGluHNuTDbZNP5rr6SBAs+rJv4IuWuU8fhY//EvCL/xltlFPBlbLMAyg4IpSejShPWpKER61yKu7qygg1Ogsx+Xmn3eroNaKdG1WTZ3JAR93gOBM4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcb526d-022d-4c43-fcf1-08d7eb692257
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 11:41:47.8918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATYSji2dmbo7kITR0aY8jkVTwOLfBQEC1UGslle7IB4U50NqXD+Y7MNVr74SHIPBNMKHdVkH8teZjIcBqieOxSMr31PbGdMjcGZqQQ46Y/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3601
Received-SPF: pass client-ip=40.107.7.101;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 07:41:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.101
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27.04.2020 16:29, Max Reitz wrote:
> On 21.04.20 10:11, Denis Plotnikov wrote:
>> The test checks fulfilling qcow2 requirements for the compression
>> type feature and zstd compression type operability.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/287     | 146 +++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/287.out |  67 +++++++++++++++++
>>   tests/qemu-iotests/group   |   1 +
>>   3 files changed, 214 insertions(+)
>>   create mode 100755 tests/qemu-iotests/287
>>   create mode 100644 tests/qemu-iotests/287.out
>>
>> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
>> new file mode 100755
>> index 0000000000..156acc40ad
>> --- /dev/null
>> +++ b/tests/qemu-iotests/287
>> @@ -0,0 +1,146 @@
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
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +#
>> +
>> +# creator
>> +owner=dplotnikov@virtuozzo.com
>> +
>> +seq="$(basename $0)"
>> +echo "QA output created by $seq"
>> +
>> +status=1	# failure is the default!
>> +
>> +# standard environment
>> +. ./common.rc
>> +. ./common.filter
>> +
>> +# This tests qocw2-specific low-level functionality
>> +_supported_fmt qcow2
>> +_supported_proto file
>> +_supported_os Linux
> This test doesn’t work with compat=0.10 (because we can’t store a
> non-default compression type there) or data_file (because those don’t
> support compression), so those options should be marked as unsupported.
>
> (It does seem to work with any refcount_bits, though.)

Could I ask how to achieve that?
I can't find any _supported_* related.

Denis
>
>> +
>> +COMPR_IMG="$TEST_IMG.compressed"
>> +RAND_FILE="$TEST_DIR/rand_data"
>> +
>> +_cleanup()
>> +{
>> +	_cleanup_test_img
>> +	rm -f "$COMPR_IMG"
> Using _rm_test_img() would be nicer.  There shouldn’t be a functional
> difference here because there’d only be one with external data files (I
> think), which won’t work with this test, but still.
>
>> +	rm -f "$RAND_FILE"
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +# for all the cases
>> +CLUSTER_SIZE=65536
>> +
>> +# Check if we can run this test.
>> +if IMGOPTS='compression_type=zstd' _make_test_img 64M |
>> +    grep "Invalid parameter 'zstd'"; then
>> +    _notrun "ZSTD is disabled"
>> +fi
>> +
>> +echo
>> +echo "=== Testing compression type incompatible bit setting for zlib ==="
>> +echo
>> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> Please use -o so user options are still considered.
>
> (i.e., _make_test_img -o compression_type=zlib)
>
> [...]
>
>> +echo
>> +echo "=== Testing incompressible cluster processing with zstd ==="
>> +echo
>> +# create a 2M image and fill it with 1M likely incompressible data
>> +# and 1M compressible data
>> +dd if=/dev/urandom of="$RAND_FILE" bs=1M count=1 seek=1
>> +QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS_NO_FMT" \
>> +$QEMU_IO -f raw -c "write -P 0xFA 0 1M" "$RAND_FILE" | _filter_qemu_io
>> +$QEMU_IMG convert -f raw -O $IMGFMT -c "$RAND_FILE" "$TEST_IMG" | _filter_qemu_io
>> +
>> +$QEMU_IMG convert -O $IMGFMT -c -o compression_type=zstd \
>> +                  "$TEST_IMG" "$COMPR_IMG"
> Again, it would be nice to not discard the user-supplied options here,
> and maybe it would also be nicer to explicitly pass the compression type
> for the first convert, too.  So we’d use
>    -o "$(_optstr_add "$IMGOPTS" "compression_type=zlib")"
> for the first convert, and
>    -o "$(_optstr_add "$IMGOPTS" "compression_type=zstd")"
> for the second one.
>
> Max
>


