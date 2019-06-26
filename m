Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1448C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876DA2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876DA2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgB9a-0003v5-Ol
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hgB76-0002KE-Ol
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hgB71-0004c9-Dy
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:49:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hgB6s-0004M2-05
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:49:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so2796723wmj.5
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 09:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=eyqwr1JNXTuZXcESW20xlAoTqcK3kn1VqNUOXwRkQVE=;
 b=OhCUSPIsykW3I6G+Va/ZdAFIGCf+o4Dc9IX0AZzenyEk6/E231RrbQ1o++jT6uQtMO
 2jD4Hm1WBkAoGKiVOrwZwtAN35vYdilL5JshxumSAAy3WPcuraKdvdILofxfmYAFJaUZ
 UA3UaBYGivVTGMHHjIpYiB8AkcrsJRox6I56ugfXz2unxt+grkxdqfGs2J5FgB+ckOXh
 Mgd6ULzf68QbXvNpHFCbStNP9TFZ+rwWyG01gP63DGlRdt36X7Sn8mtQx+USG9pZVq1m
 /rUOUVcJszI0jorVG3s0xtt0eKyZrLu8a+X2iMDRlWo7tJf13e5jw3eLGqNYoq0Fa/o3
 67Yw==
X-Gm-Message-State: APjAAAU9/t3OhV3yi8TAT/6EolChb1FQV7VaeirzCOTDBxJ5SvEDwM9K
 kWSo8XFi+5IzRWqtKJFBW6ULCA==
X-Google-Smtp-Source: APXvYqwgheF1yDrw3G3hN37LjmPR+5UYYrZJynxOVGcfhiS4VmZwBwU2ZfZ+eNmFzlMMoNrBzo1AHQ==
X-Received: by 2002:a1c:345:: with SMTP id 66mr24028wmd.8.1561567756178;
 Wed, 26 Jun 2019 09:49:16 -0700 (PDT)
Received: from steredhat (host21-207-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.207.21])
 by smtp.gmail.com with ESMTPSA id n1sm13638073wrx.39.2019.06.26.09.49.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 09:49:15 -0700 (PDT)
Date: Wed, 26 Jun 2019 18:49:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Message-ID: <20190626164913.dn2vfv4rji7xsk5k@steredhat>
References: <20190625123905.25434-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625123905.25434-1-dinechin@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2] Fix build error when VNC is configured
 out
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 02:39:05PM +0200, Christophe de Dinechin wrote:
> In hmp_change(), the variable hmp_mon is only used
> by code under #ifdef CONFIG_VNC. This results in a build
> error when VNC is configured out with the default of
> treating warnings as errors:
> 
> monitor/hmp-cmds.c: In function ‘hmp_change’:
> monitor/hmp-cmds.c:1946:17: error: unused variable ‘hmp_mon’ [-Werror=unused-variable]
> 1946 |     MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
>      |                 ^~~~~~~
> 
> v2: Move variable down as suggested by Philippe Mathieu-Daudé

Should we move out this line from the commit message?
(Maybe Dave can remove it when apply)

> 
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  monitor/hmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

