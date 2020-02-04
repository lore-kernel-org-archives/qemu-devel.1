Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8430CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505F42082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwpdVhAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505F42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyk2-00031U-JX
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iyyjE-00023h-AR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iyyjC-0007P2-NW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:59:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32886
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iyyjB-0007K4-8w
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580824736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ApGRq2pAqqElL2FcP1kx2oyo6ZLVMcPzjujT+Ww5cc=;
 b=BwpdVhAJHACBle8mbRA8ZR1tsi6pW4RpDWmXJ10O2EvPBBdn5BWwbgarP6bTx0Zbn79U3P
 YmhKrGaVW3CCU/uE0FNpvVd40Ktp6OqACTkUH3Yxk09IxfRaJ498MyoQRf0tAxnyHxgzN0
 QW435iQlmfRY4BCQUwUIWuR5TLGZocI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Sb_i5eB6N9GX-4z-ADDk6A-1; Tue, 04 Feb 2020 08:58:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B62A7107B276;
 Tue,  4 Feb 2020 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-4.gru2.redhat.com [10.97.116.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CC0D3AB;
 Tue,  4 Feb 2020 13:58:48 +0000 (UTC)
Subject: Re: [PATCH 2/2] configure: Check that sphinx-build is using Python 3
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200203132533.21850-1-peter.maydell@linaro.org>
 <20200203132533.21850-3-peter.maydell@linaro.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <c5464ee1-01be-cbfb-f674-c0052388779d@redhat.com>
Date: Tue, 4 Feb 2020 11:58:46 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203132533.21850-3-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Sb_i5eB6N9GX-4z-ADDk6A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/3/20 11:25 AM, Peter Maydell wrote:
> Currently configure's has_sphinx_build() check simply runs a dummy
> sphinx-build and either passes or fails.  This means that "no
> sphinx-build at all" and "sphinx-build exists but is too old" are
> both reported the same way.
>
> Further, we want to assume that all the Python we write is running
> with at least Python 3.5; configure checks that for our scripts, but
> Sphinx extensions run with whatever Python version sphinx-build
> itself is using.
>
> Add a check to our conf.py which makes sphinx-build fail if it would
> be running our extensions with an old Python, and handle this
> in configure so we can report failure helpfully to the user.
> This will mean that configure --enable-docs will fail like this
> if the sphinx-build provided is not suitable:
>
> Warning: sphinx-build exists but it is either too old or uses too old a Python version
>
> ERROR: User requested feature docs
>         configure was not able to find it.
>         Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx
>
> (As usual, the default is to simply not build the docs, as we would
> if sphinx-build wasn't present at all.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> At the moment our Sphinx extensions all work under Python 2;
> but the one for handling parsing QAPI docs out of the JSON is going
> to want to include some of the scripts/qapi Python which is more
> complicated and definitely now 3-only.  In any case it's nicer to
> fail cleanly rather than let users stumble into corner cases we don't
> test and don't want to support even if they happen to work today.
> ---
>   configure    | 12 ++++++++++--
>   docs/conf.py | 10 ++++++++++
>   2 files changed, 20 insertions(+), 2 deletions(-)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>



>
> diff --git a/configure b/configure
> index 830f325822a..95055f2e9dd 100755
> --- a/configure
> +++ b/configure
> @@ -4808,11 +4808,19 @@ has_sphinx_build() {
>   
>   # Check if tools are available to build documentation.
>   if test "$docs" != "no" ; then
> -  if has makeinfo && has pod2man && has_sphinx_build; then
> +  if has_sphinx_build; then
> +    sphinx_ok=yes
> +  else
> +    sphinx_ok=no
> +  fi
> +  if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
>       docs=yes
>     else
>       if test "$docs" = "yes" ; then
> -      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and python-sphinx"
> +      if has $sphinx_build && test "$sphinx_ok" != "yes"; then
> +        echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
> +      fi
> +      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx"
>       fi
>       docs=no
>     fi
> diff --git a/docs/conf.py b/docs/conf.py
> index ee7faa6b4e7..7588bf192ee 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -28,6 +28,16 @@
>   
>   import os
>   import sys
> +import sphinx
> +from sphinx.errors import VersionRequirementError
> +
> +# Make Sphinx fail cleanly if using an old Python, rather than obscurely
> +# failing because some code in one of our extensions doesn't work there.
> +# Unfortunately this doesn't display very neatly (there's an unavoidable
> +# Python backtrace) but at least the information gets printed...
> +if sys.version_info < (3,5):
> +    raise VersionRequirementError(
> +        "QEMU requires a Sphinx that uses Python 3.5 or better\n")
>   
>   # The per-manual conf.py will set qemu_docdir for a single-manual build;
>   # otherwise set it here if this is an entire-manual-set build.


