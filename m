Received: from eggs.gnu.org ([208.118.235.92]:40300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJpSB-0002WZ-4f
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 19:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJpLO-0003xL-EB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 19:35:47 -0500
References: <20181019164929.18404-1-mreitz@redhat.com>
	<20181105141838.GC10880@linux.fritz.box>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7a4c9df3-4713-1e8b-2fa8-873aa6017cf5@redhat.com>
Date: Tue, 6 Nov 2018 01:35:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181105141838.GC10880@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wYqTCOpdBuTXfuI4pJqxfWZh08GuIdBxp"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Various option help readability
 improvement suggestions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wYqTCOpdBuTXfuI4pJqxfWZh08GuIdBxp
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <7a4c9df3-4713-1e8b-2fa8-873aa6017cf5@redhat.com>
Subject: Re: [PATCH v2 0/5] Various option help readability improvement
 suggestions
References: <20181019164929.18404-1-mreitz@redhat.com>
 <20181105141838.GC10880@linux.fritz.box>
In-Reply-To: <20181105141838.GC10880@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.11.18 15:18, Kevin Wolf wrote:
> Am 19.10.2018 um 18:49 hat Max Reitz geschrieben:
>> I noticed that with the (more or less) recent series from Marc-Andr=C3=
=A9 the
>> output of qemu-img amend -f qcow2 -o help changed to this:
>>
>> $ ./qemu-img amend -f qcow2 -o help
>> Creation options for 'qcow2':
>> qcow2-create-opts.backing_file=3Dstr - File name of a base image
>> qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
>> qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
>> qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
>> [...]
>>
>> The types are a nice addition, but I didn't like having the list name
>> printed in every single line (in fact, the list name does not make any=

>> sense here at all, because there already is a caption which reads
>> "Creation options for 'qcow2'"), and I did not like the use of '=3D' f=
or
>> types.
>>
>> In general, I don't like the robot-y appearance, which is even worse i=
n
>> things like -device virtio-blk,help, which gives you this (among
>> other lines):
>>
>>> virtio-blk-pci.iothread=3Dlink<iothread>
>>
>> Sadly, there isn't much we can do about the "link<iothread>", so this
>> series doesn't improve on that point.
>>
>> What this series does do, however, is it changes these lists not to
>> print the list name on every single line, but only as a caption (and f=
or
>> option lists, this caption is option, because the caller may want to
>> print a custom caption that is more expressive -- as is the case for
>> qemu-img amend -o help).
>>
>> Consequentially, all list items are indented by two spaces to make cle=
ar
>> they belong to the caption.  I can already see that some people might
>> disagree on having this indentation, but I like it, so I have it in th=
is
>> series.
>>
>> Furthermore, types are now enclosed by angle brackets, and the alignme=
nt
>> we originally had for descriptions is restored (although now after 24
>> instead of 16 characters, because every option name is now accompanied=

>> by indentation and a type).
>>
>>
>> Thus, after this series, the amend output looks like this:
>>
>> $ ./qemu-img amend -f qcow2 -o help
>> Creation options for 'qcow2':
>>   backing_file=3D<str>     - File name of a base image
>>   backing_fmt=3D<str>      - Image format of the base image
>>   cluster_size=3D<size>    - qcow2 cluster size
>>   compat=3D<str>           - Compatibility level (0.10 or 1.1)
>> [...]
>>
>>
>> virtio-blk's list presents itself like so:
>>
>> $ x86_64-softmmu/qemu-system-x86_64 -device virtio-blk,help
>> virtio-blk-pci options:
>>   iothread=3D<link<iothread>>
>>   request-merging=3D<bool> - on/off
>>   secs=3D<uint32>
>> [...]
>>
>>
>> And now we even print something when there are no options:
>>
>> $ x86_64-softmmu/qemu-system-x86_64 -object can-bus,help
>> There are no options for can-bus.
>>
>> (Before this series, there just is no output.)
>>
>>
>> As a side effect, patch 1 fixes iotest 082.
>=20
> Thanks, applied to the block branch.

Thank you both for the quick pong. :-)

Max


--wYqTCOpdBuTXfuI4pJqxfWZh08GuIdBxp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvg4dIACgkQ9AfbAGHV
z0DT8Af9GDe/TSEN7bl7V8wPhPfgeNOoGQK1sK+8g1/0QKWhz08tbyidXmc8wd6J
mVkBtFUIEBkFezuU0ZhzAohMen382LNutW/rYSMg4udLGA4sFZ1rVrkx8tSsPmQN
Qjuinc51dBE11+o5k8elRt5Dham6UvGzf/bbA6clZat1LTf8BJi3gvsk6wEcpPga
vziQzifHZ1J2JqmhkTWC0m9/A9qOOpP2Ilr17/0RORU/c7v5XesJpCbk9nD0Hec4
0Ko2kcfXSZWxriUUUCNdoC6CrNLFHmlujjxkCxRRORg4lX0O0nf/3HgWEF9LWVz+
O/DemVGZWfBFFEB6twZG1KxVSeGGkA==
=NNKD
-----END PGP SIGNATURE-----

--wYqTCOpdBuTXfuI4pJqxfWZh08GuIdBxp--
