Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7554FC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:16:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2989020717
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JspwYB9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2989020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibmUq-0001n5-5S
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 09:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibmTR-00014V-6b
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibmTN-0002Cw-7M
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:14:48 -0500
Received: from mail-eopbgr40136.outbound.protection.outlook.com
 ([40.107.4.136]:33668 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ibmTM-0002Ca-8e; Mon, 02 Dec 2019 09:14:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYOKuad2eyiuth7FeMvnU1Dp62ZU3immw0wYBmCWYhanXhJYFvpdGXIKJfB34lLCuaz0ilR8Gj465d7ZAIkAHKjzeIKZT0nv3OjTaMVvFB8WFkzYM2msYy60syKG0+hM7VqrskuO5hMgjgo6U88xvSJojP3eWXFDrCIwMVcuomHQYuSldin/U/B7nCC4XgyBwtLaKtlNHYBMhJiFtN9IRCIwhmaQIjkz+o/jc99N0ktlyVxbLpHWHGmWo7ePbM9PhExPGKx4zVtHnlea3AzFpTsck8XC02DZCe9sVjRJintny8CPcRsXrG44Ts28BSYCTdKxrXskvybIEKODcrNY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v+QXTFDdzgNeFxOcQgoNBFIw2Q1h8roppUZgQ9doCc=;
 b=XZFlr7ETC25xoJ/ML1CdQwdNUxuqDBHLgR/9ymiiNYyqbF7JKck7cNnVdUkx8hVgir7pwmluZlb7F3d3XITW7KH/6JpI87ros0Fqs4Sp1Fpqt0ryWBFe8QfxGJh7nOUZMdQ9jadnDensbupXqtwFeOJEbnUSQ1B81ZXqo4xXuHbWn3zUiH+wUTqDyvkh1EK5XtqyBl6ooF0A729PbuJ/tlUqb9QWkD/TKF+HRLK3WMKqr70sUHcu0GQKT3vgVemJ6evm2P7tAuYDVPq6huJwBEZ7SzTmp2eg3Lc7Zpy0E6/Xm4ifdVbgcJa2V2GgRw3EXRrnptKumT9LSwAXDLrzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v+QXTFDdzgNeFxOcQgoNBFIw2Q1h8roppUZgQ9doCc=;
 b=JspwYB9caRDhcPJWBhd6ezdguN9MZ89vak3c63aDSSF/miuyyYJwoxRX/Ks11BoMsbWXRKKSp9qiPmgocEMUfoHELsk2TmzsRgKSaN3iirfiF82U5r0Zc7rftuw/hglyTA/FdrTRk/o/L3XkC45ablnL63AwZcbWPDDHC5Om0UA=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3733.eurprd08.prod.outlook.com (20.178.90.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Mon, 2 Dec 2019 14:14:40 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 14:14:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v8 1/3] docs: improve qcow2 spec about extending image
 header
Thread-Topic: [PATCH v8 1/3] docs: improve qcow2 spec about extending image
 header
Thread-Index: AQHVhZkjTzzfnHiFj0qSiLP9bR+k/adgbZKAgAAKKwCAHitYAIABHveAgCdoawA=
Date: Mon, 2 Dec 2019 14:14:40 +0000
Message-ID: <c22ec011-0e13-5749-5b18-321d2a33f58b@virtuozzo.com>
References: <20191018094758.7124-1-vsementsov@virtuozzo.com>
 <20191018094758.7124-2-vsementsov@virtuozzo.com>
 <71ad0b78-65da-9a39-4c12-f78449cdca9c@redhat.com>
 <ba5ae50c-9406-5095-89ae-6a10893e452e@virtuozzo.com>
 <8cfcca15-4018-2876-6d75-a4d5125beedc@redhat.com>
 <da2ddf4b-e549-c138-7bd9-237733885697@virtuozzo.com>
In-Reply-To: <da2ddf4b-e549-c138-7bd9-237733885697@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0071.eurprd04.prod.outlook.com
 (2603:10a6:3:19::39) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191202171438789
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28b4004b-6d26-4412-b827-08d77731f88a
x-ms-traffictypediagnostic: AM6PR08MB3733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB373369FC94D2658A16A099BAC1430@AM6PR08MB3733.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39840400004)(346002)(376002)(366004)(189003)(199004)(86362001)(316002)(110136005)(7736002)(305945005)(6116002)(14454004)(6486002)(25786009)(36756003)(4326008)(8676002)(6246003)(81156014)(81166006)(5660300002)(8936002)(107886003)(6512007)(66066001)(2501003)(31696002)(256004)(478600001)(31686004)(71190400001)(3846002)(71200400001)(2906002)(99286004)(66556008)(76176011)(386003)(53546011)(52116002)(66476007)(102836004)(186003)(64756008)(6436002)(6506007)(26005)(66946007)(2616005)(11346002)(446003)(66446008)(54906003)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3733;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OKLd2FM09uQNU0PvQBA5vLufAbED2bQExtHkORD81xkJNginF0hFqS9Ksb6L54ujXiPdfnIRx19TzddqayjkI3lmp+d/myNYtPP5FHcQMI+VzfgjW1DvT2NtokM9BeYOpgYQ1wzjCkVLnG3RtO8xsxfSTMo/QuelXP+v8Rv+WYyyC+fJypup6eBbtNId/ya39it8HmkSpsfTB0CcphCJITHB48x3rUykg4+S9CD7V5Pvean9YTmud9w6HZbVmimu8keTdta3tiQVnceZP/R+JE+D8x/b0jWvH5jeciDOIHFTSCTZhAeMGoaBeq3qPwxM9B3azj8r+U6zf1SDx2JTXJXDS1T85DN+LRH/0i+NvzQA+etW4CdslrcQwPUA4qqYG+QkJ33hSkjie1cM8nr8rZAkcpGKJXU6Z81xecUG+oXZO8yKSIJ7HjCcRaDR39u
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC8628984D2A1145A488B4FB308B6C5F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b4004b-6d26-4412-b827-08d77731f88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 14:14:40.7035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9J5yp20RolIRNvEN1QRwBsp8uB+d0jt1pQFwqW0eFjgIYX3N9CZlSivbjQiJkVvwQW7wBZrYP2RikStWHqBxVuURBBfHwmTe/B5Sjl9GPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3733
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.136
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMTEuMjAxOSAxNToyNiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDYuMTEuMjAxOSAyMjoxOSwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDEwLzE4LzE5IDk6MzYg
QU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pg0KPj4+PiBNYXliZToN
Cj4+Pj4NCj4+Pj4gaWYgc29mdHdhcmUgZG9lc24ndCBrbm93IGhvdyB0byBpbnRlcnByZXQgdGhl
IGZpZWxkLCBpdCBtYXkgYmUgc2FmZWx5IGlnbm9yZWQgdW5sZXNzIGEgY29ycmVzcG9uZGluZyBp
bmNvbXBhdGlibGUgZmVhdHVyZSBmbGFnIGJpdCBpcyBzZXQ7IGhvd2V2ZXIsIHRoZSBmaWVsZCBz
aG91bGQgYmUgcHJlc2VydmVkIHVuY2hhbmdlZCB3aGVuIHJld3JpdGluZyB0aGUgaW1hZ2UgaGVh
ZGVyLg0KPj4+Pg0KPj4+Pj4gKw0KPj4+Pj4gK0ZvciBhbGwgYWRkaXRpb25hbCBmaWVsZHMgemVy
byB2YWx1ZSBlcXVhbHMgdG8gYWJzZW5jZSBvZiBmaWVsZCAoYWJzZW5jZSBpcw0KPj4+Pj4gK3do
ZW4gZmllbGQub2Zmc2V0ICsgZmllbGQuc2l6ZSA+IEBoZWFkZXJfbGVuZ3RoKS4gVGhpcyBpbXBs
aWVzDQo+Pj4+PiArdGhhdCBpZiBzb2Z0d2FyZSB3YW50J3MgdG8gc2V0IGZpZWxkcyB1cCB0byBz
b21lIGZpZWxkIG5vdCBhbGlnbmVkIHRvIG11bHRpcGx5DQo+Pj4+PiArb2YgOCBpdCBtdXN0IGFs
aWduIGhlYWRlciB1cCBieSB6ZXJvZXMuIEFuZCBvbiB0aGUgb3RoZXIgaGFuZCwgaWYgc29mdHdh
cmUNCj4+Pj4+ICtuZWVkIHNvbWUgb3B0aW9uYWwgZmllbGQgd2hpY2ggaXMgYWJzZW50IGl0IHNo
b3VsZCBhc3N1bWUgdGhhdCBpdCdzIHZhbHVlIGlzDQo+Pj4+PiAremVyby4NCj4+Pj4NCj4+Pj4g
TWF5YmU6DQo+Pj4+DQo+Pj4+IEVhY2ggb3B0aW9uYWwgZmllbGQgdGhhdCBkb2VzIG5vdCBoYXZl
IGEgY29ycmVzcG9uZGluZyBpbmNvbXBhdGlibGUgZmVhdHVyZSBiaXQgbXVzdCBzdXBwb3J0IHRo
ZSB2YWx1ZSAwIHRoYXQgZ2l2ZXMgdGhlIHNhbWUgZGVmYXVsdCBiZWhhdmlvciBhcyB3aGVuIHRo
ZSBvcHRpb25hbCBmaWVsZCBpcyBvbWl0dGVkLg0KPj4+DQo+Pj4gSG1tbS4gVGhhdCBkb2Vzbid0
IHdvcmssIGFzICJjb3JyZXNwb25kaW5nIiBpcyBzb21ldGhpbmcgbm90IGFjdHVhbGx5IGRlZmlu
ZWQuIENvbnNpZGVyIG91ciB6c3RkIGV4dGVuc2lvbi4NCj4+Pg0KPj4+IEl0IGhhcyBjb3JyZXNw
b25kaW5nIGluY29tcGF0aWJsZSBiaXQsIHRoZXJlZm9yZSwgdGhpcyBzZW50ZW5jZSBkb2Vzbid0
IGFwcGx5IHRvIGl0LiBCdXQgc3RpbGwsIGlmIGluY29tcGF0aWJsZSBiaXQgaXMgdW5zZXQgd2Ug
Y2FuIGhhdmUgdGhpcyBmaWVsZC4gQW5kIGl0J3MgemVybyB2YWx1ZSBtdXN0IGNvcnJlc3BvbmQN
Cj4+PiB0byB0aGUgYWJzZW5jZSBvZiB0aGUgZmllbGQuDQo+Pj4NCj4+PiBTbywgYWRkaXRpb25h
bCBmaWVsZCBtYXkgdXNlIGluY29tYXB0aWJsZSBiaXQgb25seSBmb3Igc3Vic2V0IG9mIGl0cyB2
YWx1ZXMuDQo+Pj4NCj4+PiBCdXQsIEkgc2VlLCB0aGF0IHlvdSB3YW50IHRvIGFsbG93IDAgdmFs
dWUgdG8gbm90IG1hdGNoIGZpZWxkLWFic2VuY2UgaWYgaW5jb21wYXRpYmxlIGJpdCBpcyBzZXQ/
DQo+Pg0KPj4gTm90IG5lY2Vzc2FyaWx5LsKgIFJhdGhlciwgaWYgdGhlIHZhbHVlIG9mIGFuIHVu
a25vd24gZmllbGQgY2FuIGJlIHNhZmVseSBpZ25vcmVkLCB0aGVuIGl0IHNob3VsZCBkZWZhdWx0
IHRvIDAuwqAgSWYgaXQgY2Fubm90IGJlIHNhZmVseSBpZ25vcmVkLCB0aGVuIHRoYXQgZmllbGQg
d2lsbCBub3QgYmUgc2V0IHRvIGEgbm9uLXplcm8gdmFsdWUgd2l0aG91dCBhbHNvIHNldHRpbmcg
YW4gaW5jb21wYXRpYmxlIGZlYXR1cmUgZmxhZywgc28gdGhhdCBzb2Z0d2FyZSB0aGF0IGRvZXMg
bm90IGtub3cgaG93IHRvIGludGVycHJldCB0aGUgZmllbGQgd2lsbCBmYWlsIHRvIGxvYWQgdGhl
IGltYWdlIGJlY2F1c2UgaXQgYWxzbyBmYWlscyB0byByZWNvZ25pemUgdGhlIGFzc29jaWF0ZWQg
bmV3IGluY29tcGF0aWJsZSBmZWF0dXJlIGJpdC4NCj4+DQo+PiBCdXQgSSdkIHJlYWxseSBsaWtl
IEtldmluJ3Mgb3BpbmlvbiBvbiBob3cgbXVjaCB3b3JkaW5nIGlzIHdvcnRoIGFkZGluZy4NCj4+
DQo+Pj4NCj4+PiBTbywgbWF5IGJlDQo+Pj4NCj4+PiBBZGRpdGlvbmFsIGZpZWxkcyBoYXMgdGhl
IGZvbGxvd2luZyBjb21wYXRpYmxlIGJlaGF2aW9yIGJ5IGRlZmF1bHQ6DQo+Pg0KPj4gcy9oYXMv
aGF2ZS8NCj4+DQo+Pj4NCj4+PiAxLiBJZiBzb2Z0d2FyZSBkb2Vzbid0IGtub3cgaG93IHRvIGlu
dGVycHJldCB0aGUgZmllbGQsIGl0IG1heSBiZSBzYWZlbHkgaWdub3JlZCwgb3RoZXIgdGhhbiBw
cmVzZXJ2aW5nIHRoZSBmaWVsZCB1bmNoYW5nZWQgd2hlbiByZXdyaXRpbmcgdGhlIGltYWdlIGhl
YWRlci4NCj4+PiAyLiBaZXJvZWQgYWRkaXRpb25hbCBmaWVsZCBnaXZlcyB0aGUgc2FtZSBiZWhh
dmlvciBhcyB3aGVuIHRoaXMgZmllbGQgaXMgb21pdHRlZC4NCj4+DQo+PiBCb3RoIGdvb2QuDQo+
Pg0KPj4+DQo+Pj4gVGhpcyBkZWZhdWx0IGJlaGF2aW9yIG1heSBiZSBhbHRlcmVkIHdpdGggaGVs
cCBvZiBpbmNvbXBhdGlibGUgZmVhdHVyZSBiaXRzLiBTbywgaWYsIGZvciBleGFtcGxlLCBhZGRp
dGlvbmFsIGZpZWxkIGhhcyBjb3JyZXNwb25kaW5nIGluY29tcGF0aWJsZSBmZWF0dXJlIGJpdCwg
YW5kIGl0IGlzIHNldCwgd2UgYXJlIHN1cmUgdGhhdCBzb2Z0d2FyZSB3aGljaCBvcGVucyB0aGUg
aW1hZ2Uga25vd3MgaG93IHRvIGludGVycHJldCB0aGUgZmllbGQsIHNvLA0KPj4+IDEuIFRoZSBm
aWVsZCBkZWZpbml0ZWx5IHdpbGwgbm90IGJlIGlnbm9yZWQgd2hlbiBjb3JyZXNwb25kaW5nIGlu
Y29tcGF0aWJsZSBiaXQgaXMgc2V0Lg0KPj4+IDIuIFRoZSBmaWVsZCBtYXkgZGVmaW5lIGFueSBt
ZWFuaW5nIGl0IHdhbnRzIGZvciB6ZXJvIHZhbHVlIGZvciB0aGUgY2FzZSB3aGVuIGNvcnJlc3Bv
bmRpbmcgaW5jb21wYXRpYmxlIGJpdCBpcyBzZXQuDQo+Pg0KPj4gUmF0aGVyIHdvcmR5IGJ1dCBz
ZWVtcyBhY2N1cmF0ZS7CoCBQZXJoYXBzIGNvbXByZXNzIGl0IHRvOg0KPj4NCj4+IDMuIEFueSBh
ZGRpdGlvbmFsIGZpZWxkIHdob3NlIHZhbHVlIG11c3Qgbm90IGJlIGlnbm9yZWQgZm9yIGNvcnJl
Y3QgaGFuZGxpbmcgb2YgdGhlIGZpbGUgd2lsbCBiZSBhY2NvbXBhbmllZCBieSBhIGNvcnJlc3Bv
bmRpbmcgaW5jb21wYXRpYmxlIGZlYXR1cmUgYml0Lg0KPj4NCj4+IGFuZCBtYXliZSBldmVuIHJl
b3JkZXIgaXQgdG8gbGlzdCB0aGUgcG9pbnRzIGFzOg0KPj4NCj4+IEFkZGl0aW9uYWwgZmllbGRz
IGhhdmUgdGhlIGZvbGxvd2luZyBjb21wYXRpYmlsaXR5IHJ1bGVzOg0KPj4gMS4gQW55IGFkZGl0
aW9uYWwgZmllbGQgd2hvc2UgdmFsdWUgbXVzdCBub3QgYmUgaWdub3JlZCBmb3IgY29ycmVjdCBo
YW5kbGluZyBvZiB0aGUgZmlsZSB3aWxsIGJlIGFjY29tcGFuaWVkIGJ5IGEgY29ycmVzcG9uZGlu
ZyBpbmNvbXBhdGlibGUgZmVhdHVyZSBiaXQuDQo+IA0KPiBJJ2QgbGlrZSB0byBzdHJlc3MsIHRo
YXQgaW5jb21wYXRpYmxlIGJpdCBpcyBuZWVkZWQgZm9yIGluY29tcGF0aWJsZSB2YWx1ZSwgbm90
IGZvciB0aGUgZmllbGQgaXRzZWxmLiAoU28gZmllbGQgbWF5IGJlIGFjY29tcGFuaWVkIGJ5IGlu
Y29tcGF0aWJsZSBiaXQgZm9yIHNvbWUNCj4gaXQncyB2YWx1ZXMgYW5kIGZvciBvdGhlcnMgLSBu
b3QpLCBTbywgd2hhdCBhYm91dA0KPiANCj4gMS4gSWYgdGhlIHZhbHVlIG9mIHRoZSBhZGRpdGlv
bmFsIGZpZWxkIG11c3Qgbm90IGJlIGlnbm9yZWQgZm9yIGNvcnJlY3QgaGFuZGxpbmcgb2YgdGhl
IGZpbGUsIGl0IHdpbGwgYmUgYWNjb21wYW5pZWQgYnkgYSBjb3JyZXNwb25kaW5nIGluY29tcGF0
aWJsZSBmZWF0dXJlIGJpdC4NCj4gDQo+PiAyLiBJZiB0aGVyZSBhcmUgbm8gdW5yZWNvZ25pemVk
IGluY29tcGF0aWJsZSBmZWF0dXJlIGJpdHMgc2V0LCBhbiBhZGRpdGlvbmFsIGZpZWxkIG1heSBi
ZSBzYWZlbHkgaWdub3JlZCBvdGhlciB0aGFuIHByZXNlcnZpbmcgaXRzIHZhbHVlIHdoZW4gcmV3
cml0aW5nIHRoZSBpbWFnZSBoZWFkZXIuDQo+IA0KPiBTb3VuZHMgbGlrZSB3ZSBjYW4gaWdub3Jl
IHRoZSBmaWVsZCBpZiB3ZSBrbm93IGl0cyBtZWFuaW5nIGFuZCBrbm93IGl0cyBpbmNvbXBhdGli
bGUgYml0Li4NCj4gDQo+IDIuIElmIHRoZXJlIGFyZSBubyB1bnJlY29nbml6ZWQgaW5jb21wYXRp
YmxlIGZlYXR1cmUgYml0cyBzZXQsIGFuIHVua25vd24gYWRkaXRpb25hbCBmaWVsZCBtYXkgYmUg
c2FmZWx5IGlnbm9yZWQgb3RoZXIgdGhhbiBwcmVzZXJ2aW5nIGl0cyB2YWx1ZSB3aGVuIHJld3Jp
dGluZyB0aGUgaW1hZ2UgaGVhZGVyLg0KPiANCj4+IDMuIEFuIGV4cGxpY2l0IHZhbHVlIG9mIDAg
d2lsbCBoYXZlIHRoZSBzYW1lIGJlaGF2aW9yIGFzIHdoZW4gdGhlIGZpZWxkIGlzIG5vdCBwcmVz
ZW50Lg0KPiANCj4gQnV0IGl0IG1heSBiZSBjaGFuZ2VkIGJ5IGluY29tcGF0aWJsZSBiaXQuLg0K
PiANCj4gMy4gQW4gZXhwbGljaXQgdmFsdWUgb2YgMCB3aWxsIGhhdmUgdGhlIHNhbWUgYmVoYXZp
b3IgYXMgd2hlbiB0aGUgZmllbGQgaXMgbm90IHByZXNlbnQsIGlmIG5vdCBhbHRlcmVkIGJ5IHNw
ZWNpZmljIGluY29tcGF0aWJsZSBiaXQuDQo+IA0KDQpFcmljLCBPSyBmb3IgeW91Pw0KDQo+Pg0K
Pj4NCj4+Pj4+ICtJdCdzIGFsbG93ZWQgZm9yIHRoZSBoZWFkZXIgZW5kIHRvIGN1dCBzb21lIGZp
ZWxkIGluIHRoZSBtaWRkbGUgKGluIHRoaXMgY2FzZQ0KPj4+Pj4gK3RoZSBmaWVsZCBpcyBjb25z
aWRlcmVkIGFzIGFic2VudCksIGJ1dCBpbiB0aGlzIGNhc2UgdGhlIHBhcnQgb2YgdGhlIGZpZWxk
DQo+Pj4+PiArd2hpY2ggaXMgY292ZXJlZCBieSBAaGVhZGVyX2xlbmd0aCBtdXN0IGJlIHplcm9l
ZC4NCj4+Pj4+ICsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCA8IC4uLiBObyBhZGRpdGlvbmFsIGZp
ZWxkcyBpbiB0aGUgaGVhZGVyIGN1cnJlbnRseSAuLi4gPg0KPj4+Pg0KPj4+PiBEbyB3ZSBldmVu
IHN0aWxsIG5lZWQgdGhpcyBpZiB3ZSByZXF1aXJlIDgtYnl0ZSBhbGlnbm1lbnQ/wqAgV2UnZCBu
ZXZlciBiZSBhYmxlIHRvIGN1dCBhIHNpbmdsZSBmaWVsZCBpbiB0aGUgbWlkZGxlDQo+Pj4NCj4+
PiBobW0sIGZvciBleGFtcGxlOg0KPj4+IDEwNTogY29tcHJlc3Npb24gYnl0ZQ0KPj4+IDEwNi0x
MTM6IHNvbWUgb3RoZXIgOC1ieXRlcyBmaWVsZCwgdW5hbGluZ2VkDQo+Pj4gMTEzLTExOTogcGFk
ZGluZyB0byBtdWx0aXBseSBvZiA4DQo+Pj4NCj4+PiAtIGJhZCBleGFtcGxlLCBmb3Igc3VyZS4g
QnV0IHRvIHByZXZlbnQgaXQsIHdlIHNob3VsZCBhbHNvIGRlZmluZSBzb21lIGZpZWxkIGFsaWdu
bWVudCByZXF1aXJlbWVudHMuLg0KPj4+DQo+Pj4NCj4+Pj4gLCBidXQgSSBzdXBwb3NlIHlvdSBh
cmUgd29ycmllZCBhYm91dCBjdXR0aW5nIGEgMi1maWVsZCAxNi1ieXRlIGFkZGl0aW9uIHRpZWQg
dG8gYSBzaW5nbGUgZmVhdHVyZSBpbiB0aGUgbWlkZGxlLg0KPj4+DQo+Pj4gYW5kIHRoaXMgdG9v
Lg0KPj4+DQo+Pj4+IMKgwqAgQnV0IHRoYXQncyBub3QgZ29pbmcgdG8gaGFwcGVuIGluIHByYWN0
aWNlLg0KPj4+DQo+Pj4gd2h5IG5vdD8NCj4+Pg0KPj4+IDQgYnl0ZXM6IGZlYXR1cmUgMQ0KPj4+
DQo+Pj4gNCBieXRlczogZmVhdHVyZSAyDQo+Pj4gOCBieXRlczogZmVhdHVyZSAyDQo+Pj4NCj4+
PiBzbywgbGFzdCAxMiBieXRlcyBtYXkgYmUgY29uc2lkZXJlZCBhcyBvbmUgZmllbGQuLiBBbmQg
c29mdHdhcmUgd2hpY2ggZG9uJ3Qga25vdyBhYm91dCBmZWF0dXJlMiwgd2lsbCBwYWQgaGVhZGVy
IHRvIHRoZSBtaWRkbGUgb2YgZmVhdHVyZTINCj4+Pg0KPj4+PiBUaGUgb25seSB0aW1lIHRoZSBo
ZWFkZXIgd2lsbCBiZSBsb25nZXIgdGhhbiAxMDQgYnl0ZXMgaXMgaWYgYXQgbGVhc3Qgb25lIGRv
Y3VtZW50ZWQgb3B0aW9uYWwgZmVhdHVyZSBoYXMgYmVlbiBpbXBsZW1lbnRlZC9iYWNrcG9ydGVk
LCBhbmQgdGhhdCBmZWF0dXJlIHdpbGwgYmUgaW1wbGVtZW50ZWQgaW4gaXRzIGVudGlyZXR5LsKg
IElmIHlvdSBiYWNrcG9ydCBhIGxhdGVyIGZlYXR1cmUgYnV0IG5vdCB0aGUgZWFybGllciwgeW91
J3JlIHN0aWxsIGdvaW5nIHRvIHNldCBoZWFkZXJfbGVuZ3RoIHRvIHRoZSBib3VuZGFyeSBvZiB0
aGUgZmVhdHVyZSB0aGF0IHlvdSBBUkUgYmFja3BvcnRpbmcuDQo+Pj4NCj4+PiBUaGF0J3MgdHJ1
ZSwgb2YgY291cnNlLg0KPj4+DQo+Pj4+IMKgwqAgVGh1cywgSSBhcmd1ZSB0aGF0IGJsaW5kbHkg
c2V0dGluZyBoZWFkZXJfbGVuZ3RoIHRvIDEyMCBwcmlvciB0byB0aGUgc3RhbmRhcmQgZXZlciBk
ZWZpbmluZyBvcHRpb25hbCBmaWVsZChzKSBhdCAxMTItMTIwIGlzIHByZW1hdHVyZSwgYW5kIHRo
YXQgaWYgd2UgZXZlciBhZGQgYSBmZWF0dXJlIHJlcXVpcmluZyBieXRlcyAxMTItMTI4IGZvciBh
IG5ldyBmZWF0dXJlLCB5b3Ugd2lsbCBuZXZlciBzZWUgYSB2YWxpZCBxY293MiBmaWxlIHdpdGgg
YSBoZWFkZXIgbGVuZ3RoIG9mIDEyMC4NCj4+Pg0KPj4+IGNvbnNpZGVyIG15IGV4YW1wbGUgYWJv
dmUuDQo+Pg0KPj4gQXMgbG9uZyBhcyB3ZSBuZXZlciBhZGQgbmV3IGZpZWxkcyB0aGF0IGFyZSBu
b3QgOC1ieXRlIGFsaWduZWQgKGluY2x1ZGluZyBhbnkgZXhwbGljaXQgcGFkZGluZyksIHRoZW4g
d2Ugd2lsbCBuZXZlciBoYXZlIHRoZSBjYXNlIG9mIGRpdmlkaW5nIGZpZWxkcyBpbiB0aGUgbWlk
ZGxlIGJ5IGtlZXBpbmcgdGhlIGhlYWRlciBsZW5ndGggYSBtdWx0aXBsZSBvZiA4Lg0KPj4NCj4g
DQo+IE9LLg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

