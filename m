Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C19C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 07:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAD3205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 07:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAD3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMSHC-0000lx-Lw
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 03:06:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMSFg-000843-7y
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMSFf-0008GY-4t
	for qemu-devel@nongnu.org; Fri, 03 May 2019 03:05:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMSFZ-0008Cq-Gl; Fri, 03 May 2019 03:04:54 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N4hBx-1geV4o1ggR-011f2F; Fri, 03 May 2019 09:04:33 +0200
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190503004021.13814-1-alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4252bb07-1d22-ed2f-61af-67fd164e0656@vivier.eu>
Date: Fri, 3 May 2019 09:04:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190503004021.13814-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ljJC1pCFcAUv7aUonHTrxNtmHCEciugDIZLwW7gNkEtRTJtZkE+
	nQTIH9Mhf/A0Zlunu/vweFIuO+ovBLPJpAxTjAx261f6D/WPpE9k546q0ggqZhG0A9K7Mgn
	5rqlpp7APFqq5V/+oeiKduVuEYh0q13pxYhukC+oh/PEYEiGEBFD3KD1PB8gKiHPtw+6R6h
	ePvQJ3Aq16H2a1OVe7vtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e6t1Vf0dl9s=:WXActOQEmxifxAuID+IpRM
	kzve7hKldfCdezviDHkgOQWw554olQw1FS0XiIaAtL1zpc+IXnVPaQ8pL3BHDp0Z11ZxxSIRW
	igI4pAjVVOMvXNTz4C+jZ7bt8Oa4UG22SFKi02lUhT1QZ2dfG3BmF2rPOzAPL/HnFSW8CfeBM
	tO3Q7tBI+T199I2xBeWUjSMvD+LQZrUkNFAptEDK3e9ZDiw0ACb6uafyhqQ0xVz/EORA7syUG
	UFzGoMHOt93XOHfppEMzjTiVabcETmsI+LQYmK2Tldbca8y08euHbUT/kob+RSj6TDbBzUj3a
	hYMdQtQhKeLuxA6rxRMbKsGeKXaEnUefbh1act/CDH6r3nBb8Et116/JQvEuPFCkE06CyGdK0
	hDOUn9NhmD8HX9rpYcE+JS07442LumWNQwiUcz8m0v0i1ljVXkvCqp/mNsBba2BWxP4BUeXop
	8Kw17FmZkqV0oIROgSTqO/YPO7yS3ysC3pTHUCkLdZ+Tlf757O8B7BfFalSvfNAekPf6AUuVM
	snps3xlL3z96cTl1DZCfofw9p8nkCFyMfL95bn4/MJnnc0ZjvG9o/I8SddYlvIkMu427WXBEY
	6aAvhpME+YSo1UQWyG/8fFfE1QblarCFqNxcTI+Wjzvm6zZb7GWD7LKFNcr8PNXEwbeB6IpR1
	Sx5K6CXTHEmmzO5Ibhmkv3aAWvDUdBwC4mtpCpNgXUHOrm4Ns8gmZzbtV7BkE+mU5gUY5XvaC
	s/DSKDlCLecILpRg6xZ2+7imQki2JPDk9tF4XCVPMQ8e+LSWmYyzxJn7U0s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH v3] hw/usb/hcd-xhci: Fix GCC 9 build warning
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
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503070431.XEd7FcigQENSUo-Q2uaZ97_5BYrT0dZzm71sbGBusHQ@z>

On 03/05/2019 02:42, Alistair Francis wrote:
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
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> This is the onl patch left if my original series "Fix some GCC 9 build
> warnings" that hasn't either been accepeted into a maintainers tree or
> fixed by someone else.
> 
>  hw/usb/hcd-xhci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index ec28bee319..a15b103b65 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -3321,6 +3321,8 @@ static void usb_xhci_init(XHCIState *xhci)
>  
>      usb_bus_new(&xhci->bus, sizeof(xhci->bus), &xhci_bus_ops, dev);
>  
> +    g_assert(usbports <= MAX(MAXPORTS_2, MAXPORTS_3));
> +
>      for (i = 0; i < usbports; i++) {
>          speedmask = 0;
>          if (i < xhci->numports_2) {
> 
Reviewed-by: Laurent Vivier <laurent@vivier.eu>


