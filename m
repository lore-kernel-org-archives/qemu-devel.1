Received: from eggs.gnu.org ([2001:4830:134:3::10]:35096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGWp-00028K-5x
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGWo-0007ld-Ax
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:47 -0400
Resent-Message-Id: <E1dTGWo-0007ld-Ax@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dTGWo-0007l3-36
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:46 -0400
In-Reply-To: <20170628204452.41230-1-raj.khem@gmail.com>
Message-ID: <149938494275.27.2782722196835942653@7a482c8a7db2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 6 Jul 2017 16:49:03 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: raj.khem@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, kamil@netbsd.org, riku.voipio@iki.fi, laurent@vivier.eu

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYXV0b21hdGljIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IGRvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSByZXBsYWNlIHN0cnVjdCB1Y29udGV4dCB3
aXRoIHVjb250ZXh0X3QgdHlwZQpNZXNzYWdlLWlkOiAyMDE3MDYyODIwNDQ1Mi40MTIzMC0xLXJh
ai5raGVtQGdtYWlsLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKc2V0IC1lCmdpdCBzdWJtb2R1bGUgdXBkYXRlIC0taW5pdCBkdGMKIyBMZXQg
ZG9ja2VyIHRlc3RzIGR1bXAgZW52aXJvbm1lbnQgaW5mbwpleHBvcnQgU0hPV19FTlY9MQpleHBv
cnQgSj04CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M2CnRpbWUgbWFrZSBkb2Nr
ZXItdGVzdC1idWlsZEBtaW4tZ2xpYgp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CmZhdGFsOiBDYW5ub3QgdXBkYXRlIHBhdGhzIGFuZCBzd2l0Y2gg
dG8gYnJhbmNoICd0ZXN0JyBhdCB0aGUgc2FtZSB0aW1lLgpEaWQgeW91IGludGVuZCB0byBjaGVj
a291dCAnb3JpZ2luL3BhdGNoZXcvMjAxNzA2MjgyMDQ0NTIuNDEyMzAtMS1yYWoua2hlbUBnbWFp
bC5jb20nIHdoaWNoIGNhbiBub3QgYmUgcmVzb2x2ZWQgYXMgY29tbWl0PwpUcmFjZWJhY2sgKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiL2hvbWUvZmFtL2Jpbi9wYXRjaGV3IiwgbGlu
ZSA0NDAsIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsicmVwbyJdLCBy
WyJoZWFkIl0sIGxvZ2YpCiAgRmlsZSAiL2hvbWUvZmFtL2Jpbi9wYXRjaGV3IiwgbGluZSA1Mywg
aW4gZ2l0X2Nsb25lX3JlcG8KICAgIGN3ZD1jbG9uZSkKICBGaWxlICIvdXNyL2xpYjY0L3B5dGhv
bjMuNS9zdWJwcm9jZXNzLnB5IiwgbGluZSAyNzEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENh
bGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vy
cm9yOiBDb21tYW5kICdbJ2dpdCcsICdjaGVja291dCcsICdvcmlnaW4vcGF0Y2hldy8yMDE3MDYy
ODIwNDQ1Mi40MTIzMC0xLXJhai5raGVtQGdtYWlsLmNvbScsICctYicsICd0ZXN0J10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEyOAoKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
