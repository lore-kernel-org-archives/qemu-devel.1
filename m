Received: from eggs.gnu.org ([2001:4830:134:3::10]:60505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <15700157322@163.com>) id 1eOIN2-0007mm-RE
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 02:19:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <15700157322@163.com>) id 1eOIMz-0002Aw-KE
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 02:19:24 -0500
Received: from m12-16.163.com ([220.181.12.16]:47045)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <15700157322@163.com>) id 1eOIMy-00027k-OQ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 02:19:21 -0500
Date: Mon, 11 Dec 2017 15:03:34 +0800 (CST)
From: "Rogue S.T" <15700157322@163.com>
MIME-Version: 1.0
Message-ID: <581dd612.8002.1604462cfac.Coremail.15700157322@163.com>
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] Inter Shared Memory ( Ivshmem ) : Cannot Bind
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, libvirt-users@redhat.com

SGVsbG8sIGZyaWVuZHMuCkkgZW5jb3VudGVyIGEgcHJvYmxlbSB3aGVuIGkgdXNlIGl2c2htZW0g
d2l0aCBteSBndWVzdCwgbXkgaXZzaG1lbSBzZXJ2ZXIgaXMgbm90IHN0YXJ0LCBhbmQgb3V0cHV0
IGEgZXJyb3IgOiBFeGFtcGxlIGNvZGUsIGRvIG5vdCB1c2UgaW4gcHJvZHVjdGlvbiAsY2Fubm90
IGJpbmQuCgoKRGV0YWlsIGRpc3RyaWJ1dGlvbjogClRvZGF5LCBJIGtub3cgaXZzaG1lbSBmcm9t
IGEgdG9waWMgIlFFTVUgdmVyc2lvbiAyLjEwLjkzIFVzZXIgRG9jdW1lbnRhdGlvbiIsIApJdnNo
bWVtOiBpdCBjYW4gY3JlYXRlIGEgc2hhcmVkIG1lbW9yeSB0aGF0IGd1ZXN0IGRldmljZSB1c2Us
IHNvIHdlIGNhbiB1c2UgdGhpcyBtZW1vcnkgdG8gZG8gc29tZXRoaW5nIG91cnNlbHZlcy4KRmly
c3QsIEkgY3JlYXRlIGhvc3QgbWVtb3J5IGJhY2tlbmQ6CiAgICAgLW9iamVjdCBtZW1vcnktYmFj
a2VuZC1maWxlLHNpemU9MU0sc2hhcmUsbWVtLXBhdGg9L2Rldi9zaG0vaXZzaG1lbSxpZD1ob3N0
bWVtClR3aWNlLCBCaW5kIGEgc2hhcmVkIG1lbW9yeSBkZXZpY2UgdG8gbXkgZ3Vlc3Q6CiAgICAt
ZGV2aWNlIGl2c2htZW0tcGxhaW4sbWVtZGV2PWhvc3RtZW0KVGhlbiBJIGJvb3QgaXZzaG1lbSBz
ZXJ2aQogICAgaXZzaG1lbS1zZXJ2ZXIgLXAgL3Zhci9ydW4vaXZzaG1lbS1zZXJ2ZXIucGlkICAt
UyAvdG1wL2l2c2htZW1fc29ja2V0ICAtTSBpdnNobWVtIC1tIC9kZXYvc2htIC1sIDFNIC1uIDIK
TmV4dCB0aW1lIGkgZ2V0IHRoaXMgZXJyb3I6CiAgICAqKiogRXhhbXBsZSBjb2RlLCBkbyBub3Qg
dXNlIGluIHByb2R1Y3Rpb24gKioqCiAgICBjYW5ub3QgYmluZApBbmQgaSBzZWFyY2ggdGhlIHBy
b2JsZW0gb24gZ29vZ2xlLCBidXQgbm90aGluZyB0byBnZXQsIGhvcGUgeW91IGNhbiBoZWxwIG1l
IHNvbHZlIGl0Lgpmb2xsb3dpbmcgbWVzc2FnZSBpcyBteSBob3N0IGVudmlyb25tZW50OgogICAg
aG9zdDogIHVidW50dSAxNjA0CiAgICBxZW11OiAgdmVyc2lvbiAyLjEwLjkwICh2Mi4xMS4wLXJj
MC1kaXJ0eSkKICAgIGxpYnZpcnQ6ICBsaWJ2aXJ0ZCAobGlidmlydCkgMy45LjAKICAgIGd1ZXN0
OiAgICB3aW5kb3cgNyBwcm9mZXNzb3IKCgpSZWZlcjoKICAgIGh0dHBzOi8vcWVtdS53ZWlsbmV0
ei5kZS9kb2MvcWVtdS1kb2MuaHRtbCNJbnRlcl8wMDJkVk0tU2hhcmVkLU1lbW9yeS1kZXZpY2Ug
KHRvcGljIHFlbXUgZG9jdW1lbnRpb24pCiAgICBodHRwczovL2hlbHBtYW51YWwuaW8vaGVscC9p
dnNobWVtLXNlcnZlci8gICggaG93IHRvIHVzZSBpdnNobWVtLXNlcnZlciAp
