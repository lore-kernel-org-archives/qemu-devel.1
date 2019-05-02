Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ABAC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC779206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 09:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC779206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM8F9-0006qO-04
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 05:43:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM8ES-0006Zw-C0
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM8EH-00030q-Tf
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:42:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hM8E0-0002fA-D7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:42:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id y2so1528527wmi.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 02:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=FpRdV7WJOm3gTkvQrJPJUGSWtDO/C+5FfdpSvIMirPg=;
	b=HtpzRAtGHjjY6lLPrrP5B1dDFLmsvDG6D96lHDCq3l0osMWKlGTfNRCw8OCyAAIIk/
	R2iNkgfIoUKGdqT9Wa+65db7YbkMc0WTAE1ZGAvMcch7PnQPa07VTfQRaUvDD9Cs4hvP
	2S6uWLMcwirytIrOfKBIeEBpGs9qdAyiqbwT2+sfrJO7ZtK/w+nV3CO77tmdOzip5p96
	BsL+XY6ctEr6XXtfC0fX4kLrOQOUxCUDT7Z94egfpv5DcRiyFHlal9tVW0mzdqxJ4mL3
	z1AoC0/EuX3dbba+R8CXWVbToBqpQN74OA+ZJKus/jh0ljbx3pszc/t0tTecJznEnBBz
	qCKw==
X-Gm-Message-State: APjAAAWKKfSyezhN8i4AXSaZdGgqILjgXikiIJfEcIlKDXSxc/fYnqA3
	q48zhL+Yy/7NFro71SdqX3k53w==
X-Google-Smtp-Source: APXvYqzQtcZq+qdi2DoFgkiNGJoDLwEXGYT3OELxudenpBz/Pz+xGkSha4aZsz/eXgqs+/SUIr1xOA==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr1607980wml.59.1556790100636; 
	Thu, 02 May 2019 02:41:40 -0700 (PDT)
Received: from steredhat (host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103]) by smtp.gmail.com with ESMTPSA id
	s17sm18044424wra.94.2019.05.02.02.41.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 02:41:39 -0700 (PDT)
Date: Thu, 2 May 2019 11:41:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190502094058.lfe2i7gl5rm4zxul@steredhat>
References: <20190501145052.12579-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501145052.12579-1-berrange@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2] sockets: avoid string truncation
 warnings when copying UNIX path
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502094137.c7bsAlDa7E-9FhEAPQLBO8dxhuuZ8jfgAQ9weaUpJ08@z>

On Wed, May 01, 2019 at 03:50:52PM +0100, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from util/qemu-sockets.c:18:
> In function ‘strncpy’,
>     inlined from ‘unix_connect_saddr.isra.0’ at util/qemu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘strncpy’,
>     inlined from ‘unix_listen_saddr.isra.0’ at util/qemu-sockets.c:880:5:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We are already validating the UNIX socket path length earlier in
> the functions. If we save this string length when we first check
> it, then we can simply use memcpy instead of strcpy later, avoiding
> the gcc truncation warnings.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

