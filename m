Received: from eggs.gnu.org ([2001:4830:134:3::10]:59232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fGVP5-0005ac-9Z
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fGVP1-0007Kh-Jy
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:09:35 -0400
Resent-Message-Id: <E1fGVP1-0007Kh-Jy@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fGVP1-0007KJ-9x
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:09:31 -0400
In-Reply-To: <1525895585-79023-1-git-send-email-thomas.tai@oracle.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152589381877.2754.13612064728880725600@71c20359a636>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 9 May 2018 12:23:39 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH V2 0/1] virtio-balloon: fix internal stat
 name array to match Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thomas.tai@oracle.com
Cc: famz@redhat.com, mst@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, rob.gardner@oracle.com, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MjU4OTU1ODUtNzkwMjMtMS1naXQtc2VuZC1lbWFpbC10aG9tYXMudGFpQG9y
YWNsZS5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCBWMiAwLzFdIHZpcnRpby1iYWxs
b29uOiBmaXggaW50ZXJuYWwgc3RhdCBuYW1lIGFycmF5IHRvIG1hdGNoIExpbnV4IGtlcm5lbAoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3Rh
bD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KCmNv
bW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGlu
ICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBs
b2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0
PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAg
ICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0
ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hl
dy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8xNTI1ODk1
NTg1LTc5MDIzLTEtZ2l0LXNlbmQtZW1haWwtdGhvbWFzLnRhaUBvcmFjbGUuY29tIC0+IHBhdGNo
ZXcvMTUyNTg5NTU4NS03OTAyMy0xLWdpdC1zZW5kLWVtYWlsLXRob21hcy50YWlAb3JhY2xlLmNv
bQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRjaGV3LzIwMTgwNTA5MTgyMDAyLjgwNDQt
MS1tcmVpdHpAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTgwNTA5MTgyMDAyLjgwNDQtMS1tcmVp
dHpAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjZhMzc0YTYyOGEg
dmlydGlvLWJhbGxvb246IGZpeCBpbnRlcm5hbCBzdGF0IG5hbWUgYXJyYXkgdG8gbWF0Y2ggTGlu
dXgga2VybmVsCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHZpcnRp
by1iYWxsb29uOiBmaXggaW50ZXJuYWwgc3RhdCBuYW1lIGFycmF5IHRvIG1hdGNoIExpbnV4IGtl
cm5lbC4uLgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM1NjogRklM
RTogaHcvdmlydGlvL3ZpcnRpby1iYWxsb29uLmM6NDc6CiteSVZJUlRJT19CQUxMT09OX1NfTkFN
RVNfV0lUSF9QUkVGSVgoInN0YXQtIik7JAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA1
MiBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==
