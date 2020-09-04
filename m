Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49E3C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79219206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SH289MsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79219206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECtp-0003yt-Kx
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kECtB-0003RF-ME
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:40:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28051
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kECt8-000552-0P
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599230424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74mTKb/A7pnooVOMA3LbZQ2u8f7ZLBnlbUT2deWfVr4=;
 b=SH289MsN7cNsQAexe+ILtWEUmZX5Cpfn4od8scVA+UtpkOVfd6gond4wetrqEUI9HM7VJX
 aHBSb52yJmVIfyKfLoEKzHQzsZk/Gx8lqaVcdevUQGOHzqw9y1W6iSjm0ya88n2/dj5lql
 gF0//mPodXZ6iruhGyaebmzT8aD24+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-of3bJar-P_6UGNknCa9Abg-1; Fri, 04 Sep 2020 10:40:19 -0400
X-MC-Unique: of3bJar-P_6UGNknCa9Abg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D64C1008304;
 Fri,  4 Sep 2020 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32B975C1D0;
 Fri,  4 Sep 2020 14:40:08 +0000 (UTC)
Date: Fri, 4 Sep 2020 10:40:06 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200904144006.GB232153@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709103029.GK3753300@redhat.com>
 <a462a7e1094fea39e13436a940ef91bec809a8fc.camel@redhat.com>
 <20200904001817.GF55646@localhost.localdomain>
 <20200904082347.GC721059@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904082347.GC721059@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 09:23:47AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Sep 03, 2020 at 08:18:17PM -0400, Cleber Rosa wrote:
> > On Thu, Jul 09, 2020 at 01:28:27PM +0200, Andrea Bolognani wrote:
> > > On Thu, 2020-07-09 at 11:30 +0100, Daniel P. Berrang=E9 wrote:
> > > > On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > > > > +- name: Installation of basic packages to build QEMU
> > > > > +  hosts: all
> > > > > +  vars_files:
> > > > > +    - vars.yml
> > > > > +  tasks:
> > > > > +    - name: Install basic packages to build QEMU on Ubuntu 18.04=
/20.04
> > > > > +      apt:
> > > > > +        update_cache: yes
> > > > > +        # This matches the packages on tests/docker/Dockerfiles/=
ubuntu1804.docker
> > > >=20
> > > > I'd be inclined to actually use docker on the custom runners.
> > > >=20
> > > > eg. instead of having separate physical machines or VMs for each
> > > > (distro, arch) pair, have a single host distro for the arch. Then
> > > > use docker to provide the build environment against each distro.
> > > >=20
> > > > IOW, a RHEL-8 aarch64 host, running docker for ubuntu18.04, fedora3=
0
> > > > etc.
> > > >=20
> > > > That way we don't end up duplicating all these packages, and instea=
d
> > > > can use  tests/docker/Dockerfiles/ubuntu1804.docker.  This ensures
> > > > that if a user needs to reproduce a build failure on their own loca=
l
> > > > aarch64 machine, they can run docker and get the exact same build
> > > > architecture.
> > > >=20
> > > > It also has the benefit that we don't need to worry about how to
> > > > setup gitlab runners for every distro we care about. We only need t=
o
> > > > do gitlab runner for the standard host distro, which spawns a prist=
ine
> > > > throwaway docker env.
> > > >=20
> > > > I appreciate this is a big change from what you've done in this pat=
ch
> > > > though, so don't consider this comment a blocker for initial merge.
> > > > I think we should do this as the long term strategy though. Essenti=
ally
> > > > for Linux builds, everything should always be container based.
> > >=20
> > > Agreed. You should be able to set up a fairly minimal environment,
> > > which consists of Docker, gitlab-runner and not much else, using a
> > > long-term supported distro such as CentOS and then just schedule
> > > whatever container build on it. No need to provision a new machine
> > > every time a new Fedora release comes out, just create a container
> > > image for it and add it to the mix.
> > >
> >=20
> > Hi Andrea,
> >=20
> > There's nothing preventing this from happening, but limiting the
> > runners to this configuration, prevents a lot more from happening.
> >=20
> > > Additionally, the gitlab-runner Docker executor provides more
> > > isolation than the shell executor, so running untrusted builds
> > > becomes a more reasonable proposition - this is how the shared
> > > runners on gitlab.com work - and you don't have to worry about your
> > > jobs cleaning up properly after themselves nearly as much.
> > >
> >=20
> > I understand and agree to the the benefits of using the gitlab-runner
> > Docker executor... until you want to run tests on non-Docker
> > environments :).
> >=20
> > Hopefully the explanation on my previous reply to Daniel will also
> > serve for the points you raised here.  I would have loved to have
> > worked on a more abstract, container only environments, but that
> > proved to be unrealistic.
>=20
> For Linux targets, it should be possible to have exclusively container
> based testing environments. At worst you can run a privileged container
> and expose arbitrary host resources to it, so you can do anything in
> the container that you would otherwise do in bare metal. For non-Linux,
> we should be able to satisfy our needs with VMs, and indeed VMs can
> be used for Linux too if we want to emulate some specific hardware for
> testing that we don't have accessible to containers on bare metal.
> IOW, the testing environment can be entirely defined by the recipes
> we have in tests/docker and tests/vm. Bare metal hosts are simply a
> way to host the containers or vms.
>

I don't think you're following my point.  It's not about what's
possible to be done, but what's the baseline of the test environment
we want to have.

It's unwise to attempt to compare the results of a test that run under
a container with "arbitrary host resources" exposed to it, to the
results of a test running on the host without the container layer.
Think, for instance, if QE would be willing to do the former only, and
sign off on it, when customers are using the later.

I hope this makes the point clearer.
- Cleber.

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

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9SUcIACgkQZX6NM6Xy
CfP9xRAAoYbo7JO+AOODrDhBqbnaQtZSZa+cc5dw20xBoTVjO7xqvNG/NW1qTry0
EC6phJrwhs560lleFAByMLeIAgAsNJVI6oD8nfhRc3IryXnjPcRevhmfBb+kp4HQ
F7QNVZaYZMnhC7z2kll+DqfVNiZV0KhGbHHC1dn/icVgKHuWl/eXuefeOjDExkR3
SftlrrKlaiCYXFV82un7ntXPXCS95WgPu6pUBGUCwPKeCbnMMwCWRAFUX3LwE/I2
NdSxfHrCpINT8IpUO2xGhxM+OtwyePVWzpntdw+chGG9Cc2W4QaPcBFN0ddaevPu
wDyqRedClUVMATqsQFyU32RmGFVz0MlJAIm9lQKsoN1b8HNtKRTKgFyAmyjZKHfX
7oQaV7WGb1P1NVbEu/gnSRF6pXEcvPOloq60Hq29dPKXR4VlwamPwWKfSEq0QKdp
y+O091qWYckKLSTuN226UOSC+2fvZrFYra9CNszr72WLcD/Dgp7jOXdi0DMaJrud
mCZRvspNS6Pd+VfXZFsP+Z0W1JOayM8yhfytIZhKB94gC05m6Bc2j8lbv0rGO9Rj
9JnD7dY/gEYUaerxtsKC1XnqRVhExL4NGM37DhqfmV/HZTBrkUh/7Ne7dfbROXcB
k5GXQ3QSRAAfnG+ECxT8FaZFIGmN2dkPTbohUw+UzGbutxgyLus=
=h9qa
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--


