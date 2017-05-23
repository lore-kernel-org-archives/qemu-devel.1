Received: from eggs.gnu.org ([2001:4830:134:3::10]:33666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dychoi@kaist.ac.kr>) id 1dDAKX-0005Ns-UB
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dychoi@kaist.ac.kr>) id 1dDAKU-0007m0-Qp
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:58:34 -0400
Received: from smtp1.kaist.ac.kr ([143.248.5.228]:49700
	helo=newsmtpdb.kaist.ac.kr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dychoi@kaist.ac.kr>) id 1dDAKU-0007jO-1m
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:58:30 -0400
Received: from kaist.ac.kr (127.0.0.1)
	by kaist.ac.kr with ESMTP imoxion SensMail SmtpServer 7.0
	id <7a2d38dad8d745cbaea774c25775bb9a> for <qemu-devel@nongnu.org> from
	<dychoi@kaist.ac.kr>; Tue, 23 May 2017 22:58:22 +0900
Date: Tue, 23 May 2017 22:58:22 +0900 (KST)
From: =?UTF-8?B?7LWc64+Z7Jqp?=<dychoi@kaist.ac.kr>
Message-ID: <592442b13fc9_@_imoxion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] =?utf-8?q?Way_to_turn_off_translation_buffer_functio?=
 =?utf-8?q?n_in_QEMU=3F?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

SGVsbG8uIEknbSBhIHN0dWRlbnQgd29ya2luZyB3aXRoIFFFTVUuIEknbSBub3Qgc3VyZSB0aGF0
IEkgY2FuIGFzayBhIHF1ZXN0aW9uIHRvIHRoaXMgZW1haWwgYWRkcmVzcy5JJ20gbm93IHRyeWlu
ZyB0byB0dXJuIG9mZiB0aGUgdHJhbnNsYXRpb24gYnVmZmVyIGZ1bmN0aW9uIChqdXN0IGZvciBl
eHBlcmltZW50KSBidXQgaGF2aW5nIHRyb3VibGUgZG9pbmcgaXQuSSB0cmllZCB0d28gZGlmZmVy
ZW50IHdheXMgdG8gZ2V0IHJpZCBvZiB0cmFuc2xhdGlvbiBidWZmZXIgZnVuY3Rpb24uKDEpIEkg
bW9kaWZpZWQgdGhlICJ0Yl9maW5kX2Zhc3QiIGFuZCAidGJfZmluZF9zbG93IiBpbiBjcHVfZXhl
Yy5jIHRvIGFsd2F5cyBmYWlsIHRvIGZpbmQgYSBjb3JyZWN0IHRyYW5zbGF0aW9uIGJsb2NrIGZy
b20gYnVmZmVyIGFuZCBmYWxsIHRvICJ0Yl9nZW5fY29kZSIuVGhlIGZpcnN0IGFwcHJvYWNoIGRp
ZG4ndCB3b3JrLiAoRXZlbiB0aGUgVk0gZGlkIG5vdCB0dXJuIG9uLikoMikgSSBmb3VuZCB0aGF0
IHdoZW5ldmVyIHRoZSB0cmFuc2xhdGlvbiBidWZmZXIgaXMgZnVsbCBpdCBpcyBmbHVzaGVkIGlu
ICJ0Yl9nZW5fY29kZSIgYnkgY2FsbGluZyAidGJfZmx1c2giLiBUaGVyZWZvcmUgSSBtb2RpZmll
ZCB0aGUgInRiX2ZpbmRfZmFzdCIgYW5kICJ0Yl9maW5kX3Nsb3ciIGluIGNwdV9leGVjLmMgdG8g
YWx3YXlzIGNhbGwgInRiX2ZsdXNoIiBiZWZvcmUgcmV0dXJuaW5nIGZyb20gInRiX2ZpbmQiIHNv
IHRoYXQgdHJhbnNsYXRpb24gYnVmZmVyIGlzIGtlcHQgZW1wdHkgYWxsIHRoZSB0aW1lLiAodG8g
bWFrZSBpdCBpbXBvc3NpYmxlIHRvIGZpbmQgY29ycmVzcG9uZGluZyB0cmFuc2xhdGlvbiBibG9j
ayBmcm9tIHRoZSB0cmFuc2xhdGlvbiBidWZmZXIpVGhlIHNlY29uZCBhcHByb2FjaCBhbHNvIGRp
ZG4ndCB3b3JrLiAoVGhlIFZNIGRpZCBub3QgdHVybiBvbiB0b28uKUlzIHRoZXJlIGFueSB3YXkg
dG8gdHVybiBvZmYgdGhlIHRyYW5zbGF0aW9uIGJ1ZmZlciBmdW5jdGlvbiBmcm9tIFFFTVU/IEkg
d2lsbCByZWFsbHkgYXBwcmVjaWF0ZSBpZiBhbnlib2R5IGNvdWxkIGdpdmUgbWUgYW4gYWR2aWNl
Lkkgd2lsbCBhbHNvIGFwcHJlY2lhdGUgaWYgYW55Ym9keSBjb3VsZCBsZXQgbWUga25vdyB3aGVy
ZSBpcyBiZXN0IHRvIGRpc2N1c3MgdGhpcyBraW5kIG9mIHF1ZXN0aW9ucy5UaGFua3Mu
