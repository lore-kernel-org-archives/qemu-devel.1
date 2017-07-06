Received: from eggs.gnu.org ([2001:4830:134:3::10]:34911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGWY-0001ug-Nj
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGWU-0007dH-SD
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:30 -0400
Resent-Message-Id: <E1dTGWU-0007dH-SD@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dTGWU-0007cu-K1
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:26 -0400
In-Reply-To: <1498584769-12439-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <149938492720.27.2832471006999689045@7a482c8a7db2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 6 Jul 2017 16:48:47 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3 0/2] main_loop: Make main_loop_wait()
 return void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, f4bug@amsat.org, stefanha@redhat.com, patches@linaro.org

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYXV0b21hdGljIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IGRvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYzIDAvMl0gbWFpbl9sb29wOiBNYWtlIG1h
aW5fbG9vcF93YWl0KCkgcmV0dXJuIHZvaWQKTWVzc2FnZS1pZDogMTQ5ODU4NDc2OS0xMjQzOS0x
LWdpdC1zZW5kLWVtYWlsLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZwpUeXBlOiBzZXJpZXMKCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKc2V0IC1lCmdpdCBzdWJtb2R1bGUg
dXBkYXRlIC0taW5pdCBkdGMKIyBMZXQgZG9ja2VyIHRlc3RzIGR1bXAgZW52aXJvbm1lbnQgaW5m
bwpleHBvcnQgU0hPV19FTlY9MQpleHBvcnQgSj04CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlj
a0BjZW50b3M2CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1idWlsZEBtaW4tZ2xpYgp0aW1lIG1ha2Ug
ZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGlu
ZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CmZhdGFsOiBDYW5ub3Qg
dXBkYXRlIHBhdGhzIGFuZCBzd2l0Y2ggdG8gYnJhbmNoICd0ZXN0JyBhdCB0aGUgc2FtZSB0aW1l
LgpEaWQgeW91IGludGVuZCB0byBjaGVja291dCAnb3JpZ2luL3BhdGNoZXcvMTQ5ODU4NDc2OS0x
MjQzOS0xLWdpdC1zZW5kLWVtYWlsLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZycgd2hpY2ggY2Fu
IG5vdCBiZSByZXNvbHZlZCBhcyBjb21taXQ/ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBs
YXN0KToKICBGaWxlICIvaG9tZS9mYW0vYmluL3BhdGNoZXciLCBsaW5lIDQ0MCwgaW4gdGVzdF9v
bmUKICAgIGdpdF9jbG9uZV9yZXBvKGNsb25lLCByWyJyZXBvIl0sIHJbImhlYWQiXSwgbG9nZikK
ICBGaWxlICIvaG9tZS9mYW0vYmluL3BhdGNoZXciLCBsaW5lIDUzLCBpbiBnaXRfY2xvbmVfcmVw
bwogICAgY3dkPWNsb25lKQogIEZpbGUgIi91c3IvbGliNjQvcHl0aG9uMy41L3N1YnByb2Nlc3Mu
cHkiLCBsaW5lIDI3MSwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9y
KHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1sn
Z2l0JywgJ2NoZWNrb3V0JywgJ29yaWdpbi9wYXRjaGV3LzE0OTg1ODQ3NjktMTI0MzktMS1naXQt
c2VuZC1lbWFpbC1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcnLCAnLWInLCAndGVzdCddJyByZXR1
cm5lZCBub24temVybyBleGl0IHN0YXR1cyAxMjgKCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
