Received: from eggs.gnu.org ([2001:4830:134:3::10]:42167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cFPKA-0007I5-79
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cFPK9-0001oQ-FJ
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:51:10 -0500
Resent-Message-Id: <E1cFPK9-0001oQ-FJ@eggs.gnu.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148130585139.163.457606851995318584@5b492b8a941d>
In-Reply-To: <20161209172547.31550-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 9 Dec 2016 09:50:53 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3 0/1] migration: disallow
 migrate_add_blocker during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, mst@redhat.com, armbru@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, ashijeetacharya@gmail.com, marcandre.lureau@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2MyAwLzFdIG1pZ3JhdGlvbjogZGlzYWxsb3cgbWlncmF0ZV9hZGRfYmxv
Y2tlciBkdXJpbmcgbWlncmF0aW9uClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE2MTIwOTE3
MjU0Ny4zMTU1MC0xLWpzbm93QHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFT
RS4uIHwgd2MgLWwpCmZhaWxlZD0wCgojIFVzZWZ1bCBnaXQgb3B0aW9ucwpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMg
VHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIK
Zm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6
ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMg
LS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRo
ZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRv
bmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFu
Y2ggJ3Rlc3QnCmJlYmQzZDAgbWlncmF0aW9uOiBkaXNhbGxvdyBtaWdyYXRlX2FkZF9ibG9ja2Vy
IGR1cmluZyBtaWdyYXRpb24KCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEv
MTogbWlncmF0aW9uOiBkaXNhbGxvdyBtaWdyYXRlX2FkZF9ibG9ja2VyIGR1cmluZyBtaWdyYXRp
b24uLi4KRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiMxNTg6IEZJTEU6IGJsb2Nr
L3Z2ZmF0LmM6MTIwNToKKyAgICAvLyAgICBhc3NlcnQoaXNfY29uc2lzdGVudChzKSk7Cgp0b3Rh
bDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDM5NCBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
