Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC381C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A048B2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A048B2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53079 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZax-00079G-RC
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:43:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZVX-0002Jh-8i
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZJL-00054g-Kk
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:25:08 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hLZJL-00054K-Bs; Tue, 30 Apr 2019 16:25:07 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MRTIx-1h9pDa3p6j-00NPR4; Tue, 30 Apr 2019 22:24:44 +0200
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<c4768a18309b3918715f96a1f5b2a9a264a5a9e4.1556650594.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <8ca522c7-d1dd-fe05-f8ab-031b72a9fbef@vivier.eu>
Date: Tue, 30 Apr 2019 22:24:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c4768a18309b3918715f96a1f5b2a9a264a5a9e4.1556650594.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bY2AYjdAB92M61PW3TyxhnpHkcZkblKdkskm0OiVC2dBO/4zb3Y
	hJSkLtmO1Y2NalEjWBRONlHmgZQVQbjT8+uC5EJXEq2503QebZ4q+0z5DKAPpLVo/dCLM/O
	Ol+tzJpamtCFSIvumLwIocbJ2GX/B2YrYLokJ57f5a5BEfWAnZyUKlfvZgQZ1/EG+f400Nw
	+itYaG50RCZz+SMLt4SKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fcc+XOYtyn4=:eI43qPNGY9KhFYSOgd6I2P
	3vmNLGrzCvpTQ7XTpFSzfnb5yjOUPm/xZiT+XhR4hxIfqkAjTiqqoO7QOcuO1XDY5r9qDZGwr
	fXBegO+fI+GERcs6OnH48ZQ3o0bt+rG0Wgxf+Ke0BY5ShIJtUl2Kw39+nqlbi3v1T6w2q2jbS
	U5IaffHroiZwFLdgAlytJ+wW1wYvBlrjABzGfNx9QrctVmNKSa6BSsgj9fuefNnPwV1SoWQrB
	ehFyEqvkGnqQ4mnm8DuovJO5ADGd6xO0xzo4Ue942TlXGLEn2ABXyRUWnvtakKXG9D4D9Gx8e
	r7sxy5ZcK82K7M+KiV+Y0IZ+AiAT5y1r13AzKmYKunfUqhzqjRX0ZVNgRjXIOow9v9KqasHsv
	ZByfwMtdgm/y8XgkfgFma5s9Nj9tMpHwF8c29ct+eJBU79arEkRK1565Lh8pENNKlZc/kZ6C7
	z4/QFQy7GbsEnLnA3BZ+wKKKBVA8AF+TJXUzfGuigry/j6pRFp/opq8ZvDAvsmKno84rH7dhw
	zxfnA806EWCO3j2CHZ5VztUbxvbckc5SiayTkR6LqJDmQqPBknGK8dFbelGMBoprPE4vAKn+1
	m8KxMVW1YdMkuE96FK43xO4GZwn2+cygEIdgOM4ongGSfZMyAup9+W4sKs5OyDMMrztF7VI5E
	jd9yftTHwDbXVEWS2u6BKnMw28oi6PUvjSXYUq2V6hDHQJrsFyrFgS901b9OdyUGJqLOH/nnp
	9/iU3CnOgpZ0TL8w+1qSIWPC33okmf//LnJCVJcYcOgH1MACxFshefLk9r8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] [PATCH v1 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
 warning
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
Message-ID: <20190430202441.IlBGlbKyc3zBwnRQLdWInypg67IrpHtIXoclIqvoAzs@z>

Le 30/04/2019 à 22:09, Alistair Francis a écrit :
> Fix this build warning with GCC 9 on Fedora 30:
> hw/usb/hcd-xhci.c:3339:66: error: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 5 [-Werror=format-truncation=]
>  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+1);
>       |                                                                  ^~
> hw/usb/hcd-xhci.c:3339:54: note: directive argument in the range [1, 2147483647]
>  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+1);

"i" cannot be greater than 15.

perhaps an "assert(i <= MAX(MAXPORTS_2, MAXPORTS_3))" can fix the warning ?

Thanks,
Laurent

>       |                                                      ^~~~~~~~~~~~~~~
> In file included from /usr/include/stdio.h:867,
>                  from /home/alistair/qemu/include/qemu/osdep.h:99,
>                  from hw/usb/hcd-xhci.c:21:
> /usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 13 and 22 bytes into a destination of size 16
>    67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    68 |        __bos (__s), __fmt, __va_arg_pack ());
>       |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/usb/hcd-xhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index 240caa4e51..9e4988abb6 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -133,7 +133,7 @@ typedef struct XHCIPort {
>      uint32_t portnr;
>      USBPort  *uport;
>      uint32_t speedmask;
> -    char name[16];
> +    char name[24];
>      MemoryRegion mem;
>  } XHCIPort;
>  
> 


