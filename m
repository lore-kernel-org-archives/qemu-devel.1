Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B14EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7415220866
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 12:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7415220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYrrA-0004jO-Pw
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 08:51:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Georg.Hofstetter@efs-auto.de>) id 1hYqoq-0004rA-GO
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Georg.Hofstetter@efs-auto.de>) id 1hYqoo-0005ud-Hg
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:44:32 -0400
Received: from mailin3.audi.de ([143.164.102.17]:53801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Georg.Hofstetter@efs-auto.de>)
	id 1hYqol-0005d0-9w
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:44:29 -0400
From: "Hofstetter, Georg (EFS-GH2)" <Georg.Hofstetter@efs-auto.de>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 5/5] tricore: reset DisasContext before
	generating code
Thread-Index: AQHVG2WPDZN0Ee3vBE+d7NmN2Cr7ZKaMokeAgAHUenA=
Date: Thu, 6 Jun 2019 11:44:11 +0000
Message-ID: <69A9BBE82CEA98469F7BA51850C5B89CDC412063@AUDIINSX0364.audi.vwg>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
	<20190605061126.10244-6-david.brenken@efs-auto.org>
	<aaf05b6e-fb2b-1aa8-da49-b6ce29616073@mail.uni-paderborn.de>
In-Reply-To: <aaf05b6e-fb2b-1aa8-da49-b6ce29616073@mail.uni-paderborn.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.134.55]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 143.164.102.17
X-Mailman-Approved-At: Thu, 06 Jun 2019 08:47:51 -0400
Subject: Re: [Qemu-devel] [PATCH 5/5] tricore: reset DisasContext before
 generating code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgU2ViYXN0aWFuLA0KDQppbiB0cmFuc2xhdGUuYzpnZW5fbXRjcigpIGNvZGUgYWNjZXNzZXMg
aGZsYWdzIHdpdGhpbiB0aGUgc3RydWN0dXJlOg0KICAgIGlmICgoY3R4LT5oZmxhZ3MgJiBUUklD
T1JFX0hGTEFHX0tVVSkgPT0gVFJJQ09SRV9IRkxBR19TTSkgew0KICAgICAgICAvKiBzaW5jZSB3
ZSdyZSBjYWNoaW5nIFBTVyBtYWtlIHRoaXMgYSBzcGVjaWFsIGNhc2UgKi8NCg0KVGhlIGNvZGUg
ZXhwZWN0cyB0aGUgSEZMQUcgc2V0IGZvciBrZXJuZWwgbW9kZSBpbiAoaSBndWVzcykgcHJlcGFy
YXRpb24gZm9yIHN1cHBvcnRpbmcgb3BlcmF0aW9uIG1vZGVzLg0KVGhlcmUgaXMgbm8gY29kZSBt
b2RpZnlpbmcgdGhlc2UgZmxhZ3MuDQpUaGUgZmxhZ3Mgd2VyZSBpbnRyb2R1Y2VkIGluIDBhYWVi
MTEgYW5kIHRoZXJlIGl0IGxvb2tzIGxpa2UgaXQgd2FzIGV4cGVjdGVkIHRvIGJlIHplcm9lZCAt
IG1heWJlIHlvdSBrbm93IGEgYml0IG1vcmUuDQoNCkFzIGhhdmluZyBhIHN0YWNrIHZhcmlhYmxl
IHVuaW5pdGlhbGl6ZWQgaXMgZ2VuZXJhbGx5IGEgYmFkIGlkZWEsIHNvIG15IHByb3Bvc2FsIHdh
cyB0byB6ZXJvIGl0IGFzIGEgd2hvbGUsIGFzIGl0IHdvdWxkIGJlIGZvciBic3MgdmFyaWFibGVz
Lg0KQWx0ZXJuYXRpdmVseSB3ZSBjb3VsZCBpbml0aWFsaXplIHRoZW0gZXhwbGljaXRseSB0byB6
ZXJvIG9yIFRSSUNPUkVfSEZMQUdfU00uDQoNCiAgICBjdHguaGZsYWdzID0gVFJJQ09SRV9IRkxB
R19TTTsNCg0KTm90IHN1cmUgdGhvdWdoIHdoeSBhIGNwdSBzdGF0ZSBmbGFnIGlzIHdpdGhpbiBE
aXNhc0NvbnRleHQuDQoNClJlZ2FyZHMsDQpHZW9yZw0KDQoNCi0tLS0tVXJzcHLDvG5nbGljaGUg
TmFjaHJpY2h0LS0tLS0NClZvbjogQmFzdGlhbiBLb3BwZWxtYW5uIDxrYmFzdGlhbkBtYWlsLnVu
aS1wYWRlcmJvcm4uZGU+IA0KR2VzZW5kZXQ6IE1pdHR3b2NoLCA1LiBKdW5pIDIwMTkgMTE6MDIN
CkFuOiBEYXZpZCBCcmVua2VuIDxkYXZpZC5icmVua2VuQGVmcy1hdXRvLm9yZz47IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZw0KQ2M6IEJpZXJtYW5za2ksIExhcnMgKEVGUy1HSDMpIDxsYXJzLmJpZXJt
YW5za2lAZWZzLWF1dG8uZGU+OyBIb2ZzdGV0dGVyLCBHZW9yZyAoRUZTLUdIMikgPEdlb3JnLkhv
ZnN0ZXR0ZXJAZWZzLWF1dG8uZGU+OyBCcmVua2VuLCBEYXZpZCAoRUZTLUdIMikgPGRhdmlkLmJy
ZW5rZW5AZWZzLWF1dG8uZGU+OyBSYXNjaGUsIFJvYmVydCAoRUZTLUdIMikgPHJvYmVydC5yYXNj
aGVAZWZzLWF1dG8uZGU+OyBLb25vcGlrLCBBbmRyZWFzIChFRlMtR0gyKSA8YW5kcmVhcy5rb25v
cGlrQGVmcy1hdXRvLmRlPg0KQmV0cmVmZjogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0ggNS81XSB0
cmljb3JlOiByZXNldCBEaXNhc0NvbnRleHQgYmVmb3JlIGdlbmVyYXRpbmcgY29kZQ0KDQpIaSwN
Cg0KT24gNi81LzE5IDg6MTEgQU0sIERhdmlkIEJyZW5rZW4gd3JvdGU6DQo+IEZyb206IEdlb3Jn
IEhvZnN0ZXR0ZXIgPGdlb3JnLmhvZnN0ZXR0ZXJAZWZzLWF1dG8uZGU+DQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJlYXMgS29ub3BpayA8YW5kcmVhcy5rb25vcGlrQGVmcy1hdXRvLmRlPg0KPiBT
aWduZWQtb2ZmLWJ5OiBEYXZpZCBCcmVua2VuIDxkYXZpZC5icmVua2VuQGVmcy1hdXRvLmRlPg0K
PiBTaWduZWQtb2ZmLWJ5OiBHZW9yZyBIb2ZzdGV0dGVyIDxnZW9yZy5ob2ZzdGV0dGVyQGVmcy1h
dXRvLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgUmFzY2hlIDxyb2JlcnQucmFzY2hlQGVm
cy1hdXRvLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBMYXJzIEJpZXJtYW5za2kgPGxhcnMuYmllcm1h
bnNraUBlZnMtYXV0by5kZT4NCj4NCj4gLS0tDQo+ICAgdGFyZ2V0L3RyaWNvcmUvdHJhbnNsYXRl
LmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAt
LWdpdCBhL3RhcmdldC90cmljb3JlL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L3RyaWNvcmUvdHJhbnNs
YXRlLmMgDQo+IGluZGV4IGRiMDlmODJjMzEuLmNkYmMwMGQ2NTQgMTAwNjQ0DQo+IC0tLSBhL3Rh
cmdldC90cmljb3JlL3RyYW5zbGF0ZS5jDQo+ICsrKyBiL3RhcmdldC90cmljb3JlL3RyYW5zbGF0
ZS5jDQo+IEBAIC04ODExLDYgKzg4MTEsNyBAQCB2b2lkIGdlbl9pbnRlcm1lZGlhdGVfY29kZShD
UFVTdGF0ZSAqY3MsIFRyYW5zbGF0aW9uQmxvY2sgKnRiLCBpbnQgbWF4X2luc25zKQ0KPiAgICAg
ICB0YXJnZXRfdWxvbmcgcGNfc3RhcnQ7DQo+ICAgICAgIGludCBudW1faW5zbnMgPSAwOw0KPiAg
IA0KPiArICAgIG1lbXNldCgmY3R4LCAweDAwLCBzaXplb2YoRGlzYXNDb250ZXh0KSk7DQo+ICAg
ICAgIHBjX3N0YXJ0ID0gdGItPnBjOw0KPiAgICAgICBjdHgucGMgPSBwY19zdGFydDsNCj4gICAg
ICAgY3R4LnNhdmVkX3BjID0gLTE7DQoNClRvIG1lIHRoaXMgbG9va3MgbGlrZSBmaXhpbmcgYSBz
eW1wdG9tIGluc3RlYWQgb2YgdGhlIHJvb3QgY2F1c2UuIFdoaWNoIGNvbW1pdCBkaWQgeW91IGJp
c2VjdCB0bz8gRG8geW91IGhhdmUgYSByZXByb2R1Y2VyPw0KDQpDaGVlcnMsDQoNCkJhc3RpYW4N
Cg0K

