Received: from eggs.gnu.org ([2001:4830:134:3::10]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eFJiS-0005U3-NF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eFJiQ-0007sb-4Y
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:56:24 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eFJiP-0007pW-MK
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:56:22 -0500
Received: by mail-wm0-f48.google.com with SMTP id r68so9545521wmr.1
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 04:56:20 -0800 (PST)
Date: Thu, 16 Nov 2017 13:56:16 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20171116135616.63dab444@fiorina>
In-Reply-To: <CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
	<CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/SUq5jFVq_EN=2mjN9xoUynF"
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, libguestfs <libguestfs@redhat.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

--MP_/SUq5jFVq_EN=2mjN9xoUynF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 15 Nov 2017 21:41:20 +0100
Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com> wrote:

> 2017-11-15 21:29 GMT+01:00 Richard W.M. Jones <rjones@redhat.com>:
> > Gandalf, is there an XVA file publically available (pref. not
> > too big) that we can look at?
>=20
> I can try to provide one, but it's simple:
>=20
> # tar tvf 20160630_124823_aa72_.xva.gz | head -n 50
> ---------- 0/0           42353 1970-01-01 01:00 ova.xml
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000000
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000000.checksum
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000001
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000001.checksum
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000003
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000003.checksum
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000004
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000004.checksum
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000005
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000005.checksum
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000006
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000006.checksum
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000007
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000007.checksum
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000009
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000009.checksum
> ---------- 0/0         1048576 1970-01-01 01:00 Ref:175/00000010
> ---------- 0/0              40 1970-01-01 01:00 Ref:175/00000010.checksum
>=20
>=20
> You can ignore the ova.xml and just use the "Ref:175" directory.
> Inside the XVA you'll fine one "Ref" directory for each virtual disk
> (ref number is different for each disk)
> Inside each Ref directory, you'll get tons of 1MB file, corrisponding
> to the RAW image.
> You have to merge these files in a single raw file with just an
> exception: numbers are not sequential.
> as you can see above, we have: 00000000, 00000001, 00000003
>=20
> The 00000002 is missing, because it's totally blank. XenServer doesn't
> export any empty block, thus it will skip the corrisponding 1MB file.
> When building the raw image, you have to replace empty blocks with 1MB
> full of zeros.
>=20
> This is (in addition to the tar extract) the most time-consuming part.
> Currently I'm rebuilding a 250GB image, with tons of files to be
> merge.
> If qemu-img can be patched to automatically convert this kind of
> format, I can save about 3 hours (30 minutes for extracting the
> tarball, and about 2 hours to merge 250-300GB image)
>=20

Hi,

I like what Richard and Max came up with. Pretty nifty solutions.
While there's nothing wrong with them I decided to take my own shot at
it. Since the blocks in tar file are pieces of raw image there is no
conversion happening. All in all it's just moving bytes from one place
to another. That means there shouldn't be a need for any heavy
machinery, right? :)

Attached is a shell script that uses dd to do the byte-shuffling.
I'm pretty sure this could even be safely parallelized by running
multiple instances of dd at the same time (e.g. with xargs). But I did
not try that.


    Tomas

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

--MP_/SUq5jFVq_EN=2mjN9xoUynF
Content-Type: application/x-shellscript
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=xva2raw.sh

IyEgL2Jpbi9zaAoKaWYgWyAkIyAtbmUgMyBdIDsgdGhlbgogICAgZWNobyAiVXNhZ2U6ICQwIDxp
bnB1dC54dmE+IDxzdWJkaXI+IDxvdXRwdXQuaW1nPiIKICAgIGV4aXQgMQpmaQoKU1JDPSIkMSIK
RElSPSIkMiIKRFNUPSIkMyIKCmxpc3RfZmlsZXMoKSB7CiAgICAjIC0gbGlzdCBmaWxlcyBpbiB0
YXIKICAgICMgLSBleHRyYWN0IGZpbGVzIG1hdGNoaW5nIDxkaXI+LzxudW1iZXI+CiAgICAjIC0g
c3RyaXAgdHJhaWxpbmcgY29sb24gZnJvbSBvZmZzZXQKICAgICMgLSBwcmludCAiPG9mZnNldD4g
PGZpbGVuYW1lPiIKICAgIHRhciB0UnZmICIkU1JDIiB8IGF3ayAnJDggfiAvJyIkRElSIidcL1sw
LTldKyQve3NwbGl0KCQyLCBvZmYsICI6Iik7IHByaW50IG9mZlsxXSwgJDh9Jwp9CgplY2hvICJS
ZW1vdmluZyAkRFNUIgpybSAtZnYgIiREU1QiCgpsaXN0X2ZpbGVzIHwgd2hpbGUgcmVhZCBvZmZz
ZXQgZmlsZSA7IGRvCiAgICBmaWxlPSQoYmFzZW5hbWUgIiRmaWxlIikKICAgICMgc3RyaXAgbGVh
ZGluZyB6ZXJvcyBhbmQgbXVsdGlwbHkgdG8gZ2V0IGJsb2NrIG9mZnNldCAKICAgIGlmIGV4cHIg
IiRmaWxlIiA6ICcwKiQnID4gL2Rldi9udWxsIDsgdGhlbgogICAgICAgIHNyY19vZmZzZXQ9MAog
ICAgZWxzZQogICAgICAgIHNyY19vZmZzZXQ9JCgoJChleHByICIkZmlsZSIgOiAnMCpcKFsxLTld
WzAtOV0qXCknKSAqIDIwNDgpKQogICAgZmkKICAgIGVjaG8gJGZpbGUKICAgIGRkIGlmPSIkU1JD
IiBicz01MTIgb2Y9IiREU1QiIGNvdW50PTIwNDggc2tpcD0iJCgob2Zmc2V0KzEpKSIgc2Vlaz0i
JHNyY19vZmZzZXQiCmRvbmUK

--MP_/SUq5jFVq_EN=2mjN9xoUynF--
