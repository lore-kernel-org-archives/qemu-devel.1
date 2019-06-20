Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A41C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1508520679
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1508520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdxlB-0005u4-MK
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52975)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hdxPN-0005JZ-BG
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hdxPL-0004CU-DZ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:47:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hdxCs-00057V-KU
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:34:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 667EE37F41
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 13:34:15 +0000 (UTC)
Received: from work-vm (ovpn-117-203.ams2.redhat.com [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 077D45D9D2;
 Thu, 20 Jun 2019 13:34:11 +0000 (UTC)
Date: Thu, 20 Jun 2019 14:34:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190620133409.GA5910@work-vm>
References: <20190620114116.27254-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620114116.27254-1-imammedo@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 20 Jun 2019 13:34:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] deprecate -mem-path fallback to anonymous
 RAM
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Igor Mammedov (imammedo@redhat.com) wrote:
> Fallback might affect guest or worse whole host performance
> or functionality if backing file were used to share guest RAM
> with another process.
> 
> Patch deprecates fallback so that we could remove it in future
> and ensure that QEMU will provide expected behavior and fail if
> it can't use user provided backing file.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Ah yes that's useful because it's a mess for postcopy.



Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> PS:
> Patch is written on top of
>   [PATCH v4 0/3] numa: deprecate '-numa node,  mem' and default memory distribution
> to avoid conflicts in qemu-deprecated.texi
> 
>  numa.c               | 4 ++--
>  qemu-deprecated.texi | 8 ++++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 91a29138a2..53d67b8ad9 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -494,8 +494,8 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>              if (mem_prealloc) {
>                  exit(1);
>              }
> -            error_report("falling back to regular RAM allocation.");
> -
> +            warn_report("falling back to regular RAM allocation. "
> +                        "Fallback to RAM allocation is deprecated.");
>              /* Legacy behavior: if allocation failed, fall back to
>               * regular RAM allocation.
>               */
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 2fe9b72121..2193705644 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -112,6 +112,14 @@ QEMU using implicit generic or board specific splitting rule.
>  Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} (if
>  it's supported by used machine type) to define mapping explictly instead.
>  
> +@subsection -mem-path fallback to RAM (since 4.1)
> +Currently if system memory allocation from file pointed by @option{mem-path}
> +fails, QEMU fallbacks to allocating from anonymous RAM. Which might result
> +in unpredictable behavior since provided backing file wasn't used. In future
> +QEMU will not fallback and fail to start up, so user could fix his/her QEMU/host
> +configuration or explicitly use -m without -mem-path if system memory allocated
> +from anonymous RAM suits usecase.
> +
>  @section QEMU Machine Protocol (QMP) commands
>  
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
> -- 
> 2.18.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

