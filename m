Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8A1C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48292083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48292083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdtkv-0006Au-UV
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53681)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1hdti4-0004Lz-7p
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hdti0-00018v-1Z
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:50:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hdthr-0000fi-JB; Thu, 20 Jun 2019 05:50:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95D3830821C1;
 Thu, 20 Jun 2019 09:49:55 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (ovpn-204-93.brq.redhat.com
 [10.40.204.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53D5C60477;
 Thu, 20 Jun 2019 09:49:49 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Date: Thu, 20 Jun 2019 11:49:42 +0200
Message-ID: <3681094.1Qnffhumos@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
References: <20190618092403.30006-1-ptoscano@redhat.com>
 <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2879091.VcAYFig8vX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 20 Jun 2019 09:49:55 +0000 (UTC)
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, rjones@redhat.com, sw@weilnetz.de,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart2879091.VcAYFig8vX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, 18 June 2019 15:14:30 CEST Max Reitz wrote:
> On 18.06.19 11:24, Pino Toscano wrote:
> > Rewrite the implementation of the ssh block driver to use libssh instead
> > of libssh2.  The libssh library has various advantages over libssh2:
> > - easier API for authentication (for example for using ssh-agent)
> > - easier API for known_hosts handling
> > - supports newer types of keys in known_hosts
> >=20
> > Use APIs/features available in libssh 0.8 conditionally, to support
> > older versions (which are not recommended though).
> >=20
> > Adjust the tests according to the different error message, and to the
> > newer host keys (ed25519) that are used by default with OpenSSH >=3D 6.7
> > and libssh >=3D 0.7.0.
> >=20
> > Adjust the various Docker/Travis scripts to use libssh when available
> > instead of libssh2. The mingw/mxe testing is dropped for now, as there
> > are no packages for it.
> >=20
> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >=20
> > Changes from v9:
> > - restored "default" case in the server status switch for libssh < 0.8.0
> > - print the host key type & fingerprint on mismatch with known_hosts
> > - improve/fix message for failed socket_set_nodelay()
> > - reset s->sock properly
> >=20
> > Changes from v8:
> > - use a newer key type in iotest 207
> > - improve the commit message
> >=20
> > Changes from v7:
> > - #if HAVE_LIBSSH_0_8 -> #ifdef HAVE_LIBSSH_0_8
> > - ptrdiff_t -> size_t
> >=20
> > Changes from v6:
> > - fixed few checkpatch style issues
> > - detect libssh 0.8 via symbol detection
> > - adjust travis/docker test material
> > - remove dead "default" case in a switch
> > - use variables for storing MIN() results
> > - adapt a documentation bit
> >=20
> > Changes from v5:
> > - adapt to newer tracing APIs
> > - disable ssh compression (mimic what libssh2 does by default)
> > - use build time checks for libssh 0.8, and use newer APIs directly
> >=20
> > Changes from v4:
> > - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
> > - fix few return code checks
> > - remove now-unused parameters in few internal functions
> > - allow authentication with "none" method
> > - switch to unsigned int for the port number
> > - enable TCP_NODELAY on the socket
> > - fix one reference error message in iotest 207
> >=20
> > Changes from v3:
> > - fix socket cleanup in connect_to_ssh()
> > - add comments about the socket cleanup
> > - improve the error reporting (closer to what was with libssh2)
> > - improve EOF detection on sftp_read()
> >=20
> > Changes from v2:
> > - used again an own fd
> > - fixed co_yield() implementation
> >=20
> > Changes from v1:
> > - fixed jumbo packets writing
> > - fixed missing 'err' assignment
> > - fixed commit message
> >=20
> >  .travis.yml                                   |   4 +-
> >  block/Makefile.objs                           |   6 +-
> >  block/ssh.c                                   | 665 ++++++++++--------
> >  block/trace-events                            |  14 +-
> >  configure                                     |  65 +-
> >  docs/qemu-block-drivers.texi                  |   2 +-
> >  .../dockerfiles/debian-win32-cross.docker     |   1 -
> >  .../dockerfiles/debian-win64-cross.docker     |   1 -
> >  tests/docker/dockerfiles/fedora.docker        |   4 +-
> >  tests/docker/dockerfiles/ubuntu.docker        |   2 +-
> >  tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
> >  tests/qemu-iotests/207                        |   4 +-
> >  tests/qemu-iotests/207.out                    |   2 +-
> >  13 files changed, 423 insertions(+), 349 deletions(-)
>=20
> [...]
>=20
> > diff --git a/block/ssh.c b/block/ssh.c
> > index 6da7b9cbfe..644ae8b82c 100644
> > --- a/block/ssh.c
> > +++ b/block/ssh.c
>=20
> [...]
>=20
> > +    case SSH_SERVER_KNOWN_CHANGED:
> > +        ret =3D -EINVAL;
> > +        r =3D ssh_get_publickey(s->session, &pubkey);
> > +        if (r =3D=3D 0) {
> > +            r =3D ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HASH_SH=
A1,
> > +                                       &server_hash, &server_hash_len);
> > +            pubkey_type =3D ssh_key_type(pubkey);
> > +            ssh_key_free(pubkey);
> > +        }
> > +        if (r =3D=3D 0) {
> > +            fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_HAS=
H_SHA1,
> > +                                                   server_hash,
> > +                                                   server_hash_len);
> > +            ssh_clean_pubkey_hash(&server_hash);
> > +        }
> > +        if (fingerprint) {
> > +            error_setg(errp,
> > +                       "host key (%s key with fingerprint %s) does not=
 match "
> > +                       "the one in known_hosts",
> > +                       ssh_key_type_to_char(pubkey_type), fingerprint);
> > +            ssh_string_free_char(fingerprint);
> > +        } else  {
> > +            error_setg(errp, "host key does not match the one in known=
_hosts");
> > +        }
>=20
> Usually I=E2=80=99d say that more information can=E2=80=99t be bad.  But =
here I don=E2=80=99t
> see how this additional information is useful.  known_hosts contains
> base64-encoded full public keys.  This only prints the SHA-1 digest.

Note that SHA-1 is printed with libssh < 0.8; with libssh >=3D 0.8 SHA-256
is used instead.

> The user cannot add that to known_hosts, or easily scan known_hosts to
> see whether it perhaps belongs to some other hosts (maybe because DHCP
> scrambled something).
>=20
> Actually, even if this printed the base64 representation of the full
> key, the user probably wouldn=E2=80=99t just add that to known_hosts or do
> anything with it.  They=E2=80=99ll debug the problem with other tools.
>=20
> So I don=E2=80=99t think this new information is really useful...?

When this situation happens with openssh, the big scary message prints
three things:
1) the fingerprint of the server
2) the line of the server in the known_hosts file
3) how to remove the keys of the server from known_hosts, i.e. a
   copy-paste'able `ssh-keygen -R host`

Here I'm doing only (1).  Also, the current libssh2 driver does
something else, i.e. print the base64/printable representation of the
server key in known_hosts.

> (Hmm, I don=E2=80=99t know if this is a response to my =E2=80=9CBut the s=
pecification
> requires a warning!!1!=E2=80=9D, but if so, I was actually not referring =
to more
> information but to this:

You mentioned this few times: can you please point me to this bit?
I read few RFCs related to ssh, and I did not find this information...

> $ ssh 192.168.0.12
> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
> Someone could be eavesdropping on you right now (man-in-the-middle attack=
)!
> It is also possible that a host key has just been changed.
>=20
>=20
> I mean, I was also only half-serious.  I should be serious because the
> libssh specification requires us to print some warning like that, but,
> well.  Yes, I=E2=80=99ll stop mumbling about this stuff now.)

To be on the explic side: are you asking to basically put the first 6
lines of the openssh error message (as you quoted them above) as error
message in the ssh driver?
As data point (I know it is not a strong argument), I'll mention that
the current libssh2-based driver does not do that, and (according to my
possibly limited knowledge) there were no problems/complaints about
that.  Sure, improvements are good, I get that, although I do not see
why just changing the underlying implementation of a driver makes an
error message for the same situation immediately no more acceptable.
I'm perfectly fine in improving this in sequent patches, for example --
as I mentioned, the API for this in libssh is sadly not usable, and it
will be usable with the future libssh 0.9.0 (kudos to the libssh guys
for the fast fix).

>=20
> [...]
>=20
> > diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
> > index b3816136f7..774eb5f2a9 100755
> > --- a/tests/qemu-iotests/207
> > +++ b/tests/qemu-iotests/207
> > @@ -111,7 +111,7 @@ with iotests.FilePath('t.img') as disk_path, \
> >      iotests.img_info_log(remote_path)
> > =20
> >      md5_key =3D subprocess.check_output(
> > -        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | '=
 +
> > +        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v "\=
\^#" | ' +
> >          'cut -d" " -f3 | base64 -d | md5sum -b | cut -d" " -f1',
> >          shell=3DTrue).rstrip().decode('ascii')
> > =20
> > @@ -149,7 +149,7 @@ with iotests.FilePath('t.img') as disk_path, \
> >      iotests.img_info_log(remote_path)
> > =20
> >      sha1_key =3D subprocess.check_output(
> > -        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" | '=
 +
> > +        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v "\=
\^#" | ' +
> >          'cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1',
> >          shell=3DTrue).rstrip().decode('ascii')
>=20
> I=E2=80=99ve attached a diff that makes this test pass for me.  Maybe als=
o for
> you and Philippe.

It works for me as well, thanks!
I squashed it locally, and amended the commit message to mention this
with credits for you.

Thanks,
=2D-=20
Pino Toscano
--nextPart2879091.VcAYFig8vX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl0LVrYACgkQw9FMLZhk
N80oNQ//RtH+AdHbnoAvipkdcGu5WVyphtI1Pj+SIl5GdfjwEi5gwq0lOev/9+a4
boKAAW5rTWaAHuABhJFjpnH5RVazGS99wTLRhiJNpKOOHSN0wmyD5wNxmobHW8gs
BWGWJ7cOdb4cg9+my4WuR6d2TPygEzu7tSkDCb7x6LjbzRrT8OqqSXgnJTkEPd/d
d77FAUMrxcb1kEubF9eNmaX/0gqkglYz6wIVSBJD71gkU6mAyQzSPllzr3r6jzpF
mcS7blzbP7LUb03JCQMBuIruowVNuUrH17QeQ5ZfVCgsafMjn2O1fum4ctXIBn0j
6GRZNPH3Ej3POeciOUITHSKW3Ld/oQLh1o+0LFkWhQ5JEuKAihc94/4F7U0iKTZl
eyo6TUpap4e++s5po4BehpWE+TlzbrR0eLv54yNB2AitVrsqPdERv8RTfu5vF7VZ
JRP/ewo3DzMOw3GArnIm5KXXM10CGhdtvvFTmDSVyk/uxnXrHswa0GO5J6vcAK0H
fOHYHUB64c2+8Ha2FjpTyJhh6ERh+KD4eEFcoG/bl3rl01r4V0apcZH6da31AE8k
UOvWjZdEFBgHFZkZxWwf0RMzJ/88HC0ew57C+rAmbqW5dkleeqhitpzCZgRDpZ+X
VGVjZIL9xp41dlWmFRGtYPz9NOqgPkQ94vKFMJjkwYshr90swl8=
=jiBF
-----END PGP SIGNATURE-----

--nextPart2879091.VcAYFig8vX--




