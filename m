Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728A5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F36A2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxYScqoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F36A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSo6y-0003bi-Ha
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 17:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSo6F-00039V-1v
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSo68-0007TB-I1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602710050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0irtddWdIx0Ihh5L2K/7OGXY9ZD2grxjI4eo9FnXexU=;
 b=GxYScqoAweC9WaIkZleovHKQxi1VyF06PBN+Z6kMiwNGA5noyq3pazMAL+Fas0TCPhNsT5
 gso+7033+TanE76h+gBBOD6eWoxa6MslQZLdjvzxavT0oERnUcjvZsHZV+z9/456VMH6KD
 AFSeJ10PiFaT+28ZByxge97kb6HkPc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-10KvuxFIMoCgWcxuuY5cBg-1; Wed, 14 Oct 2020 17:14:03 -0400
X-MC-Unique: 10KvuxFIMoCgWcxuuY5cBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE48464082;
 Wed, 14 Oct 2020 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D787C5D9CD;
 Wed, 14 Oct 2020 21:13:57 +0000 (UTC)
Date: Wed, 14 Oct 2020 17:13:56 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 4/4] Jobs based on custom runners: add job definitions
 for QEMU's machines
Message-ID: <20201014211356.GA1199212@localhost.localdomain>
References: <20201014052140.1146924-1-crosa@redhat.com>
 <20201014052140.1146924-5-crosa@redhat.com>
 <20201014174655.GW115189@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014174655.GW115189@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 06:46:55PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Oct 14, 2020 at 01:21:40AM -0400, Cleber Rosa wrote:
> > The QEMU project has two machines (aarch64 and s390) that can be used
> > for jobs that do build and run tests.  This introduces those jobs,
> > which are a mapping of custom scripts used for the same purpose.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  .gitlab-ci.d/custom-runners.yml | 192 ++++++++++++++++++++++++++++++++
> >  1 file changed, 192 insertions(+)
> >=20
> > diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runn=
ers.yml
> > index 3004da2bda..5b51d1b336 100644
> > --- a/.gitlab-ci.d/custom-runners.yml
> > +++ b/.gitlab-ci.d/custom-runners.yml
> > @@ -12,3 +12,195 @@
> >  # strategy.
> >  variables:
> >    GIT_SUBMODULE_STRATEGY: recursive
> > +
> > +# All ubuntu-18.04 jobs should run successfully in an environment
> > +# setup by the scripts/ci/setup/build-environment.yml task
> > +# "Install basic packages to build QEMU on Ubuntu 18.04/20.04"
> > +ubuntu-18.04-s390x-all-linux-static:
> > + needs: []
> > + stage: build
> > + tags:
> > + - ubuntu_18.04
> > + - s390x
> > + rules:
> > + - if: '$CI_COMMIT_BRANCH =3D~ /^staging/'
>=20
> IIRC, in the previous v2 (or was it v1) we discussed changing this
> so that users who provide their own runners, don't have to always
> use the "staging" branch name.
>

Right, and what I got from that is that users can use a *prefix* as a
flag to indicate that they want the extra set of jobs.

> IIUC, the key thing is that we don't want the job running on the
> "master" or "stable-*" branches in the primary QEMU git. So could
> check
>=20
>    $CI_PROJECT_NAMESPACE =3D=3D 'qemu-project'
>    &&
>    $CI_COMMIT_BRANCH !~ '^master$'
>    &&
>    $CI_COMMIT_BRANCH !~ '^stable-$'
>=20
> which would let it work on users forks no matter what branch names
> they use
>=20
> What happens to the job if the user doesn't have runners ? Is it
> simply skipped, or does the pipeline stall and get marked as failed ?
>

The pipeline gets "stuck" (literaly, that's the status name it gets).
That's the main issue that made me believe that opting *in* (by using
a common branch name prefix) was the simpler solution.

> If the jobs aren't auto-skiped, we would need to add an env variable
>=20
>    (
>    $CI_PROJECT_NAMESPACE =3D=3D 'qemu-project'
>    &&
>    $CI_COMMIT_BRANCH !~ '^master$'
>    &&
>    $CI_COMMIT_BRANCH !~ '^stable-$'
>    )
>    ||
>    $QEMU_ENABLE_CUSTOM_RUNNERS =3D=3D 'yes'
>=20
> and require the user to set the QEMU_ENABLE_CUSTOM_RUNNERS variable
> in the web UI for their fork
>

We can do that, but I think it's more than we need.  The odds that a
user will have all of the same runners, and will be able to run all
the extra jobs, are very very low IMO.  Right from the start, very few
people have an s390 machine running Ubuntu 18.04.

So, I believe that whenever a user pushes to a branch such as
"staging-topic-foo", he will have to deal with some of the extra jobs
(such as canceling the ones that will never run) anyway.  Having to
deal with those on every single push, or alternatively having to turn
on/off $QEMU_ENABLE_CUSTOM_RUNNERS doesn't the best experience to me.

The "staging" prefix convention (with a better prefix name now or in
the future?) seems to result in the best experience to me.

> That all said, I don't mind if you postpone this rules change to a
> followup patch.
>

OK, let me know if you agree with my explanation above, or if you
really want to see a followup patch.

> > + script:
> > + # --disable-libssh is needed because of https://bugs.launchpad.net/qe=
mu/+bug/1838763
>=20
> This bug links to
>=20
>   https://bugs.launchpad.net/ubuntu/+source/libssh/+bug/1847514
>=20
> which is marked as fixed. So I'm thinking we can drop the --disable-libss=
h
> arg from all these jobs
>

OK, I'll double check that and, if the fix is comfirmed beyond the bug
tracker, I'll update it.

Thanks!
- Cleber.

> > + # --disable-glusterfs is needed because there's no static version of =
those libs in distro supplied packages
> > + - mkdir build
> > + - cd build
> > + - ../configure --enable-debug --static --disable-system --disable-glu=
sterfs --disable-libssh
> > + - make --output-sync -j`nproc`
> > + - make --output-sync -j`nproc` check V=3D1
> > + - make --output-sync -j`nproc` check-tcg V=3D1
>=20
>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+HahEACgkQZX6NM6Xy
CfOisw//QBiT5TM+Psf3uWzHZuqtm+1KaOeMp0J4nAzzKqSf7bnCBqkYQuYnQkQn
9t+Un91CLUvJbwXueuzYv0Jvy72zFdxrmsd3zn9PN+K1BRHa4eB34iVsG2/u+BDr
UAS8wTOjHksRqXHOXQsDgYBU4SmdDXC4enU7hdfqstc9Mk7VGoOvct+g4XAVDtKn
Lr2XezouLsjUbaESvovF/6OynoXhGruybNUMmoq/+TkEDIENBrlsE4lne8grebmM
ua7J29EYEbwBax5BM/pZnq+0W1Q8MBvdnZ8B5Su5j9mrer2f+QFktITsgt5K+FEi
Hq9MTSPYw1ukC9Dc6bhHPVl+c6fjB5oIKjwHpKI9IQM2CQT73VXIHrC03KLjuFs7
y/vL165EGnC+g4aRZ6O/mr1B8udGrW4gl3KXIbX5E6ea1hps6/5j9ZFc3jsU7J7o
vYoR5Wn5XEEATGukzUYS3IaTAykiloKUqCYWI2FaX3cdb7qLwx8DXy1UsFWjoxpH
l/QRSJQC45q0ydBdD5MrLmMSAjnuX0zAfIWNXfi3cT41U5/fYsVqikZWBGWPwKM+
vGzQjmFtfrS/A9FMlF39rTtaA6nTpfU3v/kCc+paRRNAH75lQRVrvuP1JuzblyXO
Dc/L7I4Sh6h6/m8bJQZV4pJpFQo0Cnkhq2UwpMoSgIbhuR1PuWg=
=YjFu
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--


