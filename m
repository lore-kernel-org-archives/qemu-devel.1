Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Buddhi.Madhav@veritas.com>) id 1cHhXs-00075z-3l
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 20:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Buddhi.Madhav@veritas.com>) id 1cHhXp-0008FA-1Q
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 20:42:48 -0500
Received: from mail1.bemta12.messagelabs.com ([216.82.251.14]:26125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Buddhi.Madhav@veritas.com>)
	id 1cHhXo-0008Ct-Rz
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 20:42:44 -0500
From: Buddhi Madhav <Buddhi.Madhav@veritas.com>
Date: Fri, 16 Dec 2016 01:42:39 +0000
Message-ID: <E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
In-Reply-To: <CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <807F3DFCC5645648955BFE19B3492076@veritas.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 RFC] block/vxhs: Initial commit to add
 Veritas HyperScale VxHS block device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, ashish mittal <ashmit602@gmail.com>
Cc: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

SGksDQoNCglEb2VzIHRoaXMgYXV0aGVudGljYXRpb24gc2NoZW1lIHdvcmtzPw0KDQoxKSBQYXNz
IHRoZSBlbmNyeXB0ZWQgcGFzc3dvcmQgdG8gcWVtdS1rdm0gYXMgZm9sbG93czoNCg0KIyAuIC9x
ZW11LWlvIC0tb2JqZWN0IHNlY3JldCxpZD1zZWNtYXN0ZXIwLGZvcm1hdD1iYXNlNjQsZmlsZT1r
ZXkuYjY0IA0KICAgICAgIC0tb2JqZWN0IHNlY3JldCxpZD1wYXNzd29yZC1zZWNyZXQsa2V5aWQ9
c2VjbWFzdGVyMCxmaWxlPXB3LmFlcyxpdj0kKDxpdi5iNjQpDQoNCjIpIFFFTVUgcHJvY2VzcyB3
aWxsIGRlY3J5cHQgdGhlIHBhc3N3b3JkLiAoY2FsbCBxY3J5cHRvX3NlY3JldF9sb29rdXBfYXNf
dXRmOCgpKS4NCg0KMykgRm9yIGV2ZXJ5IGRpc2sgb3BlbiwgUUVNVSBwcm9jZXNzIHNlbmRzIFZN
IElELCB2ZGlzayBJRCwgYW5kIGRlY3J5cHRlZCBwYXNzd29yZC4gSHlwZXJzY2FsZSBzZXJ2ZXIN
CiAgIHZhbGlkYXRlcyB0aGUgcGFzc3dvcmQsIGFuZCBzZW5kcyBiYWNrIHRoZSBhY2Nlc3MgdG9r
ZW4odW5pcXVlIDMyYml0IElEKS4NCg0KNCkgVGhlbiBmb3IgZXZlcnkgSS9PIHJlcXVlc3QgUUVN
VSBwcm9jZXNzIHNlbmRzIHRoYXQgdG9rZW4uIEh5cGVyc2NhbGUgc2VydmVyIHZhbGlkYXRlcyB0
aGUNCiAgIHRva2VuIGJlZm9yZSBhbGxvd2luZyB0aGUgYWNjZXNzIHRvIHRoZSBkZXZpY2UuDQoN
ClRoYW5rcw0KTWFkaGF2DQoNCk9uIDEyLzEzLzE2LCAxMToyMyBQTSwgIlN0ZWZhbiBIYWpub2N6
aSIgPHN0ZWZhbmhhQGdtYWlsLmNvbT4gd3JvdGU6DQoNCiAgICBPbiBXZWQsIERlYyAxNCwgMjAx
NiBhdCAxMjowNiBBTSwgYXNoaXNoIG1pdHRhbCA8YXNobWl0NjAyQGdtYWlsLmNvbT4gd3JvdGU6
DQogICAgPiBJIGFtIHJlcXVlc3RpbmcgZmVlZGJhY2sgb24gdGhlIGZvbGxvd2luZyBkZXNpZ24g
cHJvcG9zYWwgZm9yIGxpYnFuaW8uDQogICAgPg0KICAgID4gVGhpcyBhZGRzIGFuIGFjY2VzcyBj
b250cm9sIG1lY2hhbmlzbSBiZXR3ZWVuIGxpYnFuaW8gY2xpZW50IGFuZA0KICAgID4gc2VydmVy
LiBJdCBpcyBub3QgYSBmdWxsIGNsaWVudC1zZXJ2ZXIgYXV0aGVudGljYXRpb24gbW9kZWwsIGFu
ZCBpdCBpcw0KICAgID4gbm90IGludGVuZGVkIHRvIHN1YnN0aXR1dGUgYW4gYXV0aGVudGljYXRp
b24gbWVjaGFuaXNtLg0KICAgID4NCiAgICA+IFdlIHdhbnRlZCB0byBjaGVjayBpZiB0aGUgZm9s
bG93aW5nIHdvdWxkIGJlIGFjY2VwdGFibGUgZm9yIHRoZSBmaXJzdA0KICAgID4gdmVyc2lvbiBv
ZiBWeEhTIHBhdGNoIHdoaWxlIHdlIGRlc2lnbi9pbXBsZW1lbnQgYSBwcm9wZXINCiAgICA+IGF1
dGhlbnRpY2F0aW9uIG1lY2hhbmlzbSAocG9zc2libHkgb24gYSBsaWJxbmlvIHNpZGUgYnJhbmNo
KT8NCiAgICA+DQogICAgPiAxLiAgICAgICBDbGllbnQgcGFzc2VzIFZNIElEIGFuZCB2ZGlzayBJ
RCB0byB0aGUgc2VydmVyIHdoZW4gaXQgd2FudHMNCiAgICA+IHRvIG9wZW4gYSB2ZGlzay4NCiAg
ICA+IDIuICAgICAgIFNlcnZlciB2ZXJpZmllcyB3aGV0aGVyIHRoZSBjbGllbnQvVk0gaGFzIGFj
Y2VzcyB0byBvcGVuIHRoZQ0KICAgID4gZGlzayBhbmQgcGFzc2VzL2ZhaWxzIHRoZSBvcGVuIHJl
cXVlc3QuDQogICAgDQogICAgQXJlIHRoZSBWTSBJRCBhbmQgdmRpc2sgSUQgc2VjcmV0cz8NCiAg
ICANCiAgICBJZiB5ZXMsIHRoZW4gdGhpcyBpcyBhbiBhdXRoZW50aWNhdGlvbiBzY2hlbWUuDQog
ICAgDQogICAgSWYgbm8sIHRoZW4gdGhpcyBpcyBub3Qgc2VjdXJlIGFuZCBwcm9iYWJseSBub3Qg
d29ydGggZG9pbmcuDQogICAgDQogICAgU3RlZmFuDQogICAgDQoNCg==
