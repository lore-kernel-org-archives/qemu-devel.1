Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB79C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953892083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 09:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953892083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57537 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYp8v-0004fD-OP
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 05:57:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYp81-00045X-1N
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYp7z-00050V-P7
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 05:56:12 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYp7t-0003wT-2S; Thu, 06 Jun 2019 05:56:07 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1Mn2Fb-1gsa5P26lz-00k77Y; Thu, 06 Jun 2019 11:55:20 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20190528164020.32250-1-philmd@redhat.com>
	<20190528164020.32250-11-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <be04bd5f-5f7f-5f92-568d-ef0004b851f3@vivier.eu>
Date: Thu, 6 Jun 2019 11:55:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528164020.32250-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hkdlBuRzfNqot/E2JQ0Th2203OYjHukkX1dMwkosNUkVNxUjAAj
	HcM7zgw/DKvQzgX7D8CqIxCK2OdZMbzmtSu1fXIBsUcBta8bEMN3421FfsvdiEhsOFoSDd3
	3lAgIuXUri28wyCIE2DSap0AlEbR2ymjAbz8Hvh2yCTuh+3S0nSxPi1ZhT+631foOI6vMNl
	3xLpl3ZAqwLpBfonSXElg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xmZzg3i0GO8=:CQziJmmzeVMVVOwrn7MpFE
	4QlxxGMcqmdfhmCoe3cfCaOm99UzBLVIJepTQOkekaThJ7EJH3nAqBkE2B4Seoyv3B+NaVRPr
	OEItNRrep5cFJkVWqElN5MdXkA+DZ59UnbhoRFdo4da3ks0jt8TgbTJf1U2WdntCevjsnvs2T
	xU5FfMjW14UkC9nmSEzMaWALvXHs1A1idukcQtomvB92Wi5RYN/E1hZHmhMR3eoZ1We0ONFTF
	GKlLCcb/s8Npu+ZaSM4fD3sIBbEWne/aSMYZ/hirwmWgewJHozdjr9OQpa6wEakhXtoZ0WgVl
	jW1CJb9UPNjDe5fWL+Y8r3V4rc2zqpwRsJcD2uy3HfZsKIwSXWv4bfKgFzQzI0PEqOPepJZjZ
	D4zC+LxiOeZJPlSnYmNakIXFe4shcPGWm0VgfdCw23mdJzVLifH7eCyMxhawWxKy/lNZQVbSd
	bOQ4X4JLmCFBUYspeSxYIJwFK7zoQbzSNhQxWerGvCWZeRl1VYg4bjeB8FyoUQPml8n49YRe2
	p6/dQ9BwwAOJ4NOX37EHvKViYeCpY2empm/2BmpfJFPvLsSVbBzNCz1SN5GSaARi5Hm08zYQr
	94cn0jH+4UTleKpwxzIRQftMdrQKSx84As+dO7v2BoDXkv3WkybCREzZKgj71mcaDFd32Hibd
	v2hX5Fd02qa/1n/ng6Z5t6fqfdNIF5rE/DjpL5YX+69UDAQ5R1Z46unuIXTjYuZsZ/WuYnHL5
	59+NvDraYsre6hguc04pKSVTnxKZVEETEpvs/bmoH+cn2MmhHohu4lg9Nuc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 10/10]
 hw/watchdog/wdt_i6300esb: Use DEVICE() macro to access DeviceState.qdev
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	David Hildenbrand <david@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/05/2019 à 18:40, Philippe Mathieu-Daudé a écrit :
> Rather than looking inside the definition of a DeviceState with
> "s->qdev", use the QOM prefered style: "DEVICE(s)".
> 
> This patch was generated using the following Coccinelle script:
> 
>     // Use DEVICE() macros to access DeviceState.qdev
>     @use_device_macro_to_access_qdev@
>     expression obj;
>     identifier dev;
>     @@
>     -&obj->dev.qdev
>     +DEVICE(obj)
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/watchdog/wdt_i6300esb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
> index 1c6eddf86a..f2d1e86526 100644
> --- a/hw/watchdog/wdt_i6300esb.c
> +++ b/hw/watchdog/wdt_i6300esb.c
> @@ -200,7 +200,7 @@ static void i6300esb_timer_expired(void *vp)
>          if (d->reboot_enabled) {
>              d->previous_reboot_flag = 1;
>              watchdog_perform_action(); /* This reboots, exits, etc */
> -            i6300esb_reset(&d->dev.qdev);
> +            i6300esb_reset(DEVICE(d));
>          }
>  
>          /* In "free running mode" we start stage 1 again. */
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

