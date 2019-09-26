Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ED3C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269662053B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269662053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSQp-0000rN-BV
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iDSQ7-0008Mk-9e
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iDSPz-0001xE-VC
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iDSPz-0001kp-Op
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 339A9308A9E2;
 Thu, 26 Sep 2019 11:58:40 +0000 (UTC)
Received: from redhat.com (ovpn-112-37.ams2.redhat.com [10.36.112.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6395166A00;
 Thu, 26 Sep 2019 11:58:32 +0000 (UTC)
Date: Thu, 26 Sep 2019 12:58:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Debian support lifetime (was Re: [PATCH] docker: move tests from
 python2 to python3)
Message-ID: <20190926115829.GA18782@redhat.com>
References: <20190920200049.27216-1-jsnow@redhat.com>
 <20190923145057.GC9445@dhcp-17-179.bos.redhat.com>
 <6ac39e69-4982-dc35-d853-fedbb1c12e1a@redhat.com>
 <20190923190533.GR5035@habkost.net>
 <20190924073513.GA2106@redhat.com>
 <20190925200440.GO8144@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925200440.GO8144@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 26 Sep 2019 11:58:40 +0000 (UTC)
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
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 05:04:40PM -0300, Eduardo Habkost wrote:
> On Tue, Sep 24, 2019 at 08:35:13AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Mon, Sep 23, 2019 at 04:05:33PM -0300, Eduardo Habkost wrote:
> [...]
> > > Even for other long-lifetime distros, I really think "2 years
> > > after the new major version is released" is too long, and I'd
> > > like to shorten this to 1 year.
> >=20
> > I guess this is ok, since this. is still quite a long life time of
> > support for distros. eg RHEL has a 3-4 year gap between major
> > releases, that gives 4-5 years for each release being supported by
> > QEMU. Other LTS distros are similar
>=20
> Do you mean the 2 years period is OK (and shouldn't be changed),
> or that shortening it to 1 year is OK?

When first wording the lifetimes, I tried to strike a balance between
limiting what we have to support, while also not negatively impacting
a large number of QEMU developers or users. Since we had never had
such support lifetimes declared for QEMU before, I was fairly generous,
hence picking the 2 year overlap for LTS distros (Ubuntu, RHEL and
SLES).

It is easier to come to a decision when considering a real world tech
problem related to the lifetime.=20

The start of this thread was debating Debian / Python support. If we
fix the doc to put debian under the short life distro category, we'll
have solved the Python problem IIUC.

Then I'd suggest we just leave LTS distros as a 2 year overlap until
we hit some technical problem that is caused by needing the 2 year
overlap. That way we can consider the cost/benefit in more real terms.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

