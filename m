Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C1C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 10:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D1120675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 10:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D1120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hduBG-00006L-Kx
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 06:20:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hdu98-0006ju-AM
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hdu2Q-0005lK-7v
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:11:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hdu2O-0005kW-GQ; Thu, 20 Jun 2019 06:11:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2BC688E56;
 Thu, 20 Jun 2019 10:11:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A69560156;
 Thu, 20 Jun 2019 10:11:16 +0000 (UTC)
Date: Thu, 20 Jun 2019 11:11:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190620101113.GV25448@redhat.com>
References: <20190618092403.30006-1-ptoscano@redhat.com>
 <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 10:11:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, rjones@redhat.com,
 sw@weilnetz.de, qemu-devel@nongnu.org, Pino Toscano <ptoscano@redhat.com>,
 alex.bennee@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 03:14:30PM +0200, Max Reitz wrote:
> On 18.06.19 11:24, Pino Toscano wrote:
> > Rewrite the implementation of the ssh block driver to use libssh inst=
ead
> > of libssh2.  The libssh library has various advantages over libssh2:
> > - easier API for authentication (for example for using ssh-agent)
> > - easier API for known_hosts handling
> > - supports newer types of keys in known_hosts
> >=20
> > Use APIs/features available in libssh 0.8 conditionally, to support
> > older versions (which are not recommended though).
> >=20
> > Adjust the tests according to the different error message, and to the
> > newer host keys (ed25519) that are used by default with OpenSSH >=3D =
6.7
> > and libssh >=3D 0.7.0.
> >=20
> > Adjust the various Docker/Travis scripts to use libssh when available
> > instead of libssh2. The mingw/mxe testing is dropped for now, as ther=
e
> > are no packages for it.
> >=20
> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >=20
> > Changes from v9:
> > - restored "default" case in the server status switch for libssh < 0.=
8.0
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
> >  block/ssh.c                                   | 665 ++++++++++------=
--
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
> > +            r =3D ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HASH_=
SHA1,
> > +                                       &server_hash, &server_hash_le=
n);
> > +            pubkey_type =3D ssh_key_type(pubkey);
> > +            ssh_key_free(pubkey);
> > +        }
> > +        if (r =3D=3D 0) {
> > +            fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_H=
ASH_SHA1,
> > +                                                   server_hash,
> > +                                                   server_hash_len);
> > +            ssh_clean_pubkey_hash(&server_hash);
> > +        }
> > +        if (fingerprint) {
> > +            error_setg(errp,
> > +                       "host key (%s key with fingerprint %s) does n=
ot match "
> > +                       "the one in known_hosts",
> > +                       ssh_key_type_to_char(pubkey_type), fingerprin=
t);
> > +            ssh_string_free_char(fingerprint);
> > +        } else  {
> > +            error_setg(errp, "host key does not match the one in kno=
wn_hosts");
> > +        }
>=20
> Usually I=E2=80=99d say that more information can=E2=80=99t be bad.  Bu=
t here I don=E2=80=99t
> see how this additional information is useful.  known_hosts contains
> base64-encoded full public keys.  This only prints the SHA-1 digest.
> The user cannot add that to known_hosts, or easily scan known_hosts to
> see whether it perhaps belongs to some other hosts (maybe because DHCP
> scrambled something).
>=20
> Actually, even if this printed the base64 representation of the full
> key, the user probably wouldn=E2=80=99t just add that to known_hosts or=
 do
> anything with it.  They=E2=80=99ll debug the problem with other tools.
>=20
> So I don=E2=80=99t think this new information is really useful...?
>=20
>=20
> (Hmm, I don=E2=80=99t know if this is a response to my =E2=80=9CBut the=
 specification
> requires a warning!!1!=E2=80=9D, but if so, I was actually not referrin=
g to more
> information but to this:
>=20
> $ ssh 192.168.0.12
> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
> Someone could be eavesdropping on you right now (man-in-the-middle atta=
ck)!
> It is also possible that a host key has just been changed.
>=20
>=20
> I mean, I was also only half-serious.  I should be serious because the
> libssh specification requires us to print some warning like that, but,
> well.  Yes, I=E2=80=99ll stop mumbling about this stuff now.)

Those giant messages are targetted at humans though so I'm not so
convinced it is useful for apps managing QEMU. IMHO it is sufficient
to just report a simple error that the host ident check failed as
the patch does now. It gives enough info to then investigate further
to identify the root cause problems.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

