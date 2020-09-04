Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFBBC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B8B2075D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AD+ae8wC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B8B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDzRx-0006Zt-AF
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 20:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDzR0-0005gP-UP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kDzQy-0005yq-BM
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599178706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6n9o66/5dDss9iNasgYsLuP8UPVYZwKZBF2Pzc2yE/I=;
 b=AD+ae8wCOYgf0UMbtfUqt2I1dtNdUBM4OX6QQgFwnU6g96k7g7MLyxPA43TMcaLLsO0AGj
 V1GSrWVW07MHGTyX/Th2n5vp4jySyiGX7sA3GfMe+L/NZqyvBgdC4G5Y69tDsMqjSuWBAi
 X4COW1XiO6L+VZ9ALd9GIsKRlIhSxZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-RtlMXHCPPfOcm26nEseGMg-1; Thu, 03 Sep 2020 20:18:24 -0400
X-MC-Unique: RtlMXHCPPfOcm26nEseGMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9398118A225E;
 Fri,  4 Sep 2020 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 611BD5C1C2;
 Fri,  4 Sep 2020 00:18:19 +0000 (UTC)
Date: Thu, 3 Sep 2020 20:18:17 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200904001817.GF55646@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709103029.GK3753300@redhat.com>
 <a462a7e1094fea39e13436a940ef91bec809a8fc.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a462a7e1094fea39e13436a940ef91bec809a8fc.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 20:08:06
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 01:28:27PM +0200, Andrea Bolognani wrote:
> On Thu, 2020-07-09 at 11:30 +0100, Daniel P. Berrang=E9 wrote:
> > On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > > +- name: Installation of basic packages to build QEMU
> > > +  hosts: all
> > > +  vars_files:
> > > +    - vars.yml
> > > +  tasks:
> > > +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.=
04
> > > +      apt:
> > > +        update_cache: yes
> > > +        # This matches the packages on tests/docker/Dockerfiles/ubun=
tu1804.docker
> >=20
> > I'd be inclined to actually use docker on the custom runners.
> >=20
> > eg. instead of having separate physical machines or VMs for each
> > (distro, arch) pair, have a single host distro for the arch. Then
> > use docker to provide the build environment against each distro.
> >=20
> > IOW, a RHEL-8 aarch64 host, running docker for ubuntu18.04, fedora30
> > etc.
> >=20
> > That way we don't end up duplicating all these packages, and instead
> > can use  tests/docker/Dockerfiles/ubuntu1804.docker.  This ensures
> > that if a user needs to reproduce a build failure on their own local
> > aarch64 machine, they can run docker and get the exact same build
> > architecture.
> >=20
> > It also has the benefit that we don't need to worry about how to
> > setup gitlab runners for every distro we care about. We only need to
> > do gitlab runner for the standard host distro, which spawns a pristine
> > throwaway docker env.
> >=20
> > I appreciate this is a big change from what you've done in this patch
> > though, so don't consider this comment a blocker for initial merge.
> > I think we should do this as the long term strategy though. Essentially
> > for Linux builds, everything should always be container based.
>=20
> Agreed. You should be able to set up a fairly minimal environment,
> which consists of Docker, gitlab-runner and not much else, using a
> long-term supported distro such as CentOS and then just schedule
> whatever container build on it. No need to provision a new machine
> every time a new Fedora release comes out, just create a container
> image for it and add it to the mix.
>

Hi Andrea,

There's nothing preventing this from happening, but limiting the
runners to this configuration, prevents a lot more from happening.

> Additionally, the gitlab-runner Docker executor provides more
> isolation than the shell executor, so running untrusted builds
> becomes a more reasonable proposition - this is how the shared
> runners on gitlab.com work - and you don't have to worry about your
> jobs cleaning up properly after themselves nearly as much.
>

I understand and agree to the the benefits of using the gitlab-runner
Docker executor... until you want to run tests on non-Docker
environments :).

Hopefully the explanation on my previous reply to Daniel will also
serve for the points you raised here.  I would have loved to have
worked on a more abstract, container only environments, but that
proved to be unrealistic.

Cheers,
- Cleber.

> --=20
> Andrea Bolognani / Red Hat / Virtualization
>=20

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9Rh8YACgkQZX6NM6Xy
CfPPkxAAyLkncTf2+K9vIqvPqn/uS2wsnyRkgKGD4UYSoxw5fPWNpCnIBVjNzrMQ
+GmQhm94BHk7C/n62RcYuGjUWXP3brDhD2Kk7CXP8wJa+wOCIK+03inTAScCNlIV
EaUYhRpB4rvFOcLhhO2hE28lLW86B8T2OXLaHlZZxiyxFghtbcetB9Iv3cq1fYeW
CYGf4crcyuHZEAWUGj5BcOX12/+OCbfzAK4Rh9K0N64JfuoP5pczYg5D1S+ufPXu
T4A0ee0Hyx4AKgiPeBcfnM1cvkgZ0R2bpRTzXwPCRIbqUyF8RoykvtiNdzNoVYbW
BeSFMuT4v8ounF2ZlXIxi8a5wNwlJy0SNdRa+q+lnvSbGVjz/G3+E1dcw7siaxcF
dVIEiM+4ke1PTr1l4OqQIS7zZEICLv/vXgvTL/MI/MEVbUnrBhyaLFKokXQ65V0e
Q7iiOK84ifQ2EkbnMeRlaMuJocXHit6hqBcMBMX3tTJdaYzNx3dKh5c6a34IXKU+
Tq3mYZaKNwSffNgxHngJDqSTZbUjqqJP+uWAreTQOvdtfKPMps6QtjX2XmTtBELL
h8I31Xg5qCaJWG6QJYFCKVcTYh3Osr3neQCJ75OqcCKd6oizK32JIVqWiYenkdnu
61PAKzvgKIHh118Jcy+5+gNKhf8DVPqvERQIpJUdxoN4CsXn64g=
=YgH9
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--


