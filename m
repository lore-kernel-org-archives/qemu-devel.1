Received: from eggs.gnu.org ([2001:4830:134:3::10]:42312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tim3385@gmail.com>) id 1dWTO8-0000r1-6j
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 16:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tim3385@gmail.com>) id 1dWTO4-0001XV-44
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 16:10:04 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tim3385@gmail.com>) id 1dWTO3-0001Vn-Rg
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 16:10:00 -0400
Received: by mail-pf0-x244.google.com with SMTP id e199so14908047pfh.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 13:09:59 -0700 (PDT)
Received: from ryzenwin10 ([119.28.19.150]) by smtp.gmail.com with ESMTPSA id
	n19sm27284730pfa.64.2017.07.15.13.09.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 15 Jul 2017 13:09:57 -0700 (PDT)
Date: Sun, 16 Jul 2017 04:09:55 +0800
From: "tim3385" <tim3385@gmail.com>
Message-ID: <emc_8686d943ca454098813ea91256fdd60c@pc.loc>
References: <emc_8686d943ca454098813ea91256fdd60c@pc.loc>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] =?utf-8?q?How_to_support_AMD_acceleration__on_Window?=
 =?utf-8?q?s_host?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

SGVsbG8gYWxsLAoKLSBRRU1VIGlzIGEgZ3JlYXQgd29yay4gVGhhbmtzIGZvciB5b3VyIGVmZm9y
LgoKLcKgwqBJIGFtIGEgYmVnZ2luZXIgb2YgUUVNVS7CoEkgZG9udCd0IGZvdW5kIHRoZSB3YXkg
dG8gc3VwcG9ydCBBTUTCoGFjY2VsZXJhdGlvbsKgb24gV2luZG93cyBob3N0LiBJIHdhbnQgdG8g
cnVuIHg4NiBBQkkgYW5kcm9pZCByb20ob3IgQW5kcm9pZC14ODYpIG9uIEFNRCBDUFUgcXVpY2ts
eS4KCi0gQXMgSSBrbm93OgrCoCDCoCDCoCDCoCAtIEtRRU1VIGlzbm90IHN1cHBvcnQgSFcgQ1BV
IFZpcnR1YWxpemF0aW9uIFRlY2hub2xvZ3koQU1ELXYgYW5kIEludGVsIFZUKSBhbmQgaGFkIGJl
ZW4gZHJvcHBlZCBmcm9tIFFFTVUgbG9uZyBhZ28uCsKgIMKgIMKgIMKgIC0gS1ZNIGp1c3Qgc3Vw
cG9ydCBMaW51eCBob3N0LgrCoCDCoCDCoCDCoCAtIE9uIHdpbmRvd3MsIHRoZXJlIGlzIG9ubHkg
SEFYTSB0byBzdXBwb3J0IENQVSB2aXJ0dWFsbGl6YXRpb24uIEJ1dCBpdCBqdXN0IHN1cHBvcnQg
SW50ZWwgVlQgYnV0IEFNRC12LgrCoCDCoCDCoCDCoCAtIEdvb2dsZSBBbmRyb2lkIGVtdWxhdG9y
IHVzZSBRRU1VIHdpdGggSEFYTSB0byBzdXBwb3J0IHg4NiBBQkkgcm9tIHJ1bm5pbmcgb24gSW50
ZWwtdiBidXQgQU1ELXYuCgotIFNvIGhvdyB0byBzdXBwb3J0IEFNRCBhY2NlbGVyYXRpb24gwqBv
biBXaW5kb3dzIGhvc3Q/wqAKCi0gSWYgdGhlcmUgaXNub3QgZXhpc3Rpbmcgd2F5IG5vdywgSSBh
bSB3b25kZXIgdGhhdCBpZiBpdCdzIHBvc3NpYmxlIHRvIGFjaGlldmUgaXQgYnkgbXlzZWx2ZXMg
LS0tLS0gbWFrZSBBTUTCoGFjY2VsZXJhdGlvbiBsYXllciBmb3IgV2luZG93cyBRRU1VLiDCoFRo
ZSB3YXkgaXMgc2ltcGxlciB0aGF0IGp1c3QgdXNlIHRoZSBDUFUgaGFyZHdhcmUgdmlydHVsaXph
dGlvbiBmZWF0dXJlKE5lc3RlZCBwYWdpbmcsIEVQVCBhbmQgUlZJKSBkaXJlY3RsecKgdGhhbiB0
aGUgd2F5IG9mIEtRRU1VLiBUaGUgY29kZXMgb2YgS1ZNIGFuZCB2aXJ0dWFsYm94IGluY2x1ZGUg
c29tZSByZWZlcmVuY2UgYWJvdXQgdGhpcy4gQ2FuIHNvbWVib2R5IGdpdmUgbWUgc29tZSBzdWdn
ZXN0aW9uPwoKCmJlc3QKU2VudCBmcm9tIFlvTWFpbCBmb3IgR21haWw=
