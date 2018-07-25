Received: from eggs.gnu.org ([2001:4830:134:3::10]:40324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fiMXD-0006vG-31
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fiMXA-0001tm-19
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:21:07 -0400
Resent-Message-Id: <E1fiMXA-0001tm-19@eggs.gnu.org>
In-Reply-To: <20180725151011.25951-1-armbru@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <153253563421.13213.7542048441831236306@a31e6af6af40>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 25 Jul 2018 09:20:35 -0700 (PDT)
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON
 and back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwNzI1MTUxMDExLjI1OTUxLTEtYXJtYnJ1QHJlZGhhdC5jb20KU3ViamVj
dDogW1FlbXUtZGV2ZWxdIFtSRkMgUEFUQ0hdIHJiZDogRG9uJ3QgY29udmVydCBrZXlwYWlycyB0
byBKU09OIGFuZCBiYWNrCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpC
QVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpm
YWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAk
QkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAk
bi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0
IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQo
KG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRp
bmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCmNiZjRmNDNjMmUgcmJkOiBEb24ndCBjb252ZXJ0IGtleXBhaXJz
IHRvIEpTT04gYW5kIGJhY2sKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEv
MTogcmJkOiBEb24ndCBjb252ZXJ0IGtleXBhaXJzIHRvIEpTT04gYW5kIGJhY2suLi4KRVJST1I6
IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzEyMTogRklM
RTogYmxvY2svcmJkLmM6MzA5OgorICAgIH0gd2hpbGUoZW50cnkxKTsKCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgMTM2IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t
