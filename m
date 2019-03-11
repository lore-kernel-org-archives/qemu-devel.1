Received: from eggs.gnu.org ([209.51.188.92]:55411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h3CyN-0006Ds-1e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 00:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h3CyL-00035n-SV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 00:55:34 -0400
Resent-Message-Id: <E1h3CyL-00035n-SV@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1h3CyL-00033m-IA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 00:55:33 -0400
Message-ID: <155228009288.31099.6432699798418072895@6acff2cf482b>
In-Reply-To: <20190311013016.14411-1-richardw.yang@linux.intel.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 10 Mar 2019 21:54:54 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] exec.c: refactor function
 flatview_add_to_dispatch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richardw.yang@linux.intel.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDMxMTAxMzAxNi4xNDQx
MS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZh
aWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3Qt
bWluZ3dAZmVkb3JhIFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9hY2NlbC90Y2cvdGNnLXJ1bnRpbWUubwog
IENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2NwdS9yZWFsdmlld19tcGNvcmUubwovdG1wL3Fl
bXUtdGVzdC9zcmMvZXhlYy5jOiBJbiBmdW5jdGlvbiAnZmxhdHZpZXdfYWRkX3RvX2Rpc3BhdGNo
JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2V4ZWMuYzoxNjQ0OjMyOiBlcnJvcjogaW5jb21wYXRpYmxl
IHR5cGUgZm9yIGFyZ3VtZW50IDIgb2YgJ2ludDEyOF9ndCcKICAgICBpZiAoaW50MTI4X2d0KHJl
bWFpbi5zaXplLCAwKSkgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2V4ZWMvbWVtb3J5Lmg6
MjQsCi0tLQogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2Rpc3BsYXkvdmdhLm8KICBDQyAg
ICAgIGFhcmNoNjQtc29mdG1tdS9ody9kaXNwbGF5L2JjbTI4MzVfZmIubwovdG1wL3FlbXUtdGVz
dC9zcmMvZXhlYy5jOiBJbiBmdW5jdGlvbiAnZmxhdHZpZXdfYWRkX3RvX2Rpc3BhdGNoJzoKL3Rt
cC9xZW11LXRlc3Qvc3JjL2V4ZWMuYzoxNjQ0OjMyOiBlcnJvcjogaW5jb21wYXRpYmxlIHR5cGUg
Zm9yIGFyZ3VtZW50IDIgb2YgJ2ludDEyOF9ndCcKICAgICBpZiAoaW50MTI4X2d0KHJlbWFpbi5z
aXplLCAwKSkgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2V4ZWMvbWVtb3J5Lmg6MjQsCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5
MDMxMTAxMzAxNi4xNDQxMS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tL3Rlc3Rpbmcu
ZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
