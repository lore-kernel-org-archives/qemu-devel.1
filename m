Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB76EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 12:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30FB20848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 12:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YXMBvDHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30FB20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9TQx-0003Fw-VX
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 07:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j9TQ0-0002dM-RW
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 07:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j9TPz-0008IK-LF
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 07:46:32 -0500
Received: from mail-am6eur05on2131.outbound.protection.outlook.com
 ([40.107.22.131]:38426 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j9TPv-0008C0-Up; Wed, 04 Mar 2020 07:46:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQkU5NFYKs6PkSV3FUo/edqY6CYICq79X0IpeB5naBVkzWQLR/CIB3M6sbuBHjGrWZo8DmCaR4nHyPWPkogZXJ+YDY4d4ce5LHvQcIOSDd6rQf7WsgySJT46fDAByEkVPhI8bH+2UpLgsHyjcG3LaRxdzSaKX4p0uzlVD8znzUmLeDcQvKxAUjCcvVef8qSRjohHRsG0HIyQyFgJPgjdu3vqTOthQcuGBtxnrowcVRd8iR1z+6x56K+PKv7FS0j05unBrx2MRnA+44QlLo15jUM3JldHIe32RrOHftdasVLWNg7a6ZhhZzyI0jWEoNj0RBxkUpPz0f8uL8h70E7z6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dkb1Qf1LkKhBugzY+wkjfBtzCP8We9riVQFZtUC90Y=;
 b=XPNrLnIHIOfkcQP28GTU2JRxC+b3F+SydxPQJC8WWDbggbRgHGBS5tZ0IWJRDJwOcAH4+kF9GjvyC6YyTVlt174nycUD8+1uPIOvFBcYiKX1LOMRrCq3See57wxaFaE9gFZIhSZPhHAx2FpjzfA/MiinE8ysybHVivc8T4qq7K9sbOyD2xgiY1QMOXD+Fa8vgycuDgV6qZshm54i+vwxKq3uUpzSkkdmPmvPguLp8VOpZETuQwXncnrLJzHdyBuqXU1or1nAgg+WqhSHi+VcOcLmg0jRaGMq+iQTG4WloNcIXM23jFrGb3kzFyZKqKjJuBsGNl4Pc8niu9IjLUsOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dkb1Qf1LkKhBugzY+wkjfBtzCP8We9riVQFZtUC90Y=;
 b=YXMBvDHtJIZ7ZzCtLNN7y9sAw7/akuiP4MetIHn/4Tlf/3gs4CcsPLCkg0vZD2tlSDFLCjGdAReL5NWq5lU4AJDZCTYcY6XMAf8Nz/MTQRlNyibGiAUw1ljPcOMyIb7YnAaB0KP8+6b6i/JOy2eewbRgDmB3UMTF0Krv4PpfRlo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4404.eurprd08.prod.outlook.com (20.179.32.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 12:46:24 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::9875:c099:713b:8219%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 12:46:24 +0000
Subject: Re: [PATCH v4 4/5] qcow2: add zstd cluster compression
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200303133425.24471-1-dplotnikov@virtuozzo.com>
 <20200303133425.24471-5-dplotnikov@virtuozzo.com>
 <3cbc685e-f606-daab-6dab-84e8fb80662e@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <f63d342b-9987-bf3b-58db-46e8ee39267a@virtuozzo.com>
Date: Wed, 4 Mar 2020 15:46:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <3cbc685e-f606-daab-6dab-84e8fb80662e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR0401CA0074.eurprd04.prod.outlook.com
 (2603:10a6:3:19::42) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.233.241.117) by
 HE1PR0401CA0074.eurprd04.prod.outlook.com (2603:10a6:3:19::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 12:46:23 +0000
X-Originating-IP: [94.233.241.117]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58dddeb6-9691-44ba-f64c-08d7c03a0c27
X-MS-TrafficTypeDiagnostic: AM0PR08MB4404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4404042B6E3887CD5E2ECA92CFE50@AM0PR08MB4404.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(136003)(39850400004)(396003)(189003)(199004)(81166006)(81156014)(8676002)(5660300002)(8936002)(16526019)(6486002)(2906002)(316002)(186003)(16576012)(52116002)(2616005)(53546011)(956004)(66946007)(478600001)(31696002)(4326008)(66556008)(36756003)(86362001)(31686004)(66476007)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4404;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNXHykl83PPvby7Ns3XOEHrmbL5bFs2HzwpfNa8bDSFAW94B8tylIf3oI2Y0yZjMDphqsIWggyGQkg1o1HW/7ByYuv+JZ5dLDQMA+C0KjwbIYAi66QOm5WZWWePN6oteFrVI/FbZJsmsgpAooy6AAjLt88ioLOZmT7bHWus69Q8c0UL/QtG5Tu6x4I1RocHbqa9GuTPWqFLRMNBWZd3EFaXSuX/BkUJvMIwLu3U199rd6eVVSvatDNNeP6FZVxc9OlwQu4r6wa57cRCyGdrJgshczVvjmzXnDSIt5O7TZWwWVbOmbPfDdevNN5d1nAzQ/EYLZ+WC5sT0E9vvtksxhyxBrLrEOKrm1SFp/1b1/1EDo7GmxPtdw3Jeh5QRK8nkveHvYjR8WJJ1B73ddedlAfjJ3Hgm36eMlH88hIiE1ty1/bYdfCReE3uUqPUoxLTs
X-MS-Exchange-AntiSpam-MessageData: eRX36JmqE4CnFb96OBcv+OVOqIaTFj6X4qzPF5qgh5eXsFL7NG9M6sIuqUgRd7kELOCGp6+KnLqIHDHfunM98oQ8WQxWPNrMLX2M7x5l5Cabyla8z5GMxs9vO9rb/37oghtvEL7TFwiv8CvzLL7oyA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dddeb6-9691-44ba-f64c-08d7c03a0c27
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 12:46:24.2145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+sEdK4xB12uuTZzFJVnL1nCZHv1P5fVFJ9hJyGNL74Hs2TCgHLUvl4l5g0uAMMWRQRFakDW2cGJo7FzCL+jzoX1id/yPWJxguxMNiyDWh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4404
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.131
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



On 04.03.2020 10:49, Vladimir Sementsov-Ogievskiy wrote:
> 03.03.2020 16:34, Denis Plotnikov wrote:
>> zstd significantly reduces cluster compression time.
>> It provides better compression performance maintaining
>> the same level of the compression ratio in comparison with
>> zlib, which, at the moment, is the only compression
>> method available.
>>
>> The performance test results:
>> Test compresses and decompresses qemu qcow2 image with just
>> installed rhel-7.6 guest.
>> Image cluster size: 64K. Image on disk size: 2.2G
>>
>> The test was conducted with brd disk to reduce the influence
>> of disk subsystem to the test results.
>> The results is given in seconds.
>>
>> compress cmd:
>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2 -c -o compression_type=3D[=
zlib|zstd]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src.img [zlib|zstd]_compressed.img
>> decompress cmd
>> =C2=A0=C2=A0 time ./qemu-img convert -O qcow2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [zlib|zstd]_compressed.img uncompresse=
d.img
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compr=
ession=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 decompression
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 zlib=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zstd
>> ------------------------------------------------------------
>> real=C2=A0=C2=A0=C2=A0=C2=A0 65.5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16=
.3 (-75 %)=C2=A0=C2=A0=C2=A0 1.9=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1.6 (-16 %)
>> user=C2=A0=C2=A0=C2=A0=C2=A0 65.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15=
.8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.3=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.5
>> sys=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0.2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2.0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.0
>>
>> Both ZLIB and ZSTD gave the same compression ratio: 1.57
>> compressed image size in both cases: 1.4G
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>
> [..]
>
>> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *sr=
c, size_t src_size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 size_t ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * steal ZSTD_LEN_BUF bytes in the very beginni=
ng of the buffer
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * to store compressed chunk size
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 char *d_buf =3D ((char *) dest) + ZSTD_LEN_BUF;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * sanity check that we can store the compresse=
d data length,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * and there is some space left for the compres=
sor buffer
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (dest_size <=3D ZSTD_LEN_BUF) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 dest_size -=3D ZSTD_LEN_BUF;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D ZSTD_compress(d_buf, dest_size, src, src_siz=
e, 5);
>
> You may want to define ZSTD_COMPRESSION_LEVEL constant instead of raw=20
> number.
I didn't introduce it intentionally. zlib compression has the=20
compression level hardcoded as well.
I think it's better to introduce the compression level for both of them=20
in the future but not in the scope of this series.
> anyway,
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
>
>
>


