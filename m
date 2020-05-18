Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C0BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11955207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 13:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T964Ofjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11955207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jag2B-0002UT-Ai
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 09:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jag1Z-0001z9-8l
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:41:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51060
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jag1Y-00053r-4n
 for qemu-devel@nongnu.org; Mon, 18 May 2020 09:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589809302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLbqQj4oPY/pz3+K/1DR9PwFYqJi1eePZQ97u1eMfpM=;
 b=T964OfjkhUEqtJilOzL3jQBFJc8t3/W1XDr7GV0VyteNVlgoiZDxwOX4bQzAMbRnXZTdZ1
 k1kGdeqTjvNN2PRWln7WDD2vL40e0u/XWs/Rf+v+/OIO0jmuo7LmcvkEExxB5lIUBz8cJP
 mk4jSY4QlvtXmiIauVKJRxUYqlOwNPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-on3S1ucMN1iM6g0NouvV4A-1; Mon, 18 May 2020 09:41:40 -0400
X-MC-Unique: on3S1ucMN1iM6g0NouvV4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45231100CCC2;
 Mon, 18 May 2020 13:41:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAFDD34661;
 Mon, 18 May 2020 13:41:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DCE9417444; Mon, 18 May 2020 15:41:36 +0200 (CEST)
Date: Mon, 18 May 2020 15:41:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/2] hw/display: Include local 'framebuffer.h'
Message-ID: <20200518134136.2y3fq5a4kwgwocwt@sirius.home.kraxel.org>
References: <20200504082003.16298-1-f4bug@amsat.org>
 <20200504082003.16298-2-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200504082003.16298-2-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 10:20:02AM +0200, Philippe Mathieu-Daudé wrote:
> The "framebuffer.h" header is not an exported include.

Patch added to ui queue.
(patch 2/2 skipped, has unanswered quesions).

thanks,
  Gerd

> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/display/artist.c  | 2 +-
>  hw/display/next-fb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 753dbb9a77..e1d5885fed 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -21,7 +21,7 @@
>  #include "migration/vmstate.h"
>  #include "ui/console.h"
>  #include "trace.h"
> -#include "hw/display/framebuffer.h"
> +#include "framebuffer.h"
>  
>  #define TYPE_ARTIST "artist"
>  #define ARTIST(obj) OBJECT_CHECK(ARTISTState, (obj), TYPE_ARTIST)
> diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
> index 2b726a10f8..b0513a8fba 100644
> --- a/hw/display/next-fb.c
> +++ b/hw/display/next-fb.c
> @@ -27,7 +27,7 @@
>  #include "hw/hw.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "hw/display/framebuffer.h"
> +#include "framebuffer.h"
>  #include "ui/pixel_ops.h"
>  #include "hw/m68k/next-cube.h"
>  
> -- 
> 2.21.3
> 


