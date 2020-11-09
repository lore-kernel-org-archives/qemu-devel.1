Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECE82074F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB3utGtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECE82074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAEU-0006u8-45
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kcACS-0005vG-ET
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kcACQ-0005YX-KN
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604939961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K576SkkFpk5eNT30oARyCZ7bat7Gc96ic7/rpSCFk8Y=;
 b=JB3utGtmew9I7UP5Ndh7eC8het1Yy2resjF3Qlsp2aJTXSLDtSdawyYRTkHQutz1QF1p2o
 vN39IsK3z4grFqXK0RGDzTJNDgoCbu/dkPwDcYvtLYJ+NGpGxDiJGnK9Z5ytzC1o69tr/W
 w+Ze4CqvQJITRlVaGtPUc/d5mS17lHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-iNe4vPq_NJ-8Wvh_1uBdXQ-1; Mon, 09 Nov 2020 11:39:17 -0500
X-MC-Unique: iNe4vPq_NJ-8Wvh_1uBdXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDE4E1019624;
 Mon,  9 Nov 2020 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 050D875132;
 Mon,  9 Nov 2020 16:39:10 +0000 (UTC)
Date: Mon, 9 Nov 2020 11:39:09 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 2/4] Jobs based on custom runners: build environment
 docs and playbook
Message-ID: <20201109163909.GD3874327@localhost.localdomain>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-3-crosa@redhat.com>
 <d2b1f4e8-c257-ef80-9ceb-6fcaf15c3430@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d2b1f4e8-c257-ef80-9ceb-6fcaf15c3430@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
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
 Willian Rampazzo <wrampazz@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2020 at 09:00:27AM +0200, Thomas Huth wrote:
> On 19/10/2020 03.50, Cleber Rosa wrote:
> > To run basic jobs on custom runners, the environment needs to be
> > properly set up.  The most common requirement is having the right
> > packages installed.
> >=20
> > The playbook introduced here covers a number of different Linux
> > distributions and FreeBSD, and are intended to provide a reproducible
> > environment.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> [...]
> > +    - name: Enable PowerTools repo on CentOS 8
> > +      ini_file:
> > +        path: /etc/yum.repos.d/CentOS-PowerTools.repo
> > +        section: PowerTools
> > +        option: enabled
> > +        value: "1"
> > +      when:
> > +        - "ansible_facts['distribution'] =3D=3D 'CentOS'"
> > +        - "ansible_facts['distribution_major_version'] =3D=3D '8'"
> > +
> > +    - name: Install basic packages to build QEMU on CentOS 8
> > +      dnf:
> > +        # Originally from tests/docker/dockerfiles/centos8.docker
> > +        name:
> > +          - SDL-devel
>=20
> We do not support SDL1 in QEMU anymore, so this should be SDL2-devel now.
> Yes, we've also got it wrong in the docker files ... I'll send a patch to
> fix it there.
>=20
>  Thomas

Nice catch.  I see the dockerfile changes are already merged, so
updating them here.

- Cleber.

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+pcK0ACgkQZX6NM6Xy
CfNGehAAt1yFUQTsi+vLkXAOD0Gv5s0/fsDT1hBKx5kGH5u6ZnVAwIlF/r5ZqMsi
0nFUdplW3oRDwG6A9yiDGXVColXTel1K45+iLt+8fXK5lgQ9KduIJfuLmzaYKBKS
8Zz55ZKhcNAzOer3W1J7Z1ul4oCDr8J2lg5hpNdbiqIwoHa3ja6VILdso7bafgrs
aiVMaF20+boC9UFMnAuw+cOTd2k18uQHgDRARaVnXrdDXRxRJgroNWBaqF6ZxV3/
/dMgn+fshGE4HdoJARRtYkAjl4PCFtyB3lsn9kRpuX0YpjQUdD6RyP5O7BZBCXHv
mizptsVfRUXgC34pCXPm0bUAOCHECxXe7FlPLmt0EjbePnf6lGqAtwDYDjzxerYc
Ewx3WwHnxz2rjRIYQKhUI+Vr4yzqgam6CbI7WU3hZvasK7wXHsg5mldSzobLE+ax
yxd/wkADh9QNc44PWwMYebYvSKeASJggu/EGMND0yA46g1mIy5+MZxKsBTrhwHG1
SVvHgVo470XYc1QSr48xyE4Nkb6rwsnzmgD+rSu22Z4onReUc6Eo+peWNENqJk4G
Ar3hPC2wGOrI3J5N4xWJtWNgIE0pNme2JY/sKig3UoRiy5kM2WCEhtnGEJcXQTA9
t0i+RXKx18VdXbphixi1mhTWTH+IuRYKLzhNBGRygkuZR2AI4fo=
=cT6A
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--


