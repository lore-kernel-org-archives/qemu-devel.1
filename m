Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D47C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BAD206F5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EFyYI7sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BAD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJXbD-0001Jz-WC
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 03:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJXZg-0000W1-85
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jJXZe-0006Fh-UB
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:14:08 -0400
Received: from mail-eopbgr00129.outbound.protection.outlook.com
 ([40.107.0.129]:34051 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jJXZb-0005fo-01; Wed, 01 Apr 2020 03:14:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7JhPuKV98/6eRP94bJDW71LHHFhPl+wwwa8KqDy7nzmZwheu99Lf9kCl6eAC/JrY34QvhDAaq1EtiA2hBLpSmOA4FdIurLFXojoUeeBJlMbbQ/g6+YL8fK0Vow+sCAD7zuSjwfV95MWsZr6IHSSkYpFYuUoH+8NXlxWyt/CuSPmH1cYo9UId2hcIbGu3xBs9iTAYjoBALavLscbO6PBaK99TnPg1eqmhHMAHpGVTZypVcNTCihxNfRkjxHgfPH0TksN+cz+0/6IgLtP9rqSw5/u6VYpPeGmf9sGlvGh3oE8hGlCUPXLqQsVWfbCMSamuQ66Mk8op25YW9x0Cw+CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBr0yUFJ2XGuwjX0WjpmC9TU+TmRF91w849WPEWZecM=;
 b=LIfDqHsbktszjTWqapbmq0bgnQOH4Ie5ggsFnCWU8J38Ep8d4KJhZ89XfBGneeJK7ipA+43p4DjLhBXZ6dMa0DbTZQkGH9jLq3o1n2Lyvs2GuXW1JFYXmZOV1ED4HeIz2UyBdIIY34xu+RYL2Vj/FkRyyxBXStVDAirOuMLPBmLJwSsjTUrY9x2XSDGvv7NnyQffwQaJGUgXOaf8USByYDsWDYvoAA3aZzYFTLPSzUyrib3eJcIGMuuYvv7nN6Tprba7kiDDhs1rN5HyvaXe4TuMSKcd1xchlP7gaLZcDAvNLAmS9tbY0nJiNCo6aiPLmdoxD2HmewasKyUoyLyt0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBr0yUFJ2XGuwjX0WjpmC9TU+TmRF91w849WPEWZecM=;
 b=EFyYI7srj5+nn3tvQ7XaGQdjxsAaIwfYleu57YOKSBupn/6185xXtz3irpYmrlPjyKd370q2aDFafDtrRnA25Zlpd1TDuKu1SM6K/bpYOX6cBe2CDFvXhgoHtWniCUibp+WphjxSOnLDDBjU1wgrTEiO4fjtt46LkeL7bmUSTnw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4227.eurprd08.prod.outlook.com (20.179.33.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 07:14:00 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 07:14:00 +0000
Subject: Re: [PATCH v14 4/4] iotests: 287: add qcow2 compression type test
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200331174455.31792-1-dplotnikov@virtuozzo.com>
 <20200331174455.31792-5-dplotnikov@virtuozzo.com>
 <bebbcc59-9392-9461-7976-5ab3367df3a2@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <b8af61a4-9487-7b6f-d01c-b54083c37b76@virtuozzo.com>
Date: Wed, 1 Apr 2020 10:13:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <bebbcc59-9392-9461-7976-5ab3367df3a2@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.150.115) by
 FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 07:13:59 +0000
X-Originating-IP: [178.34.150.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c5be342-8a4c-40bf-f233-08d7d60c4038
X-MS-TrafficTypeDiagnostic: AM0PR08MB4227:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4227960204C75109A93D4F32CFC90@AM0PR08MB4227.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(346002)(39840400004)(316002)(5660300002)(16576012)(31696002)(86362001)(26005)(66946007)(66476007)(956004)(2616005)(31686004)(186003)(66556008)(16526019)(52116002)(8676002)(4326008)(8936002)(478600001)(2906002)(6486002)(81156014)(36756003)(6666004)(81166006)(107886003)(53546011);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f228oI9Emanvi4C/XlN4tV84Rt7MtcsbftqHgD9WyCa/Ie8CilxMYj6OqwDu+DesF3n3Qw/vW/JN8kU4m/ihmRovOYdKDnkuzOHU3I1kvLkC0EfDKDJNfEoU7iaOd0lKwj2UIAF3SwuZJpgDgcbpX0p45RoJgzuWm57tGxjxv4cAFbvKrD9ii+G1XbfbLop5HesUh6rn8P3GhGQZj6lPsvfEaqSLW2zfeViAoftQe5w4cBSMeu87DF65m65eoxBJyvn0lrhAMNLW5ToBjvvV/Ti054j9YRfSBoIe5isPXeGeng2+rMk4VXP4HGzS1M0XlTTm7ZK0+mae+siw92jN46BHo3mLAoU7WhaUYm6mt+1VrhJ4bZIbHnzeKWiEljBH+GOdX7o9O6rvZX1DPzhlNzpknTcpBdU2ZuTKlkSasGqsFZ7326VxiDJDPbEpRMFY
X-MS-Exchange-AntiSpam-MessageData: AMQ+GhqckBNAqjeOzZHTmZJJl/5WwvYdHsakkSy9BS/JEvvsmJuqkgXzdrGfTNlIvOQra4bEexI4nkrY214Bx3LLPAgZJPuIgOJ6bYM343s8pSLGOWsqcRcjfI7l2oBZLx9BocLi9FzILLI9xW1I9Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5be342-8a4c-40bf-f233-08d7d60c4038
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 07:14:00.3259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFKa+eNF0dCWxxp65Ez0KNSu4panhxKx/bwBMEfc9J91NpIpkR5czPLuPx7ZOnYIZ+8tsNdtwvSzG1lScBXUd88eh2evzImOSaiMapg7dU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4227
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.0.129
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
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 31.03.2020 21:43, Eric Blake wrote:
> On 3/31/20 12:44 PM, Denis Plotnikov wrote:
>> The test checks fulfilling qcow2 requiriements for the compression
>> type feature and zstd compression type operability.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 tests/qemu-iotests/287=A0=A0=A0=A0 | 128 +++++++++++++++++++++++++++=
++++++++++
>> =A0 tests/qemu-iotests/287.out |=A0 43 +++++++++++++
>> =A0 tests/qemu-iotests/group=A0=A0 |=A0=A0 1 +
>> =A0 3 files changed, 172 insertions(+)
>> =A0 create mode 100755 tests/qemu-iotests/287
>> =A0 create mode 100644 tests/qemu-iotests/287.out
>>
>
>> +
>> +# Check if we can run this test.
>> +
>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M | grep "Invalid=
=20
>> parameter 'zstd'" 2>&1 1>/dev/null
>> +
>> +ZSTD_SUPPORTED=3D$?
>> +
>> +if (($ZSTD_SUPPORTED=3D=3D0)); then
>
> This is a bash script, so (()) works; but the bash manual documents=20
> that (()) is not idiomatic.=A0 Also, what you have is rather verbose...
>
>> +=A0=A0=A0 _notrun "ZSTD is disabled"
>> +fi
>
> ...I might have written:
>
> if IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M |
> =A0=A0=A0 grep "Invalid parameter 'zstd'"; then
> =A0=A0=A0 _notrun "ZSTD is disabled"
> fi
yes, this on is shorter
>
>
>> +# Test: an image can't be openned if compression type is zlib and
>
> opened
>
>> +#=A0=A0=A0=A0=A0=A0 incompatible feature compression type is set
>> +echo
>> +echo "=3D=3D=3D Testing zlib with incompatible bit set=A0 =3D=3D=3D"
>> +echo
>> +
>> +IMGOPTS=3D'compression_type=3Dzlib' _make_test_img 64M
>> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
>> +# to make sure the bit was actually set
>> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
>> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
>> +if (($?=3D=3D0)); then
>> +=A0=A0=A0 echo "Error: The image openned successfully. The image must n=
ot=20
>> be openned"
>
> twice more
>
>> +fi
>> +
>> +# Test: an image can't be openned if compression type is NOT zlib and
>
> and again.=A0 Multiple spots in the file, I'll quit pointing them out.
>
>> +#=A0=A0=A0=A0=A0=A0 incompatible feature compression type is UNSET
>> +echo
>> +echo "=3D=3D=3D Testing zstd with incompatible bit unset=A0 =3D=3D=3D"
>
> Why the double space?
>
>> +# Test: using zstd compression, write to and read from an image
>> +echo
>> +echo "=3D=3D=3D Testing reading and writing with zstd =3D=3D=3D"
>> +echo
>> +
>> +IMGOPTS=3D'compression_type=3Dzstd' _make_test_img 64M
>> +$QEMU_IO -c "write -c -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io
>
> That's only one cluster.=A0 Wouldn't it be better to write more than=20
> one, to prove that we handle back-to-back compressed clusters=20
> resulting from back-to-back inputs?
I'll add a case for back-to-back compressed clusters
>
>
>> +$QEMU_IO -c "read -P 0xAC 65536 65536 " "$TEST_IMG" | _filter_qemu_io
>
> And if you do compress more than one cluster, you may also want to use=20
> different patterns over those various clusters.
>
>> +$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
>> +$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
>> +
>> +# success, all done
>> +echo "*** done"
>
> Is it also worth trying to generate an image with (pseudo-)random=20
> contents, and trying qemu-img convert to prove that uncompressable=20
> clusters are handled sanely?=A0 Ideally, there would be a way to use a=20
> fixed PRNG and seed that produces a deterministic sequence that cannot=20
> be compressed, but even if we can't meet the ideal, having a test that=20
> non-deterministically is likely to generate an uncompressable cluster=20
> in most runs is better than nothing (such as 1M of data copied from=20
> /dev/urandom, then qemu-img convert on that data).
And, I'll try to add a case for incompressible data.

Thanks

