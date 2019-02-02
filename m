Received: from eggs.gnu.org ([209.51.188.92]:44542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gq0Fi-0003v6-V3
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 13:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gq0Fi-0002ut-2b
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 13:42:54 -0500
Resent-Message-Id: <E1gq0Fi-0002ut-2b@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gq0Fh-0002WU-Qg
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 13:42:54 -0500
Message-ID: <154913199805.29184.362004130327262897@ebba9967afc0>
In-Reply-To: <20190118112213.11173-1-philmd@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 2 Feb 2019 10:26:39 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC PATCH] gdbstub: Avoid NULL dereference in
 gdb_handle_packet()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com
Cc: fam@euphon.net, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair.francis@wdc.com, luc.michel@greensocs.com, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExODExMjIxMy4xMTE3
My0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IFNIT1dfRU5WPTEgSj0xNAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHg4Nl82
NC1zb2Z0bW11L21lbW9yeS5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9tZW1vcnlfbWFwcGlu
Zy5vCi90bXAvcWVtdS10ZXN0L3NyYy9nZGJzdHViLmM6IEluIGZ1bmN0aW9uICdnZGJfaGFuZGxl
X3BhY2tldCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9nZGJzdHViLmM6MTQ0MDoxNzogZXJyb3I6ICdH
REJTdGF0ZScge2FrYSAnc3RydWN0IEdEQlN0YXRlJ30gaGFzIG5vIG1lbWJlciBuYW1lZCAnc19j
cHUnOyBkaWQgeW91IG1lYW4gJ2NfY3B1Jz8KICAgICAgICAgaWYgKCFzLT5zX2NwdSkgewogICAg
ICAgICAgICAgICAgIF5+fn5+CiAgICAgICAgICAgICAgICAgY19jcHUKL3RtcC9xZW11LXRlc3Qv
c3JjL2dkYnN0dWIuYzoxNDU2OjIxOiBlcnJvcjogJ0dEQlN0YXRlJyB7YWthICdzdHJ1Y3QgR0RC
U3RhdGUnfSBoYXMgbm8gbWVtYmVyIG5hbWVkICdzX2NwdSc7IGRpZCB5b3UgbWVhbiAnY19jcHUn
PwogICAgICAgICAgICAgaWYgKCFzLT5zX2NwdSkgewogICAgICAgICAgICAgICAgICAgICBefn5+
fgogICAgICAgICAgICAgICAgICAgICBjX2NwdQotLS0KICBDQyAgICAgIGFhcmNoNjQtc29mdG1t
dS9tZW1vcnkubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L21lbW9yeV9tYXBwaW5nLm8KL3Rt
cC9xZW11LXRlc3Qvc3JjL2dkYnN0dWIuYzogSW4gZnVuY3Rpb24gJ2dkYl9oYW5kbGVfcGFja2V0
JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2dkYnN0dWIuYzoxNDQwOjE3OiBlcnJvcjogJ0dEQlN0YXRl
JyB7YWthICdzdHJ1Y3QgR0RCU3RhdGUnfSBoYXMgbm8gbWVtYmVyIG5hbWVkICdzX2NwdSc7IGRp
ZCB5b3UgbWVhbiAnY19jcHUnPwogICAgICAgICBpZiAoIXMtPnNfY3B1KSB7CiAgICAgICAgICAg
ICAgICAgXn5+fn4KICAgICAgICAgICAgICAgICBjX2NwdQovdG1wL3FlbXUtdGVzdC9zcmMvZ2Ri
c3R1Yi5jOjE0NTY6MjE6IGVycm9yOiAnR0RCU3RhdGUnIHtha2EgJ3N0cnVjdCBHREJTdGF0ZSd9
IGhhcyBubyBtZW1iZXIgbmFtZWQgJ3NfY3B1JzsgZGlkIHlvdSBtZWFuICdjX2NwdSc/CiAgICAg
ICAgICAgICBpZiAoIXMtPnNfY3B1KSB7CiAgICAgICAgICAgICAgICAgICAgIF5+fn5+CiAgICAg
ICAgICAgICAgICAgICAgIGNfY3B1CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDExODExMjIxMy4xMTE3My0xLXBoaWxtZEByZWRoYXQu
Y29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
