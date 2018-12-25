Received: from eggs.gnu.org ([208.118.235.92]:49918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gbrWN-0008R4-R3
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 13:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gbrWI-0001HE-I8
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 13:33:39 -0500
Resent-Message-Id: <E1gbrWI-0001HE-I8@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gbrWH-00018p-Pd
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 13:33:34 -0500
In-Reply-To: <20181219120904.17643-1-kraxel@redhat.com>
Message-ID: <154572040861.18047.1546820225065133237@02a1dbf831e2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 24 Dec 2018 22:46:49 -0800 (PST)
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/7] ui: add generic keyboard state
 tracker, fix keymap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE4MTIxOTEyMDkwNC4xNzY0
My0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRv
czcgU0hPV19FTlY9MSBKPTgKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCmxpYnBtZW0gc3VwcG9y
dCAgIG5vCmxpYnVkZXYgICAgICAgICAgIG5vCgpXQVJOSU5HOiBVc2Ugb2YgU0RMIDEuMiBpcyBk
ZXByZWNhdGVkIGFuZCB3aWxsIGJlIHJlbW92ZWQgaW4KV0FSTklORzogZnV0dXJlIHJlbGVhc2Vz
LiBQbGVhc2Ugc3dpdGNoIHRvIHVzaW5nIFNETCAyLjAKCk5PVEU6IGNyb3NzLWNvbXBpbGVycyBl
bmFibGVkOiAgJ2NjJwogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvY29uZmlnLWRldmljZXMubWFr
LnRtcAotLS0KICBDQyAgICAgIGNoYXJkZXYvY2hhci5vCiAgQ0MgICAgICBjaGFyZGV2L2NoYXIt
ZmQubwovdG1wL3FlbXUtdGVzdC9zcmMvdWkvc2RsLmM6IEluIGZ1bmN0aW9uICdzZGxfa2V5ZXZl
bnRfdG9fa2V5Y29kZV9nZW5lcmljJzoKL3RtcC9xZW11LXRlc3Qvc3JjL3VpL3NkbC5jOjIxODoy
ODogZXJyb3I6IGluY29tcGF0aWJsZSB0eXBlIGZvciBhcmd1bWVudCAzIG9mICdrZXlzeW0yc2Nh
bmNvZGUnCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaGlmdCwgYWx0Z3IsIGN0cmwpICYg
U0NBTkNPREVfS0VZTUFTSzsKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy91aS9zZGxfa2V5c3ltLmg6MjowLAotLS0K
L3RtcC9xZW11LXRlc3Qvc3JjL3VpL2tleW1hcHMuaDo1ODo1OiBub3RlOiBleHBlY3RlZCAnc3Ry
dWN0IEtiZFN0YXRlIConIGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlICdfQm9vbCcKIGludCBrZXlz
eW0yc2NhbmNvZGUoa2JkX2xheW91dF90ICprLCBpbnQga2V5c3ltLAogICAgIF4KL3RtcC9xZW11
LXRlc3Qvc3JjL3VpL3NkbC5jOjIxODoyODogZXJyb3I6IHRvbyBtYW55IGFyZ3VtZW50cyB0byBm
dW5jdGlvbiAna2V5c3ltMnNjYW5jb2RlJwogICAgICAgICAgICAgICAgICAgICAgICAgICAgc2hp
ZnQsIGFsdGdyLCBjdHJsKSAmIFNDQU5DT0RFX0tFWU1BU0s7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvdWkvc2Rs
X2tleXN5bS5oOjI6MCwKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTgxMjE5MTIwOTA0LjE3NjQzLTEta3JheGVsQHJlZGhhdC5jb20vdGVz
dGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
