Received: from eggs.gnu.org ([2001:4830:134:3::10]:50323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fl7cg-0003il-Qf
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 03:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fl7cd-0005XB-JW
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 03:02:10 -0400
References: <20180801131905.148778-1-frankja@linux.ibm.com>
	<20180801131905.148778-3-frankja@linux.ibm.com>
	<2da970ab-276f-f792-54d8-c696e899cac5@redhat.com>
	<1889220a-b804-23a2-26ef-1a319da01d26@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <99fae744-4f55-7ffd-56b7-1cc2796269de@redhat.com>
Date: Thu, 2 Aug 2018 09:01:52 +0200
MIME-Version: 1.0
In-Reply-To: <1889220a-b804-23a2-26ef-1a319da01d26@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Xkt2FILYJa02993vSH9Vvgl3P5gSGRI6e"
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 2/2] s390x: Enable KVM huge
 page backing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xkt2FILYJa02993vSH9Vvgl3P5gSGRI6e
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Message-ID: <99fae744-4f55-7ffd-56b7-1cc2796269de@redhat.com>
Subject: Re: [qemu-s390x] [PATCH v4 2/2] s390x: Enable KVM huge page backing
 support
References: <20180801131905.148778-1-frankja@linux.ibm.com>
 <20180801131905.148778-3-frankja@linux.ibm.com>
 <2da970ab-276f-f792-54d8-c696e899cac5@redhat.com>
 <1889220a-b804-23a2-26ef-1a319da01d26@linux.ibm.com>
In-Reply-To: <1889220a-b804-23a2-26ef-1a319da01d26@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/02/2018 08:53 AM, Janosch Frank wrote:
> On 01.08.2018 18:47, Thomas Huth wrote:
>> On 08/01/2018 03:19 PM, Janosch Frank wrote:
>>> +static int kvm_s390_configure_mempath_backing(KVMState *s)
>>> +{
>>> +    size_t path_psize =3D qemu_mempath_getpagesize(mem_path);
>>> +
>>> +    if (path_psize =3D=3D 4 * KiB)
>>> +        return 0;
>>
>> Missing curly braces.
>=20
> urgh, right, this is not the kernel.
>=20
>>
>>> +    if (path_psize !=3D 1 * MiB) {
>>> +        error_report("Memory backing with 2G pages was specified, "
>>> +                     "but KVM does not support this memory backing")=
;
>>
>> May I suggest to use a text that rather matches the condition of the
>> if-statement (just in case there will be other sizes in the future...)=
,
>> e.g. "Memory backing is only supported for 1 MiB huge pages" or
>> something similar.
>>
>>  Thomas
>>
>=20
> That's actually the gist of it. s390 supports 4k, 1M and 2G and looking=

> at the POP I don't see a big chance of having any more sizes, as there
> are not a lot of software bits left and adding support in OSs is a pain=
=2E
> Also don't hold your breath for 2G, it would need a rewrite of gmap.c.

Well, never say never ... but if you want to keep the current text,
that's fine for me, too.

 Thomas


--Xkt2FILYJa02993vSH9Vvgl3P5gSGRI6e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbYqxnAAoJEC7Z13T+cC21Ui8QAIDiQPalZ63qqY7p+DSgTXfu
8DqxI9mBSXGyVjJikxmUrv+MOFhJ5rM36QD7IkbkUMVxWseTuf00jKsVVOoraj6o
N5hTiAX3h/46AlMvhj96qPhAz6wbW7yIk8RgEt9mD3m9Bhy0K84SPMzv6/Qq9t1Z
eh3uEKSom4G8nWFn7qbRVOsnNEOqolwjacQrmiV32E142+wd8REHrzS4/J6BP1Fw
nMPn4KyXbRs/PVo1AGKkaxvcZchaBDONilCkDPqXpkqcsAfs+gDtValz//le/3vs
c/OnmvyRu0WBxajlu786J7WrCxn983Mou9fSrNUm34LYsSZ1LJFtmhxvsHssijKZ
L1VfzfA271R13jv6aGRHvK0tohJ1XgEDsCU17cxdDx9XIc92GtFxOemk59st/JlN
V7uvsGR10lHPNG7IIRfgeRn5cPB+goWof4oL6J2M6Awd6dgGs5SDYGBlUzu41YRp
bCeDJJQ26+SPzmOrvWdgebNAH5Vy+tT1Lb3x+HrAG0evi6iF3WxDDvxMZwH/9r5d
vG28AOk9AkoupOpPnCBg10+BaOincI5/AjPsmz+w38H+kEPF0K1+nAJRpZFUKV5A
Ch08NU4VoRRfT8fVgPvuPhLlv+wO/GRIng54Vw+/nzqRYmp4XgkqMlEbZFb+fMkw
zP6AFC9DPLCMVOZkfC5w
=qevV
-----END PGP SIGNATURE-----

--Xkt2FILYJa02993vSH9Vvgl3P5gSGRI6e--
