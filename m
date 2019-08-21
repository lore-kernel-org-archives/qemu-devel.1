Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E169C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:01:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C1222CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C1222CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ucloud.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0PIa-000682-Vs
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 08:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <owen.si@ucloud.cn>) id 1i0PCA-0000Zp-9L
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <owen.si@ucloud.cn>) id 1i0PC5-000398-4Z
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:54:27 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:64426)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <owen.si@ucloud.cn>) id 1i0PC4-00033V-I8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:54:25 -0400
Received: from SKY-20190329ATQ (unknown [117.48.120.186])
 by m9785.mail.qiye.163.com (Hmail) with ESMTPA id 7C51A5C1184;
 Wed, 21 Aug 2019 19:54:17 +0800 (CST)
Date: Wed, 21 Aug 2019 19:54:17 +0800
From: "owen.si@ucloud.cn" <owen.si@ucloud.cn>
To: "Eduardo Habkost" <ehabkost@redhat.com>
References: <20190819100924.14968-1-owen.si@ucloud.cn>, 
 <20190820212306.GM3908@habkost.net>, 
 <2019082111044638341815@ucloud.cn>, 
 <20190821111934.GO3908@habkost.net>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.10.151[cn]
Mime-Version: 1.0
Message-ID: <2019082119541665112723@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVktVSkNDS0tLSkNMSUxMTEJPWVdZKF
 lBSUI3V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pz46SAw6Czg1Cz4pKDBNIx8#
 OTVPCy9VSlVKTk1NSENDT05MTE9LVTMWGhIXVRQMHhVVCBI7DhgXFA4fVRgVRVlXWRILWUFZSkpM
 VU9DVUpJS1VKQ01ZV1kIAVlBSkpJTkk3Bg++
X-HM-Tid: 0a6cb40710352087kuqy7c51a5c1184
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.97.85
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] Revert "i386: correct cpu_x86_cpuid(0xd)"
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SXQgaXMgQ2VudE9TIDYuMyB3aXRoIGtlcm5lbCB2ZXJzaW9uIDIuNi4zMi0yNzkuIEFjdHVhbGx5
IGFsbCBDZW50T1MgNiByZWxlYXNlcyBoYXZlIHRoaXMgaXNzdWUuDQoNCg0KDQpvd2VuLnNpQHVj
bG91ZC5jbg0KIA0KRnJvbTogRWR1YXJkbyBIYWJrb3N0DQpEYXRlOiAyMDE5LTA4LTIxIDE5OjE5
DQpUbzogb3dlbi5zaUB1Y2xvdWQuY24NCkNDOiBxZW11LWRldmVsDQpTdWJqZWN0OiBSZTogUmU6
IFtRZW11LWRldmVsXSBbUEFUQ0hdIFJldmVydCAiaTM4NjogY29ycmVjdCBjcHVfeDg2X2NwdWlk
KDB4ZCkiDQpPbiBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAxMTowNDo0NkFNICswODAwLCBvd2VuLnNp
QHVjbG91ZC5jbiB3cm90ZToNCj4gVGhhbmtzIGZvciB5b3UgcmVwbHksIHdlIGhhdmUgc29tZSBo
b3N0cyBydW5uaW5nIHdpdGggbGVnYWN5IGtlcm5lbCwgZGlmZmljdWx0IHRvIHVwZ3JhZGUsIGFu
ZCBpIHdhbnQgdG8gcnVuIHRoZSBsYXRlc3QgcWVtdS4NCj4gRG9lcyBRRU1VIHN1cHBvcnQgcnVu
bmluZyB3aXRoIGxlZ2FjeSBrZXJuZWwoa3ZtKSBpbiBkZXNpZ24/DQogDQpGb3IgS1ZNLCBRRU1V
IHJlcXVpcmVzIExpbnV4IDQuNSBvciBuZXdlci4gIFNlZSAiU3lzdGVtDQpyZXF1aXJlbWVudHMi
IC8gIktWTSBrZXJuZWwgbW9kdWxlIiBzZWN0aW9uIG9uIHFlbXUtZG9jLiAgV2UgYWxzbw0KYWlt
IHRvIHN1cHBvcnQgdGhlIGxhdGVzdCB2ZXJzaW9uIG9mIExpbnV4IGRpc3RyaWJ1dGlvbnMgd2l0
aA0KbG9uZyB0ZXJtIHN1cHBvcnQgKGUuZy4gUkhFTCwgRGViaWFuLCBVYnVudHUgTFRTLCBTTEVT
KS4NCiANCkRvIHlvdSBoYXZlIG1vcmUgZGV0YWlscyBvbiB0aGUga2VybmVsIHlvdSBhcmUgdXNp
bmc/ICBJcyBpdA0KYnVpbHQgYW5kIGRpc3RyaWJ1dGVkIGJ5IGEgdGhpcmQgcGFydHk/DQogDQog
DQo+IA0KPiANCj4gDQo+IG93ZW4uc2lAdWNsb3VkLmNuDQo+ICANCj4gRnJvbTogRWR1YXJkbyBI
YWJrb3N0DQo+IERhdGU6IDIwMTktMDgtMjEgMDU6MjMNCj4gVG86IEJpbmdzb25nIFNpDQo+IEND
OiBxZW11LWRldmVsDQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1kZXZlbF0gW1BBVENIXSBSZXZlcnQg
ImkzODY6IGNvcnJlY3QgY3B1X3g4Nl9jcHVpZCgweGQpIg0KPiBPbiBNb24sIEF1ZyAxOSwgMjAx
OSBhdCAwNjowOToyNFBNICswODAwLCBCaW5nc29uZyBTaSB3cm90ZToNCj4gPiBUaGlzIHJldmVy
dHMgY29tbWl0IGRlMmU2OGM5MDJmN2I2ZTQzOGIwZmEzY2ZlZGQ3NGEwNmEyMDcwNGYuDQo+ID4g
DQo+ID4gSW5pdGlhbCB2YWx1ZSBvZiBlbnYtPnhjcjAgPT0gMCwgdGhlbiBDUFVJRChFQVg9MHhk
LEVDWD0wKS5FQlggPT0gMCwgYWZ0ZXIga3ZtDQo+ID4gdXBzdHJlYW0gY29tbWl0IDQxMmEzYzQx
LCBJdCBpcyBvay4NCj4gPiBPbiBob3N0IGJlZm9yZSBjb21taXQgNDEyYTNjNDEsIHNvbWUgbGVn
YWN5IGd1ZXN0LCBpLmUuIENlbnRPUyA2LCBnZXQNCj4gPiB4c3RhdGVfc2l6ZSA9PSAwLCB3aWxs
IGNyYXNoIHRoZSBndWVzdC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaW5nc29uZyBTaSA8
b3dlbi5zaUB1Y2xvdWQuY24+DQo+ICANCj4gY3B1X3g4Nl9jcHVpZCgpIGlzIGFsc28gdXNlZCBi
eSBUQ0csIGFuZCBuZWVkcyB0byByZXR1cm4gdGhlDQo+IGNvcnJlY3QgZGF0YSBkZXBlbmRpbmcg
b24geGNyMC4gIElmIHlvdSB3YW50IHRvIHdvcmsgYXJvdW5kIGEgS1ZNDQo+IGJ1ZyBieSBpZ25v
cmluZyB4Y3IwLCBpdCBuZWVkcyB0byBiZSBjb25kaXRpb25hbCBvbg0KPiBrdm1fZW5hYmxlZCgp
Lg0KPiAgDQo+IEJ1dCBldmVuIGlmIHdlIHlvdSBtYWtlIHRoaXMgY29uZGl0aW9uYWwgb24ga3Zt
X2VuYWJsZWQoKSwgSQ0KPiBkb24ndCB1bmRlcnN0YW5kIHdoeSBRRU1VIHdvdWxkIG5lZWQgYSB3
b3JrYXJvdW5kIGZvciBhIEtWTSBidWcNCj4gdGhhdCB3YXMgZml4ZWQgbW9yZSB0aGFuIDQgeWVh
cnMgYWdvLg0KPiAgDQo+ID4gLS0tDQo+ID4gIHRhcmdldC9pMzg2L2NwdS5jIHwgMiArLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvY3B1LmMgYi90YXJnZXQvaTM4Ni9jcHUuYw0KPiA+
IGluZGV4IGZmNjVlMTEwMDguLjY5NTYyZTIxZWQgMTAwNjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L2kz
ODYvY3B1LmMNCj4gPiArKysgYi90YXJnZXQvaTM4Ni9jcHUuYw0KPiA+IEBAIC00NDE2LDcgKzQ0
MTYsNyBAQCB2b2lkIGNwdV94ODZfY3B1aWQoQ1BVWDg2U3RhdGUgKmVudiwgdWludDMyX3QgaW5k
ZXgsIHVpbnQzMl90IGNvdW50LA0KPiA+ICAgICAgICAgICAgICAqZWN4ID0geHNhdmVfYXJlYV9z
aXplKHg4Nl9jcHVfeHNhdmVfY29tcG9uZW50cyhjcHUpKTsNCj4gPiAgICAgICAgICAgICAgKmVh
eCA9IGVudi0+ZmVhdHVyZXNbRkVBVF9YU0FWRV9DT01QX0xPXTsNCj4gPiAgICAgICAgICAgICAg
KmVkeCA9IGVudi0+ZmVhdHVyZXNbRkVBVF9YU0FWRV9DT01QX0hJXTsNCj4gPiAtICAgICAgICAg
ICAgKmVieCA9IHhzYXZlX2FyZWFfc2l6ZShlbnYtPnhjcjApOw0KPiA+ICsgICAgICAgICAgICAq
ZWJ4ID0gKmVjeDsNCj4gPiAgICAgICAgICB9IGVsc2UgaWYgKGNvdW50ID09IDEpIHsNCj4gPiAg
ICAgICAgICAgICAgKmVheCA9IGVudi0+ZmVhdHVyZXNbRkVBVF9YU0FWRV07DQo+ID4gICAgICAg
ICAgfSBlbHNlIGlmIChjb3VudCA8IEFSUkFZX1NJWkUoeDg2X2V4dF9zYXZlX2FyZWFzKSkgew0K
PiA+IC0tIA0KPiA+IDIuMjIuMA0KPiA+IA0KPiA+IA0KPiAgDQo+IC0tIA0KPiBFZHVhcmRvDQog
DQotLSANCkVkdWFyZG8NCg==
