Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9808C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B4F21848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B4F21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lvc-0003uj-Hz
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 08:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0lZZ-0000y5-EF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0lZX-0007sv-Tm
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:48:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i0lZX-0007s9-KU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:48:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5F54180158C;
 Thu, 22 Aug 2019 11:48:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9836360E1C;
 Thu, 22 Aug 2019 11:47:49 +0000 (UTC)
Date: Thu, 22 Aug 2019 12:47:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190822114747.GS3267@redhat.com>
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 22 Aug 2019 11:48:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 16, 2019 at 07:16:55PM +0100, Peter Maydell wrote:
> The two major contenders suggested were:
> 
> (1) GitLab CI, which supports custom 'runners' which we can set
> up to run builds and tests on machines we have project access to
> 
> (2) Patchew, which can handle running tests on multiple machines (eg
> we do s390 testing today for all patches on list), and which we could
> enhance to provide support for the release-manager to do their work
> 
> Advantages of Gitlab CI:
>  * somebody else is doing the development and maintainance of the
>    CI tool -- bigger 'bus factor' than patchew
>  * already does (more or less) what we want without needing
>    extra coding work
> 
> Advantages of Patchew:
>  * we're already using it for patch submissions, so we know it's
>    not going to go away
>  * it's very easy to deploy to a new host
>  * no dependencies except Python, so works anywhere we expect
>    to be able to build QEMU (whereas gitlab CI's runner is
>    written in Go, and there seem to be ongoing issues with getting
>    it actually to compile for other architectures than x86)

IMHO the development tools/processes chosen should enable the project
contributors to maximise the time they can put into developing useful
features for QEMU itself. Time we spend writing CI systems like patchew
is time we're taking away from writing QEMU features, unless the new CI
system offers major efficiency benefits over other existing solutions.

A second important aspect is that to enable a smooth/shallow onramp
for new contributors it is useful to have our development processes
and tools be familiar to those with general open source dev experience
outside QEMU.

With both these points in mind, I think it is  pretty hard sell to
say we should write & maintain a custom CI system just for QEMU
unless it is offering major compelling functionality we can't do
without.

IOW, I'd be biased in favour of GitLab CI.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

