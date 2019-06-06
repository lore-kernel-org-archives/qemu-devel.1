Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05816C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15152083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15152083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYoZp-00038R-Ol
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 05:20:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYoZ4-0002l5-Qd
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYoZ3-0005EN-0z
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:20:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hYoYx-000575-T5
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:20:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34CE65D619;
	Thu,  6 Jun 2019 09:19:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A83F96726D;
	Thu,  6 Jun 2019 09:19:48 +0000 (UTC)
Date: Thu, 6 Jun 2019 10:19:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190606091946.GD14300@redhat.com>
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org>
	<20190605155006.GI8956@redhat.com>
	<20190605201335.GD22416@habkost.net>
	<c6a830b7-2892-6f05-faa1-3c8124e7e78a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6a830b7-2892-6f05-faa1-3c8124e7e78a@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 06 Jun 2019 09:19:58 +0000 (UTC)
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
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 03:42:39PM -0500, Eric Blake wrote:
> On 6/5/19 3:13 PM, Eduardo Habkost wrote:
> 
> >> IOW, I don't think RHEL-7 support as a build platform blocks us from
> >> dropping py2. We merely need to tweak our build platforms doc to clarify
> >> our intent wrt add-on yum repos.
> > 
> > If we clarify the docs in QEMU 4.1, is there anything that
> > prevents us from removing Python 2 support in QEMU 4.1 too?
> 
> My take (but not definitive): if we have any CI setups that are testing
> RHEL 7 without software collections and/or EPEL, then save Python 2
> removal for 4.2 to give us time to update CI setups. But if all of our
> CI setups are already fine, and we clarify the docs, then I'm all for
> getting rid of Python 2 support in 4.1.

The centos7 dockerfile will need to add the extra repo to pull
this in. I don't see any issue with that getting fixed in this
cycle.

As for any CI maintained by third parties outside QEMU tree,
they'll just have to adapt themselves. It is not difficult to
add repos, so again I don't see a big reason to delay. If we
delay chances are they won't bother to update their CI at all
until we make the py3 change in 4.2 anyway. 

> Similarly, if we are going to outlaw in-tree builds, let's get that done
> in 4.1 instead of waiting yet another release.

I don't think there was any hard objection, someone just needs to write
the patch...

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

