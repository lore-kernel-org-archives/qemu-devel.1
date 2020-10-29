Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0318C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A59D2076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTpxTpmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A59D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY2fQ-0000qh-V5
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 03:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kY2eP-0000FY-O8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kY2eL-0000hq-OD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 03:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603957626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m+IPSx8PM4hnWWKOzMDofpTvEXLRv3Qet8DHD9NoNyw=;
 b=CTpxTpmOt4a5JBvrnmRVU7C2VcBnDnV3dMrX3uawmC+NcJ78uw0SJfj7XPgsIvz2Yi+6GC
 EDfzcR7MBa3joShy11xDL5MVjVjfmLMHNnwQf1n4IyJhQWGr6kYoT7TaUMwkS0AhkepQwf
 GrIKv9B3bohNoGtEPEBAp89/+YvGGoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-OWNwvdp4OI-0I8MbPb58MA-1; Thu, 29 Oct 2020 03:47:02 -0400
X-MC-Unique: OWNwvdp4OI-0I8MbPb58MA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A25C91800D42;
 Thu, 29 Oct 2020 07:47:01 +0000 (UTC)
Received: from localhost (ovpn-112-178.ams2.redhat.com [10.36.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35A265C1D0;
 Thu, 29 Oct 2020 07:47:00 +0000 (UTC)
Date: Thu, 29 Oct 2020 07:47:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 3/7] qemu: add support for iOS host
Message-ID: <20201029074700.GB251558@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-4-j@getutm.app>
 <20201028113928.GG221115@stefanha-x1.localdomain>
 <CA+E+eSCifetWs=MHW+Q-QkTWJC8a1hj1cc=4krMbC1W+pizr6Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+E+eSCifetWs=MHW+Q-QkTWJC8a1hj1cc=4krMbC1W+pizr6Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2020 at 05:55:07PM -0700, Joelle van Dyne wrote:
> On Wed, Oct 28, 2020 at 4:39 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Tue, Oct 27, 2020 at 08:06:57PM -0700, Joelle van Dyne wrote:
> > It is beneficial to get continuous integration working for iOS.
> > Otherwise other maintainers may merge patches that break iOS compilation
> > and you'll find out later and be left solving the issues.
> If we want to do this it may come in another patch set. Reason is that
> to build QEMU for iOS, you have to build all the dependencies as well,
> which means downloading and building tar.gz from various sources for
> specific versions. We run a CI for UTM that uses this script to build
> QEMU, as you can see it's rather involved:
> https://github.com/utmapp/UTM/blob/master/scripts/build_dependencies.sh

The main issue I see is that the build time will be long due to all the
dependencies that are built from source.

If there is a way to cache the build dependency artifacts then it could
be simplified down to:

  tar xf qemu_ios_deps.tar.bz2
  git clone https://gitlab.com/qemu-project/qemu.git
  cd qemu
  ./configure ...
  make ...

The dependencies could be rebuild periodically (e.g. monthly or
on-demand when you decide to upgrade dependencies).

If you want to discuss CI integration more please start a new email
thread.  A number of people in the QEMU community have been playing with
various CI systems recently (GitLab, GitHub Actions, Travis, Cirrus,
etc) and might be able to suggest how to do this.

AFAIK Cirrus, Travis, and GitHub Actions offer free macOS runners. Or
you can install gitlab-runner on your own Mac and connect it to QEMU's
GitLab CI.

Using GitLab CI is slightly preferred because QEMU is moving towards it
as the main CI system.

Stefan

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ac3MACgkQnKSrs4Gr
c8gLtwgAssZAHNpCP+WvsTNinOu0d2eLTGvmOdrBwnfgaVSuj0xjvmsrE6J6Lur0
zunFqTt85i7vAbnCu75ZmCaIdQkETmsiuA0tIQPTkDVYqRV9vq/ZH8C6vDFoMOrn
aGeNPhniRygK/34AoarqcRE8y4cVBF7c7W+muSsqT5NXhqhnfLxMe0CCZp9TQIlj
wsDHFVr5Wh3fml+aJj+1mDa74tL4taUmgMJVjIZ3vEGGBtYr7wsCb0AMLuazbf+q
MhGKxit4VX59/6m4DlOk5Bcf2hn/tA+1ecRQzu+Vz82AjMK6qIxsCvT30MtmjL1n
9wAZDK/lrW88jfrMe2X+HVXiCf1vEw==
=yTIj
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--


