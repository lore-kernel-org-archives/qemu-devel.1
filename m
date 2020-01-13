Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E013C33CA8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4980020678
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 08:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAwoyYFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4980020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47321 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqvXo-0004kZ-EK
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 03:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pdurrant@gmail.com>) id 1iqvXB-0004GW-1L
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 03:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pdurrant@gmail.com>) id 1iqvX9-0005c4-Ul
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 03:57:16 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pdurrant@gmail.com>)
 id 1iqvX9-0005aV-NT; Mon, 13 Jan 2020 03:57:15 -0500
Received: by mail-pg1-x543.google.com with SMTP id 6so4401560pgk.0;
 Mon, 13 Jan 2020 00:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IEIZnTuW8clF6RD08mgp42pBTUtM58PRkfUOgRWL1zo=;
 b=MAwoyYFkYHarEBVWbgItJtmHobiSNg2kU3HDC8JaQkwa72f7q5OTKh3xuBfGFjXaOY
 gljLSbgWqSUAWoeeusiBcp3OKcZKo/DztS4IAXmW/RCCl4zjvymU9quzuXQHadS6rehm
 pnkysXv6jzdj3qlv1N4cJE2VTUusHarSUFp6bdlbg7DB+vuj37AM9bBG5JliI0yh0t3L
 aFxj9qTMAR6UTfKESWpXF4p+ErMpXNg6uDDAp0d4o9wYHfPrqzuwxez3rXDd62FOyuVp
 XBU51pvBiNXgYtV7Lksh28ibaiXGQNC6pLAVP9kJGdQhLQmwXBwhCiQ6SNZZNWsNMXDG
 bp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IEIZnTuW8clF6RD08mgp42pBTUtM58PRkfUOgRWL1zo=;
 b=qmotIPmov4CPyjLOPqefusNcdxDO/44mBA8wspOcBw3/Lnd/Nnw8UoVFemsBCJjexq
 yLoIW5yXSZBBZFhTRgnz+b1aDJHgK06NlFqUC7sqsa3/RDo5L0aKBtu4WU6IDL0mxaU+
 ewW5hjsgfwBeUVTIcjAzw07ZORrTUqXWpwKMNWQKhib3aUPoDbCeUiGJYVAuipg8regV
 zvzHcLYI1a5rdSmlejTrQnMthcmChXCaM3/o4d9BCoPCQnZEolVwO7zo1roKxP9pIpQZ
 L4ZC5nPfbPrTtyG32IQnzFBHL/iqelCLF+pDMEVbE4DgyjNpZ0QU+NvBaqsbzvXnaDbR
 B37Q==
X-Gm-Message-State: APjAAAXTR/Dh4J+iiitnvUplDW33OlZCy/BPVyovezPSYIzwf2k8hcgF
 JeBpSGHd7bU2HqOpWThZeC3/GxbENCCzkR0RTjA=
X-Google-Smtp-Source: APXvYqycorsm/yA2OqspdZCTdPrvz2wmqVS8037juslfs38oUSoLXQdSzBJX38dVrQY8BTs7z62X6zDN4wnntI85UDA=
X-Received: by 2002:a63:220b:: with SMTP id i11mr19393702pgi.50.1578905834622; 
 Mon, 13 Jan 2020 00:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20200110194158.14190-1-vsementsov@virtuozzo.com>
 <20200110194158.14190-12-vsementsov@virtuozzo.com>
In-Reply-To: <20200110194158.14190-12-vsementsov@virtuozzo.com>
From: Paul Durrant <pdurrant@gmail.com>
Date: Mon, 13 Jan 2020 08:57:03 +0000
Message-ID: <CACCGGhA78D7TVQdj-wrr=hWmFN+kefS_7zLm4UHBkx0ZHh8maA@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] xen: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 at 19:42, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &error_fatal
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>
> If we want to check error after errp-function call, we need to
> introduce local_err and then propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>    &error_fatal, this means that we don't break error_abort
>    (we'll abort on error_set, not on error_propagate)
>
> This commit is generated by command
>
>     sed -n '/^X86 Xen CPUs$/,/^$/{s/^F: //p}' MAINTAINERS | \
>     xargs git ls-files | grep '\.[hc]$' | \
>     xargs spatch \
>         --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>         --macro-file scripts/cocci-macro-file.h \
>         --in-place --no-show-diff --max-width 80
>
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Acked-by: Paul Durrant <paul@xen.org>

