Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAD_ENC_HEADER,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC45C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A31920815
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 15:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CRiaHRHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A31920815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47417 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVHrE-0006TQ-7U
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 11:48:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hVHpq-0005rx-Gi
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1hVHpp-0004Ck-JB
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:46:50 -0400
Received: from mail-bgr052101131081.outbound.protection.outlook.com
	([52.101.131.81]:1088
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1hVHpo-0004Bk-UN
	for qemu-devel@nongnu.org; Mon, 27 May 2019 11:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=FD26toAnhvrBTB0VbQbx9GRyUtIoT5TzwWZwmbhHUks=;
	b=CRiaHRHI7i8gJUv8dljTBQkHMrPgf4uZIFgdPb6gKYTN2kDgDMOFRmcTRMhAKnu/8OLgPsF2V5IbIDTOdeJc2LidgV0itqcqnU5xzyqymHOIXwqmBbyaP4Y6NIDsjlBmWNKjEnuKkmAhccuPhQ/BE8WL+vYk4FSUWWMOEHIURoo=
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com (20.179.46.205) by
	DBBPR08MB4919.eurprd08.prod.outlook.com (20.179.47.78) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.16; Mon, 27 May 2019 15:46:39 +0000
Received: from DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f]) by DBBPR08MB4854.eurprd08.prod.outlook.com
	([fe80::4d46:2c95:d6e:ab3f%7]) with mapi id 15.20.1922.021;
	Mon, 27 May 2019 15:46:39 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Thread-Topic: [PATCH v2 1/9] i386/kvm: convert hyperv enlightenments
	properties from bools to bits
Thread-Index: AQHVDLuPD6j+7f63IkeYJPTYiZUWlaZ/LUEA
Date: Mon, 27 May 2019 15:46:38 +0000
Message-ID: <20190527154634.GA2362@rkaganb.sw.ru>
References: <20190517141924.19024-1-vkuznets@redhat.com>
	<20190517141924.19024-2-vkuznets@redhat.com>
In-Reply-To: <20190517141924.19024-2-vkuznets@redhat.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: =?iso-8859-1?Q?Roman_Kagan_<rkagan@virtuozzo.com>,
	=09Vitaly_Kuznetsov_<vk?=
	=?iso-8859-1?Q?uznets@redhat.com>, _qemu-devel@nongnu.org,
	=09Paolo_Bonzini?= =?iso-8859-1?Q?_<pbonzini@redhat.com>,
	=09Richard_Henderson_<rth@twiddle.n?=
	=?iso-8859-1?Q?et>, =09Eduardo_Habkost_<ehabkost@redhat.com>,
	=09Marcelo_To?= =?iso-8859-1?Q?satti_<mtosatti@redhat.com>,
	=09"Dr_._David_Alan_Gilbert"_<?=
	=?iso-8859-1?Q?dgilbert@redhat.com>,
	=09Daniel_P_._Berrang=E9_<berrange@re?=
	=?iso-8859-1?Q?dhat.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
	(2603:10a6:7:14::29) To DBBPR08MB4854.eurprd08.prod.outlook.com
	(2603:10a6:10:da::13)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c608d00e-7888-42e8-5d18-08d6e2ba815f
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DBBPR08MB4919; 
x-ms-traffictypediagnostic: DBBPR08MB4919:|DBBPR08MB4919:
x-microsoft-antispam-prvs: <DBBPR08MB4919980D027E990A0AE495F5C91D0@DBBPR08MB4919.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:SPM;
	SFS:(10019020)(376002)(366004)(396003)(39850400004)(136003)(346002)(189003)(199004)(6436002)(66476007)(66446008)(66556008)(64756008)(73956011)(81156014)(81166006)(6512007)(9686003)(68736007)(8676002)(8936002)(305945005)(6486002)(229853002)(316002)(7736002)(86362001)(102836004)(6506007)(386003)(66946007)(58126008)(186003)(6246003)(52116002)(54906003)(33656002)(25786009)(26005)(99286004)(66066001)(486006)(2906002)(14454004)(446003)(11346002)(476003)(3846002)(6116002)(6916009)(478600001)(71200400001)(71190400001)(1076003)(53936002)(4744005)(256004)(4326008)(5660300002)(36756003)(76176011)(30126002);
	DIR:OUT; SFP:1501; SCL:5; SRVR:DBBPR08MB4919;
	H:DBBPR08MB4854.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xoyq2yDglVhmN/eLykN9iuIzyyyFu0xAHid7SrRPjgALWskesLlayKUt0ryDibiML1lg3zmJUeyAPFlr6uZavwd93Txe0zSBLlu0G/6d4L+TlcB1gpJMo3PsB0ovEaQnJj/N5JmrQmlQh6AZS4aq1IdxpI/QsD87pGeIilqkRuF+BJKmgukHGHZ7y51SUiXjfyTR8g/MwZ/qTdqf1xyiYyctFAFCnyct2gZASkWqSKJiTi9jl7UST5Kk8PBfCxXtut7oLJpnkF2KAUT5SZyRuhBo1a3SC/edEAvpHC/J75DK79xqrBc+l/nfeZX3JPKAzYwnw3Gc9HJQzPqPjpSYgYZVuMKVQE1B9rKy/IFoSuHgaHwVrC/mgOjGBtPUlemoqk0muNA1HO6SlinMsm68InJTLpI6SFWjlaG3BsJI/9tQprClTo0J6gk0xXjFgHA9ack/zCCjDu+j43ADWSDLuGV3/3IFPhAganWUHsXJ3YsOHclw4PHc+jEWgPRKMFC2
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2AF5B459ED835F41AC9DBA84887CB402@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c608d00e-7888-42e8-5d18-08d6e2ba815f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 15:46:38.8015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4919
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.131.81
Subject: Re: [Qemu-devel] [PATCH v2 1/9] i386/kvm: convert hyperv
 enlightenments properties from bools to bits
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 04:19:16PM +0200, Vitaly Kuznetsov wrote:
> Representing Hyper-V properties as bits will allow us to check features
> and dependencies between them in a natural way.
>=20
> Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  hw/i386/pc.c          |  3 +-
>  target/i386/cpu.c     | 44 +++++++++++++++--------
>  target/i386/cpu.h     | 37 +++++++++++--------
>  target/i386/hyperv.c  |  2 +-
>  target/i386/kvm.c     | 83 ++++++++++++++++++-------------------------
>  target/i386/machine.c |  2 +-
>  6 files changed, 91 insertions(+), 80 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

