Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D94C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933AE223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fr4Gs56A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933AE223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUbzf-0008DB-F9
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 16:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUbye-0007cb-OX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kUbyY-0005Gt-In
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 16:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603140109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ph3p+vEWnbDD3Zo+obd7qp2UFh+F+DyX3JqeFvKDd/w=;
 b=fr4Gs56AGaYV6aCvWHPzaqAd5A5iffX/w6EjR1bEisLJMmL5GpqgaZp0qzbCL5OvGbIw3e
 ir7nxV+r3zg5/7F+/I4GazYZEeFosPBS3bJfqJbB613455otDc6XwOe3jNBzg20GkTAGle
 4cim3YXpm4bGSAGT0+LG28cZCCkW/aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-i5HyksAfMuS-sgwY6JsnCA-1; Mon, 19 Oct 2020 16:41:46 -0400
X-MC-Unique: i5HyksAfMuS-sgwY6JsnCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1D361006C83;
 Mon, 19 Oct 2020 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91D3A6EF42;
 Mon, 19 Oct 2020 20:41:40 +0000 (UTC)
Date: Mon, 19 Oct 2020 16:41:38 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH v4 3/4] Jobs based on custom runners: docs and
 gitlab-runner setup playbook
Message-ID: <20201019204138.GC1617151@localhost.localdomain>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-4-crosa@redhat.com>
 <20201019102610.GB495479@nautilus>
MIME-Version: 1.0
In-Reply-To: <20201019102610.GB495479@nautilus>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 15:28:27
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 12:26:10PM +0200, Erik Skultety wrote:
> On Sun, Oct 18, 2020 at 09:50:02PM -0400, Cleber Rosa wrote:
> > To have the jobs dispatched to custom runners, gitlab-runner must
> > be installed, active as a service and properly configured.  The
> > variables file and playbook introduced here should help with those
> > steps.
> >=20
> > The playbook introduced here covers a number of different Linux
> > distributions and FreeBSD, and are intended to provide a reproducible
> > environment.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > ---
>=20
> In general, there's been put quite some effort into the playbooks - sorry=
 I'm
> late to the game - is there a plan to introduce QEMU as a project to lcit=
ool?

I think it's becoming quite clear that having so much duplication (in
the dockerfiles, tests/vm, this playbook, etc) is costly and error
prone.  I don't know if anyone has invested time in a PoC to
consolidate those (with lcitool), but I can certainly see the upside
to that.  BTW, are you volunteering (wink wink)? :)

> We've taken care of most of the bits in the playbooks that are being intr=
oduced
> and for the remaining ones I think it would be that big of an overhaul to=
 do
> the adjustments. One major re-factor though would IMO be to break the
> dependency lcitool has on the machine naming, kind of restricting it to a
> limited set of hosts and corresponding names (e.g. libvirt-fedora-32) whi=
ch
> makes it inconvenient to prepare physical hosts.
>

Right... I wasn't aware of that depedency.  And, this may be a nice
project to make sure that lcitool doesn't have any other libvirt
specificities.

> More comments inline...
>=20
> >  docs/devel/ci.rst                  | 63 ++++++++++++++++++++++++++
> >  scripts/ci/setup/.gitignore        |  1 +
> >  scripts/ci/setup/gitlab-runner.yml | 72 ++++++++++++++++++++++++++++++
> >  scripts/ci/setup/vars.yml.template | 13 ++++++
> >  4 files changed, 149 insertions(+)
> >  create mode 100644 scripts/ci/setup/.gitignore
> >  create mode 100644 scripts/ci/setup/gitlab-runner.yml
> >  create mode 100644 scripts/ci/setup/vars.yml.template
> >=20
> > diff --git a/docs/devel/ci.rst b/docs/devel/ci.rst
> > index 208b5e399b..a234a5e24c 100644
> > --- a/docs/devel/ci.rst
> > +++ b/docs/devel/ci.rst
> > @@ -84,3 +84,66 @@ To run the playbook, execute::
> > =20
> >    cd scripts/ci/setup
> >    ansible-playbook -i inventory build-environment.yml
> > +
> > +gitlab-runner setup and registration
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The gitlab-runner agent needs to be installed on each machine that
> > +will run jobs.  The association between a machine and a GitLab project
> > +happens with a registration token.  To find the registration token for
> > +your repository/project, navigate on GitLab's web UI to:
> > +
> > + * Settings (the gears like icon), then
> > + * CI/CD, then
> > + * Runners, and click on the "Expand" button, then
> > + * Under "Set up a specific Runner manually", look for the value under
> > +   "Use the following registration token during setup"
> > +
> > +Copy the ``scripts/ci/setup/vars.yml.template`` file to
> > +``scripts/ci/setup/vars.yml``.  Then, set the
> > +``gitlab_runner_registration_token`` variable to the value obtained
> > +earlier.
> > +
> > +.. note:: gitlab-runner is not available from the standard location
> > +          for all OS and architectures combinations.  For some systems=
,
> > +          a custom build may be necessary.  Some builds are avaiable
> > +          at https://cleber.fedorapeople.org/gitlab-runner/ and this
> > +          URI may be used as a value on ``vars.yml``
>=20
> Yes, this can be suboptimal...Would it make sense to fall back to build t=
he
> binary of a given version from git as a fallback during this playbook if =
the
> necessary arch version isn't provided the official way? Just an idea, I'd=
 like
> to avoid the need for you to become the maintainer of the binaries and ke=
ep up
> with the releases.
>

Well, building them during the playbook would be a lot more
complex... You can have your own repo with your own builds, and just
tweak your vars.yml.

> > +
> > +To run the playbook, execute::
> > +
> > +  cd scripts/ci/setup
> > +  ansible-playbook -i inventory gitlab-runner.yml
> > +
> > +.. note:: there are currently limitations to gitlab-runner itself when
> > +          setting up a service under FreeBSD systems.  You will need t=
o
> > +          perform steps 4 to 10 manually, as described at
>=20
> Which one of them is considered an automation problem? In lcitool we made
> gitlab-runner completely automated on all distros, including FreeBSD:
>

It looks like lcitool went the more practical route.  I was hoping to
not have to treat gitlab-runner in such a special way in any
"supported" OS.  What I mean is, I'd rather write the code within
gitlab-runner (or reespective libraries).  Of course, I did not get to
it, so that's why I just documented the steps here.

I'll take a look at lcitool's playbook to see if I can easily
canibalize some of that.  But, at this time, we don't runners for
FreeBSD anyway, so I guess this is not *that* urgent.

> 4) log file permissions - you're creating the user, you can as well creat=
e the
> file with correct permissions
>=20
> 5) ensure /usr/local/etc/rc.d exists - once you execute build-environment=
.yml
> it will pull a bunch of dependencies which ensure the dir exists
>=20
> 6) gitlab_runner service script should IMO provided by this automation as=
 a
> template and install to the correct location
>=20
> 7) ensure the service script is executable - template module can do that
>=20
> 8) register the runner - you're doing that
>=20
> 9) enable the service - Ansible's service module is generic and supports
> init/OpenRC
>=20
> 10) I don't see a step 10
>

This was either a mistake or the installation steps got updated.  I'll
adjust that.

> IOW I think there should be as little manual intervention as possible and=
 in
> this case I don't think any manual steps are needed by the user.
>

Agreed.  I was not super happy with the current state of this playbook
wrt FreeBSD, but I decided to pick other battles to fight.  Also,
newer gitlab-runner versions *may* be using the updated service
management lib, which may reduce/remove the need for custom handling.

Anyway, I'll look at what can be improved here, considering the cost.

Thanks!
- Cleber.

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+N+gAACgkQZX6NM6Xy
CfPf9g/9H+BCKuP9o4F5K2FpVoxv1mtb/CrqvnNZ/ra+TOsyvIkAKmfVhtjcoiqV
85rcckUt5uwXM06kSqWSVpgQNJnVfn9POIvmTlMYalQuwMf9VuMJCWJ2Gfnkfdan
/taJrGq+C68fW7WsCjIbb7FmAU7cCDnelXpB0B33TsF2o9RJ78zCDLNYkb04yda6
YGkpZe8VO75mtcrWiHQeEClrmp4FnqniFlj7DYBRsP4/2RfgL4HB5gQJc7oWB7S/
oiAe3oQqwDf6pfPKGEKHdK18yw3LjcT6RrnRAm8HUYK1zbgWSU8ozed/Z8GZGcId
G/qVTOjLPkj+QIIfJ2KQc9df21wC4SMy/bUNPYgSZ4IBS3o9Keru4R5HFJADUn5e
UAje0Z4dD2M9Zwqq7lYMvCLV6YPtiYbjHAaZQVTGUifL1nLVk54fESkhxrWRq/me
NbP7pFbif2G8CKGahrsEHUJHfMJMuyLzcxZiFnIBBhTCw2mrnZr5aEYbQcQ/31X7
KqsFhK5lFEbCTTpFwSCvFyim1ZavI6MP8CPxPWMmonm7LRKhrimSuaPhCjCF0pJ2
yvMW3uF5JHIMCsf+BUfCwsfImu2TkUcA4ATJIs3WpZQPCElCyRvs7zpfRwafe4/5
TZ7paQFCC4SEl6h2azfTnJy1cRDhlveX1yuMcgJPrLxUtdwx04I=
=5+nc
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--


