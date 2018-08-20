Received: from eggs.gnu.org ([2001:4830:134:3::10]:37743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frjES-0006K7-Pf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frjEO-0004MQ-OC
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:24:27 -0400
References: <20180725151011.25951-1-armbru@redhat.com>
	<5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
	<20180725160144.GJ12855@redhat.com>
	<20180728043238.GC1325070@localhost.localdomain>
	<371fc437-1330-6873-7f6d-99af8d56c5df@redhat.com>
	<87ftzgnj4z.fsf@dusky.pond.sub.org>
	<8b037e11-87bf-9258-2615-ae17e34ab353@redhat.com>
	<87zhxmerwd.fsf@dusky.pond.sub.org>
	<b3ac50ed-f464-e471-de0e-7c22e3873730@redhat.com>
	<87efettuer.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4c7e644e-9292-e5e0-78c9-c078320654b8@redhat.com>
Date: Mon, 20 Aug 2018 14:24:10 +0200
MIME-Version: 1.0
In-Reply-To: <87efettuer.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7v0kI6hHAJ8m6zyXAHBX9fo9uVcWhgwHO"
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON
 and back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7v0kI6hHAJ8m6zyXAHBX9fo9uVcWhgwHO
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, Jeff Cody <jcody@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <4c7e644e-9292-e5e0-78c9-c078320654b8@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] rbd: Don't convert keypairs to JSON and
 back
References: <20180725151011.25951-1-armbru@redhat.com>
 <5e713599-997f-7dda-917c-80902f6ef328@redhat.com>
 <20180725160144.GJ12855@redhat.com>
 <20180728043238.GC1325070@localhost.localdomain>
 <371fc437-1330-6873-7f6d-99af8d56c5df@redhat.com>
 <87ftzgnj4z.fsf@dusky.pond.sub.org>
 <8b037e11-87bf-9258-2615-ae17e34ab353@redhat.com>
 <87zhxmerwd.fsf@dusky.pond.sub.org>
 <b3ac50ed-f464-e471-de0e-7c22e3873730@redhat.com>
 <87efettuer.fsf@dusky.pond.sub.org>
In-Reply-To: <87efettuer.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-20 08:38, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 2018-08-16 08:40, Markus Armbruster wrote:

[...]

>> (And technically you need a string filename to point to when doing
>> block-commit (Kevin sent patches to remedy this, though), so that coul=
d
>> be called an application as well.)
>>
>>> Having image file headers point to other images is not as simple as i=
t
>>> may look at first glance.  The basic case of image format plus plain
>>> filename (not containing '/') is straightforward enough.  But if I ma=
ke
>>> the filename absolute (with a leading '/'), the image becomes less ea=
sy
>>> to move to another machine.
>>
>> That assumes that we correctly implement relative backing file names.
>> Believe me, we don't.
>>
>> For example, say you did this:
>>
>> $ qemu-img create -f qcow2 foo/bot.qcow2 1M
>> $ qemu-img create -f qcow2 -b bot.qcow2 foo/mid.qcow2
>> $ qemu-img create -f qcow2 -b mid.qcow2 foo/top.qcow2
>>
>> Now try committing top to mid.
>>
>> You're right, it's impossible right now.
>>
>> (Not via -b mid.qcow2, nor via -b foo/mid.qcow2, nor via
>> $PWD/foo/mid.qcow2.  Short of CD-ing to foo/ and then committing to
>> mid.qcow2, it's just impossible.)
>>
>> ((I've send patches to fix this, but still, it's not like we even got
>> the case right that's "straightforward enough". :-)))
>=20
> Wait, I carefully defined "straightforward enough" as "filename not
> containing '/'".  Did we manage to screw that up, too?

Well, you were talking about the backing filename.  In the example given
above, none of the backing filenames contain a '/'. O:-)

>>> Similarly, certain Ceph configuration bits may make no sense on anoth=
er
>>> machine, and putting them into an image file header may not be a good=

>>> idea.
>>
>> On one hand, sure.  Adding json:{} filenames really wasn't one of my
>> finest hours.  It looked like a simple enough idea at the time, but
>> they're just not really useful and just keep on biting us.
>>
>> On another, well, but they may indeed make sense on another machine.
>> It's like specifying an ssh URL (or absolute mount point on a local
>> machine, like you describe above).  It may make sense to some (say, yo=
u
>> have a global "content server" or something), so, well.
>>
>> I mean, our ideal model is that the user just configures the whole
>> backing chain at runtime and nothing is our fault.  At least that's my=

>> ideal model.  It's always the management layer's fault. O:-)
>=20
> Hi management layer, I got another buck for you!
>=20
> I'm currently leaning towards regarding an image header's references to=

> other images as a convenience feature for users.  Saves restating the
> "obvious" (appreciated), until the obvious becomes wrong, possibly
> creating confusion (generally less appreciated).  I think having them i=
s
> a perfectly reasonable tradeoff overall at least for simple cases.
> However, I suspect the more complex things get, the more the value of
> "obvious" diminishes, and the more likely confusion becomes.  Mix of
> observation and speculation, not a call for action.

That's how I'd like to look at it, too, but I'm not sure how reasonable
it is.  Well, it is reasonable as long as we can clearly define for
which use cases it simply isn't enough (*cough* the ones where you need
json:{} *cough*), but I suppose that's too late now.  With json:{} you
unfortunately can shoehorn everything into your image header...
(Which was the point, but you know, path to hell and good intentions and
so on.)

Max


--7v0kI6hHAJ8m6zyXAHBX9fo9uVcWhgwHO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt6suoACgkQ9AfbAGHV
z0DX4gf9GLIbbzyMnn4MDXVK0CXIUItWH0CO6ug9tRkdHHS66a2MWMxx9/nVo0Rj
loyt0B9TLyvBI6knGteIiYqkR0TvNvaS9ZH6hl9cT80wsupFG8DCpXT2ueP1El4p
YWEwQsNGiYDcXrW972gh2nrNT9MvnAhjq21FBDeqAEKBpPdZSHEhPMhjvITz5Bds
iIspiOuVf9L+huiy5KmCUVGbU1jkWcfY04aaOASQiQ2y+6U4x7xUlrnQlbQ8x0Ny
uQmpGPoOksFXYgj5ACvDa5/fxBk0Q38ww6QGwKHHi+CFGBvIZnqjN9ClDA9107SX
/P6ec1ndRWYsKrQJztnWTOiLml9zBQ==
=p7Rj
-----END PGP SIGNATURE-----

--7v0kI6hHAJ8m6zyXAHBX9fo9uVcWhgwHO--
