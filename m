Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BBAC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736AA2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736AA2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he3ow-00044M-F2
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 16:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1he3PT-0007Ei-Q9
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1he3I6-0005h1-6W
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1he3I2-0005XQ-KT; Thu, 20 Jun 2019 16:04:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DDA9368E3;
 Thu, 20 Jun 2019 20:03:57 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (ovpn-204-93.brq.redhat.com
 [10.40.204.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33DB460142;
 Thu, 20 Jun 2019 20:03:50 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Date: Thu, 20 Jun 2019 22:03:45 +0200
Message-ID: <4685183.8apt5qi6oh@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <bca1ddde-652a-11df-5e48-826ab1799d98@redhat.com>
References: <20190618092403.30006-1-ptoscano@redhat.com>
 <3681094.1Qnffhumos@lindworm.usersys.redhat.com>
 <bca1ddde-652a-11df-5e48-826ab1799d98@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3080213.AyQVvb27k6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 20 Jun 2019 20:03:57 +0000 (UTC)
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

--nextPart3080213.AyQVvb27k6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, 20 June 2019 14:58:40 CEST Max Reitz wrote:
> On 20.06.19 11:49, Pino Toscano wrote:
> > On Tuesday, 18 June 2019 15:14:30 CEST Max Reitz wrote:
> >> On 18.06.19 11:24, Pino Toscano wrote:
> >>> Rewrite the implementation of the ssh block driver to use libssh inst=
ead
> >>> of libssh2.  The libssh library has various advantages over libssh2:
> >>> - easier API for authentication (for example for using ssh-agent)
> >>> - easier API for known_hosts handling
> >>> - supports newer types of keys in known_hosts
> >>>
> >>> Use APIs/features available in libssh 0.8 conditionally, to support
> >>> older versions (which are not recommended though).
> >>>
> >>> Adjust the tests according to the different error message, and to the
> >>> newer host keys (ed25519) that are used by default with OpenSSH >=3D =
6.7
> >>> and libssh >=3D 0.7.0.
> >>>
> >>> Adjust the various Docker/Travis scripts to use libssh when available
> >>> instead of libssh2. The mingw/mxe testing is dropped for now, as there
> >>> are no packages for it.
> >>>
> >>> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> >>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>> ---
> >>>
> >>> Changes from v9:
> >>> - restored "default" case in the server status switch for libssh < 0.=
8.0
> >>> - print the host key type & fingerprint on mismatch with known_hosts
> >>> - improve/fix message for failed socket_set_nodelay()
> >>> - reset s->sock properly
> >>>
> >>> Changes from v8:
> >>> - use a newer key type in iotest 207
> >>> - improve the commit message
> >>>
> >>> Changes from v7:
> >>> - #if HAVE_LIBSSH_0_8 -> #ifdef HAVE_LIBSSH_0_8
> >>> - ptrdiff_t -> size_t
> >>>
> >>> Changes from v6:
> >>> - fixed few checkpatch style issues
> >>> - detect libssh 0.8 via symbol detection
> >>> - adjust travis/docker test material
> >>> - remove dead "default" case in a switch
> >>> - use variables for storing MIN() results
> >>> - adapt a documentation bit
> >>>
> >>> Changes from v5:
> >>> - adapt to newer tracing APIs
> >>> - disable ssh compression (mimic what libssh2 does by default)
> >>> - use build time checks for libssh 0.8, and use newer APIs directly
> >>>
> >>> Changes from v4:
> >>> - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
> >>> - fix few return code checks
> >>> - remove now-unused parameters in few internal functions
> >>> - allow authentication with "none" method
> >>> - switch to unsigned int for the port number
> >>> - enable TCP_NODELAY on the socket
> >>> - fix one reference error message in iotest 207
> >>>
> >>> Changes from v3:
> >>> - fix socket cleanup in connect_to_ssh()
> >>> - add comments about the socket cleanup
> >>> - improve the error reporting (closer to what was with libssh2)
> >>> - improve EOF detection on sftp_read()
> >>>
> >>> Changes from v2:
> >>> - used again an own fd
> >>> - fixed co_yield() implementation
> >>>
> >>> Changes from v1:
> >>> - fixed jumbo packets writing
> >>> - fixed missing 'err' assignment
> >>> - fixed commit message
> >>>
> >>>  .travis.yml                                   |   4 +-
> >>>  block/Makefile.objs                           |   6 +-
> >>>  block/ssh.c                                   | 665 ++++++++++------=
=2D-
> >>>  block/trace-events                            |  14 +-
> >>>  configure                                     |  65 +-
> >>>  docs/qemu-block-drivers.texi                  |   2 +-
> >>>  .../dockerfiles/debian-win32-cross.docker     |   1 -
> >>>  .../dockerfiles/debian-win64-cross.docker     |   1 -
> >>>  tests/docker/dockerfiles/fedora.docker        |   4 +-
> >>>  tests/docker/dockerfiles/ubuntu.docker        |   2 +-
> >>>  tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
> >>>  tests/qemu-iotests/207                        |   4 +-
> >>>  tests/qemu-iotests/207.out                    |   2 +-
> >>>  13 files changed, 423 insertions(+), 349 deletions(-)
> >>
> >> [...]
> >>
> >>> diff --git a/block/ssh.c b/block/ssh.c
> >>> index 6da7b9cbfe..644ae8b82c 100644
> >>> --- a/block/ssh.c
> >>> +++ b/block/ssh.c
> >>
> >> [...]
> >>
> >>> +    case SSH_SERVER_KNOWN_CHANGED:
> >>> +        ret =3D -EINVAL;
> >>> +        r =3D ssh_get_publickey(s->session, &pubkey);
> >>> +        if (r =3D=3D 0) {
> >>> +            r =3D ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HASH_=
SHA1,
> >>> +                                       &server_hash, &server_hash_le=
n);
> >>> +            pubkey_type =3D ssh_key_type(pubkey);
> >>> +            ssh_key_free(pubkey);
> >>> +        }
> >>> +        if (r =3D=3D 0) {
> >>> +            fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_H=
ASH_SHA1,
> >>> +                                                   server_hash,
> >>> +                                                   server_hash_len);
> >>> +            ssh_clean_pubkey_hash(&server_hash);
> >>> +        }
> >>> +        if (fingerprint) {
> >>> +            error_setg(errp,
> >>> +                       "host key (%s key with fingerprint %s) does n=
ot match "
> >>> +                       "the one in known_hosts",
> >>> +                       ssh_key_type_to_char(pubkey_type), fingerprin=
t);
> >>> +            ssh_string_free_char(fingerprint);
> >>> +        } else  {
> >>> +            error_setg(errp, "host key does not match the one in kno=
wn_hosts");
> >>> +        }
> >>
> >> Usually I=E2=80=99d say that more information can=E2=80=99t be bad.  B=
ut here I don=E2=80=99t
> >> see how this additional information is useful.  known_hosts contains
> >> base64-encoded full public keys.  This only prints the SHA-1 digest.
> >=20
> > Note that SHA-1 is printed with libssh < 0.8; with libssh >=3D 0.8 SHA-=
256
> > is used instead.
> >=20
> >> The user cannot add that to known_hosts, or easily scan known_hosts to
> >> see whether it perhaps belongs to some other hosts (maybe because DHCP
> >> scrambled something).
> >>
> >> Actually, even if this printed the base64 representation of the full
> >> key, the user probably wouldn=E2=80=99t just add that to known_hosts o=
r do
> >> anything with it.  They=E2=80=99ll debug the problem with other tools.
> >>
> >> So I don=E2=80=99t think this new information is really useful...?
> >=20
> > When this situation happens with openssh, the big scary message prints
> > three things:
> > 1) the fingerprint of the server
> > 2) the line of the server in the known_hosts file
> > 3) how to remove the keys of the server from known_hosts, i.e. a
> >    copy-paste'able `ssh-keygen -R host`
> >=20
> > Here I'm doing only (1).  Also, the current libssh2 driver does
> > something else, i.e. print the base64/printable representation of the
> > server key in known_hosts.
>=20
> Well, I don=E2=80=99t know whether it=E2=80=99s necessary to reproduce th=
e exact message
> with all the data it contains.  As I said, I think users can and will
> investigate the exact root of the problem with tools outside of qemu.
> (Such as openssh=E2=80=99s ssh itself.)
>=20
> >> (Hmm, I don=E2=80=99t know if this is a response to my =E2=80=9CBut th=
e specification
> >> requires a warning!!1!=E2=80=9D, but if so, I was actually not referri=
ng to more
> >> information but to this:
> >=20
> > You mentioned this few times: can you please point me to this bit?
> > I read few RFCs related to ssh, and I did not find this information...
>=20
> For example:
> http://api.libssh.org/master/group__libssh__session.html#gacbc5d04fe66bee=
e863a0c61a93fdf765
> > SSH_KNOWN_HOSTS_CHANGED: The server key has changed. Either you are und=
er attack or the administrator changed the key. You HAVE to warn the user a=
bout a possible attack.

Ah, now I see what you mean! I thought that "libssh specification" was
any of the SSH RFCs, and that's why I did not find what you meant.
I see you were talking about the libssh API documentation :-)
(Never heard the API docs of a library called as "specification" before,
TBH.)

> This doesn=E2=80=99t require any specific formatting or data to be given =
to the
> user.  All it requires is =E2=80=9Cto warn the user about a possible atta=
ck=E2=80=9D.
> That can be as simple as appending =E2=80=9CThis may be due to a
> man-in-the-middle attack=E2=80=9D to the error message.

Makes sense -- I just asked to the libssh people, and appending
"this may be a possible attack" should be enough, especially that this
is not a UI message like the one written by the ssh client.

> >> $ ssh 192.168.0.12
> >> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> >> @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
> >> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> >> IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
> >> Someone could be eavesdropping on you right now (man-in-the-middle att=
ack)!
> >> It is also possible that a host key has just been changed.
> >>
> >>
> >> I mean, I was also only half-serious.  I should be serious because the
> >> libssh specification requires us to print some warning like that, but,
> >> well.  Yes, I=E2=80=99ll stop mumbling about this stuff now.)
> >=20
> > To be on the explic side: are you asking to basically put the first 6
> > lines of the openssh error message (as you quoted them above) as error
> > message in the ssh driver?
>=20
> God forbid no.  I was just making an example of =E2=80=9CHere is a warnin=
g about
> a possible attack=E2=80=9D.  I fully agree with Dan (and probably you) th=
at this
> is completely unsuitable to qemu=E2=80=99s interface.
>=20
> Sorry if that came across in another way.

Not a problem. I preferred to ask explicitly to make sure to get it
right -- any amount of information shown is fine for me, I want to make
sure to follow QEMU best practices (if any).

=2D-=20
Pino Toscano
--nextPart3080213.AyQVvb27k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl0L5qEACgkQw9FMLZhk
N80zLA/9GpK/+QjQE2EC27LQo18O4mnu4AKR0U+sZ5ppfDIxSM7YQHtR1cRRctb/
pwi5x/dsYP+5laaA+c1Au9aRfvvHcr8KcGeCwpBIsEtMxM8Ui+i04DkUXP+4I8Xu
GK0TOr1IqkzlhP+fK/3rxqCypY9EyAVZiHSoHOzkHewaYOx0mfP5KrmIQO+z+i+G
3PpAN011ZW7HfcKGBYaULcQrY7lWQ+OA8f4JNItgkvr7Tnb9+93Ur/Ls4cpzqcZF
Mh0J/Qj6U9jkXs8iV/Va2TN9R3RcoRPZ37ygjkjXTkzhXSF0Tvk+jcsfBeV5HzWu
u2jC6Y+RQlJAu3N0La4e+gg9g7/kRaPx62MAVPsqrabT3mlItAeGDX7ghWQfF+i/
SgXtP8waNEATp1F2M/T1yjR1skYooWPAtqQ5kdu3cjy0CBknUVMYmEGEak5iOJD0
+AU76Pg8JBB/HLHVhnMEE+NFmhy0BQaoazv5MC2oaguUFs4b3arJigZuP0YQ9TGq
ZQLgQbR1niwadSq285L2tMAlShW0I4FBv0fczcyrPltqtZvXr8fgLxLaAGLt8YNO
5obHq07JXBcEQaqUNRaoCluBC+MtjIYHD3Xc3ilgUWOR3mI+1kAoa0lPd+SyT74v
A3XHzY68rTgLYHfzxcoQ4C2K9mesRpqnzJVrcnk4uVBlnqUjyxc=
=WHEu
-----END PGP SIGNATURE-----

--nextPart3080213.AyQVvb27k6--




