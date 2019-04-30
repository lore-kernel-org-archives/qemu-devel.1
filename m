Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF134C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC912080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC912080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZdw-0001nm-Re
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:46:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZVb-0002L4-Ty
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZDD-0002N3-Fw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:18:48 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hLZDB-0002LR-KF; Tue, 30 Apr 2019 16:18:46 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1Md6V3-1gn3bJ21dT-00aBGy; Tue, 30 Apr 2019 22:18:22 +0200
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"berrange@redhat.com" <berrange@redhat.com>
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <5f9283d7-aafd-1d6f-307d-c55c755709c1@vivier.eu>
Date: Tue, 30 Apr 2019 22:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Wv76BoprKAjBuCiD8FohGQkx9mKRM29gh82jIgu25jxwsOrgvLk
	PyXN4Pook6+jEn10qIuLgb49y7c1ucTNHwY4NRYLpMG9CvesY3MFgxS++aCTu0PWrzIItLe
	v6bJE1ZDFgM/LWgFQu52ZERaceyswM7RPO8VNwGdbegtv+qKj4bh3WW5sUVd6QGgs39vwQ2
	c0Gptg/W2/WhUwT6qI89Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h+m0XnVVn8k=:0xJ8QNk1Z4mt5uLuC4EPEE
	639p4vAW1oHGDoUVtJxYzP+kTAeBjay0Lj1kFi8yZxMFCTfiBy9KLw+a1UI+/vB9oh2wjEGLf
	P9yvmUqiKIncXCQoXKjafUojkweVMVHTubrmY3Irhu/4ewCvUkpGyPqG8Ei2CEwf2+r+plLtr
	yDIyLhrDRxHQxgBPN8zPMoQFD9SYsPLvXhyUGHWBp8soRb2amwARzAKYfqKYmUR2E3ROo2v/i
	bO8p0yFxpNKYy6+riuMZ7orKro7KorczQR0PhjJzMdpf5Y8c4DhYq79cwNKDj05OBYtmR2ZNi
	88lDcE2OsKWyxXXPgP1ZjkJbjXM2Zoo9RA1+/yr8pAHDsoZw7K1MvJTzfOZEuPlORqdtUfcyX
	tCRtU/GwJGfaig0+wP1qdjd3fMTfijC8Gy4+0CKFL/B72JHZb79D4LyA3Drz1BL3/dreIROJf
	nXrm+0XcW8IDskulqjfxfEqtVSTLYrBU9Z2dBDOOvLEJr4YSVZmGWrMIBP+XIdMpBPKPl7rpL
	t+6zz04EHohWdGBJIESoo5XYkvgGOenfZLgNtZdmH8SPeVyavCcJ4cNKwZ9llLr/NDrMECb1r
	xeHhoPfrAgy9t9qlN9I373Rx2oaBLsrV5AARL+JzOc94nNUt+cKm9eeciI2MkNEDwhlAp7RV7
	EoIT/lSZAbfygIeTTJ5PgSznGZNj48MmCyEEzY/mI0GqV4ELqtOmOY3Bpp3ObSB7S2KT34Tqt
	LoqLqlTo7mE8ea5COdtjmgBpSh2y7kjKAFgOKLZRckuHOdLORNwJTIDOPWk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430201818.76FxHE-JlzRzTF3gedRRkNKptToKRlmL5g9YY8ubj_8@z>

Le 30/04/2019 à 22:08, Alistair Francis a écrit :
> Fix this warning when building with GCC9 on Fedora 30:
> In function ‘strncpy’,
>     inlined from ‘unix_connect_saddr.isra.0’ at util/qemu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Werror=stringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘strncpy’,
>     inlined from ‘unix_listen_saddr.isra.0’ at util/qemu-sockets.c:880:5:
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  util/qemu-sockets.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 9705051690..4322652428 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -877,7 +877,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>  
>      memset(&un, 0, sizeof(un));
>      un.sun_family = AF_UNIX;
> -    strncpy(un.sun_path, path, sizeof(un.sun_path));
> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
>  
>      if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
>          error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
> @@ -922,7 +922,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
>  
>      memset(&un, 0, sizeof(un));
>      un.sun_family = AF_UNIX;
> -    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
> +    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path) - 1);
>  
>      /* connect to peer */
>      do {
> 

Your change reverts partially:

commit ad9579aaa16d5b385922d49edac2c96c79bcfb62
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Thu May 25 16:53:00 2017 +0100

    sockets: improve error reporting if UNIX socket path is too long

    The 'struct sockaddr_un' only allows 108 bytes for the socket
    path.

    If the user supplies a path, QEMU uses snprintf() to silently
    truncate it when too long. This is undesirable because the user
    will then be unable to connect to the path they asked for.

    If the user doesn't supply a path, QEMU builds one based on
    TMPDIR, but if that leads to an overlong path, it mistakenly
    uses error_setg_errno() with a stale errno value, because
    snprintf() does not set errno on truncation.

    In solving this the code needed some refactoring to ensure we
    don't pass 'un.sun_path' directly to any APIs which expect
    NUL-terminated strings, because the path is not required to
    be terminated.

    Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
    Message-Id: <20170525155300.22743-1-berrange@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,
Laurent

