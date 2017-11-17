Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1eFeU5-0004Ld-PJ
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1eFeTw-00086S-12
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:06:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:56111)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1eFeTv-00084R-LI
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 06:06:47 -0500
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
	<cd3fcaf0-8f53-6adf-3898-d0dab2aa6f92@gmx.com>
	<a4842f5b-4f81-1486-d044-a5ba623ccdf9@linux.intel.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <21935287-010e-fac0-73a8-4a3e9d8c9223@gmx.com>
Date: Fri, 17 Nov 2017 12:09:03 +0100
MIME-Version: 1.0
In-Reply-To: <a4842f5b-4f81-1486-d044-a5ba623ccdf9@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cpVlnhQRaqF5q4NMwCaRTshJjI1huln3s"
Subject: Re: [Qemu-devel] HAXM is now open source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Ning <yu.ning@linux.intel.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cpVlnhQRaqF5q4NMwCaRTshJjI1huln3s
From: Kamil Rytarowski <n54@gmx.com>
To: Yu Ning <yu.ning@linux.intel.com>, qemu-devel@nongnu.org
Message-ID: <21935287-010e-fac0-73a8-4a3e9d8c9223@gmx.com>
Subject: Re: [Qemu-devel] HAXM is now open source
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
 <cd3fcaf0-8f53-6adf-3898-d0dab2aa6f92@gmx.com>
 <a4842f5b-4f81-1486-d044-a5ba623ccdf9@linux.intel.com>
In-Reply-To: <a4842f5b-4f81-1486-d044-a5ba623ccdf9@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.11.2017 11:30, Yu Ning wrote:
>=20
>=20
> On 11/17/2017 16:53, Kamil Rytarowski wrote:
>> On 14.11.2017 09:54, Yu Ning wrote:
>>> Hello,
>>>
>>> As some of you may have noticed, since QEMU 2.9.0, an accelerator kno=
wn
>>> as =E2=80=9Chax=E2=80=9D has been available for Windows and macOS bui=
lds of QEMU, thanks
>>> to the hard work of Vincent Palatin and help from this community (Pao=
lo
>>> Bonzini, Stefan Weil, et al.).
>>>
>>> The accelerator requires a host kernel module (driver) known as Intel=

>>> Hardware Accelerated Execution Manager (HAXM), i.e. intelhaxm.sys on
>>> Windows or intelhaxm.kext on macOS, similar to how the KVM accelerato=
r
>>> depends on kvm.ko on Linux.
>>>
>>> Today, we released the source code of the HAXM kernel module under th=
e
>>> BSD 3-clause license:
>>>
>>> https://github.com/intel/haxm
>>>
>>> We look forward to working with the community to improve HAXM (both t=
he
>>> kernel module and the accelerator). The code is accompanied by some
>>> basic documentation (README.md and API.md), which is incomplete, but
>>> hopefully helps people get started. If you have any questions or
>>> suggestions, please create an issue or post a comment on GitHub.
>>>
>>> Thanks,
>>> Yu
>>>
>> Please make it clear whether this module can be ported (as host) to
>> other OSes
>=20
> It was designed with only Windows and Mac hosts in mind, and we don't
> plan to support more host OSes. But porting HAXM to another host OS is
> possible.  If you take a look at the HAXM source tree, there are pretty=

> clear boundaries between host-independent code (core/, include/*.h),
> Windows-specific code (windows/, include/windows/) and Mac-specific cod=
e
> (darwin/, include/darwin/).

Sounds good. I will give it a try.

>>   and whether it can support arbitrary guests OSes (for the
>> same CPU).
>=20
> Unfortunately not, but again it can be done.  Initially HAXM was
> designed to support only two guest OSes, namely Android and Tizen. When=

> we upstreamed the HAXM accelerator module to QEMU, we verified it using=

> various desktop OS images, mostly Linux-based (Chrome OS, Debian,
> Ubuntu, CentOS, etc.), although there were a few others (FreeDOS, etc.)=
=2E
>=20
> Nevertheless, you may run into issues when you boot a completely
> different guest OS (e.g. Windows, which we have never tested), or even
> with one that is similar to what I've mentioned (e.g. Fedora, which IIR=
C
> will boot to a kernel panic).  In such cases, the culprit is usually
> bug(s) in the HAXM kernel module, causing incorrect behavior when the
> guest executes certain x86 instructions.  Once all the bugs exposed by =
a
> specific guest OS are fixed, that guest OS will work correctly.
>=20

If it will run BSD for start it will be good enough for now.

Thank you for the answers!


--cpVlnhQRaqF5q4NMwCaRTshJjI1huln3s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaDsNUAAoJEEuzCOmwLnZso2oP/12POz02ZvrA8w32Ntf+OG6q
hD5JeqctDTKCJ+CX7ISTnQBfgan3PkQWDGjcRtryUW7d5Lxc968R/MbwBkglg7fk
YF5EjfbpgBeU8uj5ihgQr+uh97vbxGNvfU/iRQtKNw0j74E7V6H0uY6YRTHpqQcZ
jCVAI4fKlEeNy+5omNzGtwlCqVRYx/XKclRca06s5ljkBkLRYctYHNKuoXFUN75S
BEqSYg8Y8aJFMmw3Cm7eQLER9zJqy+J6dnwZV1aNy4o4UzJwJUVqRBfplYQlJwfq
rhACU4Ha3MOcTC2B2XFqooapgijxFTSHh42KPG/q+YYsbZNROrSgCttQ5cpfWMU1
58gAwyqWv7Nd+ISjzemhGbwuCW27x05OygWvHtRtgyGybnP3yMPED2GQ1MauIeL2
gJod1PYw3vBkOwuKItdfIGLtyN064AV2NNr3Mn0NabBL4QJzqlOZZ8WuGZga9Bse
naFiBFu91QIgrLtTcN0V0h6vaCXfWpGPehTtY8dp74EqfQHicyGZXY9i2+EYzKHl
M+AZ1R5vI5B322qUkZiPWGFbKIXbPISzpqcI+6ymxmJtEZmurZWYV08Qd0xY1Tul
AqLDdorbKXZM47WnhKQgUbHIPx9GKzYsEDVxFrVy+RJZ8hZCM49mC82zYvJlZC7f
QRT94mMl6kzHRp5PZzZP
=+WOm
-----END PGP SIGNATURE-----

--cpVlnhQRaqF5q4NMwCaRTshJjI1huln3s--
