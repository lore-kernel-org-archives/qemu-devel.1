Received: from eggs.gnu.org ([209.51.188.92]:57659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gtwmB-0004gL-TW
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gtwmA-0002wi-0S
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:48:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gtwm7-0002ob-Va
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:48:41 -0500
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
	<1542006398-30037-3-git-send-email-marcolso@amazon.com>
	<72fed418-fb20-28cd-aa34-e1df84a9cba4@redhat.com>
	<13cbaa71-82ac-e142-945f-4ece8e3093f6@amazon.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8a51bd30-40c2-e367-208f-df0f2d225d0f@redhat.com>
Date: Wed, 13 Feb 2019 16:48:25 +0100
MIME-Version: 1.0
In-Reply-To: <13cbaa71-82ac-e142-945f-4ece8e3093f6@amazon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tDis5uAY0ya8npN6dpWQUy6pLauZ8wgT1"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] blkdebug: Add latency injection
 rule type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tDis5uAY0ya8npN6dpWQUy6pLauZ8wgT1
From: Max Reitz <mreitz@redhat.com>
To: Marc Olson <marcolso@amazon.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <8a51bd30-40c2-e367-208f-df0f2d225d0f@redhat.com>
Subject: Re: [PATCH v3 3/3] blkdebug: Add latency injection rule type
References: <1542006398-30037-1-git-send-email-marcolso@amazon.com>
 <1542006398-30037-3-git-send-email-marcolso@amazon.com>
 <72fed418-fb20-28cd-aa34-e1df84a9cba4@redhat.com>
 <13cbaa71-82ac-e142-945f-4ece8e3093f6@amazon.com>
In-Reply-To: <13cbaa71-82ac-e142-945f-4ece8e3093f6@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.02.19 22:21, Marc Olson wrote:
> On 1/11/19 7:00 AM, Max Reitz wrote:
>> On 12.11.18 08:06, Marc Olson wrote:

[...]

>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index d4fe710..72f7861 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -3057,6 +3057,34 @@
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 '*immediately': 'bool' } }
>>> =C2=A0 =C2=A0 ##
>>> +# @BlkdebugDelayOptions:
>>> +#
>>> +# Describes a single latency injection for blkdebug.
>>> +#
>>> +# @event:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trigger event
>>> +#
>>> +# @state:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the state identifier b=
lkdebug needs to be in to
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 actually trigger the event; defaults to "any"
>>> +#
>>> +# @latency:=C2=A0=C2=A0=C2=A0=C2=A0 The delay to add to an I/O, in m=
icroseconds.
>>> +#
>>> +# @sector:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specifies the sector index =
which has to be affected
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 in order to actually trigger the event; defaults to
>>> "any
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sector"
>>> +#
>>> +# @once:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disables further =
events after this one has been
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 triggered; defaults to false
>>> +#
>>> +# Since: 3.1
>> Well, 4.0 now, sorry...
> Baking version numbers into code is downright silly. Every single
> version of this patch has made a comment along the lines of, "oops, it
> didn't get reviewed in time for the next version bump, so you have to
> resubmit." With a fast moving project, this is nonsense. If you're
> looking at the code, you should have access to the git history as well
> to determine the version.

True, but these comments are used to generate documentation (e.g.
docs/interopt/qemu-qmp-ref.7 in the build directory).  So they are used
by people who don't have access to the git history.

It might be possible to generate that information from git-blame when
generating the documentation, but how would trivial fixes be handled
that are no functional changes?  For instance, it seems difficult to me
to distinguish between a spelling change for some parameter description
and a change in behavior.

(Then again, we shouldn't have such behavioral changes, hm.)

To me personally, the easiest thing would seem to be some convention to
write ***INSERT VERSION HERE*** into the code and then the maintainer
can just find an replace all instances of that when applying the
patches.  But that sounds a bit silly...

(I don't have an issue with adjusting the version numbers myself as they
are, but it's just as hard for me to find and replace all of them as it
is for you.  And since you're probably going to send a v4 anyway...)

In the end, it's up to the QAPI maintainers.

[...]

>>> diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
>>> index 48b4955..976f747 100755
>>> --- a/tests/qemu-iotests/071
>>> +++ b/tests/qemu-iotests/071
>>> @@ -100,6 +100,69 @@ $QEMU_IO -c "open -o
>>> driver=3D$IMGFMT,file.driver=3Dblkdebug,file.inject-error.event
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'read=
 -P 42 0x38000 512'
>>> =C2=A0 =C2=A0 echo
>>> +echo "=3D=3D=3D Testing blkdebug latency through filename =3D=3D=3D"=

>>> +echo
>>> +
>>> +$QEMU_IO -c "open -o
>>> file.driver=3Dblkdebug,file.inject-delay.event=3Dwrite_aio,file.injec=
t-delay.latency=3D10000
>>> $TEST_IMG" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'aio_write -P 42=
 0x28000 512' \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'aio_read -P 42 =
0x38000 512' \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_qemu_io
>>> +
>>> +echo
>>> +echo "=3D=3D=3D Testing blkdebug latency through file blockref =3D=3D=
=3D"
>>> +echo
>>> +
>>> +$QEMU_IO -c "open -o
>>> driver=3D$IMGFMT,file.driver=3Dblkdebug,file.inject-delay.event=3Dwri=
te_aio,file.inject-delay.latency=3D10000,file.image.filename=3D$TEST_IMG"=

>>> \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'aio_write -P 42=
 0x28000 512' \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -c 'aio_read -P 42 =
0x38000 512' \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | _filter_qemu_io
>>> +
>>> +# Using QMP is synchronous by default, so even though we would
>>> +# expect reordering due to using the aio_* commands, they are
>>> +# not. The purpose of this test is to verify that the driver
>>> +# can be setup via QMP, and IO can complete. See the qemu-io
>>> +# test above to prove delay functionality
>> But it doesn't prove that because the output is filtered.=C2=A0 To pro=
ve it,
>> you'd probably need to use null-co as the protocol (so there is as
>> little noise as possible) and then parse the qemu-io output to show th=
at
>> the time is always above 10 ms.
>>
>> I leave it to you whether you'd like to go through that pain.
> There's not a great way to prove it without doing a lot of parsing
> changes in testing. I'll consider an update to this patch, but I think
> this series has carried on long enough.

I agree in this instance, but I'd like to note still that "this series
has carried on long enough" is not an argument to merge bad code (or
something incomplete without promise of a follow-up).  This is just a
test for blkdebug, though, so it's OK (with the comment fixed, because
it doesn't prove anything).

(I'm sorry for not having looked at this series for so long, but qemu is
not my own, so it isn't like I could pay for my wrong by accepting
something incomplete -- if it were more important than this single test
case.)

Also, we do support Python for iotests, and parsing should be simpler
there.  Since blkdebug is just a debugging driver, I'm fine with not
knowing whether its features work, though.

Maybe I'll write the test, that would kind of pay for my wrong...

Max


--tDis5uAY0ya8npN6dpWQUy6pLauZ8wgT1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxkPEkACgkQ9AfbAGHV
z0CHzQgAmCdmk38I6w70xqka6hc2FWKkCc1Q7Bafcm9aYUjS7SczW/WX4kKl0jAE
E+rC9lsXJ8S0mTRT9EMQodZhD2wWx7MW2FfDlXtk/tBsPxAi+rfS6bpaSAFYHRaw
IA0qnQ/0icd9l136OPHPRd/IuaROnlduHoXYNbzzH7ZmMcL4JNONmniTZftocWZ9
VHQnJ83PLZRZsJ/80n4TdKRr7gctmkEdXIe4A9qcE2IMRaO2tlcKEmbGU0HWm0zA
RC1HTKP3x+0Snnr2UBb2VUse6NMssUbHJY4r3xBe5rWTMtcTr1/aWGkM4sVPhsib
a0g7JAUkevWcgb7YNtTZ+ardFBv/Cg==
=vHMo
-----END PGP SIGNATURE-----

--tDis5uAY0ya8npN6dpWQUy6pLauZ8wgT1--
