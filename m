Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5740C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931C520850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931C520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEe3w-0006YE-It
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 14:04:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEe2q-0006C0-MB
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEe2o-0004aP-I8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEe2o-0004Zv-9X
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3635E2CD7F8
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 18:03:25 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C38625C207;
	Thu, 11 Apr 2019 18:03:17 +0000 (UTC)
Date: Thu, 11 Apr 2019 19:03:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190411180314.GI3641@redhat.com>
References: <20190411175345.19414-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411175345.19414-1-thuth@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 11 Apr 2019 18:03:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH for-QEMU-4.1] Declare -realtime
 as deprecated
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411180314.Y3lz6tcUvNjmMtK5XIGdkYcoSgru1grXfM-awQ2AHms@z>

On Thu, Apr 11, 2019 at 07:53:45PM +0200, Thomas Huth wrote:
> The old -realtime mlock=on|off parameter does exactly the same as the
> new -overcommit mem-lock=on|off parameter. Additionally, "-realtime"
> does not activate any additional "realtime" capabilities as the name
> might indicate. We should avoid to confuse the users this way, so
> let's deprecate the old -realtime option.

FYI libvirt currently uses  -realtime mlock=on so will need adapting
to cope with this change.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Deprecation has already been suggested last year:
>   https://patchwork.kernel.org/patch/10480963/#22026215
>  ... but apparently we forgot to really do it.
> 
>  qemu-deprecated.texi | 5 +++++
>  vl.c                 | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 2219386769..2c45204f3f 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -72,6 +72,11 @@ backend settings instead of environment variables.  To ease migration to
>  the new format, the ``-audiodev-help'' option can be used to convert
>  the current values of the environment variables to ``-audiodev'' options.
>  
> +@subsection -realtime (since 4.1)
> +
> +The @code{-realtime mlock=on|off} argument has been replaced by the
> +@code{-overcommit mem-lock=on|off} argument.
> +
>  @section QEMU Machine Protocol (QMP) commands
>  
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
> diff --git a/vl.c b/vl.c
> index c696ad2a13..d6a2779b70 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3912,6 +3912,8 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>              case QEMU_OPTION_realtime:
> +                warn_report("'-realtime mlock=...' is deprecated, please use "
> +                             "'-overcommit mem-lock=...' instead");
>                  opts = qemu_opts_parse_noisily(qemu_find_opts("realtime"),
>                                                 optarg, false);
>                  if (!opts) {
> -- 
> 2.21.0
> 
> --
> libvir-list mailing list
> libvir-list@redhat.com
> https://www.redhat.com/mailman/listinfo/libvir-list

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

