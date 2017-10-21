Received: from eggs.gnu.org ([2001:4830:134:3::10]:46839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e5yHM-0001YQ-C0
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 14:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e5yHJ-00071B-64
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 14:13:48 -0400
Resent-Message-Id: <E1e5yHJ-00071B-64@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e5yHI-0006zb-UG
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 14:13:45 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150860960587.476.13639554045849369874@b58463cdfd5f>
In-Reply-To: <alpine.DEB.2.10.1710211105550.27209@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 21 Oct 2017 11:13:26 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] fix WFI/WFE length in syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org
Cc: famz@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYXV0b21hdGljIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IGRvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogYWxwaW5lLkRFQi4yLjEwLjE3MTAyMTExMDU1NTAu
MjcyMDlAc3N0YWJlbGxpbmktVGhpbmtQYWQtWDI2MApTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BB
VENIIHYyXSBmaXggV0ZJL1dGRSBsZW5ndGggaW4gc3luZHJvbWUgcmVnaXN0ZXIKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKc2V0IC1lCmdpdCBzdWJtb2R1bGUgdXBkYXRl
IC0taW5pdCBkdGMKIyBMZXQgZG9ja2VyIHRlc3RzIGR1bXAgZW52aXJvbm1lbnQgaW5mbwpleHBv
cnQgU0hPV19FTlY9MQpleHBvcnQgSj04CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50
b3M2CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1idWlsZEBtaW4tZ2xpYgp0aW1lIG1ha2UgZG9ja2Vy
LXRlc3QtbWluZ3dAZmVkb3JhCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1ibG9ja0BmZWRvcmEKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3Fl
bXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy9hbHBpbmUuREVCLjIuMTAuMTcx
MDIxMTEwNTU1MC4yNzIwOUBzc3RhYmVsbGluaS1UaGlua1BhZC1YMjYwIC0+IHBhdGNoZXcvYWxw
aW5lLkRFQi4yLjEwLjE3MTAyMTExMDU1NTAuMjcyMDlAc3N0YWJlbGxpbmktVGhpbmtQYWQtWDI2
MApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmQ3MzA1ZjYzYWYgZml4IFdGSS9XRkUg
bGVuZ3RoIGluIHN5bmRyb21lIHJlZ2lzdGVyCgo9PT0gT1VUUFVUIEJFR0lOID09PQpTdWJtb2R1
bGUgJ2R0YycgKGdpdDovL2dpdC5xZW11LXByb2plY3Qub3JnL2R0Yy5naXQpIHJlZ2lzdGVyZWQg
Zm9yIHBhdGggJ2R0YycKQ2xvbmluZyBpbnRvICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
bWZpa3k3ZG8vc3JjL2R0YycuLi4KZmF0YWw6IHJlYWQgZXJyb3I6IENvbm5lY3Rpb24gcmVzZXQg
YnkgcGVlcgpmYXRhbDogY2xvbmUgb2YgJ2dpdDovL2dpdC5xZW11LXByb2plY3Qub3JnL2R0Yy5n
aXQnIGludG8gc3VibW9kdWxlIHBhdGggJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1tZmlr
eTdkby9zcmMvZHRjJyBmYWlsZWQKRmFpbGVkIHRvIGNsb25lICdkdGMnLiBSZXRyeSBzY2hlZHVs
ZWQKQ2xvbmluZyBpbnRvICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbWZpa3k3ZG8vc3Jj
L2R0YycuLi4KZmF0YWw6IHJlYWQgZXJyb3I6IENvbm5lY3Rpb24gcmVzZXQgYnkgcGVlcgpmYXRh
bDogY2xvbmUgb2YgJ2dpdDovL2dpdC5xZW11LXByb2plY3Qub3JnL2R0Yy5naXQnIGludG8gc3Vi
bW9kdWxlIHBhdGggJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1tZmlreTdkby9zcmMvZHRj
JyBmYWlsZWQKRmFpbGVkIHRvIGNsb25lICdkdGMnIGEgc2Vjb25kIHRpbWUsIGFib3J0aW5nCj09
PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlz
dHMub3Jn
