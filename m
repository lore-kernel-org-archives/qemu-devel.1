Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F41C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECBE206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdhjU3t1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECBE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ9gB-0001lx-PY
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 04:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZ9fO-0000DI-1K
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:56:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jZ9fL-0006x0-Bs
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589446590;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ixk7zmgwNlwnWKZA2SC2GE/i5MTqWvNVToMbRKftZEY=;
 b=NdhjU3t13r3gggp7aVvUoLUJdJJgiFGtIgAHxftq19udFZg135BBV4sXR1Xk1f4QuVTgyM
 riiLsX63prub8y0kcLQldKUYPk1EW98xB3mJ9kmI7rpEarodOJuBnHrmfl+7hZqE0KB2GU
 Sk/dXPRtVnk1K64QjxSX8L+jLW9IMXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-rlP0TT1bNDax7FKPfmsEDA-1; Thu, 14 May 2020 04:56:28 -0400
X-MC-Unique: rlP0TT1bNDax7FKPfmsEDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84989189952E;
 Thu, 14 May 2020 08:56:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E52E47D96D;
 Thu, 14 May 2020 08:56:25 +0000 (UTC)
Date: Thu, 14 May 2020 09:56:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: proposal: deprecate -readconfig/-writeconfig
Message-ID: <20200514085622.GB1280939@redhat.com>
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 14, 2020 at 10:09:21AM +0200, Paolo Bonzini wrote:
> IMHO configuration files are in general a failed experiment.  In
> practice, they do not add much value over just a shell script because
> they don't allow configuring all QEMU options, they are very much fixed
> (by their nature).  I think it's more or less agreed that they are not
> solving any problem for higher-level management stacks as well; those
> would prefer to configure the VM via QMP or another API.
>
> So, any objections to deprecating -readconfig and -writeconfig?

Libvirt would like to have a config file for QEMU, but it would have
to be one that actually covers all the config options QEMU supports,
and ideally using a data format in common with that used for runtime
changes. So for libvirt's needs the current readconfig is entirely
useless.

For a less general purpose mgmt app, that targets some specific use
cases I could imagine people might have used readconfig. Note that
we have a bunch of documentation that is illustrating usage of
-readconfig to our users. So it is quite possible we have people
relying on this feature even though it is incomplete in its coverage
of options.

If we deprecate them, the only alternative users have right now is
to go back to passing CLI args. This works, as this is what libvirt
has always done, but it isn't pretty to see 1 MB command lines ;-P

So essentially we'd be deciding to kill the feature with no direct
replacement, even though it is potentially useful in some limited
scenarios.

If we have a general strategy to eliminate QemuOpts and move entirely
to QAPI based config, then I can see -readcofig/-writeconfig may be
creating a burden of back compatibility on maintainers.

This could justify us removing the feature with no immediate replacement,
on the basis that would facilitate more important changes that are for
the greater good of the project long term.

Overall, I don't object, just cautioning that we should be aware that
we're likely to have some users of this feature we're conciously going
to break.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


