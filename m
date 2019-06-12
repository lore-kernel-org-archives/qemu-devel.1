Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A7CC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF850208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF850208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34844 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbAGA-0001k1-4l
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 16:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55755)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hbAEw-00010n-2Y
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hbAEv-0006DX-0h
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:53:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hbAEu-0006CI-RJ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:53:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B195E330265;
 Wed, 12 Jun 2019 20:52:52 +0000 (UTC)
Received: from localhost (ovpn-116-100.phx2.redhat.com [10.3.116.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35A3B1001947;
 Wed, 12 Jun 2019 20:52:43 +0000 (UTC)
Date: Wed, 12 Jun 2019 17:52:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190612205242.GQ5927@habkost.net>
References: <20190611171456.23444-1-ehabkost@redhat.com>
 <20190611171456.23444-7-ehabkost@redhat.com>
 <d107483c-eba8-f6fc-8e3a-ad0a86472d07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d107483c-eba8-f6fc-8e3a-ad0a86472d07@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 12 Jun 2019 20:52:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 6/6] travis: Make check-acceptance job more
 verbose
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
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 10:49:18PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 6/11/19 7:14 PM, Eduardo Habkost wrote:
> > It will help us debug issues when tests fail.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  .travis.yml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/.travis.yml b/.travis.yml
> > index b053a836a3..a08a7b7278 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -225,7 +225,7 @@ matrix:
> >      # Acceptance (Functional) tests
> >      - env:
> >          - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_=
64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390=
x-softmmu,alpha-softmmu"
> > -        - TEST_CMD=3D"make check-acceptance"
> > +        - TEST_CMD=3D"make AVOCADO_SHOW=3Dtest check-acceptance"
> >        addons:
> >          apt:
> >            packages:
> >=20
>=20
> Cleber, can you help figuring what's wrong here?
>=20
> https://travis-ci.org/qemu/qemu/jobs/544805900
>=20
> The tests seems successfull, is it possible the verbose logging returns
> error to the shell even if the test succeed?

That's exactly what this patch does.  On my next pull request I
will replace this with Cleber's patch that dumps the error log
only if tests failed.

--=20
Eduardo

