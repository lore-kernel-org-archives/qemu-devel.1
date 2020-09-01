Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DADC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1556206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQfiiOb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1556206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9AL-0003Bl-2f
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD99n-0002jX-NL
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:29:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59842
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD99l-00082B-Km
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598977752;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GQGmnwvrpHXwagQ7pistkOkGOXu+e1QpS9iqvXC0HoA=;
 b=WQfiiOb3i+oPQ/6+HcMcKaMg+DcDIMhP4PRlyPbEXe6E9NgIEy2lDbNjfl9kgKXjJlYGKE
 Oh21XgZsmrQvq2/y7jOPFPUTYUclgQIG0//yXiXVlLhlzG9g5/YEpqm576goxfwq8nVvjf
 TlrfL5znJBikPZfEJV2ZqxUJwGcUXgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-DPLn0jTaOFqSWQbEyZglCg-1; Tue, 01 Sep 2020 12:29:11 -0400
X-MC-Unique: DPLn0jTaOFqSWQbEyZglCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD82B1008566;
 Tue,  1 Sep 2020 16:29:09 +0000 (UTC)
Received: from redhat.com (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5724E5C1C4;
 Tue,  1 Sep 2020 16:29:04 +0000 (UTC)
Date: Tue, 1 Sep 2020 17:29:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 0/7] Run cross-compilation build tests in the gitlab-CI
Message-ID: <20200901162901.GY345480@redhat.com>
References: <20200823111757.72002-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200823111757.72002-1-thuth@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, luoyonggang@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 23, 2020 at 01:17:50PM +0200, Thomas Huth wrote:
> Now that we can use all our QEMU build containers in the gitlab-CI,
> we can also run the cross-compilation jobs there. Of course, some
> problems have to be fixed first, so this is taken care of in the first
> four patches.
> 
> The following two patches make sure that we can also enable WHPX builds with
> our debian-win64-cross container, so that we can compile-test this accelerator
> code now, too.
> 
> The last patch then finally enables the cross-compilation jobs in the CI.
> 
> v2:
>  - Dropped patches that are not necessary anymore
>  - Added the first two patches to fix problems with the new meson build
>    system
> 
> Thomas Huth (7):
>   configure: Add system = 'linux' for meson when cross-compiling
>   tests/docker: Install python3-setuptools in the debian9-mxe containers
>   tests/Makefile: test-image-locking needs CONFIG_POSIX
>   tests/Makefile: test-replication needs CONFIG_POSIX
>   dockerfiles/debian-win64-cross: Download WHPX MinGW headers
>   configure: Allow automatic WHPX detection
>   gitlab-ci: Add cross-compiling build tests
> 
>  .gitlab-ci.d/crossbuilds.yml                  | 113 ++++++++++++++++++
>  .gitlab-ci.yml                                |   1 +
>  MAINTAINERS                                   |   1 +
>  configure                                     |   4 +
>  tests/Makefile.include                        |   6 +-
>  .../dockerfiles/debian-win64-cross.docker     |   9 +-
>  tests/docker/dockerfiles/debian9-mxe.docker   |   2 +-
>  7 files changed, 133 insertions(+), 3 deletions(-)
>  create mode 100644 .gitlab-ci.d/crossbuilds.yml

You seem to have not sent the mail for 

  [PATCH 8/7] delete obsolete shippable config

;-P


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


