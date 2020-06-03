Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F201C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CB320678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 11:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CB320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgRvw-0000de-Mo
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 07:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgRv6-0008Qt-H2; Wed, 03 Jun 2020 07:50:56 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2104 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgRv5-0003qS-Cw; Wed, 03 Jun 2020 07:50:56 -0400
Received: from lhreml706-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id DF1B79064C5E8DFC0116;
 Wed,  3 Jun 2020 12:50:48 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml706-chm.china.huawei.com (10.201.108.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 3 Jun 2020 12:50:48 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Wed, 3 Jun 2020 12:50:48 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, Andrew Jones <drjones@redhat.com>
Subject: RE: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Topic: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Index: AdY3+/mIYt1+TQdDQmymnxAa7PkUWwBhkdKAAADBa4AABaxxMA==
Date: Wed, 3 Jun 2020 11:50:48 +0000
Message-ID: <c282b7adf50b4e06bf30d7944c1f0c06@huawei.com>
References: <b2e401cd17fe49d792d09b31bd726e35@huawei.com>
 <20200603093745.dwfb55ny34az7rez@kamzik.brq.redhat.com>
 <fb9cf73c-e94b-b7f9-1d11-dc0353dd3996@redhat.com>
In-Reply-To: <fb9cf73c-e94b-b7f9-1d11-dc0353dd3996@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.30.55]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 07:45:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRXJpYywNCg0KPiBGcm9tOiBRZW11LWFybSBbbWFpbHRvOnFlbXUtYXJtLWJvdW5jZXMrc2Fs
aWwubWVodGE9aHVhd2VpLmNvbUBub25nbnUub3JnXQ0KPiBPbiBCZWhhbGYgT2YgQXVnZXIgRXJp
Yw0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMywgMjAyMCAxMDo1OSBBTQ0KPiBUbzogQW5kcmV3
IEpvbmVzIDxkcmpvbmVzQHJlZGhhdC5jb20+OyBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVh
d2VpLmNvbT4NCj4gQ2M6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47
IElnb3IgTWFtbWVkb3YNCj4gPGltYW1tZWRvQHJlZGhhdC5jb20+OyBxZW11LWFybUBub25nbnUu
b3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IG1zdEByZWRoYXQuY29tDQo+IFN1YmplY3Q6
IFJlOiBbUXVlc3Rpb25dIFJlZ2FyZGluZyBQTVUgaW5pdGlhbGl6YXRpb24gd2l0aGluIHRoZSBR
RU1VIGZvciBBUk0NCj4gVkNQVXMNCj4gDQo+IEhpIERyZXcsDQo+IA0KPiBPbiA2LzMvMjAgMTE6
MzcgQU0sIEFuZHJldyBKb25lcyB3cm90ZToNCj4gPiBPbiBNb24sIEp1biAwMSwgMjAyMCBhdCAw
MzowNDozM1BNICswMDAwLCBTYWxpbCBNZWh0YSB3cm90ZToNCj4gPj4gSGVsbG8sDQo+ID4+IEkg
Y291bGQgc2VlIGJlbG93IHdpdGhpbiBmdW5jdGlvbiBmZHRfYWRkX3BtdV9ub2RlcygpIHBhcnQg
b2YNCj4gPj4gaHcvYXJtL3ZpcnQuYyBkdXJpbmcgdmlydCBtYWNoaW5lIGluaXRpYWxpemF0aW9u
IHRpbWU6DQo+ID4+DQo+ID4+IE9ic2VydmF0aW9uOg0KPiA+PiBJbiBiZWxvdyBmdW5jdGlvbiwg
c3VwcG9ydCBvZiBQTVUgZmVhdHVyZSBpcyBiZWluZyBjaGVja2VkIGZvcg0KPiA+PiBlYWNoIHZj
cHUgYW5kIGlmIHRoZSBQTVUgaXMgZm91bmQgcGFydCBvZiB0aGUgZmVhdHVyZXMgdGhlbiBQTVUN
Cj4gPj4gaXMgaW5pdGlhbGl6ZWQgd2l0aCBpbiB0aGUgaG9zdC9LVk0uIEJ1dCBpZiB0aGVyZSBp
cyBldmVuIG9uZQ0KPiA+PiB2Y3B1IHdoaWNoIGlzIGZvdW5kIHRvIG5vdCBzdXBwb3J0IHRoZSBQ
TVUgdGhlbiBsb29wIGlzIGV4aXRlZA0KPiA+PiBhbmQgUE1VIGlzIG5vdCBpbml0aWFsaXplZCBm
b3IgdGhlIHJlc3Qgb2YgdGhlIHZjcHVzIGFzIHdlbGwuDQo+ID4+DQo+ID4+IFF1ZXN0aW9uczoN
Cj4gPj4gUTEuIE5vdCBzdXJlIHdoYXQgaXMgdGhlIGxvZ2ljIG9mIHRoZSBwcmVtYXR1cmUgZXhp
dCBhbmQgbm90DQo+ID4+ICAgICBjb250aW51aW5nIHdpdGggZnVydGhlciBjaGVja3MgYW5kIGlu
aXRpYWxpemF0aW9uIG9mIG90aGVyDQo+ID4+ICAgICBWQ1BVIFBNVXM/DQo+ID4NCj4gPiBLVk0g
cmVxdWlyZXMgYWxsIFZDUFVzIHRvIGhhdmUgYSBQTVUgaWYgb25lIGRvZXMuDQo+IA0KPiBJIGZh
aWwgdG8gZmluZCB3aGVyZSB0aGlzIGlzIGVuZm9yY2VkPyBEbyB5b3Uga25vdyB0aGUgcGxhY2U/
DQo+IA0KPiAgSWYgdGhlIEFSTSBBUk0NCj4gPiBzYXlzIGl0J3MgcG9zc2libGUgdG8gaGF2ZSBQ
TVVzIGZvciBvbmx5IHNvbWUgQ1BVcywgdGhlbiwgZm9yIFRDRywNCj4gPiB0aGUgcmVzdHJpY3Rp
b24gY291bGQgYmUgcmVsYXhlZC4gSSBleHBlY3QgaXQgd2lsbCB0YWtlIG1vcmUgdGhhbg0KPiA+
IGp1c3QgcmVtb3ZpbmcgdGhlIGNoZWNrIGZvciB0aGluZ3MgdG8gd29yayB0aG91Z2guPg0KPiA+
PiBRMi4gRG9lcyBpdCBldmVuIG1ha2VzIHNlbnNlIHRvIGhhdmUgUE1VcyBpbml0aWFsaXplZCBm
b3Igc29tZQ0KPiA+PiAgICAgdmNwdXMgYW5kIG5vdCBmb3Igb3RoZXJzIHVubGVzcyB3ZSBoYXZl
IGhldGVyb2dlbmVvdXMgc3lzdGVtPw0KPiA+DQo+ID4gSSBkb24ndCBrbm93LCBidXQgaXQgZG9l
c24ndCBzb3VuZCBsaWtlIGEgY29uZmlndXJhdGlvbiBJJ2QgbGlrZQ0KPiA+IHRvIHNlZS4NCj4g
Pg0KPiA+PiBRMy4gQWxzbywgdGhlcmUgaXMgYSBwZXIgdmlydCBtYWNoaW5lIGtub2Igb2YgdmNj
LT5ub19wbXUuDQo+ID4+ICAgICBUaGlzIGlzIHNvbWV0aGluZyB3aGljaCB1c2VyIGNvdWxkIHNw
ZWNpZnkgYXQgdGhlIGluaXQgdGltZQ0KPiA+PiAgICAgYW5kIHBlcmhhcHMgb25seSBvbmNlIGJ1
dCB3ZSBkb24ndCB1c2UgaXQgZm9yIEFSTS4gUGVyaGFwcw0KPiA+PiAgICAgc2hvdWxkIGhhdmUg
YmVlbiB1c2VkIGV2ZW4gYmVmb3JlIGVudGVyaW5nIHRoaXMgZnVuY3Rpb24NCj4gPj4gICAgIHRv
IGVuYWJsZSBvciBkaXNhYmxlIHRoZSBzdXBwb3J0IGFzIHBlciB1c2VyIGNvbmZpZz8NCj4gPg0K
PiA+IEl0J3MgcHVycG9zZSBpcyB0byBrZWVwIHVzZXJzIGZyb20gZG9pbmcgJ3BtdT1vbicgb24g
Mi42IG1hY2hpbmUNCj4gPiB0eXBlcy4gT24gMi43IGFuZCBsYXRlciBtYWNoaW5lIHR5cGVzIGlm
IHlvdSBkb24ndCB3YW50IGEgUE1VDQo+ID4geW91IHNob3VsZCB1c2UgJ3BtdT1vZmYnLg0KPiAN
Cj4gZXh0cmEgbm90ZToNCj4gdGhlIGNwdSBwbXUgcHJvcGVydHkgc2V0cyB0aGUgZmVhdHVyZSBh
dCB2Y3B1IGxldmVsLiBUaGlzIGlzIHdoYXQgaXMNCj4gcmV0cmlldmVkIHdoZW4gKCFhcm1fZmVh
dHVyZSgmYXJtY3B1LT5lbnYsIEFSTV9GRUFUVVJFX1BNVSkpIGdldHMgY2FsbGVkLg0KPiANCj4g
U2VlIHRoZSBjcHUgb3B0aW9uIHNldHRlcjogYXJtX3NldF9wbXUgaW4gdGFyZ2V0L2FybS9jcHUu
Yw0KDQoNCkluZGVlZC4gSXQgaXMgYmVpbmcgc2V0IG9uIHBlci12Y3B1IGxldmVsIGJ1dCBhY3R1
YWxseSBhbGwgb2YNCnRoZSB2Y3B1cyB3aWxsIGVpdGhlciBoYXZlIE9OIG9yIE9GRiBQTVUgZmVh
dHVyZSAtIGF0IGxlYXN0IGZvcg0Kbm93LiBOb3Qgc3VyZSBpZiB3ZSBldmVyIHdhbnQgdG8gY2hh
bmdlIHRoaXMgaW4gZnV0dXJlPw0KDQpUaGFua3MNClNhbGlsLg0KDQo=

