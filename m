Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F82C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8092070A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8092070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Vii-00026O-9U
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 08:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bauerchen@tencent.com>) id 1j1ULI-0001ct-Qf
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bauerchen@tencent.com>) id 1j1UL7-0004ys-Po
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:08:31 -0500
Received: from mail6.tencent.com ([220.249.245.26]:41909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bauerchen@tencent.com>)
 id 1j1UL7-0004qQ-0o
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 07:08:29 -0500
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
 by mail6.tencent.com (Postfix) with ESMTP id 5E89BCCA33;
 Tue, 11 Feb 2020 20:08:42 +0800 (CST)
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 11 Feb
 2020 20:08:18 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 11 Feb
 2020 20:08:18 +0800
Received: from EX-SZ005.tencent.com ([fe80::1c8:f876:daf6:e9c0]) by
 EX-SZ005.tencent.com ([fe80::1c8:f876:daf6:e9c0%4]) with mapi id
 15.01.1713.004; Tue, 11 Feb 2020 20:08:18 +0800
From: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Requesting review  about optimizing large guest start up time
Thread-Topic: Requesting review  about optimizing large guest start up time
Thread-Index: AQHV4NMV+rH5F4FwIUiLta/s/6EHWw==
Date: Tue, 11 Feb 2020 12:08:18 +0000
Message-ID: <e9dfa1311de74824983e769ea197c2e6@tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [9.19.161.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.249.245.26
X-Mailman-Approved-At: Tue, 11 Feb 2020 08:34:09 -0500
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
Cc: "pbonzini >" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbSBjODgyYjE1NTQ2NjMxM2ZjZDg1YWMzMzBhNDVhNTczZTYwOGIwZDc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBiYXVlcmNoZW4gPGJhdWVyY2hlbkB0ZW5jZW50LmNvbT4KRGF0
ZTogVHVlLCAxMSBGZWIgMjAyMCAxNzoxMDozNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIE9wdGlt
aXplOiBsYXJnZSBndWVzdCBzdGFydC11cCBpbiBtZW0tcHJlYWxsb2MKTUlNRS1WZXJzaW9uOiAx
LjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PXV0Zi04CkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDhiaXQKCltkZXNjXToKwqAgwqAgTGFyZ2UgbWVtb3J5IFZNIHN0YXJ0cyBz
bG93bHkgd2hlbiB1c2luZyAtbWVtLXByZWFsbG9jLCBhbmQKwqAgwqAgdGhlcmUgYXJlIHNvbWUg
YXJlYXMgdG8gb3B0aW1pemUgaW4gY3VycmVudCBtZXRob2Q7CgrCoCDCoCAx44CBbW1hcCB3aWxs
IGJlIHVzZWQgdG8gYWxsb2MgdGhyZWFkcyBzdGFjayBkdXJpbmcgY3JlYXRlIHBhZ2UKwqAgwqAg
Y2xlYXJpbmcgdGhyZWFkcywgYW5kIGl0IHdpbGwgYXR0ZW1wdCBtbS0+bW1hcF9zZW0gZm9yIHdy
aXRlCsKgIMKgIGxvY2ssIGJ1dCBjbGVhcmluZyB0aHJlYWRzIGhhdmUgaG9sZCByZWFkIGxvY2ss
IHRoaXMgY29tcGV0aXRpb24KwqAgwqAgd2lsbCBjYXVzZSB0aHJlYWRzIGNyZWF0ZWlvbiB2ZXJ5
IHNsb3c7CgrCoCDCoCAy44CBbWV0aG9kcyBvZiBjYWxjdWF0aW5nIHBhZ2VzIGZvciBwZXIgdGhy
ZWFkcyBpcyBub3Qgd2VsbDtpZiB3ZSB1c2UKwqAgwqAgNjQgdGhyZWFkcyB0byBzcGxpdCAxNjAg
aHVnZXBhZ2UsNjMgdGhyZWFkcyBjbGVhciAycGFnZSwxIHRocmVhZArCoCDCoCBjbGVhciAzNCBw
YWdlLHNvIHRoZSBlbnRpcmUgc3BlZWQgaXMgdmVyeSBzbG93OwoKwqAgwqAgdG8gc29sdmUgdGhl
IGZpcnN0IHByb2JsZW0sd2UgYWRkIGEgbXV0ZXggaW4gdGhyZWFkIGZ1bmN0aW9uLGFuZArCoCDC
oCBzdGFydCBhbGwgdGhyZWFkcyB3aGVuIGFsbCB0aHJlYWRzIGZpbmlzaGVkIGNyZWF0ZWlvbjsK
wqAgwqAgYW5kIHRoZSBzZWNvbmQgcHJvYmxlbSwgd2Ugc3ByZWFkIHJlbWFpbmRlciB0byBvdGhl
ciB0aHJlYWRzLGluCsKgIMKgIHNpdHVhdGlvbiB0aGF0IDE2MCBodWdlcGFnZSBhbmQgNjQgdGhy
ZWFkcywgdGhlcmUgYXJlIDMyIHRocmVhZHMKwqAgwqAgY2xlYXIgMyBwYWdlcyxhbmQgMzIgdGhy
ZWFkcyBjbGVhciAyIHBhZ2VzOwpbdGVzdF06CsKgIMKgIDMyMEcgODRjIFZNIHN0YXJ0IHRpbWUg
Y2FuIGJlIHJlZHVjZWQgdG8gMTBzCsKgIMKgIDY4MEcgODRjIFZNIHN0YXJ0IHRpbWUgY2FuIGJl
IHJlZHVjZWQgdG8gMThzCgpTaWduZWQtb2ZmLWJ5OiBiYXVlcmNoZW4gPGJhdWVyY2hlbkB0ZW5j
ZW50LmNvbT4KUmV2aWV3ZWQtYnk6UGFuIFJ1aSA8cnVpcHBhbkB0ZW5jZW50LmNvbT4KUmV2aWV3
ZWQtYnk6SXZhbiBSZW4gPGl2YW5yZW5AdGVuY2VudC5jb20+Ci0tLQrCoHV0aWwvb3NsaWItcG9z
aXguYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCsKg
MSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdXRpbC9vc2xpYi1wb3NpeC5jIGIvdXRpbC9vc2xpYi1wb3NpeC5jCmluZGV4IDVhMjkx
Y2MuLmU5NzM2OWIgMTAwNjQ0Ci0tLSBhL3V0aWwvb3NsaWItcG9zaXguYworKysgYi91dGlsL29z
bGliLXBvc2l4LmMKQEAgLTc2LDYgKzc2LDEwIEBAIHN0YXRpYyBNZW1zZXRUaHJlYWQgKm1lbXNl
dF90aHJlYWQ7CsKgc3RhdGljIGludCBtZW1zZXRfbnVtX3RocmVhZHM7CsKgc3RhdGljIGJvb2wg
bWVtc2V0X3RocmVhZF9mYWlsZWQ7CsKgCitzdGF0aWMgUWVtdU11dGV4IHBhZ2VfbXV0ZXg7Citz
dGF0aWMgUWVtdUNvbmQgcGFnZV9jb25kOworc3RhdGljIHZvbGF0aWxlIGJvb2wgdGhyZWFkX2Ny
ZWF0ZV9mbGFnOworCsKgaW50IHFlbXVfZ2V0X3RocmVhZF9pZCh2b2lkKQrCoHsKwqAjaWYgZGVm
aW5lZChfX2xpbnV4X18pCkBAIC00MDMsNiArNDA3LDE0IEBAIHN0YXRpYyB2b2lkICpkb190b3Vj
aF9wYWdlcyh2b2lkICphcmcpCsKgIMKgIMKgTWVtc2V0VGhyZWFkICptZW1zZXRfYXJncyA9IChN
ZW1zZXRUaHJlYWQgKilhcmc7CsKgIMKgIMKgc2lnc2V0X3Qgc2V0LCBvbGRzZXQ7CsKgCisgwqAg
wqAvKndhaXQgZm9yIGFsbCB0aHJlYWRzIGNyZWF0ZSBmaW5pc2hlZCAqLworIMKgIMKgcWVtdV9t
dXRleF9sb2NrKCZwYWdlX211dGV4KTsKKyDCoCDCoHdoaWxlKCF0aHJlYWRfY3JlYXRlX2ZsYWcp
eworIMKgIMKgIMKgIMKgcWVtdV9jb25kX3dhaXQoJnBhZ2VfY29uZCwgJnBhZ2VfbXV0ZXgpOwor
IMKgIMKgfQorIMKgIMKgcWVtdV9tdXRleF91bmxvY2soJnBhZ2VfbXV0ZXgpOworCisKwqAgwqAg
wqAvKiB1bmJsb2NrIFNJR0JVUyAqLwrCoCDCoCDCoHNpZ2VtcHR5c2V0KCZzZXQpOwrCoCDCoCDC
oHNpZ2FkZHNldCgmc2V0LCBTSUdCVVMpOwpAQCAtNDQ4LDMwICs0NjAsNDYgQEAgc3RhdGljIGlu
bGluZSBpbnQgZ2V0X21lbXNldF9udW1fdGhyZWFkcyhpbnQgc21wX2NwdXMpCsKgIMKgIMKgcmV0
dXJuIHJldDsKwqB9CsKgCitzdGF0aWMgdm9pZCBjYWxjX3BhZ2VfcGVyX3RocmVhZChzaXplX3Qg
bnVtcGFnZXMsIGludCBtZW1zZXRfdGhyZWFkcywgc2l6ZV90ICpwYWdlc19wZXJfdGhyZWFkKXsK
KyDCoCDCoGludCBhdmcgPSBudW1wYWdlcyAvIG1lbXNldF90aHJlYWRzICsgMTsKKyDCoCDCoGlu
dCBpID0gMDsKKyDCoCDCoGludCBsYXN0ID0gYXZnICogbWVtc2V0X3RocmVhZHMgLSBudW1wYWdl
czsKKyDCoCDCoGZvciAoaSA9IDA7IGkgPCBtZW1zZXRfdGhyZWFkczsgaSsrKQorIMKgIMKgewor
IMKgIMKgIMKgIMKgaWYobWVtc2V0X3RocmVhZHMgLSBpIDw9IGxhc3QpeworIMKgIMKgIMKgIMKg
IMKgIMKgcGFnZXNfcGVyX3RocmVhZFtpXSA9IGF2ZyAtIDE7CisgwqAgwqAgwqAgwqB9ZWxzZQor
IMKgIMKgIMKgIMKgIMKgIMKgcGFnZXNfcGVyX3RocmVhZFtpXSA9IGF2ZzsKKyDCoCDCoH0KK30K
KwrCoHN0YXRpYyBib29sIHRvdWNoX2FsbF9wYWdlcyhjaGFyICphcmVhLCBzaXplX3QgaHBhZ2Vz
aXplLCBzaXplX3QgbnVtcGFnZXMsCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaW50IHNtcF9jcHVzKQrCoHsKLSDCoCDCoHNpemVfdCBudW1wYWdlc19wZXJfdGhy
ZWFkOwotIMKgIMKgc2l6ZV90IHNpemVfcGVyX3RocmVhZDsKKyDCoCDCoHNpemVfdCAqbnVtcGFn
ZXNfcGVyX3RocmVhZDsKwqAgwqAgwqBjaGFyICphZGRyID0gYXJlYTsKwqAgwqAgwqBpbnQgaSA9
IDA7CsKgCsKgIMKgIMKgbWVtc2V0X3RocmVhZF9mYWlsZWQgPSBmYWxzZTsKKyDCoCDCoHRocmVh
ZF9jcmVhdGVfZmxhZyA9IGZhbHNlOwrCoCDCoCDCoG1lbXNldF9udW1fdGhyZWFkcyA9IGdldF9t
ZW1zZXRfbnVtX3RocmVhZHMoc21wX2NwdXMpOworIMKgIMKgbnVtcGFnZXNfcGVyX3RocmVhZCA9
IGdfbmV3MChzaXplX3QsIG1lbXNldF9udW1fdGhyZWFkcyk7CsKgIMKgIMKgbWVtc2V0X3RocmVh
ZCA9IGdfbmV3MChNZW1zZXRUaHJlYWQsIG1lbXNldF9udW1fdGhyZWFkcyk7Ci0gwqAgwqBudW1w
YWdlc19wZXJfdGhyZWFkID0gKG51bXBhZ2VzIC8gbWVtc2V0X251bV90aHJlYWRzKTsKLSDCoCDC
oHNpemVfcGVyX3RocmVhZCA9IChocGFnZXNpemUgKiBudW1wYWdlc19wZXJfdGhyZWFkKTsKKyDC
oCDCoGNhbGNfcGFnZV9wZXJfdGhyZWFkKG51bXBhZ2VzLCBtZW1zZXRfbnVtX3RocmVhZHMsIG51
bXBhZ2VzX3Blcl90aHJlYWQpOworCsKgIMKgIMKgZm9yIChpID0gMDsgaSA8IG1lbXNldF9udW1f
dGhyZWFkczsgaSsrKSB7CsKgIMKgIMKgIMKgIMKgbWVtc2V0X3RocmVhZFtpXS5hZGRyID0gYWRk
cjsKLSDCoCDCoCDCoCDCoG1lbXNldF90aHJlYWRbaV0ubnVtcGFnZXMgPSAoaSA9PSAobWVtc2V0
X251bV90aHJlYWRzIC0gMSkpID8KLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoG51bXBhZ2VzIDogbnVtcGFnZXNfcGVyX3RocmVhZDsKKyDCoCDC
oCDCoCDCoG1lbXNldF90aHJlYWRbaV0ubnVtcGFnZXMgPSBudW1wYWdlc19wZXJfdGhyZWFkW2ld
OwrCoCDCoCDCoCDCoCDCoG1lbXNldF90aHJlYWRbaV0uaHBhZ2VzaXplID0gaHBhZ2VzaXplOwrC
oCDCoCDCoCDCoCDCoHFlbXVfdGhyZWFkX2NyZWF0ZSgmbWVtc2V0X3RocmVhZFtpXS5wZ3RocmVh
ZCwgInRvdWNoX3BhZ2VzIiwKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZG9fdG91Y2hfcGFnZXMsICZtZW1zZXRfdGhyZWFkW2ldLArCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBRRU1VX1RIUkVBRF9KT0lOQUJMRSk7Ci0gwqAgwqAgwqAg
wqBhZGRyICs9IHNpemVfcGVyX3RocmVhZDsKLSDCoCDCoCDCoCDCoG51bXBhZ2VzIC09IG51bXBh
Z2VzX3Blcl90aHJlYWQ7CisgwqAgwqAgwqAgwqBhZGRyICs9IG51bXBhZ2VzX3Blcl90aHJlYWRb
aV0gKiBocGFnZXNpemU7CisgwqAgwqAgwqAgwqBudW1wYWdlcyAtPSBudW1wYWdlc19wZXJfdGhy
ZWFkW2ldOwrCoCDCoCDCoH0KKyDCoCDCoHRocmVhZF9jcmVhdGVfZmxhZyA9IHRydWU7CisgwqAg
wqBxZW11X2NvbmRfYnJvYWRjYXN0KCZwYWdlX2NvbmQpOworCsKgIMKgIMKgZm9yIChpID0gMDsg
aSA8IG1lbXNldF9udW1fdGhyZWFkczsgaSsrKSB7CsKgIMKgIMKgIMKgIMKgcWVtdV90aHJlYWRf
am9pbigmbWVtc2V0X3RocmVhZFtpXS5wZ3RocmVhZCk7CsKgIMKgIMKgfQotLcKgCjEuOC4zLjE=

