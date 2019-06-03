Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD279C282DC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 00:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8058027A36
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 00:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8058027A36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXaz5-0002DL-Eu
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 20:37:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXayL-0001uh-Rr
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 20:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXayG-0006l5-UT
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 20:37:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXayG-0006kc-M3
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 20:37:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id u12so7546576qth.3
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 17:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=0yed2AQS18QOHZdJ3hTVrkDqC87a+ZkZjQ2/jltda4E=;
	b=FesfNEak2zFnbYBQkDVmAJlfQE/hT8vt3WwlxCNC7o9Wm1KEQBhzhfRa+L2sESPs50
	uduzj/QS5H1BHogQ/zobBrukGMUtOZLSJW84xsBL9SL9UWIluneMng64kX8AcrbIHha3
	LJCU3LhrC7NNBOm/oTVtWLTuIY5CNFBQbN+bfRy88iC5cYZqy19uXrQW3AmVqL10qmr0
	ytTyl1Ygt0YaNbwu/TK+w1sz98neFFIsIXC+2WCgZZ7jx1O1NyN29w9OYldwMXUJA5t4
	jQdkkVbK8b9tuUkTLQDizaajlICPlB8xehy3/zV8Kd9t8PDmjVfhZuMM7P7+DzKXGKgG
	ZnxA==
X-Gm-Message-State: APjAAAXTkX0ZGH6hZ+mQ++TNLkkzW/jU8nSdAiRfS9omvSutqAOz5zs8
	zmQS8qUXEYbwaIKOPBABurjB/w==
X-Google-Smtp-Source: APXvYqwmnWPnxBr/CYGvWOKwUHEHdaWTOAGLqidF5JE7wS4qrn21remGZ91uyamuNB6Ii20r582ttg==
X-Received: by 2002:a0c:f7cf:: with SMTP id f15mr6452176qvo.243.1559522222560; 
	Sun, 02 Jun 2019 17:37:02 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id c4sm6737958qtm.29.2019.06.02.17.37.00
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 02 Jun 2019 17:37:01 -0700 (PDT)
Date: Sun, 2 Jun 2019 20:36:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <20190602174041-mutt-send-email-mst@kernel.org>
References: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [PATCH] ioapic: kvm: Skip route updates for masked
 pins
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 02, 2019 at 01:42:13PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Masked entries will not generate interrupt messages, thus do no need to
> be routed by KVM. This is a cosmetic cleanup, just avoiding warnings of
> the kind
> 
> qemu-system-x86_64: vtd_irte_get: detected non-present IRTE (index=0, high=0xff00, low=0x100)
> 
> if the masked entry happens to reference a non-present IRTE.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/intc/ioapic.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 7074489fdf..2fb288a22d 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -197,9 +197,11 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
>              MSIMessage msg;
>              struct ioapic_entry_info info;
>              ioapic_entry_parse(s->ioredtbl[i], &info);
> -            msg.address = info.addr;
> -            msg.data = info.data;
> -            kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
> +            if (!info.masked) {
> +                msg.address = info.addr;
> +                msg.data = info.data;
> +                kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
> +            }
>          }
>          kvm_irqchip_commit_routes(kvm_state);
>      }
> -- 
> 2.16.4

