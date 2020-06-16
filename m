Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD62C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 01:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1352071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 01:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKJDt31X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1352071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl0QB-0003ou-0h
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 21:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jl0PX-0003Ow-5C
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 21:29:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jl0PU-00049v-RR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 21:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592270947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lLL+4mWRek0Q2hjgdn4+4J85OFVItdJLqy+8zGRy7Mk=;
 b=eKJDt31XrHYbVKD9xhMVtHDmsrN0IOPTutoJfYljKCcxX+Q3D0fVzLFGLKawelEtFLG76K
 fkuEfuH2EdTTsfuupPy2E3MQ+aUR8JWvXXHd8i9sSg0IzdlhE0zQJDrqN8Msu4sTr9rEMZ
 pAKSnByp0D62KiOx+sv7sbaLY4AeUlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-RtPF6px5NgyVuWqn0WPToQ-1; Mon, 15 Jun 2020 21:27:37 -0400
X-MC-Unique: RtPF6px5NgyVuWqn0WPToQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3981210059A0;
 Tue, 16 Jun 2020 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-214.rdu2.redhat.com
 [10.10.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E269660BEC;
 Tue, 16 Jun 2020 01:27:31 +0000 (UTC)
Date: Mon, 15 Jun 2020 21:27:30 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200616012730.GA247965@localhost.localdomain>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
In-Reply-To: <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 21:27:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2020 at 01:04:13PM -0400, Cleber Rosa wrote:
>=20
>=20
> ----- Original Message -----
> > From: "Peter Maydell" <peter.maydell@linaro.org>
> > To: "Markus Armbruster" <armbru@redhat.com>
> > Cc: "Fam Zheng" <fam@euphon.net>, "Thomas Huth" <thuth@redhat.com>, "Be=
raldo Leal" <bleal@redhat.com>, "Erik
> > Skultety" <eskultet@redhat.com>, "Alex Benn=E9e" <alex.bennee@linaro.or=
g>, "Wainer Moschetta" <wmoschet@redhat.com>,
> > "QEMU Developers" <qemu-devel@nongnu.org>, "Wainer dos Santos Moschetta=
" <wainersm@redhat.com>, "Willian Rampazzo"
> > <wrampazz@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Philippe Math=
ieu-Daud=E9" <philmd@redhat.com>, "Eduardo
> > Habkost" <ehabkost@redhat.com>
> > Sent: Tuesday, April 21, 2020 8:53:49 AM
> > Subject: Re: [PATCH 0/5] QEMU Gating CI
> >=20
> > On Thu, 19 Mar 2020 at 16:33, Markus Armbruster <armbru@redhat.com> wro=
te:
> > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > > I think we should start by getting the gitlab setup working
> > > > for the basic "x86 configs" first. Then we can try adding
> > > > a runner for s390 (that one's logistically easiest because
> > > > it is a project machine, not one owned by me personally or
> > > > by Linaro) once the basic framework is working, and expand
> > > > from there.
> > >
> > > Makes sense to me.
> > >
> > > Next steps to get this off the ground:
> > >
> > > * Red Hat provides runner(s) for x86 stuff we care about.
> > >
> > > * If that doesn't cover 'basic "x86 configs" in your judgement, we
> > >   fill the gaps as described below under "Expand from there".
> > >
> > > * Add an s390 runner using the project machine you mentioned.
> > >
> > > * Expand from there: identify the remaining gaps, map them to people =
/
> > >   organizations interested in them, and solicit contributions from th=
ese
> > >   guys.
> > >
> > > A note on contributions: we need both hardware and people.  By people=
 I
> > > mean maintainers for the infrastructure, the tools and all the runner=
s.
> > > Cleber & team are willing to serve for the infrastructure, the tools =
and
> > > the Red Hat runners.
> >=20
> > So, with 5.0 nearly out the door it seems like a good time to check
> > in on this thread again to ask where we are progress-wise with this.
> > My impression is that this patchset provides most of the scripting
> > and config side of the first step, so what we need is for RH to provide
> > an x86 runner machine and tell the gitlab CI it exists. I appreciate
> > that the whole coronavirus and working-from-home situation will have
> > upended everybody's plans, especially when actual hardware might
> > be involved, but how's it going ?
> >=20
>=20
> Hi Peter,
>=20
> You hit the nail in the head here.  We were affected indeed with our abil=
ity
> to move some machines from one lab to another (across the country), but w=
e're
> actively working on it.
>=20
> From now on, I'll give you an update every time a significant event occur=
s on
> our side.
>

Hi all,

It took a while, but I finally have some updates, and they're pretty
good news.

Red Hat is sponsoring 3 x86_64 machines that will act as runners for
the QEMU CI, and together with QEMU's own s390 and aarch64 machines (1
each), we have enough hardware now for a reasonable build and test
coverage.

The s390 and aarch64 machines are already up and running, and the
x86_64 machines are being racked up, but should be up and running
in the next few days.  I'm working on an updated version of this
series that takes into account this new scenario, and some
fixes and improvements.

And as a reminder, if you (individual or organization) would like to
sponsor hardware or people to expand the QEMU build and test coverage,
please reach out to us.

Thanks,
- Cleber.

> > thanks
> > -- PMM
> >=20
> >=20
>=20
> Thanks for checking in!
> - Cleber.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl7oH/4ACgkQZX6NM6Xy
CfNuJBAAtapja2AA483tbNcSJ4CO/D3n0mceYsNgxCpD0IWrh631VYrPOSi5/TlT
lDKmZKeILVsu3GrEVpTzqlGH5JqYcKck35WdNWXDSQIAmcxm/e+0qggaDalfT/gb
ImtuNuvQF68n4mFmFiqfSpHg5l9BronFUjjxfxaC1qCH3ZK6MUuxWvuZOi7uhAmu
muEWnCvmqoedXxJN6uZ0pmPdnvJP4W29in89L7tyV+NM66M5IOOxUlGbVgVTTSLT
YzSB9K1wm83hdZG9bDmyqmvoTbG8zt9qLf4Rgoe8jBb7kA1s4dh54r7htW3gLOHW
djZDuOFCxaMabhuGBQjf4bScSj2OrI/047Lr6zHhS+XMGA2pA+hAF4TOfpCQDqzL
xJH+YUYwD62aY68hpuW2o0xynvLF0tRGrecUVc0a1sSXT23WEg+FSgFyd2SYgRxV
l1IKr/m/s1QXuhZVd/dSQ3WZejcpSjffXMbpGrI/hJD+lOLP2REy6cdyaw/Dpnol
s6XdhMdNBmQmTER3JKnJOZ2gwtnuTu5Gyg1hfAp7qRTRJeSY1Vu320UeO2qG0jUz
40otNn/xEa4NOaEbSHhjQaj7aBnkyMPAErN33J+aKknDt+a5oPRVQuMdX2vhQXrp
sgkKt6nIk+Oz5fiBty/O18C3X3r6P4JI3DCOskNoxdZwnrdLxBw=
=bLxi
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


