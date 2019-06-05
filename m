Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1121C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65262083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65262083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44747 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYY7M-00016n-QE
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:46:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYY5g-0008Q0-59
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYY5d-0008V8-9e
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYY5T-0008Af-RP
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:44:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B338830917AC;
	Wed,  5 Jun 2019 15:44:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 16A70627DF;
	Wed,  5 Jun 2019 15:44:06 +0000 (UTC)
Date: Wed, 5 Jun 2019 16:44:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190605154403.GH8956@redhat.com>
References: <20190531192429.GH22103@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190531192429.GH22103@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 05 Jun 2019 15:44:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Deprecation policy and build dependencies
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 04:24:29PM -0300, Eduardo Habkost wrote:
> Long story short: I would really like to drop support for Python
> 2 in QEMU 4.1.
> 
> What exactly prevents us from doing this?  Does our deprecation
> policy really apply to build dependencies?

In general I do *not* consider our deprecation policy to apply to
*mandatory* build dependancies. Instead our platform support policy
applies.

The rationale is that mandatory build dependancies are not something
that can be considered on a case by case basis. To build QEMU on any
given platform, *all* the mandatory build deps must be satisfied by
that platform. Increasing min version of any single mandatory, build
dep will effectively exclude a host build target.

IOW, when we drop a build target we can consider updating min version
of *all* mandatory build deps at the same time.

Where the deprecation policy could come into play is if we want to drop
an *optional* build dependancy for certain platforms. eg librbd is an
optional build dep and we might have some reason we want to increase the
min version despite it not being present in all our supported platforms.
This could be a case to mark the "rbd" feature as deprecated on certain
build platforms.


Thus to answer your python 2 question, we should ask which of our build
targets cannot support python 3 ?

Obviously we know the answer to that is RHEL-7. Except there is some
fuzziness in there because it depends on what you define "RHEL-7" to
be. There are several possible answers

 a. RHEL-7 covers only the stuff in the basic yum repos
 b. RHEL-7 covers packages in any yum repos shipped by Red Hat
 c. RHEL-7 covers packages in any yum repos shipped by Red Hat or EPEL
 d. RHEL-7 covers packages in any yum repo available for use
    with RHEL-7,  provided by any vendor

The platform support policy has not documented which of these possiblities
we're targetting.

If we consider it to mean (a), then there's no way to use py3 with RHEL-7.

With (b), (c), or (d) it is possible to get py3 available on RHEL-7 by
enabling suitable repos.

Personally I think it would be fine for use to consider (b) or (c) to be
our intended interpretation for platform support policy.

In this interpretation it is possible for developers to get Python 3 on
RHEL-7 by enabling the Red Hat Software collection repos:

  https://developers.redhat.com/products/softwarecollections/hello-world/#fndtn-windows

This implies we *can* drop python2 from QEMU *and* keep RHEL-7 as a
supported target.

Also note that the platform support policy didn't say anything about
RHEL minor updates. ie it does not distinguish RHEL-7.0 from RHEL-7.6,
despite fact that some packages get major version rebases. I think we
should clarify that we mean "latest available updates" for our supported
platforms. ie 7.6 is supported, 7.0 is *not* supported.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

