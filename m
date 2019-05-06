Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC69C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A4E2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 14:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A4E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNeMT-00052d-94
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 10:12:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNeLg-0004gt-Rs
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hNeLf-0005i8-Ty
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:12:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hNeLf-0005hj-Ou
	for qemu-devel@nongnu.org; Mon, 06 May 2019 10:12:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18CA0356E4;
	Mon,  6 May 2019 14:12:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 052C660C4C;
	Mon,  6 May 2019 14:12:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 793401132B35; Mon,  6 May 2019 16:12:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190503193721.18459-1-ehabkost@redhat.com>
Date: Mon, 06 May 2019 16:12:02 +0200
In-Reply-To: <20190503193721.18459-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Fri, 3 May 2019 16:37:21 -0300")
Message-ID: <871s1br7t9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 06 May 2019 14:12:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Deprecate Python 2 support
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Python 2 will reach end of life in January 1 2020.  Declare it as
> deprecated.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  configure            | 8 ++++++++
>  qemu-deprecated.texi | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/configure b/configure
> index 5b183c2e39..50385061ed 100755
> --- a/configure
> +++ b/configure
> @@ -6461,6 +6461,14 @@ if test "$supported_os" = "no"; then
>      echo "us upstream at qemu-devel@nongnu.org."
>  fi
>  
> +# Note that if the Python conditional here evaluates True we will exit
> +# with status 1 which is a shell 'false' value.
> +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
> +  echo
> +  echo "WARNING: Python 2 support is deprecated" >&2
> +  echo "WARNING: Python 3 will be required for building future versions of QEMU" >&2

Please don't shout "warning".  

> +fi
> +
>  config_host_mak="config-host.mak"
>  
>  echo "# Automatically generated by configure - do not modify" >config-all-disas.mak
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 842e71b11d..2f2d9a3e95 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -206,3 +206,11 @@ Note that if you are exposing the export via /dev/nbd0, it is easier
>  to just export the entire image and then mount only /dev/nbd0p1 than
>  it is to reinvoke @command{qemu-nbd -c /dev/nbd0} limited to just a
>  subset of the image.
> +
> +@section Build system
> +
> +@subsection Python 2 support (since 4.1.0)
> +
> +In the future, QEMU will require Python 3 to be available at
> +build time.  Support for Python 2 in scripts shipped with QEMU
> +is deprecated.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

