Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBF6C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E89246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OV58LQsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E89246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7b62-0001il-V0
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 03:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7b51-00013N-0B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 03:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7b4z-0002kG-4v
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 03:33:06 -0500
Received: from mail-am6eur05on2099.outbound.protection.outlook.com
 ([40.107.22.99]:34528 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7b4u-0002iT-OL; Fri, 28 Feb 2020 03:33:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6xQ7cslioJ2rkA+WMO+FNtBqp0x+iXMpZKIWH/HsC6XNwklOQTlaPESCedAIF/PJB0IQpFrTrPdMKiy6+7Spog9OVC0uxtprSrigP0Seyut1b+73cInDbIBOuEY52CbOP1/aagGxcPMpJ5KPOSP6w/wCTuztGOrwMUbmJYE9jlkIF5QIh63y53r0OU/ciU1VWZdlM+QDPzXsM/h/PT61gulXPFZzgok/hXKR/FcfzKFdtsNPWeus205qPTrmUbKbRf19xoJmyh5ECLOmmWx78NbpoMgOAFBLib5tp36R3jYQ1IvxkFvYn46IrIHrDN4LBOtUCmav9etVNfrcb8hTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0aw0x+3labp6BNmlcRwzSUbhn7QEez5Jda+ZTMwcVE=;
 b=XXDQZWceEvHG25oH/r2quGr8xn6vb/XfQhPlJXZV+Gpe8JbJCPeFb7p7htXu5oeELUr6nV0cuf9Eq/9Tb83Ov6BB8Inn7H+aM8wgvrm0915N8RrszwjZXtDCGcCOZEHomLxqKQ3bK+0RtJQccmB5O2R4HB2Gq70/WLZ2KqqHcSitnAXAUz3qu9izezUWvAhF4Xc5LwqRooFV6EbtbScPyHIqdwfiADfwXohUW5gRK75nBxdag6CS0xtRWWI4Cwj2Jk5vcUp5k7lFu4je6QFoIA7SJqi6LceYJrLSToJaO8U4ElUZ1V7/cPbR3gXknymLJzjz66/S+QXY+DzttG76LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0aw0x+3labp6BNmlcRwzSUbhn7QEez5Jda+ZTMwcVE=;
 b=OV58LQsCM+Qa7p//Wp6kP14myrSXynIcA9xXEe49q7CPUC+LwzYwsd+EVNWVFCaW9vew2pkYmncmbpkzlqLFZW2hRRGSRgvHnv0ACmlTbwj1T4gBOn02Fjmrb0HLAo+O9gO+ji7bKD2N9Jx+nrA6y0son7KAOj81JRmAoeWl+0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3080.eurprd08.prod.outlook.com (52.135.167.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Fri, 28 Feb 2020 08:32:57 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.024; Fri, 28 Feb 2020
 08:32:57 +0000
Subject: Re: [PATCH v1 8/8] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200227072953.25445-1-dplotnikov@virtuozzo.com>
 <20200227072953.25445-9-dplotnikov@virtuozzo.com>
 <416ce145-9163-5397-356d-87401e346e77@virtuozzo.com>
 <1f2d8487-1634-e822-6903-1d61e3790db6@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200228113254741
Message-ID: <44e142a7-e1df-7a3b-235e-72cfe8f763e2@virtuozzo.com>
Date: Fri, 28 Feb 2020 11:32:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1f2d8487-1634-e822-6903-1d61e3790db6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P18901CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::16) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P18901CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16 via Frontend Transport; Fri, 28 Feb 2020 08:32:56 +0000
X-Tagtoolbar-Keys: D20200228113254741
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d69e78f2-5636-4249-5e7d-08d7bc28d02d
X-MS-TrafficTypeDiagnostic: AM6PR08MB3080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30806277A0F57F877746C529C1E80@AM6PR08MB3080.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(6486002)(86362001)(31686004)(36756003)(316002)(26005)(4326008)(478600001)(81166006)(52116002)(81156014)(66476007)(8676002)(186003)(8936002)(2906002)(2616005)(5660300002)(66556008)(16526019)(66946007)(53546011)(16576012)(956004)(31696002)(2004002)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3080;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcFxdZ05lUR42QcMp3PDxSD5fkGnfT+dwPTgCqmhACcprIsUp3VflVGFPJBez15wuShs/V0YgUUMqTtH+CSinphXG4sDxk0+3UJZSuO1QghdYNQXyY7S1sZrAkgblhGO70LtNOyAnhAjERWH3ke010bZ4cyw1aAwSan1C6luT7NEoHkbIWIW470UTD6NIyI+FuZy5iFhrf/RAnD5UGx4U0pC0UeRTzgRcmhbehupo2Szw5vY8EzzDseQPnSeKzMIHFTMB7H2B/K4cC0yw4TPwfEopyLb3FhSVBM+EiOD2KRoiUzSYM//TVAcpvULjomkc35SmK9DweKiHPm7MfxO8odl4WoinqwyYHp31+EHp7/86h+hT74/EnViAEHHhbCvrR7xx6bUjo/z+HsG6n0e6JlTKyCjHzTeH0USClKBkw8P8qYLk1sgepsRTpZjNaX8BR8txNRAPGCfYDfiA9D3RvS+uoIoU2v0H8PO9lXEdn5euToTSK/qKesxWLJjGRAsMy/l3tU21PMmPelkHHWUIJxG/D/c+p857GoSFQIXoTSA0Y2UQ+MUQljSHgcQuuwkTPZUjGFupCWg6wPoCily+w==
X-MS-Exchange-AntiSpam-MessageData: IUgR9uriv+uAMZLyAExkbOQU5QffObs9t6RmVcnN2x7MrcXffvxsELQJPPxjr3pIo83lRv1hilOTTAme28zQYYOBUgu0b4pjtlMhfXLHbY4h2NqiKZD28STR3Kk+o6fjk4fikzJpN7sfLHBPGmkJSw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69e78f2-5636-4249-5e7d-08d7bc28d02d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 08:32:57.5321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMo9pKtnuWztcVT9kvWo7oGBeTHLSoEE9znwiJFvhMFVTh5JRU3ypNBYdRYU9JlEFp27eRK0haN54H1RMj23gUAeIA4rgfMoi+AYFgiTkQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3080
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.99
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

28.02.2020 11:23, Denis Plotnikov wrote:
>=20
>=20
> On 27.02.2020 13:29, Vladimir Sementsov-Ogievskiy wrote:
>> 27.02.2020 10:29, Denis Plotnikov wrote:
>>> The test checks fulfilling qcow2 requiriements for the compression
>>> type feature and zstd compression type operability.
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> ---
>>> =C2=A0 tests/qemu-iotests/287=C2=A0=C2=A0=C2=A0=C2=A0 | 123 +++++++++++=
++++++++++++++++++++++++++
>>> =C2=A0 tests/qemu-iotests/287.out |=C2=A0 41 +++++++++++++
>>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 3 files changed, 165 insertions(+)
>>> =C2=A0 create mode 100755 tests/qemu-iotests/287
>>> =C2=A0 create mode 100644 tests/qemu-iotests/287.out
>>>
>>> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
>>> new file mode 100755
>>> index 0000000000..41b916f690
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/287
>>> @@ -0,0 +1,123 @@
>>> +#!/usr/bin/env bash
>>> +#
>>> +# Test case for an image using zstd compression
>>> +#
>>> +# Copyright (c) 2020 Virtuozzo International GmbH
>>> +#
>>> +# This program is free software; you can redistribute it and/or modify
>>> +# it under the terms of the GNU General Public License as published by
>>> +# the Free Software Foundation; either version 2 of the License, or
>>> +# (at your option) any later version.
>>> +#
>>> +# This program is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the
>>> +# GNU General Public License for more details.
>>> +#
>>> +# You should have received a copy of the GNU General Public License
>>> +# along with this program.=C2=A0 If not, see <http://www.gnu.org/licen=
ses/>.
>>> +#
>>> +
>>> +# creator
>>> +owner=3Ddplotnikov@virtuozzo.com
>>> +
>>> +seq=3D"$(basename $0)"
>>> +echo "QA output created by $seq"
>>> +
>>> +status=3D1=C2=A0=C2=A0=C2=A0 # failure is the default!
>>> +
>>> +_cleanup()
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 _cleanup_test_img
>>> +}
>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>> +
>>> +# standard environment
>>> +. ./common.rc
>>> +. ./common.filter
>>> +
>>> +# This tests qocw2-specific low-level functionality
>>> +_supported_fmt qcow2
>>> +_supported_proto file
>>> +_supported_os Linux
>>> +
>>> +P=3D`echo "$QEMU_PROG" | sed "s/qemu-system-x86_64//"`
>>> +
>>> +grep "CONFIG_ZSTD=3Dy" "$P"../config-host.mak >/dev/null
>>> +RES=3D$?
>>
>> Hmm. This will not work for other architectures and for
>> out of tree builds. Also, it checks config but not current
>> binary (they may be out of sync, or even unrelated).
>>
>> Probably better try to create image with zstd compression type
>> and handle expected error.
> What if the error is "unable to create an image with zstd", although it h=
as to be?

With such message test should fail. I expect something like "unknown option=
" error in case of not built in zstd, and I think it's OK to check such mes=
sage and skip the test.

> I think the best way is to ask qemu binary whether it supports zstd, but =
it doesn't available by now (should be?)

And in this case the problem is the same: what if it will say that it doesn=
't support it, although it should support? We can't check such things anywa=
y.

>=20
> Is there any other way to make sure that the std compression test has to =
be executed?
>>
>>
>>> +if (($RES)); then
>>> +=C2=A0=C2=A0=C2=A0 _notrun "ZSTD is disabled in the current configurat=
ion"
>>> +fi
>>> +
>>> +# Test: when compression is zlib the incompatible is unset
>>> +echo
>>> +echo "=3D=3D=3D Testing compression type incompatible bit setting for =
zlib =3D=3D=3D"
>>> +echo
>>> +
>>> +_make_test_img 64M
>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>>> +
>>> +# Test: when compression differs from zlib the incompatible bit is set
>>> +echo
>>> +echo "=3D=3D=3D Testing compression type incompatible bit setting for =
zstd =3D=3D=3D"
>>> +echo
>>> +
>>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>>> +
>>> +# Test: an image can't be openned if compression type is zlib and
>>
>> opened
>>
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 incompatible feature compression=
 type is set
>>> +echo
>>> +echo "=3D=3D=3D Testing zlib with incompatible bit set=C2=A0 =3D=3D=3D=
"
>>> +echo
>>> +
>>> +IMGOPTS=3D'compression_type=3Dzlib' _make_test_img 64M
>>> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
>>> +# to make sure the bit was actually set
>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>>> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
>>> +if (($?=3D=3D0)); then
>>> +=C2=A0=C2=A0=C2=A0 echo "Error: The image openned successfully. The im=
age must not be openned"
>>> +fi
>>
>> may be better to instead keep error output and just check it..
> I add the explicit message to reduce the investigating time of what happe=
ned and what should it be.
> If it isn't that important I'd rather leave it as is.

of course, up to you

>>
>>> +
>>> +# Test: an image can't be openned if compression type is NOT zlib and
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 incompatible feature compression=
 type is UNSET
>>> +echo
>>> +echo "=3D=3D=3D Testing zstd with incompatible bit unset=C2=A0 =3D=3D=
=3D"
>>> +echo
>>> +
>>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>>> +$PYTHON qcow2.py "$TEST_IMG" set-header incompatible_features 0
>>> +# to make sure the bit was actually unset
>>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>>> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
>>> +if (($?=3D=3D0)); then
>>> +=C2=A0=C2=A0=C2=A0 echo "Error: The image openned successfully. The im=
age must not be openned"
>>> +fi
>>> +# Test: check compression type values
>>> +echo
>>> +echo "=3D=3D=3D Testing compression type values=C2=A0 =3D=3D=3D"
>>> +echo
>>> +# zlib=3D0
>>> +IMGOPTS=3D'compression_type=3Dzlib' _make_test_img 64M
>>> +od -j104 -N1 -An -vtu1 "$TEST_IMG"
>>> +
>>> +# zstd=3D1
>>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>>> +od -j104 -N1 -An -vtu1 "$TEST_IMG"
>>> +
>>> +# Test: using zstd compression, write to and read from an image
>>> +echo
>>> +echo "=3D=3D=3D Testing reading and writing with zstd =3D=3D=3D"
>>> +echo
>>> +
>>> +CLUSTER_SIZE=3D65536
>>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>>> +$QEMU_IO -c "write -c 0 64k " "$TEST_IMG" | _filter_qemu_io
>>> +$QEMU_IO -c "read -v 0 10 " "$TEST_IMG" | _filter_qemu_io
>>> +$QEMU_IO -c "read -v 65530 8" "$TEST_IMG" | _filter_qemu_io
>>
>> Hmm output depends on default pattern. Better use "write -c -P 0x11 0 64=
k"
>> =C2=A0(or any pattern you want), to make it explicit.
> Good suggestion, I'll change that
>>
>>> +
>>> +# success, all done
>>> +echo "*** done"
>>> +rm -f $seq.full
>>> +status=3D0
>>> diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
>>> new file mode 100644
>>> index 0000000000..4218254ce0
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/287.out
>>> @@ -0,0 +1,41 @@
>>> +QA output created by 287
>>> +
>>> +=3D=3D=3D Testing compression type incompatible bit setting for zlib =
=3D=3D=3D
>>> +
>>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>> +incompatible_features=C2=A0=C2=A0=C2=A0=C2=A0 []
>>> +
>>> +=3D=3D=3D Testing compression type incompatible bit setting for zstd =
=3D=3D=3D
>>> +
>>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 compressi=
on_type=3Dzstd
>>> +incompatible_features=C2=A0=C2=A0=C2=A0=C2=A0 [3]
>>> +
>>> +=3D=3D=3D Testing zlib with incompatible bit set=C2=A0 =3D=3D=3D
>>> +
>>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>> +incompatible_features=C2=A0=C2=A0=C2=A0=C2=A0 [3]
>>> +
>>> +=3D=3D=3D Testing zstd with incompatible bit unset=C2=A0 =3D=3D=3D
>>> +
>>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 compressi=
on_type=3Dzstd
>>> +incompatible_features=C2=A0=C2=A0=C2=A0=C2=A0 []
>>> +
>>> +=3D=3D=3D Testing compression type values=C2=A0 =3D=3D=3D
>>> +
>>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>>> +=C2=A0=C2=A0 0
>>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 compressi=
on_type=3Dzstd
>>> +=C2=A0=C2=A0 1
>>> +
>>> +=3D=3D=3D Testing reading and writing with zstd =3D=3D=3D
>>> +
>>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 compressi=
on_type=3Dzstd
>>> +wrote 65536/65536 bytes at offset 0
>>> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +00000000:=C2=A0 cd cd cd cd cd cd cd cd cd cd=C2=A0 ..........
>>> +read 10/10 bytes at offset 0
>>> +10 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +0000fffa:=C2=A0 cd cd cd cd cd cd 00 00=C2=A0 ........
>>> +read 8/8 bytes at offset 65530
>>> +8 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +*** done
>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>> index 0317667695..5edbadef40 100644
>>> --- a/tests/qemu-iotests/group
>>> +++ b/tests/qemu-iotests/group
>>> @@ -293,3 +293,4 @@
>>> =C2=A0 283 auto quick
>>> =C2=A0 284 rw
>>> =C2=A0 286 rw quick
>>> +287 auto quick
>>>
>>
>>
>=20


--=20
Best regards,
Vladimir

