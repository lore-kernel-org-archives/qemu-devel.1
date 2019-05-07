Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A6C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07B52054F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07B52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44247 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNxVC-0003l4-1t
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 06:39:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNxUP-0003PY-8g
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNxUN-00015G-2M
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:38:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hNxUM-000140-10
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:38:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D4743066800;
	Tue,  7 May 2019 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-186.ams2.redhat.com
	[10.36.116.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AEFA31001DF5;
	Tue,  7 May 2019 10:38:15 +0000 (UTC)
Date: Tue, 7 May 2019 12:38:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190507103814.GF5808@localhost.localdomain>
References: <20190503193721.18459-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503193721.18459-1-ehabkost@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 07 May 2019 10:38:19 +0000 (UTC)
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
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.05.2019 um 21:37 hat Eduardo Habkost geschrieben:
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
> +fi

While it's clear that we want to get rid of Python 2, did we actually
discuss how to decide what the new minimum Python version is? I don't
think any major distribution uses 3.0, which was released in 2008, so
this doesn't seem to make a lot of sense to me as the new minimum.

Currently, 3.6 seems to be a commonly available version. It looks like
Debian stable is at 3.5 still, though it might become oldstable before
the next QEMU release. Do we need to support anything older than that?

Kevin

