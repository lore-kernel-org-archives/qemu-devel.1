Received: from eggs.gnu.org ([2001:4830:134:3::10]:45981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1crJa7-0006la-Kq
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1crJa6-0004qL-Ox
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:24:19 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1crJa6-0004qD-Ju
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:24:18 -0400
Received: by mail-qt0-x243.google.com with SMTP id n37so811449qtb.3
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 00:24:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d355d12a-9f37-b7ca-aab0-1fcd0d481a8f@redhat.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
	<CAFEAcA-mzO7vniDEaZeueVFQ7+MVBB7pnzHhahv2Yk_f3q0mJw@mail.gmail.com>
	<CAJy91CZ4Ed-HGHLkzEc1dqQbo32d-eTE1S1ovO_ZwkDdTpkQXQ@mail.gmail.com>
	<CAJy91CaCV40FgSP55qWZeZgkQ=2+E8Cr7xdbu9pn5HLEo+6JJQ@mail.gmail.com>
	<CAJy91CYEwOVT7oEdYY=21__c2kcLTyxyjAaq7Zx4VnQdeLdQQQ@mail.gmail.com>
	<CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
	<1322109813.6444955.1490172025040.JavaMail.zimbra@redhat.com>
	<CAJy91CaUxFHJeGLLW4DqK6sBwx2qDnE9s20ZbdT86JDn8yQoHg@mail.gmail.com>
	<218df442-1a31-e969-32ef-01184fae84c0@redhat.com>
	<CAJy91CbBV97RRKr=Rze5-eYrYAvnwiDZQ0oQZi33aKR1v-UXKg@mail.gmail.com>
	<2d7a5a9a-8a7b-1bae-feb8-80fc4ee3048a@redhat.com>
	<CAJy91CbcV3_jVg9PTD6unka6_M65rgkKDv0KsBK=YpVd=XKqvg@mail.gmail.com>
	<ed9e6d65-ba93-d572-861a-46926a37d42a@redhat.com>
	<CAJy91CYfOUZ+_TrN6-tLtWuPX-3_gRc7bfNa4anW0iM42i1FTg@mail.gmail.com>
	<d355d12a-9f37-b7ca-aab0-1fcd0d481a8f@redhat.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Fri, 24 Mar 2017 08:24:17 +0100
Message-ID: <CAJy91Ca+=vJtXn6dV-awqz8xKHNyAnAw0MY91Fbr9yOE2-NNPw@mail.gmail.com>
Content-Type: multipart/mixed; boundary=94eb2c12381cabfef2054b74e109
Subject: Re: [Qemu-devel] Guest application reading from pl011 without
 device driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

--94eb2c12381cabfef2054b74e109
Content-Type: text/plain; charset=UTF-8

Hi, here are the patch files for char-pipe.c, char-win.c, char-win.h


On 23 March 2017 at 18:31, Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 23/03/2017 18:28, Jiahuan Zhang wrote:
> > Hi, the method doesn't work for pipe. It still causes the same issue.
> > The only difference is that the first byte in the UART fifo can be read
> > by the guest app.
> > So now my guest app can immediately read 17bytes when the host is
> > sending data continuously,
> > then guest app is unable to read.
> >
> > Now there is a solution-to-be. Set the qemu pipe chardev to wait for 1
> > millisecond before do a next ReadFile(),
> > then the pl011 can deliver the complete large data by the 16-byte fifo
> > continuously to the guest app.
> >
> > Is it rational? Or is this host -CPU-dependent?
>
> Post the patch, maybe you have a bug.
>
> Paolo
>

--94eb2c12381cabfef2054b74e109
Content-Type: application/octet-stream; name="char-pipe.patch"
Content-Disposition: attachment; filename="char-pipe.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0ni33l50

LS0tIGNoYXItcGlwZS5jCTIwMTctMDMtMjQgMDg6MDg6MTMuOTk5MjM3MDAwICswMTAwCisrKyBj
aGFyLXBpcGVfbmV3LmMJMjAxNy0wMy0yNCAwODoxNzowMC41ODA3NjkxMDAgKzAxMDAKQEAgLTM1
LDYgKzM1LDY3IEBACiAjZGVmaW5lIE1BWENPTk5FQ1QgMQ0KICNkZWZpbmUgTlRJTUVPVVQgNTAw
MA0KIA0KK3N0YXRpYyBEV09SRCBXSU5BUEkgd2luX2Nocl9waXBlX3RocmVhZChMUFZPSUQgcGFy
YW0pDQorew0KKyAgICAvL0NoYXJkZXYgKmNociA9IENIQVJERVYocGFyYW0pOw0KKyAgICBXaW5D
aGFyZGV2ICpzID0gV0lOX0NIQVJERVYocGFyYW0pOw0KKyAgICBEV09SRCBzaXplOw0KKw0KKyAg
ICBpbnQgcmV0Ow0KKw0KKyAgICBaZXJvTWVtb3J5KCZzLT5vcmVjdiwgc2l6ZW9mKHMtPm9yZWN2
KSk7DQorICAgIHMtPm9yZWN2LmhFdmVudCA9IHMtPmhyZWN2Ow0KKwl3aGlsZSAoMSkgew0KKw0K
KwkJUGVla05hbWVkUGlwZShzLT5oY29tLCBOVUxMLCAwLCBOVUxMLCAmc2l6ZSwgTlVMTCk7DQor
CQlpZiAoc2l6ZT4wKSB7DQorCQkJCS8vIFdhaXQgZm9yIG9uZSBieXRlDQorCQkgICAgU2xlZXAo
MSk7DQorCQkJcmV0ID0gUmVhZEZpbGUocy0+aGNvbSwgJnMtPndpbl9waXBlX2J1ZiwgMSwgJnNp
emUsICZzLT5vcmVjdik7DQorCQkJcHJpbnRmKCIJCQklcyBidWYgPSAlYyBzaXplID0gJWx1XG4i
LCBfX2Z1bmNfXywgcy0+d2luX3BpcGVfYnVmLCBzaXplKTsNCisNCisJCQlpZiAoIXJldCkgew0K
KwkJCQlicmVhazsNCisJCQl9DQorCQkJaWYgKCFzaXplKSB7DQorCQkJCWJyZWFrOw0KKwkJCX0N
CisNCisJCQkvLyBTb21lIHRlcm1pbmFsIGVtdWxhdG9yIHJldHVybnMgXHJcbiBmb3IgRW50ZXIs
IGp1c3QgcGFzcyBcbg0KKwkJCWlmIChzLT53aW5fcGlwZV9idWYgPT0gJ1xyJykgew0KKwkJCQkg
Y29udGludWU7DQorCQkJfQ0KKw0KKwkJCS8vIFNpZ25hbCB0aGUgbWFpbiB0aHJlYWQgYW5kIHdh
aXQgdW50aWwgdGhlIGJ5dGUgd2FzIGVhdGVuDQorCQkJaWYgKCFTZXRFdmVudChzLT5ocGlwZUlu
cHV0UmVhZHlFdmVudCkpIHsNCisJCQkJIGJyZWFrOw0KKwkJCX0NCisJCQlwcmludGYoIgkJCSVz
IHRoZSBtYWluIHRocmVhZCBpcyBzaWduYWxlZFxuIiwgX19mdW5jX18pOw0KKwkJCWlmIChXYWl0
Rm9yU2luZ2xlT2JqZWN0KHMtPmhwaXBlSW5wdXREb25lRXZlbnQsIElORklOSVRFKSAhPSBXQUlU
X09CSkVDVF8wKSB7DQorCQkJCSBicmVhazsNCisJCQl9DQorCQkJcHJpbnRmKCIJCQklcyB0aGUg
Ynl0ZSB3YXMgZWF0ZW5cbiIsIF9fZnVuY19fKTsNCisJCX0NCisJfQ0KKyAgICBxZW11X2RlbF93
YWl0X29iamVjdChzLT5ocGlwZUlucHV0UmVhZHlFdmVudCwgTlVMTCwgTlVMTCk7DQorICAgIHJl
dHVybiAwOw0KK30NCisNCitzdGF0aWMgdm9pZCB3aW5fcGlwZV90aHJlYWRfd2FpdF9mdW5jKHZv
aWQgKm9wYXF1ZSkNCit7DQorICAgIENoYXJkZXYgKmNociA9IENIQVJERVYob3BhcXVlKTsNCisg
ICAgV2luQ2hhcmRldiAqcyA9IFdJTl9DSEFSREVWKG9wYXF1ZSk7DQorDQorCWlmIChxZW11X2No
cl9iZV9jYW5fd3JpdGUoY2hyKSkgew0KKwkJcWVtdV9jaHJfYmVfd3JpdGUoY2hyLCAmcy0+d2lu
X3BpcGVfYnVmLCAxKTsNCisJCXByaW50ZigiCQkJJXMsIHMtPndpbl9waXBlX2J1ZiA9ICV4XG4i
LF9fZnVuY19fLCBzLT53aW5fcGlwZV9idWYpOw0KKwkJU2V0RXZlbnQocy0+aHBpcGVJbnB1dERv
bmVFdmVudCk7IC8vZm9yY2UgdGhlIGJ5dGUgaXMgZWF0ZW4gYnkgdGhlIGZpZm8NCisJCXByaW50
ZigiCQkJJXMgdGhlIGlucHV0IHRocmVhZCBpcyBzaWduYWxlZFxuIiwgX19mdW5jX18pOw0KKwl9
DQorDQorICAgLy8gU2V0RXZlbnQocy0+aHBpcGVJbnB1dERvbmVFdmVudCk7DQorCS8vcHJpbnRm
KCIJCQklcyB0aGUgaW5wdXQgdGhyZWFkIGlzIHNpZ25hbGVkXG4iLCBfX2Z1bmNfXyk7DQorfQ0K
IHN0YXRpYyBpbnQgd2luX2Nocl9waXBlX2luaXQoQ2hhcmRldiAqY2hyLCBjb25zdCBjaGFyICpm
aWxlbmFtZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCiB7
DQpAQCAtOTQsOCArMTU1LDM4IEBACiAgICAgICAgIG92LmhFdmVudCA9IE5VTEw7DQogICAgIH0N
CiANCi0gICAgcWVtdV9hZGRfcG9sbGluZ19jYih3aW5fY2hyX3BpcGVfcG9sbCwgY2hyKTsNCi0g
ICAgcmV0dXJuIDA7DQorICAgICAvLyBmb3IgaW50ZXJsb2NraW5nDQorICAgIERXT1JEICAgZHdJ
ZDsNCisNCisNCisgICAgcy0+aHBpcGVJbnB1dFJlYWR5RXZlbnQgPSBDcmVhdGVFdmVudChOVUxM
LCBGQUxTRSwgRkFMU0UsIE5VTEwpOw0KKyAgICBzLT5ocGlwZUlucHV0RG9uZUV2ZW50ICA9IENy
ZWF0ZUV2ZW50KE5VTEwsIEZBTFNFLCBGQUxTRSwgTlVMTCk7DQorICAgIGlmIChzLT5ocGlwZUlu
cHV0UmVhZHlFdmVudCA9PSBJTlZBTElEX0hBTkRMRV9WQUxVRQ0KKyAgICAgICAgfHwgcy0+aHBp
cGVJbnB1dERvbmVFdmVudCA9PSBJTlZBTElEX0hBTkRMRV9WQUxVRSkgew0KKyAgICAgICAgZXJy
b3Jfc2V0ZyhlcnJwLCAiY2Fubm90IGNyZWF0ZSBldmVudCIpOw0KKyAgICAgICAgZ290byBlcnIy
Ow0KKyAgICB9DQorDQorICAgIGlmIChxZW11X2FkZF93YWl0X29iamVjdChzLT5ocGlwZUlucHV0
UmVhZHlFdmVudCwgd2luX3BpcGVfdGhyZWFkX3dhaXRfZnVuYywgY2hyKSkgew0KKyAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAicWVtdV9hZGRfd2FpdF9vYmplY3Q6IGZhaWxlZCIpOw0KKyAgICAg
ICAgZ290byBlcnIyOw0KKyAgICB9DQorDQorICAgIHMtPmhwaXBlSW5wdXRUaHJlYWQgPSBDcmVh
dGVUaHJlYWQoTlVMTCwgMCwgd2luX2Nocl9waXBlX3RocmVhZCwgY2hyLCAwLCAmZHdJZCk7DQor
ICAgIGlmIChzLT5ocGlwZUlucHV0VGhyZWFkID09IElOVkFMSURfSEFORExFX1ZBTFVFKSB7DQor
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJjYW5ub3QgY3JlYXRlIHN0ZGlvIHRocmVhZCIpOw0K
KyAgICAgICAgZ290byBlcnIzOw0KKyAgICB9DQorDQorICAgICByZXR1cm4gMDsNCisNCitlcnIz
Og0KKyAgICBxZW11X2RlbF93YWl0X29iamVjdChzLT5ocGlwZUlucHV0UmVhZHlFdmVudCwgTlVM
TCwgTlVMTCk7DQorICAgIHJldHVybiAtMTsNCitlcnIyOg0KKyAgICBDbG9zZUhhbmRsZShzLT5o
cGlwZUlucHV0UmVhZHlFdmVudCk7DQorICAgIENsb3NlSGFuZGxlKHMtPmhwaXBlSW5wdXREb25l
RXZlbnQpOw0KKyAgICByZXR1cm4gLTE7DQogDQogIGZhaWw6DQogICAgIHJldHVybiAtMTsNCg==
--94eb2c12381cabfef2054b74e109
Content-Type: application/octet-stream; name="char-win.h.patch"
Content-Disposition: attachment; filename="char-win.h.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0ni3e201

LS0tIGNoYXItd2luLmgJMjAxNy0wMy0yMiAxNDo1NTowNC43MTMxNjMwMDAgKzAxMDAKKysrIGNo
YXItd2luX25ldy5oCTIwMTctMDMtMjQgMDg6MjA6MjMuOTM0NzY5MTAwICswMTAwCkBAIC0zOCw2
ICszOCwxMSBAQAogICAgIE9WRVJMQVBQRUQgb3NlbmQ7DQogICAgIC8qIEZJWE1FOiBmaWxlL2Nv
bnNvbGUgZG8gbm90IGZpbmFsaXplICovDQogICAgIGJvb2wgc2tpcF9mcmVlOw0KKwkvL2ZvciBp
bnRlcmxvY2tpbmcNCisgICAgdWludDhfdCB3aW5fcGlwZV9idWY7DQorICAgIEhBTkRMRSAgaHBp
cGVJbnB1dFJlYWR5RXZlbnQ7DQorICAgIEhBTkRMRSAgaHBpcGVJbnB1dERvbmVFdmVudDsNCisg
ICAgSEFORExFICBocGlwZUlucHV0VGhyZWFkOw0KIH0gV2luQ2hhcmRldjsNCiANCiAjZGVmaW5l
IE5TRU5EQlVGIDIwNDgNCg==
--94eb2c12381cabfef2054b74e109
Content-Type: application/octet-stream; name="char-win.patch"
Content-Disposition: attachment; filename="char-win.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0ni3i8z2

LS0tIGNoYXItd2luLmMJMjAxNy0wMy0yNCAwODowOToyOC4wNzA3MjY1MDAgKzAxMDAKKysrIGNo
YXItd2luX25ldy5jCTIwMTctMDMtMjQgMDg6MTg6NTMuMzA4NzY5MTAwICswMTAwCkBAIC0yMjYs
MTAgKzIyNiwxNCBAQAogICAgIGlmIChzLT5oY29tKSB7DQogICAgICAgICBDbG9zZUhhbmRsZShz
LT5oY29tKTsNCiAgICAgfQ0KLSAgICBpZiAocy0+ZnBpcGUpIHsNCi0gICAgICAgIHFlbXVfZGVs
X3BvbGxpbmdfY2Iod2luX2Nocl9waXBlX3BvbGwsIGNocik7DQotICAgIH0gZWxzZSB7DQotICAg
ICAgICBxZW11X2RlbF9wb2xsaW5nX2NiKHdpbl9jaHJfcG9sbCwgY2hyKTsNCisJaWYgKHMtPmhw
aXBlSW5wdXRSZWFkeUV2ZW50ICE9IElOVkFMSURfSEFORExFX1ZBTFVFKSB7DQorICAgICAgICBD
bG9zZUhhbmRsZShzLT5ocGlwZUlucHV0UmVhZHlFdmVudCk7DQorICAgIH0NCisgICAgaWYgKHMt
PmhwaXBlSW5wdXREb25lRXZlbnQgIT0gSU5WQUxJRF9IQU5ETEVfVkFMVUUpIHsNCisgICAgICAg
IENsb3NlSGFuZGxlKHMtPmhwaXBlSW5wdXREb25lRXZlbnQpOw0KKyAgICB9DQorICAgIGlmIChz
LT5ocGlwZUlucHV0VGhyZWFkICE9IElOVkFMSURfSEFORExFX1ZBTFVFKSB7DQorICAgICAgICBU
ZXJtaW5hdGVUaHJlYWQocy0+aHBpcGVJbnB1dFRocmVhZCwgMCk7DQogICAgIH0NCiANCiAgICAg
cWVtdV9jaHJfYmVfZXZlbnQoY2hyLCBDSFJfRVZFTlRfQ0xPU0VEKTsNCg==
--94eb2c12381cabfef2054b74e109--
