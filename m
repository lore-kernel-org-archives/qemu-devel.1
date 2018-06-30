Received: from eggs.gnu.org ([2001:4830:134:3::10]:37299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fZ92X-0001vo-RR
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fZ92S-00061k-SV
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:07:21 -0400
Received: from mout.web.de ([217.72.192.78]:59595)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1fZ92S-00060G-H9
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:07:16 -0400
References: <cover.1522769774.git.jan.kiszka@web.de>
	<fb0c41863e19c760eca91a71a86eb391147d083d.1522769774.git.jan.kiszka@web.de>
	<dff77a32-ef43-192f-2e36-16067052a60e@redhat.com>
	<6d1d6901-3fc8-8d0d-68f4-2dcce8086018@web.de>
	<8a17241d-4e22-a6f4-62bd-d13afc5d6681@redhat.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <39e6f43a-2fec-d158-87a3-fc257ae65c13@web.de>
Date: Sat, 30 Jun 2018 08:07:02 +0200
MIME-Version: 1.0
In-Reply-To: <8a17241d-4e22-a6f4-62bd-d13afc5d6681@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4wlUSqKTcvJxS3EyqhXGNmVh3eYnVPupc"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] target-i386: Add NPT support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4wlUSqKTcvJxS3EyqhXGNmVh3eYnVPupc
From: Jan Kiszka <jan.kiszka@web.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Message-ID: <39e6f43a-2fec-d158-87a3-fc257ae65c13@web.de>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] target-i386: Add NPT support
References: <cover.1522769774.git.jan.kiszka@web.de>
 <fb0c41863e19c760eca91a71a86eb391147d083d.1522769774.git.jan.kiszka@web.de>
 <dff77a32-ef43-192f-2e36-16067052a60e@redhat.com>
 <6d1d6901-3fc8-8d0d-68f4-2dcce8086018@web.de>
 <8a17241d-4e22-a6f4-62bd-d13afc5d6681@redhat.com>
In-Reply-To: <8a17241d-4e22-a6f4-62bd-d13afc5d6681@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-30 08:05, Paolo Bonzini wrote:
> On 30/06/2018 07:25, Jan Kiszka wrote:
>> On 2018-06-27 14:14, Paolo Bonzini wrote:
>>> On 03/04/2018 17:36, Jan Kiszka wrote:
>>>> =20
>>>> +static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType a=
ccess_type,
>>>> +                        int *prot)
>>>> +{
>>>> +    CPUX86State *env =3D &X86_CPU(cs)->env;
>>>> +    uint64_t rsvd_mask =3D PG_HI_RSVD_MASK;
>>>> +    uint64_t ptep, pte;
>>>> +    uint64_t exit_info_1 =3D 0;
>>>> +    target_ulong pde_addr, pte_addr;
>>>> +    uint32_t page_offset;
>>>> +    int page_size;
>>>> +
>>>> +    if (likely(!(env->hflags & HF_NPT_MASK))) {
>>>> +        return gphys;
>>>> +    }
>>>
>>> hflags are a somewhat limited resource.  Can this go in hflags2?
>>>
>>
>> Will have a look - I don't seen why not. Or is there any special
>> semantical difference between both fields?
>=20
> Yes, hflags become flags of the translation block, while hflags2 are
> just random processor state.  If translate.c uses it you must use
> hflags, but here hflags2 should be safe.

Indeed. We only change it at vmentry/exit, and that is already a
translation block barrier.

v2 is on the way.

Jan


--4wlUSqKTcvJxS3EyqhXGNmVh3eYnVPupc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTKX4wA9fvIVGYBbICK1KxveuXnFAUCWzceBgAKCRCK1KxveuXn
FFbnAKDNYUO8Hl/Vneh7ymrgwq52TDjI6ACgjjPx5pB3ufgIzVGFMRWmO0+dz4E=
=1wq3
-----END PGP SIGNATURE-----

--4wlUSqKTcvJxS3EyqhXGNmVh3eYnVPupc--
