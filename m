Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5DEC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E5E20789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgXSSwuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E5E20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZeM-0008Nc-4X
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kNZdJ-0007wo-6W
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kNZdG-00007g-Qd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:46:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601462801;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ff5S0TxFQ+b7vnHf5+waekB2E1oO3CHgJTCHKVpvnOo=;
 b=QgXSSwufq+LWXbbuvwivN+zE7Ye+o0GpVp2XSh5AL2Qa835cxgwJ9tKGZ+M7EsdoCHrIIF
 V6pzD3MCauburqwCebY2SFjxrfqpEtXBvK7uoqr0ZRWDVOPdti91vyrDUTkfhE72ecSZ5H
 0jL0pV9whFpeOHelpbn7E1eRstL6G5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-CW0dK63XP8SyTi7WqP6wBA-1; Wed, 30 Sep 2020 06:46:30 -0400
X-MC-Unique: CW0dK63XP8SyTi7WqP6wBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 019441015C84;
 Wed, 30 Sep 2020 10:46:29 +0000 (UTC)
Received: from redhat.com (ovpn-114-69.ams2.redhat.com [10.36.114.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 863E273699;
 Wed, 30 Sep 2020 10:46:27 +0000 (UTC)
Date: Wed, 30 Sep 2020 11:46:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: use of 'apt' in scripting in our dockerfiles provokes warnings
Message-ID: <20200930104624.GE2264779@redhat.com>
References: <CAFEAcA-wMzZhO-9EdYhPC3aoPatQ-JEtBJ2nSjGepRbLs-5AdA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wMzZhO-9EdYhPC3aoPatQ-JEtBJ2nSjGepRbLs-5AdA@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 11:33:21AM +0100, Peter Maydell wrote:
> While processing a recent pullreq which updated the dockerfile
> dependencies and thus provoked a rebuild, I noticed that we
> use the 'apt' command in ways that provoke a warning:
> 
> #7 0.789 WARNING: apt does not have a stable CLI interface. Use with
> caution in scripts.
> 
> The apt(8) manpage says:
> 
> SCRIPT USAGE AND DIFFERENCES FROM OTHER APT TOOLS
>        The apt(8) commandline is designed as an end-user tool and it may
>        change behavior between versions. While it tries not to break backward
>        compatibility this is not guaranteed either if a change seems
>        beneficial for interactive use.
> 
>        All features of apt(8) are available in dedicated APT tools like apt-
>        get(8) and apt-cache(8) as well.  apt(8) just changes the default value
>        of some options (see apt.conf(5) and specifically the Binary scope). So
>        you should prefer using these commands (potentially with some
>        additional options enabled) in your scripts as they keep backward
>        compatibility as much as possible.
> 
> That suggests that we should probably be using apt-get instead
> of apt in our dockerfiles...

It appears that we already use apt-get in some of the dockerfiles.
Yay for consistency. Should be an easy switch to standardize on
apt-get though.

> 
> Also, any idea what this error is about?
> 
> #4 importing cache manifest from registry.gitlab.com/qemu-project/qemu/qemu...
> #4       digest:
> sha256:815fb44b573ac7520d148d9b2510c00f31846ca6fa55127d322bc8db3c5d0ec0
> #4         name: "importing cache manifest from
> registry.gitlab.com/qemu-project/qemu/qemu/debian-alpha-cross:latest"
> #4      started: 2020-09-29 22:57:54.371490684 +0000 UTC
> #4    completed: 2020-09-29 22:57:55.064468936 +0000 UTC
> #4     duration: 692.978252ms
> #4        error: "invalid build cache from
> {MediaType:application/vnd.docker.distribution.manifest.v2+json
> Digest:sha256:a1e8a5830bb19b7cddda64872c5d71a0337d4b98bed30fd7684d20467adcd289
> Size:1161 URLs:[] Annotations:map[] Platform:<nil>}"
> 
> It didn't seemt to have an adverse effect...

I've not seen that before. I guess everything still works because cache
is optional.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


