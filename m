Received: from eggs.gnu.org ([208.118.235.92]:60651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfAlK-0001Ts-8p
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfAlI-0001Dg-V8
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 16:42:46 -0500
References: <20190102110804.18155-1-lbloch@janustech.com>
	<20190102110804.18155-2-lbloch@janustech.com>
	<w51h8eqdroh.fsf@maestria.local.igalia.com>
	<9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
	<1ab08459-6635-acc2-0ba2-961c7a0e5704@redhat.com>
	<472c0a97-283b-ac81-c07d-11843edd2488@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3797d82c-a6a6-eb97-be0c-67316ee55e22@redhat.com>
Date: Thu, 3 Jan 2019 15:42:30 -0600
MIME-Version: 1.0
In-Reply-To: <472c0a97-283b-ac81-c07d-11843edd2488@janustech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6GG9ageKSmywv75IBZHgDI6G0D2TOIK2n"
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6GG9ageKSmywv75IBZHgDI6G0D2TOIK2n
From: Eric Blake <eblake@redhat.com>
To: Leonid Bloch <lbloch@janustech.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <3797d82c-a6a6-eb97-be0c-67316ee55e22@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes lookup
 table
References: <20190102110804.18155-1-lbloch@janustech.com>
 <20190102110804.18155-2-lbloch@janustech.com>
 <w51h8eqdroh.fsf@maestria.local.igalia.com>
 <9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
 <1ab08459-6635-acc2-0ba2-961c7a0e5704@redhat.com>
 <472c0a97-283b-ac81-c07d-11843edd2488@janustech.com>
In-Reply-To: <472c0a97-283b-ac81-c07d-11843edd2488@janustech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/3/19 3:21 PM, Leonid Bloch wrote:
> Hi,
>=20
> On 1/4/19 12:04 AM, Eric Blake wrote:
>> On 1/3/19 2:57 PM, Leonid Bloch wrote:
>>
>>>> I have to say that I'm not very convinced of the benefits of replaci=
ng a
>>>> set of trivial numeric macros with a longer and harder to read shell=

>>>> script accompanied by changes to the build system.
>>>
>>> I think that the benefit is that the script is easily verifiable,
>>> whereas if someone would like to verify the table, they will need to
>>> generate it themselves. Also, this table is automatically generated
>>> anyway, so it only makes sense to generate it during the build.
>>
>> But no one is submitting patches to active modify the table.  The work=

>> has already been done once to generate it, and the reviewers have
>> already verified it; at this point, no further changes are likely to
>> happen (other than my pipe dream of entirely getting rid of the table =
in
>> favor of using runtime generation of human-friendly default strings is=

>> added to QemuOpts instead).  If the table were not already in git, the=
n
>> generating it at build time might make sense; but at this stage in the=

>> game, you're slowing down every build to regenerate something that is
>> already correct.
>>
>=20
> OK, that's a good point. But still, I think that you agree that it woul=
d=20
> be more correct to generate it during the build, right? So now it is=20
> there already and it works. But isn't it worth it to make it more corre=
ct?

I said "might make sense", not "I would have done it that way".  I also
don't see how a generated table is "more correct" than a hand-written
one - they are both equally correct if all values in the table match
what they are documented to provide.

In my view, code generators make sense when used on code that is
expected to change over time (a good example is QAPI because we add new
commands every release; other places might be a generator to help deal
with syscall handlers since newer kernels can add a syscall; or even the
fact that we have used some powerful GNU make textual processing to make
it easy to add files to particular subsets of the build with as few
lines edited as possible), where the goal is that the generator gives
you both a compact representation that is easier to edit, and that the
expansion from the generator ensures that repetitive boilerplate is
formed without typos.  In short, if a generator results in a net
reduction in lines of edited source in relation to the lines it
produces, AND if the source that gets regenerated is likely to change,
then it makes total sense to spend time on the generator.  But when the
amount of effort to write a generator costs as much as just hard-coding
the list outright, especially when the list is not going to change
(there really aren't any other powers of 2 within 64 bits), I'm not sure
a generator adds any value.  Unfortunately, your patch diffstat of:

>  .gitignore           |  1 +
>  Makefile             |  5 +++
>  block/qcow2.h        |  2 +-
>  block/vdi.c          |  1 +
>  include/qemu/units.h | 73 --------------------------------------------=

>  scripts/gen-sizes.sh | 66 +++++++++++++++++++++++++++++++++++++++
>  6 files changed, 74 insertions(+), 74 deletions(-)
>  create mode 100755 scripts/gen-sizes.sh

is a wash (you did not result in any fewer lines in the codebase
overall), and the commit message did not do a good job saying WHY we
need it (you said WHAT it does - avoiding a hard-coded list - but not
WHY the hardcoded list is so bad that a generator would be better).  So
I'm not seeing the point of this patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6GG9ageKSmywv75IBZHgDI6G0D2TOIK2n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwugcYACgkQ3g5py3or
ov22+Af/b4W8ReWcOHAy89TMJa0QhL+x4p9exIZhbjwyOGMld1DQukRMYPe0739f
O8rhFB+B1k9nru95I15pipcInE54j8FqCtlJ0Rre8utAzHa58F/AkR4wkv4DG951
d1QlmtgeQ95Hw7fjEVGCGa68lcJ+dZD4pkhnN+LZdIyG6DjpEuFkou2zKPPOTKVv
2RLmTNpI+qD89KTY/q5fuCWoqtBSQm6LZFCCzz7xb0XDnHrmHPdDhuuOeEAZEEgD
uKFjp1lpmNVSabz0LQWk1uA89TnFCH+8tUW7tvNqEOmsRsAN2vr3bzOFvLeR+R1d
I0w32zi7QWXSu3azEL+F7Fc7KyvwIw==
=6YSF
-----END PGP SIGNATURE-----

--6GG9ageKSmywv75IBZHgDI6G0D2TOIK2n--
