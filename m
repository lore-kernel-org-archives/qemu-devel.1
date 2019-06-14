Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92F1C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C262D20866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C262D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52432 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnnA-0005E6-Nd
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33856)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1hbnDc-0004JK-EU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hbnDb-00016B-5V
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:30:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hbnDR-0000kk-CM; Fri, 14 Jun 2019 10:30:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 439A0307D90D;
 Fri, 14 Jun 2019 14:30:00 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (ovpn-200-20.brq.redhat.com
 [10.40.200.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F0084608A4;
 Fri, 14 Jun 2019 14:29:52 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Date: Fri, 14 Jun 2019 16:29:46 +0200
Message-ID: <2592166.7WioNeH6bT@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2635807.eRrssQcAN8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 14 Jun 2019 14:30:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9] ssh: switch from libssh2 to libssh
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

--nextPart2635807.eRrssQcAN8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, 13 June 2019 21:31:40 CEST Max Reitz wrote:
> On 13.06.19 15:20, Pino Toscano wrote:
> > -    switch (r) {
> > -    case LIBSSH2_KNOWNHOST_CHECK_MATCH:
> > +    switch (state) {
> > +    case SSH_KNOWN_HOSTS_OK:
> >          /* OK */
> > -        trace_ssh_check_host_key_knownhosts(found->key);
> > +        trace_ssh_check_host_key_knownhosts();
> >          break;
> > -    case LIBSSH2_KNOWNHOST_CHECK_MISMATCH:
> > +    case SSH_KNOWN_HOSTS_CHANGED:
> >          ret =3D -EINVAL;
> > -        session_error_setg(errp, s,
> > -                      "host key does not match the one in known_hosts"
> > -                      " (found key %s)", found->key);
> > +        error_setg(errp, "host key does not match the one in known_hos=
ts");
>=20
> So what about the possible attack warning that the specification
> technically requires us to print? O:-)

There is the API since libssh 0.8.0... which unfortunately is not
usable, as they forgot to properly export the symbol :-(

>=20
> >          goto out;
> > -    case LIBSSH2_KNOWNHOST_CHECK_NOTFOUND:
> > +    case SSH_KNOWN_HOSTS_OTHER:
> >          ret =3D -EINVAL;
> > -        session_error_setg(errp, s, "no host key was found in known_ho=
sts");
> > +        error_setg(errp,
> > +                   "host key for this server not found, another type e=
xists");
> >          goto out;
> > -    case LIBSSH2_KNOWNHOST_CHECK_FAILURE:
> > +    case SSH_KNOWN_HOSTS_UNKNOWN:
> >          ret =3D -EINVAL;
> > -        session_error_setg(errp, s,
> > -                      "failure matching the host key with known_hosts"=
);
> > +        error_setg(errp, "no host key was found in known_hosts");
> > +        goto out;
> > +    case SSH_KNOWN_HOSTS_NOT_FOUND:
> > +        ret =3D -ENOENT;
> > +        error_setg(errp, "known_hosts file not found");
> > +        goto out;
> > +    case SSH_KNOWN_HOSTS_ERROR:
> > +        ret =3D -EINVAL;
> > +        error_setg(errp, "error while checking the host");
> >          goto out;
> >      default:
> >          ret =3D -EINVAL;
> > -        session_error_setg(errp, s, "unknown error matching the host k=
ey"
> > -                      " with known_hosts (%d)", r);
> > +        error_setg(errp, "error while checking for known server");
> >          goto out;
> >      }
> > +#else /* !HAVE_LIBSSH_0_8 */
> > +    int state;
> > +
> > +    state =3D ssh_is_server_known(s->session);
> > +    trace_ssh_server_status(state);
> > +
> > +    switch (state) {
> > +    case SSH_SERVER_KNOWN_OK:
> > +        /* OK */
> > +        trace_ssh_check_host_key_knownhosts();
> > +        break;
> > +    case SSH_SERVER_KNOWN_CHANGED:
> > +        ret =3D -EINVAL;
> > +        error_setg(errp, "host key does not match the one in known_hos=
ts");
> > +        goto out;
> > +    case SSH_SERVER_FOUND_OTHER:
> > +        ret =3D -EINVAL;
> > +        error_setg(errp,
> > +                   "host key for this server not found, another type e=
xists");
> > +        goto out;
> > +    case SSH_SERVER_FILE_NOT_FOUND:
> > +        ret =3D -ENOENT;
> > +        error_setg(errp, "known_hosts file not found");
> > +        goto out;
> > +    case SSH_SERVER_NOT_KNOWN:
> > +        ret =3D -EINVAL;
> > +        error_setg(errp, "no host key was found in known_hosts");
> > +        goto out;
> > +    case SSH_SERVER_ERROR:
> > +        ret =3D -EINVAL;
> > +        error_setg(errp, "server error");
> > +        goto out;
>=20
> No default here?

This switch is for libssh < 0.8.0, so enumerating all the possible
values of the enum of the old API is enough.

> > @@ -775,16 +845,13 @@ static int ssh_file_open(BlockDriverState *bs, QD=
ict *options, int bdrv_flags,
> >      }
> > =20
> >      /* Go non-blocking. */
> > -    libssh2_session_set_blocking(s->session, 0);
> > +    ssh_set_blocking(s->session, 0);
> > =20
> >      qapi_free_BlockdevOptionsSsh(opts);
> > =20
> >      return 0;
> > =20
> >   err:
> > -    if (s->sock >=3D 0) {
> > -        close(s->sock);
> > -    }
> >      s->sock =3D -1;
>=20
> Shouldn=E2=80=99t connect_to_ssh() set this to -1 after closing the sessi=
on?

It should, although it will not make a difference. connect_to_ssh() is
used in only two places:
=2D in ssh_file_open, and s->sock is reset to -1 on error
=2D in ssh_co_create, which uses a local BDRVSSHState

> > diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
> > index b3816136f7..774eb5f2a9 100755
> > --- a/tests/qemu-iotests/207
> > +++ b/tests/qemu-iotests/207
>=20
> [...]
>=20
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
> Hm.  This is a pain.
>=20
> I suppose the best would be to drop the "-t" altogether and then check
> whether any of the entries ssh-keyscan reports matches.

The problem here is slightly more than this:
=2D libssh2 supports only rsa and dsa keys, so when connecting rsa keys
  are usually used, and thus it is easy to pass a fingerprint for that
  rsa key
=2D libssh supports more recent (and stronger) types of keys, which of
  course are preferred by more modern (open)ssh servers.  Thus it is not
  possible to know which key will be used when connecting, unless forced
  (which I'd rather not do)
A possible future improvement could be IMHO to add an extra option to
set the allowed key types for the connection, so you can set it to a
specific one and specify the right fingerprint for it.

=2D-=20
Pino Toscano
--nextPart2635807.eRrssQcAN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl0Dr1oACgkQw9FMLZhk
N83x3xAAyVFd6CRmaxprkIIGT2Zc4xA4/Y6XHPxqsnDXlCzb2ujqHgjNkwVf6vVp
m/PzW0kHUheIJnyhAGAa2uL9MVy3+0VXlDHhWY9Hu5HVYSvw/4+eZRO5vfEKsL4u
qVjm0ik1TYI2YxNaMnGiYXQf8PVtDFMHZ8qmeoHhIEcSxFmf6S4n9j4M3yYQEp4z
HDzQwKZNkKfN2MYeNhITuv7U3gGcrrJWn3TO+883y/OMhFjveJxs8SEnR05fDBBT
oGz3k43kqHmmofwLpCb1Nop1qRTe3Kfkf9cQtyOOmKNcXm3z15Z8tJLOm/tSmtbp
DnRnA8ne0OApZIbmyJ7dOUOd6bYWp5D52qUPx+sRkLcIvZfKeLtOAsEgRwOECJw2
z+TNQLWNc/3BOKyhCNop5kHXjcmpvU4zTEWX6eT0kLNY8BTPzpa69ZPpIV9ijl/b
TbQTHn2qjf3gRPa0cwYjz/bgrZeir2ZwjDcrfF9DG+Uj2pIQAzZKw3m6JS2wGByv
o0H+N+LDLut76/mtZy1U0WeIOGzWqke9t3e39ubeSSgrFMPz6li2yUl3jKChW7Ax
Vwd2VCdb50TI9RsH4bi8EE06urYZy62ScMsnuoovFMH/hhr6HsfaBDH0ZxDVavhY
e9JyRU1pgp0J1M7LSY/sjVyINZByK2gMm3d3XRNK4v6/I9yCs1o=
=cD8G
-----END PGP SIGNATURE-----

--nextPart2635807.eRrssQcAN8--




