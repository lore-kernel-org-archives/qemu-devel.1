Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539F0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28AB020870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28AB020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qWb-0000yD-Q7
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0qUd-00088j-67
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0qUa-0000Pf-A7
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:03:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i0qUZ-0000Oy-OZ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:03:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6A414ACA7;
 Thu, 22 Aug 2019 17:03:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-26.ams2.redhat.com [10.36.112.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77B4460603;
 Thu, 22 Aug 2019 17:03:11 +0000 (UTC)
Date: Thu, 22 Aug 2019 18:03:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190822170308.GA8081@redhat.com>
References: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
 <20190822114747.GS3267@redhat.com> <20190822163150.GA3332@work-vm>
 <9caf3a64-0841-dde6-3413-a77dc80e22bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9caf3a64-0841-dde6-3413-a77dc80e22bd@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 22 Aug 2019 17:03:18 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 06:48:08PM +0200, Paolo Bonzini wrote:
> On 22/08/19 18:31, Dr. David Alan Gilbert wrote:
> >> With both these points in mind, I think it is  pretty hard sell to
> >> say we should write & maintain a custom CI system just for QEMU
> >> unless it is offering major compelling functionality we can't do
> >> without.
> 
> In theory I agree.
> 
> In practice, the major compelling functionality is portability.  If it
> is true that setting up runners is problematic even on aarch64, frankly
> GitLab CI is dead on arrival.  If it is not true, then I'd be very happy
> to use GitLab CI too.

Sure, I did qualify my statement in the text before that quoted here
to say that the patchew would have to offer some compelling feature
over GitLab. If GitLab can't be made to work with non-x86 runners,
then clearly non-x86 portability is the compelling feature that would
make Patchew a sensible option for QEMU.

I don't know what the problems are wrt to aarch64 & GitLab but the
scheme for connecting new runners to GitLab CI looks pretty flexible
when I examined it, so I'd really hope non-x86 is not a show stopper.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

