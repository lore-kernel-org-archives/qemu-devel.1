Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FEAC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A643206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A643206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDTAx-00008J-Af
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDT96-0007DI-EB
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDT91-0004gx-33
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:45:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iDT90-0004dU-Qi
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:45:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABD3A210B;
 Thu, 26 Sep 2019 12:45:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7FDF5C21A;
 Thu, 26 Sep 2019 12:45:01 +0000 (UTC)
Date: Thu, 26 Sep 2019 13:44:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Debian support lifetime (was Re: [PATCH] docker: move tests from
 python2 to python3)
Message-ID: <20190926124459.GA19660@redhat.com>
References: <20190920200049.27216-1-jsnow@redhat.com>
 <20190923145057.GC9445@dhcp-17-179.bos.redhat.com>
 <6ac39e69-4982-dc35-d853-fedbb1c12e1a@redhat.com>
 <20190923190533.GR5035@habkost.net>
 <20190924073513.GA2106@redhat.com>
 <20190925200440.GO8144@habkost.net>
 <20190926115829.GA18782@redhat.com>
 <CAFEAcA8Jn=er6mRZX+EYTePruTcHpLzVpqpydkERMVA9DdUOag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Jn=er6mRZX+EYTePruTcHpLzVpqpydkERMVA9DdUOag@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Thu, 26 Sep 2019 12:45:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 01:18:35PM +0100, Peter Maydell wrote:
> On Thu, 26 Sep 2019 at 12:58, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > When first wording the lifetimes, I tried to strike a balance between
> > limiting what we have to support, while also not negatively impacting
> > a large number of QEMU developers or users. Since we had never had
> > such support lifetimes declared for QEMU before, I was fairly generou=
s,
> > hence picking the 2 year overlap for LTS distros (Ubuntu, RHEL and
> > SLES).
> >
> > It is easier to come to a decision when considering a real world tech
> > problem related to the lifetime.
> >
> > The start of this thread was debating Debian / Python support. If we
> > fix the doc to put debian under the short life distro category, we'll
> > have solved the Python problem IIUC.
>=20
> I don't think Debian counts as a distro "with frequent, short-lifetime
> releases", though.

It is kind of in the middle ground between the short 6 month frequency
releases, and the long 3+ year major releases

> Stating overall that we don't intend to support distro versions
> that the distro themselves doesn't support ought to be sufficient,
> shouldn't it?

Yeah, that at least addresses the python question.

> In general, my view is that if we bump up against any of these
> support-lifetime limits then we're being too eager to drop
> support for something from QEMU and we should prefer to retain
> support for a while longer. I like and think that it's important
> that QEMU as a project does not live on the bleeding-edge and
> require latest-and-greatest versions of its dependencies to build.

Yeah, there's certainly a balance to be hit. If we only rarely have
to debate problems with desired min versions vs distros, and users
rarely complain that we're dropping stuff too soon, then that's a
sign we've got the balance about right.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

