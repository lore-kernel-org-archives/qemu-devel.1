Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E6C74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FFC21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/KKUsqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FFC21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYgj-0001Cj-B6
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33209)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYfq-0000dY-9Y
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYfp-0005yq-8d
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:59:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYfp-0005xs-38
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:59:45 -0400
Received: by mail-ot1-x342.google.com with SMTP id x21so5699410otq.12
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Me9ADo/C9cmgC762XJrfpOD5onZSeKsx2B01+M4r6Lk=;
 b=d/KKUsqJHraL3rbuOvnlW/8MM3VlQ0rZcAzq5rNqiWsGJD0LI0RHY7I19NMz8Wd5Df
 o9SQxPCSkfI7OUoM88shXk5GVjRj5NITE80zo9BQEENxy8sQi/1wKs3JY3NYFeQqL2Ca
 laRGFLV8jFg+03jtrPKo8BfE59jmzNe8gEYifWKjG6psvqfa+ouPqlo6P/yv7DaInEqq
 0mx45vN5rbJxoyasj2ryDOHercytS65v3NvYWeCFOvZH9jb6NR62N6m23x0vhaGXECU0
 tVA5fTEBpCcz6iMpfNv75kDF4ceob5rmQC00JvOq+OO3Dq/7BDW4P7xGhhNIKcB1huXR
 ItoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Me9ADo/C9cmgC762XJrfpOD5onZSeKsx2B01+M4r6Lk=;
 b=o4A1OiH9JICl2Sk30eSODoOg8txpbu6vXa3sHs8pXK8Flc4fC79y64jkCogSDvvB77
 eYzXNnUBt2TXh0yzYvcmYCsS4/S9VUcuz6WwMiwuo2okqIQJdJZAdFTfmMEgqXmIKZZg
 Q9QetHocdHFEHADudcPcbhC5aqdfJywzosLf77kT9NcyVjBUX11biUG8Dx2B4P2A6uqB
 w5/NPtiiJn2fVhWe2kifZwNl5zjK97Wr3dFYVLt6Ht6JypvOcSPzxY2qST56x9lab4OR
 I3hxOrTJ4MGP7s43ShPE7jI+nsyVyb+6s1MNxQV3UrRPkO/tMhFvPJC7aEb4rUKqaENR
 A/LA==
X-Gm-Message-State: APjAAAXaoLIDsYs3UWNKaFb9ofAevCv4QfFEZvC3QBndTIRXAyNdf2mX
 V9Xc8O0sQChAikLIeVRGt3+UnHhhkKFj6gdIOJ4Tdw==
X-Google-Smtp-Source: APXvYqyv/etiWX38sdstFWl2AIQMi1TWd+PZQpnvi2yBUk6ZDKcezEaVcJlQWOWEgWqJo4YlWLXaSXzbPR3L6mUD/Lo=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr3075519otj.97.1562849984271; 
 Thu, 11 Jul 2019 05:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150606.24851-1-mst@redhat.com>
 <20190619094907.10131-5-pagupta@redhat.com>
In-Reply-To: <20190619094907.10131-5-pagupta@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 13:59:33 +0100
Message-ID: <CAFEAcA_fHQKz3Kw1sumQHRLvq+LQ1nLo3V3v_dXE7PRT8xou9w@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 08/22] virtio-pci: Proxy for virtio-pmem
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
Cc: Pankaj Gupta <pagupta@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 16:07, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Pankaj Gupta <pagupta@redhat.com>
>
> We need a proxy device for virtio-pmem, and this device has to be the
> actual memory device so we can cleanly hotplug it.
>
> Forward memory device class functions either to the actual device or use
> properties of the virtio-pmem device to implement these in the proxy.
>
> virtio-pmem will only be compiled for selected, supported architectures
> (that can deal with virtio/pci devices being memory devices). An
> architecture that is prepared for that can simply enable
> CONFIG_VIRTIO_PMEM to make it work.
>
> As not all architectures support memory devices (and CONFIG_VIRTIO_PMEM
> will be enabled per supported architecture), we have to move the PCI proxy
> to a separate file.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> [ split up patches, memory-device changes, move pci proxy]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20190619094907.10131-5-pagupta@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Hi; Coverity spotted a bug here (CID 1403010):

> +static uint64_t virtio_pmem_pci_get_plugged_size(const MemoryDeviceState *md,
> +                                                 Error **errp)
> +{
> +    VirtIOPMEMPCI *pci_pmem = VIRTIO_PMEM_PCI(md);
> +    VirtIOPMEM *pmem = VIRTIO_PMEM(&pci_pmem->vdev);
> +    VirtIOPMEMClass *vpc = VIRTIO_PMEM_GET_CLASS(pmem);
> +    MemoryRegion *mr = vpc->get_memory_region(pmem, errp);
> +
> +    /* the plugged size corresponds to the region size */
> +    return mr ? 0 : memory_region_size(mr);

This looks like maybe the arguments to ?: have been put
the wrong way round? If mr is non-NULL we'll return 0
and if it is NULL then we'll crash because memory_region_size()
dereferences mr...

> +}

thanks
-- PMM

