Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57351C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207E82075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PCjDuxBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207E82075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Oc9-0001Y5-7D
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8ObN-00012O-DF
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8ObM-0007Eu-2p
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:53:33 -0400
Received: from mail-eopbgr40106.outbound.protection.outlook.com
 ([40.107.4.106]:56835 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8ObH-00076G-55; Thu, 12 Sep 2019 08:53:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKih+lFsSvFdl9NA4Yoj6TiJl7o2Z0h4poVhyNiGjxIKZiMQRMlsfBHZyOFH0fzF32wQRQ3/n/GdWfF+JMvX+7mWTAfRhSTq5D35E/ddGRoy6NywKf1FWX1qL+TNQuzQS3XymATbP0Km4sKOiQhMbgX+vQrZn+e3RybiSCkUqBt3RNyGedzRYBScki0LLRQRc4Sd9sk3y/9KA/F2XTPXJ/SWZsPJSraSSAqRwwZOHyiSdvtng1nrMKdYqcJyYTNscVZGep/UBoiI+8B7w9yXDro0MZJ7OP5YohuXY1oK40YqdA9p8Yme6Ct4NFdebHrDRjlS9GmfMeb+Ba/j+9Gw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWsET3rsL1D7/2X7j4MuxFtBu4y5lmn91nIzgbCjZvQ=;
 b=M/GQsta/+rHa9PV079M2vMRGivomcMoR0fMLBhNBUSzOFCOnfJnzXw9q14zLSoCfRWaKry/jgwXXFyDFd67RJHGxC3uYEyEHz8G1U3cai75mdalo2I8irczB5mk4uPWHblonhTxIOSRVmCJnDguu1mwc0VHaAYWbaIcgnVDiEMm0ZhD+wHIDLQKlWawdzevLmPPqJHt8+hWQo1U1+D4iSoIIeFaXI8cZ0Kr2AWbH9hmDUM/T3l4LUnb4Jujft1SGfeuVz/JfW6pJGBGA2AwjxQipKk8YUOA1ADlvPDp1rVLvz2zPjbIJictjlbJpUj6dVYBbAwIlDVof6WMeUsS2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWsET3rsL1D7/2X7j4MuxFtBu4y5lmn91nIzgbCjZvQ=;
 b=PCjDuxBeCmUyE7dAE2b7SoqNf/6EpQB/SrQ38gzz/fiNcF+L1daZgPNbh8z+tQZuonmiFXPt/LI7EZPH4bRzHtcbvExMou+VoEO/YGxvNDzVx/oy76wd/rh7rCl3497dv+MzkhlFctCbUej/5lnL9dvEbCJ+CN7a6typIFEpIP0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5337.eurprd08.prod.outlook.com (52.133.243.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 12 Sep 2019 12:53:24 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 12:53:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 0/3] proper locking on bitmap add/remove
 paths
Thread-Index: AQHVZ/Sl8JlDvEflUE+vmp1j2//H2aclX1kAgAEl6YCAAH+nAIAA/UkA
Date: Thu, 12 Sep 2019 12:53:24 +0000
Message-ID: <fb9b857d-60e2-9203-3481-5f813fb425d3@virtuozzo.com>
References: <156814787725.15929.11693446479791530766@5dec9699b7de>
 <cb8fd02c-4fe7-0594-3a89-1d91d02940fc@virtuozzo.com>
 <dd68ed3f-494e-d02f-3973-db6920f65b1a@redhat.com>
In-Reply-To: <dd68ed3f-494e-d02f-3973-db6920f65b1a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190912155320768
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b70119ba-0552-476a-4fd1-08d73780326f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5337; 
x-ms-traffictypediagnostic: DB8PR08MB5337:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB53376B5F765882036E088D09C1B00@DB8PR08MB5337.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(366004)(39850400004)(396003)(199004)(189003)(6512007)(6116002)(107886003)(3846002)(6306002)(186003)(6436002)(26005)(53376002)(7736002)(14454004)(6246003)(305945005)(53936002)(478600001)(2501003)(53546011)(31686004)(229853002)(386003)(6506007)(8676002)(966005)(2906002)(81166006)(81156014)(6486002)(102836004)(66446008)(86362001)(66476007)(66556008)(66946007)(64756008)(52116002)(5660300002)(71190400001)(71200400001)(486006)(99286004)(25786009)(31696002)(76176011)(4326008)(66066001)(11346002)(2616005)(316002)(446003)(476003)(8936002)(36756003)(256004)(14444005)(110136005)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5337;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E/Z8QDtwfV9H2PgUoC83QFDMVSXyMdx/gXd9B3ukEIDGrycMd6bV4erEC7eN/V9DksmmRvKhJSuMHnms0hgRBOUs66Xm9m19iaQRB1rzTzHsmiP8DlDuHK7KA2kXbWoongW/Cf4e6hhN4O1K3UFfoBeGfJUv8QAQtUgNqSlhyB/h0bbXP8QFp9Xx7pHCMm+hAqtv6puPZaF0lP4bjYlT1dALDFgFZS3UTKawZxdvGBtu9El+xbo287IUAv+yW4wikMvL6kncP8wkek1wF1fqc1ZT5slbrjRs1He8Uxsg/uDtuXdUcx0tK/lut3UZvhCNgP9AsqAs6iNyh8zMrHC5vrq+Wbe+kAFLCdYWyFHQT0/gqEG97yjR3brK8fZvhAMTWiPK3DMK/dzsKG342aIrdWw6gFeeLowx7xhg68gjd9k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4656AA058813F143B147085676E0C856@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70119ba-0552-476a-4fd1-08d73780326f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 12:53:24.0323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH5iQmRFuUu2sIcv5t+Nnb213hB+XTseFK1vpuEMOFQbiCcNGdfE92qZ5so+OmVdMGI8FgRvwhvqArPSKpK3NPZ00kUI08osAxZhQt6F0Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5337
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.106
Subject: Re: [Qemu-devel] [PATCH 0/3] proper locking on bitmap add/remove
 paths
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDkuMjAxOSAwOjQ2LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOS8xMS8xOSAx
MDowOSBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEwLjA5LjIw
MTkgMjM6MzcsIG5vLXJlcGx5QHBhdGNoZXcub3JnIHdyb3RlOg0KPj4+IFBhdGNoZXcgVVJMOiBo
dHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAxOTA5MTAxNjI3MjQuNzk1NzQtMS12c2VtZW50c292
QHZpcnR1b3p6by5jb20vDQo+Pj4NCj4+Pg0KPj4+DQo+Pj4gSGksDQo+Pj4NCj4+PiBUaGlzIHNl
cmllcyBmYWlsZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBm
aW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZA0KPj4+IHRoZWlyIG91dHB1dCBiZWxvdy4gSWYg
eW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQN
Cj4+PiBsb2NhbGx5Lg0KPj4+DQo+Pj4gPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQ0KPj4+ICMh
L2Jpbi9iYXNoDQo+Pj4gbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09SSz0xDQo+
Pj4gdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5F
VFdPUks9MQ0KPiANCj4gKFdhcyBwYXRjaGV3IGV2ZW4gdXNpbmcgY2xhbmc/KQ0KDQpobW0gZ2Nj
IDkuMiBkb24ndCBzaG93IHN1Y2ggZXJyb3IgYnV0IGNsYW5nIGRvZXMuDQoNCj4gDQo+Pj4gPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0NCj4+Pg0KPj4+IGxpYnVkZXYgICAgICAgICAgIG5vDQo+Pj4g
ZGVmYXVsdCBkZXZpY2VzICAgeWVzDQo+Pj4NCj4+PiB3YXJuaW5nOiBQeXRob24gMiBzdXBwb3J0
IGlzIGRlcHJlY2F0ZWQNCj4+PiB3YXJuaW5nOiBQeXRob24gMyB3aWxsIGJlIHJlcXVpcmVkIGZv
ciBidWlsZGluZyBmdXR1cmUgdmVyc2lvbnMgb2YgUUVNVQ0KPj4+DQo+Pj4gTk9URTogY3Jvc3Mt
Y29tcGlsZXJzIGVuYWJsZWQ6ICAnY2MnDQo+Pj4gICAgIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUv
Y29uZmlnLWRldmljZXMubWFrLnRtcA0KPj4+IC0tLQ0KPj4+ICAgICBDQyAgICAgIGJsb2NrL3Fl
ZC1jbHVzdGVyLm8NCj4+PiAgICAgQ0MgICAgICBibG9jay9xZWQtY2hlY2subw0KPj4+IC90bXAv
cWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1iaXRtYXAuYzogSW4gZnVuY3Rpb24gJ3Fjb3cyX2Nv
X3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcCc6DQo+Pj4gL3RtcC9xZW11LXRlc3Qvc3Jj
L2Jsb2NrL3Fjb3cyLWJpdG1hcC5jOjUwMjo4OiBlcnJvcjogJ2JtJyBtYXkgYmUgdXNlZCB1bmlu
aXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0N
Cj4+PiAgICAgICAgaWYgKGJtID09IE5VTEwpIHsNCj4+PiAgICAgICAgICAgXg0KPj4+IC90bXAv
cWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1iaXRtYXAuYzoxNDEzOjE4OiBub3RlOiAnYm0nIHdh
cyBkZWNsYXJlZCBoZXJlDQo+Pj4NCj4+Pg0KPj4+IFRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQNCj4+PiBodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxMDE2MjcyNC43OTU3NC0xLXZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBl
PW1lc3NhZ2UuDQo+Pj4gLS0tDQo+Pj4gRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLg0KPj4+IFBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29tDQo+Pj4NCj4+DQo+PiBXaG8ga25vd3Ms
IGhvdyB0byBjbGFuZyBRZW11Pw0KPj4NCj4+IEkgdHJ5IHdpdGgNCj4+IC4vY29uZmlndXJlIC0t
dGFyZ2V0LWxpc3Q9eDg2XzY0LXNvZnRtbXUgLS1lbmFibGUtZGVidWcgLS1kaXNhYmxlLXZpcnRm
cyAtLWVuYWJsZS13ZXJyb3IgLS1hdWRpby1kcnYtbGlzdD1vc3MgLS1leHRyYS1jZmxhZ3M9LVdh
bGwgLS1lbmFibGUtc2FuaXRpemVycyAtLWNjPWNsYW5nIC0tY3h4PWNsYW5nKysNCj4+IG1ha2Ug
LWo5DQo+Pg0KPiANCj4gLi4vLi4vY29uZmlndXJlIC0tdGFyZ2V0LWxpc3Q9Ing4Nl82NC1zb2Z0
bW11IiAtLWNjPWNsYW5nIC0tY3h4PWNsYW5nKysNCj4gLS1ob3N0LWNjPWNsYW5nDQo+IA0KPiB3
b3JrcyBPSyBmb3IgbWUgaW4gZmVkb3JhIDMwLg0KDQpTbywgbm93IEkndmUgbW92ZWQgdG8gZmVk
b3JhIGZyb20gcmhlbC1iYXNlZCB2aXJ0dW96em8sIGFuZCBpdCBqdXN0IHdvcmtzIDopDQoNCj4g
DQo+IC0tdGFyZ2V0LWxpc3Q9Ing4Nl82NC1zb2Z0bW11IiAtLWNjPWNsYW5nIC0tY3h4PWNsYW5n
KysgLS1ob3N0LWNjPWNsYW5nDQo+IC0tZW5hYmxlLXdlcnJvciAtLWV4dHJhLWNmbGFncz0tV2Fs
bA0KPiANCj4gU2VlbXMgT0sgdG9vLCBhbmQgZmluYWxseSBhZGRpbmcNCj4gDQo+IC0tZW5hYmxl
LXNhbml0aXplcnMNCj4gDQo+IGFsc28gYXBwZWFycyB0byB3b3JrIGFscmlnaHQuDQo+IA0KPiAN
Cj4gY2xhbmcgdmVyc2lvbiA4LjAuMCAoRmVkb3JhIDguMC4wLTEuZmMzMCkNCj4gVGFyZ2V0OiB4
ODZfNjQtdW5rbm93bi1saW51eC1nbnUNCj4gVGhyZWFkIG1vZGVsOiBwb3NpeA0KPiBJbnN0YWxs
ZWREaXI6IC91c3IvYmluDQo+IA0KPiANCj4gTWF5YmUgc29tZXRoaW5nIGJhZCBpbiB5b3VyIGNj
YWNoZSBvciBzb21lIGludGVybWVkaWF0ZSBzdGF0ZSBpbiB5b3VyDQo+IGJ1aWxkIGRpci4gSSB1
c2Ugc2VwYXJhdGUgYnVpbGQgZGlyZWN0b3JpZXMgZm9yIGdjYyBhbmQgY2xhbmcganVzdCBpbiBj
YXNlLg0KPiANCg0KVGhhbmtzIGZvciBoZWxwIQ0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

