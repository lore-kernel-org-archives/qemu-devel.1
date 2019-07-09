Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12E6C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE87321537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JDxZmxpK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a6HeRZbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE87321537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hklVH-0001dm-0P
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 04:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0865724b8=shinichiro.kawasaki@wdc.com>)
 id 1hklT0-0000Eh-U8
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0865724b8=shinichiro.kawasaki@wdc.com>)
 id 1hklSx-0007pA-DY
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:27:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=0865724b8=shinichiro.kawasaki@wdc.com>)
 id 1hklSv-0007lJ-6b
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562660829; x=1594196829;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BhcouebLSH0UvJU80851itprE6ePDNwmM4RZrQyChHk=;
 b=JDxZmxpKaq2QaunOZW1iHldda9biIKhWhIS5L2TexMRtAlxspY0MYHHd
 WSGCvErKsdauUlg9UY/G3mjrnWAA/IE+nye9MTzL7B4/SVMFAqMjq/Zik
 WedM4q8w8+MkK+j4ueSyABoElLloP01+n0Gun4kDqJaLTNQ5Y+5jD39+i
 v41lDdFhGq3HqQgeWS32KFQ9iejqMIZh8AVVmkCxsJJLP4mZMwtQwwRxZ
 aq0sUkHCIy12olU4vbTpKY/1kXaPRubOp/ofoeOyQRSFH1DpkLG6lmduH
 WvBJW1cqDOrXXEVOJtgR6r4J/jMFa9bqU+HS4yypBVeVUoof75LOIwkmE Q==;
IronPort-SDR: mVZGctZTp1OOB87X1S9Jbb6fZpozgbctOVXRtYnnkjCIgqwbJ3Wgl4ELsigPzb25goEWIZxqQb
 x/gqx8k/d+Eu/jOucCyyH0GAeWuNvQVEmZhXB1ntp0AV92rLMPy7DimqiKzlnIpMS3j5vqSgKA
 I3pB+i9gz5tIENYd8nXBCd+7OJQ0EefDLn8wK4fz9889ERm5qjAYlX2WAtFgHQISJaa6oJYYKW
 ZVs2oNfCUpqp7+dNMExRaFI3y9KYic5nJVqS2om9k6ggOosRiT4pgHl9r56b/C0EGfj5pPojp/
 ARk=
X-IronPort-AV: E=Sophos;i="5.63,469,1557158400"; d="scan'208";a="112529161"
Received: from mail-by2nam01lp2057.outbound.protection.outlook.com (HELO
 NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.57])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 16:27:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57e8fGswk8vq1a/ciix4n4HZrafjYeYLJUV43i51hmU=;
 b=a6HeRZbPCUk5cCVLhdQLFueRnYHq6Q0P1fd9PTPv5hBrStXa5tV3OXjIqUx6sGi46rAQlAYrUF9wZOa92HPKKFPqyMSrA1HSyorUWQo1edp04uM18L5QxEBzklUzxp3C8Fsx74Jj9LvGL3SXgljeIYDnz+f1tcJCOfYRftatHS0=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.10.135) by
 CY1PR04MB2348.namprd04.prod.outlook.com (10.167.17.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 9 Jul 2019 08:27:02 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::3c89:eb2e:38c3:6089]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::3c89:eb2e:38c3:6089%7]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 08:27:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis
 <alistair23@gmail.com>
Thread-Topic: [PATCH v1 1/1] hw/scsi: Report errors and sense to guests
 through scsi-block
Thread-Index: AQHVLHFNTNaoeJK+R0uVGvml8Q5ogQ==
Date: Tue, 9 Jul 2019 08:27:02 +0000
Message-ID: <CY1PR04MB226889E90FA5A938C443DF8FEDF10@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
 <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
 <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
 <CAKmqyKMRSJTMxZ5c-yyuownYF8vJLYrzr92cE4rkiTdP7tmUzg@mail.gmail.com>
 <CY1PR04MB22682B84C1ABA7FB10752465EDF90@CY1PR04MB2268.namprd04.prod.outlook.com>
 <79c9e21f-06b1-6255-97af-95c08b354c8a@redhat.com>
 <CY1PR04MB22683409CB203BF5042697FBEDF80@CY1PR04MB2268.namprd04.prod.outlook.com>
 <5a741004-fc88-f31a-2abf-70f4a9b0d5a9@redhat.com>
 <BN3PR04MB22577C778C58BC5E2C8DD61FEDF50@BN3PR04MB2257.namprd04.prod.outlook.com>
 <8a5bd434-4c4c-f5ae-cae4-a23f6463a05c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46c0f4a6-13b1-40f4-e78d-08d7044737fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:CY1PR04MB2348; 
x-ms-traffictypediagnostic: CY1PR04MB2348:
x-microsoft-antispam-prvs: <CY1PR04MB23489D32E95617178B6D4D04EDF10@CY1PR04MB2348.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(51914003)(25786009)(33656002)(86362001)(68736007)(4326008)(229853002)(99286004)(2906002)(316002)(110136005)(54906003)(7696005)(53546011)(6506007)(14454004)(102836004)(26005)(76176011)(186003)(6116002)(3846002)(8936002)(44832011)(486006)(8676002)(81156014)(81166006)(476003)(446003)(478600001)(9686003)(55016002)(6246003)(53936002)(5660300002)(6436002)(71190400001)(71200400001)(91956017)(76116006)(66066001)(52536014)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(7736002)(305945005)(14444005)(74316002)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY1PR04MB2348;
 H:CY1PR04MB2268.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s6kmIeVvhwExNc21SgiY3PtjmWQpi2KtZvNebf0maogxA/YeK1YK3G5a7qFNR5DuE2/3mJ5irVCxX/uJdLewIyBgE/jeCQMJWDpnFcWLYMeYVMy2SMXiF1TiWjUm8DyHtYYtEt+RvqEkLpqkPzXJTi4KrZJGAhOqkYHDJ3BkiECRx5TtTpOFzSVWTroeohBq1MTnCRqRzmBbHhnMR+ymSzQCw8Vi3ijSk1azZaa03WBWRXoRbDq1AyIyRd2kh/honz4CKCM5uiTn3xYQLZfTIYuY52BF1W5LltXPGLylTsdM6yiEJdOQYab6s7AT/LlpgCEOf2Ig4twv6HVQavB0c0RPDJDGFZSw3vT3yopr4cLg6ApLqVI//ccm+eYUykphCw5J8NxyO9alhGLzwaxmFqDKkXWLrfLEEp63XpXLUqg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c0f4a6-13b1-40f4-e78d-08d7044737fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 08:27:02.4125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shinichiro.kawasaki@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2348
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw/scsi: Report errors and sense to
 guests through scsi-block
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org
 Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/19 2:08 AM, Paolo Bonzini wrote:=0A=
> On 05/07/19 12:31, Shinichiro Kawasaki wrote:=0A=
>>> This way there's generally no need to shoehorn ASC codes into errno.  I=
=0A=
>>> still have to test my changes, but I hope to send something within a=0A=
>>> couple of days.=0A=
>>=0A=
>> Thanks for sharing your thoughts. Now I understand your idea.=0A=
>>=0A=
>> I'm awaiting your patch. In case you want me to create the patch based o=
n your=0A=
>> idea, please let me know. I can afford some time next week to work on it=
.=0A=
> =0A=
> I didn't have time to finish, but since I will be out for part of next=0A=
> week, here is what I currently have (untested, somewhat uncompiled).=0A=
=0A=
Paolo, thanks for the patch! With a few simple compile error fixes, the pat=
ch =0A=
series worked with my system as expected. Zoned storage devices are visible=
 on =0A=
the guest through scsi-block driver. Good.=0A=
=0A=
Here I list the compile error fixes for your reference:=0A=
=0A=
1) changed return type of scsi_sense_buf_is_guest_recoverable() from int to=
 bool=0A=
    in include/scsi/utils.h=0A=
2) replaced scsi_sense_to_errno() call in scsi_sense_buf_is_guest_recoverab=
le()=0A=
    with scsi_sense_is_guest_recoverable()=0A=
3) removed unused "out:" label in block/iscsi.c=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=

