Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D24C606CF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 12:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CCA2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 12:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CCA2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlBdX-0005d9-Eo
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 08:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hlBY1-0003HJ-Cc
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 08:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hlBY0-0003Vh-3Y
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 08:18:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:20677)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hlBXy-0003HR-1k
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 08:18:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jul 2019 05:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; d="scan'208";a="159750015"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga008.jf.intel.com with ESMTP; 10 Jul 2019 05:18:03 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 05:18:03 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 05:18:03 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.55]) with mapi id 14.03.0439.000;
 Wed, 10 Jul 2019 20:18:01 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Thread-Topic: [RFC v1 07/18] hw/pci: add pci_device_bind/unbind_gpasid
Thread-Index: AQHVM+ylJSuaOlaygUCdWu9uaMDG5abBdTOAgAJVvKA=
Date: Wed, 10 Jul 2019 12:18:00 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439F2A70A@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-8-git-send-email-yi.l.liu@intel.com>
 <1dbeec81-8fa6-4e5c-fc62-4a999387bd12@redhat.com>
In-Reply-To: <1dbeec81-8fa6-4e5c-fc62-4a999387bd12@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTMxZDUxNjYtOTAzNi00MWU3LTliMTMtMDBjNjdkYjQ4ZWZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMEVkbzd6XC9pWUE5SVlrbzdpWXFXd0JsSCtyaDlEK3N3UjVMajdQQ0lNeUdTV1dNUUQ1Rm1cL1BERjBzdFRSNmU4In0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [RFC v1 07/18] hw/pci: add
 pci_device_bind/unbind_gpasid
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRXJpYywNCg0KPiBGcm9tOiBBdWdlciBFcmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQu
Y29tXQ0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDksIDIwMTkgNDozOCBQTQ0KPiBUbzogTGl1LCBZ
aSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IG1zdEByZWRo
YXQuY29tOw0KPiBTdWJqZWN0OiBSZTogW1JGQyB2MSAwNy8xOF0gaHcvcGNpOiBhZGQgcGNpX2Rl
dmljZV9iaW5kL3VuYmluZF9ncGFzaWQNCj4gDQo+IEhpIExpdSwNCj4gDQo+IE9uIDcvNS8xOSAx
OjAxIFBNLCBMaXUgWWkgTCB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMgdHdvIGNhbGxiYWNr
cyBwY2lfZGV2aWNlX2JpbmQvdW5iaW5kX2dwYXNpZCgpIHRvDQo+ID4gUENJUEFTSURPcHMuIFRo
ZXNlIHR3byBjYWxsYmFja3MgYXJlIHVzZWQgdG8gcHJvcGFnYXRlIGd1ZXN0IHBhc2lkDQo+ID4g
YmluZC91bmJpbmQgdG8gaG9zdC4gVGhlIGltcGxlbWVudGF0aW9ucyBvZiB0aGUgY2FsbGJhY2tz
IHdvdWxkIGJlDQo+ID4gZGV2aWNlIHBhc3N0aHJ1IG1vZHVsZXMgbGlrZSB2ZmlvLg0KPiA+DQo+
ID4gQ2M6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KPiA+IENjOiBKYWNvYiBQ
YW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiA+IENjOiBQZXRlciBYdSA8cGV0
ZXJ4QHJlZGhhdC5jb20+DQo+ID4gQ2M6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNv
bT4NCj4gPiBDYzogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IERh
dmlkIEdpYnNvbiA8ZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1Pg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L3BjaS9w
Y2kuYyAgICAgICAgIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGlu
Y2x1ZGUvaHcvcGNpL3BjaS5oIHwgIDkgKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
MzkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3
L3BjaS9wY2kuYyBpbmRleCA3MTBmOWU5Li4yMjI5MjI5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3Bj
aS9wY2kuYw0KPiA+ICsrKyBiL2h3L3BjaS9wY2kuYw0KPiA+IEBAIC0yNjc2LDYgKzI2NzYsMzYg
QEAgaW50IHBjaV9kZXZpY2VfcmVxdWVzdF9wYXNpZF9mcmVlKFBDSUJ1cyAqYnVzLA0KPiBpbnQz
Ml90IGRldmZuLA0KPiA+ICAgICAgcmV0dXJuIC0xOw0KPiA+ICB9DQo+ID4NCj4gPiArdm9pZCBw
Y2lfZGV2aWNlX2JpbmRfZ3Bhc2lkKFBDSUJ1cyAqYnVzLCBpbnQzMl90IGRldmZuLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBncGFzaWRfYmluZF9kYXRhICpn
X2JpbmRfZGF0YSkNCj4gc3RydWN0IGdwYXNpZF9iaW5kX2RhdGEgaXMgZGVmaW5lZCBpbiBsaW51
eCBoZWFkZXJzIHNvIEkgdGhpbmsgeW91IHdvdWxkDQo+IG5lZWQ6ICNpZmRlZiBfX2xpbnV4X18N
Cg0KT29wcywgdGhhbmtzIGZvciB0aGUgcmVtaW5kLg0KDQpSZWdhcmRzLA0KWWkgTGl1DQo=

