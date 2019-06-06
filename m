Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DCBC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E04A20717
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E04A20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYks1-0003ZX-C9
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 01:23:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkrF-0003Ih-G4
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYkrE-00059O-M4
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:22:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYkrE-00056q-GZ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:22:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7ACA85365;
	Thu,  6 Jun 2019 05:22:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A37368396;
	Thu,  6 Jun 2019 05:22:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D0B9411386A0; Thu,  6 Jun 2019 07:22:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org> <20190605155006.GI8956@redhat.com>
	<20190605201335.GD22416@habkost.net>
	<c6a830b7-2892-6f05-faa1-3c8124e7e78a@redhat.com>
Date: Thu, 06 Jun 2019 07:22:28 +0200
In-Reply-To: <c6a830b7-2892-6f05-faa1-3c8124e7e78a@redhat.com> (Eric Blake's
	message of "Wed, 5 Jun 2019 15:42:39 -0500")
Message-ID: <87r287jnjf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 06 Jun 2019 05:22:34 +0000 (UTC)
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
	"Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 6/5/19 3:13 PM, Eduardo Habkost wrote:
>
>>> IOW, I don't think RHEL-7 support as a build platform blocks us from
>>> dropping py2. We merely need to tweak our build platforms doc to clarify
>>> our intent wrt add-on yum repos.
>> 
>> If we clarify the docs in QEMU 4.1, is there anything that
>> prevents us from removing Python 2 support in QEMU 4.1 too?
>
> My take (but not definitive): if we have any CI setups that are testing
> RHEL 7 without software collections and/or EPEL, then save Python 2
> removal for 4.2 to give us time to update CI setups. But if all of our
> CI setups are already fine, and we clarify the docs, then I'm all for
> getting rid of Python 2 support in 4.1.

There's still time to update CI setups without undue haste.  But I agree
we don't want to lose CI even temporarily just to expedite getting rid
of Python 2.

> Similarly, if we are going to outlaw in-tree builds, let's get that done
> in 4.1 instead of waiting yet another release.

For that we need patches.

