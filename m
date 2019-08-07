Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFEC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2730321E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2730321E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJ5A-0003Ah-Ge
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvJ4O-00025o-Sa
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvJ4N-0000VY-Uk
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:21:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvJ4N-0000VD-P9
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:21:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so87559891wrm.8
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ut8rKdsCGjwoDcQe1WfdHDD3p9bP4Zc5XPGg5dYQmXg=;
 b=HxLkA9YqIw6m0RSjQJCN8cO59XrF2hq/ZYzBWXe5qPDqqKna82ZXyLztmhAMGFtpBL
 7Oa+2UW8qntRhX+nZy8W/ZB8xpID2CGZklMhG/ZfsyOBhJuVKmx3z1pvtKSqfUtt3wCq
 5F9ClAoQEkK+b075NkCwTOE4wQgZE5JvzhFS/Ae7/4QcK4XVUpgCJpXU9rocKVCVOM2O
 9JsVX+xlTxbUEfqNkS7xG6+z0dyZoJnxLaA030sIJTJnI9LQfbM2zJphbFMsvhKdVYYE
 94h8ZzZhP+y6INHoA7RPgdDDK/5obJyGkGqtVfjQO41SGyFdUQ51Ci6Xn1fqOAmumW8X
 cJwQ==
X-Gm-Message-State: APjAAAUpbBftCBa6/1jFWdmyas3C1zMKp8r1siYmchz1JaSokG7LmV1x
 O/Kr1v+mtHUGxP+YL2MIfwEFSg==
X-Google-Smtp-Source: APXvYqxiVW/618AkUlNgKntXHr0JvaqLp+UaRw0p49XSvbe07Xv21nAv9fGCt0D56y8Vt6jR37c5MQ==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr9834417wrm.55.1565173282052;
 Wed, 07 Aug 2019 03:21:22 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id g17sm71882718wrm.7.2019.08.07.03.21.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 03:21:21 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5a03da74-d9f0-40c2-b961-62a3a63a0330@redhat.com>
Date: Wed, 7 Aug 2019 12:21:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190806151435.10740-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 05/29] queue: Drop superfluous #include
 qemu/atomic.h
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 5:14 PM, Markus Armbruster wrote:
> When commit 5f7d05ecfda added QLIST_INSERT_HEAD_RCU() to qemu/queue.h,
> it had to include qemu/atomic.h.  Commit 341774fe6cc removed
> QLIST_INSERT_HEAD_RCU() again, but neglected to remove the #include.
> Do that now.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/qemu/queue.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index 0379bd8fdb..73bf4a984d 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -78,8 +78,6 @@
>   * For details on the use of these macros, see the queue(3) manual page.
>   */
>  
> -#include "qemu/atomic.h" /* for smp_wmb() */
> -
>  /*
>   * List definitions.
>   */
> 

