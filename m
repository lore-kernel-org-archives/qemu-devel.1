Received: from eggs.gnu.org ([2001:4830:134:3::10]:35162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGWu-0002BW-Ij
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dTGWt-0007oG-DG
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:52 -0400
Resent-Message-Id: <E1dTGWt-0007oG-DG@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dTGWt-0007nb-4D
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:49:51 -0400
In-Reply-To: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
Message-ID: <149938498402.27.12581019939720173427@7a482c8a7db2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 6 Jul 2017 16:49:44 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v1 0/3] Some armv7m fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: frederic.konrad@adacore.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, alistair@alistair23.me, alex.bennee@linaro.org, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYXV0b21hdGljIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IGRvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYxIDAvM10gU29tZSBhcm12N20gZml4ZXMK
TWVzc2FnZS1pZDogMTQ5ODcyODUzMy0yMzE2MC0xLWdpdC1zZW5kLWVtYWlsLWZyZWRlcmljLmtv
bnJhZEBhZGFjb3JlLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKc2V0IC1lCmdpdCBzdWJtb2R1bGUgdXBkYXRlIC0taW5pdCBkdGMKIyBMZXQg
ZG9ja2VyIHRlc3RzIGR1bXAgZW52aXJvbm1lbnQgaW5mbwpleHBvcnQgU0hPV19FTlY9MQpleHBv
cnQgSj04CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M2CnRpbWUgbWFrZSBkb2Nr
ZXItdGVzdC1idWlsZEBtaW4tZ2xpYgp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CmZhdGFsOiBDYW5ub3QgdXBkYXRlIHBhdGhzIGFuZCBzd2l0Y2gg
dG8gYnJhbmNoICd0ZXN0JyBhdCB0aGUgc2FtZSB0aW1lLgpEaWQgeW91IGludGVuZCB0byBjaGVj
a291dCAnb3JpZ2luL3BhdGNoZXcvMTQ5ODcyODUzMy0yMzE2MC0xLWdpdC1zZW5kLWVtYWlsLWZy
ZWRlcmljLmtvbnJhZEBhZGFjb3JlLmNvbScgd2hpY2ggY2FuIG5vdCBiZSByZXNvbHZlZCBhcyBj
b21taXQ/ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvaG9tZS9m
YW0vYmluL3BhdGNoZXciLCBsaW5lIDQ0MCwgaW4gdGVzdF9vbmUKICAgIGdpdF9jbG9uZV9yZXBv
KGNsb25lLCByWyJyZXBvIl0sIHJbImhlYWQiXSwgbG9nZikKICBGaWxlICIvaG9tZS9mYW0vYmlu
L3BhdGNoZXciLCBsaW5lIDUzLCBpbiBnaXRfY2xvbmVfcmVwbwogICAgY3dkPWNsb25lKQogIEZp
bGUgIi91c3IvbGliNjQvcHl0aG9uMy41L3N1YnByb2Nlc3MucHkiLCBsaW5lIDI3MSwgaW4gY2hl
Y2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJv
Y2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0JywgJ2NoZWNrb3V0JywgJ29y
aWdpbi9wYXRjaGV3LzE0OTg3Mjg1MzMtMjMxNjAtMS1naXQtc2VuZC1lbWFpbC1mcmVkZXJpYy5r
b25yYWRAYWRhY29yZS5jb20nLCAnLWInLCAndGVzdCddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAxMjgKCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
