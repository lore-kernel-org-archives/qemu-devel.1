Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29403C3F2D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 08:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F29246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 08:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UjtRjUIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F29246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ax2-0006hV-Ug
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 03:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7avt-00062p-25
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 03:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j7avr-0002Dp-E4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 03:23:41 -0500
Received: from mail-db8eur05on2102.outbound.protection.outlook.com
 ([40.107.20.102]:28513 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j7avn-00028p-J0; Fri, 28 Feb 2020 03:23:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm/odaQIjnvjEBr6QEo50U2NowhGWauwpmM7L8b3uTyyPhIm+VSvtrVKp18VU7t+9BC32KN8fJq25yu3fEkYnKw6eQBywcbzk0yPfjMJ4pQTzXo0MSD+yeCEZ3AJYY2c8dc3AVkvqH6JQmvKmViTACd9wmEFGcwur8IixvgkqE+6EiA/ub6Adlp5C4FYpCa2fZN7HsA9A0w9GPfOfhSaDrLjVurztjTEQB0ByLb/Ezy+EYSJ2mhVhHaB/GFs2tJEkvAT/pvrN1l6L+Pei+tOLu8jrrOf3QRyU1WFagFlkHg78V/qKTOzPz4BMwM7exEvJgp6VP0qWPbCuEVe7lNDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEiNeGR+pntXfp7RK8ip/vgq6U/JV5iy0A2hK8nS4Ik=;
 b=HlUGH2cRnXQMxVZq6yogd/NffCHFibU9+CpixEeZt8Sox6CMoQ6MgVO/+KWkDmS9SneCa51TkCqV1lXLE2sofBSrhN2gJBmKGdQldNk+mW5rodPrNepeFxl9ErxsuHVTzCL4JuGziQ/Y8FVTy4L9xvjVYTvD0CQPA+UCKpboADboiTdDVVGvi3RyaqGzRcC4kA4DBUoA4kRgP66aGhzRplUEkMa4FB6RFiIPyhwLh7f4WqrDyfpZAgTV+LP8UNuj6ueS+FtRe9rjeIxmIcO0q2QBXju9N6MoiuXZropGrvAkWtDSTKKrRytBaZZtUAxQJEA1tuYZZ4M0aiCfqBrUpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEiNeGR+pntXfp7RK8ip/vgq6U/JV5iy0A2hK8nS4Ik=;
 b=UjtRjUIu4zH6TbyVNlWTQW4DqGdtDHMGzHb10lo/79UBDOS2hAY6ZZM+uifZA6lt6KSOi+trs+3hkDL+eUkh773VtlynSM7Eio2SNyB54MPgEwculD6vONJciQYGp5stKswB764dG2iW6MmRV2+us4VjOeybhgR1xm14BPCmb74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB2947.eurprd08.prod.outlook.com (52.134.94.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Fri, 28 Feb 2020 08:23:32 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.012; Fri, 28 Feb 2020
 08:23:32 +0000
Subject: Re: [PATCH v1 8/8] iotests: 287: add qcow2 compression type test
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-9-dplotnikov@virtuozzo.com>
 <416ce145-9163-5397-356d-87401e346e77@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <1f2d8487-1634-e822-6903-1d61e3790db6@virtuozzo.com>
Date: Fri, 28 Feb 2020 11:23:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <416ce145-9163-5397-356d-87401e346e77@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0402CA0006.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::16) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.162.229) by
 HE1PR0402CA0006.eurprd04.prod.outlook.com (2603:10a6:3:d0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Fri, 28 Feb 2020 08:23:30 +0000
X-Originating-IP: [178.34.162.229]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aa2189b-bd7d-4840-871e-08d7bc277ef5
X-MS-TrafficTypeDiagnostic: AM0PR08MB2947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB2947A0D9E579A32E4895490DCFE80@AM0PR08MB2947.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(396003)(39850400004)(366004)(199004)(189003)(86362001)(66556008)(478600001)(36756003)(53546011)(16576012)(316002)(66476007)(16526019)(52116002)(2616005)(31696002)(186003)(6486002)(26005)(956004)(4326008)(8676002)(81166006)(81156014)(66946007)(8936002)(2906002)(5660300002)(31686004)(2004002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2947;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pki8Fyopi5XQ+GBQfk3gdpFnghLKqe3zdvjMyUYAdXxINh8QDwJ7XH8lqfoZLcNBoy59ReA54OBNpUEfW1FchKuDDXm6ql54GHyOR+mbhMti25LRVz70V6sUi7eAOnj30N0yEXZFiq5gWRm4vIsABNjcn/jlAJXNpaxJgjOs/HDNgJIp2eKheCwadpuiJJ+y+/OAvmeaRyJkhjZ9gY6pSIVOM5ggofuuUp3q1xvQSLuXlFapcaTh2Wo1LfywvCCcC6FJBq2RU+h1hs7XYqcgi9lDSQbBm0DNNRyVvT+1hAnrdyxv2FtIkbRh1cjGCqFiZeJzYjexzX+EzZu20y8u8JJCWwi37UqDK/cWe97ftVYsiUZfUXbI6Ah6dOdnhSsH65UNH/nrYk64uyV97kEtYjuSC84CklbREafFw8XetpCLd7Cy/gij9L47Fs1C5JjnGSodSGQRdObcarOB5vLgOAVVPzylfhXxauaAR/htb6VgT2x7Y+1K9dJwELduY3pRZkg7t6NndTWe3wMzXDbO5MB1nKsIpdEjFajeu9Q6Q0Y4KI85wU8H1Um4o0EsH1mWKD+KRzD/huTWbuTY//stdQ==
X-MS-Exchange-AntiSpam-MessageData: n1ks4c5m6kSPkHtZ5Pl0MrMblTYU69CJc5Jsf5OeJjGQPjFBigyWyxiAwOr6GpssQ1Mba7JJsCD0hsVh8ujzY0G6quugLKpy9QP6SqJetoBjtHHmNC0O4oSKLn43enqeT/f3PmwRlGoiIV2rUQY8FQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa2189b-bd7d-4840-871e-08d7bc277ef5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 08:23:32.6854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk3EszM+nVWeSI7wBj43QGDZgh8a6ST9NI9KLOcyAfqLUlzbUm8mF3QiDT2K5W3Hk/HhxsKAA62nH+UP6CzRzkVzolBEQM9ovATkuUm2gqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2947
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.102
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



On 27.02.2020 13:29, Vladimir Sementsov-Ogievskiy wrote:
> 27.02.2020 10:29, Denis Plotnikov wrote:
>> The test checks fulfilling qcow2 requiriements for the compression
>> type feature and zstd compression type operability.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>> =C2=A0 tests/qemu-iotests/287=C2=A0=C2=A0=C2=A0=C2=A0 | 123 ++++++++++++=
+++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/287.out |=C2=A0 41 +++++++++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 165 insertions(+)
>> =C2=A0 create mode 100755 tests/qemu-iotests/287
>> =C2=A0 create mode 100644 tests/qemu-iotests/287.out
>>
>> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
>> new file mode 100755
>> index 0000000000..41b916f690
>> --- /dev/null
>> +++ b/tests/qemu-iotests/287
>> @@ -0,0 +1,123 @@
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
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.=C2=A0 If not, see <http://www.gnu.org/licens=
es/>.
>> +#
>> +
>> +# creator
>> +owner=3Ddplotnikov@virtuozzo.com
>> +
>> +seq=3D"$(basename $0)"
>> +echo "QA output created by $seq"
>> +
>> +status=3D1=C2=A0=C2=A0=C2=A0 # failure is the default!
>> +
>> +_cleanup()
>> +{
>> +=C2=A0=C2=A0=C2=A0 _cleanup_test_img
>> +}
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
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
>> +P=3D`echo "$QEMU_PROG" | sed "s/qemu-system-x86_64//"`
>> +
>> +grep "CONFIG_ZSTD=3Dy" "$P"../config-host.mak >/dev/null
>> +RES=3D$?
>
> Hmm. This will not work for other architectures and for
> out of tree builds. Also, it checks config but not current
> binary (they may be out of sync, or even unrelated).
>
> Probably better try to create image with zstd compression type
> and handle expected error.
What if the error is "unable to create an image with zstd", although it=20
has to be?
I think the best way is to ask qemu binary whether it supports zstd, but=20
it doesn't available by now (should be?)

Is there any other way to make sure that the std compression test has to=20
be executed?
>
>
>> +if (($RES)); then
>> +=C2=A0=C2=A0=C2=A0 _notrun "ZSTD is disabled in the current configurati=
on"
>> +fi
>> +
>> +# Test: when compression is zlib the incompatible is unset
>> +echo
>> +echo "=3D=3D=3D Testing compression type incompatible bit setting for z=
lib=20
>> =3D=3D=3D"
>> +echo
>> +
>> +_make_test_img 64M
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>> +
>> +# Test: when compression differs from zlib the incompatible bit is set
>> +echo
>> +echo "=3D=3D=3D Testing compression type incompatible bit setting for z=
std=20
>> =3D=3D=3D"
>> +echo
>> +
>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>> +
>> +# Test: an image can't be openned if compression type is zlib and
>
> opened
>
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 incompatible feature compression =
type is set
>> +echo
>> +echo "=3D=3D=3D Testing zlib with incompatible bit set=C2=A0 =3D=3D=3D"
>> +echo
>> +
>> +IMGOPTS=3D'compression_type=3Dzlib' _make_test_img 64M
>> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
>> +# to make sure the bit was actually set
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
>> +if (($?=3D=3D0)); then
>> +=C2=A0=C2=A0=C2=A0 echo "Error: The image openned successfully. The ima=
ge must not=20
>> be openned"
>> +fi
>
> may be better to instead keep error output and just check it..
I add the explicit message to reduce the investigating time of what=20
happened and what should it be.
If it isn't that important I'd rather leave it as is.
>
>> +
>> +# Test: an image can't be openned if compression type is NOT zlib and
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 incompatible feature compression =
type is UNSET
>> +echo
>> +echo "=3D=3D=3D Testing zstd with incompatible bit unset=C2=A0 =3D=3D=
=3D"
>> +echo
>> +
>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>> +$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
>> +# to make sure the bit was actually unset
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
>> +if (($?=3D=3D0)); then
>> +=C2=A0=C2=A0=C2=A0 echo "Error: The image openned successfully. The ima=
ge must not=20
>> be openned"
>> +fi
>> +# Test: check compression type values
>> +echo
>> +echo "=3D=3D=3D Testing compression type values=C2=A0 =3D=3D=3D"
>> +echo
>> +# zlib=3D0
>> +IMGOPTS=3D'compression_type=3Dzlib' _make_test_img 64M
>> +od -j104 -N1 -An -vtu1 "$TEST_IMG"
>> +
>> +# zstd=3D1
>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>> +od -j104 -N1 -An -vtu1 "$TEST_IMG"
>> +
>> +# Test: using zstd compression, write to and read from an image
>> +echo
>> +echo "=3D=3D=3D Testing reading and writing with zstd =3D=3D=3D"
>> +echo
>> +
>> +CLUSTER_SIZE=3D65536
>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>> +$QEMU_IO -c "write -c 0 64k " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -v 0 10 " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -v 65530 8" "$TEST_IMG" | _filter_qemu_io
>
> Hmm output depends on default pattern. Better use "write -c -P 0x11 0=20
> 64k"
> =C2=A0(or any pattern you want), to make it explicit.
Good suggestion, I'll change that
>
>> +
>> +# success, all done
>> +echo "*** done"
>> +rm -f $seq.full
>> +status=3D0
>> diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
>> new file mode 100644
>> index 0000000000..4218254ce0
>> --- /dev/null
>> +++ b/tests/qemu-iotests/287.out
>> @@ -0,0 +1,41 @@
>> +QA output created by 287
>> +
>> +=3D=3D=3D Testing compression type incompatible bit setting for zlib =
=3D=3D=3D
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>> +incompatible_features=C2=A0=C2=A0=C2=A0=C2=A0 []
>> +
>> +=3D=3D=3D Testing compression type incompatible bit setting for zstd =
=3D=3D=3D
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864=20
>> compression_type=3Dzstd
>> +incompatible_features=C2=A0=C2=A0=C2=A0=C2=A0 [3]
>> +
>> +=3D=3D=3D Testing zlib with incompatible bit set=C2=A0 =3D=3D=3D
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>> +incompatible_features=C2=A0=C2=A0=C2=A0=C2=A0 [3]
>> +
>> +=3D=3D=3D Testing zstd with incompatible bit unset=C2=A0 =3D=3D=3D
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864=20
>> compression_type=3Dzstd
>> +incompatible_features=C2=A0=C2=A0=C2=A0=C2=A0 []
>> +
>> +=3D=3D=3D Testing compression type values=C2=A0 =3D=3D=3D
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>> +=C2=A0=C2=A0 0
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864=20
>> compression_type=3Dzstd
>> +=C2=A0=C2=A0 1
>> +
>> +=3D=3D=3D Testing reading and writing with zstd =3D=3D=3D
>> +
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864=20
>> compression_type=3Dzstd
>> +wrote 65536/65536 bytes at offset 0
>> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +00000000:=C2=A0 cd cd cd cd cd cd cd cd cd cd=C2=A0 ..........
>> +read 10/10 bytes at offset 0
>> +10 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +0000fffa:=C2=A0 cd cd cd cd cd cd 00 00=C2=A0 ........
>> +read 8/8 bytes at offset 65530
>> +8 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +*** done
>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>> index 0317667695..5edbadef40 100644
>> --- a/tests/qemu-iotests/group
>> +++ b/tests/qemu-iotests/group
>> @@ -293,3 +293,4 @@
>> =C2=A0 283 auto quick
>> =C2=A0 284 rw
>> =C2=A0 286 rw quick
>> +287 auto quick
>>
>
>


