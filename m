Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB8EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBAA21734
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGtwCw63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBAA21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuI4S-0003QM-DC
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuI3a-0002xc-Do
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuI3Z-0007n3-Az
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:36:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30923
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuI3Z-0007mh-7M
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579707396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uhaj6xVFlOl7k2BbX9setjtElsj+qViHlLbi8JzQ/g=;
 b=WGtwCw639H8emSVXd758qPXG3Bmpe0eSJZ6QHjsjlxuWn3KOsnbV6rU+y/CJ6p8Uz+30h1
 mwD2K6mZq6HklHOAfU5GGPbYjPQPQamY2Ca2wHHxzrIfT5zzHam8oMLQ9aC7s0peqLhPAp
 d5kF0FlU5uIhBe5AWWLsQtZK+sqZK+E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-Bqj0Apd7M5-2aJGN9lI_2g-1; Wed, 22 Jan 2020 10:36:32 -0500
Received: by mail-wr1-f72.google.com with SMTP id c17so3241002wrp.10
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 07:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B6M9xWuuS2KLZUIQfnNptYAL1stJTVjP6zQqyB48RAk=;
 b=dhu774HAHOo3uCT2+v3HVC/9Q5G1fn0vVoPOr4iAlUWRCy3hPtWd+8mk0x/vixgDaK
 tuyP7yaY8Hib0i201VW3pWscam5QSNp97bEguabEGWfVLQrt/LED0RCqiYr1u2OLSpD4
 Igiv31x3+uNCVjzR3CeCcA7N/AW1ZROiebOHEJZBPT9JGkFqR7WMafYsNoFJwmhwnuqP
 ygU+FsB35rbIsXU3upZK6AFgfCOPnrULxYxuVjtRBKr6qWUxu/h7IR2m06fH0nqEx6oT
 MTADt3owuOwPkLjBp62A5zHiUAO6Y/eHgugwI9qFwVetSHKWuMsuT5Wuh/djRSjpppFY
 3oeQ==
X-Gm-Message-State: APjAAAXGPHpTOt+otvP4UPlRPRFP3M3eF/uPIA1cnF/vd0D+Wo8N6XvI
 uT0oxM13rn2tRqefaAhdzUkoNBYkZk+eL2g3eyLG37J2NeUwFnso1HhpTmA/6KHCTtshBDsADFs
 Rd+/W1ANMnzzX714=
X-Received: by 2002:a5d:608a:: with SMTP id w10mr11274078wrt.136.1579707390961; 
 Wed, 22 Jan 2020 07:36:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzrAv0M8sQYOvGbqHKa6icGrYolknLgfOyqXatw4amKTJoDATRC9H6NbWYaFhIugOhpz8c7w==
X-Received: by 2002:a5d:608a:: with SMTP id w10mr11274054wrt.136.1579707390675; 
 Wed, 22 Jan 2020 07:36:30 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id b128sm4452219wmb.25.2020.01.22.07.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 07:36:30 -0800 (PST)
Subject: Re: [PATCH v2 062/109] virtiofsd: Add timestamp to the log with
 FUSE_LOG_DEBUG level
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-63-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5e3fca8d-446a-d550-c53e-a805b452248d@redhat.com>
Date: Wed, 22 Jan 2020 16:36:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-63-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: Bqj0Apd7M5-2aJGN9lI_2g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:23 PM, Dr. David Alan Gilbert (git) wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> virtiofsd has some threads, so we see a lot of logs with debug option.
> It would be useful for debugging if we can see the timestamp.
>=20
> Add nano second timestamp, which got by get_clock(), to the log with
> FUSE_LOG_DEBUG level if the syslog option isn't set.
>=20
> The log is like as:
>=20
>    ]# ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=3D/=
tmp/share0 -o cache=3Dauto

First ']' is incorrect copy/pasting?

>    ...
>    [5365943125463727] [ID: 00000002] fv_queue_thread: Start for queue 0 k=
ick_fd 9
>    [5365943125568644] [ID: 00000002] fv_queue_thread: Waiting for Queue 0=
 event
>    [5365943125573561] [ID: 00000002] fv_queue_thread: Got queue event on =
Queue 0
>=20
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>   tools/virtiofsd/passthrough_ll.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 991de69334..a7fb34ac0c 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -35,6 +35,8 @@
>    * \include passthrough_ll.c
>    */
>  =20
> +#include "qemu/osdep.h"

I think this include belongs to patch #011 "virtiofsd: Fix common header=20
and define for QEMU builds".

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +#include "qemu/timer.h"
>   #include "fuse_virtio.h"
>   #include "fuse_log.h"
>   #include "fuse_lowlevel.h"
> @@ -2275,7 +2277,13 @@ static void log_func(enum fuse_log_level level, co=
nst char *fmt, va_list ap)
>       }
>  =20
>       if (current_log_level =3D=3D FUSE_LOG_DEBUG) {
> -        localfmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_gett=
id), fmt);
> +        if (!use_syslog) {
> +            localfmt =3D g_strdup_printf("[%" PRId64 "] [ID: %08ld] %s",
> +                                       get_clock(), syscall(__NR_gettid)=
, fmt);
> +        } else {
> +            localfmt =3D g_strdup_printf("[ID: %08ld] %s", syscall(__NR_=
gettid),
> +                                       fmt);
> +        }
>           fmt =3D localfmt;
>       }
>  =20
>=20


