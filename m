Received: from eggs.gnu.org ([2001:4830:134:3::10]:46249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYpWL-0007bm-IT
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 02:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYpWH-0008I7-MU
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 02:40:01 -0500
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-2-git-send-email-thuth@redhat.com>
	<20170201001028.GA30639@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <632092c8-aedf-c97b-8363-9a65ce86160e@redhat.com>
Date: Wed, 1 Feb 2017 08:39:47 +0100
MIME-Version: 1.0
In-Reply-To: <20170201001028.GA30639@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="sMSLveMd8JEcUo3eQeF8h2Kh2fwlxwGXR"
Subject: Re: [Qemu-devel] [PATCH 1/2] ppc/kvm: Handle the "family" CPU via
 alias instead of registering new types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sMSLveMd8JEcUo3eQeF8h2Kh2fwlxwGXR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 01:10, David Gibson wrote:
> On Tue, Jan 31, 2017 at 02:11:58PM +0100, Thomas Huth wrote:
>> When running with KVM on POWER, we are registering a "family" CPU
>> type for the host CPU that we are running on. For example, on all
>> POWER8-compatible hosts, we register a "POWER8" CPU type, so that
>> you can always start QEMU with "-cpu POWER8" there, without the
>> need to know whether you are running on a POWER8, POWER8E or POWER8NVL=

>> host machine.
>> However, we also have a "POWER8" CPU alias in the ppc_cpu_aliases list=

>> (that is mainly useful for TCG). This leads to two cosmetical drawback=
s:
>> If the user runs QEMU with "-cpu ?", we always claim that POWER8 is an=

>> "alias for POWER8_v2.0" - which is simply not true when running with
>> KVM on POWER. And when using the 'query-cpu-definitions' QMP call,
>> there are currently two entries for "POWER8", one for the alias, and
>> one for the additional registered type.
>> To solve the two problems, we should rather update the "family" alias
>> instead of registering a new types. We then only have one "POWER8"
>> CPU definition around, an alias, which also points to the right
>> destination.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1396536
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Updating the otherwise static table of aliases is kind of ugly, but
> then so is registering an extra full type as we do now.
>=20
> Is this safe to apply without the follow up patch to vl.c.

Yes. It fixes the problem with "query-cpu-definitions" already. You just
need the other patch to get the output of "-cpu ?" right, too.

 Thomas



--sMSLveMd8JEcUo3eQeF8h2Kh2fwlxwGXR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYkZDJAAoJEC7Z13T+cC21EV8QAInJz6kOrJvLxlEQH2ga0Jcd
DQC6tR98QVKkMhJwPWGf91NynjUAKj7wa1Mpp8y2JivohFClUfc+JP2WFEwSPpRP
LrYpJncZ4Z8hmrbFUAN+dMTcFokDYJ5GCnK05VUI3WNPAl/iuNYcLPByxHFidyBZ
7kV9uI52cn+aK99u2xds58lI3J0JG7awKGXzgdZXyad4rlxjCXwrH32XuAlhktiS
NEw94mz2bKgLN9K8Kd7Vzt6Dfne2Y6mRQzdcxok7BeAsNlPKT7oNz0ThsCAAzUJ0
IH6U18b28BDXuOK7F1MiZRjxG3+mEW2mzFGVYRUs4vovMPfX844HIrKwTLIurwpc
eEWU38CqvceX63x0cnvRElJYnIrco69w4UV0iTWxD1R5xobUyMjudWEDBCRb0ZCq
R7Z6DO1wt3HQy9p3ElywRQcF1ZWHNPX3WAEanMsY7pqflV5ZokA28KMbX3sqsdiW
imFe+veArPoL6sBXbopOTdiIFDUQ+5CT0+wNsqTq1g/xQD8h8NyHkkkmPPMbFAyz
yVssEHE61qSv/aZ+1LQzkOV6o6au7OszXZxttq9p1uv7lw71iQHeNFl4x8Usik0h
kN40BXDcO15C49FTBhpPEcmTytTveOULXKiiVEMzHa8Xq9JuxJQ9vR9p1XV8dq7p
aBNTnFafk822iG4kyoeA
=rEI5
-----END PGP SIGNATURE-----

--sMSLveMd8JEcUo3eQeF8h2Kh2fwlxwGXR--
