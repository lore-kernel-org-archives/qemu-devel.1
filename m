Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D861EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F2F246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFBb4Hh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F2F246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7d1k-0003gf-TZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7d0v-0002Fa-Vn
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7d0u-00010f-SC
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:37:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7d0u-00010S-OS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582886220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPXnCKjG5yRGfukRRtYFa7a5EdQwWRhC2QlXB6jTSow=;
 b=LFBb4Hh5TiLiZKV2/SvySzFEDp6niyhGFoRt4aK9Lqq8y6C98LbPx+lRi9ZofNNCxlEsx9
 xQdzyEKYbZXCVFfXkqQe9J2eYeZ4pbYdNcV7m7MDaSjlfwsIz2k/E81rEYa8l8ucSEnWEX
 X2Sm0nESIRuO46X9QDJ37PaQLysqhTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-wnJeDJFRMZKi7-LhxgQA2Q-1; Fri, 28 Feb 2020 05:36:58 -0500
X-MC-Unique: wnJeDJFRMZKi7-LhxgQA2Q-1
Received: by mail-wm1-f69.google.com with SMTP id w3so539596wmg.4
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GPXnCKjG5yRGfukRRtYFa7a5EdQwWRhC2QlXB6jTSow=;
 b=DW7EW1DtAMoCeSPKk4/XWPjFhDW/sVoqI8WgyGoawDRlyt1veIDTevW5bIOoB5h+2w
 5e45OWxFHhAcvuXWHpRs7YNSpzGqAd1tSB/R+i6g/eErGsJ3Oe5QCbjrHUO4oF0H+yM8
 lphsYk+Uu/dApHCffQAiDHkdGf2WQYY8LLYwu0YrkR9PRIuLaTg3C4oX77VEOue44Yhx
 8bvm0L3JzL2LcQGTJaIDFFbDWCE4wLxduNO7lyJmxnyUMa54JwmIn79lbGyuu7KHuAeW
 P5UGx2rXGkTceTztJGYZevd0I5fXhDMmBAqmZbU/PHlbR/qTlg3RXy0hd9uobotvsZD1
 fD+A==
X-Gm-Message-State: APjAAAX7a+CasaIEJH6Pfy2VWvc252MfZNDYM9KZIKp9WVYa3VLwM94T
 E+OLR9e+FwJ3XKpYUXamiQwWhKIdhL9aQ3zU0YFeCDbmTuSSfaGFCQaRqnd59oaInTkRcQ3+pQO
 gA9vEQA2JgORc2B4=
X-Received: by 2002:adf:c54e:: with SMTP id s14mr4052857wrf.385.1582886217832; 
 Fri, 28 Feb 2020 02:36:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIXSfEABddIXqeoBMaZDoEDz0aU8DYZ1EXJET4epnQNZsOIgXagwfgmZjyXG1gIPo+BGaBcg==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr4052838wrf.385.1582886217594; 
 Fri, 28 Feb 2020 02:36:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id b14sm1241888wrn.75.2020.02.28.02.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 02:36:57 -0800 (PST)
Subject: Re: [PATCH 0/5] vfio/pci: Fix up breakage against split irqchip and
 INTx
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200226225048.216508-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf2fab93-d1bc-8a4c-3a26-f14f12bdc07d@redhat.com>
Date: Fri, 28 Feb 2020 11:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226225048.216508-1-peterx@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/02/20 23:50, Peter Xu wrote:
> VFIO INTx is not working with split irqchip.  On new kernels KVM_IRQFD
> will directly fail with resamplefd attached so QEMU will automatically
> fallback to the INTx slow path.  However on old kernels it's still
> broken.
> 
> Only until recently I noticed that this could also break PXE boot for
> assigned NICs [1].  My wild guess is that the PXE ROM will be mostly
> using INTx as well, which means we can't bypass that even if we
> enables MSI for the guest kernel.
> 
> This series tries to first fix this issue function-wise, then speed up
> for the INTx again with resamplefd (mostly following the ideas
> proposed by Paolo one year ago [2]).  My TCP_RR test shows that:
> 
>   - Before this series: this is broken, no number to show
> 
>   - After patch 1 (enable slow path): get 63% perf comparing to full
>     kernel irqchip

Oh, I thought something like patch 1 had already been applied.

One comment: because you're bypassing IOAPIC when raising the irq, the
IOAPIC's remote_irr for example will not be set.  Most OSes probably
don't care, but it's at least worth a comment.

Paolo

>   - After whole series (enable fast path partly, irq injection will be
>     the same as fast path, however userspace needs to intercept for
>     EOI broadcast to resamplefd, though should still be faster than
>     the MMIO trick for intx eoi): get 93% perf comparing to full
>     kernel irqchip, which is a 46% performance boost


