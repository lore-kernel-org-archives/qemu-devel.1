Received: from eggs.gnu.org ([209.51.188.92]:60493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghqkJ-0007gt-81
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghqec-0004Ii-RU
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 01:50:55 -0500
References: <1547111736-3962-1-git-send-email-thuth@redhat.com>
	<1547111736-3962-3-git-send-email-thuth@redhat.com>
	<20190110132838.31365c55@bahia.lan>
	<8947b77e-41c7-5c1d-465f-a9bf1dd7d103@redhat.com>
	<20190111001716.GK6682@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4d7242ed-e084-e95f-c5f0-d4b559fe2a6f@redhat.com>
Date: Fri, 11 Jan 2019 07:50:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190111001716.GK6682@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vg9L6XLm68LABnm6lwEnrgeVFrmuZlFUM"
Subject: Re: [Qemu-devel] [PATCH v4 2/3] ppc: Drop duplicated typedefs to be
 able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vg9L6XLm68LABnm6lwEnrgeVFrmuZlFUM
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4d7242ed-e084-e95f-c5f0-d4b559fe2a6f@redhat.com>
Subject: Re: [PATCH v4 2/3] ppc: Drop duplicated typedefs to be able to
 compile with Clang in gnu99 mode
References: <1547111736-3962-1-git-send-email-thuth@redhat.com>
 <1547111736-3962-3-git-send-email-thuth@redhat.com>
 <20190110132838.31365c55@bahia.lan>
 <8947b77e-41c7-5c1d-465f-a9bf1dd7d103@redhat.com>
 <20190111001716.GK6682@umbus.fritz.box>
In-Reply-To: <20190111001716.GK6682@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2019-01-11 01:17, David Gibson wrote:
> On Thu, Jan 10, 2019 at 03:07:59PM +0100, Thomas Huth wrote:
>> On 2019-01-10 14:15, Greg Kurz wrote:
>>> On Thu, 10 Jan 2019 10:15:35 +0100
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>> When compiling the ppc code with clang and -std=3Dgnu99, there are a=

>>>> couple of warnings/errors like this one:
>>>>
>>>>   CC      ppc64-softmmu/hw/intc/xics.o
>>>> In file included from /home/thuth/devel/qemu/hw/intc/xics.c:35:
>>>> /home/thuth/devel/qemu/include/hw/ppc/xics.h:43:25: error: redefinit=
ion of typedef 'ICPState' is a C11 feature
>>>>       [-Werror,-Wtypedef-redefinition]
>>>> typedef struct ICPState ICPState;
>>>>                         ^
>>>> /home/thuth/devel/qemu/target/ppc/cpu.h:1181:25: note: previous defi=
nition is here
>>>> typedef struct ICPState ICPState;
>>>>                         ^
>>>>
>>>> Drop the duplicated typedefs and use normal "struct" forward declara=
tions
>>>> like we already do it at the top of spapr.h for a couple of other de=
finitions.
>>>>
>>>
>>> Hmm... so the choice here is to simply ignore the official coding
>>> style ?
>>
>> Are typedefs really our "official coding style"? It's mentioned in
>> HACKING, not in CODING_STYLE, so I rather see this as a recommendation=

>> only. (Otherwise, all the forward struct definitions at the beginning =
of
>> spapr.h are a plain violation of the coding style, too...)
>=20
> I'd say it's definitely qemu coding style in practice, whatever you
> argue about the wording in the docs.

So do I get you right that you rather prefer some additional #include
statements in the headers to pull in the typedef definitions from other
headers (like Greg suggested) than to do some struct forward
declarations without typedefs?
Ok, if that's what most ppc folks prefer, I'll rework this patch
accordingly...

 Thomas


--vg9L6XLm68LABnm6lwEnrgeVFrmuZlFUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcODzHAAoJEC7Z13T+cC21ml0P/3BG2sOj2uXh3va9kiIk9KI3
sUW6mg4Q9Vo/OCAghDUYd5EDLUBX1YQ0HreAPEXmYx/MH/3MR721Zhby8xtcMLkf
y4EFLFHN1gDdwJ0+puVXP3IqLGAATCa7mKsjDiSbeDLD4XIkTu0kY4OhihcMGOj3
2s/fCSM0Dgu6S5BeaKN7VFfSfkwfrEqJVbFSxJim7EMseuXh3SbnM8t/eFOO9nf2
GE23TcVRRHPVA5a63DM3onc0m1GH9F9W8Lmv/b5a9dDKsKTB+w2H7wI5BITfM0Rb
esQee6OEOnSK+WQRm+2OBFbOD4QNSj5MOdn5olPxm0YrxsArcnvEIz8eVTlalUpP
OT5M7gEzAeYNaA1fsszr00wrfHUjhTqQqoCIb6XVAOnaah26zMjxQmAUHEGMgmxB
wnCishJJoa9mKafHDp7RR/izGr6PTRrzk2cviqM+LIAP3x383AjafVuwev9sj0Hs
lnVtdeSRqcW2+ygi8Ll1W+ciNd72Eoiw/cjrPRbbAq/ViE58jtMMZ0+FSavZ+UUc
ELw5Pbyx42i/ZflRUnuG1M18hOa20xyrDCIhxhaxppJ3fuINr/ZribP6O3MZIxIy
Qi2qYONglyCURavPndBOipm4A03A4gmok+WK9rpgQfMPt9ZCIiaK93OMGz7KtFOb
pe+c6EybtaF9OtxclgE2
=MNLD
-----END PGP SIGNATURE-----

--vg9L6XLm68LABnm6lwEnrgeVFrmuZlFUM--
