Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F7CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899332073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j88sNPcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899332073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkad-0001QZ-FN
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkDP-0008PR-Ma; Tue, 23 Jun 2020 10:47:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkDN-0005PP-VA; Tue, 23 Jun 2020 10:47:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id j18so3236152wmi.3;
 Tue, 23 Jun 2020 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nHH/5HcJjGJrbqd+zi6VW/xh2OGjZUFq9HtreqvbFjE=;
 b=j88sNPcvKbsKR66W5xYiI3S/L1nE4Fsfg0V7zivseJ4toP3aHhJmq16CV8J+X5QJvi
 7t1w7z3+Vvl+PdGRLiF3E0PQjD4O1JLh65f2mCHSTwlelWUNu0hS8uzBUPPnCXqshYuT
 K+a6m40zTbZLr2tgNVtxDXP1CsX6yFn4FawIl6F41vISUaVx/4fQ+0NzDbkcQgffc3M1
 8knaAJE4Lyt2OWJ906bSH71BS/p/jjZQsTiy3f4eeCuzt7y4nkWxlN2F6hT38ui6BxfQ
 /SqmSKhDR8zGrJ1SExvAzHi8ZgZ0sXQnLsIQ2czvXrSV7l8wdWRGSgC6SpKCIFHWQmFS
 bmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nHH/5HcJjGJrbqd+zi6VW/xh2OGjZUFq9HtreqvbFjE=;
 b=bt8o0T5MM0gG1E+tZuG736tWHXviHOcrG0AxWUi29QN1ImWj0nA73fohd1JF+oOqSd
 4t23wDh6wor63qQX0f+aqbsf491RvDF48ItkF3wCjdHWGVj3evY0WEVUi3w7bz67jK44
 SLjNLJU7Gt670SIh/nvxFQofqWq7KxL4fR0nsxjlbZVuvYxWYHYoNiRYDpNbnI33uuo9
 pgVh8XbGVszpvMhi2znwAp5kTGWHRVV3Qq+48o9dx7KMRSlZMkcLSiG0t9pChMR3P4q1
 /scGo+3K1WeMWwa1AKpXwckMDYiGuHG39TxbDV85pyLt3NlJIighSdCRRR8X+Um05fhF
 tjaQ==
X-Gm-Message-State: AOAM530GrDFPArnZM1doEzf+kSagJ5Zpwcd4gS1dUIwHqPE6wnOSLWC5
 gJLbd1uNaBf0gTqMN6Oz2WQ=
X-Google-Smtp-Source: ABdhPJwVuMWH18T8+Vr8EoiJNUY1m6sdb2K808sRWdv9zmrwmOiOsOcxsTaS52nP+PeAH4xw5/PUQQ==
X-Received: by 2002:a1c:b007:: with SMTP id z7mr2252440wme.37.1592923676000;
 Tue, 23 Jun 2020 07:47:56 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z1sm14432596wru.30.2020.06.23.07.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:47:54 -0700 (PDT)
Date: Tue, 23 Jun 2020 15:47:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] scripts/tracetool: Add plainlog backend
Message-ID: <20200623144753.GR36568@stefanha-x1.localdomain>
References: <20200617134505.9D06E7482D3@zero.eik.bme.hu>
 <20200618073124.GA1956319@stefanha-x1.localdomain>
 <20200618090741.GC671599@redhat.com>
 <20200618153516.GE1956319@stefanha-x1.localdomain>
 <20200618154323.GK671599@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X35wERi4JU/f1kly"
Content-Disposition: inline
In-Reply-To: <20200618154323.GK671599@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--X35wERi4JU/f1kly
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 04:43:23PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jun 18, 2020 at 04:35:16PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Jun 18, 2020 at 10:07:41AM +0100, Daniel P. Berrang=E9 wrote:
> > > On Thu, Jun 18, 2020 at 08:31:24AM +0100, Stefan Hajnoczi wrote:
> > > > On Wed, Jun 17, 2020 at 03:36:29PM +0200, BALATON Zoltan wrote:
> > > > > Add a backend that is the same as the log backend but omits the
> > > > > process id and timestamp so logs are easier to read and diff-able.
> > > > >=20
> > > > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > > > ---
> > > > >  scripts/tracetool/backend/plainlog.py | 48 +++++++++++++++++++++=
++++++
> > > > >  1 file changed, 48 insertions(+)
> > > > >  create mode 100644 scripts/tracetool/backend/plainlog.py
> > > > >=20
> > > > > diff --git a/scripts/tracetool/backend/plainlog.py b/scripts/trac=
etool/backend/plainlog.py
> > > > > new file mode 100644
> > > > > index 0000000000..40bbfa6d76
> > > > > --- /dev/null
> > > > > +++ b/scripts/tracetool/backend/plainlog.py
> > > > > @@ -0,0 +1,48 @@
> > > > > +# -*- coding: utf-8 -*-
> > > > > +
> > > > > +"""
> > > > > +Stderr built-in backend, plain log without proc ID and time.
> > > > > +"""
> > > > > +
> > > > > +__author__     =3D "Llu????s Vilanova <vilanova@ac.upc.edu>"
> > > > > +__copyright__  =3D "Copyright 2012-2017, Llu????s Vilanova <vila=
nova@ac.upc.edu>"
> > > >=20
> > > > There is a Unicode issue here, Llu=EDs' name is not printed correct=
ly.
> > > >=20
> > > > > +__license__    =3D "GPL version 2 or (at your option) any later =
version"
> > > > > +
> > > > > +__maintainer__ =3D "Stefan Hajnoczi"
> > > > > +__email__      =3D "stefanha@linux.vnet.ibm.com"
> > > > > +
> > > > > +
> > > > > +from tracetool import out
> > > > > +
> > > > > +
> > > > > +PUBLIC =3D True
> > > > > +
> > > > > +
> > > > > +def generate_h_begin(events, group):
> > > > > +    out('#include "qemu/log-for-trace.h"',
> > > > > +        '')
> > > > > +
> > > > > +
> > > > > +def generate_h(event, group):
> > > > > +    argnames =3D ", ".join(event.args.names())
> > > > > +    if len(event.args) > 0:
> > > > > +        argnames =3D ", " + argnames
> > > > > +
> > > > > +    if "vcpu" in event.properties:
> > > > > +        # already checked on the generic format code
> > > > > +        cond =3D "true"
> > > > > +    else:
> > > > > +        cond =3D "trace_event_get_state(%s)" % ("TRACE_" + event=
=2Ename.upper())
> > > > > +
> > > > > +    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
> > > > > +        '        qemu_log("%(name)s " %(fmt)s "\\n" %(argnames)s=
);',
> > > > > +        '    }',
> > > > > +        cond=3Dcond,
> > > > > +        name=3Devent.name,
> > > > > +        fmt=3Devent.fmt.rstrip("\n"),
> > > > > +        argnames=3Dargnames)
> > > >=20
> > > > It is not necessary to introduce a new backend. There could be an o=
ption
> > > > that controls whether or not the timestamp/tid is printed. For exam=
ple,
> > > > -trace timestamp=3Doff or maybe the timestmap/tid can be integrated=
 into
> > > > qemu_log() itself so that it's used more consistently and a -d time=
stamp
> > > > option enables it.
> > >=20
> > > QEMU already has a "-msg timestamp=3Don|off" option that controls whe=
ther
> > > error reports on stderr get a timestamp. I think it is probably reaso=
nable
> > > for this existing option to apply to anything QEMU prints to stdout/e=
rr,
> > > and thus we could wire it up for qemu_log().
> >=20
> > I thought about that but the features are somewhat unrelated.
> >=20
> > If we unify them, how about making the timestamp/tid apply to *all*
> > qemu_log() output, not just tracing?
>=20
> That's exactly what I intended.
>=20
> Essentially if QEMU is going to add timestamps to things it writes to
> stdout/err, then it should do that universally for all parts of the code
> base that use stdio. This means error_report(), qemu_log(), and any
> other places that are relevant wrt stdio.
>=20
> Having separate timestamp on/off switches for each feature is not
> desirable.

Okay. I'll take a look at this tomorrow.

Thanks!

Stefan

--X35wERi4JU/f1kly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yFhkACgkQnKSrs4Gr
c8jScwf/Vwuncu8SvXwB9876y2Tr01ig5w19YjLirNu7pfu4TXkeIrp9sdUZ2v7v
HYCMqMFOXVLWp6wr6kySGUDFLyIQiLBEVkoCP+XTDT4dlnnS8E6QQICVjxlIxI2X
UEYZkT06G5XT+ICcVDgEq0KidEaqtZhFLJipd33d/9mHVvwNM6HCrm3shKmWR2CB
J6PHLaVDk+4YjHcRMI0uF9D16HAX00qljYPqjbVJNdpihCc3JDQy1sCbREugR8kp
/PiJE1M/htwZYNZO+2ik7eEL2Rf5gfuabxQdNJdxvifgMfSGjSNDYJCEyP5Jyd5m
rf1nwb5aJKHCridtaj4l7WRa+aGCGQ==
=8swd
-----END PGP SIGNATURE-----

--X35wERi4JU/f1kly--

