Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B501C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B72207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B72207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedRL-0007RK-05
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jedQf-00070E-RI
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:44:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:28726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jedQc-0001s4-C0
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:44:00 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 96EE274633E;
 Fri, 29 May 2020 13:43:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7810F746331; Fri, 29 May 2020 13:43:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 76640746333;
 Fri, 29 May 2020 13:43:54 +0200 (CEST)
Date: Fri, 29 May 2020 13:43:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] usb-host: workaround libusb bug
In-Reply-To: <20200529072225.3195-1-kraxel@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2005291343110.15014@zero.eik.bme.hu>
References: <20200529072225.3195-1-kraxel@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 07:43:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020, Gerd Hoffmann wrote:
> libusb seems to no allways call the completion callback for requests

Typo: not always call.

Regards,
BALATON Zoltan

> canceled (which it is supposed to do according to the docs).  So add
> a limit to avoid qemu waiting forever.
>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> hw/usb/host-libusb.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index e28441379d99..094010d5f849 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -951,6 +951,7 @@ fail:
> static void usb_host_abort_xfers(USBHostDevice *s)
> {
>     USBHostRequest *r, *rtmp;
> +    int limit = 100;
>
>     QTAILQ_FOREACH_SAFE(r, &s->requests, next, rtmp) {
>         usb_host_req_abort(r);
> @@ -961,6 +962,19 @@ static void usb_host_abort_xfers(USBHostDevice *s)
>         memset(&tv, 0, sizeof(tv));
>         tv.tv_usec = 2500;
>         libusb_handle_events_timeout(ctx, &tv);
> +        if (--limit == 0) {
> +            /*
> +             * Don't wait forever for libusb calling the complete
> +             * callback (which will unlink and free the request).
> +             *
> +             * Leaking memory here, to make sure libusb will not
> +             * access memory which we have released already.
> +             */
> +            QTAILQ_FOREACH_SAFE(r, &s->requests, next, rtmp) {
> +                QTAILQ_REMOVE(&s->requests, r, next);
> +            }
> +            return;
> +        }
>     }
> }
>
>

