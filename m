Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD4C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B55620663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp1olLUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B55620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGL8N-0002YG-Pr
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jGL7Y-0001ug-6A
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jGL7X-0001oZ-2k
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:19:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jGL7W-0001o4-Sg
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:19:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id a81so8576015wmf.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EuieIyc6tTCmsECeaubnyZnEEhvgWS00+SrOLT8Gg1A=;
 b=bp1olLUbjPPN/trbMavs5zN/8N+WZkLnW/IWMM67jys981TCnzlbw3T0Le+P844WmB
 9c42Vyhp5DLM7O5OsQYqu+MxjCtDf0hUuFC4ojT5TELqNuLlGc3yvMaz3l/1MHni3Dr5
 aTgArwAG65OI5FwbdLFPETIIByq/hoNAH4Xh0Dxkc3ioAPzE6VypQqrn38BKsUfUxT+o
 lRDv5hsk8T1w9tNLvB9W/HY1Rid2aMnHwb/KNsRCLF/okqDCs9CNkxkpHHJX36XQlsy7
 6uLluHLCMB/Wj4pW3Cl9QYveEWD0L2JrlPuYlUucoTLi6Aa1QP4ZKHGe/aNV+hm9P6J0
 ZaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EuieIyc6tTCmsECeaubnyZnEEhvgWS00+SrOLT8Gg1A=;
 b=GdNGnmilvGIjWEK9/7t27oLhaJTfCV4D2ymi4n/PTVB0sfX2EmJ5CMIDWnK6IHCFii
 Xp8Ru/MjCfZsOYWRvKiVXPNaUAi/wMno8sCImix5t+uSpj+smAnz49xd6ZRLE8SSeTPn
 tC+VgHhrQiK7PoW4eaZOORkgNjQKMsmyUwG2EyZreGptTd/tG+2zISHGjfhFTeKYhWL6
 8o5UdGN+1ZbFpywB+oKzINMj/byZn0tEOGelFOULsuHifnuhqKZEtPJ6Gz7gAvAP76sF
 n7PYouEcpNo5mD9HtbfngAqsF5FMkm4PCQEzSOMWJYtnqAQ3MdbYvncB1uoZnSBrIN+Q
 RlCQ==
X-Gm-Message-State: ANhLgQ2GklFYsXoMsoKFfxyXdSgro/ZiHUp2GsyUB12jethKzkvmbgaa
 mOLp01nQGX93K31f2Ddzprvl9uuDup/mxJ7VfMM=
X-Google-Smtp-Source: ADFU+vsoJiDQK1Sf1kWrCMh2ZgxNwoXXhZEHkKXuH+SDYRmq3WoYAhOaqc97yyFazw81FVeYf+UYQJR0dwyd/T3Diu4=
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr1511253wmc.55.1584962389383; 
 Mon, 23 Mar 2020 04:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200323110408.309111-1-stefanha@redhat.com>
In-Reply-To: <20200323110408.309111-1-stefanha@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 23 Mar 2020 12:19:37 +0100
Message-ID: <CAJ+F1C+hUXUQiCsj6Gu6E_kWbu5y6d+NxXq4Ztt8GytjHC-gCw@mail.gmail.com>
Subject: Re: [PATCH] qemu-ga: document vsock-listen in the man page
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Mar 23, 2020 at 12:04 PM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>
> Although qemu-ga has supported vsock since 2016 it was not documented on
> the man page.
>
> Also add the socket address representation to the qga --help output.
>
> Fixes: 586ef5dee77180fc32e33bc08051600030630239
>        ("qga: add vsock-listen method")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  docs/interop/qemu-ga.rst | 5 +++--
>  qga/main.c               | 4 +++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index 1313a4ae1c..3063357bb5 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -36,13 +36,14 @@ Options
>  .. option:: -m, --method=3DMETHOD
>
>    Transport method: one of ``unix-listen``, ``virtio-serial``, or
> -  ``isa-serial`` (``virtio-serial`` is the default).
> +  ``isa-serial``, or ``vsock-listen`` (``virtio-serial`` is the default)=
.
>
>  .. option:: -p, --path=3DPATH
>
>    Device/socket path (the default for virtio-serial is
>    ``/dev/virtio-ports/org.qemu.guest_agent.0``,
> -  the default for isa-serial is ``/dev/ttyS0``)
> +  the default for isa-serial is ``/dev/ttyS0``). Socket addresses for
> +  vsock-listen are written as ``<cid>:<port>``.
>
>  .. option:: -l, --logfile=3DPATH
>
> diff --git a/qga/main.c b/qga/main.c
> index 8ee2736f8e..f0e454f28d 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -234,7 +234,9 @@ QEMU_COPYRIGHT "\n"
>  "  -p, --path        device/socket path (the default for virtio-serial i=
s:\n"
>  "                    %s,\n"
>  "                    the default for isa-serial is:\n"
> -"                    %s)\n"
> +"                    %s).\n"
> +"                    Socket addresses for vsock-listen are written as\n"
> +"                    <cid>:<port>.\n"
>  "  -l, --logfile     set logfile path, logs to stderr by default\n"
>  "  -f, --pidfile     specify pidfile (default is %s)\n"
>  #ifdef CONFIG_FSFREEZE
> --
> 2.24.1
>


--=20
Marc-Andr=C3=A9 Lureau

