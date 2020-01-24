Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CEDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9200F2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="fQxxYYr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9200F2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv346-0003hg-Qy
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1iv338-00036w-93
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1iv337-0005Zx-3H
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:47:17 -0500
Received: from mail-mw2nam10on2116.outbound.protection.outlook.com
 ([40.107.94.116]:21632 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1iv336-0005Yp-M8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:47:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO2wcDPc+46H1tVbfIJFMF0DBPg3Tc8o9rCqlFXm/Ci9PpSR0r/yLr3K6lhZ9eeAG420V0Y627+Jf2N5c8AjkBxLiOBuZeKjjTE1KFVa85fZNBspf/vIiLZMOSqp5v8VJKii+wwhu4yrPgemFaSxudtrVQnXzoqyDRMK8ojLhPovW9fRrrdakAHXh4vK2yx0fn5rvdd/MM/9PrAclyFQ6DZSAgy5givW/WryueDZX6t5eBuHv3nOW+M0nZcEUP1JW3gpx5WdVng0uQsLVHqsNRdIL57aYPXAHPtNrMw5CioOhuPoDfG77JZMU8ySXqmX+JRxOiaKb8yZBfvtbrpLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrFl80WWcygiZrYMh4ptmWs4WWEzQOdVUNYwL+QZK28=;
 b=dP+t220sKs2wIoC8cv67rtuYGS3PKqnML6sfrrBZrxGYgx8PJshK1/+Cme1HfoIlcQ3H0DbxAIRKL9LQGPqmIGUZlN42g1Ol4C3qN0YYqWkRtg+kn31baAmRoxmLbcBcanHRrAooxWqLzjy/Z03cxCfnNQugK4/n5jv0CkDaDxwIeImzdHx1/3s8FSbi5PlEKbqsmuc1CBYVsu1f6WhQTif+RujEXLyKBzwH/WWtY1/SnwuPOOFelys9BQOyXk73ammtwp8HuMEXVtAf16SFB6svyqrFgR/W3SAqir9vSJbcZv+5/kbFqoKljKxDQ2its1PEEZ/JqAyYjl65gTN8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrFl80WWcygiZrYMh4ptmWs4WWEzQOdVUNYwL+QZK28=;
 b=fQxxYYr2JosnGjXEZy3RLlO9QaNlti7De66RDMpJEAvoNNNhVal44IzbMX14KYl93JFM5SFQ7u/gxLH5RkXBJwHAnnletlOS5TbjWJI7ZOBwpN7zXUZAQBx4tf9gxMxDs76ktUd0EeMiUJcHrRXUfB05VOG3fi5F7x9YCoV5I2U=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1555.namprd22.prod.outlook.com (10.174.81.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Fri, 24 Jan 2020 17:47:13 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::1594:9447:698:8486]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::1594:9447:698:8486%6]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 17:47:13 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [EXTERNAL][PULL 0/7] MIPS queue for January 24th, 2020
Thread-Topic: [EXTERNAL][PULL 0/7] MIPS queue for January 24th, 2020
Thread-Index: AQHV0t1ylmERqGh0GU6immV1sDP946f6FppJ
Date: Fri, 24 Jan 2020 17:47:13 +0000
Message-ID: <BN6PR2201MB12519AA892772D96C4B3993CC60E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1579887646-5949-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1579887646-5949-1-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 110ac066-8852-4987-5b88-08d7a0f5720a
x-ms-traffictypediagnostic: BN6PR2201MB1555:
x-microsoft-antispam-prvs: <BN6PR2201MB155598E888936E6EBACE6008C60E0@BN6PR2201MB1555.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39840400004)(376002)(136003)(346002)(189003)(199004)(33656002)(55016002)(9686003)(7696005)(86362001)(558084003)(316002)(110136005)(71200400001)(8936002)(81156014)(81166006)(8676002)(55236004)(66446008)(2906002)(66556008)(66476007)(66946007)(64756008)(508600001)(186003)(91956017)(5660300002)(52536014)(26005)(6506007)(76116006)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1555;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uq9a1To5zn0djyUZMaURmb5D/pmb7K1+A1kqxXFi448ygnt7n7lYaP+KUF3Iisyqtx+h0oGO//kLNHMtm/OxHBLkgV9WfZCZuxIGRJglvk0pQdgtEdP1hLKy2ZbeD1UcU7mU94KaIImvT4MSH++y+QcBQaQfSi8LVgxYCML+/iIsdphp8mDKDqlXEDpyVX5DVtD57OX4YgQ96Ctm0qBwyZCyWBoev8nowc/GGUhgrd9OQnTUtcypkbQB/c1kV8ZdtmtPPaYybQVLytkIOqwafU8oz4SKFK21N8LpgsJ6ZjihsquWpC7RMQaohlGH5QmibfWhvVyXfbgyHnbzoPz6oY/6/w+/l2yoNxTFY6yvyYGV15aZTJW3WHqSnolU+8tuu2R2GhghfTLA5q76MRUURDgjs5Ga6E1Yz5rGLAcfBftLLu9suYU9NS7SAZ1sY6fU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110ac066-8852-4987-5b88-08d7a0f5720a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 17:47:13.5328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZ49Co1rfM5UNlqoixvzZ0kuEDGwFcQFDqtUraheM1qtHG8IhvzCAPNvUgR0wIcnBcUA1NI+VERaA5hTCgrbiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1555
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.116
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
=0A=
> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>=0A=
> Cc: peter.maydell@linaro.org; Aleksandar Markovic=0A=
> Subject: [EXTERNAL][PULL 0/7] MIPS queue for January 24th, 2020=0A=
=0A=
I forgot one "Signed-off-by:". Will send v2 shortly.=0A=
=0A=
Thanks,=0A=
Aleksandar=0A=

