Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE023C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96E621783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D0nBjboT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96E621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUbI4-0005g5-VW
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 13:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sunilmut@microsoft.com>) id 1iUbHH-0005GK-B1
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sunilmut@microsoft.com>) id 1iUbHF-00081C-Rc
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:52:34 -0500
Received: from mail-eopbgr690100.outbound.protection.outlook.com
 ([40.107.69.100]:8819 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sunilmut@microsoft.com>)
 id 1iUbHF-0007z1-MN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:52:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ2xaZF/CrZPEDUIJBcygW0N1ciLA0vP0zJKNAECBk4xIjrxQCi8zk9A7AvOTRxSYlAVI4eErfj/Uhwlk4DtpLwlwWACHiJ8kOF5PFJfi3MpBmG3dBzjKMRdR45dv/3e8TKxUtsizbqjRqhAQ+YIRvZ/NEZajPbL8Mnb1rvEY9oJgo5sKRkaQZXAdHk2pfyZRiTetrzj8AFweuMSPH3fZDsgU7miJk5097xRXpZ15mY22x9O1KAXWTI0byGwHR+lf9fqBkJblJLJBES8dRSGsWI105JzI+LdE3UDTeRu46bekyBf3GK47tHr8qNUDqdUlHlVmzZJl0+AwUeWnlSItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47VxyZNnsQBmQZsLQHN75IXw+5EIeJsHCHGyp0ii4DU=;
 b=D3Zb//XBHacWpDzzvDD7TNPVKPm7Vd0g7eF82eoJDFuy1/UHGA2ys7qRSsmBwGaw5ZAT23ytQQ4m1s4nkW+9d8pTUfQeQNrTJHF54gLySQWBNjDt75Qrr5U5qinR7EHWXiVjJRmAKCZJ0Rnyfvrld+e+fzSS2tQdIa0v9Ik3B4gQ9GPGlQHs9OyWZcnBKvuQw5o2Cv3KeEy3gTK3a3QMu0zz6o1CO+uOE4MiGUFlMYzM5Ftz0l66Fl4SfT3z04CBbCCpFUpjyAgxHzaULXqG4YlUcFdpLQJoNqMWcVTMRiq4+YVNk/L3lp6rdaNIbnBVw86r5zh7X6jTbve709utqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47VxyZNnsQBmQZsLQHN75IXw+5EIeJsHCHGyp0ii4DU=;
 b=D0nBjboTr41iq4CzvnIh76c41nEgQPWe4i3Az+ZMSYwNQCZcyB2rqBvifdaTgOYLGtoaDuhNHnktSTsGe2t+uFzvsDpf/RVeZ9mcuET3z6Gkgk4zxt++kdAGeOu6zaRJVXBWz8DdxadJDFSsFVJakyScrWhTJnCDAVuxDVJg3ak=
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com (52.132.149.33) by
 MW2PR2101MB1003.namprd21.prod.outlook.com (52.132.146.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.6; Tue, 12 Nov 2019 18:52:31 +0000
Received: from MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9]) by MW2PR2101MB1116.namprd21.prod.outlook.com
 ([fe80::121:8a4f:76a8:fd9%6]) with mapi id 15.20.2451.018; Tue, 12 Nov 2019
 18:52:31 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2] WHPX: support for xcr0
Thread-Topic: [PATCH v2] WHPX: support for xcr0
Thread-Index: AdWVpCACQMQiiI0KR2iuY0/EuyLlQQD5hBew
Date: Tue, 12 Nov 2019 18:52:31 +0000
Message-ID: <MW2PR2101MB1116F6FEFFFB607B07CF4456C0770@MW2PR2101MB1116.namprd21.prod.outlook.com>
References: <MW2PR2101MB1116F07C07A26FD7A7ED8DCFC0780@MW2PR2101MB1116.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1116F07C07A26FD7A7ED8DCFC0780@MW2PR2101MB1116.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:4c8c:ac9e:157a:29d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69684bf6-25bb-4333-e348-08d767a178fb
x-ms-traffictypediagnostic: MW2PR2101MB1003:
x-microsoft-antispam-prvs: <MW2PR2101MB1003D4B4EC23068233054F5DC0770@MW2PR2101MB1003.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(39860400002)(396003)(376002)(136003)(346002)(366004)(13464003)(199004)(189003)(186003)(4326008)(52536014)(476003)(66946007)(64756008)(66556008)(25786009)(81156014)(81166006)(256004)(110136005)(7696005)(71190400001)(71200400001)(7736002)(76116006)(305945005)(14454004)(11346002)(486006)(8936002)(446003)(6246003)(102836004)(8676002)(46003)(9686003)(66476007)(2906002)(66446008)(10090500001)(6506007)(8990500004)(33656002)(55016002)(53546011)(76176011)(229853002)(5660300002)(6116002)(22452003)(316002)(4744005)(74316002)(478600001)(86362001)(10290500003)(99286004)(6436002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB1003;
 H:MW2PR2101MB1116.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9u194IrGRvDWMPZERcjra/Vtb+LR+JRVn613K2bgW6Xw3i/IraS4vFq+AMcDa75lc+brKfTNxWUAd1io+oOewbT+CGXvRjE+0PQNCNjqCDeVcBh+bAcQbiImgiiuz50vTzi7aWK2JLdCLJlmclcpPbJfU/TOXZ3H02kEYaCnTsEEBEM5oIrHUsb02mgmByAqtq1TSdw058Gte/jJuVgQiX9GXiwizaPLKLIjd9gyYLd4c8oKT4JKwPzFgxYpz/o0Ti6cWA0QodmiI/rs65f+ib+fYznpqQGtzS1AoxWyfkNMJUIj2VImZdlmqYIzvmewCcVKl3olJsPJ5RC9ss5LBlKQsX3/y4E06Zv11F9PWBl3yH0j5qV8lDkFY+9eKB0HxASFI770zSfstMcXp9E0KJIU8ior3/01pBLB5oDfixdnvGc4VLTKA4i1SVgqerJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69684bf6-25bb-4333-e348-08d767a178fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 18:52:31.1514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5arQfaEpldBpL38xLeceDMYTj/vrauXAPLaLUZYlLLlbILcxS4iRT+0pwcDn6V/dT9oD1MNowBJ2u6YH6JBoKEgqantA+TouxLiCRvmF2wU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1003
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.100
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



> -----Original Message-----
> From: Sunil Muthuswamy
> Sent: Thursday, November 7, 2019 11:49 AM
> To: Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.n=
et>; Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> Subject: [PATCH v2] WHPX: support for xcr0
>=20
> Support for xcr0 to be able to enable xsave/xrstor. This by itself
> is not sufficient to enable xsave/xrstor. WHPX XSAVE API's also
> needs to be hooked up.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> You will need the Windows 10 SDK for RS5 (build 17763) or above to
> to be able to compile this patch because of the definition of the
> XCR0 register.
>=20
> Changes since v1:
> - Added a sign-off line in the patch.
>=20

Is it possible to get some eyes on this?

