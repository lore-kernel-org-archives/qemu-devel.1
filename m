Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEFCC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0556C20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0556C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCgmi-0003LE-7Y
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iCgm2-0002u1-Bs
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iCglz-0007pl-Lm
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:06:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iCglz-0007pb-E0
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AAFBC300BEA9;
 Tue, 24 Sep 2019 09:06:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-39.ams2.redhat.com [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEAF8608C0;
 Tue, 24 Sep 2019 09:06:06 +0000 (UTC)
Date: Tue, 24 Sep 2019 10:06:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Debian support lifetime (was Re: [PATCH] docker: move tests from
 python2 to python3)
Message-ID: <20190924090604.GB2106@redhat.com>
References: <20190920200049.27216-1-jsnow@redhat.com>
 <20190923145057.GC9445@dhcp-17-179.bos.redhat.com>
 <6ac39e69-4982-dc35-d853-fedbb1c12e1a@redhat.com>
 <20190923190533.GR5035@habkost.net>
 <20190924073513.GA2106@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924073513.GA2106@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 24 Sep 2019 09:06:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 08:35:13AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Sep 23, 2019 at 04:05:33PM -0300, Eduardo Habkost wrote:
> > On Mon, Sep 23, 2019 at 01:19:41PM -0400, John Snow wrote:
> > > On 9/23/19 10:50 AM, Cleber Rosa wrote:
> > [...]
> > > >> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker=
 b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> > > >> index b9c2e2e531..e6f93f65ee 100644
> > > >> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
> > > >> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> > > >> @@ -18,7 +18,7 @@ RUN apt-get update && \
> > > >>          flex \
> > > >>          gettext \
> > > >>          git \
> > > >> -        python-minimal
> > > >> +        python3-minimal
> > > >=20
> > > > I'm getting Python 3.5.3-1+deb9u1 here, so it LGTM.
> > > >=20
> > >=20
> > > Oh, that's actually a bit of a problem. I tested on 3.5+, but I thi=
nk
> > > some people want 3.6+.
> > >=20
> > > I don't know much about Debian, but we either need to guarantee 3.6=
+ or
> > > backtrack our plans to 3.5+.
> >=20
> > Good catch.  I forgot we were going to keep 3.5 support because
> > of Debian 9.
> >=20
> > Now, I'd like to clarify what the wording on our supported build
> > platforms documentation is supposed to mean for Debian.
> >=20
> > The document says:
> >=20
> > ] For distributions with frequent, short-lifetime releases, the proje=
ct will
> > ] aim to support all versions that are not end of life by their respe=
ctive
> > ] vendors. For the purposes of identifying supported software version=
s, the
> > ] project will look at Fedora, Ubuntu, and openSUSE distros. Other sh=
ort-
> > ] lifetime distros will be assumed to ship similar software versions.
> > ]=20
> > ] For distributions with long-lifetime releases, the project will aim=
 to support
> > ] the most recent major version at all times. Support for the previou=
s major
> > ] version will be dropped 2 years after the new major version is rele=
ased. For
> > ] the purposes of identifying supported software versions, the projec=
t will look
> > ] at RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime =
distros will
> > ] be assumed to ship similar software versions.
> >=20
> > Debian 10 was released in July 2019.  Are we really willing to
> > support Debian 9 as a supported build platform until July 2021?
> > The Debian Project itself won't support Debian 9 after July 2020.
>=20
> This is an oversight on my part - I didn't realize Debian releases
> were supported for such a short time in parallel.
>=20
> There should be a general statement that, no matter what else the
> policy states, we do *NOT* support any distro that has been end of
> life by its vendor.
>=20
> > Even for other long-lifetime distros, I really think "2 years
> > after the new major version is released" is too long, and I'd
> > like to shorten this to 1 year.
>=20
> I guess this is ok, since this. is still quite a long life time of
> support for distros. eg RHEL has a 3-4 year gap between major
> releases, that gives 4-5 years for each release being supported by
> QEMU. Other LTS distros are similar

Having said that, in the past we did have some pushback from people who
were staying on Ubuntu LTS releases for quite a long time, which influenc=
ed
the decision to have a 2 year overlap. In practice that hopefully isn't t=
oo
big a problem, as support for the other LTS distros probably means Ubuntu
LTS will work ok regardless for 2 releases.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

