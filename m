Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF61C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8498E206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Uo1c4uLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8498E206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QED-0001t2-NL
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4QDJ-0001IE-DX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j4QDI-0001Ss-DL
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:20:33 -0500
Received: from mail-eopbgr70122.outbound.protection.outlook.com
 ([40.107.7.122]:29505 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j4QDF-0001Ha-QO; Wed, 19 Feb 2020 09:20:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGmrZopb20DZ+jgDunsBY7FDurQnxG5PQVvDMwCdKIuyYdJ8zCXvyW4JAdX3GH3epBH8I3PirZnnVMKnWS1vd2219b8KqTsFbCYDVi/5rgJ4a7lOGiBCDyvmJz1af4LTUa22W3uYLG0bRTJTQ5ejKa1qgjokxrg8kuZ2CGqBOm4l5QtKj2xLrF/RTLr8nedS05t/j9CWxFHuN6GTXCtm79HRNGvDJNotJiisMyxjRmKKAetIfXI3kOMqGQTby2SSqbPJz4z5YSW94/ZYkjNacfYbmEjxKjB0+xhvx2J4Zod8TP8d/HLOA4KJz74b/362SJ0SUUCpJQjH7WVZbNszuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH9EHqkbMyWmdEt/0QwDpiMVTqyqSBq7KnKYinE5OvQ=;
 b=IEp93sw81zc3NSV1Acm+BM7sEE0B2TYXaP7omyCdmz7DYx1bOkf8VHAt6b5G41yWfA0G5wAnIpKxn93clphkUbxAp0fZn9LQAjL/8YIYj/Ch+Nyi+Erao0I05VgHSjGVlWwfPrCPkybdw85g1IHPJ/WF++dq7m1zXUgLNdDuRc6SNvbfed+WGu3KUNbvRttmEeOz08nJS8tvZlb3Ykqc7bo+Trb7di8h/FS3QhFD0/oKb2f05tqpZAqsRa3DZ6uowmy9nOycrOcZ3LXtiWPFfyMi7qhWH2xSVwqPLTqSYCfYPc9krQQPgmmoRhQa9n7i6HzOFVi/k62a9Ao1lal9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH9EHqkbMyWmdEt/0QwDpiMVTqyqSBq7KnKYinE5OvQ=;
 b=Uo1c4uLV3hN6jOx9/Gel0+9kEwURK2HQdHXxmeV/UOkNmJOiaAdyCoUhphSzWxcEqT7uGsaf3B9av5egYkTaQo9rbgRVGjRyqBZgK4MkV0GXb4OVHpC3ogUrBtlJLKm031MwESF3xO7yfxp0VQDfGa+64a+KBJInLIbVenep+Xo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5206.eurprd08.prod.outlook.com (10.255.122.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Wed, 19 Feb 2020 14:20:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 14:20:26 +0000
Subject: Re: [PATCH v2 03/22] migration/block-dirty-bitmap: rename
 dirty_bitmap_mig_cleanup
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-4-vsementsov@virtuozzo.com>
 <bbdc4dc6-d220-1b97-50e9-31dcc3459bc1@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200219172023945
Message-ID: <ca63f745-d16b-1f51-56dc-e4e3a456864e@virtuozzo.com>
Date: Wed, 19 Feb 2020 17:20:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <bbdc4dc6-d220-1b97-50e9-31dcc3459bc1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0102CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::39) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0102CA0062.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 19 Feb 2020 14:20:25 +0000
X-Tagtoolbar-Keys: D20200219172023945
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecaa8fd8-8389-4ca5-2f4e-08d7b546dd25
X-MS-TrafficTypeDiagnostic: AM6PR08MB5206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB52069A5E9C81EDF75B9CA952C1100@AM6PR08MB5206.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(346002)(376002)(136003)(199004)(189003)(66556008)(8936002)(8676002)(81166006)(66946007)(2616005)(26005)(2906002)(81156014)(36756003)(4326008)(66476007)(186003)(86362001)(956004)(31686004)(478600001)(31696002)(52116002)(6486002)(16576012)(16526019)(316002)(54906003)(53546011)(5660300002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5206;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4a/ZihQazQFWkduC3HWlilsz720IaEHJktRdfz7JPV45QorPeEGsIkVaq9OZiNaXlbqOBNd/684w2rIEK72mroSIn/qkpT6J56P/ScC5MrXS4IYXWiA8PCHczDbeCG4IVkLyaRCSs9eHLn3j0nJjHDuzhgZIEL5tsmKIl67Ze5YiTME768D+M/nQRH1nFD0GBfbwwGYOxvPWEuNsIViyduZWi07xRN4iBkluuHgLmc7xii8V3C5v6puSkDC+wxtEQxjceGFwwRMRqL9pjKbzmQ7CKGCatihHd4QG0uCV8CohTW/H5ZMQM83mmKX0RiPdjbzoVonlhAfe70kFHEz+OlVoOYGXbEE/sET8QIMuXzbcvhHrDBoTxFj+5axOjPBziIeK315ab3V46EbcHXRTR2lV7as1oD2k87qJHJIFcV6b7iLH0ZiIlSV7xskkKxU9kDxEshQTGOLK12OZEbWSamQmodx8FNTVc0JHyKf1fNux/Bm/+5t6R3Qa1dgYqfk
X-MS-Exchange-AntiSpam-MessageData: f0eFA+lluqW93D3FBQfqMHkEaQg6KctOFktGWqgcOB8H79eaptZR2EoLXw00Pfi8wd2wvokHvyL4sLTyhgyeTnY0kaeXOskM7kaZE3pUY5DwrqiLrBCYmcsxv6PV8ZL5n6dAQhGxEw0m3vWq5wAkQQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaa8fd8-8389-4ca5-2f4e-08d7b546dd25
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 14:20:26.1123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUTpuvQmyffphlSQXKs45neBPoER+2joEDidNAqbM5vZZmJIdbpmCB/BtxMObA6NJghevUbhZ4vWmY2oYQqTy5dpYIydxhr4dLmejIYpdgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5206
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.122
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

18.02.2020 14:00, Andrey Shinkevich wrote:
> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>> Rename dirty_bitmap_mig_cleanup to dirty_bitmap_do_save_cleanup, to
>> stress that it is on save part.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 migration/block-dirty-bitmap.c | 8 ++++----
>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitm=
ap.c
>> index 73792ab005..4e8959ae52 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -259,7 +259,7 @@ static void send_bitmap_bits(QEMUFile *f, SaveBitmap=
State *dbms,
>> =C2=A0 }
>> =C2=A0 /* Called with iothread lock taken.=C2=A0 */
>> -static void dirty_bitmap_mig_cleanup(void)
>> +static void dirty_bitmap_do_save_cleanup(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SaveBitmapState *dbms;
>> @@ -338,7 +338,7 @@ static int init_dirty_bitmap_migration(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 fail:
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_cleanup();
>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_do_save_cleanup();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> =C2=A0 }
>> @@ -377,7 +377,7 @@ static void bulk_phase(QEMUFile *f, bool limit)
>> =C2=A0 /* for SaveVMHandlers */
>> =C2=A0 static void dirty_bitmap_save_cleanup(void *opaque)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_cleanup();
>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_do_save_cleanup();
>> =C2=A0 }
>> =C2=A0 static int dirty_bitmap_save_iterate(QEMUFile *f, void *opaque)
>> @@ -412,7 +412,7 @@ static int dirty_bitmap_save_complete(QEMUFile *f, v=
oid *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_save_complete_finish()=
;
>> -=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_cleanup();
>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_do_save_cleanup();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>>
>=20
> At the next opportunity, I would suggest the name like
> "dirty_bitmap_do_clean_after_saving()"
> and similar for dirty_bitmap_save_cleanup()
> "dirty_bitmap_clean_after_saving()".

I'd keep my naming, it corresponds to .save_cleanup handler name.

>=20
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


--=20
Best regards,
Vladimir

