Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92436C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8A62064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rR6VaK8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8A62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybpY-0007TE-2W
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 08:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hybnx-0005yB-TV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hybnw-0000JI-0c
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:05 -0400
Received: from mail-eopbgr20129.outbound.protection.outlook.com
 ([40.107.2.129]:65260 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hybnv-0000IA-EM; Fri, 16 Aug 2019 08:58:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+DhHSFc7ZRSjQGnBDlzkD8eHCIKTDWOOUh40ShJtEo9BAUCCWxkY6bBOQSe/R0D7jbMoSxdmj4e/Ittob3e9UCidGChv9PuH/jsz0j0xcE3GZnqZamLUbol/gvUW+lK4lq8QyJCEBWhwfrOjvyRP5dkRMonLPUd18E4wbub/VWRjcIbGTvHPCOnfrgDTndKTe4ywjKkcf/kqYL3gv4yjh+8Peno2B39WHYjyrGQgMALMDzuIBiSZjAamel8qllKf4Yqy9t7WJRE2v2Y3Y9siMGa8bFiG7NDq2CRs7T1SrBML0gIva0YHaA5p7T1evc8mADR6SXAlUsGqfoDi/pgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CXVcoDludvPq2sM2TTBJjUQYg1lirnF5b/ACgVirK4=;
 b=jgBhQcwz+j8qAefVCDIHul+NuOnYjtihtaIrkaIXrBAOSrzlow0iNdDFfaY8TR2AXBwUi8qQXlWU+D7cMyF3oeyKN4IXiTjcyN3QcgO0ehLwW140PdKeaRcAfWn2piqSXNVdWn2ZUQOJf1O2brr1lUvmcsdxFKY8KlhDdzVAmAg9mMC2C9rWi5JCuZt7jI/okz22oW2kMuGMEQh/gyMwdKGwvpDZW+n/DOOQbS7cLuUbo+guvg8PXz7/CsS65pufinLVhEum6Baur77LljeXhaQ+WOYBQlF8a1GAKjVnhxE/N8wR0/RPcffgNsoVsCh7TtFhI1mJu03CoOFAAioq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CXVcoDludvPq2sM2TTBJjUQYg1lirnF5b/ACgVirK4=;
 b=rR6VaK8zgAcLywUJq+Bo+CWZlglLlAd6+wtY7k4izQZuxSyCRdr+KsxBLCLyYOsJKOc0lYidaHrp51bnUHgUanibALn20B18OS6XNvzKnjFomehIlmq+HozxKwyKkbhawX2uRcYbJAi/bJql/iTCes0swqaakfPirH45fupcOHo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4569.eurprd08.prod.outlook.com (20.179.12.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 16 Aug 2019 12:58:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 12:58:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
Thread-Index: AQHVUogdkuEpfSqLt0qlSVbE/q5j26b7B6gAgAEBgACAAFjygIAAC1OAgAArtpSAANingIAARtXfgAAGxQA=
Date: Fri, 16 Aug 2019 12:58:00 +0000
Message-ID: <99135eb2-5a37-32a3-090c-3c50d8730bb6@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <9c290e4e-1d3b-bc6e-c6e6-28a0414b866e@redhat.com>
 <20190815164821.GE7415@linux.fritz.box> <87a7caut8t.fsf@dusky.pond.sub.org>
 <20190816082013.GB5014@localhost.localdomain>
 <87d0h5p9wp.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0h5p9wp.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190816155758606
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08ff8e1d-66f8-424c-81e9-08d722495e41
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4569; 
x-ms-traffictypediagnostic: DB8PR08MB4569:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB45697FAF0348A3B259FC184BC1AF0@DB8PR08MB4569.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(346002)(396003)(376002)(366004)(199004)(189003)(66066001)(256004)(386003)(99286004)(6486002)(6506007)(81156014)(102836004)(7736002)(305945005)(229853002)(81166006)(8936002)(52116002)(8676002)(14444005)(76176011)(86362001)(53936002)(3846002)(6116002)(6436002)(31686004)(25786009)(71200400001)(4326008)(2906002)(6246003)(71190400001)(31696002)(66946007)(64756008)(66446008)(5660300002)(186003)(66556008)(66476007)(11346002)(316002)(110136005)(54906003)(36756003)(26005)(6512007)(2616005)(14454004)(446003)(478600001)(476003)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4569;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /ZhqMMJFJx+EWm9nUBU4lwg+4pM5exD2+6ndr92La6BRMbz+d06BIaYh78pJgMBT+Key1YD5pGwfFIA0pF/vDIJufDdopJsJaE0wOPCR6oaODzmlt+GHJYHW7/BwlPx2UgBBq2ttWZs5bG+iK8SXda3HzQFWCbi2yLTaiUWnLpTo6JwDsTVqZ17U5IcajF8BzAH8YW+3HOkCspNIjdB3E71rTfEOVzV9tEsKa0d+d8e0nxt7uGE0e+Vl2/couGcys1FkEbOfCcBTNOLpU94MNeeoZPbaRluayK2F9C82GZtdK2WSZk7E/IMPMxO9Koc0G4e0/CEqslAbp7Wpwka5ZOdDeTHy6uWZ1DKrSqyYgJnYNMQzgyerUQALs4biRinKanPpwsNbqC0EzAy13z/qUrmsVgVUZxxE+p4nMBrwsJE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <995E8E847396634582FEB1DAF6D6017E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ff8e1d-66f8-424c-81e9-08d722495e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 12:58:00.7734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8T1+nR1WS2S/ZlnOSlRmSTq9BmCvwl3emDg2iAMa8MFIwz7WTmJwXYv3hoCXGk/+ZDd/Bhn6CS9h/X/lEEN5JHOBSKDnRH2994DyPVe0uKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4569
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.129
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDguMjAxOSAxNTozMywgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IEtldmluIFdvbGYg
PGt3b2xmQHJlZGhhdC5jb20+IHdyaXRlczoNCj4gDQo+PiBBbSAxNS4wOC4yMDE5IHVtIDIxOjI0
IGhhdCBNYXJrdXMgQXJtYnJ1c3RlciBnZXNjaHJpZWJlbjoNCj4gWy4uLl0NCj4+PiBMZXQncyBh
c3N1bWUgYWxsIGxpYnZpcnQgZXZlciBkb2VzIHdpdGggZGVwcmVjYXRpb24gbm90aWNlcyBpcyBs
b2dnaW5nDQo+Pj4gdGhlbS4gIFdvdWxkIHRoYXQgc29sdmUgdGhlIHByb2JsZW0gb2YgcmVsaWFi
bHkgYWxlcnRpbmcgbGlidmlydA0KPj4+IGRldmVsb3BlcnMgdG8gZGVwcmVjYXRpb24gaXNzdWVz
PyAgTm9wZS4gIEJ1dCBpdCBjb3VsZCBoZWxwDQo+Pj4gb2NjYXNpb25hbGx5Lg0KPj4NCj4+IEkn
bSBub3Qgc2F5aW5nIHRoYXQgZGVwcmVjYXRpb24gbm90aWNlcyB3b3VsZCBodXJ0LCBqdXN0IHRo
YXQgdGhleQ0KPj4gcHJvYmFibHkgd29uJ3Qgc29sdmUgcHJvYmxlbSBhbG9uZS4NCj4gDQo+IE5v
IGFyZ3VtZW50Lg0KPiANCj4+IENyYXNoaW5nIGlmIC0tZnV0dXJlIGlzIGdpdmVuIGFuZCBsb2dn
aW5nIG90aGVyd2lzZSBzZWVtcyByZWFzb25hYmxlDQo+PiBlbm91Z2ggdG8gbWUuIFdoZXRoZXIg
d2UgbmVlZCB0byB3aXJlIHVwIGEgbmV3IGRlcHJlY2F0aW9uIG1lY2hhbmlzbSBpbg0KPj4gUU1Q
IGZvciB0aGUgbG9nZ2luZyBvciBpZiB3ZSBjYW4ganVzdCBrZWVwIHByaW50aW5nIHRvIHN0ZGVy
ciBpcw0KPj4gZGViYXRhYmxlLiBzdGRlcnIgYWxyZWFkeSBlbmRzIHVwIGluIGEgbG9nIGZpbGUs
IGEgUU1QIGV4dGVuc2lvbiB3b3VsZA0KPj4gcmVxdWlyZSBuZXcgbGlidmlydCBjb2RlLiBJZiBs
aWJ2aXJ0IHdvdWxkIGxvZyBkZXByZWNhdGlvbiBub3RpY2VzIG1vcmUNCj4+IHByb21pbmVudGx5
LCBvciB1c2UgdGhlIGluZm9ybWF0aW9uIGZvciB0YWludGluZyBvciBhbnkgb3RoZXIga2luZCBv
Zg0KPj4gcHJvY2Vzc2luZywgYSBkZWRpY2F0ZWQgUU1QIG1lY2hhbmlzbSBjb3VsZCBiZSBqdXN0
aWZpZWQuDQo+IA0KPiBJJ2QgbGlrZSB0byBzdGFydCB3aXRoIHR3byB0YXNrczoNCj4gDQo+ICog
QSBDTEkgb3B0aW9uIHRvIGNvbmZpZ3VyZSB3aGF0IHRvIGRvIG9uIHVzZSBvZiBhIGRlcHJlY2F0
ZWQgZmVhdHVyZS4NCj4gDQo+ICAgIFdlIGN1cnJlbnRseSB3YXJuLiAgV2Ugd2FudCB0byBiZSBh
YmxlIHRvIGNyYXNoIGluc3RlYWQuICBTaWxlbmNpbmcNCj4gICAgdGhlIHdhcm5pbmdzIG1pZ2h0
IGJlIHVzZWZ1bC4gIFR1cm5pbmcgdGhlbSBpbnRvIGVycm9ycyBtaWdodCBiZQ0KPiAgICB1c2Vm
dWwuDQo+IA0KPiAgICBUaGUgZXhpc3RpbmcgYWQgaG9jIHdhcm5pbmdzIG5lZWQgdG8gYmUgcmVw
bGFjZWQgYnkgYSBjYWxsIG9mIGEgY29tbW9uDQo+ICAgIGZ1bmN0aW9uIHRoYXQgaW1wbGVtZW50
cyB0aGUgY29uZmlndXJhYmxlIGJlaGF2aW9yLg0KPiANCj4gKiBRQVBJIGZlYXR1cmUgZmxhZyAi
ZGVwcmVjYXRlZCIsIGZvciBpbnRyb3NwZWN0YWJsZSBkZXByZWNhdGlvbiwgYW5kDQo+ICAgIHdp
dGhvdXQgYWQgaG9jIGNvZGUuDQo+IA0KPiBUaGVuIHNlZSB3aGV0aGVyIG91ciB1c2VycyBuZWVk
IG1vcmUuDQo+IA0KDQpDcmFzaGluZyBpcyB1c2VmdWwgZm9yIGxpYnZpcnQgZGV2ZWxvcGVycywg
aXQncyBvYnZpb3VzLCBqdXN0IGVuYWJsZSBjcmFzaC1vbi1kZXByZWNhdGVkDQpvbiBhbGwgdGVz
dGluZyBlbnZpcm9ubWVudHMgYW5kIG1vc3QgcHJvYmFibHkgd2Ugd2lsbCBub3QgbWlzcyBzdWNo
IGEgY2FzZS4NCg0KRm9yIHFhcGkgSSBkb3VidCBpcyBpdCByZWFsbHkgbmVlZGVkLiBJbXBsZW1l
bnRpbmcgY29kZSBpbiBsaWJ2aXJ0IHdoaWNoIHdpbGwgY2hlY2sgZm9yIGNvbW1hbmQNCihvciBp
dCdzIHBhcmFtZXRlciwgb3IgaXQncyBwYXJhbWV0ZXIgIm9wdGlvbmFsaXR5IiBpcyBkZXByZWNh
dGVkKSA/IEl0J3MgaGFyZCBhbmQgd2hhdCBsaWJ2aXJ0DQpzaG91bGQgcmVwb3J0IHRvIGZpbmFs
IHVzZXI/IEl0IGJlY29tZXMgYSBraW5kIG9mIHN5bnRoZXRpYyBlcnJvciBpbiBsaWJ2aXJ0IGNv
ZGUsIGxpa2UNCg0KLi4uDQpsb2dfZXJyb3IoIldlIGFyZSBnb2luZyB0byBkaXZpZGUgYnkgemVy
by4gSXQncyBhIGJ1ZywgcGxlYXNlIHJlcG9ydCBpdCB0byBkZXZlbG9wZXJzISIpOw0KeCA9IGEg
LyAwOw0KLi4uDQoNCkl0J3Mgc2ltcGxlciB0byBmaXggc2Vjb25kIGxpbmUgdGhhbiBpbXBsZW1l
bnQgc3BlY2lhbCBtZWNoYW5pc20gaW5jbHVkaW5nIHByb3RvY29sIHNwZWNpZmljYXRpb24NCnRv
IHJlcG9ydCBzdWNoIGEgY2FzZS4NCg0KSSBleGFnZ2VyYXRlIG9mIGNvdXJzZSB3aXRoIHRoaXMg
ZXhhbXBsZSwgYnV0IEkgZG91YnQgdGhhdCBpbXBsZW1lbnRpbmcgYSBzcGVjaWFsIHByb3RvY29s
DQpmb3IgaXQgd29ydGggZG9pbmcuIEFuZCBJIHRoaW5rIG5vdGlmeWluZyBsaWJ2aXJ0IGJ5IGVt
YWlsIChhcyBQZXRlciBzYWlkKSBhbmQgcHJvdmlkaW5nIG9wdGlvbg0KImNyYXNoLW9uLWRlcHJl
Y2F0ZWQiIGluIFFlbXUgYXJlIGVub3VnaCBmb3IgbGlidmlydCBkZXZlbG9wZXJzIHRvIHByZXZl
bnQgYW5kIHRvIGZpeCB1c2luZw0KZGVwcmVjYXRlZCB0aGluZ3MuDQoNCkluIG90aGVyIHdvcmRz
LCBJIGRvbid0IHNlZSB3aHkgcmVwb3J0aW5nIGRlcHJlY2F0ZWQgZmVhdHVyZSB1c2FnZSBpcyBi
ZXR0ZXIgaW4gbGlidmlydCB0aGFuIGluDQpRZW11IChieSB3YXJuaW5nLCBlcnJvciBvciBjcmFz
aCksIGFuZCBpbiBRZW11IGl0J3MgbXVjaCBtb3JlIHNpbXBsZSBhbmQgZG9uJ3QgbmVlZCBRQVBJ
IHByb3RvY29sDQpleHRlbnNpb24uDQoNCihJJ20gc29ycnkgaWYgSSdtIHJlcGVhdGluZyBhbHJl
YWR5IHdyaXR0ZW4gYXJndW1lbnRzLCBJJ3ZlIG5vdCByZWFkIHRoZSB3aG9sZSB0aHJlYWQpDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

