Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F0C33CA8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55435206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AelOTrA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55435206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqwN5-0005iz-Fw
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 04:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iqwM2-0004cE-GZ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iqwM0-0006VT-Nz
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:49:50 -0500
Received: from mail-eopbgr70124.outbound.protection.outlook.com
 ([40.107.7.124]:61400 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iqwM0-0006T4-3I; Mon, 13 Jan 2020 04:49:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwL5pceqf0olibJEXSboS0NfUKGY+Ha97/V5vTbEGsLafkqbVtYCc/UQZZkN0iZN3xqC/r6/kBBL8JNQfqwGtj+ryUUeQDVXO41FBiQOhs8GVuyhGkcgGx/TxEVv75SeeHmi8MTGYHs0p8xvL7+L8PCuB/ztvxrcc9t43mL5zPW/S4GASjoyvp5AEKVgJ3aFiaL91bhAJ6ZsF958NnfWz5jvuAzudjc8qbYrg+LInXGoT5unaxBhB4+n/bFKeUOVCqvs8DjZKYUwgl7OCZeNLHC9BM1wZ0hYEyeYx8q4TAsfJ6TrXjg/iN6Ci8Br2ZU7278X0n9QotCxdefk3OVdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F2exqxnmo5xu20TtkegNwjxGLPptQvlK6GaEs6HGaA=;
 b=LWNVeLxMX0unvgqnrdNqc5yQv0Wonkuo8CkTEcD+67iSY4FZ+N9nWKPxs8nFInGHXm06fZmAteke5GkGTqhFRErDI5XN+ub7uUwA8p2hlA1b1vWKFoYXEIfN0c9MROdkh8zAFyYkdV4qYHKn+32dbw/Y/Z8ez0nrBQrZwNTPPTpbvNYlaYTMo6UN7CPDpJ8h4jpbEht7oaQcoyp9GNJb9lwxgndKUrSNspXssAH95RpzKXL96mYoo2cBf4kJUMMqQMDsDNcIlMR81G/oIRc4LXsK3NiFsdH6q0a+seBbKvQAqNo9Tvp5Rukm9dRmNWEufl3ApAYlEXpVU0pRPxbRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F2exqxnmo5xu20TtkegNwjxGLPptQvlK6GaEs6HGaA=;
 b=AelOTrA8feoRTGgvJ0WcWppwBf/6zXOIrRS1JZC3nlbRuG5kFEy2gEix7OYwA1SI0TQ0O5Htt+RxtoVK/Yeszlo204jjBWUgeFz+IjFqQrXlt65v1r8EhB2xQbPq0b6O/IRwl8lG4KSQ96iyw9FbqpzZpyDqmsBq0vI406u1shg=
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5190.eurprd08.prod.outlook.com (10.255.121.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 09:49:45 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 09:49:44 +0000
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0225.eurprd05.prod.outlook.com (2603:10a6:3:fa::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 09:49:44 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 1/2] qcow2: introduce Qcow2Metadata structure
Thread-Topic: [PATCH 1/2] qcow2: introduce Qcow2Metadata structure
Thread-Index: AQHVvKr42CF6/IuWt0KYom51XTtZFqff1E+AgAif6QA=
Date: Mon, 13 Jan 2020 09:49:44 +0000
Message-ID: <e322d993-dbbd-ba53-b012-043b9a2bd1c8@virtuozzo.com>
References: <1577447039-400109-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1577447039-400109-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <534be317-976c-56c8-ee27-7031b40acc85@redhat.com>
In-Reply-To: <534be317-976c-56c8-ee27-7031b40acc85@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0225.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::25) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 531dc536-d37b-4bf6-8505-08d7980deb5d
x-ms-traffictypediagnostic: AM6PR08MB5190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB51909005BE46092CFACAFBEAF4350@AM6PR08MB5190.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39840400004)(366004)(136003)(396003)(199004)(189003)(16576012)(71200400001)(478600001)(107886003)(66946007)(316002)(186003)(26005)(110136005)(16526019)(66476007)(66556008)(66446008)(54906003)(44832011)(64756008)(81156014)(81166006)(8676002)(2616005)(956004)(31686004)(2906002)(4326008)(86362001)(5660300002)(8936002)(31696002)(6486002)(36756003)(53546011)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5190;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jo6H7C//7v3t79NOzeT+X51Cp2AsDu1r/EHTcNPhRlJH7Fv3CiZEmzxzrTxzDEWAJO+T5gy/8oR46/B30CQ/CZIdxUrHltfnHhyS++ij0lWs11SI3M3qixgoLni7Zp4WcaAE+QlAOOsopWfAJSMAdhUDUUE1PfUp55ZW39BLhplPCRnAzoqGct9JPoCCak7eVxPD8DX0q0qgcmEB5dYugjTgHrgG36DYBw7tYYyFsvxUtt1wBIwQmiX0qOu4ddTlaK5aHGCDxuau7yotZuGcuxLyY8ATkhzhXjg6lo8SsF7QLzETjnrUKP01e0Z6YTl/80dmXNjQwEfVxODLUhlWiVBzGKiRLYk6kHOi+WNeh5VCN1PDg+IIH9Qrf7RFhbnznmoyxplkvetgzsTx3psQ4AA5f9DWXO8jCRbno0vjV1Zw/Hs5pFGHRlZqC6910+8d
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5F424C709A6FC6408CB75A60454F97BC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531dc536-d37b-4bf6-8505-08d7980deb5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 09:49:44.8185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B6bOwDNbRbh9UPtMljVzl+9GzUTGjnOhPhD+ogPvdKua3fdXwbDFSIcTmauT/+jt1CueUJX+5J75zfzGsBMTdrdKsD2XjhiA+5zdZSYIOxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5190
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.124
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 08/01/2020 01:07, Eric Blake wrote:
> On 12/27/19 5:43 AM, Andrey Shinkevich wrote:
>> The preliminary patch to provide an extendable structure for dumping
>> QCOW2 metadata allocations in image.
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>> =A0 qapi/block-core.json | 208=20
>> ++++++++++++++++++++++++++++++++++++++++++++++++++-
>> =A0 1 file changed, 207 insertions(+), 1 deletion(-)
>>
>=20
>> +
>> +##
>> +# @Qcow2BitmapTbl:
>> +#
>=20
> Any reason we must abbreviate instead of spelling this out as Table?
>=20

Thank you Eric for your comments. The reason for the abbreviation is=20
that the name 'Qcow2BitmapTable' is in conflict with the existing=20
structure name in block/qcow2-bitmap.c. I can rename it to=20
'Qcow2BitmapTableInfo'


>> +# QCOW2 bitmap table information
>> +#
>> +# @table-entries: list of bitmap table entries
>> +#
>> +# @location: bitmap table offset and size in image
>> +#
>> +# Since: 5.0
>> +##
>> +{ 'struct': 'Qcow2BitmapTbl',
>> +=A0 'data': {'table-entries': ['Qcow2BitmapTblEntry'],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'location': 'Qcow2Allocation' } }
>> +
>> +##
>> +# @Qcow2BitmapTblEntry:
>=20
> Similar question
>=20

and to 'Qcow2BitmapTableInfoEntry' here.

>=20
>> +{ 'struct': 'Qcow2BitmapTblEntry',
>> +=A0 'data': {'type': 'Qcow2BitmapTblEntryType',
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '*cluster': 'Qcow2Allocation' } }
>> +
>> +##
>> +# @Qcow2BitmapTblEntryType:
>> +#
>> +# An enumeration of cluster types in bitmap table
>> +#
>> +# @all-zeros: cluster should be read as all zeros
>=20
> While there are multiple 'zeros' in the code base, 'zeroes' appears to=20
> be the more common spelling.
>=20
>=20
>> @@ -215,6 +418,8 @@
>> =A0 #=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
field is present if the driver for the image=20
>> format
>> =A0 #=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
supports it
>> =A0 #
>> +# @viscera: encapsulates QCOW2 tables allocation information
>=20
> Missing a '(since 5.0)' tag.=A0 Interesting choice of name; not one I=20
> would have picked out of the air.=A0 Would 'metadata' be any more of a=20
> reasonable name?
>=20
>> +#
>> =A0 # Since: 1.4
>> =A0 #
>> =A0 ##
>> @@ -223,7 +428,8 @@
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '*image-end-offset': 'int', '*corru=
ptions': 'int',=20
>> '*leaks': 'int',
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '*corruptions-fixed': 'int', '*leak=
s-fixed': 'int',
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '*total-clusters': 'int', '*allocat=
ed-clusters': 'int',
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '*fragmented-clusters': 'int', '*compres=
sed-clusters':=20
>> 'int' } }
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '*fragmented-clusters': 'int', '*compres=
sed-clusters': 'int',
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '*viscera': 'Qcow2Metadata' } }
>=20
> The field is listed as optional, but the docs don't describe what=20
> controls whether it is present or absent.=A0 Is that worth adding?
>=20
>=20

--=20
With the best regards,
Andrey Shinkevich


