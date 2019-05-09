Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8F5C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B300020578
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 05:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B300020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48385 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hObuC-0008JB-25
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 01:47:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hObrx-0006HX-Jt
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hObrw-0003xt-F4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:45:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hObrw-0003xH-76
	for qemu-devel@nongnu.org; Thu, 09 May 2019 01:45:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 523F3806B3;
	Thu,  9 May 2019 05:45:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D92985C221;
	Thu,  9 May 2019 05:45:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 656DA1132B35; Thu,  9 May 2019 07:45:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190508182339.22447-1-ehabkost@redhat.com>
Date: Thu, 09 May 2019 07:45:17 +0200
In-Reply-To: <20190508182339.22447-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Wed, 8 May 2019 15:23:39 -0300")
Message-ID: <87ftpo89le.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 09 May 2019 05:45:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] configure: Require python3 >= 3.5
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> The oldest python3 version in distros that will be supported by
> QEMU 4.1 is 3.5.3 (the one in Debian Stretch).  Error out if
> running python3 < 3.5.
>
> We have a .travis.yml job configured to use Python 3.4.  Change
> it to use Python 3.5.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  configure   | 5 +++--
>  .travis.yml | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/configure b/configure
> index 6b3ed8c532..520c207d66 100755
> --- a/configure
> +++ b/configure
> @@ -1841,8 +1841,9 @@ fi
>  
>  # Note that if the Python conditional here evaluates True we will exit
>  # with status 1 which is a shell 'false' value.
> -if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
> -  error_exit "Cannot use '$python', Python 2 >= 2.7 or Python 3 is required." \
> +if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7) or \
> +                                      (3,0) <= sys.version_info < (3,5))'; then
> +  error_exit "Cannot use '$python', Python 2 >= 2.7 or Python 3 >= 3.5 is required." \
>        "Use --python=/path/to/python to specify a supported Python."
>  fi
>  
> diff --git a/.travis.yml b/.travis.yml
> index 66448d99d6..0f6986b3f1 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -211,7 +211,7 @@ matrix:
>          - CONFIG="--target-list=x86_64-softmmu"
>        language: python
>        python:
> -        - "3.4"
> +        - "3.5"
>  
>  
>      - env:

Easily missed, good work.

My grep for similar references to Python versions we don't support found
a few 2.x, x < 7.  Not this patch's problem, of course, but let me show
them anyway:

* scripts/qapi/common.py

        # re.subn() lacks flags support before Python 2.7, use re.compile()

  I'll clean this up.

* tests/image-fuzzer/

  docs/image-fuzzer.txt "Fuzzer requirements" item "17. Should be
  compatible with python version 2.4-2.7".

  Stefan, does the fuzzer need porting to Python 3?

  Two spots in the code are marked as 2.4 work-arounds:

    tests/image-fuzzer/qcow2/fuzz.py:        in Python 2.4
    tests/image-fuzzer/runner.py:        # Python 2.4 doesn't support 'finally' and 'except' in the same 'try'

Grep also found tests/vm/netbsd and tests/vm/openbsd pass
--python=python2.7 to configure.  Eduardo, should they be upgraded to a
suitable version of Python 3?  Possibly in your "[PATCH] Deprecate
Python 2 support"?

If yes, then https://wiki.qemu.org/Hosts/BSD also needs an update.

