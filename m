Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8055C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F366206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLnZdFvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F366206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuhD-0006Di-Cx
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1juugd-0005fy-5b
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:23:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1juugb-0005lY-FH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594632224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhledgnKx98onXVEvaBzvvm95m6jDRMwdvuBipA5h+o=;
 b=DLnZdFvkLSsyEr/sxpkNJfY3O9t0whbuxVrVNXZtMpM5/bPd2SZpRL6mSTQ+MaWJS0nLmD
 WfiYfjgflYQYP4ML/7XuOKX/YKAsPgxNUwwOyj2CkrP5JNBHINGf2VTW+QQwAhIlaCHh7M
 8xjRrSAbOWaw+pSUXR9key1GxStqg2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-v6FDOFAcNVyCjYi6GzFKwQ-1; Mon, 13 Jul 2020 05:23:43 -0400
X-MC-Unique: v6FDOFAcNVyCjYi6GzFKwQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 057F51081;
 Mon, 13 Jul 2020 09:23:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF54D6FEDF;
 Mon, 13 Jul 2020 09:23:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39B5B11384A6; Mon, 13 Jul 2020 11:23:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [RFC PATCH 2/3] hw/i2c/smbus_eeprom: Add description based on
 child name
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-3-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006261255120.94870@zero.eik.bme.hu>
 <5895e827-68e9-8204-aeba-e066d8c0d680@amsat.org>
 <20200709194822.GJ780932@habkost.net>
 <d5cab3f9-7685-a705-3414-838cf0b2c49c@amsat.org>
 <20200710174054.GS780932@habkost.net>
Date: Mon, 13 Jul 2020 11:23:32 +0200
In-Reply-To: <20200710174054.GS780932@habkost.net> (Eduardo Habkost's message
 of "Fri, 10 Jul 2020 13:40:54 -0400")
Message-ID: <875zarg44r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 =?utf-8?Q?C?= =?utf-8?Q?=C3=A9dric?= Le Goater <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPiB3cml0ZXM6DQoNCj4gT24gRnJp
LCBKdWwgMTAsIDIwMjAgYXQgMTE6MDU6MjlBTSArMDIwMCwgUGhpbGlwcGUgTWF0aGlldS1EYXVk
w4PGksOCwqkgd3JvdGU6DQo+PiArU3RlZmFuIGZvciB0cmFjaW5nIFBvVg0KPj4gDQo+PiBPbiA3
LzkvMjAgOTo0OCBQTSwgRWR1YXJkbyBIYWJrb3N0IHdyb3RlOg0KPj4gPiBPbiBGcmksIEp1biAy
NiwgMjAyMCBhdCAwNDoyNjozM1BNICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDg8aSw4bi
gJnDg+KAmsOCwqkgd3JvdGU6DQo+PiA+PiBPbiA2LzI2LzIwIDE6MDAgUE0sIEJBTEFUT04gWm9s
dGFuIHdyb3RlOg0KPj4gPj4+IE9uIEZyaSwgMjYgSnVuIDIwMjAsIFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMODxpLDhuKAmcOD4oCaw4LCqSB3cm90ZToNCj4+ID4+Pj4gU3VnZ2VzdGVkLWJ5OiBNYXJr
dXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+PiA+Pj4+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMODxpLDhuKAmcOD4oCaw4LCqSA8ZjRidWdAYW1zYXQub3Jn
Pg0KPj4gPj4+PiAtLS0NCj4+ID4+Pj4gaHcvaTJjL3NtYnVzX2VlcHJvbS5jIHwgMyArKysNCj4+
ID4+Pj4gMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4gPj4+Pg0KPj4gPj4+PiBk
aWZmIC0tZ2l0IGEvaHcvaTJjL3NtYnVzX2VlcHJvbS5jIGIvaHcvaTJjL3NtYnVzX2VlcHJvbS5j
DQo+PiA+Pj4+IGluZGV4IDg3OWZkN2M0MTYuLjIyYmE3YjIwZDQgMTAwNjQ0DQo+PiA+Pj4+IC0t
LSBhL2h3L2kyYy9zbWJ1c19lZXByb20uYw0KPj4gPj4+PiArKysgYi9ody9pMmMvc21idXNfZWVw
cm9tLmMNCj4+ID4+Pj4gQEAgLTQ3LDYgKzQ3LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgU01CdXNFRVBS
T01EZXZpY2Ugew0KPj4gPj4+PiDDg8aSw6LigqzFocOD4oCaw4LCoMODxpLDouKCrMWhw4PigJrD
gsKgw4PGksOi4oKsxaHDg+KAmsOCwqAgdWludDhfdCAqaW5pdF9kYXRhOw0KPj4gPj4+PiDDg8aS
w6LigqzFocOD4oCaw4LCoMODxpLDouKCrMWhw4PigJrDgsKgw4PGksOi4oKsxaHDg+KAmsOCwqAg
dWludDhfdCBvZmZzZXQ7DQo+PiA+Pj4+IMODxpLDouKCrMWhw4PigJrDgsKgw4PGksOi4oKsxaHD
g+KAmsOCwqDDg8aSw6LigqzFocOD4oCaw4LCoCBib29sIGFjY2Vzc2VkOw0KPj4gPj4+PiArw4PG
ksOi4oKsxaHDg+KAmsOCwqDDg8aSw6LigqzFocOD4oCaw4LCoMODxpLDouKCrMWhw4PigJrDgsKg
IGNoYXIgKmRlc2NyaXB0aW9uOw0KPj4gPj4+PiB9IFNNQnVzRUVQUk9NRGV2aWNlOw0KPj4gPj4+
Pg0KPj4gPj4+PiBzdGF0aWMgdWludDhfdCBlZXByb21fcmVjZWl2ZV9ieXRlKFNNQnVzRGV2aWNl
ICpkZXYpDQo+PiA+Pj4+IEBAIC0xMzQsNyArMTM1LDkgQEAgc3RhdGljIHZvaWQgc21idXNfZWVw
cm9tX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj4+ID4+Pj4gRXJyb3IgKiplcnJwKQ0KPj4g
Pj4+PiDDg8aSw6LigqzFocOD4oCaw4LCoMODxpLDouKCrMWhw4PigJrDgsKgw4PGksOi4oKsxaHD
g+KAmsOCwqAgc21idXNfZWVwcm9tX3Jlc2V0KGRldik7DQo+PiA+Pj4+IMODxpLDouKCrMWhw4Pi
gJrDgsKgw4PGksOi4oKsxaHDg+KAmsOCwqDDg8aSw6LigqzFocOD4oCaw4LCoCBpZiAoZWVwcm9t
LT5pbml0X2RhdGEgPT0gTlVMTCkgew0KPj4gPj4+PiDDg8aSw6LigqzFocOD4oCaw4LCoMODxpLD
ouKCrMWhw4PigJrDgsKgw4PGksOi4oKsxaHDg+KAmsOCwqDDg8aSw6LigqzFocOD4oCaw4LCoMOD
xpLDouKCrMWhw4PigJrDgsKgw4PGksOi4oKsxaHDg+KAmsOCwqDDg8aSw6LigqzFocOD4oCaw4LC
oCBlcnJvcl9zZXRnKGVycnAsICJpbml0X2RhdGEgY2Fubm90IGJlIE5VTEwiKTsNCj4+ID4+Pj4g
K8ODxpLDouKCrMWhw4PigJrDgsKgw4PGksOi4oKsxaHDg+KAmsOCwqDDg8aSw6LigqzFocOD4oCa
w4LCoMODxpLDouKCrMWhw4PigJrDgsKgw4PGksOi4oKsxaHDg+KAmsOCwqDDg8aSw6LigqzFocOD
4oCaw4LCoMODxpLDouKCrMWhw4PigJrDgsKgIHJldHVybjsNCj4+ID4+Pj4gw4PGksOi4oKsxaHD
g+KAmsOCwqDDg8aSw6LigqzFocOD4oCaw4LCoMODxpLDouKCrMWhw4PigJrDgsKgIH0NCj4+ID4+
Pj4gK8ODxpLDouKCrMWhw4PigJrDgsKgw4PGksOi4oKsxaHDg+KAmsOCwqDDg8aSw6LigqzFocOD
4oCaw4LCoCBlZXByb20tPmRlc2NyaXB0aW9uID0NCj4+ID4+Pj4gb2JqZWN0X2dldF9jYW5vbmlj
YWxfcGF0aF9jb21wb25lbnQoT0JKRUNUKGRldikpOw0KPj4gPj4+PiB9DQo+PiA+Pj4+DQo+PiA+
Pj4+IHN0YXRpYyB2b2lkIHNtYnVzX2VlcHJvbV9jbGFzc19pbml0Zm4oT2JqZWN0Q2xhc3MgKmts
YXNzLCB2b2lkICpkYXRhKQ0KPj4gPj4+DQo+PiA+Pj4gV2hhdCBpcyB0aGlzIGZvcj8gU2hvdWxk
bid0IHRoaXMgZGVzY3JpcHRpb24gZmllbGQgYmUgaW4gc29tZSBwYXJlbnQNCj4+ID4+PiBvYmpl
Y3QgYW5kIHdoYXRldmVyIHdhbnRzIHRvIHByaW50IGl0IGNvdWxkIHVzZSB0aGUNCj4+ID4+PiBv
YmplY3RfZ2V0X2Nhbm9uaWNhbF9wYXRoX2NvbXBvbmVudCgpIGFzIGRlZmF1bHQgdmFsdWUgaWYg
aXQncyBub3Qgc2V0DQo+PiA+Pj4gaW5zdGVhZCBvZiBhZGRpbmcgbW9yZSBib2lsZXIgcGxhdGUg
dG8gZXZlcnkgb2JqZWN0Pw0KPj4gPj4NCj4+ID4+IFlvdSBhcmUgcmlnaHQsIGlmIHdlIHdhbnQg
dG8gdXNlIHRoaXMgZmllbGQgZ2VuZXJpY2FsbHksIGl0IHNob3VsZCBiZQ0KPj4gPj4gYSBzdGF0
aWMgT2JqZWN0IGZpZWxkLiBJJ2xsIGRlZmVyIHRoYXQgcXVlc3Rpb24gdG8gRWR1YXJkby9NYXJr
dXMuDQo+PiA+IA0KPj4gPiBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCdzIHRoZSBxdWVzdGlvbiBo
ZXJlLiAgV2hhdCB3b3VsZCBiZSB0aGUNCj4+ID4gcHVycG9zZSBvZiBhIHN0YXRpYyBPYmplY3Qg
ZmllbGQsIGFuZCB3aHkgaXQgd291bGQgYmUgYmV0dGVyIHRoYW4NCj4+ID4gc2ltcGx5IGNhbGxp
bmcgb2JqZWN0X2dldF9jYW5vbmljYWxfcGF0aF9jb21wb25lbnQoKSB3aGVuIHlvdQ0KPj4gPiBu
ZWVkIGl0Pw0KPj4gDQo+PiBCZWNhdXNlIHdoZW4gcmVhZGluZyBhIDhLQiBFRVBST00gd2l0aCB0
cmFjaW5nIGVuYWJsZWQgd2UgZW5kDQo+PiB1cCBjYWxsaW5nOg0KPj4gDQo+PiA4MTkyIGdfaGFz
aF90YWJsZV9pdGVyX2luaXQoKQ0KPj4gODE5MiBnX2hhc2hfdGFibGVfaXRlcl9uZXh0KCkNCj4+
IDgxOTIgb2JqZWN0X3Byb3BlcnR5X2l0ZXJfaW5pdCgpDQo+PiA4MTkyIG9iamVjdF9wcm9wZXJ0
eV9pdGVyX25leHQoKQ0KPj4gODE5MiBnX2hhc2hfdGFibGVfYWRkKCkNCj4+IDgxOTIgZ19zdHJk
dXAoKQ0KPj4gODE5MiBnX2ZyZWUoKQ0KPj4gDQo+PiBXaGljaCBpcyB3aHkgSSBhZGRlZCB0aGUg
U01CdXNFRVBST01EZXZpY2VTdGF0ZTo6ZGVzY3JpcHRpb24NCj4+IGZpZWxkLCB0byBjYWxsIGl0
IG9uY2UgYW5kIGNhY2hlIGl0LiBCdXQgWm9sdGFuIHJlYWxpemVkIHRoaXMNCj4+IGNvdWxkIGJl
bmVmaXQgYWxsIFFPTSBvYmplY3RzLCBub3QgdGhpcyBzaW5nbGUgb25lLg0KPj4gDQo+PiBTbyB0
aGUgcXVlc3Rpb24gaXMsIGlzIGl0IE9LIHRvIG1ha2UgdGhpcyBhIGNhY2hlZCBmaWVsZA0KPj4g
aW4gb2JqZWN0X2dldF9jYW5vbmljYWxfcGF0aF9jb21wb25lbnQoKT8NCj4NCj4gVGhhdCdzIHdo
YXQgSSB3YXMgdGhpbmtpbmcgb2YsIGJ1dCBub3cgSSBzZWUgdGhhdA0KPiBvYmplY3RfZ2V0X2Nh
bm9uaWNhbF9wYXRoX2NvbXBvbmVudCgpIGlzIGFuIGluY29udmVuaWVudCBBUEkNCj4gYmVjYXVz
ZSBpdCByZXF1aXJlcyBjYWxsZXJzIHRvIGdfZnJlZSgpIHRoZSByZXR1cm4gdmFsdWUuDQoNCkkg
YWdyZWUuDQoNCj4gV2UgY291bGQgY2hhbmdlIG9iamVjdF9nZXRfY2Fub25pY2FsX3BhdGhfY29t
cG9uZW50KCkgdG8gbm90DQo+IHJlcXVpcmUgY2FsbGVycyB0byBjYWxsIGdfZnJlZSgpLA0KDQpJ
J2xsIGxvb2sgaW50byB0aGF0LiAgSXQgd291bGQgZml4IGEgbWVtb3J5IGxlYWsgSSBjcmVhdGVk
IGJlY2F1c2UgSQ0KZGlkbid0IGV4cGVjdCBvYmplY3RfZ2V0X2Nhbm9uaWNhbF9wYXRoX2NvbXBv
bmVudCgpIHRvIHJldHVybiBhIG1hbGxvY2VkDQpzdHJpbmcuDQoNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG9yIGNyZWF0ZSBhIG5ldyBtZWNoYW5pc20gdG8NCj4gZ2V0IHRo
ZSBvYmplY3QgbmFtZSBsaWtlIHlvdSBzdWdnZXN0ZWQgKGFuZCB0aGVuIGdldCByaWQgb2YgbW9z
dA0KPiBvZiB0aGUgZXhpc3RpbmcgdXNlcyBvZiBvYmplY3RfZ2V0X2Nhbm9uaWNhbF9wYXRoX2Nv
bXBvbmVudCgpKS4NCg0KWy4uLl0NCg==


