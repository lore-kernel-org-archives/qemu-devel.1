Received: from eggs.gnu.org ([209.51.188.92]:45972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gtxbX-0005am-2A
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gtxbO-0001fI-G4
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:41:42 -0500
Resent-Message-Id: <E1gtxbO-0001fI-G4@eggs.gnu.org>
Message-ID: <155007605850.7770.17230991325760326009@ebba9967afc0>
In-Reply-To: <20190212200750.27521-1-jsnow@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 13 Feb 2019 08:41:00 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIxMjIwMDc1MC4yNzUy
MS0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIGJsb2NrZGV2OiBhY3F1
aXJlIGFpb19jb250ZXh0IGZvciBiaXRtYXAgYWRkL3JlbW92ZQpUeXBlOiBzZXJpZXMKTWVzc2Fn
ZS1pZDogMjAxOTAyMTIyMDA3NTAuMjc1MjEtMS1qc25vd0ByZWRoYXQuY29tCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5j
b20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hl
dy8yMDE5MDIxMjIwMDc1MC4yNzUyMS0xLWpzbm93QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5
MDIxMjIwMDc1MC4yNzUyMS0xLWpzbm93QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwpiM2IxMWUzZTZmIGJsb2NrZGV2OiBhY3F1aXJlIGFpb19jb250ZXh0IGZvciBi
aXRtYXAgYWRkL3JlbW92ZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IE1pc3NpbmcgU2ln
bmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA2NyBsaW5l
cyBjaGVja2VkCgpDb21taXQgYjNiMTFlM2U2ZjQwIChibG9ja2RldjogYWNxdWlyZSBhaW9fY29u
dGV4dCBmb3IgYml0bWFwIGFkZC9yZW1vdmUpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09
PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwMjEy
MjAwNzUwLjI3NTIxLTEtanNub3dAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==
