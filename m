Received: from eggs.gnu.org ([2001:4830:134:3::10]:49477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQbH7-0007Q9-BX
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:50:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQbH4-0000Dl-Q9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:50:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQbH4-0000DJ-Gp
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:50:14 -0500
References: <1469611466-31574-1-git-send-email-silbe@linux.vnet.ibm.com>
	<57991CC1.40003@redhat.com> <87twfaysit.fsf@dusky.pond.sub.org>
	<5799E26B.7090408@linux.vnet.ibm.com> <579A1D33.6010500@redhat.com>
	<579A24BE.2060707@linux.vnet.ibm.com> <579A733C.5050306@redhat.com>
	<579B5C49.1040707@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b7d3287-90c4-6a07-894c-e9c32fd4567f@redhat.com>
Date: Mon, 9 Jan 2017 08:50:10 -0600
MIME-Version: 1.0
In-Reply-To: <579B5C49.1040707@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Mod3xnreMFaeqcu3X8CroCxasD3CVnhq5"
Subject: Re: [Qemu-devel] [PATCH] error: error_setg_errno(): errno gets
 preserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Max Reitz <mreitz@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Mod3xnreMFaeqcu3X8CroCxasD3CVnhq5
From: Eric Blake <eblake@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
 Max Reitz <mreitz@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>
Message-ID: <8b7d3287-90c4-6a07-894c-e9c32fd4567f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] error: error_setg_errno(): errno gets
 preserved
References: <1469611466-31574-1-git-send-email-silbe@linux.vnet.ibm.com>
 <57991CC1.40003@redhat.com> <87twfaysit.fsf@dusky.pond.sub.org>
 <5799E26B.7090408@linux.vnet.ibm.com> <579A1D33.6010500@redhat.com>
 <579A24BE.2060707@linux.vnet.ibm.com> <579A733C.5050306@redhat.com>
 <579B5C49.1040707@linux.vnet.ibm.com>
In-Reply-To: <579B5C49.1040707@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/29/2016 08:38 AM, Halil Pasic wrote:
>=20
>=20
> On 07/28/2016 11:03 PM, Eric Blake wrote:
>> On 07/28/2016 09:29 AM, Halil Pasic wrote:
>>
>>>> You mean va_start, not start_va.  And actually, C11 is clear that er=
rno
>>>> is unspecified after library functions (but not macros) that don't
>>>> explicitly state otherwise.  Since va_start() is a macro and not a
>>>> library function, that means va_start does NOT have carte blanche
>>>> permission to modify errno.  For more reading on the topic:
>>>
>>> I also considered this function/macro thing but in the end I am not
>>> aware of anything in C11 what would prohibit va_start to modify errno=
 --
>>> correct me if I'm wrong. With that it boils down to 'may' and relying=
 on
>>> 'does not' means you are not covered by the standard C11 (but may
>>> be covered by something else -- in which case this should be document=
ed
>>> in HACKING).
>>>
>>>>
>>>> http://austingroupbugs.net/view.php?id=3D384
>>>>
>>>
>>> This got rejected, or? Means that there is no willingness to introduc=
e
>>> this guarantee at POSIX level?
>>> =20
>>
>> That particular bug report was rejected because the POSIX folks decide=
d
>> that the C11 wording was clear enough that va_start() was already
>> guaranteed to not mess with errno, so no additionally wording was need=
ed
>> in POSIX.
>>
>=20
> Sadly, I still do not get it. I have re-read the relevant parts of N157=
0
> and even had a conversation with the in house compiler team. The
> compiler guy's opinion was also that there is no guarantee provided by
> C11. In http://austingroupbugs.net/view.php?id=3D384 you stated in the
> description that the code example provided there is not conforming.

The description was the initial claim, before I had consulted with the
rest of the Austin Group.  Yes, my initial claim was that POSIX needed
tightening to guarantee something not provided by C.

> Your
> last reply I read like you were wrong with that statement.

Correct - after consultation with the full Austin Group, my initial
claim was invalidated, and the reason it was invalidated was that the
C99 standard only permits arbitrary changes to errno after function
calls, and that the C99 definition of a function call does NOT include
macro expansions.  Therefore, POSIX does not need tightening, because
the guarantee I wanted is already present; the initial description in
that bug report is well-defined, rather than my claim of undefined.
Any compliant C implementation, and therefore all POSIX-compliant
implementations, already leave errno unchanged after any use of the
varags macros.  (The current version of POSIX is still stuck on C99,
although the Austin Group is just barely starting work to incorporate
C11 for the next version of POSIX.)

> I still do
> not understand why were you wrong there. In fact, I could argue that yo=
u
> were right, but I'm afraid the argument would be somewhat lengthy and
> confusing, and I'm already feeling bad about taking so much of your tim=
e
> with this. Since I'm  admittedly quite inexperienced in this field I
> decided to just accept your the conclusion you and the POSIX guys
> reached -- without fully understanding it.

The C99 standard is annoying in that it does not use the usual RFC
wording, so where C99 uses "may", many other standards (including POSIX)
use "shall" or even "shall only".  So the fact that C99 states that "The
value of errno may be set to nonzero by a library function call" is a
requirement that C can permit arbitrary modification of errno ONLY after
a function call, and not for any other reason (including after a macro
expansion if that macro does not expand to a documented function call).
va_start() is usually not implemented as a function call, and even if it
is, it is not a publicly documented function call.

But you are certainly welcome to add further comments to the Austin
Group bug, if you think anything was misinterpreted - in the end, the
intent IS that va_* are safe to use without arbitrary changes to errno,
and it is now just a matter of whether that intent is already met by C
wording or whether POSIX indeed needs to add an additional requirement.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Mod3xnreMFaeqcu3X8CroCxasD3CVnhq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYc6MiAAoJEKeha0olJ0Nqud4H+wYzX3sia5u3OOaWWnYA5xGa
SDRqnvsaNzuIFwaKgTZwKMIilBfmk9OGoR/wAniazzvUk1l3njZKnodtejtLwdVt
haKL+eVJQtPjFhwFoO6gVBLd8G87lOhuGBW9CYXGIFLnaiG31b24ACZnVPoDUx58
2qS8dtV5kEFFryRgrMZy3zprwYO0YtSeJG5LESxmoHftcgr4/wI5tx2tVki/ZWnJ
eXIfwa4pfj2JQxIi7fx55Dv9voGQiklO2smok5dXGjT6F31GY7pYD02wi+/S7yWj
KjzFF6vDwEnqIWrYC935+QNgAWk7PkIAiJfmcREVfzlqmLoXUZBEVDQ5Op3SjNE=
=peJC
-----END PGP SIGNATURE-----

--Mod3xnreMFaeqcu3X8CroCxasD3CVnhq5--
