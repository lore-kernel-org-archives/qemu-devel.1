Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E5CC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7E22082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="mftFgKFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7E22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycfO-0001TC-DV
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1iyceV-0000p2-Nr
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1iyceT-0006Bj-3j
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:24:39 -0500
Received: from mail-eopbgr700090.outbound.protection.outlook.com
 ([40.107.70.90]:49583 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1iyceS-0006A0-Qu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:24:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T27VXXxyRgg3iLqEmBt5HF/Pz/2G6ynX3jUlNRRpLip5pzbb88yOCTlrnf+bkWu608p38RccPxm7UcvzPnrpWBRabux/hCaaS4yAoOl8mBmltfBr0vkCLWGa+yGDhGmh8ZORG2u6QQZoAOm+EdmPbe1kz+AmbwYyBvMYKbSdSehOzXAL+e6CurE9bnmjh+eqCOkLkQ7wQaSHMQZw+iluyX6HwWmzTXxBCcxxd0UuqQkOqZAOAoBNRZxIzHEzNma5ksDSDjpi/ci4L0OIsYKKFJJ4d4Cj98mJ2P9Sdma7fG+cXkalzVOiauuplc16RY8LYe7k2JxnU44G2wig2nOyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rm5mgeI0hnQp/EOFQuHx/YKEork2ldF1NctVrxnK2UM=;
 b=kiysw9sxRU5jsJTo7fnvAdjJK9Ctmy3V4zV5fbY5lz8RliVM9VMGsGyrrJrywQIKGML02/E7nNdwSKfxd4f/y+S4i9fsjO7v9J3NBurmFy4g4b+lmqMegWZsiX+HiuusZgKk7PP+Vik//NlL3z4DdWMAKCURAEomV3/tOqOtk2a4elrtfniwHivDB6a/E375ueDnyTeO8WyRebQ/twJXVu9hQdKrXDRYeVMjrpvBOAXydU+tq+yxi48Q+O2sHdtV7Fk9yAdh7pzwEgyLgB4p9hmUbjyNVonTvL+0DWZrd8a+trXlIKgsQ7riHu4S6HY59pQCmEQ4cSTnbccG3fbBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rm5mgeI0hnQp/EOFQuHx/YKEork2ldF1NctVrxnK2UM=;
 b=mftFgKFKVPUlwVVPkQzBkUWY1qcalJVtqG9c6VEeH4lMzcjzfIqMG8uEaHNN1lauHKqaB2iIzCCy2/Pao/s7kuRZvJZ9ynPGaHGYdJkNND7ptaaQFituS//x7EJ9cBuBovB4VbjEmIRBrM2RWDxFWQtHtmrAPmWrivAlQOQ6imI=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1522.namprd22.prod.outlook.com (10.174.90.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34; Mon, 3 Feb 2020 14:24:32 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c804:a036:269:9290]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c804:a036:269:9290%4]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 14:24:32 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Richard Henderson <richard.henderson@linaro.org>, James Clarke
 <jrtc27@jrtc27.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [EXTERNAL]Re: [PATCH] target/mips: Fix ll/sc after
 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f
Thread-Topic: [EXTERNAL]Re: [PATCH] target/mips: Fix ll/sc after
 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f
Thread-Index: AQHV2mbY4J7aXy2RR0GQyuxjE3PI1KgJhdki
Date: Mon, 3 Feb 2020 14:24:32 +0000
Message-ID: <BN6PR2201MB1251B0561D85C7C68BF90C8EC6000@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20200202153409.28534-1-jrtc27@jrtc27.com>,
 <75960e9f-3d28-4db6-ba9a-098b576c6d9d@linaro.org>
In-Reply-To: <75960e9f-3d28-4db6-ba9a-098b576c6d9d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef0a937e-2086-4ba1-04e1-08d7a8b4c976
x-ms-traffictypediagnostic: BN6PR2201MB1522:
x-microsoft-antispam-prvs: <BN6PR2201MB15221E0368E7FC5D1C6E02E5C6000@BN6PR2201MB1522.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39830400003)(346002)(396003)(366004)(376002)(136003)(199004)(189003)(81156014)(81166006)(8936002)(86362001)(71200400001)(8676002)(186003)(2906002)(76116006)(52536014)(91956017)(4326008)(9686003)(66556008)(316002)(33656002)(64756008)(66446008)(66476007)(66946007)(55016002)(54906003)(110136005)(53546011)(55236004)(26005)(508600001)(6506007)(7696005)(966005)(5660300002)(98903001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1522;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+XxmewO+nX0yphpptRDZ9CEjltyyoF0+RtE7bir8yCJOi+pNQ+7W5gWtXB8KLVtJhjabLkt8V+EUcF4gYhrphSQEWu99EdNMAwETJmmvekcWR/iDthzbyEQif3OMADSBfGRnK96nZ9/9VvzDT3eo/RaKzVSssbnNMOht+X1MHQSkoUrwYX7mVaQr5QLR/rbSKvqn/kNd6OZZjFHwLQULirAhEJrshlT/CHPqyz3hIk/ifwWd7do8dEDS7GwDPmBBh6hoLPY+3JkC9AKOk9dOeK5nkZvxrU0/NaD4b4g+K5JlCln2DxwtO37p5iH2tiY+vy8RTdu/qfoo7+S6rm/Gj1bdGgdr1gcE0rXQ44a8ycsXAFXSWg82KvAfPOs6xtRf09z0KzfyZ2yrO0Ye/Dd4G0xvn2X7exufJu+aHQnzGuketfYO04DU8qnjekaNOwG+ugXG8k7bd/6bdnQStTkef99lIB6CCIlhruquq/eO/KMOQSH7eExxpby4owdLF2t7CMZZQ+3LkZMe6fJQta6OvSJtlEAcK0IazoFvhSXRxObVpQffX6VNjN63/2PaS6L
x-ms-exchange-antispam-messagedata: 3tBpGeMmkvDfCNmbDZWh1/c8KgNdaQtkmjm4WTY13ZYQa4GxgkBFGiwWcqtMs4gtomq80vg4EGIhO/HS90mLwKaXIibNqivxuWqfNR8XqPykS3QooWreH6oYhH0dON/z3om7Q76TACYavwedNiuPAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0a937e-2086-4ba1-04e1-08d7a8b4c976
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 14:24:32.0520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1TIYn4Fcot6MI58FH/C/yUn/J1D+SPQ30PYS0tfTCEKxrhhAiSPB7WcoX5oApm2dkqhAI9CGXrwvX8YmooSeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1522
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.90
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Richard Henderson <richard.henderson@linaro.org>=0A=
> Sent: Monday, February 3, 2020 8:52 AM=0A=
> To: James Clarke; qemu-devel@nongnu.org=0A=
> Cc: Alex Richardson; Aurelien Jarno; Aleksandar Markovic; Aleksandar Rika=
lo=0A=
> Subject: [EXTERNAL]Re: [PATCH] target/mips: Fix ll/sc after > 7dd547e5ab6=
b31e7a0cfc182d3ad131dd55a948f=0A=
> =0A=
> On 2/2/20 3:34 PM, James Clarke wrote:=0A=
> > From: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>=0A=
> >=0A=
> > After 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f the env->llval value is=
=0A=
> > loaded as an unsigned value (instead of sign-extended as before).=0A=
> > Therefore, the CMPXCHG in gen_st_cond() in translate.c fails if the sig=
n=0A=
> > bit is set in the loaded value.=0A=
> > Fix this by sign-extending the llval value for the 32-bit case.=0A=
> >=0A=
> > I discovered this issue because FreeBSD MIPS64 was looping forever in a=
n=0A=
> > atomic helper function when trying to start /sbin/init.=0A=
> >=0A=
> > Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>=0A=
> > Fixes: 7dd547e5ab6b ("target/mips: Use cpu_*_mmuidx_ra instead of MMU_M=
ODE*_SUFFIX")=0A=
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1861605=0A=
> > Cc: Aurelien Jarno <aurelien@aurel32.net>=0A=
> > Cc: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
> > Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>=0A=
> > Cc: Richard Henderson <richard.henderson@linaro.org>=0A=
> > Signed-off-by: James Clarke <jrtc27@jrtc27.com>=0A=
> > ---=0A=
> >  target/mips/op_helper.c | 8 ++++----=0A=
> >  1 file changed, 4 insertions(+), 4 deletions(-)=0A=
> =0A=
> My fault.  Sorry about that.=0A=
> =0A=
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>=0A=
> =0A=
=0A=
Applied to the next mips queue.=0A=
=0A=
Thanks to everyone involved!!=0A=
=0A=
Aleksandar=0A=
=0A=
> =0A=
r~=0A=

