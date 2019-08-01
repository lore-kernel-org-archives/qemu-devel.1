Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3E4C32753
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556A3214DA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556A3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htA2Q-0007Db-MS
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 08:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1htA1t-0006oR-1P
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1htA1s-0007uf-1O
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:17:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1htA1r-0007uP-Tt
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:17:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so69919381qtl.5
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 05:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8HvCIqveHQFTQsPbxSY8BPKSR9+7iUK0LCosfuCvszk=;
 b=oEsIokPR9kr5vBvQ6giUNzNiYpignlKTF4r7D4IvawnonB42KbBX/nu33p8/Ow5TZ4
 vl7IOVSIsYRpbQHdaSMjEF3moG/SJ5+KLHctO9CjiRoXxlnd3cNGnI9aR8YaSWvY1/ET
 +yMXXSBawd8V2Y4FwyoEhBLOKmmgvdcQucjS4tby+aZB9mIgtXQZ6/TfpdI14ALsIXw3
 aWmmecqE4ojMByQAe787rE9Yi+w0esCf5KdaYMhkWwrO5pL/9JQrBjJvNpfxBqWq86zB
 JkHIZGKPzh0jBY/1BbqhIYVnnhDmp0Jd5A5r6yBfT6n2ARlQErnc5BJsXbOBv+/9Oi/5
 odyg==
X-Gm-Message-State: APjAAAVToDA0Yi4Emc+GvUImBjVRtfWFbtI0exQ9aCGTu4PjWHhZJWdx
 cfnGCPUPFUneGBVitUUAZdyaVA==
X-Google-Smtp-Source: APXvYqwfPTMpFTqFhgIy4Yn/YpQl1RChv9mHn3UAmRjBf1Ubx8yWbytErX0gFOcnd4QHG20JTTnpQA==
X-Received: by 2002:aed:2fe6:: with SMTP id m93mr61446518qtd.114.1564661875412; 
 Thu, 01 Aug 2019 05:17:55 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 o18sm41766116qtb.53.2019.08.01.05.17.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 05:17:54 -0700 (PDT)
Date: Thu, 1 Aug 2019 08:17:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190801073132-mutt-send-email-mst@kernel.org>
References: <20190729125755.45008-1-slp@redhat.com>
 <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
 <87imriwjpm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imriwjpm.fsf@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, Andrea Bolognani <abologna@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 31, 2019 at 01:02:13PM +0200, Sergio Lopez wrote:
> 
> Andrea Bolognani <abologna@redhat.com> writes:
> 
> > On Mon, 2019-07-29 at 14:57 +0200, Sergio Lopez wrote:
> > [...]
> >>  /* virtio-mmio device */
> >>  
> >>  static Property virtio_mmio_properties[] = {
> >>      DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
> >>                       format_transport_address, true),
> >> +    DEFINE_PROP_BOOL("modern", VirtIOMMIOProxy, modern, false),
> >>      DEFINE_PROP_END_OF_LIST(),
> >>  };
> >
> > Not a QEMU developer so forgive me if I say something silly, but IIUC
> > you'd be able to opt into the new feature by using eg.
> >
> >   -device virtio-net-device,modern=on
> >
> > However, virtio-pci devices already have a mechanism to control the
> > VirtIO protocol version, where you use
> >
> >   -device virtio-net-pci,disable-modern=no,disable-legacy=yes
> >
> > to get a VirtIO 1.x-only device and
> >
> >   -device virtio-net-pci,disable-modern=no,disable-legacy=no
> >
> > for a transitional device.
> >
> > Can you please make sure virtio-mmio uses the existing interface
> > instead of introducing a new one?
> 
> The problem here is that virtio-pci devices register an specific type
> for each kind of supported device (virtio-net-pci, virtio-blk-pci...),
> while virtio-mmio doesn't. This saves a lot of boilerplate, but also
> implies that bus properties can't be passed through the attached device
> (virtio-blk-device can't carry properties for it's virtio-mmio parent
> bus).
> 
> Sergio.

That's something we wanted to fix a long time ago though.

-- 
MST

