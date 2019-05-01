Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C03C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 09:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC7D21670
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 09:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC7D21670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLliK-0003u3-07
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 05:39:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLlhD-0003OV-I0
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLlhA-0004U8-Gm
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:38:35 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hLlh1-0004RA-Ij; Wed, 01 May 2019 05:38:24 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MfZ9C-1goups3xuq-00g3Qi; Wed, 01 May 2019 11:38:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <74fcaa14-6e80-9d7b-bcd6-9c951a4f46de@vivier.eu>
Date: Wed, 1 May 2019 11:37:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IZxBcBlsJLYvrvTAxFKqPPRMO7uxy/VSPuOlbycQq7a6wwrHxGn
	B3RHNMHvygfRfCz+yhvw7KQvx1c8fZ9E4F2uUFJZk47ZO7czpdbfpnNrx+7PNvb+ouKuKbd
	ooVuPRzZLR5NYdvf3n3+czcaoXOXGmgZ9aBfH0JtWCcPIbAf8UMiHCRpaq/gpaVhXjsGjb2
	F7zW4hFDUfSmShaDfTW5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Iyne2eBd160=:NTz2q4pQKxnzGAZ6pk6wpn
	BfBWyZfU4RDG/9o/4yxYpxdnE+RZ9Qp5aVJTd9RbrZoHc4UXo6g94GiyiqKVhu3uT7iwqB/f5
	sh4jJqIfSISaymzHgE38WIzMLCwkoQJIoYGf9dSGLWpFTg9LWVh7w3e6nlVIRonYBFKgsDgZf
	kHAbLaK+VysN9JOe9aBBztQMuBJZGoKZVHGQLNGreJY3k2SXjgRu4QOjwNhMBYbScSytAHqt2
	9Ojzfjeljz3Gcaot5rMy12dR/uoKZytFbHOadsxCsgg4R8apmCJYFUY2s048PJ4tVYFRQQj0Q
	gBYKu7AD6nrnOpWHUUgxapW8CIdVYf5OUXUhzLPHuMisjWaqdYF5/VXQnWRQCwKMlINTmNqi6
	tKDLVqPQQvnYe7tC9EOkgLoyTvEsfKrFIRfLNroaUFfMOdz2Hr9oDfi9RTbO2+7vMm8u6iwY/
	SDygNrVtBq+qqProtxhjsdTDe4Uo8t7P64OwuLhCEJzYD8Pz7wHHjbgHjEcs0bdqmJ+iS67Ug
	9YVVmml3qk1Rqg7YjTWWPmSgSsne3vv8NiUkB5o2ef1VUs0m9T6qIQoXK7n1ujQ5Y/nFpy3Z5
	Amh5trEc3pYMfGsDME0LxpH5RqejToOgl9EXn33pL7RKV6Zub6uyozYJiIlgyph2RLZHgP2fS
	DmGLOMCP7Xhb7dKBOG8Vhiw5Rdi3Tck0T30VitQK4dFhtKQVAgjWFM2fnUTYrBjWNjAEtJGZT
	uKNpTMLps5DvOAt+WatJMJYRZr9NljDYPYXeXAUHeOvGFFRjetIZUHirtcM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
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
Message-ID: <20190501093758.Bd7OaltkX7RS3InuB4l8N2-yhnIaqUaZ6mrMMtZN3eI@z>

Le 01/05/2019 à 01:28, Alistair Francis a écrit :
> Fix this build warning with GCC 9 on Fedora 30:
> hw/usb/hcd-xhci.c:3339:66: error: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 5 [-Werror=format-truncation=]
>  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+1);
>       |                                                                  ^~
> hw/usb/hcd-xhci.c:3339:54: note: directive argument in the range [1, 2147483647]
>  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port #%d", i+1);
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
>  hw/usb/hcd-xhci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index ec28bee319..2b061772b2 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3322,6 +3322,7 @@ static void usb_xhci_init(XHCIState *xhci)
>      usb_bus_new(&xhci->bus, sizeof(xhci->bus), &xhci_bus_ops, dev);
>  
>      for (i = 0; i < usbports; i++) {
> +        g_assert(i < MAX(MAXPORTS_2, MAXPORTS_3));
>          speedmask = 0;
>          if (i < xhci->numports_2) {
>              if (xhci_get_flag(xhci, XHCI_FLAG_SS_FIRST)) {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



