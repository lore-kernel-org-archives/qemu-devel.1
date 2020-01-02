Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7B0C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:48:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A61215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOMxL7Sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A61215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1lu-00034E-Tv
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1in1l1-0002Tn-HS
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1in1l0-0004XT-5W
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:47:27 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1in1kz-0004XE-Sd
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:47:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id p17so5868663wmb.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 06:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=HFWandZ948+NYHiu+wRtaAleKYJy+O19h5qYbdqXyUk=;
 b=FOMxL7Sg1y9trnbBFHojHif4+uNBo/foviXSPzi1GMLsLkQ5NBE9HToDRcw6Da+/l9
 OpA0CNs4+yU29GNH7zQChvAD5tUq0+XKIJNNgx+y0QVItjeIkRRdEOmTjLoDvTnmtSNo
 VzfA0YfnvcFscBpZMLY3BZxUTheEnAOGdtTFLdkzK0dgVfOqKqYi9fwehuqFUwq4zNIW
 IEcO2opSknNrZM+27mewV/56Yy1ZBSkSkE06CE5sni/kQNmslG6QJ5NRbCbyECHyLAZ1
 S4noA/lms42Ir7/Q/ZaDLEGRq/tdtAX+0M32GIge9Z7den+nbRXIlES8jGfuG17JG0wR
 Q74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HFWandZ948+NYHiu+wRtaAleKYJy+O19h5qYbdqXyUk=;
 b=VM3YltUSGeUZAhS0Mu6Z7ERaVJJaQsyZmsaxB10BR7KvAMyPTsK3wDm+Pktkr7s2OO
 3Jay2NnN3L3IY//u3fX8+33GNLfrQHL0Ax6quVICkkWnSxNRvg41JzU3lbTbHXtTD2P3
 Wna/pBK7svN1oQ7BWReSmVcIvj8t7GLnUVc0bNBmH9AcaJAYP4/KQxs6Cu3DfxrIlagk
 3msPKTKXM+84kAtc7kti85q/W0J13AjzmkL/aCs+5BtXGnt0aEGozpL93jSsi+YtGMRw
 Yd1nWlqCV0LlRqPtTX2RNISMEPCSIQIP1TFbMfQPnMNmY2V3zM+c9sSLzZoGZ0zByer1
 mFNA==
X-Gm-Message-State: APjAAAVSQ4dnPrxLXjPmrPHVuJQSOXX1wkFOhCZ/buKJk7nmlmkdzTy4
 h33B6gT5Yz7RLVH7wNRtHV0=
X-Google-Smtp-Source: APXvYqwgv83coufRw+pWXKG+aRVxFBziD4nnTxeqkP+nSucCYKVmQNVT9Fb+f5GNyUKaR3kTc/BQkg==
X-Received: by 2002:a1c:9acf:: with SMTP id
 c198mr14190161wme.175.1577976444403; 
 Thu, 02 Jan 2020 06:47:24 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p17sm57096505wrx.20.2020.01.02.06.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 06:47:23 -0800 (PST)
Date: Thu, 2 Jan 2020 14:47:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200102144722.GL121208@stefanha-x1.localdomain>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+278g007AL/ykmV8"
Content-Disposition: inline
In-Reply-To: <87h81unja8.fsf@dusky.pond.sub.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+278g007AL/ykmV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2019 at 10:02:23AM +0100, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > Hi,
> > QEMU presents a command-line interface and QMP monitor for
> > applications to interact with.  Applications actually need API
> > bindings in their programming language.  Bindings avoid reimplementing
> > code to spawn a QEMU process and interact with QMP.  QEMU is kind of
> > lazy and de facto relies on libvirt for API bindings.
> >
> > Is it time for better QEMU APIs?
> >
> > 1. We have qapi-schema.json.  Let's render to HTML and publish
> > versioned documentation online.
>=20
> Make can build docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt}.  Grab
> the .html and go for it.  There's also qmp-ga-ref.

The missing step here is to integrate doc generation and upload into the
release process so the documentation is published.

Once my recent documentation publishing patches have been merged I'll
see if Mike Roth wants to extend the release scripts.

> > 2. scripts/qmp/ contains command-line tools for QMP communication.
> > They could use some polish and then be shipped.
>=20
> MAINTAINERS blames them on me, but they're effectively unmaintained.
> Prerequisite for shipping: having a maintainer who actually gives a
> damn.
=2E..
> * scripts/qmp/qmp-shell
>=20
>   Half-hearted attempt at a human-friendly wrapper around the JSON
>   syntax.  I have no use for this myself.

I think this one is used by people.  John Snow comes to mind.

> > 3. python/qemu/ contains Python modules for managing a QEMU process
> > and QMP communication.  This should be packaged in distros and
> > available on PyPI.
>=20
> Currently maintained by Eduardo and Cleber (cc'ed) under "Python
> scripts".
>=20
> > 4. Go and Rust bindings would also be useful.  There is
> > https://github.com/intel/govmm but I think it makes sense to keep it
> > in qemu.git and provide an interface similar to our Python modules.
>=20
> Mapping QAPI/QMP commands and events to function signatures isn't hard
> (the QAPI code generator does).  Two problems (at least):
>=20
> 1. Leads to some pretty ridiculous functions.  Here's one:
>=20
>     void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>                              const char *device,
>                              const char *target,
>                              bool has_replaces, const char *replaces,
>                              MirrorSyncMode sync,
>                              bool has_speed, int64_t speed,
>                              bool has_granularity, uint32_t granularity,
>                              bool has_buf_size, int64_t buf_size,
>                              bool has_on_source_error,
>                              BlockdevOnError on_source_error,
>                              bool has_on_target_error, BlockdevOnError on=
_target_error,
>                              bool has_filter_node_name, const char *filte=
r_node_name,
>                              bool has_copy_mode, MirrorCopyMode copy_mode=
,=20
>                              bool has_auto_finalize, bool auto_finalize,
>                              bool has_auto_dismiss, bool auto_dismiss,
>                              Error **errp);
>=20
>   We commonly use 'boxed': true for such beasts, which results in
>   functions like this one:
>=20
>     void qmp_blockdev_add(BlockdevOptions *arg, Error **errp);
>=20
> 2. Many schema changes that are nicely backward compatible in QMP are
>    anything but in such an "obvious" C API.  Adding optional arguments,
>    for instance, or changing integer type width.  The former is less of
>    an issue with 'boxed': true.
>=20
> Perhaps less of an issue with dynamic languages.
>=20
> I figure a static language would need much more expressive oomph than C
> to be a good target.  No idea how well Go or Rust bindings can work.

Most of what govmm does is build QEMU command-lines, not wrap QMP APIs.

Native QMP API bindings are harder and we'd need to see who really needs
this.  Languages with a built-in dict type like Python make working with
JSON-level QMP feasible.  In C it's painful though and native API
bindings are desirable.

--+278g007AL/ykmV8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4OAnkACgkQnKSrs4Gr
c8gaoQf/dVcjER4HurjzBGW25WV9OsxxsKfC0lJ32DsedLrGezZEhXQUhdfkjMuk
+Esu52/ZePFplPiA/01Y3rPKVPEDUEi8eJvA3mnBTaF7W/qv8UACHzVT5t0Kx/Vh
c6oE38DJlYz3j3KmyjdRvPkievqDupgmeqNo9aiQyYH0IeG8mKm3B26urSuuoP27
pZMM+IkAdPoOPzQT9l5zpQLsYh9smdIgL+vgTCjEZ7fZytZJlvI64HIqcbT/x3ZW
56OpuuRuDJtrzB9XDGy7838t2zVx3Ej8/PPhNdQnlo3rfHUByRyoeDzYZ+wkjQK0
Q8i5BlqpMs3PdFA+UY+dLeTVl8i+Jg==
=s6Ci
-----END PGP SIGNATURE-----

--+278g007AL/ykmV8--

