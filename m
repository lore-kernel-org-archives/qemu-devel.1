Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E82C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157632080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7ijQkmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157632080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iop3m-00008U-UL
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iop06-0000RG-Mp
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iop05-0006df-Kx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:34:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28064
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iop05-0006c6-GB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578404065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=aVHWUPijN67Yd8prPGoEwGFdSzw4hbEysj3lMHTDpXY=;
 b=X7ijQkmkBtB//Wm4dRg80byuer4xG8gu16Pgt3P6ooTONBkBQbqndwQWtSGNQLCVUkt59t
 TiCKKrEHuiBOoK3a26AT1mE+OzFBVKThUHl6KWm1g4xhGJuHAWTDWwX3oQeABV7J/IfPtj
 aWekctgAY3HGewGIEI6oPjjSG/bMos8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-B6jzkJq9O2e1-GXptvivYQ-1; Tue, 07 Jan 2020 08:34:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1124E801E77;
 Tue,  7 Jan 2020 13:34:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2711E86C43;
 Tue,  7 Jan 2020 13:34:21 +0000 (UTC)
Subject: Re: [PATCH v1 31/59] util/aio-posix.c: remove unneeded 'out' label in
 aio_epoll
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-32-danielhb413@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e38ddfcb-1b65-a7ac-924b-5c0d36476bad@redhat.com>
Date: Tue, 7 Jan 2020 14:34:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106182425.20312-32-danielhb413@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: B6jzkJq9O2e1-GXptvivYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/01/2020 19.23, Daniel Henrique Barboza wrote:
> 'out' can be replaced by 'return ret'.
> 
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  util/aio-posix.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index a4977f538e..7c4cfea8ce 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -121,7 +121,7 @@ static int aio_epoll(AioContext *ctx, GPollFD *pfds,
>                           ARRAY_SIZE(events),
>                           timeout);
>          if (ret <= 0) {
> -            goto out;
> +            return ret;
>          }
>          for (i = 0; i < ret; i++) {
>              int ev = events[i].events;
> @@ -132,7 +132,6 @@ static int aio_epoll(AioContext *ctx, GPollFD *pfds,
>                  (ev & EPOLLERR ? G_IO_ERR : 0);
>          }
>      }
> -out:
>      return ret;
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>


