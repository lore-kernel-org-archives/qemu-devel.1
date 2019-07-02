Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E40C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C95B216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f20SK7Ex";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NzVYwfi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C95B216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCwO-00065m-7q
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36052)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07907f462=shinichiro.kawasaki@wdc.com>)
 id 1hiCWi-0001r1-V8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07907f462=shinichiro.kawasaki@wdc.com>)
 id 1hiCWf-0003n2-AW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:44:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:12094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=07907f462=shinichiro.kawasaki@wdc.com>)
 id 1hiCWb-0003gN-5d
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562049874; x=1593585874;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SLYPvGXH97KKNEUTKs7Io3bEeR3zpBaBb+mXq2vnqsM=;
 b=f20SK7Ex3Uw/rGEWigAtsx4GOFpNgTIbJuwmh4xfNmktRqU+C/DaqwGS
 4ojdz8zq6sVb35rw50yvWedeHnEdGAhg72v4sicETtEXjlXTZ/sV9rnC5
 SOcsRglT0Eh4YLz7Niulp4/XGFrUfYfmQR5muot7fJGIzo47yXQfHqMaW
 RS4tLimHTf9qhFHzCtBjCQaxHVT9Wbcw+3AfQls1NP/eLZX/obcJZCyMB
 utWOSqu2cH961bbOrM9KgRUna5gOiDDu8NA8oJ7v3Ut+9vM7dZivQ0aMJ
 RgKTLIlSeOV63YCJRWE2t2Hbu2XTITxaV0IleWqyHEgzd8yhhl/iIC/4I Q==;
IronPort-SDR: XLDGpidCrBnRMxNKkc+l19DirvtUq30ngUD9/dp+1ReUXtx9GijROCKYjad0G3/HXHy63WBHX/
 39ZuGqMMrA7DlQf1XHut+fXWpyBDtwNIUJjCxBKfqAZxzBoDKTj9t/WnOadZHdcwODgtN8RFeE
 nIpOE3LdDMJ34gYh4E9r43P4qpTBa/xK1KMwixdNUpFwlzwFVPSaXKFQBW0uire0ksUkbo9A+J
 apjuaqT1v54A28hF7QRb6FoO9Ynp0Sv9/yMaTtB6igHFjNrPIYylCJ1NZFVB2nEwwAcsGyxd8U
 dSE=
X-IronPort-AV: E=Sophos;i="5.63,442,1557158400"; d="scan'208";a="211872513"
Received: from mail-by2nam01lp2054.outbound.protection.outlook.com (HELO
 NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.54])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 14:44:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwc7CujttRyn9Z4Zt4LVqG4UoJ7NJvqGrr6QtYW7fxE=;
 b=NzVYwfi1yKMtf1gKWuwCCCnxnKFIGKhacrBuShomLPtxRDaiblaDy4aGGknCl5eEJp6ILzDymjxKduIYJXWMR/uj4mvyQoly5dodTBywPtN5fflaVa6W275//Lnm5qQYFciYm7UwgcUazxleg3KmPpTB+0EaNXJTG7BCC2Us2xc=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.10.135) by
 CY1PR04MB2154.namprd04.prod.outlook.com (10.174.128.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 06:44:03 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::59c9:cdab:735b:411e]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::59c9:cdab:735b:411e%3]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 06:44:03 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis
 <alistair23@gmail.com>
Thread-Topic: [PATCH v1 1/1] hw/scsi: Report errors and sense to guests
 through scsi-block
Thread-Index: AQHVLHFNTNaoeJK+R0uVGvml8Q5ogQ==
Date: Tue, 2 Jul 2019 06:44:03 +0000
Message-ID: <CY1PR04MB22683409CB203BF5042697FBEDF80@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
 <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
 <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
 <CAKmqyKMRSJTMxZ5c-yyuownYF8vJLYrzr92cE4rkiTdP7tmUzg@mail.gmail.com>
 <CY1PR04MB22682B84C1ABA7FB10752465EDF90@CY1PR04MB2268.namprd04.prod.outlook.com>
 <79c9e21f-06b1-6255-97af-95c08b354c8a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e8141b1-be2a-49f8-01cc-08d6feb8ac0e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:CY1PR04MB2154; 
x-ms-traffictypediagnostic: CY1PR04MB2154:
x-microsoft-antispam-prvs: <CY1PR04MB21541B60E31D8ACF10CDA654EDF80@CY1PR04MB2154.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(199004)(189003)(186003)(86362001)(76176011)(26005)(6506007)(102836004)(53546011)(81166006)(71200400001)(7696005)(6436002)(229853002)(74316002)(8936002)(476003)(305945005)(256004)(76116006)(33656002)(99286004)(66066001)(73956011)(64756008)(66946007)(66556008)(91956017)(54906003)(66446008)(110136005)(446003)(14444005)(71190400001)(8676002)(52536014)(81156014)(5660300002)(44832011)(66476007)(7736002)(6116002)(25786009)(486006)(316002)(14454004)(4326008)(53936002)(6246003)(68736007)(3846002)(55016002)(2906002)(478600001)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY1PR04MB2154;
 H:CY1PR04MB2268.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sTcKMAdC6Zj47VMqE9J882oROI6gL9YMbekcsHLMF7/FPQcvHHyBM+51Az9GZWQyZeGVDPS6TNJ8CIin0CKuC0DbFh/Bz2rzzrwBGIC/Ip0QHKjzgnDZcM0SG2aQ46DR+lzMfvEZggbZ2s1pqSr2X9rxZJwRFh3/boYxBrxTWSo2muxcnCCc2Yu/XpWHG2ZXZEIToYwxhiPQSv0Bbl/GDlKyydB0C9rFufGvBIW7TwpjtQf6wiSZNRzHAoSJDWt00jqiwsfJlOK+o6/sdWHCYfGrprLY1Xrc5GXGBGku/VucAhjRPxglh1lhtXEvaXdHKknWEojt8tfIa8NsmMFU6VgS9KKli4KVzZaA+naIMhq3iRrHEnk5/6dA0cg373vKlT5G/iOV9/Pto+1RvHde5ToxVFkcXD94lA/CzCIFbLU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8141b1-be2a-49f8-01cc-08d6feb8ac0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 06:44:03.1709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shinichiro.kawasaki@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2154
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
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

On 7/1/19 8:56 PM, Paolo Bonzini wrote:=0A=
> On 01/07/19 12:14, Shinichiro Kawasaki wrote:=0A=
>> I observe four of them listed below in sense data,=0A=
>> when I ran basic operations to the zoned storage from the guest via scsi=
-block.=0A=
>>=0A=
>>       21h 04h: UNALIGNED WRITE COMMAND=0A=
>>       21h 05h: WRITE BOUNDARY VIOLATION=0A=
>>       21h 06h: ATTEMPT TO READ INVALID DATA=0A=
>>       55h 0Eh: INSUFFICIENT ZONE RESOURCES=0A=
>>=0A=
>> These ASCs can be reported for write or read commands due to unexpected =
zone=0A=
>> status or write pointer status. Reporting these ASCs to the guest, the u=
ser=0A=
>> applications can handle them to manage zone/write pointer status, or hel=
p the=0A=
>> user application developers to understand the failure reason and fix bug=
s.=0A=
>>=0A=
>> I took a look in scsi_sense_to_errno() and learned that ASCs are grouped=
 in=0A=
>> errnos. To report the ASCs above to the guest, is it good to add them in=
 EINVAL=0A=
>> group defined in scsi_sense_to_errno()? The ASCs are reported with sense=
 key=0A=
>> ILLEGAL_REQUEST or DATA_PROTECT, then I think it fits in the function.=
=0A=
> =0A=
> The grouping by errno is historical and pretty much broken.  It should=0A=
> be possible to change it to return just a bool.=0A=
=0A=
The errno grouping of scsi_sense_to_errno() is used not only by scsi-disk b=
ut =0A=
also by block/iscsi for error reporting. Can we avoid errno grouping for is=
csi also?=0A=
=0A=
If the errno grouping is not valuable for iscsi, single error code (EIO?) c=
an be =0A=
reported for all iscsi failures. If the errno grouping is useful for iscsi,=
 I =0A=
can create a patch to avoid errno grouping only for scsi-disk, leaving =0A=
scsi_sense_to_errno() for iscsi.=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=

