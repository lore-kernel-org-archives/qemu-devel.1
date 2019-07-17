Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77870C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494F72077C
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 07:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494F72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hneln-0005or-IB
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 03:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hnelc-0005JC-VI
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hnelb-0000wW-NF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 03:54:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hnelb-0000wA-HO; Wed, 17 Jul 2019 03:54:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9EA883082E23;
 Wed, 17 Jul 2019 07:54:22 +0000 (UTC)
Received: from redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C57FF19C68;
 Wed, 17 Jul 2019 07:54:20 +0000 (UTC)
Date: Wed, 17 Jul 2019 08:54:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190717075417.GA2891@redhat.com>
References: <1563346686.2145.11.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1563346686.2145.11.camel@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 17 Jul 2019 07:54:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU] crypto/random: Fall back to /dev/random
 when getrandom returns EAGAIN
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
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 04:58:06PM +1000, Suraj Jitindar Singh wrote:
> Hi,
> 
> I'm trying to use qemu inside a a guest, however since there isn't
> enough entropy for the rng getrandom() blocks. This means I am unable
> to even get output from 'qemu --help' for example. This is annoying at
> best.

Are you running QEMU during early boot ? Normally when there are
problems with the urandom source not being initialized, some OS
process will hang during early boot waiting for entropy. 

> Thinking about ways to work around this obviously the major one is to
> have an entropy source for the guest.

Yes, this is the strongly preferred solution. It is nice if the guest
can be provided a virtio-rng device, but that's not the only option.
The Linux kernel has a jitterentropy source which generates random
numbers from CPU jitter which should work in all cases if nothing
else is available as a random data source.

> In cases where this isn't possible I think it would make sense to fall
> back to the old /dev/random source when the getrandom() syscall returns
> EAGAIN indicating that it would block.

QEMU calls getrandom() with flags==0 and thus the data it is requesting
comes from the urandom source.  This should only block during early
boot when the kernel RNG source has not been initialized.

In this case falling back to /dev/random will also certainly block.
Perhaps that was a typo and you meant to fallback to /dev/urandom.
This would indeed not block, because the data it returns will *not*
be considered random due to urandom source not being initialized
yet. I think it would be a bad idea for QEMU to use this non-random
data.

> Alternatively it would be nice to have a config option to disable the
> new getrandom interface, along the lines of --disable-getrandom.

Disabling would have the same effect - if the urandom pool is not
initialized yet, QEMU would be reading data that is not random.

> If you feel that either of the approaches would be statisfactory I'd be
> happy to send a patch. Otherwise if we can have a discussion here with
> regards to how to progress.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

