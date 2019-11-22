Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AE9C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E163120704
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ac5qbiew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E163120704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7G0-0000pg-WA
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iY7Eq-0008Vq-8r
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iY7Eo-0007d6-OA
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:36:35 -0500
Received: from mail-db5eur03on0710.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::710]:58849
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iY7Eo-0007cS-3a; Fri, 22 Nov 2019 06:36:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsZ7Lne33Yoh5yrHRAmqgteTgSQwfBLqNN7O1tXsrp72PaTqRRA5WEpWdyfPUbz5rgbUJ1rMKIFRWr/6nWdvdzxUHz9J1OJJJX4ch+GJh1XRU7noTzoefcSZ2IP1FZ+Yv4DcDYZ/s0B9nqx4PkeYy0s2oMV26fHO0GrGNX79sLSc2Jf7DqVtnwxv5lgfJUkUph59izncP8QguK8kwPlJFgKGCp9NK2lJW5jJZ9q8KneaiKkon1neTcot9RPJWPztlX5zyEuW9dIHAnpXwUwXme/CeFdjXBmOaIrg7OnMHR5+qLnkkkbOvkqcRq0lwR8GeuCJJzpTNNo2mdolTtZXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ8r4owcMHfEaPsFc0r/m+iEsO1P4iTyCPC4gRqSOvk=;
 b=k89RKKU4jhexRp6qHrU4M90RdyA3CQvxLXzuNjW915pVlGmlTlUQ0TAYXaFSl7+Q8YYrsh1GnWFqdrSc6AqjGnUXfsZ4jptICV0fgfhVoV+ULeOAoDu22q1qiTVpGKc8Ql0ioJNKnkydGqm3Hwo60w55+w5QTlRHceMA23sl5ZcVxKfz8JrnJlugS3AJl131oj8ypuR5Vnt476mca++2i0BsXfJzTP65+o0cdvpgoWUvOx6dnoA9QfPVs3mNzcRiF5nTh8iKzXHDqAEEsXRllJCEtgZzCJthhk85rs5q769yFa0thb5sWZJfXZ5uNUGowkGVFT6gsHKaFhYeAYupIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ8r4owcMHfEaPsFc0r/m+iEsO1P4iTyCPC4gRqSOvk=;
 b=Ac5qbiewM6hnsaWs3bzxbVPKNsuvU4c9UTx4+OnzJau3wQ7B1TkVmZkwFDxbOPrAhPwDUB6s1eRxg/yHn0qPcao+COmn3V3nBPvbdPHRzu3MFwiIpRTMX3MoIVhv3VHghuslAe7JFuA4DNNnYoE9BOgfUhAEYB6EcdQnAHbt40s=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4066.eurprd08.prod.outlook.com (20.178.117.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Fri, 22 Nov 2019 11:36:30 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12%4]) with mapi id 15.20.2474.021; Fri, 22 Nov 2019
 11:36:30 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v0 1/2] qdev-properties-system: extend set_pionter for
 unrealized devices
Thread-Topic: [PATCH v0 1/2] qdev-properties-system: extend set_pionter for
 unrealized devices
Thread-Index: AQHVl/nxDteiAUIJXEyH6anabhWATqeRU16AgAXO1YA=
Date: Fri, 22 Nov 2019 11:36:30 +0000
Message-ID: <d5d3ac62-4f46-08d6-bf66-620e410fa954@virtuozzo.com>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-2-dplotnikov@virtuozzo.com>
 <20191118185453.GC3812@habkost.net>
In-Reply-To: <20191118185453.GC3812@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::23) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.34.161.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fee97608-a8e5-4f79-5af8-08d76f4037e4
x-ms-traffictypediagnostic: AM0PR08MB4066:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4066FF2AED21B065A5AE18B5CF490@AM0PR08MB4066.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(39850400004)(396003)(189003)(199004)(86362001)(52116002)(478600001)(386003)(76176011)(36756003)(186003)(31696002)(26005)(316002)(71190400001)(2616005)(446003)(53546011)(256004)(25786009)(71200400001)(6506007)(102836004)(11346002)(6116002)(3846002)(14454004)(66946007)(6246003)(31686004)(66476007)(66556008)(64756008)(66446008)(2906002)(6916009)(6486002)(81156014)(81166006)(229853002)(5660300002)(8936002)(7736002)(4326008)(305945005)(6512007)(8676002)(107886003)(54906003)(66066001)(6436002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4066;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6rooP/2ep1l5lA6KLwCT15nBxmr8xOO/AgRIQ0Ciz8KPU8qmYghL5M6nj6Kv8OVq+5qzljMMCaHEoHw23ZyvVG55IRDLZWXzLLgXrHh9G0JzKgRlQuR/kqB4PKwxt6FPdC8lYvMdwD26Sp3bG0SXJl9TYZI7BI/1lrjAkk9t/LR4deduTsZJs7jUuN7fJLUCGpxLG5vknxK/+92xcRwpUtPq/gARScW6dg/6HAjXKg3lpi9bl9/TT0usWynKg9IykQbjPfuFmBCw5h0xwnAniomK9Cl1cHMZ7rNRamM/YCESq7hjioVWdo5laSLGPj24Ydt+VPzdvoUn0z2uYImmXyBqLMahhgBu+eCcQhyzyCE+LD/1aJwTWUWa0qy0TCPqXcoTaxf3KgBTVK1yFtWSsZud0xKjM/a83VZjhC8Yo4/9XunZXsmj3ksPamYWjT3
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9E216994595209408DE049803E498D32@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee97608-a8e5-4f79-5af8-08d76f4037e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 11:36:30.4006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvgaYQsZB01bTg0QLxw/gz2U5EIKZREQQ1fNeX5EhlboJzfxvj4rIggLom6x5zUxVwazExi2RogX8gCIV2oewlmDmlFi+DmQMltqKzjRBU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4066
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::710
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
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 18.11.2019 21:54, Eduardo Habkost wrote:
> On Sun, Nov 10, 2019 at 10:03:09PM +0300, Denis Plotnikov wrote:
>> Some device's property can be changed if the device has been already
>> realized. For example, it could be "drive" property of a scsi disk devic=
e.
>>
>> So far, set_pointer could operate only on a relized device. The patch
>> extends its interface for operation on an unrealized device.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   hw/core/qdev-properties-system.c | 32 +++++++++++++++++++++-----------
>>   1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-=
system.c
>> index ba412dd2ca..c534590dcd 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -38,9 +38,14 @@ static void get_pointer(Object *obj, Visitor *v, Prop=
erty *prop,
>>   }
>>  =20
>>   static void set_pointer(Object *obj, Visitor *v, Property *prop,
>> -                        void (*parse)(DeviceState *dev, const char *str=
,
>> -                                      void **ptr, const char *propname,
>> -                                      Error **errp),
>> +                        void (*parse_realized)(DeviceState *dev,
>> +                                               const char *str, void **=
ptr,
>> +                                               const char *propname,
>> +                                               Error **errp),
>> +                        void (*parse_unrealized)(DeviceState *dev,
>> +                                                 const char *str, void =
**ptr,
>> +                                                 const char *propname,
>> +                                                 Error **errp),
>>                           const char *name, Error **errp)
> Wouldn't it be simpler to just add a PropertyInfo::allow_set_after_realiz=
e
> bool field, and call the same setter function?  Then you can
> simply change do_parse_drive() to check if realized is true.
May be, but I thought It would be more clear to have a separate callback=20
for all the devices supporting the property setting when realized.
Also the "drive" property setting on realized and non-realized device a=20
little bit different: in the realized case the setter function expects=20
to get
BlockDriverState only, when in the unrealized case the setter can accept=20
both BlockBackend and BlockDriverState. Also, in the unrealized case the=20
setter function doesn't expect to have a device with an empty BlockBackend.
I decided that extending do_parse_drive would make it more complex for=20
understanding. That's why I made two separate functions for both cases.

I'd like to mention that I have a few concerns about=20
do_parse_drive_realized (please see the next patch from the series) and=20
I'd like them to be reviewed as well. After that, may be it would be=20
better to go the way you suggested.

Thanks for reviewing!
Denis

>
>>   {
>>       DeviceState *dev =3D DEVICE(obj);
>> @@ -48,11 +53,6 @@ static void set_pointer(Object *obj, Visitor *v, Prop=
erty *prop,
>>       void **ptr =3D qdev_get_prop_ptr(dev, prop);
>>       char *str;
>>  =20
>> -    if (dev->realized) {
>> -        qdev_prop_set_after_realize(dev, name, errp);
>> -        return;
>> -    }
>> -
>>       visit_type_str(v, name, &str, &local_err);
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>> @@ -63,7 +63,17 @@ static void set_pointer(Object *obj, Visitor *v, Prop=
erty *prop,
>>           *ptr =3D NULL;
>>           return;
>>       }
>> -    parse(dev, str, ptr, prop->name, errp);
>> +
>> +    if (dev->realized) {
>> +        if (parse_realized) {
>> +            parse_realized(dev, str, ptr, prop->name, errp);
>> +        } else {
>> +            qdev_prop_set_after_realize(dev, name, errp);
>> +        }
>> +    } else {
>> +        parse_unrealized(dev, str, ptr, prop->name, errp);
>> +    }
>> +
>>       g_free(str);
>>   }
>>  =20
>> @@ -178,13 +188,13 @@ static void get_drive(Object *obj, Visitor *v, con=
st char *name, void *opaque,
>>   static void set_drive(Object *obj, Visitor *v, const char *name, void =
*opaque,
>>                         Error **errp)
>>   {
>> -    set_pointer(obj, v, opaque, parse_drive, name, errp);
>> +    set_pointer(obj, v, opaque, NULL, parse_drive, name, errp);
>>   }
>>  =20
>>   static void set_drive_iothread(Object *obj, Visitor *v, const char *na=
me,
>>                                  void *opaque, Error **errp)
>>   {
>> -    set_pointer(obj, v, opaque, parse_drive_iothread, name, errp);
>> +    set_pointer(obj, v, opaque, NULL, parse_drive_iothread, name, errp)=
;
>>   }
>>  =20
>>   const PropertyInfo qdev_prop_drive =3D {
>> --=20
>> 2.17.0
>>


