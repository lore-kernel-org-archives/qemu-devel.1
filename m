Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813AC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 23:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D437B20740
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 23:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiGz99IK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D437B20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF4yz-0001ca-S0
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 19:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jF4yR-0001EA-AM
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 19:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jF4yP-00054P-0a
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 19:53:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jF4yO-000512-NK
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 19:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584661991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sDJKi0wGTm+IoKyssIxTYidFF9nV4kvOq034Bq755iA=;
 b=XiGz99IKK0KOtUyIsPk2TS1dUUMmdDQPGi6HC7sM7rHgrRmz5yJE9T5sUDsP63tQhLWuVd
 KyHQq+kDqnnqG9m4UVAHYHXfuBPc/4mHY5xYdaIurc4ZDGknbBC38uuEttAE6peCPUHz0I
 ze4hzWHmI53bnKW4al9oKRe3xxgbfWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-sUJvKqekM_ej_0ZjA1B0_g-1; Thu, 19 Mar 2020 19:53:08 -0400
X-MC-Unique: sUJvKqekM_ej_0ZjA1B0_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A321EDB20;
 Thu, 19 Mar 2020 23:53:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-2.rdu2.redhat.com [10.10.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1986E5D9E2;
 Thu, 19 Mar 2020 23:53:02 +0000 (UTC)
Date: Thu, 19 Mar 2020 19:53:01 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200319235301.GA483056@localhost.localdomain>
References: <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
 <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
 <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sgi49uf6.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 05:33:01PM +0100, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On Tue, 17 Mar 2020 at 14:13, Cleber Rosa <crosa@redhat.com> wrote:
> >>
> >> On Tue, Mar 17, 2020 at 09:29:32AM +0000, Peter Maydell wrote:
> >> > Ah, I see. My assumption was that this was all stuff that you were
> >> > working on, so that I would then be able to test that it worked corr=
ectly,
> >> > not that I would need to do configuration of the gitlab.com setup.
> >
> >> So, I had to use temporary hardware resources to set this up (and set
> >> it up countless times TBH).  I had the understanding based on the list
> >> of machines you documented[1] that at least some of them would be used
> >> for the permanent setup.
> >
> > Well, some of them will be (eg the s390 box), but some of them
> > are my personal ones that can't be reused easily. I'd assumed
> > in any case that gitlab would have at least support for x86 hosts:
> > we are definitely not going to continue to use my desktop machine
> > for running CI builds! Also IIRC RedHat said they'd be able to
> > provide some machines for runners.

While GitLab let's you run x86 code for free with the "Linux Shared
Runners"[1], I don't think it would be suitable to what we're trying
to achieve.  It's limited to a single OS (CoreOS), single architecture
and really geared towards running containers.  BTW, if it isn't clear,
this is the approach being used today for the jobs defined on
".gitlab-ci.yml".

IMO we can leverage and still expand on the use of the "Linux Shared
Runners", but to really get a grasp oh how well this model can work
for QEMU, we'll need "Specific Runners", because we're validating
how/if we can depend on it for OS/architectures they don't support on
shared runners (and sometimes not even for the gitlab-runner agent).

>=20
> Correct!  As discussed at the QEMU summit, we'll gladly chip in runners
> to test the stuff we care about, but to match the coverage of your
> private zoo of machines, others will have to chip in, too.
>

I'm sorry I missed the original discussions, and I'm even more sorry
if that led to any misunderstandings here.

> >> OK, I see it, now it makes more sense.  So we're "only" missing the
> >> setup for the machines we'll use for the more permanent setup.  Would
> >> you like to do a staged setup/migration using one or some of the
> >> machines you documented?  I'm 100% onboard to help with this, meaning
> >> that I can assist you with instructions, or do "pair setup" of the
> >> machines if needed.  I think a good part of the evaluation here comes
> >> down to how manageable/reproducible the setup is, so it'd make sense
> >> for one to be part of the setup itself.
> >
> > I think we should start by getting the gitlab setup working
> > for the basic "x86 configs" first. Then we can try adding
> > a runner for s390 (that one's logistically easiest because
> > it is a project machine, not one owned by me personally or
> > by Linaro) once the basic framework is working, and expand
> > from there.
>=20
> Makes sense to me.
>=20
> Next steps to get this off the ground:
>=20
> * Red Hat provides runner(s) for x86 stuff we care about.
>=20
> * If that doesn't cover 'basic "x86 configs" in your judgement, we
>   fill the gaps as described below under "Expand from there".
>=20
> * Add an s390 runner using the project machine you mentioned.
>=20
> * Expand from there: identify the remaining gaps, map them to people /
>   organizations interested in them, and solicit contributions from these
>   guys.
>=20
> A note on contributions: we need both hardware and people.  By people I
> mean maintainers for the infrastructure, the tools and all the runners.
> Cleber & team are willing to serve for the infrastructure, the tools and
> the Red Hat runners.

Right, while we've tried to streamline the process of setting up the
machines, there will be plenty of changes to improve the automation.

More importantly, maintaining the machines is very important to the
super important goal of catching code regressions only, and not facing
other failures.  Mundane tasks such as making sure enough disk space
is always available can be completely change the perception of the
usefulness of a CI environment.  And for this maintenance, we need
help from people "owning" those machines.

>=20
> Does this sound workable?
>=20
> > But to a large degree I really don't want to have to get
> > into the details of how gitlab works or setting up runners
> > myself if I can avoid it. We're going through this migration
> > because I want to be able to hand off the CI stuff to other
> > people, not to retain control of it.
>=20
> Understand.  We need contributions to gating CI, but the whole point of
> this exercise is to make people other than *you* contribute to our
> gating CI :)
>=20
> Let me use this opportunity to say thank you for all your integration
> work!
>=20
>

^ THIS.  I have to say that I'm still amazed as to how Peter has
managed to automate, integrate and run all those tests in such varied
environments for so long.  Major kudos!

- Cleber.

[1] https://docs.gitlab.com/ee/user/gitlab_com/#linux-shared-runners

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl50BdkACgkQZX6NM6Xy
CfOsPQ//VM6LuSltGeAYA+nWeUrYCt+oJL6vyNEEUQmQiNFKK2EDlKz5S6xRf5QK
biEtUMTwgbtpa+3CiWT8jeLQZSwQADzFBIDfpewJvQdhdmwWTyy2nteUpOx2pouq
v9uaN9dQrU1/fn9ut9TGjjJIQgYxBG5VKjnHIfwIggdXC5SibEte3HMRWZMLGzM9
+oKAevczMZWKfHS1aGgAdAGXpqd5bjAdK5dYaDehWmVLEXlCKlIW96uOizJPvAGy
vRasAZUGfK3z4UTq3Sn/N9aPoniG1L5u70QszJJbnSqNLthwKc/nlUS8Ga4CWKbR
LRrINWFH4mMuCIKzWMK32bBUC9eCfaJa/HMnWsy4sZ8RAQf11Zm/wWV8Jz7mUChu
NR9q1Dh4l+LUp2PY9qUeJrKndd+6RaD2MExVcr2cnAPsx99wRBbX4SW1lobowwVy
2w+xjvTU5wahsZ8HYQprdx2o+siWZTQQs5m8Kk4nL5k7VC6ZMYbPsdXEvgpHxaC9
FMSu7DxCZW093PKbLjQjlHXU79L3ZVYLbK/r1BBkGWRsVdaYg+L2xl0elLbklrFs
MoloULfzo7slXUizJnFImYPZE3KsCmQ9vGn9ky6URJGyEaq1+22yBmSrLMnJ0XUQ
UOWOmJGMnxKsWc89nE+Qk4kS6B2UJlZMTrgSYd9r+TKclWBI8bQ=
=wf9P
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--


