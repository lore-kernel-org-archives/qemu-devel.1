Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9183FC4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 05:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB1C208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 05:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB1C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg062-0003k9-Ki
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 01:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hg04z-0003If-9w
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hg04x-0006Na-Kk
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43150)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hg04x-0006L9-2Q
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:02:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05563882FD
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 05:02:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B9C05D70D;
 Wed, 26 Jun 2019 05:02:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC28411386A0; Wed, 26 Jun 2019 07:02:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
References: <20190625161629.302-1-imammedo@redhat.com>
Date: Wed, 26 Jun 2019 07:02:37 +0200
In-Reply-To: <20190625161629.302-1-imammedo@redhat.com> (Igor Mammedov's
 message of "Tue, 25 Jun 2019 12:16:29 -0400")
Message-ID: <87ftnxkkgi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 26 Jun 2019 05:02:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] deprecate -mem-path fallback to
 anonymous RAM
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
Cc: berrange@redhat.com, ehabkost@redhat.com, libvir-list@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor Mammedov <imammedo@redhat.com> writes:

> Fallback might affect guest or worse whole host performance
> or functionality if backing file were used to share guest RAM
> with another process.
>
> Patch deprecates fallback so that we could remove it in future
> and ensure that QEMU will provide expected behavior and fail if
> it can't use user provided backing file.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>  * improve text language
>     (Markus Armbruster <armbru@redhat.com>)
>
>  numa.c               | 6 ++++--
>  qemu-deprecated.texi | 9 +++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/numa.c b/numa.c
> index 91a29138a2..c15e53e92d 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -494,8 +494,10 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>              if (mem_prealloc) {
>                  exit(1);
>              }
> -            error_report("falling back to regular RAM allocation.");
> -
> +            warn_report("falling back to regular RAM allocation");
> +            error_printf("This is deprecated. Make sure that -mem-path "
> +                         " specified path has sufficient resources to allocate"
> +                         " -m specified RAM amount or QEMU will fail to start");

The "or QEMU will fail to start" is confusing, I'm afraid.  *This* QEMU
won't.  A future QEMU may.  Suggest to simply delete the confusing part.

>              /* Legacy behavior: if allocation failed, fall back to
>               * regular RAM allocation.
>               */
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 2fe9b72121..1b7f3b10dc 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -112,6 +112,15 @@ QEMU using implicit generic or board specific splitting rule.
>  Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} (if
>  it's supported by used machine type) to define mapping explictly instead.
>  
> +@subsection -mem-path fallback to RAM (since 4.1)
> +Currently if guest RAM allocation from file pointed by @option{mem-path}
> +fails, QEMU falls back to allocating from RAM, which might result
> +in unpredictable behavior since the backing file specified by the user
> +is ignored. In the future, users will be responsible for making sure
> +the backing storage specified with @option{-mem-path} can actually provide
> +the guest RAM configured with @option{-m} and fail to start up if RAM allocation
> +is unsuccessful.

Grammar nit: the subject of "fail to start up" is "users", oopsie.
Suggest ", and QEMU will fail to start up".

> +
>  @section QEMU Machine Protocol (QMP) commands
>  
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)

With these tweaks:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

