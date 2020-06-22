Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B8AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B4A2073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3xkyvM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B4A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOhq-0001Uz-Bi
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnOeZ-0007j3-AB
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:46:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26621
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnOeV-000508-7T
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592840790;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gA+vBOr0SXBVfMN6yit8U4YRZyxpNmq2BbO3vsfC074=;
 b=d3xkyvM7iwAiTozctwF2vN6Nz0qby8AG7vZpr19CwQWZEPXefj8Qa+gCMELN+4ZpKjfvdF
 J1uiFXRlsOgFjIttI5pAq76w48AGUQbvF+q5j+pW9ijKXd+U5HqeE8S532OeeAvkUcSulp
 IwJsOVG/COV5YE+vajrpOutqYUgmrkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-zGbi1UYoM8GjmXpgSANVQw-1; Mon, 22 Jun 2020 11:46:28 -0400
X-MC-Unique: zGbi1UYoM8GjmXpgSANVQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 315F0EC1A6;
 Mon, 22 Jun 2020 15:46:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1966F5C241;
 Mon, 22 Jun 2020 15:46:14 +0000 (UTC)
Date: Mon, 22 Jun 2020 16:46:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
Message-ID: <20200622154611.GJ736373@redhat.com>
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com>
 <e6c27611-2873-2567-e3c8-f10b78831bc9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e6c27611-2873-2567-e3c8-f10b78831bc9@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 05:38:16PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/22/20 5:33 PM, Daniel P. Berrangé wrote:
> > We have a number of container images in tests/docker/dockerfiles
> > that are intended to provide well defined environments for doing
> > test builds. We want our CI system to use these containers too.
> > 
> > This introduces builds of all of them as the first stage in the
> > CI, so that the built containers are available for later build
> > jobs. The containers are setup to use the GitLab container
> > registry as the cache, so we only pay the penalty of the full
> > build when the dockerfiles change. The main qemu-project/qemu
> > repo is used as a second cache, so that users forking QEMU will
> > see a fast turnaround time on their CI jobs.
> 
> OMG you did it! Lovely... 😍
> 
> Looking at https://gitlab.com/berrange/qemu/-/pipelines/158854797
> why gitlab isn't caching the docker images? the cache isn't
> populated on all the runners yet? Or we have to use the same
> runner again to hit its cache?

It is caching it but it isn't obvious what to look for.

The "docker build" command is always still run, but you'll
notice each of the actual commands in the dockerfile are
followed by a message "  ---> Using cache", instead of the
normal command output.

Compare the "amd64-debian9-container" job as an example.

Here is the output seen in the original job which actually did a real
build:

   https://gitlab.com/berrange/qemu/-/jobs/605783351

And here is the output from the pipeline you point to above:

   https://gitlab.com/berrange/qemu/-/jobs/606175855

The cached case is still taking 2 mins 30 seconds, but the original
full build took 4 mins 50 seconds.

The difference will be more noticable if we expand the list of packages
install in the images to cover more of QEMU's possible dependancies.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


