Received: from eggs.gnu.org ([209.51.188.92]:32934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLa12-0008QY-H9
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLa11-0005pF-EW
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:10:16 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
	<d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
	<CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f6212e0-6bc4-8e84-c522-e80d36c67257@redhat.com>
Date: Tue, 30 Apr 2019 16:10:07 -0500
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2eQGYAMbxZNLq163vRzK1kPqdTbMJ7rpK"
Subject: Re: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>, "kraxel@redhat.com" <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2eQGYAMbxZNLq163vRzK1kPqdTbMJ7rpK
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair23@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Message-ID: <5f6212e0-6bc4-8e84-c522-e80d36c67257@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
References: <cover.1556650594.git.alistair.francis@wdc.com>
 <6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
 <d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
 <CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
In-Reply-To: <CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 4:01 PM, Alistair Francis wrote:
> On Tue, Apr 30, 2019 at 1:36 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
>>
>> Le 30/04/2019 =C3=A0 22:09, Alistair Francis a =C3=A9crit :
>>> Fix this warning when building with GCC9 on Fedora 30:
>>> In function =E2=80=98strncpy=E2=80=99,
>>>     inlined from =E2=80=98fill_psinfo=E2=80=99 at /home/alistair/qemu=
/linux-user/elfload.c:3208:12,
>>>     inlined from =E2=80=98fill_note_info=E2=80=99 at /home/alistair/q=
emu/linux-user/elfload.c:3390:5,
>>>     inlined from =E2=80=98elf_core_dump=E2=80=99 at /home/alistair/qe=
mu/linux-user/elfload.c:3539:9:
>>> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builti=
n_strncpy=E2=80=99 specified bound 16 equals destination size [-Werror=3D=
stringop-truncation]
>>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos=
 (__dest));
>>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
>>>

>>        /*
>>         * Using strncpy here is fine: at max-length,
>>>       * this field is not NUL-terminated.
>>>       */>      (void) strncpy(psinfo->pr_fname, base_filename,
>>> -                   sizeof(psinfo->pr_fname));
>>> +                   sizeof(psinfo->pr_fname) - 1);
>>
>> Read the comment above :)
>=20
> GCC can't read the comment though. The only other option I can think
> of is using a pragma, which I avoided using unless I had to. Would you
> prefer a pragma here? Or do you have a better solution?

psinfo is struct target_elf_prpsinfo, which we declare.  Why not just
use the QEMU_NONSTRING attribute in the declaration, to tell the
compiler our exact intents (untested, but something like this):

diff --git i/linux-user/elfload.c w/linux-user/elfload.c
index c1a26021f8d..6ebb2eeb957 100644
--- i/linux-user/elfload.c
+++ w/linux-user/elfload.c
@@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
     target_gid_t pr_gid;
     target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
     /* Lots missing */
-    char    pr_fname[16];           /* filename of executable */
+    char    pr_fname[16] QEMU_NONSTRING;           /* filename of
executable */
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };




--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2eQGYAMbxZNLq163vRzK1kPqdTbMJ7rpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIua8ACgkQp6FrSiUn
Q2r/7ggApsTIaRRUv/G9fQPGBvmMb04sQyyxt/bE2c5EnsLk4QDO2K370HgNGRaW
GOyh8EZVQomkSliU87N4VLvXCS423MAFArL2/faQNls5szGTNqaMfaEicHCR49yv
hcZxBgSf1wExbKE4sTeosLU89vRzd9kw2vweYv7raTjEoiOo7BWpvr5juLy8o8bg
jV2AKJYivvPIgOjSs5dCLVbQblDE4arwGqG/9Tqw9GxTlPbbXVewje9CUoskYdWi
4dZlaIhqkv+I9I2eFSiHbymW5eVIz8QCkxQa1okKWnd8KQR+MgiszQbmGa3/dzWb
hZS5oc9SUADUwg1TzZObMEjW9Tf/BQ==
=LPec
-----END PGP SIGNATURE-----

--2eQGYAMbxZNLq163vRzK1kPqdTbMJ7rpK--
