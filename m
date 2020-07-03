Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8189CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EA9208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdClpDeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EA9208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNRY-0003bh-Je
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrNPQ-0000tf-Cc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:15:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrNPO-0003e7-GY
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593789321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=EjCYvOrwZDf6Wpst0H+Id0/VhmE4j4c8ByeJMWzgE04=;
 b=UdClpDeWv4OCgPQXFDRgX094UQLkbE1aElm/8EwZY6yIkOExQXpYOs1SJaTpvGko5Ez21r
 M1LO43DkrmtibgUfzfK78Pz0dhYZEj7v/jRdKZdc33IreSqzWuUu1bNNmhaLdC0PSdm+V5
 g6qc4Vy38jNHJi4mC2RgButGtUe+B5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-mSo0t1EDMkOtA7tPWWKtKg-1; Fri, 03 Jul 2020 11:15:19 -0400
X-MC-Unique: mSo0t1EDMkOtA7tPWWKtKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1B63106BF7D;
 Fri,  3 Jul 2020 15:15:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0FDC5BADB;
 Fri,  3 Jul 2020 15:15:14 +0000 (UTC)
Subject: Re: [PATCH v3 4/9] osdep.h: Always include <sys/signal.h> if it exists
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200703145614.16684-1-peter.maydell@linaro.org>
 <20200703145614.16684-5-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2b801122-1ee2-d62d-a5dc-30f7c770b54d@redhat.com>
Date: Fri, 3 Jul 2020 17:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200703145614.16684-5-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/2020 16.56, Peter Maydell wrote:
> From: David CARLIER <devnexen@gmail.com>
> 
> Regularize our handling of <sys/signal.h>: currently we include it in
> osdep.h, but only for OpenBSD, and we include it without an ifdef
> guard in a couple of C files.  This causes problems for Haiku, which
> doesn't have that header.
> 
> Instead, check in configure whether sys/signal.h exists, and if it
> does then always include it from osdep.h.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> [PMM: Expanded commit message]
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure                   | 8 ++++++++
>  include/qemu/osdep.h        | 2 +-
>  hw/xen/xen-legacy-backend.c | 1 -
>  util/oslib-posix.c          | 1 -
>  4 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index ddc53d873ef..d131f760d8f 100755
> --- a/configure
> +++ b/configure
> @@ -3212,6 +3212,11 @@ if ! check_include "ifaddrs.h" ; then
>    have_ifaddrs_h=no
>  fi
>  
> +have_sys_signal_h=no
> +if check_include "sys/signal.h" ; then
> +  have_sys_signal_h=yes
> +fi
> +
>  ##########################################
>  # VTE probe
>  
> @@ -7398,6 +7403,9 @@ fi
>  if test "$have_broken_size_max" = "yes" ; then
>      echo "HAVE_BROKEN_SIZE_MAX=y" >> $config_host_mak
>  fi
> +if test "$have_sys_signal_h" = "yes" ; then
> +    echo "CONFIG_SYS_SIGNAL=y" >> $config_host_mak
> +fi

I'd maybe rather name it HAVE_SYS_SIGNAL_H, but I guess that's just a
matter of taste.

Reviewed-by: Thomas Huth <thuth@redhat.com>


