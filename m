Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84CCC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EBEE2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBEE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYd0d-0008BG-J7
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:59:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYcqp-0007tz-OM
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYcqo-0001Fv-T1
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hYcqn-0001A5-Ga
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:49:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F39113087932;
	Wed,  5 Jun 2019 20:49:29 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 95A8219C6F;
	Wed,  5 Jun 2019 20:49:22 +0000 (UTC)
Date: Wed, 5 Jun 2019 17:49:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190605204920.GG22416@habkost.net>
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org>
	<20190605155006.GI8956@redhat.com>
	<20190605201335.GD22416@habkost.net>
	<c6a830b7-2892-6f05-faa1-3c8124e7e78a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a830b7-2892-6f05-faa1-3c8124e7e78a@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 05 Jun 2019 20:49:30 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
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

If we do this soon, CI system owners will have at least 9 weeks
to fix them before 4.1.0 is released.

> 
> Similarly, if we are going to outlaw in-tree builds, let's get that done
> in 4.1 instead of waiting yet another release.

I'm missing the context on this.  Is this from a separate discussion?

-- 
Eduardo

