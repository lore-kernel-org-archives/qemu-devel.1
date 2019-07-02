Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2344C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75F921852
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+J/XUNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75F921852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOFX-0005bd-3s
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49597)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiN9Q-0003ei-3U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiN9C-0006dc-Bs
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:04:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiN91-0006JH-JL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 14:04:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id z23so18105290ote.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Bi09lEVeDAFQsaQvsCrjgXi9neIu4EZJKKOLKhdRyS4=;
 b=I+J/XUNekxMJrx1/01qxBgbfbR4kuwtyl8aTFl4yzCvT/mpXoyoGPEbyfWlTIjIDJf
 huPilD1OBUqFTdRs9qy6nD8yuQrd/xq3vOG3uKjzx/Dl8p0kbFp8gbM8xfY4ifUuPgMI
 uRFBgHfwXJ0WGzPqcJkzRfEERQsXOuAGOWozQqYELwailVDQYcq65PEQYXUPdbClEcgf
 u+PswKLFqFEwP+yozaPFUBrYSOoapu041wCsV4vDRQg9hVfEFX8+EUAKcxjbgLB4eQfg
 Kmg8eEZU6gv6oeueCxAfSLVSeNxYNmOKDVqxADY6Ew5tTjU33bOGmGFOqS+CaFyd2GsS
 p+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bi09lEVeDAFQsaQvsCrjgXi9neIu4EZJKKOLKhdRyS4=;
 b=My+thi0gUw/E/hmGu+tuL5/OGzi1cg3iUra0zujG/QTl7YvCo+JrlAEzqw1kgvD67Z
 OMVJ0rJKxOYRG6anNkhi2R2y82bLBR5nJznxgL9NE08RV5JgHc1/gIdan9OrqzIKVarb
 FZIc6sRnFF2C21yNi8YhcZD6Xt1SBwWWigstTAG9A7aPWYVmaBO6pKrd/rn/vKWn7fKy
 roLJOhVFT0IV8ic9vbRh/Khg0W+ROdDoSpiiLF6ithcmdWNDiVSppFCG1QGF31Bve1Cz
 n0Jb8YLJKSWP8sQwhS8KEHyFQqJW6Pi8Xe4BAIcD4s76f/DIuNcIkQkikhpIxPS/ht5E
 6biQ==
X-Gm-Message-State: APjAAAW304IuH/0ApezmsO7kUJvGaxzYNoCpvfXYPS31s+2+P+4ikTiN
 ySX170A/BHzR3mTb6g+m1gWa8hYU0SREzNEMU1CL8A==
X-Google-Smtp-Source: APXvYqzUsl3Xj6NP/jZ/fJM3pG82gD44cANhHyb+tGfohqjp0PSJVjvtXnkhhWwImj3OZPJ271WVwh+y6r/2OgEh330=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr25721860oti.91.1562090666280; 
 Tue, 02 Jul 2019 11:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
In-Reply-To: <87a7dwnxwj.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 19:04:15 +0100
Message-ID: <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, maran.wilson@oracle.com,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 18:34, Sergio Lopez <slp@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Could we use virtio-pci instead of virtio-mmio? virtio-mmio is
> > a bit deprecated and tends not to support all the features that
> > virtio-pci does. It was introduced mostly as a stopgap while we
> > didn't have pci support in the aarch64 virt machine, and remains
> > for legacy "we don't like to break existing working setups" rather
> > than as a recommended config for new systems.
>
> Using virtio-pci implies keeping PCI and ACPI support, defeating a
> significant part of microvm's purpose.
>
> What are the issues with the current state of virtio-mmio? Is there a
> way I can help to improve the situation?

Off the top of my head:
 * limitations on numbers of devices
 * no hotplug support
 * unlike PCI, it's not probeable, so you have to tell the
   guest where all the transports are using device tree or
   some similar mechanism
 * you need one IRQ line per transport, which restricts how
   many you can have
 * it's only virtio-0.9, it doesn't support any of the new
   virtio-1.0 functionality
 * it is broadly not really maintained in QEMU (and I think
   not really in the kernel either? not sure), because we'd
   rather not have to maintain two mechanisms for doing virtio
   when virtio-pci is clearly better than virtio-mmio

thanks
-- PMM

