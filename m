Received: from eggs.gnu.org ([2001:4830:134:3::10]:50763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1evLYv-0005ln-KP
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1evLYr-000316-M7
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:24:17 -0400
Received: from smtp61.cstnet.cn ([159.226.251.61]:35642 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1evLYr-0002uo-0o
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:24:13 -0400
Date: Mon, 12 Mar 2018 19:24:07 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <359ea922.4a3d5.16219f40e21.Coremail.suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  BiteSizedTasks: API conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thomas huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

RGVhciBUaG9tYXMsCkknbSB0cmluZyB0byB3b3JrIG9uIHRoaXMgam9iOgpCaXRlU2l6ZWRUYXNr
czoKICAgIEFQSSBjb252ZXJzaW9uOgogICAgICAgIFJlcGxhY2UgY2FsbHMgdG8gZnVuY3Rpb25z
IG5hbWVkIGNwdV9waHlzaWNhbF9tZW1vcnlfKiB3aXRoIGFkZHJlc3Nfc3BhY2VfKi4KV2hlbiBJ
IHRyeSB0byByZXBsYWNlCmBjcHVfcGh5c2ljYWxfbWVtb3J5X3dyaXRlX3JvbShyb20tPmFzLCBy
b20tPmFkZHIsIHJvbS0+ZGF0YSwgcm9tLT5kYXRhc2l6ZSk7YAp3aXRoCmBhZGRyZXNzX3NwYWNl
X3dyaXRlX3JvbShyb20tPmFzLCByb20tPmFkZHIsIHJvbS0+ZGF0YSwgcm9tLT5kYXRhc2l6ZSk7
YApnY2MgY29tcGxhaW5zIGFib3V0OgoiIiIKL2hvbWUvZGFyY3kvd29ya3N0YXRpb24vcWVtdS9o
dy9jb3JlL2xvYWRlci5jOiBJbiBmdW5jdGlvbiDigJhyb21fcmVzZXTigJk6Ci9ob21lL2RhcmN5
L3dvcmtzdGF0aW9uL3FlbXUvaHcvY29yZS9sb2FkZXIuYzoxMDk4OjEyOiBlcnJvcjogaW1wbGlj
aXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYYWRkcmVzc19zcGFjZV93cml0ZV9yb23igJkg
Wy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgICAgICAgIGFkZHJl
c3Nfc3BhY2Vfd3JpdGVfcm9tKHJvbS0+YXMsIHJvbS0+YWRkciwgcm9tLT5kYXRhLAogICAgICAg
ICAgICBeCi9ob21lL2RhcmN5L3dvcmtzdGF0aW9uL3FlbXUvaHcvY29yZS9sb2FkZXIuYzoxMDk4
OjEyOiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiDigJhhZGRyZXNzX3NwYWNl
X3dyaXRlX3JvbeKAmSBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKL2hvbWUvZGFyY3kvd29ya3N0YXRpb24vcWVtdS9ydWxl
cy5tYWs6NjY6IHJlY2lwZSBmb3IgdGFyZ2V0ICdody9jb3JlL2xvYWRlci5vJyBmYWlsZWQKbWFr
ZTogKioqIFtody9jb3JlL2xvYWRlci5vXSBFcnJvciAxCiIiIgoKVGhlbiBJIHVzZSBgYWcgYWRk
cmVzc19zcGFjZV93cml0ZV9yb21gIGluIHFlbXUncyByb290IGRpcmVjdG9yeSwKaXQgZmFpbGVk
IHRvIGZpbmQgYW55IGZ1bmN0aW9uIG5hbWVkIGBhZGRyZXNzX3NwYWNlX3dyaXRlX3JvbWAuCgpC
eSB0aGUgd2F5LCBzb3JyeSBJIGRvbid0IGZpbmQgdG9vbCBsaWtlIGBXaWtpQmxhbWVgLCB0byBo
ZWxwIG1lIGZpbmQKd2hvIGFkZCB0aGlzIHRhc2suIFNvIEkgY2FuJ3QgQ0Mgb3RoZXJzIGJ1dCB5
b3UuCgpCZXN0LApTdSBIYW5n
