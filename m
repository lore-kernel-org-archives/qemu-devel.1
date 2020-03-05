Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528D8C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2114720848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 10:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=online.net header.i=@online.net header.b="K3czyuBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2114720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=online.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9nVt-0002RJ-B1
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 05:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fflorensa@online.net>) id 1j9nUz-0001wh-Vd
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fflorensa@online.net>) id 1j9nUx-0006Mn-3b
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:13:00 -0500
Received: from mail.online.net ([62.210.16.11]:58316)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fflorensa@online.net>)
 id 1j9nUw-0006Ii-Hj
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 05:12:59 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id 9E151F2BE193;
 Thu,  5 Mar 2020 11:12:56 +0100 (CET)
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id tUbWUBvJybM8; Thu,  5 Mar 2020 11:12:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.online.net (Postfix) with ESMTP id 790BDF2BE1F4;
 Thu,  5 Mar 2020 11:12:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.online.net 790BDF2BE1F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.net;
 s=4EC61654-9574-11E8-870F-3D38CA7095BF; t=1583403176;
 bh=bOBcn1AbRH3FzETGsn7bQ3DJ+9TA4h8shgXMn4W1svM=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=K3czyuBrUc8oyfZX6jcb4m2UxKbbafdjctp0c1I8lhEPyskE3lrO+86tcc+JRyt5M
 rZ9p0LtiBaFwzUI8WiLL1znBCiE79bFJg7r6HMANuBLn7OGt/HAN47RdQSgHHEe8Za
 zMZ2FUHFD8JSV4ybojEDN8XMRXQM+Ew3dKeQs2A4FVAEIQ9CKi889Bzlo4+o/+3VLG
 oF8fohdpqRf5UQjHO4vnlv0c8Xr9ecj6+MbxDT1NQ3PVA4ljL2T634C1uV/h7YR3wR
 h9BYWa8ZJ0lcjjT6Zwx0RFH3UaOCu5yMNeLrzYJNbaxfblETcqo6OXuSIYQNC0+k9w
 56sFkZYNwmaag==
X-Virus-Scanned: amavisd-new at mail.online.net
Received: from mail.online.net ([127.0.0.1])
 by localhost (mail.online.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id K-cDuG1ZQxWN; Thu,  5 Mar 2020 11:12:56 +0100 (CET)
Received: from localhost (unknown [195.154.229.35])
 by mail.online.net (Postfix) with ESMTPSA id 434B1F2BE193;
 Thu,  5 Mar 2020 11:12:56 +0100 (CET)
Date: Thu, 5 Mar 2020 11:12:55 +0100
From: Florian Florensa <fflorensa@online.net>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 1/1] block/rbd: Add support for ceph namespaces
Message-ID: <20200305101255.dcmioggplin565xn@flash.localdomain>
References: <20200110111513.321728-1-fflorensa@online.net>
 <20200110111513.321728-2-fflorensa@online.net>
 <CA+aFP1A-C-7FYMtCQkK4XHwON5E6ZZ=Qu5N3Tf2-bhcTkEH=zQ@mail.gmail.com>
 <20200203111625.umggvu4w7qylwrc5@flash.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a5cz37dno26mj3do"
Content-Disposition: inline
In-Reply-To: <20200203111625.umggvu4w7qylwrc5@flash.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 62.210.16.11
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
Cc: Stefano Garzarella <sgarzare@redhat.com>, Max Reitz <mreitz@redhat.com>,
 dillaman <dillaman@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a5cz37dno26mj3do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 12:17:10PM +0100, Florian Florensa wrote:
Hello,

Any news regarding this ?

Regards,

Florian
> Hello Kevin,
>=20
> Just checking in to see if any more work needs to be done on this for a
> possible merge.
>=20
> Regards,
>=20
> Florian
> On Fri, Jan 10, 2020 at 09:13:12AM -0500, Jason Dillaman wrote:
> > On Fri, Jan 10, 2020 at 6:15 AM Florian Florensa <fflorensa@online.net>=
 wrote:
> > >
> > > Starting from ceph Nautilus, RBD has support for namespaces, allowing
> > > for finer grain ACLs on images inside a pool, and tenant isolation.
> > >
> > > In the rbd cli tool documentation, the new image-spec and snap-spec a=
re :
> > >  - [pool-name/[namespace-name/]]image-name
> > >  - [pool-name/[namespace-name/]]image-name@snap-name
> > >
> > > When using an non namespace's enabled qemu, it complains about not
> > > finding the image called namespace-name/image-name, thus we only need=
 to
> > > parse the image once again to find if there is a '/' in its name, and=
 if
> > > there is, use what is before it as the name of the namespace to later
> > > pass it to rados_ioctx_set_namespace.
> > > rados_ioctx_set_namespace if called with en empty string or a null
> > > pointer as the namespace parameters pretty much does nothing, as it t=
hen
> > > defaults to the default namespace.
> > >
> > > The namespace is extracted inside qemu_rbd_parse_filename, stored in =
the
> > > qdict, and used in qemu_rbd_connect to make it work with both qemu-im=
g,
> > > and qemu itself.
> > >
> > > Signed-off-by: Florian Florensa <fflorensa@online.net>
> > > ---
> > >  block/rbd.c          | 44 +++++++++++++++++++++++++++++++-----------=
--
> > >  qapi/block-core.json |  4 ++++
> > >  2 files changed, 35 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/block/rbd.c b/block/rbd.c
> > > index 027cbcc695..84115d34b4 100644
> > > --- a/block/rbd.c
> > > +++ b/block/rbd.c
> > > @@ -104,6 +104,7 @@ typedef struct BDRVRBDState {
> > >      rbd_image_t image;
> > >      char *image_name;
> > >      char *snap;
> > > +    char *namespace;
> > >      uint64_t image_size;
> > >  } BDRVRBDState;
> > >
> > > @@ -152,7 +153,7 @@ static void qemu_rbd_parse_filename(const char *f=
ilename, QDict *options,
> > >      const char *start;
> > >      char *p, *buf;
> > >      QList *keypairs =3D NULL;
> > > -    char *found_str;
> > > +    char *found_str, *image_name;
> > >
> > >      if (!strstart(filename, "rbd:", &start)) {
> > >          error_setg(errp, "File name must start with 'rbd:'");
> > > @@ -171,18 +172,24 @@ static void qemu_rbd_parse_filename(const char =
*filename, QDict *options,
> > >      qdict_put_str(options, "pool", found_str);
> > >
> > >      if (strchr(p, '@')) {
> > > -        found_str =3D qemu_rbd_next_tok(p, '@', &p);
> > > -        qemu_rbd_unescape(found_str);
> > > -        qdict_put_str(options, "image", found_str);
> > > +        image_name =3D qemu_rbd_next_tok(p, '@', &p);
> > >
> > >          found_str =3D qemu_rbd_next_tok(p, ':', &p);
> > >          qemu_rbd_unescape(found_str);
> > >          qdict_put_str(options, "snapshot", found_str);
> > >      } else {
> > > -        found_str =3D qemu_rbd_next_tok(p, ':', &p);
> > > +        image_name =3D qemu_rbd_next_tok(p, ':', &p);
> > > +    }
> > > +    /* Check for namespace in the image_name */
> > > +    if (strchr(image_name, '/')) {
> > > +        found_str =3D qemu_rbd_next_tok(image_name, '/', &image_name=
);
> > >          qemu_rbd_unescape(found_str);
> > > -        qdict_put_str(options, "image", found_str);
> > > +        qdict_put_str(options, "namespace", found_str);
> > > +    } else {
> > > +        qdict_put_str(options, "namespace", "");
> > >      }
> > > +    qemu_rbd_unescape(image_name);
> > > +    qdict_put_str(options, "image", image_name);
> > >      if (!p) {
> > >          goto done;
> > >      }
> > > @@ -343,6 +350,11 @@ static QemuOptsList runtime_opts =3D {
> > >              .type =3D QEMU_OPT_STRING,
> > >              .help =3D "Rados pool name",
> > >          },
> > > +        {
> > > +            .name =3D "namespace",
> > > +            .type =3D QEMU_OPT_STRING,
> > > +            .help =3D "Rados namespace name in the pool",
> > > +        },
> > >          {
> > >              .name =3D "image",
> > >              .type =3D QEMU_OPT_STRING,
> > > @@ -467,13 +479,14 @@ static int coroutine_fn qemu_rbd_co_create_opts=
(const char *filename,
> > >       * schema, but when they come from -drive, they're all QString.
> > >       */
> > >      loc =3D rbd_opts->location;
> > > -    loc->pool     =3D g_strdup(qdict_get_try_str(options, "pool"));
> > > -    loc->conf     =3D g_strdup(qdict_get_try_str(options, "conf"));
> > > -    loc->has_conf =3D !!loc->conf;
> > > -    loc->user     =3D g_strdup(qdict_get_try_str(options, "user"));
> > > -    loc->has_user =3D !!loc->user;
> > > -    loc->image    =3D g_strdup(qdict_get_try_str(options, "image"));
> > > -    keypairs      =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs"=
);
> > > +    loc->pool        =3D g_strdup(qdict_get_try_str(options, "pool")=
);
> > > +    loc->conf        =3D g_strdup(qdict_get_try_str(options, "conf")=
);
> > > +    loc->has_conf    =3D !!loc->conf;
> > > +    loc->user        =3D g_strdup(qdict_get_try_str(options, "user")=
);
> > > +    loc->has_user    =3D !!loc->user;
> > > +    loc->q_namespace =3D g_strdup(qdict_get_try_str(options, "namesp=
ace"));
> > > +    loc->image       =3D g_strdup(qdict_get_try_str(options, "image"=
));
> > > +    keypairs         =3D qdict_get_try_str(options, "=3Dkeyvalue-pai=
rs");
> > >
> > >      ret =3D qemu_rbd_do_create(create_options, keypairs, password_se=
cret, errp);
> > >      if (ret < 0) {
> > > @@ -648,6 +661,11 @@ static int qemu_rbd_connect(rados_t *cluster, ra=
dos_ioctx_t *io_ctx,
> > >          error_setg_errno(errp, -r, "error opening pool %s", opts->po=
ol);
> > >          goto failed_shutdown;
> > >      }
> > > +    /*
> > > +     * Set the namespace after opening the io context on the pool,
> > > +     * if nspace =3D=3D NULL or if nspace =3D=3D "", it is just as w=
e did nothing
> > > +     */
> > > +    rados_ioctx_set_namespace(*io_ctx, opts->q_namespace);
> > >
> > >      return 0;
> > >
> > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > index fcb52ec24f..c6f187ec9b 100644
> > > --- a/qapi/block-core.json
> > > +++ b/qapi/block-core.json
> > > @@ -3661,6 +3661,9 @@
> > >  #
> > >  # @pool:               Ceph pool name.
> > >  #
> > > +# @namespace:          Rados namespace name in the Ceph pool.
> > > +#                      (Since 5.0)
> > > +#
> > >  # @image:              Image name in the Ceph pool.
> > >  #
> > >  # @conf:               path to Ceph configuration file.  Values
> > > @@ -3687,6 +3690,7 @@
> > >  ##
> > >  { 'struct': 'BlockdevOptionsRbd',
> > >    'data': { 'pool': 'str',
> > > +            '*namespace': 'str',
> > >              'image': 'str',
> > >              '*conf': 'str',
> > >              '*snapshot': 'str',
> > > --
> > > 2.24.1
> > >
> >=20
> > Reviewed-by: Jason Dillaman <dillaman@redhat.com>
> >=20
> > --=20
> > Jason
> >=20



--a5cz37dno26mj3do
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEENMOcO22p59MYDr5mpFTgAOO+N4gFAl5g0KcACgkQpFTgAOO+
N4iIWBAAgdcS4aZU097Lh5FLjeZIPbpsvbIrVjPK+/XdVvNdDHKHGPIWWb1/x1lz
rYdq5QDVEYkZTqvXCf97aV4LIJVbaKbkYhk2SdhhM9oZYxRVHmDp0vElWibVrFPE
MUxCHQXKczmdDYmjz7NFoHlC5BMmvN0nbTgr/lel07PHBNfA7a0Jm9ajfRD4eCuX
UPXX31VkTeSXz/PjsoYs6bGBvbBm571diuTJNgzwkA4moB+EnayFxrSfCT73ojz4
L69Mk6m9NRnKYqA4lmfg5xYkkXdnUu+EDMCd+y5fKN3kaFaf0CuO10xHsS/oiLf7
0dA39vYty6+wQujqjc4Erqq/MltcArrmqxEEOxRvYG11EW1az8r8ymOd3rQz43Zm
6gKSmsU5UnSTaZHrJqMH5fH1d6PwmkcicCdWLLwm4GI/Od6THDT1I67lbnjxoJKn
VDCAkphwFg2tJh3mG9Oucd6Q5p7/QAYwfCIwLjnYmKeW9Y1Z2ANtjlHaZAiHVJya
/zXLeYRltXPHlDl3D9z17JNcsO0tmM5W5RM3E5GgkVUoZOXbNyoRQv9QlOQQYdjF
WtcJL6IHjVSYNf+CYSmAkzmlw7j3iLSyvtoyhuH/8F6iUMrSPDUte4ayMGPmcGcD
j3irY9XvF0JS8nNsAVLlcE1Xog2+dJ5EWyN0226pnFZK66VBnX0=
=xs4Q
-----END PGP SIGNATURE-----

--a5cz37dno26mj3do--

