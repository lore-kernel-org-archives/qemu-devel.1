Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F18C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16C120787
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4ZgRxPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16C120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKIpv-0002oF-39
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jKIpE-00028x-6I
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jKIpD-00048P-55
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:41:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56355
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jKIpD-000484-1a
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585906878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qg19V/5vgzKncAs+MasFtQi/jNHYopheJRPLweR8bWw=;
 b=K4ZgRxPvqBIs+AvpHzuuJ3nMELHwjuOhmfdd2UXvSQbFtMvpdm6roMpQkoltRuncwKMUYE
 KrQ/EJft82cexXX5w1z1r4fmJTip+w1hkgJoHRGAomiaxSAGdWfwJ3LvzCvfxwYkGsmqzp
 SLTQcZrdxpWJ5J44nR8rwxSzcGHsa2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-StHTTRwZMoem1ougtRtcTw-1; Fri, 03 Apr 2020 05:41:17 -0400
X-MC-Unique: StHTTRwZMoem1ougtRtcTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8AE1190B2A0;
 Fri,  3 Apr 2020 09:41:15 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAFF5118F20;
 Fri,  3 Apr 2020 09:41:03 +0000 (UTC)
Date: Fri, 3 Apr 2020 11:41:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 01/12] move 'typedef Aml' to qemu/types.h
Message-ID: <20200403114102.383a8e71@redhat.com>
In-Reply-To: <20200403080502.8154-2-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-2-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  3 Apr 2020 10:04:51 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/aml-build.h | 1 -
>  include/qemu/typedefs.h     | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index de4a4065682c..1bfe5844e984 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -32,7 +32,6 @@ struct Aml {
>      uint8_t op;
>      AmlBlockFlags block_flags;
>  };
> -typedef struct Aml Aml;
>  
>  typedef enum {
>      AML_COMPATIBILITY = 0,
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 375770a80f06..ecf3cde26c3c 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -24,6 +24,7 @@
>  typedef struct AdapterInfo AdapterInfo;
>  typedef struct AddressSpace AddressSpace;
>  typedef struct AioContext AioContext;
> +typedef struct Aml Aml;
>  typedef struct AnnounceTimer AnnounceTimer;
>  typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
>  typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;


