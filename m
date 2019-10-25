Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B340CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C955F21872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="c8z9y1DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C955F21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2iL-0003O2-Rx
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1iO2gT-0000ia-Ne
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1iO2gS-00012T-P5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:43:29 -0400
Received: from mail-eopbgr720098.outbound.protection.outlook.com
 ([40.107.72.98]:36112 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1iO2gS-0000yf-Bh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:43:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPyIelOlZSexs3jgWKbl5cy4t0dNX1SzqRw9Ie1KHEsS/5JgLayHDbhUXAkfLAGebiBKjHv1FXh3fK6oFYIY1cs6GKCnwzmUivI6+6pUqvPNRchGVjxhauvKvcvBD6pjM6A3R2EIzdvsNwTequRH+pQf/JMUvhxkZDpQWm6/LneL/dvLgdTKzSc89kfWc4fu068nNf0bAHEL+c9L4UGK7z6Eoc5ZTejE8aYUEapYClDDQKDWWNdgdU68xtFmQhmhFGPXrYnPbaFCF2HULVHpDNfkYXKukIWFr25K5h3gPEO47KuGjkReme9gKkTUtYML8X0TJXiTXdCYCzLe2IuRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/32WKVFh4f2EhZsKs4UJrGl2sCU0mBAQPuijhgzC04=;
 b=NlYCaNKKyioKdsBc6K6UGVgU1m3sjz3LZqLodHmBwSd/xg3p6l1vDPkmlaU5usFD2BGFWf+mzTLSgc6M8da+QY8KMoaDoM+EPKxJYtC/qcamzI/WpYJ5Fr1RZnWv2ZNrwQgXEV/o2jdNCL9W+ZGui7du/GlssbxL0qNN3xLJbMNecgNfXNWrazWuX2ncEM8Wh+z+fRZdJTEz5n+VZCCQeNazKUUZhwcDV5nb/dt/IehASNqbZ+37wiOfBSLWmBfg+dKO5FGj0izMJrF/Xiaer0JhbfRx+sIP0Uqv0CQoja52Fx6lT1/cbnFmZCjHVleHDy31SAm0/TSsKdEbEoozfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/32WKVFh4f2EhZsKs4UJrGl2sCU0mBAQPuijhgzC04=;
 b=c8z9y1DPfLou6MrNuT8x7XnN5ArojlMdK5x3tnL0EJBgVZAwCocfSWUO+g8tJbFms4NZzJjg2yhQOkJJHNcxWUEEsR9Ut/GYU41MYF2nByiVzjwW+6chhoo5LGbHIO5ZJqNzaFElXDnWfCz+4mW4SS8sRw0yhZ+PF9qcvZpUgPE=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1555.namprd22.prod.outlook.com (10.174.81.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 16:43:15 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::850f:a4cc:f2f8:364a]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::850f:a4cc:f2f8:364a%11]) with mapi id 15.20.2367.025; Fri, 25 Oct
 2019 16:43:15 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic
 <aleksandar.markovic@rt-rk.com>
Subject: Re: [EXTERNAL]Re: [PULL 00/11] MIPS queue for October 24th, 2019
Thread-Topic: [EXTERNAL]Re: [PULL 00/11] MIPS queue for October 24th, 2019
Thread-Index: AQHVixcS8n6SCPd4PkKMyhAuK+OhzKdrkBad
Date: Fri, 25 Oct 2019 16:43:15 +0000
Message-ID: <BN6PR2201MB1251CCF53610941977596E8DC6650@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1571915195-4381-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <CAFEAcA-Eawy4t-aGG7u7jR389bUqHab8KX7VSmZUEUjZxbABCQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-Eawy4t-aGG7u7jR389bUqHab8KX7VSmZUEUjZxbABCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f797f21-d651-497c-46f8-08d7596a6eb4
x-ms-traffictypediagnostic: BN6PR2201MB1555:
x-microsoft-antispam-prvs: <BN6PR2201MB1555EFBCE166E48ED7E8A10DC6650@BN6PR2201MB1555.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(39840400004)(396003)(199004)(189003)(99286004)(558084003)(5660300002)(8936002)(316002)(2906002)(7736002)(110136005)(81156014)(91956017)(74316002)(8676002)(305945005)(81166006)(3846002)(33656002)(71200400001)(446003)(14454004)(25786009)(478600001)(256004)(86362001)(6506007)(6116002)(76176011)(486006)(55236004)(7696005)(9686003)(186003)(55016002)(66556008)(66476007)(76116006)(4326008)(66946007)(66446008)(6436002)(64756008)(26005)(6246003)(11346002)(71190400001)(229853002)(476003)(52536014)(66066001)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1555;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xKY0qJBs3CHsTSipcqUYPJAU9fGjUQQGH8PXlsSBOVMwsK11xEMyVot57B9lIZQhFFnvZmJy27fCD22jUYSroz8dXXVVy2GMUoFPUfmUx9QZSTjGcQEFSaCjiJNxNwvoblQq2E55gy6lNR3OTja9Ji30D8f9ZRfTSAWgrAT7/zYwN3B8L/7UXbGLq1dG0WILbSeseHY1DebkMH3mLKt22tEI+2SAaKCPKh8bINB6qv6pchkXHho5CL/ePTQgxrFD1j7js4CHyQFhzvjDYetaFWW1HxkeJgr5nO2PlMyLdiNFRwSHF16sUoFWR7GU/37PugAPoB5ub9P7iFFB566Oq8hHTXSRVg4a11aQNLo8z2XaE5tGc+i8FZfwhazZwDRS2SPE0CsM2t94ozaFQWc7wI7fIXw2eBqHnlI/A+kkZr+OVJ6l7noiKvvvdMz0Xrs+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f797f21-d651-497c-46f8-08d7596a6eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 16:43:15.1599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adWvq5xbQf6vKE7fN+EHCD4XvS2p4c4S1knrXIUr49rbbg3Z2/zOhBipO0x9u+4rU816JLkof+Kg8q8GftHDXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1555
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.98
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
> Hi; this fails to compile with 'implicit conversion' errors=0A=
> on clang (OSX, freebsd, openbsd, and linux):=0A=
=0A=
=0A=
I am going to send v2 shortly, that will not contain the offending patch.=
=0A=
=0A=
Sorry about this.=0A=
=0A=
Aleksandar=

