Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9475CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A6920700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KWOtCsv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A6920700
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMv2U-0003OP-Ab
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron@os.amperecomputing.com>) id 1iMuu0-0001uD-PC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1iMutz-0005P7-Qd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:12:48 -0400
Received: from mail-eopbgr780105.outbound.protection.outlook.com
 ([40.107.78.105]:6328 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1iMuty-0005O5-1O
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:12:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGCq1AIIACnecXZZxeeqzKRg3SfHrZr9bT8g7t0OHAQbN1inAOUOaXDHwTICptISexJnvdKGCBSRGYl4w2/Zo7UD0sjKRorKEwJUfWJCywXABZQXNPonYf4SGHy1Xu1AetVjIjMi1p5ET/KEx8JJxt0L9UKild0uAkVM6HjXtY059KswMntnFefEHCXrTvZlv9N3POcJ2Z+gs7U2fVvotMFdEKoPFAX7k3pCRMSH2Unkqnx8sFslG8vnHPXpU6YKOTkuVG6Gi+mgYLrOqn0Q1tlPi1Ahl2ikCmciAZJHgFYcltUxwfWpTXKKeUAoSdmxXp7Wo627lXGDuZADW37+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXomyPeBUs3gHAXjvCeY6AENdEGPAZ2/d1bzyPvrMvg=;
 b=CMCFjkADcIH+pCCLXwbGkeWMpkh57+JijxSx3RL3FKYAtS/pYYbJNgplb2LNqGfVBgvjK8iWni1W3e0xYJeiYmckWdfor6KHgaU+2Dy68CdukODc10WpgykLN0iWmo9VOOXwluIPRawxIimlnRD02aysziy6mBFgT2wSKLHfZnz6dX/KjLYi1zvDyWkty8SCzr/ooox5H8/M16gcRr/zV4QQuJHDy7y2DvhBYGk1cUq5CnIvi7uu52fSOolj5uTrttSUO+nI38eXYbQl8BcRAhHS6Aa9Le+V4hKihui8tlFgXggzR6ZE0kb40CSwHS5KncW9Ij1dY351N+hN34Br1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXomyPeBUs3gHAXjvCeY6AENdEGPAZ2/d1bzyPvrMvg=;
 b=KWOtCsv8RX+dqJn2TG66oQ4FvoQZBvycsY4rbdv1aBLAaugmbu9G3WbQnsW7cLKxOMJ94GtdXgBKUszBGecUbK0Rry9S5UXWtxsEv5HKuVpZKJQuk9FdfV0JboH3sVf8MWPyecKpDksvNcIbbgnSFxnEubBJPDLd0jPW3C1bLbQ=
Received: from DM6PR01MB6027.prod.exchangelabs.com (52.132.249.89) by
 DM6PR01MB5164.prod.exchangelabs.com (20.176.121.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 22 Oct 2019 14:12:42 +0000
Received: from DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::3029:7c3:24fc:bb60]) by DM6PR01MB6027.prod.exchangelabs.com
 ([fe80::3029:7c3:24fc:bb60%7]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 14:12:42 +0000
From: Aaron Lindsay OS <aaron@os.amperecomputing.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "cota@braap.org"
 <cota@braap.org>, "peter.puhov@futurewei.com" <peter.puhov@futurewei.com>,
 "robert.foley@futurewei.com" <robert.foley@futurewei.com>
Subject: Re: [PATCH  v6 54/54] scripts/checkpatch.pl: don't complain about
 (foo, /* empty */)
Thread-Topic: [PATCH  v6 54/54] scripts/checkpatch.pl: don't complain about
 (foo, /* empty */)
Thread-Index: AQHVhO5bzPQS85aN70OLU/D5vJfzUKdmu5OA
Date: Tue, 22 Oct 2019 14:12:42 +0000
Message-ID: <20191022141221.GH42857@RDU-FVFX20TUHV2H>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
 <20191017131615.19660-55-alex.bennee@linaro.org>
In-Reply-To: <20191017131615.19660-55-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY1PR07CA0011.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::21) To DM6PR01MB6027.prod.exchangelabs.com
 (2603:10b6:5:1da::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8b09fe2-40f2-4859-055d-08d756f9e71e
x-ms-traffictypediagnostic: DM6PR01MB5164:
x-microsoft-antispam-prvs: <DM6PR01MB5164124B7C6A9ADF93EC02A68A680@DM6PR01MB5164.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(7916004)(136003)(376002)(346002)(366004)(39850400004)(396003)(199004)(189003)(14454004)(33656002)(478600001)(102836004)(52116002)(186003)(5660300002)(229853002)(14444005)(99286004)(256004)(6436002)(26005)(6916009)(1076003)(66574012)(76176011)(6486002)(4326008)(386003)(6506007)(66476007)(66556008)(66946007)(305945005)(6512007)(66446008)(3846002)(9686003)(54906003)(71200400001)(6116002)(558084003)(486006)(6246003)(8676002)(86362001)(316002)(8936002)(81166006)(81156014)(64756008)(25786009)(7736002)(66066001)(2906002)(33716001)(71190400001)(446003)(476003)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB5164;
 H:DM6PR01MB6027.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FOPYSsuTGQJq8OKNDq+RGJrFUunQzkZZgsg3JV/MeaDHn6kWiC618oiFbT6SZbqoPFA8pwGnqlo6isrDIczEUxGtZ91R9UbDnvj0htYSOv4j85bDlhLxHNr3lekWmYUCxfNGuFpgvoMu2/x9Fdx2VET3FZuJSLFhC6JtlhE4YsOXp6EP00lCd9tNf4Rq5arH5gTwMRXYHHnjWxeASl5Y3SUoYCvWPHDsbR8X60PIyI5O0TlwnVyDgf6IZ0UgNUlz9iRB5MHK415LKmSK36KkdDiW4ioTzViSqsBacLh4P+XWyI8d06DupTAr/EFJSo57TrQX79ZCBdYjZ0dJ7QTaQcazNqOmN8zvPNbkLINrwF0ZPeJPKGLucJTc3wUlulHCrwUjotap1DHoX2D3c7wjA6zJKCOnAF5mfegj4w5AuUw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7613B0DE722E4540812685888B035B61@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b09fe2-40f2-4859-055d-08d756f9e71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 14:12:42.2053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PfFb0q8CPjNS4AqOzXs6PUOTYHA5a2wBc1T9GwDXlurukpjbOsWAgx3purlOR2YEeK1VIDJAQ0z2yNVWf0MlCpfCw3e9oGtKg9v0UH+Z8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5164
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.105
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
> It's quite common to have a mini comment inside braces to acknowledge
> we know it's empty. Expand the inline detection to allow closing
> braces before the end of line.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>

