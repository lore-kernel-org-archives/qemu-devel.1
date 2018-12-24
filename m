Received: from eggs.gnu.org ([208.118.235.92]:54007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gbNBv-00037S-CC
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 05:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gbNBr-0001XQ-Ex
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 05:10:31 -0500
Received: from m13-21.163.com ([220.181.13.21]:12333)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <13824125580@163.com>) id 1gbNBl-0001NE-BG
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 05:10:24 -0500
Date: Mon, 24 Dec 2018 18:10:15 +0800 (CST)
From: tugouxp <13824125580@163.com>
MIME-Version: 1.0
Message-ID: <1bd5a622.e60b.167dfb192d3.Coremail.13824125580@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] what is the behavier precisely if a tb was interrupted
 by a interrupt or signal?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

aGkgZm9sa3M6CgoKIHRoaW5rIGFib3V0IHRoZSBzY2VuYXJpbyBsaWtlIHRoYXQsIGEgdGIgYmxv
Y2sgY29udGFpbiAgOSBuYXRpdmUgaW5zdHJ1Y3Rpb25zICBleGVjdXRlIHNlcXVlbnRpYWxseQoK
IGlmIGEgaW50ZXJydXB0IG9yIGEgc2lnbmFsIGhhcHBlbnMgIGJlZm9yZSBpbnN0cnVjdGlvbiA2
IGV4ZWN1dGVkLCAgZGlkIHRoZSB0YiAgYmUgZmluaXNoZWQgYmVmb3JlIHJlc3BvbnNlIHRvIHRo
ZSBpbnRlcnJ1cHQgIG9yCgp0aGUgIGV4aXRlZCBhdCBvbmNlIHRvIHJlc3BvbnNlIHRoZSBpbnRl
cnJ1cHQ/CgoKCnRiIHN0YXJ0Ogpob3N0IGluc3RydWN0aW9uIDEKaG9zdCBpbnN0cnVjdGlvbiAy
Cmhvc3QgaW5zdHJ1Y3Rpb24gNApob3N0IGluc3RydWN0aW9uIDUKCmhvc3QgaW5zdHJ1Y3Rpb24g
NiAgIDwtLS0tLS0tLSBpbnRlcnJ1cHQgb3Igc2lnbmFsIGhlcmUKCmhvc3QgaW5zdHJ1Y3Rpb24g
Nwpob3N0IGluc3RydWN0aW9uIDgKaG9zdCBpbnN0cnVjdGlvbiA5CmV4aXQgdGIK
