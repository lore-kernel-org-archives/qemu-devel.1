Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FDBC28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCD4207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCD4207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58533 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqO5-0008E5-0Q
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:16:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYqKC-00059o-K9
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hYqKA-0002kG-Od
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:12:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hYqK4-0002Ze-Rk; Thu, 06 Jun 2019 07:12:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66EBE3079B60;
	Thu,  6 Jun 2019 11:12:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A57192A345;
	Thu,  6 Jun 2019 11:12:34 +0000 (UTC)
Date: Thu, 6 Jun 2019 12:12:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>
Message-ID: <20190606111232.GG14300@redhat.com>
References: <20190605213654.9785-1-ptoscano@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605213654.9785-1-ptoscano@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 06 Jun 2019 11:12:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6] ssh: switch from libssh2 to libssh
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, rjones@redhat.com,
	qemu-devel@nongnu.org, mreitz@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 11:36:54PM +0200, Pino Toscano wrote:
> Rewrite the implementation of the ssh block driver to use libssh instead
> of libssh2.  The libssh library has various advantages over libssh2:
> - easier API for authentication (for example for using ssh-agent)
> - easier API for known_hosts handling
> - supports newer types of keys in known_hosts
> 
> Use APIs/features available in libssh 0.8 conditionally, to support
> older versions (which are not recommended though).


> 
> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> ---
> 
> Changes from v5:
> - adapt to newer tracing APIs
> - disable ssh compression (mimic what libssh2 does by default)
> - use build time checks for libssh 0.8, and use newer APIs directly
> 
> Changes from v4:
> - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
> - fix few return code checks
> - remove now-unused parameters in few internal functions
> - allow authentication with "none" method
> - switch to unsigned int for the port number
> - enable TCP_NODELAY on the socket
> - fix one reference error message in iotest 207
> 
> Changes from v3:
> - fix socket cleanup in connect_to_ssh()
> - add comments about the socket cleanup
> - improve the error reporting (closer to what was with libssh2)
> - improve EOF detection on sftp_read()
> 
> Changes from v2:
> - used again an own fd
> - fixed co_yield() implementation
> 
> Changes from v1:
> - fixed jumbo packets writing
> - fixed missing 'err' assignment
> - fixed commit message
> 
>  block/Makefile.objs        |   6 +-
>  block/ssh.c                | 610 +++++++++++++++++++------------------
>  block/trace-events         |  14 +-
>  configure                  |  62 ++--
>  tests/qemu-iotests/207.out |   2 +-
>  5 files changed, 351 insertions(+), 343 deletions(-)


> diff --git a/configure b/configure
> index b091b82cb3..bfdd70c40a 100755
> --- a/configure
> +++ b/configure

> @@ -3914,43 +3914,17 @@ EOF
>  fi
>  
>  ##########################################
> -# libssh2 probe
> -min_libssh2_version=1.2.8

The commit message says we're conditionally using APIs from 0.8.0,
but doesn't say what minimum version we actually need and there's
no check here.

In terms of our supported build platforms, the oldest libssh I
see is RHEL-7 with 0.7.1.

So assume it does actually compile on RHEL-7, then it is desirable
to have a min_libssh_Version=0.7.1 set here & checked below.

At some future date when support platforms changes, we'll then be
able to tweak it to 0.8.0 and drop the conditional compilation.

> -if test "$libssh2" != "no" ; then
> -  if $pkg_config --atleast-version=$min_libssh2_version libssh2; then
> -    libssh2_cflags=$($pkg_config libssh2 --cflags)
> -    libssh2_libs=$($pkg_config libssh2 --libs)
> -    libssh2=yes
> +# libssh probe
> +if test "$libssh" != "no" ; then
> +  if $pkg_config --exists libssh; then
> +    libssh_cflags=$($pkg_config libssh --cflags)
> +    libssh_libs=$($pkg_config libssh --libs)
> +    libssh=yes
>    else
> -    if test "$libssh2" = "yes" ; then
> -      error_exit "libssh2 >= $min_libssh2_version required for --enable-libssh2"
> +    if test "$libssh" = "yes" ; then
> +      error_exit "libssh required for --enable-libssh"
>      fi
> -    libssh2=no
> -  fi
> -fi

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

