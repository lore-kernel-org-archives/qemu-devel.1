Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5538EC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AD721D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="bjkAYDOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AD721D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD84z-0007cm-8P
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arikalo@wavecomp.com>) id 1iD82y-0006Kg-Vt
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1iD82x-0005ig-Pz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:13:36 -0400
Received: from mail-eopbgr680129.outbound.protection.outlook.com
 ([40.107.68.129]:51203 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1iD82x-0005iT-KA
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXyvF6Jh6FSfte3QG08Q4fIciiQ0o09WtGrDEJUeLFBjQ3EjQd5PLw412E4gJ3eYFeCHPE7/UoA4p+gSJcyhVt4HqqI2u/Blx1UCgW07TdQza3ZE41v9rOz47dg7n49BvsUXBPAlzqwrnkv87N/0chu/tOjVLHG7yVQ+FFNdxTTlnsWQcLqeUz1Xlydl74nCInEOXwutAuh4ztJESDgKgxmkBjqR9CvGfhVqzJeEjWwYM9fY8EFDPm4Xexn4tgXjXCGw1WIc/HeZoaOPL+q4R1PoI8/7/VSrJltzcYUowkRn6oduuHlkYt+eth3/ud5MddVjnEHS+4nWM7mLLr3BQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1UqI1LNXwCg65F0ws23hpxs6n8vlOdYjw15yojDCSo=;
 b=DaLBeQ485133vWAZ6NIVrmXkQCu+MydbNcszY8NfapT5Zn9NNwfJ/+5Dq99oXuuOJ5M2xpdpZjdaycmXDcgUH3dp86pdBWzKb3lkyPL2HMkZYjkP0/pZUmsOnxlfcC+HHcSfDuLibhw5k454bww/HVvQSefe2SvzXf80f4x9q9CKemhioz6PVEZTpsKM3AnAc8OfIpWM1aQl1bjeAs6Vsy3PqpWprhJwkN9/R0NYCGjTy7YahsoNrCOfc5CoAsfckcZo11vN2PsOTJvOO9g6U+Np7pFL15EVEI6ECzu2gUFpiqoUDD/g3Kc0TEn8lqRMI+ZSbcwKJiy/izUmfyZDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1UqI1LNXwCg65F0ws23hpxs6n8vlOdYjw15yojDCSo=;
 b=bjkAYDOuwW4IWUqtQ17EwYNjELT6P/lwt64C1BDKOLcHTjrIqT4pr4P8c5Idg2gn+99Z/+fJA9zNboNGBLCRj3nDFpOyi7M5vUw5KQ1ktP2VJuu0vTImu1ZkZJVYvlj8hFRFGM0alWKJPK8A+h0yjMdp9jEi5X8alzVHrkM9drk=
Received: from MWHPR22MB1664.namprd22.prod.outlook.com (10.164.206.142) by
 MWHPR22MB0397.namprd22.prod.outlook.com (10.173.54.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Wed, 25 Sep 2019 14:13:33 +0000
Received: from MWHPR22MB1664.namprd22.prod.outlook.com
 ([fe80::715e:bc1f:6393:9b00]) by MWHPR22MB1664.namprd22.prod.outlook.com
 ([fe80::715e:bc1f:6393:9b00%3]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 14:13:33 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL][PATCH v2 00/20] target/mips: Misc cleanups for
 September/October 2019
Thread-Topic: [EXTERNAL][PATCH v2 00/20] target/mips: Misc cleanups for
 September/October 2019
Thread-Index: AQHVc58+lebhCXHmDUiXkZWwejizLqc8b1dG
Date: Wed, 25 Sep 2019 14:13:33 +0000
Message-ID: <MWHPR22MB166436CC2F8311F4122EB3C7D2870@MWHPR22MB1664.namprd22.prod.outlook.com>
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b8beade-7969-418a-2b2d-08d741c28cc0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:MWHPR22MB0397; 
x-ms-traffictypediagnostic: MWHPR22MB0397:
x-microsoft-antispam-prvs: <MWHPR22MB0397E8647126EF4008D7921AD2870@MWHPR22MB0397.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(39840400004)(376002)(396003)(199004)(189003)(102836004)(6506007)(25786009)(52536014)(81156014)(9686003)(86362001)(55016002)(5660300002)(186003)(6436002)(76116006)(229853002)(64756008)(91956017)(66946007)(66556008)(66446008)(66476007)(478600001)(110136005)(256004)(6246003)(81166006)(8676002)(14454004)(316002)(6116002)(8936002)(2906002)(305945005)(33656002)(71200400001)(71190400001)(7736002)(2501003)(26005)(66066001)(53546011)(99286004)(446003)(11346002)(486006)(55236004)(76176011)(3846002)(74316002)(7696005)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR22MB0397;
 H:MWHPR22MB1664.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NEjW/nqFkeRvXDsN4N8LpWQToGCgoXexEGfl5K8NaBCYcmNC6or+In+S246OLokelNFIoZb7/Wi+hSOrrS4JuooZSOa/k+EZzj6G2MhpLcbwybmZs+/8l8ezGcSx95O/of9vR+iaa7w3s8Pg7h+lo/tehGfM8JJeCTQhdTWWQ9vTY7ztoPQcYpeOl23zl4ftlxvnx0Yt06GrllOaKzktwMy8DSEUOt4ROkfVVTAYW14MzkseuX+maY5wQ/HxJTztdG74kFC701i9knTR9M8QuzUZdmkspcdK6uHcBqJ+GBMpM6F+bENXVyKT/y/TkcB1pQAWyunbE+LBvjR4po/ALl31Vs+Zu9qdKbfYDRXEJN/0P8thn11/vKrX/kOFs4/YFUrWuyQZ7oRLqyVYGQm80pfXg+LfsL6siBWFbYY5SxA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8beade-7969-418a-2b2d-08d741c28cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 14:13:33.6250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kgRiFNMWC1kDT+omCfiouXgsJpxu0ccQgqNYfBAUeoJSE5OcgISzWVf3+3QY4v2y274oRw2SzhDdGDNU8nLo1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR22MB0397
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.129
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>=0A=
> Sent: Wednesday, September 25, 2019 2:45 PM=0A=
> To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>=0A=
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>=0A=
> Subject: [EXTERNAL][PATCH v2 00/20] target/mips: Misc cleanups for Septem=
ber/October 2019=0A=
>  =0A=
> From: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
>=0A=
> Mostly cosmetic changes.=0A=
>=0A=
> Aleksandar Markovic (20):=0A=
>   target/mips: Clean up helper.c=0A=
>   target/mips: Clean up internal.h=0A=
>   target/mips: Clean up kvm_mips.h=0A=
>   target/mips: Clean up mips-defs.h=0A=
>   target/mips: Clean up op_helper.c=0A=
>   target/mips: Clean up translate.c=0A=
>   target/mips: msa: Split helpers for <NLOC|NLZC>.<B|H|W|D>=0A=
>   target/mips: msa: Split helpers for PCNT.<B|H|W|D>=0A=
>   target/mips: msa: Split helpers for BINS<L|R>.<B|H|W|D>=0A=
>   target/mips: msa: Unroll loops and demacro <BMNZ|BMZ|BSEL>.V=0A=
>   target/mips: msa: Split helpers for B<CLR|NEG|SEL>.<B|H|W|D>=0A=
>   target/mips: msa: Split helpers for AVE_<S|U>.<B|H|W|D>=0A=
>   target/mips: msa: Split helpers for AVER_<S|U>.<B|H|W|D>=0A=
>   target/mips: msa: Split helpers for CEQ.<B|H|W|D>=0A=
>   target/mips: msa: Split helpers for CLE_<S|U>.<B|H|W|D>=0A=
>   target/mips: msa: Split helpers for CLT_<S|U>.<B|H|W|D>=0A=
>   target/mips: msa: Split helpers for DIV_<S|U>.<B|H|W|D>=0A=
>   target/mips: msa: Split helpers for MOD_<S|U>.<B|H|W|D>=0A=
>   target/mips: msa: Simplify and move helper for MOVE.V=0A=
>   target/mips: msa: Move helpers for <AND|NOR|OR|XOR>.V=0A=
>=0A=
>  target/mips/helper.c     |  132 +--=0A=
>  target/mips/helper.h     |  144 +++-=0A=
>  target/mips/internal.h   |   60 +-=0A=
>  target/mips/kvm_mips.h   |    2 +-=0A=
>  target/mips/mips-defs.h  |   53 +-=0A=
>  target/mips/msa_helper.c | 2115 ++++++++++++++++++++++++++++++++++++----=
------=0A=
>  target/mips/op_helper.c  |  913 +++++++++++++-------=0A=
>  target/mips/translate.c  |  421 +++++++--=0A=
>  8 files changed, 2888 insertions(+), 952 deletions(-)=0A=
>=0A=
> --=0A=
> 2.7.4=0A=
=0A=
Make sure you run all our MSA regression unit tests before applying.=0A=
Also, there are more than 80 characters lines in patches 12, 13, 15, 16, 17=
 and 18.=0A=
=0A=
Otherwise, for the whole series:=0A=
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>=

