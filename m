Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9524FC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A24720665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A24720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCTfr-0005KR-Li
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 15:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iCTeb-0004eG-NZ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iCTeY-0004Uz-Vf
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:05:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iCTeY-0004U9-QR
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:05:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF8B310A8128;
 Mon, 23 Sep 2019 19:05:40 +0000 (UTC)
Received: from localhost (ovpn-116-45.gru2.redhat.com [10.97.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 809CD19D70;
 Mon, 23 Sep 2019 19:05:34 +0000 (UTC)
Date: Mon, 23 Sep 2019 16:05:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Debian support lifetime (was Re: [PATCH] docker: move tests from
 python2 to python3)
Message-ID: <20190923190533.GR5035@habkost.net>
References: <20190920200049.27216-1-jsnow@redhat.com>
 <20190923145057.GC9445@dhcp-17-179.bos.redhat.com>
 <6ac39e69-4982-dc35-d853-fedbb1c12e1a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ac39e69-4982-dc35-d853-fedbb1c12e1a@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 23 Sep 2019 19:05:40 +0000 (UTC)
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 01:19:41PM -0400, John Snow wrote:
> On 9/23/19 10:50 AM, Cleber Rosa wrote:
[...]
> >> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> >> index b9c2e2e531..e6f93f65ee 100644
> >> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
> >> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> >> @@ -18,7 +18,7 @@ RUN apt-get update && \
> >>          flex \
> >>          gettext \
> >>          git \
> >> -        python-minimal
> >> +        python3-minimal
> > 
> > I'm getting Python 3.5.3-1+deb9u1 here, so it LGTM.
> > 
> 
> Oh, that's actually a bit of a problem. I tested on 3.5+, but I think
> some people want 3.6+.
> 
> I don't know much about Debian, but we either need to guarantee 3.6+ or
> backtrack our plans to 3.5+.

Good catch.  I forgot we were going to keep 3.5 support because
of Debian 9.

Now, I'd like to clarify what the wording on our supported build
platforms documentation is supposed to mean for Debian.

The document says:

] For distributions with frequent, short-lifetime releases, the project will
] aim to support all versions that are not end of life by their respective
] vendors. For the purposes of identifying supported software versions, the
] project will look at Fedora, Ubuntu, and openSUSE distros. Other short-
] lifetime distros will be assumed to ship similar software versions.
] 
] For distributions with long-lifetime releases, the project will aim to support
] the most recent major version at all times. Support for the previous major
] version will be dropped 2 years after the new major version is released. For
] the purposes of identifying supported software versions, the project will look
] at RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime distros will
] be assumed to ship similar software versions.

Debian 10 was released in July 2019.  Are we really willing to
support Debian 9 as a supported build platform until July 2021?
The Debian Project itself won't support Debian 9 after July 2020.

Even for other long-lifetime distros, I really think "2 years
after the new major version is released" is too long, and I'd
like to shorten this to 1 year.

-- 
Eduardo

