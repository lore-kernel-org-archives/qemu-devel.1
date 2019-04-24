Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F0CC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92F921773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92F921773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFTe-0005vR-OC
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 06:50:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJFSh-0005ZR-7x
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJFSf-0007lV-Oj
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:49:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hJFSb-0007gt-U2; Wed, 24 Apr 2019 06:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE948C04B2E4;
	Wed, 24 Apr 2019 10:49:04 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FB005D9C8;
	Wed, 24 Apr 2019 10:48:58 +0000 (UTC)
Date: Wed, 24 Apr 2019 11:48:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190424104855.GE31388@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190424103747.10173-6-thuth@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 24 Apr 2019 10:49:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424104855.UumHNd7lN70DS7T4_LjVUPTbezKGomOq3tb3KIksywc@z>

On Wed, Apr 24, 2019 at 12:37:46PM +0200, Thomas Huth wrote:
> People often forget to run the iotests before submitting patches or
> pull requests - this is likely due to the fact that we do not run the
> tests during our mandatory "make check" tests yet. Now that we've got
> a new "ci" group of iotests that should be fine to run in every environ-
> ment, it should be OK to enable the iotests during "make check" again.
> Thus we now run the "ci" tests by default from the qemu-iotests-quick.sh
> script, and only use the former "quick" group (that contains some tests
> that are failing in some environments) when the user decided to run
> "make check SPEED=thorough" or something similar.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include      |  2 +-
>  tests/qemu-iotests-quick.sh | 17 ++++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)

> diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
> index 0e554bb972..416b3fc48b 100755
> --- a/tests/qemu-iotests-quick.sh
> +++ b/tests/qemu-iotests-quick.sh

s/-quick//  perhaps, since it no longer only runs the "quick" tests.

> @@ -1,8 +1,23 @@
>  #!/bin/sh
>  
> +# Honor the SPEED environment variable, just like we do it for the qtests.
> +# The default is to run all tests that still work fine in a CI environments,
> +# but if the user set SPEED=slow or SPEED=thorough, we also run all other
> +# tests that are still marked as "quick"
> +if [ "$SPEED" = "slow" -o "$SPEED" = "thorough" ]; then
> +    group=quick

When user asks for "slow" tests we run the "quick" tests, which
presumably implies...

> +else
> +    group=ci

..."ci" is quicker than the "quick"  tests !

Confused ? We certainly try to ensure that you will be :-)

> +fi
> +
> +if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
> +    echo "No qemu-system binary available. Skipped qemu-iotests."
> +    exit 0
> +fi
> +
>  cd tests/qemu-iotests
>  
>  ret=0
> -TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g quick || ret=1
> +TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g "$group" || ret=1


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

