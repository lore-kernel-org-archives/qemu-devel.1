Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C499AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 03:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5B420650
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 03:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eOsfkfmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5B420650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUN4C-0004XB-Pp
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 22:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iUN3Y-00040P-GU
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 22:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iUN3X-0008Vb-Fu
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 22:41:28 -0500
Received: from mail-eopbgr80138.outbound.protection.outlook.com
 ([40.107.8.138]:7137 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iUN3U-0008U6-9r; Mon, 11 Nov 2019 22:41:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxfSL0CuH5AC2ldhnCeQiwc4IssBPfNLIGsaqYwVxDi//f58T9u1IP9mJBiV5whLlARvbaegqyd1fKeg2hurlbQH6gWAd/6qhCxELYAiXsO+DQGH1I5/JDjoAAl2IjOkBGMLXjxwPvk4TzJ2XeozyybIIjNMqGVVSnokQRXf+eJNDJsoZRe/1b7s3pH44dJvWSLVwqT6bOwFcu0KY7MaJYmwt5uZgLuhTVr8sWTwaABBCzJVImzSgp385qlK6KlMjx3eW+PzxcG345lzU107rx+XjFUvloczZIYUtTmIY0r0WuRdSgsmZDyJvtpLGyaseGT1+Ulrfp3ObWD/av9y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg2EOaKD3DADCUo63o5rYeSfqc+jI33GDUzW0z/H9VY=;
 b=iVFocw/9P2xTF+boYehG03J/bqLjwp2etwbCQLKty4gHwwcQUb0KHObTWmrXW6+OdzRwWjbUXx9JqYXEdwlPEq1tiz2hvfho81DNn3DBjSNczZEZC0hxvM8dTZNMesRWrFB96CPPePjarhQJnRZYYQFnJoO9SMBf3WnaszaaAMDTVPSGQZgkfqncI9NV/vCHpTf8To+Ioe816gVDHcX1LRwfiMQJ+cjDbQuPgvlam+Uu9wIr1sOsST52+/2ZZ37KrMAS8itvCEpiRq4J3SNS5mtC+wQAeLWSaAryA0AdIJ7kvCqFkLrMZlvzSkRAGe29MVEQSPUHzQmeuT7sJGvAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg2EOaKD3DADCUo63o5rYeSfqc+jI33GDUzW0z/H9VY=;
 b=eOsfkfmMRdyq4g9+Oc+tCYw1hKbEF8rqH9hQk5ApwheVjqXNaIxlPjJk5NWOx4DQQB5XzMSCM3CBkkhWAvLv1ddy2ig3D1GVLZIGznJkMMJMUed0NrKNKpLSUCZtdeVqu+8b1RjqZz5eV9wg08zG1y9eExI1/6nModEG76O7UYI=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2839.eurprd08.prod.outlook.com (10.175.232.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Tue, 12 Nov 2019 03:41:20 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 03:41:20 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4] iotests: Test NBD client reconnection
Thread-Topic: [PATCH v4] iotests: Test NBD client reconnection
Thread-Index: AQHVmHdtTYL1QQeE8kOLfJ2gY7oGZKeGQPIAgACkM4A=
Date: Tue, 12 Nov 2019 03:41:20 +0000
Message-ID: <e13624ac-3542-e3d8-d389-298c62deaf40@virtuozzo.com>
References: <1573466663-626788-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <68944099-25f1-8aea-c951-ea1802bf9549@redhat.com>
In-Reply-To: <68944099-25f1-8aea-c951-ea1802bf9549@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0048.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::34) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dd3db7e-c0f0-47dc-ffd6-08d767222e88
x-ms-traffictypediagnostic: DB6PR08MB2839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB28396B07774FE34B032E9FF9F4770@DB6PR08MB2839.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(2616005)(476003)(6512007)(2501003)(11346002)(2201001)(446003)(66446008)(66066001)(66476007)(66556008)(53546011)(6506007)(386003)(6486002)(64756008)(76176011)(52116002)(66946007)(5660300002)(186003)(229853002)(102836004)(6116002)(316002)(6436002)(3846002)(256004)(99286004)(14444005)(25786009)(31686004)(107886003)(26005)(478600001)(8936002)(36756003)(14454004)(6246003)(54906003)(31696002)(44832011)(2906002)(8676002)(7736002)(305945005)(4326008)(71200400001)(486006)(71190400001)(81156014)(81166006)(86362001)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2839;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOBxYpLDxxMZuhjqW8pqOYNmtv4YN0fjGz/S9Xxfsb/FHSY53DpLfSz3oi8/T7v3DGqg3ta3d/+aVHiNKkWEBLb0n82WA88tkMsBi8gk7x3NJKz8oG5s/IXmjc9AlG3URxGqiGeQoCBO5zDaDzVmQ0Gg5LcG5EHcojuSDULhSsJmGtN14Jh4Co4FzR53i7jBIR4T+7EtqcOuyiFR04ZWLgXPdI/UwVs6GEWlltsl6L5f5Ne6T4RbNhINGOdlOtqlg3A/OsgWcxSVA3EeCF6nWIy5PAhuMuJxYZ1JyajFlJx5iuyrtpvX08eh5YhGYexS4H/JMlwVsuvGj7y5gqixCKRiLMsjk/MWBBV8cnplnxamiVaqb5thEbWOTaXOO/SXxmKCaGhsqdv+XLuB+pAVfkmn2TYSb9zYC+pdM+c3pw3NlnKx29Gdc1MTJAl9B2OY
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <37940C9B3D256E4D8672DB6BD2228BEA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd3db7e-c0f0-47dc-ffd6-08d767222e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 03:41:20.6473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AG/fw8t9cG60Ti2yWqR4AEY2w7DTamkGWfQ2NHFZD16RMkKqaNSJxaQ5M2Ez0lJ13goYFglXG++B1OYrColn7CpbEbKgMvwfkO5RJD+6LA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2839
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.138
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/11/2019 20:53, Eric Blake wrote:
> On 11/11/19 4:04 AM, Andrey Shinkevich wrote:
>> The test for an NBD client. The NBD server is disconnected after the
>> client write request. The NBD client should reconnect and complete
>> the write operation.
>>
>> Suggested-by: Denis V. Lunev <den@openvz.org>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>> v3 was discussed in the email thread with the message ID
>> <1572627272-23359-1-git-send-email-andrey.shinkevich@virtuozzo.com>
>>
>=20
>> +import os
>> +import subprocess
>> +import iotests
>> +from iotests import file_path, log
>> +
>> +
>> +nbd_sock, conf_file =3D file_path('nbd-sock', "nbd-fault-injector.conf"=
)
>=20
> Mixing '' and "" in the same line is odd.=A0 I don't know if we have a=20
> strong preference for one style over the other.
>=20
>> +++ b/tests/qemu-iotests/group
>> @@ -284,3 +284,4 @@
>> =A0268 rw auto quick
>> =A0270 rw backing quick
>> =A0272 rw
>> +277 rw
>=20
> The test completes in 3 seconds for me; we could add 'quick'.
>=20
> Otherwise, looks reasonable to me.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Tested-by: Eric Blake <eblake@redhat.com>
>=20
> I'll probably queue this through my NBD tree for rc1, as it adds test=20
> coverage of a new feature for the 4.2 release.
>=20
Eric,
Thank you very much.
Please let me know when the patch is queued.
--=20
With the best regards,
Andrey Shinkevich


