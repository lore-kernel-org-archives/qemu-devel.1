Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4FDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C70F2469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 13:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF0DsNbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C70F2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fhB-0006km-Hs
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 08:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7fgT-0005pw-Lt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j7fgS-0007LD-Nt
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 08:28:05 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j7fgS-0007L2-JY; Fri, 28 Feb 2020 08:28:04 -0500
Received: by mail-ot1-x344.google.com with SMTP id j16so2572760otl.1;
 Fri, 28 Feb 2020 05:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ex/U+ZXS0a7QzW/hujcnxdk5o23BUA3sQLdU7CdIaHc=;
 b=qF0DsNbeRRxcnlvPbcBIdp9kYNOQ+B6Dtv4t+4IGklpOGk0ToCVyFqJzypQdA4bNOz
 dHC9EsM7QP6nrLNQ0CzWuDHUjMdTUp/1Kr4BAl675p64QB55TOTsXW8k75AFMUniCEQN
 e2n/KETpifLO+YNNt9k8W3yAESz7e7RzHIGFZ7MCo6hZwP55bkF3JNZelO/h6wfbaqiI
 z/QSC17w7vNhIj6oWPdXwOdReU4o1TOxf5OY1uF7ZfptNQvpNRwUG0OfX3QL5//pKc0I
 c1la8us+zaDtXxxAIgkhDIkohnQ672d5poWgYfZAK3wEJUrDi8rQL1ZOc3WRqiXVCP3B
 1zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ex/U+ZXS0a7QzW/hujcnxdk5o23BUA3sQLdU7CdIaHc=;
 b=cfX2e2/dUxBBizQmIhmx3l75oy6ShBV1V1oxURQW9vrQ3YMTPzA2/rEsDnOdmMoVZa
 BAs2dI8H77bfKFgJsExZU/K3O1NQzPKiWBgveusIpdGDSHAhu1XKOjj9TVyxdMe+MZVL
 +usB0YtbyecUUkRDoXNnqAY1AtXoDmFl6kotQuSkGU+f5kT2uqDxqDyGWK7vJOyeJjWQ
 CRaazW0OZfNwbyonWTmYPUUWXuOAlQIXkgmP8qLm+veiA2mHFS7tbjB/RRHbkJdKGLjP
 ZuVuj2m/EZgjANuu5sDqyrQp1pVPOsgJW+rjEBEhyoJbvCYIecxsRfWqQufuWY5My9m+
 bYdA==
X-Gm-Message-State: APjAAAWVtdz3niR6/UiZ+76L1yILQMGFnsC8v/f3wsBsTfVyu0S8dM5h
 0AH0c5qjHIvYBuLwFd6jvwwBRR9OLx8O4Bnslxs=
X-Google-Smtp-Source: APXvYqw/TnEE8HDSaP4oUfFDDerImFuJHU+7JZm5U7/VOA0Q8wgxdQlOvwfbKwzdL2SF6ilhrj9GRRSLPvu0TNFps38=
X-Received: by 2002:a05:6830:1e76:: with SMTP id
 m22mr3445202otr.295.1582896483566; 
 Fri, 28 Feb 2020 05:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
 <20200228071914.11746-5-vsementsov@virtuozzo.com>
In-Reply-To: <20200228071914.11746-5-vsementsov@virtuozzo.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 28 Feb 2020 14:27:52 +0100
Message-ID: <CAL1e-=i1yUe7QKZLOfnH0Rk6H9R025ZxbGzS_3+D8Mza4b39Eg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] MAINTAINERS: add simplebench
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 "open list:bochs" <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 28, 2020 at 8:19 AM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..16d069adc5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2038,6 +2038,11 @@ F: python/qemu/*py
>  F: scripts/*.py
>  F: tests/*.py
>
> +Benchmark util
> +M: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> +S: Maintained
> +F: scripts/simplebench/
> +
>  QAPI
>  M: Markus Armbruster <armbru@redhat.com>
>  M: Michael Roth <mdroth@linux.vnet.ibm.com>
> --
> 2.21.0
>
>

