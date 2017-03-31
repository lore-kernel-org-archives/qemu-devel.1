Received: from eggs.gnu.org ([2001:4830:134:3::10]:48307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cu0Zr-0001so-D3
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cu0Zn-0006mi-Cd
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:43:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cu0Zn-0006mW-2j
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:43:07 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
Date: Fri, 31 Mar 2017 19:43:02 +0200
MIME-Version: 1.0
In-Reply-To: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iDA93gFdmmLgivOAppBDSuBBts8LQqTEs"
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iDA93gFdmmLgivOAppBDSuBBts8LQqTEs
From: Max Reitz <mreitz@redhat.com>
To: Ciprian Barbu <Ciprian.Barbu@enea.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>,
 Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 svc-armband <armband@enea.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
In-Reply-To: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 18:03, Ciprian Barbu wrote:
> Hello,
>=20
> Similar to the other thread about possible regression with rbd, there m=
ight be a regression with nbd.
> This time we are launching an instance from an image (not volume) and t=
ry to live migrate it:
>=20
> nova live-migration <test_instance>
>=20
> The nova-compute service complains with:
>=20
> 2017-03-31 15:32:56.179 7806 INFO nova.virt.libvirt.driver [req-15d79cb=
e-5956-4738-92df-3624e6b993ee d795de59fb9a4ea38776a11d20ae8469 cee03e7488=
1f4ccba3b83345fb652b2c - - -] [instance: 6a04508f-5d79-4582-8e2c-4cc36875=
3f6c] Migration running for 0 secs, memory 100% remaining; (bytes process=
ed=3D0, remaining=3D0, total=3D0)
> 2017-03-31 15:32:58.029 7806 WARNING stevedore.named [req-73bc0113-5555=
-4dd8-8903-d3540cc61b47 b9fbceeadd2d4d1bab9c90ae104db1f7 7e7db99b32c64671=
84701e9a0c2f1de7 - - -] Could not load instance_network_info
> 2017-03-31 15:32:59.038 7806 ERROR nova.virt.libvirt.driver [req-15d79c=
be-5956-4738-92df-3624e6b993ee d795de59fb9a4ea38776a11d20ae8469 cee03e748=
81f4ccba3b83345fb652b2c - - -] [instance: 6a04508f-5d79-4582-8e2c-4cc3687=
53f6c] Live Migration failure: internal error: unable to execute QEMU com=
mand 'nbd-server-add': Conflicts with use by drive-virtio-disk0 as 'root'=
, which does not allow 'write' on #block143
> 2017-03-31 15:32:59.190 7806 ERROR nova.virt.libvirt.driver [req-15d79c=
be-5956-4738-92df-3624e6b993ee d795de59fb9a4ea38776a11d20ae8469 cee03e748=
81f4ccba3b83345fb652b2c - - -] [instance: 6a04508f-5d79-4582-8e2c-4cc3687=
53f6c] Migration operation has aborted
>=20
> I will try and bisect it myself, but I thought I would paste this here =
first, just so you know there is this issue too.

Well, I already know the commit in question. It's
8a7ce4f9338c475df1afc12502af704e4300a3e0 ("nbd/server: Use real
permissions for NBD exports").

Whether this is a bug depends on the standpoint. I would very much
consider it a bug fix because as of this commit you can no longer create
a writable NBD server on a block device that is in use by a guest device
without the guest device being aware of this.

The problem is that the functionality to "make" the guest device "aware"
of it was introduced only a couple of commits before, and it's called
"share-rw".

So this doesn't work:

$ x86_64-softmmu/qemu-system-x86_64 \
    -blockdev node-name=3Dimage,driver=3Dqcow2,\
file.driver=3Dfile,file.filename=3Dfoo.qcow2 \
    -device virtio-blk,drive=3Dimage \
    -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 92, "minor": 8, "major": 2},
"package": " (v2.8.0-2038-g6604c893d0)"}, "capabilities": []}}
{'execute':'qmp_capabilities'}
{"return": {}}
{'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data':{=
'host':'localhost','port':'10809'}}}}
{"return": {}}
{'execute':'nbd-server-add','arguments':{'device':'image','writable':true=
}}
{"error": {"class": "GenericError", "desc": "Conflicts with use by
/machine/peripheral-anon/device[0]/virtio-backend as 'root', which does
not allow 'write' on image"}

But this works:

$ x86_64-softmmu/qemu-system-x86_64 \
    -blockdev node-name=3Dimage,driver=3Dqcow2,\
file.driver=3Dfile,file.filename=3Dfoo.qcow2 \
    -device virtio-blk,drive=3Dimage,share-rw=3Don \
    -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 92, "minor": 8, "major": 2},
"package": " (v2.8.0-2038-g6604c893d0)"}, "capabilities": []}}
{'execute':'qmp_capabilities'}
{"return": {}}
{'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data':{=
'host':'localhost','port':'10809'}}}}
{"return": {}}
{'execute':'nbd-server-add','arguments':{'device':'image','writable':true=
}}
{"return": {}}

(The difference is the share-rw=3Don in the -device parameter.)


So in theory all that's necessary is to set share-rw=3Don for the device
in the management layer. But I'm not sure whether that's practical.

As for just allowing the NBD server write access to the device... To me
that appears pretty difficult from an implementation perspective. We
assert that nobody can write without having requested write access and
we make sure that nobody can request write access without it being
allowed. Making an exception for NBD seems very difficult and would
probably mean we'd have to drop the assertion for write accesses altogeth=
er.

Max


--iDA93gFdmmLgivOAppBDSuBBts8LQqTEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljelSYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfhoIAIXL+x75CLbGBuykGpZCl5tYN4vR1IKW
EEg9r8HIPmtalRCfq7I4TDOhJvAM3ortlMwwFeHUTrr7D8/ggJIYUGyQnZUBGibj
VNWTBxHjlWfjjk27tPsN/h2Vk7ozYrUNjxV31sSDpXrjmrvCJ/EvxgQyl6V8nR73
0nO3gQcGJ4Zth+ExS2bV9AOnfeGw0wOXqx9IpV9+qwYN9BL17cHJMVQEPbXCEsSb
4cJaIYDpHadW3fPFllyIYGIh6qStY3qeDKu/6KCylq+lpR6EdjuXYcV7dIrc0Pr1
1pbnFy+gDAk0tmBB9keFLPvzESDwn+yWvJuRx+TZ1UTsFQEMjwxol1I=
=yZiK
-----END PGP SIGNATURE-----

--iDA93gFdmmLgivOAppBDSuBBts8LQqTEs--
