Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB4E20663
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfXmaidE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB4E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if65Z-0004aN-Oe
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1if64V-00041h-Tw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1if64S-0004qA-Dn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:46:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25195
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1if64S-0004oJ-8I
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576086402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ft0cE2qXNi9Q33cPTdlGqusf7/Ss3IfiUQ+QIl0iTh8=;
 b=OfXmaidEF1J1VO6CNfiaTJ0B/jJtXEqveg5HzztmurydMx2S51L250pTfvQyJqJ/o5R+ik
 qb2aLtOsSoZY392jIAlUGuYnNX2RPzlIzz4Ralwjj+b2gFfZBIWeCiGyBvpnsz9SmO5IkR
 jI+Tw5FBWUFejWXwedTiGGj9qquXm3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-ssW987vLN366_sJce6qpeg-1; Wed, 11 Dec 2019 12:46:39 -0500
X-MC-Unique: ssW987vLN366_sJce6qpeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52F5B8CC517;
 Wed, 11 Dec 2019 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-90.rdu2.redhat.com
 [10.10.124.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9C98472E3;
 Wed, 11 Dec 2019 17:46:30 +0000 (UTC)
Date: Wed, 11 Dec 2019 12:46:28 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v2 2/4] python/qemu: accel: Add list_accel() method
Message-ID: <20191211174628.GA519@localhost.localdomain>
References: <20191206213433.11305-1-wainersm@redhat.com>
 <20191206213433.11305-3-wainersm@redhat.com>
 <20191210005258.GC31990@localhost.localdomain>
 <fee77377-2ffc-af79-4740-23682096f799@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fee77377-2ffc-af79-4740-23682096f799@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, ehabkost@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 02:58:35PM -0200, Wainer dos Santos Moschetta wrote=
:
>=20
> On 12/9/19 10:52 PM, Cleber Rosa wrote:
> > On Fri, Dec 06, 2019 at 04:34:31PM -0500, Wainer dos Santos Moschetta w=
rote:
> > > Since commit cbe6d6365a48 the command `qemu -accel help` returns
> > > the list of accelerators enabled in the QEMU binary. This adds
> > > the list_accel() method which return that same list.
> > >=20
> > > Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> > > Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > ---
> > >   python/qemu/accel.py | 23 +++++++++++++++++++++++
> > >   1 file changed, 23 insertions(+)
> > >=20
> > > diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> > > index cbeac10dd1..746b7e68f5 100644
> > > --- a/python/qemu/accel.py
> > > +++ b/python/qemu/accel.py
> > > @@ -14,7 +14,11 @@ accelerators.
> > >   # the COPYING file in the top-level directory.
> > >   #
> > > +import logging
> > >   import os
> > > +import subprocess
> > > +
> > > +LOG =3D logging.getLogger(__name__)
> > >   # Mapping host architecture to any additional architectures it can
> > >   # support which often includes its 32 bit cousin.
> > > @@ -23,6 +27,25 @@ ADDITIONAL_ARCHES =3D {
> > >       "aarch64" : "armhf"
> > >   }
> > > +def list_accel(qemu_bin):
> > > +    """
> > > +    List accelerators enabled in the QEMU binary.
> > > +
> > > +    @param qemu_bin (str): path to the QEMU binary.
> > > +    @raise Exception: if failed to run `qemu -accel help`
> > > +    @return a list of accelerator names.
> > > +    """
> > > +    if not qemu_bin:
> > > +        return []
> > > +    try:
> > > +        out =3D subprocess.check_output("%s -accel help" % qemu_bin,=
 shell=3DTrue)
> > There's no need to use a shell here.  This could become:
> >=20
> >     out =3D subprocess.check_output([qemu_bin, '-accel' 'help'])
>=20
> Ack
>=20
> >=20
> > > +    except:
> > > +        LOG.debug("Failed to get the list of accelerators in %s" % q=
emu_bin)
> > > +        raise
> > > +    lines =3D out.decode().splitlines()
> > And maybe discard the first line earlier with:
> >=20
> >     lines =3D out.decode().splitlines()[1:]
> >=20
> > Also, you could avoid the manual decode() with the `universal_newlines`
> > option to subprocess.check_output(), ie:
> >=20
> >     accels =3D subprocess.check_output([qemu-bin, '-accel', 'help'],
> >                                      universal_newlines=3DTrue).splitli=
nes()[1:]
>=20
> Nice. v3 will have universal_newlines=3DTrue.
>=20
> >=20
> > > +    # Skip the first line which is the header.
> > > +    return [l.strip() for l in lines[1:] if l]
> > > +
> > I think that the `if l` check can actually hide undesirable behavior
> > (bugs) in the `qemu -accel ?` output.  I don't remember seeing
> > `-$(option) ?` returning empty strings but doesn't mean it couldn't
> > and shouldn't).
> >=20
> > I do remember `-machine ?` returning random non-printable characters
> > that turned out to be a bug, though.
>=20
> Double-checking: are you suggesting to remove the 'if not empty' check so
> that bugs on output could emerge?
>

Yes, that's my suggestion.  I don't think we need to process QEMU's
output beyond what it's expected to be returned.

Cheers,
- Cleber.

> Thanks!
>=20
> - Wainer
>=20
> >=20
> > >   def kvm_available(target_arch=3DNone):
> > >       host_arch =3D os.uname()[4]
> > >       if target_arch and target_arch !=3D host_arch:
> > > --=20
> > > 2.21.0
> > >=20
> > - Cleber.
>=20
>=20

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3xK3IACgkQZX6NM6Xy
CfPaqhAAqkzr2tvUnmZLWzEsZUDmzA2091o+DwsSShFhj5D38QYhRbM3dG7q2Rce
AIdzZ5/lsApnqVRPmnOZ2fGV5mOrbbwWImVdexOSsqFtc5lPx2gX+1si1hC3Nt7w
wZ4lPsst0Cv9JL7QP6tlPsYbhDFo1BgW6PcnD1NlerGYGzfKBk5MOVS7ide65SvQ
2A8ytHqkOO/9cCIY9rnc3uukANxpXZNjGMkxVBfmS+fPi2Dr6wzc99ys/2FVvF6N
xCpQo3thxA6+mQz3F45orpjamMmX9MhzjQBRFmX3vcuyxtgDDBrpKKY2aYYm4jhS
C7VBJpdo9Z2fdIbcet7GseasUm3FQ6kVCHzs7y+giPBYhT7L4kpmddSF9mRwhuZc
b2Ow1Vx4wrnfAVW6Eh5Glur30zIj7Lgv/CBNZEc84/TIIdQp5Xd+6WgAvSbDGqIi
vyGhcEvH9wlvGYoSxRKgXYn4mYh26OvyfR1WKzY90zBDYIa//twPTS6o7qSnpkTC
5qHRK5X3ZD9X+ZxbEdbisuQZvakk8AfxQHD+lgwyIJ8DfODi4MljrRG7RkdgTwu6
E1NFmyyV+/GOoyCBtP4rUfB0Ltuth2HJSYtW5Fxt+aSsPJXi3/4EMIQhFcnRaXYT
/YpJmQEBZUmfhTIUtyfrnSPHwJ3QV2O0CO2T77X+7aM4W8YgPWc=
=5hwL
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--


