Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70291C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD07206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhUlDpwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD07206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDzjs-0004Xe-9X
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 20:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDziZ-0003xQ-Th
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDziX-0008GW-C0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599179795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2KIz9q6QiAbh7Do4J0nHWkg6uYef3dyM7oNRV5PPms=;
 b=BhUlDpwun87R7CbPUHI7bjkmGOOanuyzWg1T3s2YTh1RROXwLHQFgjZai2zXHT7H5ltmVU
 4aqKz46dvQn5R1CBD/R/iAV+kCYp19RXn403vKiwf+qb8e4T1u/hWDKVNCzLIQ7qnox1Pe
 /0Zk8ppha71oRGuD7WbcivZ5VZTfatw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-U1CXXJ4PMN-TyxoU6xUoAQ-1; Thu, 03 Sep 2020 20:36:30 -0400
X-MC-Unique: U1CXXJ4PMN-TyxoU6xUoAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 756E710BBEC2;
 Fri,  4 Sep 2020 00:36:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68F7B1002D57;
 Fri,  4 Sep 2020 00:36:25 +0000 (UTC)
Date: Thu, 3 Sep 2020 20:36:23 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200904003623.GG55646@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200729101629.GA37763@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200729101629.GA37763@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 20:18:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2020 at 11:16:29AM +0100, Stefan Hajnoczi wrote:
> On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
>=20
> Awesome, thanks for creating this stuff! Minor suggestions:
>=20
> > diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> > index c1ff24370b..f8dab788ea 100644
> > --- a/docs/devel/testing.rst
> > +++ b/docs/devel/testing.rst
> > @@ -1003,3 +1003,150 @@ exercise as many corner cases as possible. It i=
s a useful test suite
> >  to run to exercise QEMU's linux-user code::
> > =20
> >    https://linux-test-project.github.io/
> > +
> > +CI
> > +=3D=3D
> > +
> > +QEMU has configurations enabled for a number of different CI services.
> > +The most update information about them and their status can be found
> > +at::
> > +
> > +   https://wiki.qemu.org/Testing/CI
> > +
> > +Gating CI
> > +----------
> > +
> > +A Pull Requests will only to be merged if they successfully go through
> > +a different set of CI jobs.  GitLab's CI is the service/framework used
>=20
> s/A Pull Requests/Pull Requests/
> s/will only to be merged/will only be merged/
>=20
> I suggest simplifying the first sentence:
>=20
>   Code is only merged after passing the "gating" set of CI jobs.
>=20
> Whether they are called Pull Requests or Merge Requests shouldn't matter
> :).
>

Yep, makes sense.

> > +for executing the gating jobs.
> > +
> > +The architecture of GitLab's CI service allows different machines to b=
e
> > +setup with GitLab's "agent", called gitlab-runner, which will take car=
e
>=20
> s/setup/set up/ throughout this document
> https://grammarist.com/spelling/set-up-vs-setup/
>

Nice catch, thanks.

> > +of running jobs created by events such as a push to a branch.
> > +
> > +Even though gitlab-runner can execute jobs on environments such as
> > +containers, this initial implementation assumes the shell executor is
> > +used, effectively running jobs on the same machine (be them physical
>=20
> s/them/they/
>=20
> > +or virtual) the gitlab-runner agent is running.  This means those
>=20
> s/the/where the/
>

Right, thanks.

> > +machines must be setup in advance, with the requirements matching the
> > +jobs expected to be executed there.
> > +
> > +Machine configuration for gating jobs
> > +-------------------------------------
> > +
> > +The GitLab's CI architecture allows different parties to provide
> > +different machines that will run different jobs.  At this point, QEMU
> > +will deploy a limited set of machines and jobs.  Documentation and/or
> > +scripts to setup those machines is located under::
> > +
> > +  scripts/ci/setup
> > +
> > +Ansible playbooks have been provided to perform two different tasks
> > +related to setting gitlab-runner and the build environment.
>=20
> s/setting/setting up/
>=20
> > +
> > +Other organizations involved in QEMU development may, in the near
> > +future, contribute their own setup documentation/scripts under
>=20
> Comments about relative time lack context in a long-lived document like
> this one:
> s/in the near future//
>

You're right.  That was already bothering but I couldn't tell why.

> > diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/=
build-environment.yml
> > new file mode 100644
> > index 0000000000..89b35386c7
> > --- /dev/null
> > +++ b/scripts/ci/setup/build-environment.yml
> > @@ -0,0 +1,217 @@
> > +---
> > +- name: Installation of basic packages to build QEMU
> > +  hosts: all
> > +  vars_files:
> > +    - vars.yml
> > +  tasks:
> > +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
> > +      apt:
> > +        update_cache: yes
> > +        # This matches the packages on tests/docker/Dockerfiles/ubuntu=
1804.docker
>=20
> These comments will not age well :). If you really want to leave a note
> then I suggest "Originally from
> tests/docker/Dockerfiles/ubuntu1804.docker".
>=20
> > diff --git a/scripts/ci/setup/inventory b/scripts/ci/setup/inventory
> > new file mode 100644
> > index 0000000000..8bb7ba6b33
> > --- /dev/null
> > +++ b/scripts/ci/setup/inventory
> > @@ -0,0 +1,2 @@
> > +[local]
> > +localhost
> > diff --git a/scripts/ci/setup/vars.yml b/scripts/ci/setup/vars.yml
>=20
> Perhaps this file can be called vars.yml.template and an entry for
> vars.yml can be added to .gitignore. A file that needs local editing
> should not be commited to git in-place. Otherwise it's easy to
> accidentally commit the local changes to git (and expose the private
> GitLab token!).

Right... Philippe has already suggested this, and you've definitely
increased its significance with the data leak example.  So yes, let's
do this rename.

Thanks for the feedback and suggestions!
- Cleber.

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9RjAQACgkQZX6NM6Xy
CfNkahAAjBRC7hkbk5kjJ5QEd7jkR8BlJ1zTVjrnE3NBbBQMdC16aOITZjBWxQp1
OAKCDdxF4/ZsVFVfe51MAsAnnujI1FAjRNpKWSTGy6QivyRu3zP8c+Y9ngNdwWs3
g8exTvkMg1aTxYEKMdPdO2aHAPxMwPL9s40fqj3Kciynaz7vwm2jIZD4pKsg/GOi
AurvI9lS52zE7QwwSSmwKPgqyFRIOdahUAl+5sc/EqGsTT/4s30VgVBuF8bIFKIu
wyh33J7r43U80tZYoyAoLMqussrEGiaj7apC2EUtGDk6k6a9zJAriIQC5Z3q2QXk
fLNtpIGCRnGyEs+m6NHZrJiR8ol+bfbOCSxkptSaUEeqiEmEFZitPngObrwqqDN1
AhU48+RnZYNm3qPM+GkTy9G3ReGGXeOtjdJd/56CBOKa4bpxL1aQRtAZXz53BFDs
66UjAYr9BbgxWr5QWRBSibYL/UnhtQtYVZCg2t+YkhUZOZPp1Yft7uFWb53uAprV
G3JnR+4h9vH6IFqxQW4hJ/gGfhZ+pb+uJVGH9180jlfRwbJ6Ff9q7TKKKbD4unaD
eaKsMJWtAfLrRi62xqf4FKoe7kcxP9uAZd8gIijsDl0r4yR8/AIjzZk4u6poFfMg
XjQcO07EkmPYYrn8yA+WCW6cW+yR4/JuV9iuyWRm8RI8W4BtxX8=
=7TAl
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--


