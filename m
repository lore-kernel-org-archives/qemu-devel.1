Received: from eggs.gnu.org ([2001:4830:134:3::10]:49990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cvovE-0004FI-GB
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cvovA-0006yx-IV
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:40:44 -0400
Resent-Message-Id: <E1cvovA-0006yx-IV@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cvovA-0006yL-62
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:40:40 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <149141402579.31515.1127470305239424205@6c512846dbc7>
In-Reply-To: <20170405104627.18140-1-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 5 Apr 2017 10:40:26 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] qga-win: Fix a bug where qemu-ga
 service is stuck during stop operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sameeh@daynix.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, yan@daynix.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2Ml0gcWdhLXdpbjogRml4IGEgYnVnIHdoZXJlIHFlbXUtZ2Egc2Vydmlj
ZSBpcyBzdHVjayBkdXJpbmcgc3RvcCBvcGVyYXRpb24KTWVzc2FnZS1pZDogMjAxNzA0MDUxMDQ2
MjcuMTgxNDAtMS1zYW1lZWhAZGF5bml4LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0t
b25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgojIFVzZWZ1bCBnaXQgb3B0aW9ucwpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJz
ZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRD
SCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEg
Z2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1h
aWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBu
PSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBk
YXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmRiZGViNzQgcWdhLXdpbjogRml4IGEgYnVnIHdoZXJlIHFl
bXUtZ2Egc2VydmljZSBpcyBzdHVjayBkdXJpbmcgc3RvcCBvcGVyYXRpb24KCj09PSBPVVRQVVQg
QkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogcWdhLXdpbjogRml4IGEgYnVnIHdoZXJlIHFl
bXUtZ2Egc2VydmljZSBpcyBzdHVjayBkdXJpbmcgc3RvcCBvcGVyYXRpb24uLi4KRVJST1I6IGxp
bmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM0NDogRklMRTogcWdhL21haW4uYzoxNTM6CisgICAgICAg
ICAgICBnX2RlYnVnKCJFcnJvciB1bmZyZWV6aW5nIGZpbGVzeXN0ZW1zIHByaW9yIHRvIGV4aXRp
bmc6ICVzIiwgZXJyb3JfZ2V0X3ByZXR0eShlcnIpKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgNzQgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QGZyZWVsaXN0cy5vcmc=
