Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA8C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE87205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcmoBk5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE87205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkhS-0002xS-PB
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDkc0-0004tT-Mu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:28:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42509
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDkby-0000tm-Tb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599121730;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WO1IykrkRljFCtH0u7QdGEA7PjsC6uXTJ94gGyKBLWk=;
 b=VcmoBk5cJZS7af9xuU6LWI1hKpFc5f3juM3C4teoS/ahHOGO0qxCGURxfGyGliHMbUA9NA
 z27tW/2mCLnS4wX4niHWimZnVksgeuqQ9waqnd6ROzxC4NcVGWUDrgtDAsPf4RHyqgH5OE
 iYb+PU3rW/oqiQazoHw6odPnW2vJp38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-9ibuIiBiNLayewcBA3V-tA-1; Thu, 03 Sep 2020 04:28:46 -0400
X-MC-Unique: 9ibuIiBiNLayewcBA3V-tA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62CC01007471;
 Thu,  3 Sep 2020 08:28:45 +0000 (UTC)
Received: from redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EDB96CE4D;
 Thu,  3 Sep 2020 08:28:44 +0000 (UTC)
Date: Thu, 3 Sep 2020 09:28:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v3 00/12] Green the msys2 CI make
Message-ID: <20200903082841.GG441291@redhat.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 03:43:01PM +0800, Yonggang Luo wrote:
> Also it's fixes issues about make check
> 
> Yonggang Luo (12):
>   configure: fixes dtc not cloned when running msys2 CI
>   meson: Convert undefsym.sh to undefsym.py
>   tcg: Fixes dup_const link error
>   tests: handling signal on win32 properly
>   configure: Fix include and linkage issue on msys2
>   block: Fixes nfs on msys2/mingw
>   osdep: These function are only available on Non-Win32 system.
>   ci: fixes msys2 build by upgrading capstone to 4.0.2
>   stubs: qemu_notify_event have no need to stub
>   meson: Fixes qapi tests.
>   tests: Disable test-image-locking that not works under Win32
>   ci: Enable msys2 ci in cirrus
> 
>  .cirrus.yml                         |   108 +-
>  block/nfs.c                         |  1812 +--
>  capstone                            |     2 +-
>  configure                           | 16560 +++++++++++++-------------
>  include/qemu/osdep.h                |  1372 +--
>  include/tcg/tcg.h                   |  2898 ++---
>  meson.build                         |  2994 ++---
>  scripts/ci/windows/msys2_build.sh   |    33 +
>  scripts/ci/windows/msys2_install.sh |    31 +
>  scripts/undefsym.py                 |    57 +
>  scripts/undefsym.sh                 |    20 -
>  stubs/notify-event.c                |     8 +-
>  tcg/tcg-op-gvec.c                   |  7012 +++++------
>  tests/Makefile.include              |  1086 +-
>  tests/qapi-schema/meson.build       |   451 +-
>  tests/test-replication.c            |  1214 +-
>  16 files changed, 17904 insertions(+), 17754 deletions(-)

This whole series is messed up adding/removing 1000's of lines of
code with no change. I'm assuming you've introduced DOS line
endings causing a massive diff


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


