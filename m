Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA06C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EAA2086A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KNLZzcQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EAA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybrB-0004on-KW
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iybqR-0004L7-5G
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iybqP-0004q3-Mj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:32:54 -0500
Received: from mail-db8eur05on2139.outbound.protection.outlook.com
 ([40.107.20.139]:62144 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iybqO-0004kY-W3; Mon, 03 Feb 2020 08:32:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsLbOfZPmGrVe+GE2jMXPCjhMAhm04XZ6QYv6AXieE3wxxge7Oob7WYgO26639kwdQE54uONqBaNRsW3PsIokmJaygoY/XA8SvAQWJX6TIq7q/svu8NaYAL/PfSuqD2HHtNr+AM7TQV8ldOgT/Hjw9UfMBb87hDRcaCyV28mqMOZn6tJd2rN8p1xByUntkaVF8DCCDXjM6ZKQGT4Edo1Q/gJ5QL5oKWqVcI3HA+Es6PyiIpZ67XMCgfDZEYvhrf5k8h1OtNGyjmmdfuyepDLjmMlhrS4romGzwyU/5R8jfoY6vwhyWHrgoiZ3Hfq986lHs5mPdpeO+aPcwCkM2s3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ojigzsq6WMBeGNdfbrY1zAd6VHPTZKhTDGJoC7ssxow=;
 b=jHQ4HwA5fsHq6DHIQO3IuzCAMcr5iW6MzOAFalfgtGz0r/RQyz8PloOA5pYGC3I0Xt6D2Y9CnC29EWHCsV+AKatznDNhTmBGGA2pGlyMMyI4GcimGxWHXfEZdLX0/HrD0DTvj6+M/Ci33tyS6B479l6CuEJ2/zJo8RbUBwdm0Si7nFFVYOazvH5at1oXbfyZp7YfIugXiW06as5P448aHEY6jSBEpV+E4wqby+CPrBnZAfEGpNUblSX4A+OK84BEq2Su6PSGXcjfhKrrwooPH1hZlNqiq8IEBOS2qLzh5EGftzSuLCehwNvRK9Wbh94Nm++3hV6UQneRoMScCu+5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ojigzsq6WMBeGNdfbrY1zAd6VHPTZKhTDGJoC7ssxow=;
 b=KNLZzcQmgcJjwIdKZEQxbAG59s0DPyIeNr043gzWGWRa5O8+HmAjIsOe1mVIaQ9LCr0DqIk8/gVPJz2C7JOGopIA09rLgq82ekTxsrFLL5gRai/ZVFtftmpWV9OyXog1864TMO1SWU8EVra9cZqm0/4ogWw4HYVJ0qxRQ7Wk/Kw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3413.eurprd08.prod.outlook.com (20.177.113.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 13:32:49 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 13:32:49 +0000
Subject: Re: [PATCH] block/backup-top: fix flags handling
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200131184805.7033-1-vsementsov@virtuozzo.com>
 <f442ed27-044e-f293-8955-74798b581ab4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200203163246841
Message-ID: <a89e1c7b-0376-7168-5fe6-4ce5a878ef04@virtuozzo.com>
Date: Mon, 3 Feb 2020 16:32:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <f442ed27-044e-f293-8955-74798b581ab4@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::26)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29 via Frontend Transport; Mon, 3 Feb 2020 13:32:48 +0000
X-Tagtoolbar-Keys: D20200203163246841
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b37c71ae-e59e-4d74-2a3f-08d7a8ad8fe5
X-MS-TrafficTypeDiagnostic: AM6PR08MB3413:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3413C36FC43F3FBEDAA900B6C1000@AM6PR08MB3413.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(376002)(39850400004)(366004)(199004)(189003)(4326008)(478600001)(31686004)(81156014)(2616005)(956004)(81166006)(8676002)(16576012)(316002)(6486002)(66476007)(66556008)(52116002)(53546011)(31696002)(186003)(16526019)(86362001)(5660300002)(26005)(36756003)(8936002)(66946007)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3413;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xUWyaFQLTRfFRuX9DFB6K3LzXFdwBKg7z49ncOnkfJYf4Lf00IX402aN9KJVbyjmn8aUkisiggd0Q/BmEw7PYitsocZwIgeeD+S+J9LK5XIpDmSbMXTsMzyHxrxWyKt7JJU0AfdzqQLpmyi183G40ohhBVMRuesnDJW9MusY/JUi2givV0/E+6YxlYTmz0ETqKH5lWbuyDIPqucp7y3uDVvKj+NsJbGsVrOt0QdEbBVOMaSfUws52ry6BijohnsqMeVIOqVbplhO8wDleMT3QCkewxxaDQmXSzObS4jgQO7mgcbtnEfYK1b/TffjfstndJKtW7fmNjuz0nQtUwcXm9K0V1xmRjPAOUgtCKnbZWnYcCPEFFNIuQp9+lv+9MThKNhlXnOaNy1Am3MYmv8mroSdlhGgme6pTdgLUwMsMNqS/c10KuVkgEyplVa4PsWP
X-MS-Exchange-AntiSpam-MessageData: m5m8gatsm9KWWW5jQfnUzuB2kBkUuaVZ9cpYCnlNDkoPvzMiaA0eqiO6zSszyz12ewurjpnEDcV+yp1MiTUHJLvrGZfMH308uC3FdSkwggnihlYw0HQckk2xTtbbdT21xA6x9lwI/u0VRATXBEGmag==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37c71ae-e59e-4d74-2a3f-08d7a8ad8fe5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 13:32:49.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyLo2xvapkNr9xjil6lloFUdwTlakHHSfD95HXEfLY2f/sW48AVpsYuN//Icw+e0988uLy32YsTZQ8fFZP+nRrlNnRId+myoGb783XIizVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3413
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.139
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 22:38, Eric Blake wrote:
> On 1/31/20 12:48 PM, Vladimir Sementsov-Ogievskiy wrote:
>> backup-top "supports" write-unchanged, by skipping CBW operation in
>> backup_top_co_pwritev. But it forgets to do the same in
>> backup_top_co_pwrite_zeroes, as well as declare support for
>> BDRV_REQ_WRITE_UNCHANGED.
>>
>> Fix this, and, while being here, declare also support for flags
>> supported by source child.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =A0 block/backup-top.c | 28 ++++++++++++++++++----------
>> =A0 1 file changed, 18 insertions(+), 10 deletions(-)
>=20
>=20
>> @@ -197,6 +201,10 @@ BlockDriverState *bdrv_backup_top_append(BlockDrive=
rState *source,
>> =A0=A0=A0=A0=A0 top->total_sectors =3D source->total_sectors;
>> =A0=A0=A0=A0=A0 state =3D top->opaque;
>> +=A0=A0=A0 top->supported_write_flags =3D
>> +=A0=A0=A0=A0=A0=A0=A0 BDRV_REQ_WRITE_UNCHANGED | source->supported_writ=
e_flags;
>> +=A0=A0=A0 top->supported_zero_flags =3D
>> +=A0=A0=A0=A0=A0=A0=A0 BDRV_REQ_WRITE_UNCHANGED | source->supported_zero=
_flags;
>=20
> Elsewhere, in block/filter-compress.c we do:
>=20
>  =A0=A0=A0 bs->supported_write_flags =3D BDRV_REQ_WRITE_UNCHANGED |
>  =A0=A0=A0=A0=A0=A0=A0 (BDRV_REQ_FUA & bs->file->bs->supported_write_flag=
s);
>=20
>  =A0=A0=A0 bs->supported_zero_flags =3D BDRV_REQ_WRITE_UNCHANGED |
>  =A0=A0=A0=A0=A0=A0=A0 ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_=
FALLBACK) &
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bs->file->bs->supported_zero_flags);
>=20

I've looked at this too, but didn't understand, why we need it. Now with yo=
ur description, I see that this make sense. I'll resend with same pattern, =
thanks.

> That's slightly more robust (if the block layer adds new BDRV_REQ_ bits, =
we don't have to revisit filter-compress.c to decide if blindly exposing th=
ose bits breaks for some reason, but rahter DO have to amend the line to op=
t-in to supporting the new bits).=A0 Whereas your code does NOT need editin=
g if passing on the new bit is safe, but risks a subtle breakage if we forg=
et to filter out the new bit when passing it on would be unsafe.=A0 I tend =
to lean towards safety and opt-in over blind pass-through that works with t=
he current set of defined bits, but not enough to withhold:
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20


--=20
Best regards,
Vladimir

