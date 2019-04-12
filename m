Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E14FC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9B620850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9B620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40017 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzRd-0000Zo-VS
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:54:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzQW-0008PW-MZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzQV-0003r6-Ni
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:53:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEzQV-0003p6-Fa
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:53:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EA0881E15
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:53:18 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C52E60148;
	Fri, 12 Apr 2019 16:53:17 +0000 (UTC)
Date: Fri, 12 Apr 2019 17:53:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190412165314.GG2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-2-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 12 Apr 2019 16:53:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 01/17] include: Include fprintf-fn.h only
 where needed
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412165314.dQ9_QohMBhJGc74SM51Ck9w7xnK2oOvx2dZc-sT1pNM@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/qemu-common.h | 2 --
>  include/qemu/cutils.h | 2 --
>  include/sysemu/cpus.h | 1 +
>  3 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index a102245519..f891e05e7e 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -12,8 +12,6 @@
>  #ifndef QEMU_COMMON_H
>  #define QEMU_COMMON_H
>  
> -#include "qemu/fprintf-fn.h"
> -
>  #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
>  
>  /* Copyright string for -version arguments, About dialogs, etc */
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index d2dad3057c..12301340a4 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -1,8 +1,6 @@
>  #ifndef QEMU_CUTILS_H
>  #define QEMU_CUTILS_H
>  
> -#include "qemu/fprintf-fn.h"
> -
>  /**
>   * pstrcpy:
>   * @buf: buffer to copy string into
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 731756d948..eea0010b53 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -1,6 +1,7 @@
>  #ifndef QEMU_CPUS_H
>  #define QEMU_CPUS_H
>  
> +#include "qemu/fprintf-fn.h"
>  #include "qemu/timer.h"
>  
>  /* cpus.c */
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

