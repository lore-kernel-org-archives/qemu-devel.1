Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825AAC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5FD20575
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afW6lg1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5FD20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDVWM-0006KB-BZ
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jDVSs-0004hv-Nb
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jDVSr-0004AV-K0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:46:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jDVSr-00047U-Cm
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584287168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hk0V1+ErACjTYckpGdPKhaJYhVVzaFlhDUbotdzJRwE=;
 b=afW6lg1FAefYHHDvXXLdV+2+DRz0MHsul0Sk/r9T6s2JvOsemOYwXbU6DF/TUu1FQ+tlT/
 Le9XMXDp92Qf0P3oob9wAduchEg5iz8d3CUPadm7DCTjnXeWGssUJrAysy8lRiwgTfg7Ed
 RyfE1V3yqIRQv5iNNErpSWsrY69LSBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-iaxq-4e-MwCyj_uFlk0nbQ-1; Sun, 15 Mar 2020 11:46:05 -0400
X-MC-Unique: iaxq-4e-MwCyj_uFlk0nbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0DCD8010E7;
 Sun, 15 Mar 2020 15:46:03 +0000 (UTC)
Received: from localhost (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8EFE27183;
 Sun, 15 Mar 2020 15:46:00 +0000 (UTC)
Date: Sun, 15 Mar 2020 11:45:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
Message-ID: <20200315154559.GW1187748@habkost.net>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-3-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200311232342.1614944-3-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, jingqi.liu@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, jtomko@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 07:23:42PM -0400, Eduardo Habkost wrote:
> The CONFIG_LINUX check at the top of mmap-alloc.c never worked
> because it was done before including osdep.h.
>=20
> This means MAP_SYNC and MAP_SHARED_VALIDATE would always be set
> to 0 at the beginning of the file.  Luckily, this didn't break
> when using recent glibc versions (2.28+), because those macros
> were redefined by glibc headers.
>=20
> Move the CONFIG_LINUX check after the main include lines, so the
> CONFIG_LINUX check works and we actually include <linux/mman.h>.
> This will make MAP_SYNC and MAP_SHARED_VALIDATE available even if
> the host has an older glibc version.
>=20
> Reported-by: Jingqi Liu <jingqi.liu@intel.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * (none)
> ---
>  util/mmap-alloc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 27dcccd8ec..7c2ce98eb0 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -9,6 +9,9 @@
>   * This work is licensed under the terms of the GNU GPL, version 2 or
>   * later.  See the COPYING file in the top-level directory.
>   */
> +#include "qemu/osdep.h"
> +#include "qemu/mmap-alloc.h"
> +#include "qemu/host-utils.h"
> =20
>  #ifdef CONFIG_LINUX
>  #include <linux/mman.h>

This breaks the build on mips, because mips doesn't have MAP_SYNC
defined at linux/mman.h:

https://app.shippable.com/github/ehabkost/qemu-hacks/runs/9/9/console


> @@ -17,10 +20,6 @@
>  #define MAP_SHARED_VALIDATE   0x0
>  #endif /* CONFIG_LINUX */
> =20
> -#include "qemu/osdep.h"
> -#include "qemu/mmap-alloc.h"
> -#include "qemu/host-utils.h"
> -
>  #define HUGETLBFS_MAGIC       0x958458f6
> =20
>  #ifdef CONFIG_LINUX
> --=20
> 2.24.1
>=20

--=20
Eduardo


