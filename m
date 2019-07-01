Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E1BC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8222089F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jjffNDTr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zNM0a0jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8222089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtMm-0005xo-8u
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59214)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=078b6f121=shinichiro.kawasaki@wdc.com>)
 id 1hhtKr-0005L4-FU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=078b6f121=shinichiro.kawasaki@wdc.com>)
 id 1hhtKn-0007Zo-Qk
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:14:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=078b6f121=shinichiro.kawasaki@wdc.com>)
 id 1hhtKk-0007Tw-0K
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561976091; x=1593512091;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=qRN+Nh10QSy8ov42auqAnKI3wkbMAD2y8d4zUT3IPYI=;
 b=jjffNDTrimH80u5cWap7Sf9XgjRzapJVqiRxxkh7eGpJScH6j9EQYX/T
 xSsiHYxBSfHI3fQW38UXScZ2G5r+C72e8nGo8bzxlKUXZuvUuUPf1zIMV
 k0uviu4H7yPrMk//eD9sWEXBtHeMun2pDkZh5Akf/jtKch03s9igrqKT4
 YXYMi69VSC0rlIoTadVDZ8yjXpgPLG/j7R2/+qzdFK+IaeBZyqHJThmpf
 nrWhAMOXDXzJ6K/wm/p4I9kL7J7M2ecinXI9IoKYuW+yp1hUMctYhiBtX
 8ka2k/Vg/DL2oy5PvVg8T9GM0yO8Fh1qj8qpAWXyvOcbPxCk7WUy8M/LH A==;
X-IronPort-AV: E=Sophos;i="5.63,438,1557158400"; d="scan'208";a="116799946"
Received: from mail-sn1nam01lp2054.outbound.protection.outlook.com (HELO
 NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.54])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2019 18:14:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd1bNUjNgP1M4ZjVhM1e4ZYP/nLkDPaWW6irmsGJetI=;
 b=zNM0a0jmPYFX0kft58Hi5tp8j3h8Dw8ttA3dcyJa1pdFJIqAZUQAFIb6tEPS+rW0v1rv221RbjxT57Gfugzmy94rOmH2lO4eLCrNpBkV1ZFLFsIR70FxVl3S8qxtVmfyLPqA8cn9Xx3qPz4dNqd41Q/IbHiwJi+Dv6PRHdujYb0=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.10.135) by
 CY1PR04MB2297.namprd04.prod.outlook.com (10.167.9.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 10:14:42 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::59c9:cdab:735b:411e]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::59c9:cdab:735b:411e%3]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 10:14:42 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Alistair Francis <alistair23@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Thread-Topic: [PATCH v1 1/1] hw/scsi: Report errors and sense to guests
 through scsi-block
Thread-Index: AQHVLHFNTNaoeJK+R0uVGvml8Q5ogQ==
Date: Mon, 1 Jul 2019 10:14:42 +0000
Message-ID: <CY1PR04MB22682B84C1ABA7FB10752465EDF90@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
 <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
 <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
 <CAKmqyKMRSJTMxZ5c-yyuownYF8vJLYrzr92cE4rkiTdP7tmUzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 604e5cf3-4b20-486d-3937-08d6fe0cef2e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:CY1PR04MB2297; 
x-ms-traffictypediagnostic: CY1PR04MB2297:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB22971AC6EB47722E6268FB9BEDF90@CY1PR04MB2297.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(76176011)(9686003)(53546011)(6506007)(66556008)(86362001)(66946007)(53936002)(73956011)(966005)(66476007)(33656002)(7696005)(6436002)(186003)(53376002)(6306002)(55016002)(71200400001)(478600001)(71190400001)(52536014)(25786009)(14454004)(76116006)(66446008)(64756008)(91956017)(5660300002)(476003)(8676002)(305945005)(3846002)(6116002)(8936002)(486006)(446003)(110136005)(7736002)(44832011)(74316002)(4326008)(68736007)(81156014)(81166006)(14444005)(256004)(2906002)(66066001)(54906003)(6246003)(26005)(102836004)(99286004)(229853002)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY1PR04MB2297;
 H:CY1PR04MB2268.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g7Rl92mK4B8Yi/Yk8joigv2IgINPCRjuMp0AaRLtNzfZAesyDALuO1kXuVl39dQ1e5Qbr23e29xDuyAelcCOGceRQssrt5dtCWFkxq5fa49uRu5IpDGAx2Ji+zr2RArn3UYhftSaKH3qNNUt0pEGzW0E35LSUhDAHV9iLFGMcMYqyq8+f5ge5yihwwfUYksjZr+XMWk+dpQ8MFDKSf28HUuqYXk41zCJVnJ+5yUL0rQBAJ97/xqPH2S5MTM+Z2twF0soOYNG4Q5rW3pvhKTHhYlkdyKxH+vn2vPzpnHk1l0wjWlDP9b+Lzmd20YS8EBqnH7vvi81Yeml6cVFZVjw6Vl5sCvawh/lJH6SljUVtoV8D2xl3y6WNYe8SEFFZYehcRRiAqUtXoMAuUKj/ZcA1PWlAnsxYxDd0bR2WqG2XQw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604e5cf3-4b20-486d-3937-08d6fe0cef2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 10:14:42.4509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shinichiro.kawasaki@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2297
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
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

On 6/29/19 7:21 AM, Alistair Francis wrote:=0A=
> On Fri, Jun 28, 2019 at 3:14 PM Paolo Bonzini <pbonzini@redhat.com> wrote=
:=0A=
>>=0A=
>> On 28/06/19 23:57, Alistair Francis wrote:=0A=
>>>=0A=
>>> I tried to run my VM with option "-drive=0A=
>>> ...,rerror=3Dreport,werror=3Dreport" as he noted, but the eternal loop=
=0A=
>>> symptom still happens when host block-scsi device returns EIO. Then I=
=0A=
>>> believe EIO should be added to the report target error list.=0A=
>>=0A=
>> What is the sense data he's seeing?  EIO is a catch-all return value=0A=
>> for scsi_sense_buf_to_errno so I'd rather be more specific.=0A=
> =0A=
> I'm not sure, he is CCed to this email so he should respond with more=0A=
> information.=0A=
=0A=
Hi Paolo, thank you very much for your review and comments.=0A=
(Alistair, thank you for your care for the patch post)=0A=
=0A=
The sense data I observe are related to 'zoned storage'. Now I'm trying to =
make =0A=
zoned storage on host visible to qemu guests through scsi-block driver, to =
=0A=
utilize qemu guest environment for zoned storage system development.=0A=
=0A=
     'zonedstroage.io' is the good reference for details of the zoned stora=
ge.=0A=
     http://zonedstorage.io/introduction/zoned-storage/=0A=
=0A=
The zoned storage introduced "zone" and "write pointer" concepts, and SCSI =
spec =0A=
documents were updated to define additional commands for zoned storage as w=
ell =0A=
as Additional Sense Codes. The latest SPC-5 defines a number of ASCs that z=
oned =0A=
SCSI storage devices return. I observe four of them listed below in sense d=
ata, =0A=
when I ran basic operations to the zoned storage from the guest via scsi-bl=
ock.=0A=
=0A=
     21h 04h: UNALIGNED WRITE COMMAND=0A=
     21h 05h: WRITE BOUNDARY VIOLATION=0A=
     21h 06h: ATTEMPT TO READ INVALID DATA=0A=
     55h 0Eh: INSUFFICIENT ZONE RESOURCES=0A=
=0A=
These ASCs can be reported for write or read commands due to unexpected zon=
e=0A=
status or write pointer status. Reporting these ASCs to the guest, the user=
=0A=
applications can handle them to manage zone/write pointer status, or help t=
he=0A=
user application developers to understand the failure reason and fix bugs.=
=0A=
=0A=
I took a look in scsi_sense_to_errno() and learned that ASCs are grouped in=
 =0A=
errnos. To report the ASCs above to the guest, is it good to add them in EI=
NVAL =0A=
group defined in scsi_sense_to_errno()? The ASCs are reported with sense ke=
y =0A=
ILLEGAL_REQUEST or DATA_PROTECT, then I think it fits in the function.=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=

