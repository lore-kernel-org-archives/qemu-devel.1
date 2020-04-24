Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCE7C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 249182075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT2Q173r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249182075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS0uP-0000n6-5p
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 12:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS0tX-0000Cf-UR
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS0tX-0007wx-FW
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:09:39 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:34205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jS0tX-0007wc-1g
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:09:39 -0400
Received: by mail-il1-x142.google.com with SMTP id w6so9783522ilg.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x34Cvcp8HB+wcNcEXmq5CtCFXROT6wpN0c6tiV5Xaek=;
 b=hT2Q173r608lxtoWrm2ErJtMP40o9S3f9W7/V0ik1bRM7QMu1z30np3klCurID60RD
 nJq6oyMwszUvpiH4m+SNe10OGIX72wA7Xn2YJ3bBdx+3tBVLZvckdIxm0A8l0i71PUKf
 HmhnkFbXDwkB4N/u631ow92ptSdsgYlbDD8l/T4Vvs0J1RypYL5Y+ftCWIVL6md0/3SF
 g2y2JzzjpE8tZt5l1KqgdcSKJMvu1WhP3qiLlFpFTF/+tA0rJnSzg7ix/eY86cyhjFXM
 +f16JbdfKX0Lzc8RVCTBqNIbek0ggsAtzjOPjpIsxiO1/1oqFPH0WoDEND+qS2+uAQCF
 GZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x34Cvcp8HB+wcNcEXmq5CtCFXROT6wpN0c6tiV5Xaek=;
 b=YFZo/zA5NFSogGSZGg8cflucfKt/VKHLiUgqqedRRnXF5I2nMXNyqkC3HDXRdo/wh6
 yEJEIM9QpT3g0PtOXnH+lg46UdqCDc7STwQ1dfoCB+RfmVLOBQqqArWBh+85oZTnc5gc
 OD5v+q5uN3n1LR7mBMVawCKPV19cx4MGw9/9VfEP8CYsBJcdQfXdAPAI+2MF+UvILIYI
 W+1CJo8t3GnCgxMIRtmlwB5DJi5d5XkcrqWu4glazWrx44tmfAupWBb2Mwf9o8ec8pXq
 XzAeqtLjn08mT1Garw4rLllkJ8WrUByolAdlxKhMfWxYBFuToQ0gNDFnvVQBn1vLlZ4l
 DdyQ==
X-Gm-Message-State: AGi0PuYr0Uz9M+aMZCRSD/rDDjPdiM7xhvl2sYgslgMCaj2mlBPYubTu
 BdBtgs6t8u4D6FdoNlopIh7OQorhpnp/rKdrZ0M=
X-Google-Smtp-Source: APiQypJYUdtkiHOJXQ0XJUUP5R3bGrA9sRco/JWU+nEi3qMFRCm7/NmWWQ042UfUqTXopQtnSZExvK2LpajdpYS26Z4=
X-Received: by 2002:a92:4b11:: with SMTP id m17mr9613499ilg.42.1587744577468; 
 Fri, 24 Apr 2020 09:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182127.12258.26300.stgit@localhost.localdomain>
 <a2183a2f-e10d-1e19-52d9-a9cd71fa2655@redhat.com>
 <CAKgT0Ud1WVUV5VNCCBqJtYPSLCZTq5oXGUyvqHmXdnTQUko6qQ@mail.gmail.com>
 <6f7f970f-9188-726e-39da-6e0954ab9fdf@redhat.com>
In-Reply-To: <6f7f970f-9188-726e-39da-6e0954ab9fdf@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 24 Apr 2020 09:09:26 -0700
Message-ID: <CAKgT0Ueg=oJpxXj2m9hpV8V7v75VcByhsWH3Vz1_-tRuJ3MtFQ@mail.gmail.com>
Subject: Re: [PATCH v21 QEMU 5/5] virtio-balloon: Provide an interface for
 free page reporting
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alexander.duyck@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 24, 2020 at 8:34 AM David Hildenbrand <david@redhat.com> wrote:
>
>
> >> Also, I do wonder if we want to default-enable it. It can still have a
> >> negative performance impact and some people might not want that.
> >
> > The negative performance impact should be minimal. At this point the
> > hinting process ends up being very light since it only processes a
> > small chunk of the memory before it shuts down for a couple seconds.
> > In my original data the only time any significant performance
> > regression was seen was with page shuffling enabled, and that was
> > before I put limits on how many pages we could process per pass and
> > how frequently we would make a pass through memory. My thought is that
> > we are much better having it enabled by default rather than having it
> > disabled by default. In the worst case scenario we have a little bit
> > of extra thread noise from it popping up running for a few
> > milliseconds and then sleeping for about two seconds, but the benefit
> > side is that the VMs will do us a favor and restrict themselves to a
> > much smaller idle footprint until such time as the memory is actually
> > needed in the guest.
>
> While I agree that the impact is small, there *is* a noticeable
> performance impact. One of the main users is memory overcommit.
>
> Also, imagine the following scenarios:
> - RT workload in the guest. Just because you have a virtio-balloon
>   device defined would mean something is suddenly active and
>   discarding/trying to discard pages.
> - vfio: free page reporting is completely useless right now and
>   *only* overhead.
> - prealloc does not expect that pages get suddenly discarded
> - s390x, which has CMM and might not benefit at all (except when using
>   huge pages as backing storage)
>
> No, I don't think it's acceptable to enable this as default. I remember
> that it is quite common to just define a balloon device but never use it.
>
> E.g., "A virtual memory balloon device is added to all Xen and KVM/QEMU
> guest virtual machines. It will be seen as <memballoon> element" [1].
>
> I think we should let upper layers decide (just as we do for free page
> hinting, for example).

Okay. I guess there are a number of other cases I hand't thought of. I
will switch the default to false.

Thanks.

- Alex

