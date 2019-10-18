Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8000CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD32F20663
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD32F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSXG-0007HM-UA
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iLSWM-0006cj-9y
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iLSWL-0001yy-75
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:42:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58812)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iLSWK-0001yk-U4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:42:21 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D448E2D6A3F
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 13:42:19 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k4so2703687wru.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 06:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CM22kF1hX/gKyH1MdvDK6bYTJUPtBgkegAIt1Fo6asQ=;
 b=oZLmOy4qNYDWj53IxgZe0ge/EPxdJ1F48hc3LiqW1oIoKw3xSOIj9KFWmr/aduRdez
 9Hq6TNlAD9zVtX/e4s2AAbjzeJbD5x0hNtnOnJeAuK7vdUp+2pMLaQq8xvQuyWRfvu6y
 r5xnqidjfEW9h8EXWzwsONY4wkPEaLgqDzzZnw96vHRDV43vDluS2miSoeeNx1AfIMUw
 OIv79JJaEIujWfYQSkfpiiC4L1O+L0onKQ+Jtzsj+uzbfgWy7p+7WPSh+M69dEE3cLsZ
 V48NscG3HRpSAXjCZpjFNkXUxfOSU1mh2bszDcWubN/FcBS/V7uMZ8F/fU0zZ/uycuvQ
 G8kg==
X-Gm-Message-State: APjAAAUFeJwp/hfz39zGZRimOe0MzhTwCXIeMtmWDb/gVzMpTdJauOlk
 wSku9BeKLkxCCvgBKwYy8gYFwf/WilQbq+NDTBCEfcKgyahdGI2UFmnR2CKYytDvFVeezeuFQmU
 iVkHmu5Q4sHNRpyI=
X-Received: by 2002:a5d:6949:: with SMTP id r9mr8118709wrw.106.1571406138480; 
 Fri, 18 Oct 2019 06:42:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXaJUm2DeK+PvdOriUphd1170tmdyQZkDowuqXh2mz58Byb1jDM9lu6MZ80QdhB50unka6NQ==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr8118678wrw.106.1571406138158; 
 Fri, 18 Oct 2019 06:42:18 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id w7sm4461539wmd.22.2019.10.18.06.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 06:42:17 -0700 (PDT)
Date: Fri, 18 Oct 2019 15:42:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] Do not use %m in common code to print error messages
Message-ID: <20191018134215.u6psfffrrxlsa2ns@steredhat>
References: <20191018130716.25438-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018130716.25438-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, berrange@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 03:07:16PM +0200, Thomas Huth wrote:
> The %m format specifier is an extension from glibc - and when compiling
> QEMU for NetBSD, the compiler correctly complains, e.g.:
> 
> /home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c: In function 'sigfd_handler':
> /home/qemu/qemu-test.ELjfrQ/src/util/main-loop.c:64:13: warning: %m is only
>  allowed in syslog(3) like functions [-Wformat=]
>              printf("read from sigfd returned %zd: %m\n", len);
>              ^
> Let's use g_strerror() here instead, which is an easy-to-use wrapper
> around the thread-safe strerror_r() function.
> 
> While we're at it, also convert the "printf()" in main-loop.c into
> the preferred "error_report()".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Do not try to g_free() the strings
> 
>  hw/misc/tmp421.c | 4 ++--
>  util/main-loop.c | 3 ++-
>  util/systemd.c   | 4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)

There are many uses of %m also in hw/vfio/ but that's Linux stuff.
Should we change those too or it doesn't matter since it never really
compiled on NetBSD?

Anyway, this patch LGTM:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 
> diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
> index 9f044705fa..c0bc150bca 100644
> --- a/hw/misc/tmp421.c
> +++ b/hw/misc/tmp421.c
> @@ -120,7 +120,7 @@ static void tmp421_get_temperature(Object *obj, Visitor *v, const char *name,
>      int tempid;
>  
>      if (sscanf(name, "temperature%d", &tempid) != 1) {
> -        error_setg(errp, "error reading %s: %m", name);
> +        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
>          return;
>      }
>  
> @@ -160,7 +160,7 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
>      }
>  
>      if (sscanf(name, "temperature%d", &tempid) != 1) {
> -        error_setg(errp, "error reading %s: %m", name);
> +        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
>          return;
>      }
>  
> diff --git a/util/main-loop.c b/util/main-loop.c
> index e3eaa55866..eda63fe4e0 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -61,7 +61,8 @@ static void sigfd_handler(void *opaque)
>          }
>  
>          if (len != sizeof(info)) {
> -            printf("read from sigfd returned %zd: %m\n", len);
> +            error_report("read from sigfd returned %zd: %s", len,
> +                         g_strerror(errno));
>              return;
>          }
>  
> diff --git a/util/systemd.c b/util/systemd.c
> index d22e86c707..1dd0367d9a 100644
> --- a/util/systemd.c
> +++ b/util/systemd.c
> @@ -60,8 +60,8 @@ unsigned int check_socket_activation(void)
>               * and we should exit.
>               */
>              error_report("Socket activation failed: "
> -                         "invalid file descriptor fd = %d: %m",
> -                         fd);
> +                         "invalid file descriptor fd = %d: %s",
> +                         fd, g_strerror(errno));
>              exit(EXIT_FAILURE);
>          }
>      }
> -- 
> 2.18.1
> 
> 

-- 

