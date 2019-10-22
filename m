Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486EFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1398321872
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tQnakT/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1398321872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuw7-0004KG-OH
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron@os.amperecomputing.com>) id 1iMuoa-0002be-6B
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1iMuoZ-0002nV-1K
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:07:12 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com
 ([40.107.72.121]:30903 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1iMuoY-0002n0-RJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:07:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7xW+JBJHNXr0KXmBR97cq9N0fXl/qh6ji/EkdrB1TtTXBZh9/oaYcb5za30KeDlUvyVtJO7wDQ3xqfVE6ANl3SgFiMdqOee9Rb0V9s7J6+rYhjtooOVGlJ2cKqEePV7zixsCs9apPM7nZ7/luie2ltQnvmCurMdICpQqM1chX8dJTYSdpw6tJvPBS2EApiokWKVv7bpGCs0ra+ia+X31Hd24aVDnz3O+bgabkTffdjhovgMpT5b9KOze6YncTr7Mfuxy+nA1NGbK2TWbKRmztDzZ8+L6dOaTbWupCI9YBHCQLUthSJxMq5AjLHdhUjgUcQXnjGtIuIOTbpP4FphMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0+1EVVhcUf00loUVtV2NIHs20Q+61OHq35OaHFDFKQ=;
 b=caBxVCSR8BwoJ5VFrQGIEHCAvfBZuu4+f03tg12Odc2QM+2ouyeF8O8llXlc9U2EyGQ1J0Y+y5PLN/Oxr586twG98ztIiWCjLC15g1AgVl8UDm8A1uNPJDbInsaCOJpFDIH46dPh1U2BnHJXe4jaI3slkl/qEMPYRrlRZ24nLxeGyDc35vA3s53xSizVDwwDBLhQ3wwmP30d3ISr6QeRsAh/KwE1Mzfvxs/5llpeOIvAuklHxymQPtLis3ytRYH+hT3UBsBYQ58XFXhg21RmkcPgQcGeV00AOtXkYIbRHp+yj7JSWupcvcu44BAlxahpE02+xJKO80KPBvwLPmiUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0+1EVVhcUf00loUVtV2NIHs20Q+61OHq35OaHFDFKQ=;
 b=tQnakT/zMxcPTOjX+LefQRug9/cxXItrOXW8IBIFcBJU9/YGtYabUUlY10N9aR3yJ3zexuHYzWY7QS5jqz3+q6M/u8mUWmHAuHCi92iNh8fvwRsTILq+9pNdAR9ON/l43lq0YtCnfTZzGcBHm9Lx4RIQ5+dVIxmLGRgPJN+3Rk0=
Received: from DM6PR01MB6027.prod.exchangelabs.com (52.132.249.89) by
 DM6PR01MB5612.prod.exchangelabs.com (20.179.69.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 14:07:07 +0000
Received: from DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::3029:7c3:24fc:bb60]) by DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::3029:7c3:24fc:bb60%7]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 14:07:07 +0000
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "cota@braap.org"
 <cota@braap.org>, "peter.puhov@futurewei.com" <peter.puhov@futurewei.com>,
 "robert.foley@futurewei.com" <robert.foley@futurewei.com>
Subject: Re: [PATCH  v6 39/54] plugin: add qemu_plugin_outs helper
Thread-Topic: [PATCH  v6 39/54] plugin: add qemu_plugin_outs helper
Thread-Index: AQHVhO5VFQaxqC28QE2m7X2ER1g5SqdmugWA
Date: Tue, 22 Oct 2019 14:07:07 +0000
Message-ID: <20191022140647.GG42857@RDU-FVFX20TUHV2H>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
 <20191017131615.19660-40-alex.bennee@linaro.org>
In-Reply-To: <20191017131615.19660-40-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR01CA0022.prod.exchangelabs.com (2603:10b6:903:1f::32)
 To DM6PR01MB6027.prod.exchangelabs.com (2603:10b6:5:1da::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d5da8ce-233a-44db-0cd1-08d756f91f55
x-ms-traffictypediagnostic: DM6PR01MB5612:
x-microsoft-antispam-prvs: <DM6PR01MB561240C6DBE84CBC0DA02C1A8A680@DM6PR01MB5612.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(4636009)(39850400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(6436002)(6486002)(7736002)(305945005)(229853002)(14454004)(3846002)(6506007)(386003)(26005)(6116002)(99286004)(102836004)(1076003)(9686003)(4326008)(186003)(6512007)(66476007)(81166006)(446003)(66556008)(64756008)(5660300002)(86362001)(81156014)(8676002)(486006)(478600001)(476003)(8936002)(11346002)(66446008)(66946007)(33716001)(256004)(316002)(54906003)(25786009)(558084003)(33656002)(2906002)(6916009)(71200400001)(71190400001)(6246003)(52116002)(76176011)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB5612;
 H:DM6PR01MB6027.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /V6T7LzeWQPgx1ZQnja3h/kESHpeeC+fCEpvoSmiHqAxuHF07vQ/KQJAfvfr5rPeb5/y6n/t8CG/EOSFTzcds6TLeSEXBT1+63B15pM3bSwMWv2Ei4sXNp8tw/WN0Qla6frvGTZ8zKk6+hrBAhTK9FKKpPp3dCQj5qm+d2HSbVz+lgAC3w6fd/0BfjkdlEhQPJyN+axukGsCdV06sk/3038CYsrPlrnneMLdzv+fFcfyydmS56snyZAbF5t5wFeBFewcZfT26yirhjmA/si5YAYgDRIignqAHBaJ+Mmw0UKezmf9sUpHEqGPj3jMhMgwOKcFJATPeJH5g5bpSB9yiGAjHPxVx303J6oRUhPZB3MO1TWOMtrRV4Vkx364TNLvtgdxbiHU5C44aFW2BDg5FTTJRPuMzAyOL6LeQ+pqvmlBlk8LoXlaxCrXjy8NmUxM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <77FBF3CF0EB67543B3A13E0867BB963A@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5da8ce-233a-44db-0cd1-08d756f91f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 14:07:07.2095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkOUNRASPvElc5ZMy4tqW4Ry7O0R9CFlZ7uymzYULM3pRcby5/p9ZRkCy5uno1kriVq+BqA9bVXt/VUYshv5Wi6WEJQ/g9T3Erv32JQaJ2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5612
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.121
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

On Oct 17 14:16, Alex Benn=E9e wrote:
> Having the plugins grab stdout and spew stuff there is a bit ugly and
> certainly makes the tests look ugly. Provide a hook back into QEMU
> which can be redirected as needed.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>

