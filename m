Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3367DC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1682206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VV8CGYiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1682206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQVzW-00050r-Vd
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 08:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53022 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQVyQ-00049y-Et
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:56:38 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQVyP-00016L-Rm
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:56:30 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com
 ([40.107.8.94]:13277 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQVyL-0000rZ-BL; Mon, 20 Apr 2020 08:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr18tIh+COKCr6wTwS7lDlIHXjWvNFVRhpsAdxVtScPd5VJcBG67xOVSketBt4hR7DdhftcXck2Ypy8+7ghyTm5AroLLyKLe3PLTsFhAXQv0/2Npy1NXgEk1lKgzyuZhx+hyDD19ISc83vABsez196EpIQuFj7owwaEVLVSqAy9HSjy2EUyYnOUsu1pVGsHT30SluYYNw4EFw10MxAD8ZwBwHxgTOG2sZZzcU0RD7uhzUKAwjKArBDMXWYQ9wijc+lk3TDFBYISJJATuIryp1TfrgC5Z7ylC243F7JleWB7yss72U/WmiwxFHT9ZHThMpyYnE40aqzttkmnZuda2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIUH7e+PEkfd+4XDwZxOIKLZJ4qnOs74IUFqodtVhtk=;
 b=EMtPQxUrkLS8wCWutexaRTXg6KQZfokY+InD7G8VTiE6ml6JpBEbxwCuzjvwlnIXudmvtiZNvNKu8DtYWRRbKrjK/+AwTya+EE3FilBMI9voV2ILGncpuW50MrAVmv9CBLLDFidKW8cehTsj4R747djrEJxm1VyAaHRp0ksjQHVrnTET4uB11S/Uebn7aicHr6mrUiz6x9nOdjruhLkfrL7MGq2vMkEbJW2JgRQHdbjhoXiwbuZMJB52zHHDKvk4irOuDTNEd3pPR6JMgu8loLgALa04ANunBMOCFEt5ViI6BtitiaB7hseZEQe7aWlc5Qpr15YZ3vIMKpsbh67gZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIUH7e+PEkfd+4XDwZxOIKLZJ4qnOs74IUFqodtVhtk=;
 b=VV8CGYiRauR8AMTA/1H5j5MLuqLWskF0/uZTLUsRXQBVQAy8YJ8ZEEOkSIoMZ+JYviDIyZEjI9p7NjrhN9EuRUCN7ArqahntmdmkEuzLNe04aHnrXWbpOhANvdDxd4H1iFaJb7haSn8ekTb7fwtRktP5ovoLWzrwwSVayuS03mQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 12:56:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 12:56:21 +0000
Subject: Re: [PATCH v19 4/4] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200420091757.14102-1-dplotnikov@virtuozzo.com>
 <20200420091757.14102-5-dplotnikov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200420155619384
Message-ID: <f7eb0e48-4c0d-4ae7-893f-dbb2064836d3@virtuozzo.com>
Date: Mon, 20 Apr 2020 15:56:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420091757.14102-5-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0091.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM0PR06CA0091.eurprd06.prod.outlook.com (2603:10a6:208:fa::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 12:56:20 +0000
X-Tagtoolbar-Keys: D20200420155619384
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b14f93b0-0f79-434a-5656-08d7e52a394f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5430D6E1CF7D4F33128D4381C1D40@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(136003)(376002)(366004)(346002)(396003)(6486002)(478600001)(66946007)(8676002)(66556008)(81156014)(8936002)(66476007)(4326008)(36756003)(316002)(16576012)(86362001)(26005)(2906002)(31686004)(956004)(52116002)(186003)(31696002)(5660300002)(16526019)(2616005)(2004002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ElGfidT0kQEBQde5rrWhMKh6xje5vJiArajKO6zraNwjA0DKeDnKY0cxDfShSiZCi0lZAPiZcaq8MLs+bLj5ISSUb9KAEEk8XQQ2nusHvRLbHLlDvARnCbQbe7FR03426i62b0KmpYE4Gu9/zCBmVIguUNAKHr9SJHZkntfzCVNGytahX9EZ6flf18D3TAJu5FmfVERHLbGbJ8xW3vkTwb3pLXsoBU+7W0sjsj7xo+g9qTvPRGqwxC7L+XditfPClO6ZusTG8R0CjJicrkDvwe+FuH8bD+DowNd3ZvWbVlNjZNR8gYkCRgNTtFl4WHswUQe2X7q0K1mHRF6FbUtiOl9zp5T6mRafX018suMWEmpvq8RMHMvhnJjM15NX3MWggaw4uRxKgsd5XuhCUl6u5w3WX/5N6sRuSb8zUyNqItrBzpncxtXaQqIXSjDezrnGkJ2YAAJ6aP2RUnUGyUZfpUamTpwAMY45AEXZN3+qVAJ22e3nkqxnQdySDZMxD/lQElgXvdP0gQLsHxkhdmt9a4LYKnNmK2Mu71FyWO7fqhuV8aPS6eLc/Utpuznzt66
X-MS-Exchange-AntiSpam-MessageData: FZ0dpbAz32CnVfu1Tgo8hQbDRf4pFbD9fMv0rWEtYvYdECzkqC6zN2PhckeXNPOBg0nqaaVPL7mUuFGKdYqldWT0PLwghsJkOpJBicwTIIT4pVxQSvgDzyJcvrgrdCl8D8ytsRD0r7p2yNjYBieqWQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14f93b0-0f79-434a-5656-08d7e52a394f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 12:56:21.0406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kl8EKdMWOMJMd2E98nd1lfBWcbeyrusI7k3njTFk+bj734mEC3SOVbYqOF/5O5gHk/6SucecvKwuRLJMoye7M0eOT28QBKG1pEZ6CAA0zug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.8.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 08:56:22
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.94
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

20.04.2020 12:17, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requirements for the compression
> type feature and zstd compression type operability.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>   tests/qemu-iotests/287     | 153 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/287.out |  67 ++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 221 insertions(+)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
> 
> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
> new file mode 100755
> index 0000000000..44988bc14b
> --- /dev/null
> +++ b/tests/qemu-iotests/287
> @@ -0,0 +1,153 @@
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
> +# Sanity check: our use of $RAND_FILE fails if $TEST_DIR contains spaces
> +# or other problems

Hmm, but I see, you now don't use writing from file, but instead, rewrite rand_file by 0xFA pattern. So, we don't have now any restrictions on RAND_FILE now, and than, we should drop this check.

> +case "$TEST_DIR" in
> +    *[^-_a-zA-Z0-9/]*)
> +        _notrun "Suspicious TEST_DIR='$TEST_DIR', cowardly refusing to run" ;;
> +esac
> +
> +COMPR_IMG="$TEST_IMG.compressed"
> +RAND_FILE="$TEST_DIR/rand_data"
> +
> +_cleanup()
> +{
> +	_cleanup_test_img
> +	rm -f "$COMPR_IMG"
> +	rm -f "$RAND_FILE"
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# for all the cases
> +CLUSTER_SIZE=65536
> +
> +# Check if we can run this test.
> +if IMGOPTS='compression_type=zstd' _make_test_img 64M |
> +    grep "Invalid parameter 'zstd'"; then
> +    _notrun "ZSTD is disabled"
> +fi
> +
> +echo
> +echo "=== Testing compression type incompatible bit setting for zstd ==="
> +echo
> +# use the zstd image created on the test runnable check above.

Hmm, but you don't? Should you also drop the following line?

> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +echo
> +echo "=== Testing compression type incompatible bit setting for zlib ==="
> +echo
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +echo
> +echo "=== Testing zlib with incompatible bit set ==="
> +echo
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
> +# to make sure the bit was actually set
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
> +    echo "Error: The image opened successfully. The image must not be opened."
> +fi
> +
> +echo
> +echo "=== Testing zstd with incompatible bit unset ==="
> +echo
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
> +# to make sure the bit was actually unset
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +
> +if $QEMU_IMG info "$TEST_IMG" >/dev/null 2>&1 ; then
> +    echo "Error: The image opened successfully. The image must not be opened."
> +fi
> +
> +echo
> +echo "=== Testing compression type values ==="
> +echo
> +# zlib=0
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +peek_file_be "$TEST_IMG" 104 1
> +echo
> +
> +# zstd=1
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +peek_file_be "$TEST_IMG" 104 1
> +echo
> +
> +echo
> +echo "=== Testing simple reading and writing with zstd ==="
> +echo
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
> +# read on the cluster boundaries
> +$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
> +
> +echo
> +echo "=== Testing adjacent clusters reading and writing with zstd ==="
> +echo
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$QEMU_IO -c "write -c -P 0xAB 0 64K " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "write -c -P 0xAC 64K 64K " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "write -c -P 0xAD 128K 64K " "$TEST_IMG" | _filter_qemu_io
> +
> +$QEMU_IO -c "read -P 0xAB 0 64k " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xAC 64K 64k " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0xAD 128K 64k " "$TEST_IMG" | _filter_qemu_io
> +
> +echo
> +echo "=== Testing incompressible cluster processing with zstd ==="
> +echo
> +# create a 2M imgae and fill it with 1M likely incompressible data

image

> +# and 1M compressible data
> +dd if=/dev/urandom of="$RAND_FILE" bs=2M count=1
> +# rewrite the last 1M with compressible data
> +$QEMU_IO -f raw -c "write -P 0xFA 1M 1M" "$RAND_FILE" | _filter_qemu_io

So, we avoid problems with whitespaces  in RAND_FILE.

Still, you may improve it a bit, by not generating extra 1M of random data, for example,
create 2M raw image, then write to it b dd only 1M, then the other megabyte by pattern.

Also, I believe, that it works as is, but passing two -f options to qemu-io is not good
thing, I think, actually, we'd better forbid it in qemu-io option parsing (Haha, I'm
sure, a lot of iotests will need a fix:).. So, more correct is something like

QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT $QEMU_IO -f raw [...]



-- 
Best regards,
Vladimir

