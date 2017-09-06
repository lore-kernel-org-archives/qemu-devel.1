Received: from eggs.gnu.org ([2001:4830:134:3::10]:54649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpdQ4-0004WH-Rf
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpdPv-0001KQ-Gg
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:43:16 -0400
References: <cover.1504112256.git.jcody@redhat.com>
	<fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
	<20170906130041.GI3753@dhcp-200-186.str.redhat.com>
	<20170906150221.GB7570@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f28c0ee8-68e5-34f6-3f92-2bdcce159bc8@redhat.com>
Date: Wed, 6 Sep 2017 11:42:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170906150221.GB7570@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7anVeBFRGcUSvcc35oTmLuCgAlMUa75gx"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/3] block-jobs: Optionally
 unregister live block operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, mrezanin@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7anVeBFRGcUSvcc35oTmLuCgAlMUa75gx
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com,
 mrezanin@redhat.com
Message-ID: <f28c0ee8-68e5-34f6-3f92-2bdcce159bc8@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/3] block-jobs: Optionally
 unregister live block operations
References: <cover.1504112256.git.jcody@redhat.com>
 <fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
 <20170906130041.GI3753@dhcp-200-186.str.redhat.com>
 <20170906150221.GB7570@localhost.localdomain>
In-Reply-To: <20170906150221.GB7570@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 10:02 AM, Eduardo Habkost wrote:
> On Wed, Sep 06, 2017 at 03:00:41PM +0200, Kevin Wolf wrote:
>> Am 30.08.2017 um 19:01 hat Jeff Cody geschrieben:
>>> From: Jeffrey Cody <jcody@redhat.com>
>>>
>>> If configured without live block operations enabled, unregister the
>>> live block operation commands.
>>>
>>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>>
>> How sure are we that libvirt will like a qemu that advertises these
>> commands in the schema, but doesn't actually provide them?
>=20
> If libvirt wants to know if a command is available, it uses
> 'query-commands', not 'query-qmp-schema'.
>=20
> The only query-qmp-schema elements used by latest libvirt are
> gluster-related blockdev-add options (see
> libvirt/src/qemu/qemu_capabilities.c:virQEMUCapsQMPSchemaQueries]]).

Indeed, libvirt is currently just fine with the fact that query-commands
introspection hides disabled commands, even if they are still leaked in
query-qmp-schema.  Besides, Marc-Andre's work on adding #if support to
QAPI should probably also land in 2.11, at which point the hack goes
away (because then we ARE properly hiding things from the schema
introspection).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7anVeBFRGcUSvcc35oTmLuCgAlMUa75gx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwJYoACgkQp6FrSiUn
Q2rqsgf/VTihbAou+M4jneRQtRhbSVOwjQiRahKQot0TFp6Qw3Wug4qTTeOc9D6O
S97m/Z1rNKZveyghSjHsxJ1fiYd9Jqc6b65cTucUt43vHSkbC7Lpxz2F42BUCYEE
TTi9fTlji4uMoHx3MC7o7x+DV46LTydudG0ax3OaqSGRETz5exPuXw9wIZniMC+p
Ams4wonTh/SMIf7VXoQCHZxxm6PhLNjc6O7PIFtrmKMjIljFjxBtbqkX47eJMxLX
7Gv1Vm0g5M2WEmSwuHW3zPSC9maGSFvdazp5W3D5MMIIWFjN8ZhFshq96zUriagL
QyNwM5QcJsFcS96DaCUk5CSeSwkDnQ==
=Ajsh
-----END PGP SIGNATURE-----

--7anVeBFRGcUSvcc35oTmLuCgAlMUa75gx--
