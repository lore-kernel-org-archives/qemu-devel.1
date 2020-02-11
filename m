Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87422C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E088206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E088206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XPf-0006CY-IJ
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sebastien.boeuf@intel.com>) id 1j1XOk-0005Zf-NG
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebastien.boeuf@intel.com>) id 1j1XOi-0005Xz-Jf
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:24:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:10472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
 id 1j1XOi-0005Vp-By
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:24:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 07:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
 d="scan'208,223";a="405967096"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by orsmga005.jf.intel.com with ESMTP; 11 Feb 2020 07:24:18 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.101]) with mapi id 14.03.0439.000;
 Tue, 11 Feb 2020 07:24:18 -0800
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: docs: Update vhost-user spec regarding backend program conventions
Thread-Topic: docs: Update vhost-user spec regarding backend program
 conventions
Thread-Index: AQHV4O9TY4yCVz7xVU+TIDtOwGOnlA==
Date: Tue, 11 Feb 2020 15:24:18 +0000
Message-ID: <15a5fbc76266fb51b365e66872c105b9e2832999.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.25.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A1FEFBA75A0AA4A9CC2EE183A3E03E4@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbSBjMDczZDUyOGI4Y2Q3MDgyODMyZmQxODI1ZGMzM2RkNjViMzA1YWEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogU2ViYXN0aWVuIEJvZXVmIDxzZWJhc3RpZW4uYm9ldWZAaW50
ZWwuY29tPg0KRGF0ZTogVHVlLCAxMSBGZWIgMjAyMCAxNjowMToyMiArMDEwMA0KU3ViamVjdDog
W1BBVENIXSBkb2NzOiBVcGRhdGUgdmhvc3QtdXNlciBzcGVjIHJlZ2FyZGluZyBiYWNrZW5kIHBy
b2dyYW0NCiBjb252ZW50aW9ucw0KDQpUaGUgdmhvc3QtdXNlciBzcGVjaWZpY2F0aW9uIGlzIG5v
dCBjbGVhcmx5IHN0YXRpbmcgdGhlIGV4cGVjdGVkDQpiZWhhdmlvciBmcm9tIGEgYmFja2VuZCBw
cm9ncmFtIHdoZW5ldmVyIHRoZSBjbGllbnQgZGlzY29ubmVjdHMuDQoNClRoaXMgcGF0Y2ggYWRk
cmVzc2VzIHRoZSBpc3N1ZSBieSBkZWZpbmluZyB0aGUgZGVmYXVsdCBiZWhhdmlvciBhbmQNCnBy
b3Bvc2luZyBhbiBhbHRlcm5hdGl2ZSB0aHJvdWdoIGEgY29tbWFuZCBsaW5lIG9wdGlvbi4NCg0K
QnkgZGVmYXVsdCwgYSBiYWNrZW5kIHByb2dyYW0gd2lsbCBoYXZlIHRvIGtlZXAgbGlzdGVuaW5n
IGV2ZW4gaWYgdGhlDQpjbGllbnQgZGlzY29ubmVjdHMsIHVubGVzcyB0b2xkIG90aGVyd2lzZSB0
aHJvdWdoIHRoZSBuZXdseSBpbnRyb2R1Y2VkDQpvcHRpb24gLS1leGl0LW9uLWRpc2Nvbm5lY3Qu
DQoNClNpZ25lZC1vZmYtYnk6IFNlYmFzdGllbiBCb2V1ZiA8c2ViYXN0aWVuLmJvZXVmQGludGVs
LmNvbT4NClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4NCi0tLQ0KIGRvY3MvaW50ZXJvcC92aG9zdC11c2VyLnJzdCB8IDEwICsrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZG9jcy9pbnRl
cm9wL3Zob3N0LXVzZXIucnN0IGIvZG9jcy9pbnRlcm9wL3Zob3N0LXVzZXIucnN0DQppbmRleCA1
ZjhiM2E0NTZiLi5kYTlhMWViYzRjIDEwMDY0NA0KLS0tIGEvZG9jcy9pbnRlcm9wL3Zob3N0LXVz
ZXIucnN0DQorKysgYi9kb2NzL2ludGVyb3Avdmhvc3QtdXNlci5yc3QNCkBAIC0xMzIzLDYgKzEz
MjMsMTAgQEAgVGhlIGJhY2tlbmQgcHJvZ3JhbSBtdXN0IGVuZCAoYXMgcXVpY2tseSBhbmQgY2xl
YW5seSBhcyBwb3NzaWJsZSkgd2hlbg0KIHRoZSBTSUdURVJNIHNpZ25hbCBpcyByZWNlaXZlZC4g
RXZlbnR1YWxseSwgaXQgbWF5IHJlY2VpdmUgU0lHS0lMTCBieQ0KIHRoZSBtYW5hZ2VtZW50IGxh
eWVyIGFmdGVyIGEgZmV3IHNlY29uZHMuDQogDQorQnkgZGVmYXVsdCwgdGhlIGJhY2tlbmQgcHJv
Z3JhbSBjb250aW51ZXMgcnVubmluZyBhZnRlciB0aGUgY2xpZW50DQorZGlzY29ubmVjdHMuIEl0
IGFjY2VwdHMgb25seSAxIGNvbm5lY3Rpb24gYXQgYSB0aW1lIG9uIGVhY2ggVU5JWCBkb21haW4N
Citzb2NrZXQuDQorDQogVGhlIGZvbGxvd2luZyBjb21tYW5kIGxpbmUgb3B0aW9ucyBoYXZlIGFu
IGV4cGVjdGVkIGJlaGF2aW91ci4gVGhleQ0KIGFyZSBtYW5kYXRvcnksIHVubGVzcyBleHBsaWNp
dGx5IHNhaWQgZGlmZmVyZW50bHk6DQogDQpAQCAtMTMzNyw2ICsxMzQxLDEyIEBAIGFyZSBtYW5k
YXRvcnksIHVubGVzcyBleHBsaWNpdGx5IHNhaWQgZGlmZmVyZW50bHk6DQogICB2aG9zdC11c2Vy
IHNvY2tldCBhcyBmaWxlIGRlc2NyaXB0b3IgRkROVU0uIEl0IGlzIGluY29tcGF0aWJsZSB3aXRo
DQogICAtLXNvY2tldC1wYXRoLg0KIA0KKy0tZXhpdC1vbi1kaXNjb25uZWN0DQorDQorICBXaGVu
IHRoaXMgb3B0aW9uIGlzIHByb3ZpZGVkLCB0aGUgYmFja2VuZCBwcm9ncmFtIG11c3QgdGVybWlu
YXRlIHdoZW4NCisgIHRoZSBjbGllbnQgZGlzY29ubmVjdHMuIFRoaXMgY2FuIGJlIHVzZWQgdG8g
a2VlcCB0aGUgYmFja2VuZCBwcm9ncmFtJ3MNCisgIGxpZmV0aW1lIHN5bmNocm9uaXplZCB3aXRo
IGl0cyBjbGllbnQgcHJvY2Vzcy4NCisNCiAtLXByaW50LWNhcGFiaWxpdGllcw0KIA0KICAgT3V0
cHV0IHRvIHN0ZG91dCB0aGUgYmFja2VuZCBjYXBhYmlsaXRpZXMgaW4gSlNPTiBmb3JtYXQsIGFu
ZCB0aGVuDQotLSANCjIuMjAuMQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50ZWwgQ29ycG9yYXRpb24gU0FT
IChGcmVuY2ggc2ltcGxpZmllZCBqb2ludCBzdG9jayBjb21wYW55KQpSZWdpc3RlcmVkIGhlYWRx
dWFydGVyczogIkxlcyBNb250YWxldHMiLSAyLCBydWUgZGUgUGFyaXMsIAo5MjE5NiBNZXVkb24g
Q2VkZXgsIEZyYW5jZQpSZWdpc3RyYXRpb24gTnVtYmVyOiAgMzAyIDQ1NiAxOTkgUi5DLlMuIE5B
TlRFUlJFCkNhcGl0YWw6IDQsNTcyLDAwMCBFdXJvcwoKVGhpcyBlLW1haWwgYW5kIGFueSBhdHRh
Y2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yCnRoZSBzb2xlIHVz
ZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBBbnkgcmV2aWV3IG9yIGRpc3RyaWJ1dGlv
bgpieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkCnJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFs
bCBjb3BpZXMuCg==


