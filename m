Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EDFC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5250121743
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5250121743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1QS-0001lN-J7
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw1Py-0001Lb-Ck
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw1Px-0008UH-Ci
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:42:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw1Px-0008U1-66
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:42:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so5040934wmp.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IF9i5MkBj1Rac6J3It91j+Ty1Shp223Jad8QVXcYG2A=;
 b=HnO/e5+/UOvQJpn+YtFkM0YECoDkz78INCtLkdGrzprFrgWR1+ibzIyTXj6YymY/Fr
 50vSgqYnxq5lrP/78ZNfyS8xGCENQJtMvfcwY2gm9/TzeGR/7Eh5/5iTaqXG8MXq6Y8N
 QVGra/uu7rE9g/QqyHQVmvpPRkRzuyA7vmc5D0js3m/slT0njThJCGEUiZULaEgc6eSH
 O2lTy7z6vSTXLAe2zSQLySV3473oMxM6OQcWRZ5ZDUTRVZj6uCfu5dkHjLzydG2SOHzG
 M6GUEVxf+oYuwr3HRjHII9BiSElgj1Pn/uMuX6HmVhvaRvamKqgTNrOOJ4nJnu2RPcu5
 qUKg==
X-Gm-Message-State: APjAAAWvws75i3ltvEmHTIZdTa3tiVmE2o/wzbByo8Y4JTAngddYL7FE
 XzQz1m9uW7CEdiA5B6uT7qjsSMTDTe4=
X-Google-Smtp-Source: APXvYqxpS1EjQ6G7Xaf7dHDELQpsjt5rHXhCv/IrDIaKdN2CpSF1/c6hLud+hsGE/UF1uZKgB74HIA==
X-Received: by 2002:a1c:1a87:: with SMTP id a129mr9582131wma.21.1565343755920; 
 Fri, 09 Aug 2019 02:42:35 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id h97sm9511427wrh.74.2019.08.09.02.42.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 02:42:35 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-21-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c76aaebc-d4bf-cb25-fe27-7a9c9ba644c9@redhat.com>
Date: Fri, 9 Aug 2019 11:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809064645.22656-21-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 20/29] Include qemu/main-loop.h less
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 8:46 AM, Markus Armbruster wrote:
> In my "build everything" tree, changing qemu/main-loop.h triggers a
> recompile of some 5600 out of 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h).  It includes block/aio.h,
> which in turn includes qemu/event_notifier.h, qemu/notify.h,
> qemu/processor.h, qemu/qsp.h, qemu/queue.h, qemu/thread-posix.h,
> qemu/thread.h, qemu/timer.h, and a few more.
> 
> Include qemu/main-loop.h only where it's needed.  Touching it now
> recompiles only some 1700 objects.  For block/aio.h and
> qemu/event_notifier.h, these numbers drop from 5600 to 2800.  For the
> others, they shrink only slightly.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
[...]
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 77f5df59b0..ac18a1184a 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -5,7 +5,6 @@
>  #include "qapi/qapi-types-run-state.h"
>  #include "qemu/timer.h"
>  #include "qemu/notify.h"
> -#include "qemu/main-loop.h"
>  #include "qemu/bitmap.h"
>  #include "qemu/uuid.h"
>  #include "qom/object.h"

netmap failing again :S

$ make docker-image-debian-amd64 V=1 DEBUG=1
[...]
  CC      net/netmap.o
net/netmap.c: In function 'netmap_update_fd_handler':
net/netmap.c:109:5: error: implicit declaration of function
'qemu_set_fd_handler' [-Werror=implicit-function-declaration]
     qemu_set_fd_handler(s->nmd->fd,
     ^~~~~~~~~~~~~~~~~~~
net/netmap.c:109:5: error: nested extern declaration of
'qemu_set_fd_handler' [-Werror=nested-externs]

