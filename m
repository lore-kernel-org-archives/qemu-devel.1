Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF5FC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9794207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGDbhW09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9794207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2CZ-0004lg-2Q
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jX2B5-0003Rx-Mq
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:32:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jX2B0-0006ce-SM
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:32:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id u16so10364894wmc.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EQqs3Tj1cjkbzb8Iwh/7A9sRwxR4Q3CLO8bZhPaGVoc=;
 b=nGDbhW09d/H8+KRCMcYbdBIM8Kwdn1yYc3uOHwkFxRsckB/yTWBWV9W9tITubz+ZUM
 UuDhZSeUorZQmi2Q6ebWheMRoc0ymbKxoxr92ncIEL7HC6vJgfIM8eTkB/QUTyJutlKZ
 o0e3H6WJ5vK+tNF7OMC8de9lkrblS9xyyq5+I1SCpxaItM9O4Ue3Ec0i5Hae5sv0YxN7
 K4IFz6mzcLIdlJvzOXMN6p+byVkYRY9rlLJZzDtr6ZWuHmk/b/BvJ2L0A+IJA5pVQWB3
 stpdmjka2XHgD4DMQX7/V72IuOd31INjr07PiCtdKbrOdE4aSNa6Dy1KqLjnSKRoLGKv
 qODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EQqs3Tj1cjkbzb8Iwh/7A9sRwxR4Q3CLO8bZhPaGVoc=;
 b=mn4+dmtWpcvymX6zmXsqtvskcdBVte9F8le0izel335MQmuVDag/Ui7O3QjjiHw5m4
 fKtXkTPzgE20z6ozJ/yWIXUiV/NRhG65wSSQN/Nd0f5No61hvwAeQJW7BPefT11XhMkn
 EXQa4NizAHpnJlrXzaLiRRl2cSKER4bfN4m0o+22yrUa0dyefe7uY5CP9JsovD0qgpGp
 4BSH1DDHoaW8FedT6f1NzKB0GfiAFPSvqYgFYUjPje0p+NVj3vhzC5pXF8Zq1J3/Lz5w
 XkGUm8OzdXjRu9hwBfTeT6ZmxTUDkfDX/O2KFi3eGqX8Hc4SNeCari7bLrNvgzZiWsFB
 wr6w==
X-Gm-Message-State: AGi0PuaXM9/cRvXnJgiXFWGQQTw3uBpo3JbuAYT69bOTB+PJVjDgSK1y
 QT6ZZmPn4PwrvkVkuirvy2/+671LYKnA1HWFz/g=
X-Google-Smtp-Source: APiQypIWXAVBu5I4PecCHGcpDwYcyI6del74Oj2iv7En+Abv+iGY3RBTB9CF19OULOlTAnD6U0BrlKYG+enh/U+12fM=
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr16980227wma.26.1588941144937; 
 Fri, 08 May 2020 05:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200428085122.1621-1-fengli@smartx.com>
 <20200508051441.8143-1-fengli@smartx.com>
 <20200508051441.8143-2-fengli@smartx.com>
In-Reply-To: <20200508051441.8143-2-fengli@smartx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 8 May 2020 14:32:12 +0200
Message-ID: <CAJ+F1CK6S-M4ykYp0DapZ9q0nAD046Uim-F7cxUTYqYC5anBTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] io/channel: fix crash when qio_channel_readv_all
 return 0
To: Li Feng <fengli@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Li Feng <lifeng1519@gmail.com>, Dima Stepanov <dimastep@yandex-team.ru>,
 Kyle Zhang <kyle@smartx.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, May 8, 2020 at 7:14 AM Li Feng <fengli@smartx.com> wrote:
>
> Root cause:
> From `man recvmsg`, the RETURN VALUE says:
> These  calls return the number of bytes received, or -1 if an error occur=
red.
> In the event of an error, errno is set to indicate the error.
> The return value will be 0 when the peer has performed an orderly shutdow=
n.
>
> When an error happens, the socket will be closed, and recvmsg return 0,
> then error_setg will trigger a crash.
>
> This unit test could reproduce this issue:
> tests/test-char -p /char/socket/client/reconnect-error/unix

Current master doesn't trigger the backtrace, it's only after your patch 2.

>
> The core file backtrace is :
>
> (gdb) bt
>     #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
>     #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
>     #2  0x00005555555aaa94 in error_handle_fatal (errp=3D<optimized out>,=
 err=3D0x7fffec0012d0) at util/error.c:40
>     #3  0x00005555555aab6d in error_setv (errp=3D0x555555802a08 <error_ab=
ort>, src=3D0x5555555c4280 "io/channel.c", line=3D148,
>         func=3D0x5555555c4580 <__func__.17489> "qio_channel_readv_all", e=
rr_class=3DERROR_CLASS_GENERIC_ERROR,
>         fmt=3D<optimized out>, ap=3D0x7ffff423bae0, suffix=3D0x0) at util=
/error.c:73
>     #4  0x00005555555aacf0 in error_setg_internal (errp=3Derrp@entry=3D0x=
555555802a08 <error_abort>,
>         src=3Dsrc@entry=3D0x5555555c4280 "io/channel.c", line=3Dline@entr=
y=3D148,
>         func=3Dfunc@entry=3D0x5555555c4580 <__func__.17489> "qio_channel_=
readv_all",
>         fmt=3Dfmt@entry=3D0x5555555c43a0 "Unexpected end-of-file before a=
ll bytes were read") at util/error.c:97
>     #5  0x000055555556c25c in qio_channel_readv_all (ioc=3D<optimized out=
>, iov=3D<optimized out>, niov=3D<optimized out>,
>         errp=3D0x555555802a08 <error_abort>) at io/channel.c:147
>     #6  0x000055555556c29a in qio_channel_read_all (ioc=3D<optimized out>=
, buf=3D<optimized out>, buflen=3D<optimized out>,
>         errp=3D<optimized out>) at io/channel.c:247
>     #7  0x000055555556ad22 in char_socket_ping_pong (ioc=3D0x7fffec0008c0=
) at tests/test-char.c:732
>     #8  0x000055555556ae12 in char_socket_client_server_thread (data=3Dda=
ta@entry=3D0x55555582e350) at tests/test-char.c:891
>     #9  0x00005555555a95b6 in qemu_thread_start (args=3D<optimized out>) =
at util/qemu-thread-posix.c:519
>     #10 0x00007ffff5e61e25 in start_thread () from /lib64/libpthread.so.0
>     #11 0x00007ffff5b8bbad in clone () from /lib64/libc.so.6
>
> Signed-off-by: Li Feng <fengli@smartx.com>
> ---
>  io/channel.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/io/channel.c b/io/channel.c
> index e4376eb0bc..1a4a505f01 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -144,8 +144,6 @@ int qio_channel_readv_all(QIOChannel *ioc,
>
>      if (ret =3D=3D 0) {
>          ret =3D -1;
> -        error_setg(errp,
> -                   "Unexpected end-of-file before all bytes were read");

Nack, this code is fine.

The problem is that the test case doesn't expect a disconnect in
char_socket_ping_pong().

--=20
Marc-Andr=C3=A9 Lureau

