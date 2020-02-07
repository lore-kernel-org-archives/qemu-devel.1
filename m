Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE52C2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3205D2082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 06:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3205D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izxL6-0008Dv-AP
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 01:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1izxKB-0007YG-Hu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1izxK9-00055T-Pf
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:41:10 -0500
Received: from gecko.sbs.de ([194.138.37.40]:60389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1izxK9-0004uJ-Da
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 01:41:09 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0176f5aW027202
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Feb 2020 07:41:05 +0100
Received: from [167.87.42.193] ([167.87.42.193])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0176f4SE026935;
 Fri, 7 Feb 2020 07:41:04 +0100
Subject: Re: [PATCH] apic: Report current_count via 'info lapic'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <f6c36298-5e63-f4c6-654c-3b16010ae6da@siemens.com>
 <3d05c5a8-34fb-3309-ebba-14d187813756@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7684f66e-8dad-3b28-1078-a7a5cb578bd8@siemens.com>
Date: Fri, 7 Feb 2020 07:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3d05c5a8-34fb-3309-ebba-14d187813756@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by gecko.sbs.de id 0176f5aW027202
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.138.37.40
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMDYuMDIuMjAgMjM6MzYsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBP
biAyLzYvMjAgODo1MCBQTSwgSmFuIEtpc3prYSB3cm90ZToNCj4+IEZyb206IEphbiBLaXN6
a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+Pg0KPj4gVGhpcyBpcyBoZWxwZnVsIHdo
ZW4gZGVidWdnaW5nIHN0dWNrIGd1ZXN0IHRpbWVycy4NCj4+DQo+PiBBcyB3ZSBuZWVkIGFw
aWNfZ2V0X2N1cnJlbnRfY291bnQgZm9yIHRoYXQsIGFuZCBpdCBpcyByZWFsbHkgbm90DQo+
PiBlbXVsYXRpb24gc3BlY2lmaWMsIG1vdmUgaXQgdG8gYXBpY19jb21tb24uYyBhbmQgZXhw
b3J0IGl0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6a2FA
c2llbWVucy5jb20+DQo+PiAtLS0NCj4+IMKgIGh3L2ludGMvYXBpYy5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE4IC0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gwqAg
aHcvaW50Yy9hcGljX2NvbW1vbi5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOCArKysrKysr
KysrKysrKysrKysNCj4+IMKgIGluY2x1ZGUvaHcvaTM4Ni9hcGljX2ludGVybmFsLmggfMKg
IDEgKw0KPj4gwqAgdGFyZ2V0L2kzODYvaGVscGVyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA1ICsrKy0tDQo+PiDCoCA0IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyks
IDIwIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pbnRjL2FwaWMuYyBi
L2h3L2ludGMvYXBpYy5jDQo+PiBpbmRleCBiZDQwNDY3OTY1Li5mMjIwN2QwYWNlIDEwMDY0
NA0KPj4gLS0tIGEvaHcvaW50Yy9hcGljLmMNCj4+ICsrKyBiL2h3L2ludGMvYXBpYy5jDQo+
PiBAQCAtNjE1LDI0ICs2MTUsNiBAQCBpbnQgYXBpY19hY2NlcHRfcGljX2ludHIoRGV2aWNl
U3RhdGUgKmRldikNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+PiDCoCB9DQo+PiDCoCAt
c3RhdGljIHVpbnQzMl90IGFwaWNfZ2V0X2N1cnJlbnRfY291bnQoQVBJQ0NvbW1vblN0YXRl
ICpzKQ0KPj4gLXsNCj4+IC3CoMKgwqAgaW50NjRfdCBkOw0KPj4gLcKgwqDCoCB1aW50MzJf
dCB2YWw7DQo+PiAtwqDCoMKgIGQgPSAocWVtdV9jbG9ja19nZXRfbnMoUUVNVV9DTE9DS19W
SVJUVUFMKSAtDQo+PiBzLT5pbml0aWFsX2NvdW50X2xvYWRfdGltZSkgPj4NCj4+IC3CoMKg
wqDCoMKgwqDCoCBzLT5jb3VudF9zaGlmdDsNCj4+IC3CoMKgwqAgaWYgKHMtPmx2dFtBUElD
X0xWVF9USU1FUl0gJiBBUElDX0xWVF9USU1FUl9QRVJJT0RJQykgew0KPj4gLcKgwqDCoMKg
wqDCoMKgIC8qIHBlcmlvZGljICovDQo+PiAtwqDCoMKgwqDCoMKgwqAgdmFsID0gcy0+aW5p
dGlhbF9jb3VudCAtIChkICUgKCh1aW50NjRfdClzLT5pbml0aWFsX2NvdW50ICsgMSkpOw0K
Pj4gLcKgwqDCoCB9IGVsc2Ugew0KPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChkID49IHMtPmlu
aXRpYWxfY291bnQpDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWwgPSAwOw0KPj4g
LcKgwqDCoMKgwqDCoMKgIGVsc2UNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCA9
IHMtPmluaXRpYWxfY291bnQgLSBkOw0KPj4gLcKgwqDCoCB9DQo+PiAtwqDCoMKgIHJldHVy
biB2YWw7DQo+PiAtfQ0KPj4gLQ0KPj4gwqAgc3RhdGljIHZvaWQgYXBpY190aW1lcl91cGRh
dGUoQVBJQ0NvbW1vblN0YXRlICpzLCBpbnQ2NF90IGN1cnJlbnRfdGltZSkNCj4+IMKgIHsN
Cj4+IMKgwqDCoMKgwqAgaWYgKGFwaWNfbmV4dF90aW1lcihzLCBjdXJyZW50X3RpbWUpKSB7
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaW50Yy9hcGljX2NvbW1vbi5jIGIvaHcvaW50Yy9hcGlj
X2NvbW1vbi5jDQo+PiBpbmRleCA5ZWMwZjJkZWIyLi42ZjRlODc3ODc4IDEwMDY0NA0KPj4g
LS0tIGEvaHcvaW50Yy9hcGljX2NvbW1vbi5jDQo+PiArKysgYi9ody9pbnRjL2FwaWNfY29t
bW9uLmMNCj4+IEBAIC0xODksNiArMTg5LDI0IEBAIGJvb2wgYXBpY19uZXh0X3RpbWVyKEFQ
SUNDb21tb25TdGF0ZSAqcywgaW50NjRfdA0KPj4gY3VycmVudF90aW1lKQ0KPj4gwqDCoMKg
wqDCoCByZXR1cm4gdHJ1ZTsNCj4+IMKgIH0NCj4+IMKgICt1aW50MzJfdCBhcGljX2dldF9j
dXJyZW50X2NvdW50KEFQSUNDb21tb25TdGF0ZSAqcykNCj4+ICt7DQo+PiArwqDCoMKgIGlu
dDY0X3QgZDsNCj4+ICvCoMKgwqAgdWludDMyX3QgdmFsOw0KPj4gK8KgwqDCoCBkID0gKHFl
bXVfY2xvY2tfZ2V0X25zKFFFTVVfQ0xPQ0tfVklSVFVBTCkgLQ0KPj4gcy0+aW5pdGlhbF9j
b3VudF9sb2FkX3RpbWUpID4+DQo+PiArwqDCoMKgwqDCoMKgwqAgcy0+Y291bnRfc2hpZnQ7
DQo+PiArwqDCoMKgIGlmIChzLT5sdnRbQVBJQ19MVlRfVElNRVJdICYgQVBJQ19MVlRfVElN
RVJfUEVSSU9ESUMpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBwZXJpb2RpYyAqLw0KPj4g
K8KgwqDCoMKgwqDCoMKgIHZhbCA9IHMtPmluaXRpYWxfY291bnQgLSAoZCAlICgodWludDY0
X3Qpcy0+aW5pdGlhbF9jb3VudCArIDEpKTsNCj4+ICvCoMKgwqAgfSBlbHNlIHsNCj4+ICvC
oMKgwqDCoMKgwqDCoCBpZiAoZCA+PSBzLT5pbml0aWFsX2NvdW50KQ0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdmFsID0gMDsNCj4+ICvCoMKgwqDCoMKgwqDCoCBlbHNlDQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWwgPSBzLT5pbml0aWFsX2NvdW50IC0gZDsNCj4g
DQo+IFVzaW5nIFFFTVUgc3R5bGUgaWYgKCkge30gZWxzZSB7fToNCg0KWWVhaCwgdGhhdCBo
YXBwZW5zIHdoZW4geW91IG1vdmUgb2xkIGNvZGUgLSB3aWxsIGFkZHJlc3MuDQoNCj4gUmV2
aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4N
Cg0KVGhhbmtzLA0KSmFuDQoNCi0tIA0KU2llbWVucyBBRywgQ29ycG9yYXRlIFRlY2hub2xv
Z3ksIENUIFJEQSBJT1QgU0VTLURFDQpDb3Jwb3JhdGUgQ29tcGV0ZW5jZSBDZW50ZXIgRW1i
ZWRkZWQgTGludXgNCg==

