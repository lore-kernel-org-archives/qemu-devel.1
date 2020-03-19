Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF6C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458D22072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLxGIfpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458D22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzGF-0008Li-Bk
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jEzFB-0007T3-JU
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jEzFA-0001i0-Kf
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:46:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56295)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jEzFA-0001g5-HO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584639968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X96inDBVhoQXtXmJSxrHeIbtnSOPuYAOepBDwr8llyI=;
 b=aLxGIfpaSto1hUWVJVG+lssLtQ+/TnFvlGk9iyAi64Gi4G5EG3Ljjy/C9IfJzkRuNQy8dS
 Q8RhwVEqjDBUHbnP+mYWzqOnX14pVaEq0WgNNRfFFy44+S93tKeYNBpU0izRoJ39aGpd9Z
 qlUR+eVzFAtNp1mOBq/PHZzVgeS4/Zc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-f0oO7j7EOhKSCGMRZemUuA-1; Thu, 19 Mar 2020 13:46:00 -0400
X-MC-Unique: f0oO7j7EOhKSCGMRZemUuA-1
Received: by mail-wm1-f71.google.com with SMTP id a11so1302256wmm.9
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FulMNvK+4oyfG2BYLEjuJD5SbdTa19vDHO4eXc084cg=;
 b=hEedMbEaQ0ves4DOFvSroF3J+Km0EYD9CkpijWUb42E+gD5W6vV2pft12AfswMreYh
 xDzWkZpScQ5OcBTARK4r2uhcwekGQxieu5eiPRUIbfG4P9hXN0tb+8Tiwn4BhLFV0bN2
 /J5U2z2CUcL2dWOBnggn0RZ7JJLD1Ggs04P/T8GQC61rb/+i2SwSbwESJXqSM/frMTh1
 6PvZ61sbGrssspG5qsfWXcTp7Od9OyScgZuVAYrmzobW9xHUkwT2zstt5XR6UB6KUMMV
 Ssuz3W+xVJNXSTgI+rWsScuZ2shiWM/CUGhj3U4nIARDc7DV0wKi4U3NAZJPZqgAT4SA
 wKlg==
X-Gm-Message-State: ANhLgQ2Jf097X80F9HTiQhsq9hMqU4VhcyeIP0oQ7CKS71ZLFJyKfAB5
 sYO7hrpB+MXmZCm6D9NtHqZ+z6mzfDCf/BJvrfwscAIlia9zwsDZn8OtZ1Rw8pII+Ou2nudfMYv
 5uMOMP+U5lgSNdZ4=
X-Received: by 2002:adf:e78e:: with SMTP id n14mr5982002wrm.363.1584639959506; 
 Thu, 19 Mar 2020 10:45:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsgGXhqewAg01AVdZEvcJhyZkpW4JuFMjKOpkWuR8TGRCgocErSp27KRZm0726xeGikiQtE2g==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr5981978wrm.363.1584639959242; 
 Thu, 19 Mar 2020 10:45:59 -0700 (PDT)
Received: from redhat.com (bzq-109-66-39-109.red.bezeqint.net. [109.66.39.109])
 by smtp.gmail.com with ESMTPSA id w19sm3881478wmi.0.2020.03.19.10.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 10:45:58 -0700 (PDT)
Date: Thu, 19 Mar 2020 13:45:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when switching
 to protected mode
Message-ID: <20200319133710-mutt-send-email-mst@kernel.org>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
 <20200227132402.67a38047.pasic@linux.ibm.com>
 <8622efeb-1a4a-338f-d363-53818b00d195@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8622efeb-1a4a-338f-d363-53818b00d195@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Janosch Frank <frankja@linux.ibm.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 02:54:11PM +0100, David Hildenbrand wrote:
> Why does the balloon driver not support VIRTIO_F_IOMMU_PLATFORM? It is
> absolutely not clear to me. The introducing commit mentioned that it
> "bypasses DMA". I fail to see that.

Well sure one can put the balloon behind an IOMMU.  If will shuffle PFN
lists through a shared page.  Problem is, you can't run an untrusted
driver with it since if you do it can corrupt guest memory.
And VIRTIO_F_IOMMU_PLATFORM so far meant that you can run
a userspace driver.

Maybe we need a separate feature bit for this kind of thing where you
assume the driver is trusted? Such a bit - unlike
VIRTIO_F_IOMMU_PLATFORM - would allow legacy guests ...



--=20
MST


