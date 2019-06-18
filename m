Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CADC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 13:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8A52070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 13:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8A52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57852 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdDz3-0002jM-NU
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 09:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45848)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdDwu-0001zg-Cy
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 09:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdDws-0004nS-MT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 09:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdDwo-0004Tq-TL; Tue, 18 Jun 2019 09:14:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A276300156D;
 Tue, 18 Jun 2019 13:14:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
 [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83BD7176C2;
 Tue, 18 Jun 2019 13:14:32 +0000 (UTC)
To: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20190618092403.30006-1-ptoscano@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
Date: Tue, 18 Jun 2019 15:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618092403.30006-1-ptoscano@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HsFBjai7Sm2iLqAVMvNOGQSg1cDH86OCL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 18 Jun 2019 13:14:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v10] ssh: switch from libssh2 to libssh
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, fam@euphon.net, philmd@redhat.com, rjones@redhat.com,
 sw@weilnetz.de, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HsFBjai7Sm2iLqAVMvNOGQSg1cDH86OCL
Content-Type: multipart/mixed; boundary="KPWJKOU4limqbjOnX6zmdMKb2aOBJSpcl";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: rjones@redhat.com, kwolf@redhat.com, philmd@redhat.com,
 alex.bennee@linaro.org, fam@euphon.net, sw@weilnetz.de
Message-ID: <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
Subject: Re: [PATCH v10] ssh: switch from libssh2 to libssh
References: <20190618092403.30006-1-ptoscano@redhat.com>
In-Reply-To: <20190618092403.30006-1-ptoscano@redhat.com>

--KPWJKOU4limqbjOnX6zmdMKb2aOBJSpcl
Content-Type: multipart/mixed;
 boundary="------------67CD08141485A9DD5A8CD036"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------67CD08141485A9DD5A8CD036
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.06.19 11:24, Pino Toscano wrote:
> Rewrite the implementation of the ssh block driver to use libssh instea=
d
> of libssh2.  The libssh library has various advantages over libssh2:
> - easier API for authentication (for example for using ssh-agent)
> - easier API for known_hosts handling
> - supports newer types of keys in known_hosts
>=20
> Use APIs/features available in libssh 0.8 conditionally, to support
> older versions (which are not recommended though).
>=20
> Adjust the tests according to the different error message, and to the
> newer host keys (ed25519) that are used by default with OpenSSH >=3D 6.=
7
> and libssh >=3D 0.7.0.
>=20
> Adjust the various Docker/Travis scripts to use libssh when available
> instead of libssh2. The mingw/mxe testing is dropped for now, as there
> are no packages for it.
>=20
> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>=20
> Changes from v9:
> - restored "default" case in the server status switch for libssh < 0.8.=
0
> - print the host key type & fingerprint on mismatch with known_hosts
> - improve/fix message for failed socket_set_nodelay()
> - reset s->sock properly
>=20
> Changes from v8:
> - use a newer key type in iotest 207
> - improve the commit message
>=20
> Changes from v7:
> - #if HAVE_LIBSSH_0_8 -> #ifdef HAVE_LIBSSH_0_8
> - ptrdiff_t -> size_t
>=20
> Changes from v6:
> - fixed few checkpatch style issues
> - detect libssh 0.8 via symbol detection
> - adjust travis/docker test material
> - remove dead "default" case in a switch
> - use variables for storing MIN() results
> - adapt a documentation bit
>=20
> Changes from v5:
> - adapt to newer tracing APIs
> - disable ssh compression (mimic what libssh2 does by default)
> - use build time checks for libssh 0.8, and use newer APIs directly
>=20
> Changes from v4:
> - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
> - fix few return code checks
> - remove now-unused parameters in few internal functions
> - allow authentication with "none" method
> - switch to unsigned int for the port number
> - enable TCP_NODELAY on the socket
> - fix one reference error message in iotest 207
>=20
> Changes from v3:
> - fix socket cleanup in connect_to_ssh()
> - add comments about the socket cleanup
> - improve the error reporting (closer to what was with libssh2)
> - improve EOF detection on sftp_read()
>=20
> Changes from v2:
> - used again an own fd
> - fixed co_yield() implementation
>=20
> Changes from v1:
> - fixed jumbo packets writing
> - fixed missing 'err' assignment
> - fixed commit message
>=20
>  .travis.yml                                   |   4 +-
>  block/Makefile.objs                           |   6 +-
>  block/ssh.c                                   | 665 ++++++++++--------=

>  block/trace-events                            |  14 +-
>  configure                                     |  65 +-
>  docs/qemu-block-drivers.texi                  |   2 +-
>  .../dockerfiles/debian-win32-cross.docker     |   1 -
>  .../dockerfiles/debian-win64-cross.docker     |   1 -
>  tests/docker/dockerfiles/fedora.docker        |   4 +-
>  tests/docker/dockerfiles/ubuntu.docker        |   2 +-
>  tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
>  tests/qemu-iotests/207                        |   4 +-
>  tests/qemu-iotests/207.out                    |   2 +-
>  13 files changed, 423 insertions(+), 349 deletions(-)

[...]

> diff --git a/block/ssh.c b/block/ssh.c
> index 6da7b9cbfe..644ae8b82c 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c

[...]

> +    case SSH_SERVER_KNOWN_CHANGED:
> +        ret =3D -EINVAL;
> +        r =3D ssh_get_publickey(s->session, &pubkey);
> +        if (r =3D=3D 0) {
> +            r =3D ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HASH_SH=
A1,
> +                                       &server_hash, &server_hash_len)=
;
> +            pubkey_type =3D ssh_key_type(pubkey);
> +            ssh_key_free(pubkey);
> +        }
> +        if (r =3D=3D 0) {
> +            fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_HAS=
H_SHA1,
> +                                                   server_hash,
> +                                                   server_hash_len);
> +            ssh_clean_pubkey_hash(&server_hash);
> +        }
> +        if (fingerprint) {
> +            error_setg(errp,
> +                       "host key (%s key with fingerprint %s) does not=
 match "
> +                       "the one in known_hosts",
> +                       ssh_key_type_to_char(pubkey_type), fingerprint)=
;
> +            ssh_string_free_char(fingerprint);
> +        } else  {
> +            error_setg(errp, "host key does not match the one in known=
_hosts");
> +        }

Usually I=E2=80=99d say that more information can=E2=80=99t be bad.  But =
here I don=E2=80=99t
see how this additional information is useful.  known_hosts contains
base64-encoded full public keys.  This only prints the SHA-1 digest.
The user cannot add that to known_hosts, or easily scan known_hosts to
see whether it perhaps belongs to some other hosts (maybe because DHCP
scrambled something).

Actually, even if this printed the base64 representation of the full
key, the user probably wouldn=E2=80=99t just add that to known_hosts or d=
o
anything with it.  They=E2=80=99ll debug the problem with other tools.

So I don=E2=80=99t think this new information is really useful...?


(Hmm, I don=E2=80=99t know if this is a response to my =E2=80=9CBut the s=
pecification
requires a warning!!1!=E2=80=9D, but if so, I was actually not referring =
to more
information but to this:

$ ssh 192.168.0.12
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack=
)!
It is also possible that a host key has just been changed.


I mean, I was also only half-serious.  I should be serious because the
libssh specification requires us to print some warning like that, but,
well.  Yes, I=E2=80=99ll stop mumbling about this stuff now.)

[...]

> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
> index b3816136f7..774eb5f2a9 100755
> --- a/tests/qemu-iotests/207
> +++ b/tests/qemu-iotests/207
> @@ -111,7 +111,7 @@ with iotests.FilePath('t.img') as disk_path, \
>      iotests.img_info_log(remote_path)
> =20
>      md5_key =3D subprocess.check_output(
> -        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | '=
 +
> +        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v "\=
\^#" | ' +
>          'cut -d" " -f3 | base64 -d | md5sum -b | cut -d" " -f1',
>          shell=3DTrue).rstrip().decode('ascii')
> =20
> @@ -149,7 +149,7 @@ with iotests.FilePath('t.img') as disk_path, \
>      iotests.img_info_log(remote_path)
> =20
>      sha1_key =3D subprocess.check_output(
> -        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | '=
 +
> +        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v "\=
\^#" | ' +
>          'cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1',
>          shell=3DTrue).rstrip().decode('ascii')

I=E2=80=99ve attached a diff that makes this test pass for me.  Maybe als=
o for
you and Philippe.

Max

--------------67CD08141485A9DD5A8CD036
Content-Type: text/x-patch;
 name="207.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="207.diff"

diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index 774eb5f2a9..ec8c1d06f0 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -110,12 +110,49 @@ with iotests.FilePath('t.img') as disk_path, \
=20
     iotests.img_info_log(remote_path)
=20
-    md5_key =3D subprocess.check_output(
-        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v "\\^=
#" | ' +
-        'cut -d" " -f3 | base64 -d | md5sum -b | cut -d" " -f1',
-        shell=3DTrue).rstrip().decode('ascii')
+    keys =3D subprocess.check_output(
+        'ssh-keyscan 127.0.0.1 2>/dev/null | grep -v "\\^#" | ' +
+        'cut -d" " -f3',
+        shell=3DTrue).rstrip().decode('ascii').split('\n')
+
+    # Mappings of base64 representations to digests
+    md5_keys =3D {}
+    sha1_keys =3D {}
+
+    for key in keys:
+        md5_keys[key] =3D subprocess.check_output(
+            'echo %s | base64 -d | md5sum -b | cut -d" " -f1' % key,
+            shell=3DTrue).rstrip().decode('ascii')
+
+        sha1_keys[key] =3D subprocess.check_output(
+            'echo %s | base64 -d | sha1sum -b | cut -d" " -f1' % key,
+            shell=3DTrue).rstrip().decode('ascii')
=20
     vm.launch()
+
+    # Find correct key first
+    matching_key =3D None
+    for key in keys:
+        result =3D vm.qmp('blockdev-add',
+                        driver=3D'ssh', node_name=3D'node0', path=3Ddisk=
_path,
+                        server=3D{
+                             'host': '127.0.0.1',
+                             'port': '22',
+                        }, host_key_check=3D{
+                             'mode': 'hash',
+                             'type': 'md5',
+                             'hash': md5_keys[key],
+                        })
+
+        if 'error' not in result:
+            vm.qmp('blockdev-del', node_name=3D'node0')
+            matching_key =3D key
+            break
+
+    if matching_key is None:
+        vm.shutdown()
+        iotests.notrun('Did not find a key that fits 127.0.0.1')
+
     blockdev_create(vm, { 'driver': 'ssh',
                           'location': {
                               'path': disk_path,
@@ -140,7 +177,7 @@ with iotests.FilePath('t.img') as disk_path, \
                               'host-key-check': {
                                   'mode': 'hash',
                                   'type': 'md5',
-                                  'hash': md5_key,
+                                  'hash': md5_keys[matching_key],
                               }
                           },
                           'size': 8388608 })
@@ -148,11 +185,6 @@ with iotests.FilePath('t.img') as disk_path, \
=20
     iotests.img_info_log(remote_path)
=20
-    sha1_key =3D subprocess.check_output(
-        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v "\\^=
#" | ' +
-        'cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1',
-        shell=3DTrue).rstrip().decode('ascii')
-
     vm.launch()
     blockdev_create(vm, { 'driver': 'ssh',
                           'location': {
@@ -178,7 +210,7 @@ with iotests.FilePath('t.img') as disk_path, \
                               'host-key-check': {
                                   'mode': 'hash',
                                   'type': 'sha1',
-                                  'hash': sha1_key,
+                                  'hash': sha1_keys[matching_key],
                               }
                           },
                           'size': 4194304 })

--------------67CD08141485A9DD5A8CD036--

--KPWJKOU4limqbjOnX6zmdMKb2aOBJSpcl--

--HsFBjai7Sm2iLqAVMvNOGQSg1cDH86OCL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0I47cACgkQ9AfbAGHV
z0DDzQf/fJr5X69jJydoWJXgvOsXAEGsJoMMZD5O3Qa3+3/EQ5/6hfGjL/ktFeww
b5IvbZ/va5BJE2Lrdb0Yd/8fuMAbIa6neGw5ng7kVQhyN33/bmjCBIfyyW5vWEC/
Y1KxZW84K+ljHxuuPnJlhQOxqvU/usW2g6nOxLWJshYy2H6ntdenTh9/brJpIdGN
sKZFh4kUS6YFPUmJMBL4w+C339RDiwc38UW16Fif0Es3qRXmuXXUrX6cJEhhaFcP
mkoHQakCdIh3fAHSqtBz3P+MQ6yx0hv8hhicsXnwb6CTQguHF9sfQ9Kkgpc7swmy
FR3mQndRfCWN5EI4WSc5ElM0+kJSRg==
=ZdmH
-----END PGP SIGNATURE-----

--HsFBjai7Sm2iLqAVMvNOGQSg1cDH86OCL--

