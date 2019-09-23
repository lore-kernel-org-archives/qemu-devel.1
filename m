Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7D3C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B2B207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="hI4CVkVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B2B207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCO2D-0005lc-6g
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iCKni-0007yI-1H
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iCKng-0007J2-S8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:38:33 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:4055)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1iCKnd-0007GP-Pf; Mon, 23 Sep 2019 05:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569231509;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ierprGRCESYRIdj5DW8nQBUyO1ByU8+f1CrJhVQvUV0=;
 b=hI4CVkVYI3S+p11VoVuUxhcWafpG+Gv9n15lYXGgHCVYqK/5K/nQ51ME
 u11xQsvndzGW1/QYBpDYDzFQw4QiqM1hNLDIiZjUd5yWanc8Yqj6m+/Mp
 LdiPKXgJKlb/jOhxEimc604xP6+ARD0qnmZc5g9Q1f/VU9g9Jf9DgfwsC M=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: F/v7CLDOXO16lQSTwXw1we4Z59glBPGzDhfUVg4T6cjedMZ5OMJPhhswQXH2dE0jvpCcL8aS8v
 kLMuHBJrl0M2b9GcpI8zz+HREEOQa+Cd9yJvQSFt9xcw/UflT7/7KiMRhCcbMJ6q+EC0mKCIIK
 RfIu0cNgPbcmOMe7fu43BkezqJ2KrQB56vfpClRjvtM+pmkoPemy6tACNfUzD5SEfITVA7d1qS
 +0qmSpFsahyKPypHYpr4GmrVJUCVm25I377YyGkL0pnd3qpWiTB3SvcBsMtzZaMpNZKwL+nNSQ
 NKs=
X-SBRS: 2.7
X-MesageID: 6247405
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,539,1559534400"; 
   d="scan'208";a="6247405"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: 'John Snow' <jsnow@redhat.com>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: RE: [Qemu-block] [PATCH] xen-block: treat XenbusStateUnknown the same
 as XenbusStateClosed
Thread-Topic: [Qemu-block] [PATCH] xen-block: treat XenbusStateUnknown the
 same as XenbusStateClosed
Thread-Index: AQHVbhg6evd30eCO0U6hN9t69Suydac08g8AgAQWodA=
Date: Mon, 23 Sep 2019 09:38:20 +0000
Message-ID: <46f838982f7d448b86391bc48e9d8179@AMSPEX02CL03.citrite.net>
References: <20190918115702.38959-1-paul.durrant@citrix.com>
 <d02b4f9a-4277-6aaf-324d-2c7958878690@redhat.com>
In-Reply-To: <d02b4f9a-4277-6aaf-324d-2c7958878690@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
X-Mailman-Approved-At: Mon, 23 Sep 2019 09:02:59 -0400
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Mark Syms <Mark.Syms@citrix.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIFNub3cgPGpzbm93QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IDIwIFNlcHRlbWJlciAyMDE5IDIyOjExDQo+IFRvOiBQYXVsIER1
cnJhbnQgPFBhdWwuRHVycmFudEBjaXRyaXguY29tPjsgeGVuLWRldmVsQGxpc3RzLnhlbnByb2pl
Y3Qub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHFlbXUtYmxvY2tAbm9uZ251Lm9yZw0K
PiBDYzogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT47IFN0ZWZhbm8gU3RhYmVsbGluaSA8
c3N0YWJlbGxpbmlAa2VybmVsLm9yZz47IE1heCBSZWl0eg0KPiA8bXJlaXR6QHJlZGhhdC5jb20+
OyBBbnRob255IFBlcmFyZCA8YW50aG9ueS5wZXJhcmRAY2l0cml4LmNvbT47IE1hcmsgU3ltcyA8
TWFyay5TeW1zQGNpdHJpeC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1ibG9ja10gW1BBVENI
XSB4ZW4tYmxvY2s6IHRyZWF0IFhlbmJ1c1N0YXRlVW5rbm93biB0aGUgc2FtZSBhcyBYZW5idXNT
dGF0ZUNsb3NlZA0KPiANCj4gDQo+IA0KPiBPbiA5LzE4LzE5IDc6NTcgQU0sIFBhdWwgRHVycmFu
dCB3cm90ZToNCj4gPiBXaGVuIGEgZnJvbnRlbmQgZ3JhY2VmdWxseSBkaXNjb25uZWN0cyBmcm9t
IGFuIG9mZmxpbmUgYmFja2VuZCwgaXQgd2lsbA0KPiA+IHNldCBpdHMgb3duIHN0YXRlIHRvIFhl
bmJ1c1N0YXRlQ2xvc2VkLiBUaGUgY29kZSBpbiB4ZW4tYmxvY2suYyBjb3JyZWN0bHkNCj4gPiBk
ZWFscyB3aXRoIHRoaXMgYW5kIHNldHMgdGhlIGJhY2tlbmQgaW50byBYZW5idXNTdGF0ZUNsb3Nl
ZC4gVW5mb3J0dW5hdGVseQ0KPiA+IGl0IGlzIHBvc3NpYmxlIGZvciB0b29sc3RhY2sgdG8gYWN0
dWFsbHkgZGVsZXRlIHRoZSBmcm9udGVuZCBhcmVhDQo+ID4gYmVmb3JlIHRoZSBzdGF0ZSBrZXkg
aGFzIGJlZW4gcmVhZCwgbGVhZGluZyB0byBhbiBhcHBhcmVudCBmcm9udGVuZCBzdGF0ZQ0KPiA+
IG9mIFhlbmJ1c1N0YXRlVW5rbm93bi4gVGhpcyBwcmV2ZW50cyB0aGUgYmFja2VuZCBzdGF0ZSBm
cm9tIHRyYW5zaXRpb25pbmcNCj4gPiB0byBYZW5idXNTdGF0ZUNsb3NlZCBhbmQgaGVuY2UgbGVh
dmVzIGl0IGxpbWJvLg0KPiA+DQo+IA0KPiBEb2VzIHRoZSAwIGNvbWUgZnJvbSBhIHJlYWQgaW50
byBkZS1hbGxvY2F0ZWQgbWVtb3J5Pw0KDQpObywgaXQgY29tZXMgZnJvbSB0aGUgZmFjdCB0aGF0
IHRoZSB4ZW5zdG9yZSBzdGF0ZSBrZXkgaXMgbm90IHByZXNlbnQuIENvbnZlbnRpb25hbGx5IGEg
bWlzc2luZyBzdGF0ZSBrZXkgbWVhbnMgdGhlIHN0YXRlIGlzIHJlcG9ydGVkIGFzIFhlbmJ1c1N0
YXRlVW5rbm93bi4NCg0KICBQYXVsDQoNCj4gDQo+IC0tanMNCj4gDQo+ID4gVGhpcyBwYXRjaCBz
aW1wbHkgdHJlYXRzIGEgZnJvbnRlbmQgc3RhdGUgb2YgWGVuYnVzU3RhdGVVbmtub3duIHRoZSBz
YW1lDQo+ID4gYXMgWGVuYnVzU3RhdGVDbG9zZWQsIHdoaWNoIHdpbGwgdW5ibG9jayB0aGUgYmFj
a2VuZCBpbiB0aGVzZSBjaXJjdW1zdGFuY2VzLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IE1hcmsg
U3ltcyA8bWFyay5zeW1zQGNpdHJpeC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGF1bCBEdXJy
YW50IDxwYXVsLmR1cnJhbnRAY2l0cml4LmNvbT4NCj4gPiAtLS0NCj4gPiBDYzogU3RlZmFubyBT
dGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPg0KPiA+IENjOiBBbnRob255IFBlcmFy
ZCA8YW50aG9ueS5wZXJhcmRAY2l0cml4LmNvbT4NCj4gPiBDYzogS2V2aW4gV29sZiA8a3dvbGZA
cmVkaGF0LmNvbT4NCj4gPiBDYzogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gPiAt
LS0NCj4gPiAgaHcvYmxvY2sveGVuLWJsb2NrLmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYmxvY2sveGVuLWJsb2Nr
LmMgYi9ody9ibG9jay94ZW4tYmxvY2suYw0KPiA+IGluZGV4IGY3NzM0M2RiNjAuLjg3OWZjMzEw
YTQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYmxvY2sveGVuLWJsb2NrLmMNCj4gPiArKysgYi9ody9i
bG9jay94ZW4tYmxvY2suYw0KPiA+IEBAIC0zMTMsNiArMzEzLDcgQEAgc3RhdGljIHZvaWQgeGVu
X2Jsb2NrX2Zyb250ZW5kX2NoYW5nZWQoWGVuRGV2aWNlICp4ZW5kZXYsDQo+ID4gICAgICAgICAg
YnJlYWs7DQo+ID4NCj4gPiAgICAgIGNhc2UgWGVuYnVzU3RhdGVDbG9zZWQ6DQo+ID4gKyAgICBj
YXNlIFhlbmJ1c1N0YXRlVW5rbm93bjoNCj4gPiAgICAgICAgICB4ZW5fYmxvY2tfZGlzY29ubmVj
dCh4ZW5kZXYsICZsb2NhbF9lcnIpOw0KPiA+ICAgICAgICAgIGlmIChsb2NhbF9lcnIpIHsNCj4g
PiAgICAgICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+ID4NCg==

