Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A1BC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83351206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83351206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNdjj-0005Qk-KO
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 09:32:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kheib@redhat.com>) id 1hNdii-00055R-Fm
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kheib@redhat.com>) id 1hNdih-0001mN-Io
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:31:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kheib@redhat.com>) id 1hNdih-0001lW-CQ
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:31:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so1569681wmi.1
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 06:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vSN7Thh132WZDfZrspRnY/ocym5CKOY6vT5Z4gWzOks=;
	b=i/m98k0Y4fk9BRSsS1WPEcJ5T9wGsmBrYSUmBK7M2Zqk18s7URrY8ZPd1wbIapPnBo
	WdiAoYdWO6sYqTF+ihdDyDmQi3ojP8CJw9DKzzHTgtvcRrYffStqJqvPiOmdEn5a675X
	jVvwP8muWiXYjYK3NHObjoChZiGThHZu7dYWe7zbavUxqmtjUEdKuF5Lo+yO4/38+qSn
	cNg77kybic5HN2YL4T/PVPn6WmUQrlvs0XzUQMyDGt04o++yDbxs6oOAsBXTEGr3sh3q
	2Apeq1Pu/jmO3TrYXQByQGF2ivwV2znS4KKsFqTc9pUDtu4uTj3Qvv6gUhX4TC6yJPVS
	YNIg==
X-Gm-Message-State: APjAAAXBhGQ6ygAKLm2z7icYGk56sSJCjAQrXTQuThn+dRfUAi9+J2Jy
	oQ/2FNaIDFhKH7ahq9GBbqjuBgOd5YA=
X-Google-Smtp-Source: APXvYqxENha2A43cl2o9EM50RQxuMohbe49D2A4D8kaNBOXSKWA9ZmFUfPfySbS/YjlsfkyxEZDgtw==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr17352882wma.71.1557149508728; 
	Mon, 06 May 2019 06:31:48 -0700 (PDT)
Received: from [192.168.1.105] (bzq-109-67-4-126.red.bezeqint.net.
	[109.67.4.126]) by smtp.gmail.com with ESMTPSA id
	v18sm9100787wro.11.2019.05.06.06.31.47
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 06:31:48 -0700 (PDT)
To: Yuval Shaia <yuval.shaia@oracle.com>, marcel.apfelbaum@gmail.com,
	qemu-devel@nongnu.org
References: <20190505105112.22691-1-yuval.shaia@oracle.com>
From: Kamal Heib <kheib@redhat.com>
Message-ID: <278d00ab-768c-c6b4-fc2a-5a1ee2e2ba79@redhat.com>
Date: Mon, 6 May 2019 16:31:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505105112.22691-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Delete unused headers inclusion
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/5/19 1:51 PM, Yuval Shaia wrote:
> This is a trivial cleanup patch.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  hw/rdma/rdma_backend.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index d1660b6474..05f6b03221 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -14,16 +14,9 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "sysemu/sysemu.h"
> -#include "qapi/error.h"
> -#include "qapi/qmp/qlist.h"
> -#include "qapi/qmp/qnum.h"
>  #include "qapi/qapi-events-rdma.h"
>  
>  #include <infiniband/verbs.h>
> -#include <infiniband/umad_types.h>
> -#include <infiniband/umad.h>
> -#include <rdma/rdma_user_cm.h>
>  
>  #include "contrib/rdmacm-mux/rdmacm-mux.h"
>  #include "trace.h"
> 

Reviewed-by: Kamal Heib <kheib@redhat.com>

