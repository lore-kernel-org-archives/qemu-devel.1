Received: from eggs.gnu.org ([2001:4830:134:3::10]:47785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJfP-0002pF-MO
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJfK-000591-U8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:37:47 -0400
References: <20170904111616.21333-1-kchamart@redhat.com>
	<20170904125523.GC19748@lemon.lan>
	<20170904132859.cqj4ufphrvz2wsys@eukaryote>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46a46a9b-bb92-92cb-b4b1-2879467a7a5f@redhat.com>
Date: Tue, 5 Sep 2017 14:37:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170904132859.cqj4ufphrvz2wsys@eukaryote>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hKcEa7up12ofCb8pH77AI0pSDR59frVFB"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Make test 192 use QMP;
 convert it to Python
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hKcEa7up12ofCb8pH77AI0pSDR59frVFB
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com,
 kwolf@redhat.com, dgilbert@redhat.com
Message-ID: <46a46a9b-bb92-92cb-b4b1-2879467a7a5f@redhat.com>
Subject: Re: [PATCH] qemu-iotests: Make test 192 use QMP; convert it to Python
References: <20170904111616.21333-1-kchamart@redhat.com>
 <20170904125523.GC19748@lemon.lan>
 <20170904132859.cqj4ufphrvz2wsys@eukaryote>
In-Reply-To: <20170904132859.cqj4ufphrvz2wsys@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2017 08:28 AM, Kashyap Chamarthy wrote:
> On Mon, Sep 04, 2017 at 08:55:23PM +0800, Fam Zheng wrote:
>> Hi Kashyap,
>>
>> On Mon, 09/04 13:16, Kashyap Chamarthy wrote:

>>> The test 192 ("Test NBD export with '-incoming' (non-shared
>>> storage migration use case from libvirt")) is currently using HMP.
>>> Replace the HMP usage with QMP, as the upstream preference seems to b=
e:
>>> "Use QMP where possible, unless you're explicitly testing something
>>> related to HMP".

Kevin actually argued that keeping some HMP coverage is a GOOD thing:

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00798.html

>>
>> As an improvement maybe you could rebase to Stefan's "iotests: clean u=
p
>> resources using context managers" series and switch to "with" for the =
temp file
>> and VM.
>=20
> Good point.  I did notice that thread[*] about resource clean up.  And =
I
> see it's already applied to 'block-next'.  Will rebase and change to th=
e
> 'with' statement.

I'm not sure if this patch helps us any; I personally find the unit-test
style python iotests harder to debug than the ones that produce
diff-able nnn.out files (debugging an nnn.out file that has only a list
of ..... doesn't make it easy to reproduce).  If the test already runs
well in shell, what does the conversion to Python actually buy us?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hKcEa7up12ofCb8pH77AI0pSDR59frVFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmu/PEACgkQp6FrSiUn
Q2pfugf+P0BWaJOYNW35TxUpNvt2wB1vS7+l51t9FflIUZF6oPsmT/eT09XI1qOH
5z/r0AJ2sfFQCX1XsudKUifzrOVAo0vqXVBiLqP43dBUa5aa5lKrjxZl/RVNpGX7
zNNMMXS2iIix27XP0nKyub8Qni/WIRYb72Sv3lKVZqeDAjB6tjH9m/bhqx2nyr6q
/OGBtU8DOPXI0PHifrvp0H+9QnnZVbmRKSZLmx8W8QGboERoz+9h7x5WtC09Hwk3
Q7lx7gDtYkoEkZ1Yns5bbGTjGgXdTcvfArtG4e6ppPVu/mPIVGwXw1Ai8CfzDq67
5HDu30Qy8TF0Jsfy/LcBWc6XUm1Chg==
=PY9C
-----END PGP SIGNATURE-----

--hKcEa7up12ofCb8pH77AI0pSDR59frVFB--
