Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073ABC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BF320728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bt8XR9MC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BF320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVf6m-00011E-Sy
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVf61-0000CF-Qw
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVf60-0008Lw-Mr
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:09:21 -0500
Received: from mail-eopbgr40116.outbound.protection.outlook.com
 ([40.107.4.116]:65430 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVf5y-0008JU-86; Fri, 15 Nov 2019 12:09:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3I4LJq7KFqMiZSKub9d6NBAmAL/S44N3x66pn3ZD2LWonwoEsQ1rEuUYzKY0TVHs/J9gXBZiHzUOlDAXr8w4V5LpzIU7lab529/9ArpCteG+JyGBi9L9YwHKPY6Oj4MeB/RU9WUQMp6p2cgdyFsPKFQlPSpttqIiwduoGd+J6oUJjgza2Yd5veftIl53L0TXojOrfRO8QcGZ6moXk9eFeUyEGoNzyh8BKKsBpNXdgojT63by63MIKY7vMzEPWBLweGpSpc0nTnhSR3b0ZEyE4b6dmdzayP1HNtdnQzKeOuswgjT72fSzx6NsaF1YYgd5ZSFy8Bl/rlBxx1Dr721sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYEIOquNE+7Onip/QcEMBS7Rccf7xFZSfZ+GUGgZiWo=;
 b=DYfgKt+T7CjLbEfUxZ9dIa8lcpSAgTQnP9xu5WaWqZ0rASvcilrjYOr/LIZdv0+TsqYhcsw/20H8cLcb+CIWBstd/yvjhyvorenC+XpW2hwegwhllJWM4ltU9QSymu5E8HJtq23+vNr8Emgt6HLmrDvfFGQND1Z0iQaLblT/UD6w+D48Qyi99MHTLUg2W0H71F8zb3SUltwOmN/zSATT3sMD1UNd0I80cbpkCqB7UuiYvN1vTbBVV8HW/zUDu9IALVUSuEep0C3N9XwsAhFf4IlpwUXNQkgtBm7ZkE+1YjtFHhddiXeFo0k1UE2hfMUaVZmO3/sh3BaWz5VAf81W1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYEIOquNE+7Onip/QcEMBS7Rccf7xFZSfZ+GUGgZiWo=;
 b=Bt8XR9MCDjIYb0pjexgkj47MObBh9Q9r/cLK3FhZU8UMGqMaI9PQWsVQTS/Qt4B0RYsD98/2jgnd6fjtEqUI+hDeLtHWrDIoXmjsSF5VXfJJ1TiVrJE2jX6Jz4EHtfs2G+M0YyQ4UTMFHrjuA5RWx99VQ/RRFdKdbQQdn6gHTD0=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3749.eurprd08.prod.outlook.com (20.178.91.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Fri, 15 Nov 2019 17:09:16 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 17:09:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/4] bitmap: Enforce maximum bitmap name length
Thread-Topic: [PATCH v3 2/4] bitmap: Enforce maximum bitmap name length
Thread-Index: AQHVmpXQlrP7gvUJk0eiM4XXWoXbLqeMiPCA///Zu4CAAAzrgIAACg4A
Date: Fri, 15 Nov 2019 17:09:16 +0000
Message-ID: <9f5aa9bd-0a31-f80e-336d-a85398869875@virtuozzo.com>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-3-eblake@redhat.com>
 <0a25974f-f9cd-07a1-4cb7-2bbd4dfe4375@virtuozzo.com>
 <6d54c6eb-4f28-6a5d-81e1-a175e34f3cf8@virtuozzo.com>
 <8461437b-8991-3725-308d-68e054c7f3a8@redhat.com>
In-Reply-To: <8461437b-8991-3725-308d-68e054c7f3a8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::20)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191115200914246
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4628ed91-e618-4eab-63c1-08d769ee8bae
x-ms-traffictypediagnostic: AM6PR08MB3749:
x-microsoft-antispam-prvs: <AM6PR08MB3749E8C2EF7AE76EB0C96A49C1700@AM6PR08MB3749.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(136003)(376002)(396003)(346002)(51444003)(199004)(189003)(86362001)(71200400001)(71190400001)(66066001)(8936002)(386003)(66446008)(64756008)(66556008)(31686004)(81156014)(81166006)(8676002)(186003)(102836004)(2616005)(54906003)(5660300002)(11346002)(446003)(305945005)(486006)(476003)(7736002)(52116002)(66476007)(110136005)(26005)(316002)(66946007)(6506007)(53546011)(99286004)(4326008)(6436002)(478600001)(2501003)(31696002)(76176011)(36756003)(14444005)(256004)(2906002)(229853002)(6486002)(6246003)(6512007)(6116002)(3846002)(25786009)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3749;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ePE773/LjkjN9eaQyPzZKqbUBogF4tQlG5nDHZ46tGVMKFCHf+HMrMJOPXW736dyp7OaIqgYX6LeRMpoXUIxA/gpbY09d7iklBFveYXojDzcSCWJe/PBO4nbpPcY4pvniu6k6F38jRYGU09M474S6xQhMeVjbeBBKHbzIjuez3zZzN+e08oYOIQ//F9GymtqzcdxNq4zZ026AQUkqVuIdXE3jfWNbK2QcnRr6lBz+stO/hdcLyuDT14CLdCMYt15eraPXx+ZBnBSbLhi5Edq7/OrbWO69u+Y8NVHKZF2YZOPchzQjDf+cADLSRlrg8g0f6GdQRaPJiUZPoV3eNZC6IgqKGgi2reCKr3P85ObLuZ0x/o7O5leoaXAT/3buY13ZtEVPKNh6Q1zwd3CCitjxvUPYD0E4zyCPf+CmWMpDMrmKJyrZEpl8VDALbM9Odas
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <DB0F00452A5037409B42DBA720A9277F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4628ed91-e618-4eab-63c1-08d769ee8bae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 17:09:16.3648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQpAjjlROK1GxKWQ++OT1kMB50+/w24nklitYnnusdHZRXyD342YPeXRf5pCGaZJlfU2UserSmd0AHXzlEyVswJwxW7ltFfOnuLhctB8e8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3749
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.116
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.11.2019 19:33, Eric Blake wrote:
> On 11/15/19 9:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 15.11.2019 18:03, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.11.2019 5:46, Eric Blake wrote:
>>>> We document that for qcow2 persistent bitmaps, the name cannot exceed
>>>> 1023 bytes.=A0 It is inconsistent if transient bitmaps do not have to
>>>> abide by the same limit, and it is unlikely that any existing client
>>>> even cares about using bitmap names this long.=A0 It's time to codify
>>>> that ALL bitmaps managed by qemu (whether persistent in qcow2 or not)
>>>> have a documented maximum length.
>>>>
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>>
>>
>> One doubt:
>>
>> Is it good idea to include string larger than 4K into error message
>> (in next patch too)? I doubt that such message would be
>> readable, and I think that most possible source of such message is
>> some kind of memory corruption, so the whole message would be garbage,
>> which may contain special symbols which may look bad or even break
>> output.
>=20
> The string was provided by the user. You are correct that it results in a=
 lot of output on stderr, but it is no more garbage than what the user prov=
ided in the first place. If we wanted, we could truncate (list only the fir=
st 256 or so bytes and then output "..."), but it's such a corner case erro=
r that I don't think it's worth the effort to worry about it.
>=20

OK

--=20
Best regards,
Vladimir

