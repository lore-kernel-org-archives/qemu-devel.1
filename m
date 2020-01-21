Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2589C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4E024653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STNZab2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4E024653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itucJ-00006o-JU
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ituB3-0000rv-C3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ituAz-0008WQ-6P
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:06:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ituAz-0008Vt-1S
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579615600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c15pK4ujm6hBaqsGSqfq6xH4gGQtafWdSPYDDOHuoiw=;
 b=STNZab2spVYfKvVW4kA2lyEu2tv6nVePaTdSTXN2xRGZLFBJh3Ce4bAmG4T3nH4xdLyTQM
 Vye7xj8bz1t7bgwM33Z0z4pn2/UEdV9zX0Cn0k0VD2U+NMXVb+phnR7a5eVnxJmlWrIT/p
 14lRJGoi9G3+tl5iYJ2cMB3EW+hIMP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228--ugODxVUPJOaJe8zucGimg-1; Tue, 21 Jan 2020 09:06:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBA5C802B7F;
 Tue, 21 Jan 2020 14:06:32 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E453A5C290;
 Tue, 21 Jan 2020 14:06:25 +0000 (UTC)
Date: Tue, 21 Jan 2020 15:06:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 10/10] accel/tcg: Sanitize include path
Message-ID: <20200121150623.09441553.cohuck@redhat.com>
In-Reply-To: <20200121110349.25842-11-philmd@redhat.com>
References: <20200121110349.25842-1-philmd@redhat.com>
 <20200121110349.25842-11-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: -ugODxVUPJOaJe8zucGimg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 12:03:49 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Commit af0440ae852 moved the qemu_tcg_configure() function,
> but introduced extraneous 'include/' in the includes path.
> As it is not necessary, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: New patch
> ---
>  accel/tcg/tcg-all.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 1802ce02f6..acfdcfdf59 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -31,9 +31,9 @@
>  #include "sysemu/cpus.h"
>  #include "qemu/main-loop.h"
>  #include "tcg/tcg.h"
> -#include "include/qapi/error.h"
> -#include "include/qemu/error-report.h"
> -#include "include/hw/boards.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "hw/boards.h"
>  #include "qapi/qapi-builtin-visit.h"
> =20
>  typedef struct TCGState {

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


