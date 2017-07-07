Received: from eggs.gnu.org ([2001:4830:134:3::10]:54479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTaDk-0004Ld-Vy
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTaDj-00084y-VO
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:51:25 -0400
References: <20170707203049.534-1-eblake@redhat.com>
	<20170707203049.534-4-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0976309-fe36-e624-c6bd-36f4700694d8@redhat.com>
Date: Fri, 7 Jul 2017 15:51:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170707203049.534-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AXSIin7vA3uj1s17eOD2s1wupmLFAwmFI"
Subject: Re: [Qemu-devel] [PATCH v5 3/9] nbd: Expose and debug more NBD
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, marcandre.lureau@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AXSIin7vA3uj1s17eOD2s1wupmLFAwmFI
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 den@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Message-ID: <b0976309-fe36-e624-c6bd-36f4700694d8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/9] nbd: Expose and debug more NBD
 constants
References: <20170707203049.534-1-eblake@redhat.com>
 <20170707203049.534-4-eblake@redhat.com>
In-Reply-To: <20170707203049.534-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2017 03:30 PM, Eric Blake wrote:
> The NBD protocol has several constants defined in various extensions
> that we are about to implement.  Expose them to the code, along with
> an easy way to map various constants to strings during diagnostic
> messages.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v5: rebase to master, add command name lookup; enough changes that
> R-b is dropped
> v4: new patch

Worth squashing this in:

diff --git i/nbd/client.c w/nbd/client.c
index af2b46d..8dd2d69 100644
--- i/nbd/client.c
+++ w/nbd/client.c
@@ -902,7 +902,8 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest
*request)
     uint8_t buf[NBD_REQUEST_SIZE];

     trace_nbd_send_request(request->from, request->len, request->handle,=

-                           request->flags, request->type);
+                           request->flags, request->type,
+                           nbd_cmd_lookup(request->type));

     stl_be_p(buf, NBD_REQUEST_MAGIC);
     stw_be_p(buf + 4, request->flags);
diff --git i/nbd/trace-events w/nbd/trace-events
index b18d051..74ed3b8 100644
--- i/nbd/trace-events
+++ w/nbd/trace-events
@@ -28,7 +28,7 @@ nbd_client_loop(void) "Doing NBD loop"
 nbd_client_loop_ret(int ret, const char *error) "NBD loop returned %d: %=
s"
 nbd_client_clear_queue(void) "Clearing NBD queue"
 nbd_client_clear_socket(void) "Clearing NBD socket"
-nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t
flags, uint16_t type) "Sending request to server: { .from =3D %" PRIu64",=

=2Elen =3D %" PRIu32 ", .handle =3D %" PRIu64 ", .flags =3D %" PRIx16 ", =
=2Etype =3D
%" PRIu16 " }"
+nbd_send_request(uint64_t from, uint32_t len, uint64_t handle, uint16_t
flags, uint16_t type, const char *name) "Sending request to server: {
=2Efrom =3D %" PRIu64", .len =3D %" PRIu32 ", .handle =3D %" PRIu64 ", .f=
lags =3D
%" PRIx16 ", .type =3D %" PRIu16 " (%s) }"
 nbd_receive_reply(uint32_t magic, int32_t error, uint64_t handle) "Got
reply: { magic =3D 0x%" PRIx32 ", .error =3D % " PRId32 ", handle =3D %"
PRIu64" }"

 # nbd/server.c

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AXSIin7vA3uj1s17eOD2s1wupmLFAwmFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX/RCAAoJEKeha0olJ0NqdyQH/3RNgyX0EsHwjmQLeQ2FgkLG
7ePxnCPmeyram21zKGpQcL4YxcTWB7Gpe77k4gYxvZfkiA6d6aokvznUX5zYoeje
S1bFs1+SamPa/0zEbSQsFmD08RkmxUTWw/zNu9WLhrh8ldNvwa1CdTr6+ZUfK7Dy
SDPDSf/D6sXWyQOS918JZV4K4FtiUrWr9R7uuM6J4A/HgsfL4e/tCeEz4SwvYaQ6
GefjRwLhF13u3/+EueJor2XTVPYQavdICJDc/kCm/doHUxhtjyTdBEGtKmMopF3g
OvHmKJsLqYTAmzIUPxJzOz1hay/bMfSlDWl3gx1A+Lf8RceP42SPchWhpANq9Kg=
=jq+4
-----END PGP SIGNATURE-----

--AXSIin7vA3uj1s17eOD2s1wupmLFAwmFI--
