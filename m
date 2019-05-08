Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D431DC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F53214C6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F53214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOIVp-0006EA-Ue
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 05:05:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOISO-0003ug-Ia
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOISM-0006dw-Iu
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:01:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hOISG-0006Z9-QA; Wed, 08 May 2019 05:01:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 805383084213;
	Wed,  8 May 2019 09:01:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2160260C6A;
	Wed,  8 May 2019 09:01:33 +0000 (UTC)
Date: Wed, 8 May 2019 10:01:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190508090131.GA32552@redhat.com>
References: <20190507183610.9848-1-mreitz@redhat.com>
	<20190507183610.9848-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190507183610.9848-2-mreitz@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 08 May 2019 09:01:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/5] qemu-nbd: Add --pid-file option
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 08:36:06PM +0200, Max Reitz wrote:
> --fork is a bit boring if there is no way to get the child's PID.  This
> option helps.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-nbd.c    | 29 +++++++++++++++++++++++++++++
>  qemu-nbd.texi |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index dca9e72cee..7e48154f44 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -59,6 +59,7 @@
>  #define QEMU_NBD_OPT_IMAGE_OPTS    262
>  #define QEMU_NBD_OPT_FORK          263
>  #define QEMU_NBD_OPT_TLSAUTHZ      264
> +#define QEMU_NBD_OPT_PID_FILE      265
>  
>  #define MBR_SIZE 512
>  
> @@ -111,6 +112,7 @@ static void usage(const char *name)
>  "                            specify tracing options\n"
>  "  --fork                    fork off the server process and exit the parent\n"
>  "                            once the server is running\n"
> +"  --pid-file=PATH           store the server's process ID in the given file\n"
>  #if HAVE_NBD_DEVICE
>  "\n"
>  "Kernel NBD client support:\n"
> @@ -651,6 +653,7 @@ int main(int argc, char **argv)
>          { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
>          { "trace", required_argument, NULL, 'T' },
>          { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
> +        { "pid-file", required_argument, NULL, QEMU_NBD_OPT_PID_FILE },
>          { NULL, 0, NULL, 0 }
>      };
>      int ch;
> @@ -677,6 +680,8 @@ int main(int argc, char **argv)
>      bool list = false;
>      int old_stderr = -1;
>      unsigned socket_activation;
> +    const char *pid_path = NULL;
> +    FILE *pid_file;
>  
>      /* The client thread uses SIGTERM to interrupt the server.  A signal
>       * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
> @@ -876,6 +881,9 @@ int main(int argc, char **argv)
>          case 'L':
>              list = true;
>              break;
> +        case QEMU_NBD_OPT_PID_FILE:
> +            pid_path = optarg;
> +            break;
>          }
>      }
>  
> @@ -1196,6 +1204,27 @@ int main(int argc, char **argv)
>  
>      nbd_update_server_watch();
>  
> +    if (pid_path) {
> +        pid_file = fopen(pid_path, "w");
> +        if (!pid_file) {
> +            error_report("Failed to store PID in %s: %s",
> +                         pid_path, strerror(errno));
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        ret = fprintf(pid_file, "%ld", (long)getpid());
> +        if (ret < 0) {
> +            ret = -errno;
> +        }
> +        fclose(pid_file);
> +
> +        if (ret < 0) {
> +            error_report("Failed to store PID in %s: %s",
> +                         pid_path, strerror(-ret));
> +            exit(EXIT_FAILURE);
> +        }
> +    }

This is racy because multiple qemu-nbd's can be started pointing to
the same pidfile and one will blindly overwrite the other.

Please use  qemu_write_pidfile instead which acquires locks on the
pidfile in a race free manner.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

