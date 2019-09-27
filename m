Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E59C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 12:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55D5207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 12:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.onmicrosoft.com header.i=@siemens.onmicrosoft.com header.b="jBGi+/fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55D5207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=etm.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDpPx-0002WU-TF
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 08:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thomas.strasser.ext@etm.at>) id 1iDmPl-0000VH-Ee
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thomas.strasser.ext@etm.at>) id 1iDmPj-0002ka-6P
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:19:48 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com
 ([40.107.3.46]:53483 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thomas.strasser.ext@etm.at>)
 id 1iDmPe-0002Ts-0Z; Fri, 27 Sep 2019 05:19:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUe6uFBJ0Ui4SU6vruZzOPnRs9yVY0giQNrgCtd/9ThbsjdAJOq51vZtQHVfgYan9LNfGnu3rSapcd9SxL6u896/pCCEx4gTyoA+jcH3zGXbsx6qMqxqwCq7vIq2KA9nq6TwfB+lZFCFOFgLmR6iCxkBxSpv0neAMopOE35lPE/YsqVizlzAs2RM5imMwZYePpc/sQ/gpiQt04DnllFd7kIyM/1YbkbQsvuVAbzt04JqlSe5rdQB+gjKMuF+IMzvT+xsj6cADeBzx4kn0/UoJuiDFRZxyKJfgn7g7OTZuWemH7NrjwPkSotTnVd5a2R3sNYZQEfUjl64CbVWN8b+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhqPgp2g4nmS2sx8AWR0sAnsyiNTQvIkJl6hKc0ni2A=;
 b=MDJYI4LANdYGhhDHaeAFak9/b5mDDn/csEZXwaZGsOlvBhHaJMnS0HLBDZjtyySPXOczZDS+VpMyrb19aFDUEeNuS+hOf2m+bhiHbCZv5gqBwVPUsaD6mDhf6svZ967tCKB5ICavXtfACWZCk6PMJWnFB10cYApdf0pNFrYVEhun6PmprDn+rXaLR2NaNAljCwowaG3DXBR8/nNALG2GNRbxNp/DLDzIuTmiuHKDQy3/ggDNx2atn0PZ3Jk2TmzQQHLDdhznEv4/r1Trk4aff08YOtLev4yOFtVQdQtumoHt9fa0g1qKHeZs/c/1Mr1aphfWJ54ZAVZaGS8wexfvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=etm.at; dmarc=pass action=none header.from=etm.at; dkim=pass
 header.d=etm.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens.onmicrosoft.com; s=selector2-siemens-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhqPgp2g4nmS2sx8AWR0sAnsyiNTQvIkJl6hKc0ni2A=;
 b=jBGi+/fqJT2l4IrMNWEnnxUhtpslj4FH1spQ0eSh3c4Bx2VA5uN42dM6trb3vraS8TMxufkFx4kutge9jQ+Fx+MlOG0lE5zrYY8Ydt7o9syVADehWTWDVLdigkcu4jDzIkz0EkRvLMMpqz8ZbYm/SY1rioGSyQ9MGFytbYt+nEU=
Received: from VE1PR10MB3407.EURPRD10.PROD.OUTLOOK.COM (10.255.158.30) by
 VE1PR10MB2880.EURPRD10.PROD.OUTLOOK.COM (10.255.158.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Fri, 27 Sep 2019 09:19:34 +0000
Received: from VE1PR10MB3407.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cee:f272:d480:77ba]) by VE1PR10MB3407.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cee:f272:d480:77ba%3]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 09:19:34 +0000
From: "thomas.strasser.ext@etm.at" <thomas.strasser.ext@etm.at>
To: "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>
Subject: qemu smb access problem host: linux, guest: win10
Thread-Topic: qemu smb access problem host: linux, guest: win10
Thread-Index: AQHVdRStG9kWAkgS30yZw90AHiTL1A==
Date: Fri, 27 Sep 2019 09:19:34 +0000
Message-ID: <223422.542537691-sendEmail@md2evabc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: sendEmail-1.56
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thomas.strasser.ext@etm.at; 
x-originating-ip: [194.138.39.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccb4d3ec-ef23-458a-4ada-08d7432bcfdc
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VE1PR10MB2880:
x-microsoft-antispam-prvs: <VE1PR10MB28805ADE86950E016584EFE1DB810@VE1PR10MB2880.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(8936002)(450100002)(50226002)(305945005)(256004)(14444005)(9686003)(6512007)(54896002)(5640700003)(6436002)(6486002)(476003)(81166006)(6506007)(26005)(66066001)(6916009)(2501003)(102836004)(81156014)(8676002)(7736002)(316002)(2351001)(186003)(86362001)(5660300002)(4326008)(14454004)(66946007)(76116006)(33716001)(91956017)(66446008)(66556008)(66476007)(64756008)(71200400001)(99286004)(6116002)(25786009)(71190400001)(3846002)(478600001)(2906002)(486006)(14943795004)(19607625011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR10MB2880;
 H:VE1PR10MB3407.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: etm.at does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tK0BfapguwpKyt0aXH9rReGXnThLDuDUmpWHFlCea5hApfxwmASAsvn+1uj96LZq4zKXQJsyAKyiK+yQGDm0ZmPb5brX7Sjg7zQGj19ok88fytVLGDwJPYj3bmqY7+xZ5zelYTumyGF401GHx3kXvvyMEz8mznmd8KUqNLsKmVJmTorvpXKAqyUmOQdJ36h2S/7KVh4XdORVESpYhwMqcZyWC/G5Ecogi7G8m/uxFLdR/nX5khsv/OJo4p2wakMmO8cbIAICEKaNKf8O1rrMVpXCdk1VYDxRra6jtKYZs3McO16IRJpCAXikUsucb8v7gyFYHh4m+8BoN2HFqAGAkoq+KqS95rCIqXLJZ05eUSMv4wVsT97Env5uJp1T4XwLbbCDZMuuhF5bBog2mLr9zhmh6Co5nNAX+V6okoSWpSI=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_223422542537691sendEmailmd2evabc_"
MIME-Version: 1.0
X-OriginatorOrg: etm.at
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb4d3ec-ef23-458a-4ada-08d7432bcfdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 09:19:34.5160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdxdG/zmdUEumNwQx2xviIXV5Bw9kyvERJEARp/BFwOpsel65e1TjY9HEMjEdZhOjlrWM+2wXYbgvSRsa6/ldhUsXrM1NtBusnW+Xc92VOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB2880
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.46
X-Mailman-Approved-At: Fri, 27 Sep 2019 08:31:19 -0400
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_223422542537691sendEmailmd2evabc_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8hDQoNCkkgaGF2ZSBwcm9ibGVtcywgYWNjZXNzaW5nIGEgc2hhcmVkIGZvbGRlciBmcm9t
IFdpbmRvd3MgMTAgZ3Vlc3Qgb24gbXkgT3BlblN1c2UgaG9zdCBtYWNoaW5lLg0KDQpJIGNhbiBh
Y2Nlc3MgdGhlIHNoYXJlZCBmb2xkZXIgaW4gbXkgdmlydHVhbCBtYWNoaW5lIHdpdGggXFwxOTIu
MTY4LjAuNFxxZW11Lg0KSG93ZXZlciwgSWYgSSBvcGVuIGl0IHdpdGggZXhwbG9yZXIgSSBnZXQg
YSBDb3VsZCBub3QgYWNjZXNzIFxcMTkyLjE2OC4wLjRccWVtdSBlcnJvci4NCkluIHRoZSBXaW5k
b3dzIGNvbW1hbmQgbGluZSBJIm0gZ2V0dGluZyBhIGZpbGUgbm90IGZvdW5kIG1lc3NhZ2UuDQpu
ZXQgdXNlIFxcMTkyLjE2OC4wLjRccWVtdSB3b3JrcyB3aXRob3V0IGFueSBwcm9ibGVtcy4NClRo
ZSBwZXJtaXNzaW9uIG9mIHRoZSBzaGFyZWQgZm9sZGVyICgvb3B0L3ZpcnRNYWNoaW5lcy9zaGFy
ZS13aW4xMCkgYW5kIGFsbCBmaWxlcyBpbiBpdCBpcyByd3hyd3hyd3guDQoNClRoZSBzbWJkIHZl
cnNpb24gaXMgNC43LjExLWdpdC4xNTMuYjM2Y2VhZjIyMzVscDE1MC4zLjE0LjEtU1VTRS1vUzE1
LjAteDg2XzY0Lg0KVGhlIHFlbXUgdmVyc2lvbiBpcyAyLjExLjIuDQoNCkkgc3RhcnQgdGhlIHFl
bXUgd2l0aCB0aGUgZm9sbG93aW5nIG9wdGlvbnM6DQoNCg0KcWVtdS1rdm0gLXNtcCA4LHNvY2tl
dHM9Mixjb3Jlcz00LHRocmVhZHM9MSAtY3B1IGhvc3Qsa3ZtPW9uIC1tIHNpemU9MTAyNCAtayBk
ZSBcDQogIC1iYWxsb29uIG5vbmUgXA0KICAtbW9uaXRvciB1bml4OnFlbXUtbW9uaXRvci1zb2Nr
ZXQsc2VydmVyLG5vd2FpdCAtZGFlbW9uaXplIFwNCiAgLWNkcm9tIC9vcHQvdmlydE1hY2hpbmVz
L2R2ZHMvZW1wdHkuaXNvIFwNCiAgLWhkYSAvb3B0L3ZpcnRNYWNoaW5lcy9pbWFnZXMvd2luMTAu
cWNvdzIgXA0KICAtZHJpdmUgZmlsZT0vb3B0L3ZpcnRNYWNoaW5lcy9pbWFnZXMvdnMtYW5kLXRv
b2xzLnFjb3cyIFwNCiAgLWRyaXZlIGZpbGU9L29wdC92aXJ0TWFjaGluZXMvaW1hZ2VzL3NyYy1h
bmQtYnVpbGQucWNvdzIgXA0KICAtZGlzcGxheSBzZGwgXA0KICAtdmdhIHZtd2FyZSBcDQogIC1u
ZXRkZXYgInVzZXIsaWQ9bXluZXQwLHJlc3RyaWN0PXksbmV0PTE5Mi4xNjguMC8yNCxkaGNwc3Rh
cnQ9MTkyLjE2OC4wLjEzMCxob3N0ZndkPXRjcDo6MjIyOC06MjIsaG9zdGZ3ZD10Y3A6OjIyMzgt
OjMzODksc21iPS9vcHQvdmlydE1hY2hpbmVzL3NoYXJlLXdpbjEwIiBcDQogIC1kZXZpY2UgcnRs
ODEzOSxuZXRkZXY9bXluZXQwIFwNCiAgLWJvb3Qgb3JkZXI9ZGMsbWVudT1vbiAtbm8tcXVpdA0K
DQoNCg0KSG93IGNhbiBJIGFjY2VzcyBteSBzaGFyZWQgZm9sZGVyPw0KDQpUaGFuayB5b3UhDQoN
CkhhdmUgYSBuaWNlIGRheQ0KDQogICBUaG9tYXMgU3RyYXNzZXINCg0K

--_000_223422542537691sendEmailmd2evabc_
Content-Type: text/html; charset="utf-8"
Content-ID: <B58A50C98039B4449FF40D15B0A1141C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzY3JpcHQgbGFuZ3VhZ2U9IkphdmFTY3JpcHQi
Pg0KZnVuY3Rpb24gd2lraTJodG1sX2V4cGFuZChlbnRUaXRsZSwgZW50TmFtZSkgew0KICB2YXIg
ZW50ID0gZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQoZW50TmFtZSk7DQogIHZhciB0aXRsZSA9ICLi
lrwiK2VudFRpdGxlLmlubmVySFRNTC5zdWJzdHIoMSk7DQogIGVudC5zdHlsZS5kaXNwbGF5ID0g
ImJsb2NrIjsNCiAgZW50VGl0bGUucGFyZW50RWxlbWVudC5pbm5lckhUTUwgPSAiPHNwYW4gb25j
bGljaz0iamF2YXNjcmlwdDp3aWtpMmh0bWxfY29sbGFwc2UodGhpcywgXCIiK2VudE5hbWUrIlwi
KSI+Iit0aXRsZSsiPC9zcGFuPiI7DQp9ZnVuY3Rpb24gd2lraTJodG1sX2NvbGxhcHNlKGVudFRp
dGxlLCBlbnROYW1lKSB7DQogIHZhciBlbnQgPSBkb2N1bWVudC5nZXRFbGVtZW50QnlJZChlbnRO
YW1lKTsNCiAgdmFyIHRpdGxlID0gIuKWuiIrZW50VGl0bGUuaW5uZXJIVE1MLnN1YnN0cigxKTsN
CiAgZW50LnN0eWxlLmRpc3BsYXkgPSAibm9uZSI7DQogIGVudFRpdGxlLnBhcmVudEVsZW1lbnQu
aW5uZXJIVE1MID0gIjxzcGFuIG9uY2xpY2s9ImphdmFzY3JpcHQ6d2lraTJodG1sX2V4cGFuZCh0
aGlzLCBcIiIrZW50TmFtZSsiXCIpIj4iK3RpdGxlKyI8L3NwYW4+IjsNCn0NCjwvc2NyaXB0Pjwh
LS0gT1JJR0lOQUwtV0lLSS1QQUdFOg0KSGVsbG8hDQoNCkkgaGF2ZSBwcm9ibGVtcywgYWNjZXNz
aW5nIGEgc2hhcmVkIGZvbGRlciBmcm9tIFdpbmRvd3MgMTAgZ3Vlc3Qgb24gbXkgT3BlblN1c2Ug
aG9zdCBtYWNoaW5lLg0KDQpJIGNhbiBhY2Nlc3MgdGhlIHNoYXJlZCBmb2xkZXIgaW4gbXkgdmly
dHVhbCBtYWNoaW5lIHdpdGggIiJcXDE5Mi4xNjguMC40XHFlbXUiIi4NCkhvd2V2ZXIsIElmIEkg
b3BlbiBpdCB3aXRoIGV4cGxvcmVyIEkgZ2V0IGEgIiJDb3VsZCBub3QgYWNjZXNzIFxcMTkyLjE2
OC4wLjRccWVtdSIiIGVycm9yLg0KSW4gdGhlIFdpbmRvd3MgY29tbWFuZCBsaW5lIEkibSBnZXR0
aW5nIGEgIiJmaWxlIG5vdCBmb3VuZCIiIG1lc3NhZ2UuDQoiIm5ldCB1c2UgXFwxOTIuMTY4LjAu
NFxxZW11IiIgd29ya3Mgd2l0aG91dCBhbnkgcHJvYmxlbXMuDQpUaGUgcGVybWlzc2lvbiBvZiB0
aGUgc2hhcmVkIGZvbGRlciAoIiIvb3B0L3ZpcnRNYWNoaW5lcy9zaGFyZS13aW4xMCIiKSBhbmQg
YWxsIGZpbGVzIGluIGl0IGlzIHJ3eHJ3eHJ3eC4NCg0KVGhlIHNtYmQgdmVyc2lvbiBpcyA0Ljcu
MTEtZ2l0LjE1My5iMzZjZWFmMjIzNWxwMTUwLjMuMTQuMS1TVVNFLW9TMTUuMC14ODZfNjQuDQpU
aGUgcWVtdSB2ZXJzaW9uIGlzIDIuMTEuMi4NCg0KSSBzdGFydCB0aGUgcWVtdSB3aXRoIHRoZSBm
b2xsb3dpbmcgb3B0aW9uczoNCnt7Iw0KcWVtdS1rdm0gLXNtcCA4LHNvY2tldHM9Mixjb3Jlcz00
LHRocmVhZHM9MSAtY3B1IGhvc3Qsa3ZtPW9uIC1tIHNpemU9MTAyNCAtayBkZSBcDQogIC1iYWxs
b29uIG5vbmUgXA0KICAtbW9uaXRvciB1bml4OnFlbXUtbW9uaXRvci1zb2NrZXQsc2VydmVyLG5v
d2FpdCAtZGFlbW9uaXplIFwNCiAgLWNkcm9tIC9vcHQvdmlydE1hY2hpbmVzL2R2ZHMvZW1wdHku
aXNvIFwNCiAgLWhkYSAvb3B0L3ZpcnRNYWNoaW5lcy9pbWFnZXMvd2luMTAucWNvdzIgXA0KICAt
ZHJpdmUgZmlsZT0vb3B0L3ZpcnRNYWNoaW5lcy9pbWFnZXMvdnMtYW5kLXRvb2xzLnFjb3cyIFwN
CiAgLWRyaXZlIGZpbGU9L29wdC92aXJ0TWFjaGluZXMvaW1hZ2VzL3NyYy1hbmQtYnVpbGQucWNv
dzIgXA0KICAtZGlzcGxheSBzZGwgXA0KICAtdmdhIHZtd2FyZSBcDQogIC1uZXRkZXYgInVzZXIs
aWQ9bXluZXQwLHJlc3RyaWN0PXksbmV0PTE5Mi4xNjguMC8yNCxkaGNwc3RhcnQ9MTkyLjE2OC4w
LjEzMCxob3N0ZndkPXRjcDo6MjIyOC06MjIsaG9zdGZ3ZD10Y3A6OjIyMzgtOjMzODksc21iPS9v
cHQvdmlydE1hY2hpbmVzL3NoYXJlLXdpbjEwIiBcDQogIC1kZXZpY2UgcnRsODEzOSxuZXRkZXY9
bXluZXQwIFwNCiAgLWJvb3Qgb3JkZXI9ZGMsbWVudT1vbiAtbm8tcXVpdA0KfX0NCg0KSG93IGNh
biBJIGFjY2VzcyBteSBzaGFyZWQgZm9sZGVyPw0KDQpUaGFuayB5b3UhDQoNCkhhdmUgYSBuaWNl
IGRheQ0KDQogICBUaG9tYXMgU3RyYXNzZXINCg0KDQotLT4NCjwvaGVhZD4NCjxib2R5Pg0KSGVs
bG8hPGJyPg0KPGJyPg0KSSBoYXZlIHByb2JsZW1zLCBhY2Nlc3NpbmcgYSBzaGFyZWQgZm9sZGVy
IGZyb20gV2luZG93cyAxMCBndWVzdCBvbiBteSBPcGVuU3VzZSBob3N0IG1hY2hpbmUuPGJyPg0K
PGJyPg0KSSBjYW4gYWNjZXNzIHRoZSBzaGFyZWQgZm9sZGVyIGluIG15IHZpcnR1YWwgbWFjaGlu
ZSB3aXRoIDxjb2RlPlxcMTkyLjE2OC4wLjRccWVtdTwvY29kZT4uPGJyPg0KSG93ZXZlciwgSWYg
SSBvcGVuIGl0IHdpdGggZXhwbG9yZXIgSSBnZXQgYSA8Y29kZT5Db3VsZCBub3QgYWNjZXNzIFxc
MTkyLjE2OC4wLjRccWVtdTwvY29kZT4gZXJyb3IuPGJyPg0KSW4gdGhlIFdpbmRvd3MgY29tbWFu
ZCBsaW5lIEkmcXVvdDttIGdldHRpbmcgYSA8Y29kZT5maWxlIG5vdCBmb3VuZDwvY29kZT4gbWVz
c2FnZS48YnI+DQo8Y29kZT5uZXQgdXNlIFxcMTkyLjE2OC4wLjRccWVtdTwvY29kZT4gd29ya3Mg
d2l0aG91dCBhbnkgcHJvYmxlbXMuPGJyPg0KVGhlIHBlcm1pc3Npb24gb2YgdGhlIHNoYXJlZCBm
b2xkZXIgKDxjb2RlPi9vcHQvdmlydE1hY2hpbmVzL3NoYXJlLXdpbjEwPC9jb2RlPikgYW5kIGFs
bCBmaWxlcyBpbiBpdCBpcyByd3hyd3hyd3guPGJyPg0KPGJyPg0KVGhlIHNtYmQgdmVyc2lvbiBp
cyA0LjcuMTEtZ2l0LjE1My5iMzZjZWFmMjIzNWxwMTUwLjMuMTQuMS1TVVNFLW9TMTUuMC14ODZf
NjQuPGJyPg0KVGhlIHFlbXUgdmVyc2lvbiBpcyAyLjExLjIuPGJyPg0KPGJyPg0KSSBzdGFydCB0
aGUgcWVtdSB3aXRoIHRoZSBmb2xsb3dpbmcgb3B0aW9uczo8YnI+DQo8cHJlIHN0eWxlPSJiYWNr
Z3JvdW5kLWNvbG9yOiNjZmNmY2Y7Ij4NCnFlbXUta3ZtIC1zbXAgOCxzb2NrZXRzPTIsY29yZXM9
NCx0aHJlYWRzPTEgLWNwdSBob3N0LGt2bT1vbiAtbSBzaXplPTEwMjQgLWsgZGUgXA0KICAtYmFs
bG9vbiBub25lIFwNCiAgLW1vbml0b3IgdW5peDpxZW11LW1vbml0b3Itc29ja2V0LHNlcnZlcixu
b3dhaXQgLWRhZW1vbml6ZSBcDQogIC1jZHJvbSAvb3B0L3ZpcnRNYWNoaW5lcy9kdmRzL2VtcHR5
LmlzbyBcDQogIC1oZGEgL29wdC92aXJ0TWFjaGluZXMvaW1hZ2VzL3dpbjEwLnFjb3cyIFwNCiAg
LWRyaXZlIGZpbGU9L29wdC92aXJ0TWFjaGluZXMvaW1hZ2VzL3ZzLWFuZC10b29scy5xY293MiBc
DQogIC1kcml2ZSBmaWxlPS9vcHQvdmlydE1hY2hpbmVzL2ltYWdlcy9zcmMtYW5kLWJ1aWxkLnFj
b3cyIFwNCiAgLWRpc3BsYXkgc2RsIFwNCiAgLXZnYSB2bXdhcmUgXA0KICAtbmV0ZGV2ICZxdW90
O3VzZXIsaWQ9bXluZXQwLHJlc3RyaWN0PXksbmV0PTE5Mi4xNjguMC8yNCxkaGNwc3RhcnQ9MTky
LjE2OC4wLjEzMCxob3N0ZndkPXRjcDo6MjIyOC06MjIsaG9zdGZ3ZD10Y3A6OjIyMzgtOjMzODks
c21iPS9vcHQvdmlydE1hY2hpbmVzL3NoYXJlLXdpbjEwJnF1b3Q7IFwNCiAgLWRldmljZSBydGw4
MTM5LG5ldGRldj1teW5ldDAgXA0KICAtYm9vdCBvcmRlcj1kYyxtZW51PW9uIC1uby1xdWl0DQo8
L3ByZT4NCjxicj4NCjxicj4NCkhvdyBjYW4gSSBhY2Nlc3MgbXkgc2hhcmVkIGZvbGRlcj88YnI+
DQo8YnI+DQpUaGFuayB5b3UhPGJyPg0KPGJyPg0KSGF2ZSBhIG5pY2UgZGF5PGJyPg0KPGJyPg0K
PGNvZGU+Jm5ic3A7Jm5ic3A7Jm5ic3A7PC9jb2RlPlRob21hcyBTdHJhc3Nlcjxicj4NCjxicj4N
CjwvYm9keT4NCjwvaHRtbD4NCg==

--_000_223422542537691sendEmailmd2evabc_--

