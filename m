Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2ADC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C02206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sSEynbcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C02206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRQA-0005Ox-ME
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXRPV-0004tW-1E
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXRPT-0004Zq-H5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:56:48 -0500
Received: from mail-eopbgr140091.outbound.protection.outlook.com
 ([40.107.14.91]:18091 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXRPT-0004Yb-9W; Wed, 20 Nov 2019 09:56:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd4Hum+L8S2JB2yckiVMCEHdHZVjEwlvD3ncL/7Yif7ec2fUNVuXIWFu9ZNIPuHFNMJQpZmbw4aAOHbr0GWBEjZI4ha939m/Ei6JBHDcM8nyD94I3iULk67mA58K4BkexyPgQk7UhQ/ECqZeXuYnk0BaCjqSpPOk0hcgCDI3w7Py7kgayJpQCh3ca/mEnTDsbVm4gHHUSvqaomw5f8GpHl3f4hBUz2ti2uwoSrG2IRKLFZx9zJhOEBTlYZfq0OecB+awxFbYdZMqB1CYL7Hk1ZHyRRSktmrlUILFB9s1DBzDvkqQNEbsXakoo6evH16H1c1TlHOsAq6DvcmmSHPCVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvLQj5p0IbIM3D7EzTztA5sa0EkisiBj3bQ1rDCHFlA=;
 b=kLis10LLSPnsaRZEuJi8x0ePRz3h6ZtrRJ7+yh+fhrK3KeKPs/yU0uEniqXY7BekFmYf4w7/hcFHKV8gdSonmo/f53uA21ryq316OVFacz2zSiVDnoF+qKg6boFHekgVuRFqcd4Mm3TpkqEVsa/4NOW6EsHfeRgVorKWWVOifqLv7QweBIV49lYotEV4SY3hD4CMleh9DOUGQPcsJ4aGS9XuTzh3ylOMIBZqbCx6O3Zb0vevpbUiTJB1F8bBmx/V1eCOe7NkmiEPkw4xmAHqO9SVW/wYvGGtX8gXn4uA2LHmsuRlYBo8aHogv6t1Hu6sOPAnS6PNf2rh9uh4odw0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvLQj5p0IbIM3D7EzTztA5sa0EkisiBj3bQ1rDCHFlA=;
 b=sSEynbcVwdQftA6GpawA14gMNHl18a0kPLmpdWLXzWc2A5f7LQ9zPNa17CuhQSYwuHh6OtYfTKWq2FaCiNMHH6YO0/xLsNVteBjpg5llRffWMV//nUSk3S50ch3/6Izzjj/EMcTZo6Q4noOgnW1EYOlHCak4AqRZ1bafO3tBBOw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4739.eurprd08.prod.outlook.com (10.255.97.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 14:56:44 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 14:56:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 5/6] iotests: Support job-complete in run_job()
Thread-Topic: [PATCH 5/6] iotests: Support job-complete in run_job()
Thread-Index: AQHVn6tbv7WaUZvfu0mqa7yjDgpJsqeUJhkA
Date: Wed, 20 Nov 2019 14:56:44 +0000
Message-ID: <bf16520e-13aa-69b8-161a-a5eb6bc32c6a@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-6-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-6-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::21)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120175642309
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42dd5113-afe4-40bf-55b9-08d76dc9dc28
x-ms-traffictypediagnostic: AM6PR08MB4739:
x-microsoft-antispam-prvs: <AM6PR08MB47399EC5607223FE625EB2B0C14F0@AM6PR08MB4739.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39850400004)(366004)(376002)(136003)(189003)(199004)(6116002)(102836004)(66946007)(110136005)(256004)(14444005)(446003)(3846002)(305945005)(4744005)(386003)(6506007)(81166006)(36756003)(6512007)(2906002)(14454004)(54906003)(316002)(11346002)(6246003)(2501003)(71190400001)(71200400001)(7736002)(64756008)(66476007)(66446008)(66556008)(486006)(31686004)(476003)(2616005)(31696002)(52116002)(81156014)(99286004)(186003)(5660300002)(8936002)(76176011)(25786009)(6436002)(6486002)(86362001)(478600001)(4326008)(229853002)(66066001)(26005)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4739;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TjR/2jPl9vj6CwpFL0D6Ebg7DhwgmXPEyozd3+Yc5DxIlpQvgCNnrnsqAXxI1/HZ7oCjTnJoFDWjh88f61DkOO+5Mo3rTC0Rll0Mrwt9lAxMn3DXWyoucbqRDuzYrDbyKXM4USmCcMslGuIZ1IyRrP/H+hm9SZSPzs3yc587Yo/112ZSaJHco9RYH9Saa0r5IyKgvWNOWCUwOAhLa+5CBkBvVJQfKAuBHV9ttFSCCfefG/4WbcVCPgcXd2y//cOouUZbs7E3LKyzYugQDd14RxdG8qJPfEvMovY4a4aohGEpehO+AXi7p2Xd8lQevV9MGpU/IXgQPBaP9hh/BJKzoZBGrxhPxrYzFOF9SGWJQMJQNcuxdd78pXV87OtlLLj1EQAzBFs4ZCEo7DBXYUM+Dy9pebWRDOJrb/MdtVQ7Z2AbCX3YAELt4dWXiDBFyCAA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <8843BF3308699C47A65BC6D88F9EB0F6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dd5113-afe4-40bf-55b9-08d76dc9dc28
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 14:56:44.7138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsOa2II/dBo++vWMKf7UBSFxBAMaaQTDoMwdrzWFdQFkrbvHvOsqu02BPVRtMxICtdFtQtjZZdZMtXaYuvPDIw0qC2sYE1IjQJReIY1AuNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4739
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.91
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.11.2019 17:03, Kevin Wolf wrote:
> Automatically complete jobs that have a 'ready' state and need an
> explicit job-complete. Without this, run_job() would hang for such
> jobs.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   tests/qemu-iotests/iotests.py | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index b409198e47..c4063ef6bb 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -617,6 +617,8 @@ class VM(qtest.QEMUQtestMachine):
>                           error =3D j['error']
>                           if use_log:
>                               log('Job failed: %s' % (j['error']))
> +            elif status =3D=3D 'ready':
> +                self.qmp_log('job-complete', id=3Djob)
>               elif status =3D=3D 'pending' and not auto_finalize:
>                   if pre_finalize:
>                       pre_finalize()
>=20


--=20
Best regards,
Vladimir

