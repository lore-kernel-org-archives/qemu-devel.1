Received: from eggs.gnu.org ([2001:4830:134:3::10]:52404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dy0ZN-0000Nb-8c
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dy0ZK-0006JG-6Q
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dy0ZJ-0006Iv-Ta
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:03:26 -0400
References: <20170929033844.26935-1-peterx@redhat.com>
	<150665750396.84.2688523110192906870@b58463cdfd5f>
	<20170929041433.GA29131@pxdev.xzpeter.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ef3d76b-ddd8-7c6a-e934-1fb84de2b35f@redhat.com>
Date: Fri, 29 Sep 2017 14:03:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170929041433.GA29131@pxdev.xzpeter.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FMt8eUGP6FO4tlL8UHmkF7oMTTTFMfWL4"
Subject: Re: [Qemu-devel] [RFC v2 00/22] QMP: out-of-band (OOB) execution
 support
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, famz@redhat.com, quintela@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, shajnocz@redhat.com, pbonzini@redhat.com, marcandre.lureau@gmail.com, dgilbert@redhat.com
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FMt8eUGP6FO4tlL8UHmkF7oMTTTFMfWL4
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, famz@redhat.com, quintela@redhat.com,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com, shajnocz@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@gmail.com, dgilbert@redhat.com
Message-ID: <1ef3d76b-ddd8-7c6a-e934-1fb84de2b35f@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 00/22] QMP: out-of-band (OOB) execution
 support
References: <20170929033844.26935-1-peterx@redhat.com>
 <150665750396.84.2688523110192906870@b58463cdfd5f>
 <20170929041433.GA29131@pxdev.xzpeter.org>
In-Reply-To: <20170929041433.GA29131@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/28/2017 11:14 PM, Peter Xu wrote:
> On Thu, Sep 28, 2017 at 08:58:25PM -0700, no-reply@patchew.org wrote:
>> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c: In function =E2=80=
=98monitor_io_thread_init=E2=80=99:
>> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4286:32: error: imp=
licit declaration of function =E2=80=98iothread_create=E2=80=99 [-Werror=3D=
implicit-function-declaration]
>>      mon_global.mon_io_thread =3D iothread_create("monitor_io_thr",
>>                                 ^~~~~~~~~~~~~~~
>> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4286:5: error: nest=
ed extern declaration of =E2=80=98iothread_create=E2=80=99 [-Werror=3Dnes=
ted-externs]

>=20
> This is because the iothread series that this series used has not yet
> been pushed to master.

In which case, you can add a 'Based-on: <message-id>' tag in your cover
letter of this series to tell patchew to not try this series unless it
applies all Based-on series first.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FMt8eUGP6FO4tlL8UHmkF7oMTTTFMfWL4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnOmPIACgkQp6FrSiUn
Q2qylwf/apgw1U1Ed7koQSrUdvjYm2raEUKBkN/fWe3dHXAGWFOcNNd/LjXpbdLS
sqg4EyJv1oBDnEOFHhqlKcBYtxCgBnEv8lCHAVh0/KvUuZFIsQ8JumdVuihWz2HB
R19iYO16KwCCqqJW4djg9wpIIrGoEDXDGx5/EEjbC71b91VU1cpLbiBna4rKwB17
G5bRPoJICaw1jHkj4od04wmEp4J1UfNH9eqAee2EVpiEZ9fkpStuJZLE+v44UD6n
4k+eg3dpAVj738vnj9ZDww0eNhTg3ZIZx8BE3MnMmIOiJQclia5A7XaECfwdwbOL
ppjIBXacriaYIguiCroibwwEhc2LaA==
=xaGA
-----END PGP SIGNATURE-----

--FMt8eUGP6FO4tlL8UHmkF7oMTTTFMfWL4--
