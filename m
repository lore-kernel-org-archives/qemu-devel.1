Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52163C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DE92083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DE92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYCG-0003NW-A1
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:51:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYBS-00035n-1H
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYYBQ-000061-3A
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:50:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYYBP-0008SY-TD
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:50:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14D1430C34CC;
	Wed,  5 Jun 2019 15:50:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-70.ams2.redhat.com [10.36.112.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0944B80B9;
	Wed,  5 Jun 2019 15:50:09 +0000 (UTC)
Date: Wed, 5 Jun 2019 16:50:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190605155006.GI8956@redhat.com>
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871s0asvli.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 05 Jun 2019 15:50:31 +0000 (UTC)
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
	Eduardo Habkost <ehabkost@redhat.com>,
	John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 02:26:49PM +0200, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
> > On 5/31/19 3:24 PM, Eduardo Habkost wrote:
> >> Long story short: I would really like to drop support for Python
> >> 2 in QEMU 4.1.
> 
> The sooner, the better, as far as I'm concerned.
> 
> >> What exactly prevents us from doing this?  Does our deprecation
> >> policy really apply to build dependencies?
> >> 
> >
> > Normally I'd say it's only nice to also follow the depreciation policy
> > for tooling as well to give people a chance to switch away, but with
> > regards to Python2, I feel like we're in the clear to drop it for the
> > first release that will happen after the Python2 doomsday clock.
> >
> > (So, probably 4.2.)
> 
> In addition to our feature deprecation policity, we have a "Supported
> build platforms" policy (commit 45b47130f4b).  The most common holdback
> is this one:
> 
>     For distributions with long-lifetime releases, the project will aim
>     to support the most recent major version at all times. Support for
>     the previous major version will be dropped 2 years after the new
>     major version is released. For the purposes of identifying supported
>     software versions, the project will look at RHEL, Debian, Ubuntu
>     LTS, and SLES distros. Other long-lifetime distros will be assumed
>     to ship similar software versions.
> 
> RHEL-7 has Python 3 only in EPEL.  RHEL-8 came out last month.  Unless
> we interpret our policy to include EPEL, this means supporting Python 2
> for some 16 months after upstream Python retires it.  My personal
> opinion: nuts.

We've not said whether this refers to only base repos, or whether addon
repos are accepted. IMHO, we are reasonably justified in saying RHEL-7
as a build platform covers any repo provided by Red Hat, which would
give us Python3 via software collections. I think it would be reasonable
to also state it covers EPEL, since EPEL is such a commonly used repo
with RHEL.

IOW, I don't think RHEL-7 support as a build platform blocks us from
dropping py2. We merely need to tweak our build platforms doc to clarify
our intent wrt add-on yum repos.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

