Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FA2C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0215D21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXIPIvr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0215D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYef-0008TV-7T
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYeB-0007xN-Gd
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYeA-0003p8-ES
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:58:03 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:41005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYeA-0003mn-7n
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:58:02 -0400
Received: by mail-ot1-x334.google.com with SMTP id o101so5724793ota.8
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W1i3c8PHWYx6uqL/+yt4ilyF0xqyR3GkinwVyqSUpfU=;
 b=HXIPIvr10uIu8/+JOup58AzBoQGrzg+O37GrX9yWAr0EJljESSPJqCQgaLbBo6ZNG/
 zeNIzp49CmwAddYlAuoyf1I0A2B4tpJsB7BNbsK+i+ghUKOtJT81Su7c1WIkgmekIEId
 3QmR8sWaCmyCaoe5F6TqKPYYCFKIRLbt1yWmtI5d3Gent6obtMMbzzgHCq/q9aki89Ax
 4PN6tsHseJDgLXaM2v8CPvmtIixsXedVWK/sDQ11ivYA6jx9YOcib3WYF/9lkZ4ucu8Z
 vhNlXBKLfTuxRIxGS1iGvxruaexiPg33GmnlEnteWV39YGEdni9oYHfb2UaIXNbQBlOr
 /7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W1i3c8PHWYx6uqL/+yt4ilyF0xqyR3GkinwVyqSUpfU=;
 b=TU4vZYVvZWV3nrasxjRJvK2yuysm8dmmel9aZ/9rd0XSJLfNFizTtCj+OjvbHqSr70
 +W8iF0BngXsGS8AtHrdkM3r9rPYA5D77MwLknTAwBcSaK9/Ss1EbosCLSwRFOfohhkFj
 4jpOK/L41IuhUKbdN7z5AqCGXSV859/4376S+aGbvokXu0a/nI37u1B1uYgdZkf1S7fm
 ixs9Rf2+7V+XLA1sgJGgUK9b7sM0rEoRiRnxxW+7w91gPkiEDO28dkhIS9n4Y6if66WU
 3Z3MoJ/KBiqUhVSI6ZOxPWTu90q0PkI9r+afYDbP6FArNkirippTHKOAagP5iJRGdpkE
 8fzg==
X-Gm-Message-State: APjAAAXj4gcenWlgb3UsxKd8/+HT7S7jYhJKMpbMTj9tXTBHyXgXsRsY
 ozhtmYFEmi4N5baeZBpzK2n2dKn0MudMOumAYJlh0A==
X-Google-Smtp-Source: APXvYqzzxziPF4ASlKh41zrUav9ybf7OW4lQf5nJh076jcHiqFA/cJPSz3CymA4Q6wi1UFh2A+TUyPMymEXhMJEmZlg=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr3430757otk.232.1562849880704; 
 Thu, 11 Jul 2019 05:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150606.24851-1-mst@redhat.com>
 <20190619094907.10131-2-pagupta@redhat.com>
In-Reply-To: <20190619094907.10131-2-pagupta@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 13:57:49 +0100
Message-ID: <CAFEAcA9=t7uK+=P3noWnP2Ga7=eKiPy9ZoDG9x=ty1P9UJgS3g@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: Re: [Qemu-devel] [PULL 05/22] virtio-pmem: add virtio device
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
Cc: Pankaj Gupta <pagupta@redhat.com>, David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 16:07, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Pankaj Gupta <pagupta@redhat.com>
>
> This is the implementation of virtio-pmem device. Support will require
> machine changes for the architectures that will support it, so it will
> not yet be compiled. It can be unlocked with VIRTIO_PMEM_SUPPORTED per
> machine and disabled globally via VIRTIO_PMEM.
>
> We cannot use the "addr" property as that is already used e.g. for
> virtio-pci/pci devices. And we will have e.g. virtio-pmem-pci as a proxy.
> So we have to choose a different one (unfortunately). "memaddr" it is.
> That name should ideally be used by all other virtio-* based memory
> devices in the future.
>     -device virtio-pmem-pci,id=p0,bus=bux0,addr=0x01,memaddr=0x1000000...
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> [ QAPI bits ]
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",
>   split up patches, unplug handler ]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20190619094907.10131-2-pagupta@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

> +static void virtio_pmem_fill_device_info(const VirtIOPMEM *pmem,
> +                                         VirtioPMEMDeviceInfo *vi)
> +{
> +    vi->memaddr = pmem->start;
> +    vi->size = pmem->memdev ? memory_region_size(&pmem->memdev->mr) : 0;
> +    vi->memdev = object_get_canonical_path(OBJECT(pmem->memdev));

Hi; Coverity points out (CID 1403009) that when we're assigning
vi->size we handle the "pmem->memdev is NULL" case; but we then
pass it into object_get_canonical_path(), which unconditionally
dereferences it and will crash if it is NULL. If this pointer
can be NULL then we need to do something else here.

> +}

thanks
-- PMM

