Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2851AC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB620218DA
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 22:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB620218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiQwt-0002sh-98
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 18:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hiQuB-0001sU-20
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hiQu3-00021E-An
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:05:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hiQtz-000101-PN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 18:05:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so147088wmj.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 15:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lAGQd72zM/qKe0oHpMeROkdsbmqmnCkQdhy++O2S+v0=;
 b=PTYSylsWRil7jGMt28pAnytSWPdhw1Ctt7JvUgIVMyeJ6i6hDQk8g9jp5g7LP26Ou6
 gvkZSZuSVsS2kfWD0AJDmwiUVJkmdzugMdUglb5Gyi5b8E1aW1dXtqoo6HMVisvi+RNR
 eKJ6zFaLyIBc6rnIxw4iXvycNHOLZ0VvccdhdvUDm053qKMcQoGFb/TicZUliCtm7b4X
 GzlNBn8hx2hMtl9Ju7aBaYlJ5scvOgr4QX1ZC9FjoKDFY3GuJZ6mcdE3/LsOkphyigo6
 FDnDoxwHPLIJ1Sv+MPZdlVyDS6UC+6rN17O2vnzuAWVP1cL83zmXT37LoxHwPkmowDgY
 TDfg==
X-Gm-Message-State: APjAAAX8DkHBaSXjzJzCiFeRyp9nFyqL5JUUOeb4b4y7G8vZK26+hZhK
 VKtyKLcORsmeqcwBtqFHghD7Wg==
X-Google-Smtp-Source: APXvYqya5dTMJXPxa/P4HPWH9/KGTo3f1x6Xzo/vLtCtc6rtVRXfI5AHXE4zXrRgEQlrcMYTinaD+A==
X-Received: by 2002:a1c:6c0a:: with SMTP id h10mr4585363wmc.40.1562105044968; 
 Tue, 02 Jul 2019 15:04:04 -0700 (PDT)
Received: from localhost (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id y3sm132210wrq.30.2019.07.02.15.04.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 15:04:03 -0700 (PDT)
Date: Wed, 3 Jul 2019 00:04:00 +0200
From: Sergio Lopez <slp@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190702220400.GA13923@localhost>
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
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

On Tue, Jul 02, 2019 at 07:04:15PM +0100, Peter Maydell wrote:
> On Tue, 2 Jul 2019 at 18:34, Sergio Lopez <slp@redhat.com> wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> > > Could we use virtio-pci instead of virtio-mmio? virtio-mmio is
> > > a bit deprecated and tends not to support all the features that
> > > virtio-pci does. It was introduced mostly as a stopgap while we
> > > didn't have pci support in the aarch64 virt machine, and remains
> > > for legacy "we don't like to break existing working setups" rather
> > > than as a recommended config for new systems.
> >
> > Using virtio-pci implies keeping PCI and ACPI support, defeating a
> > significant part of microvm's purpose.
> >
> > What are the issues with the current state of virtio-mmio? Is there a
> > way I can help to improve the situation?
> 
> Off the top of my head:
>  * limitations on numbers of devices
>  * no hotplug support
>  * unlike PCI, it's not probeable, so you have to tell the
>    guest where all the transports are using device tree or
>    some similar mechanism
>  * you need one IRQ line per transport, which restricts how
>    many you can have
>  * it's only virtio-0.9, it doesn't support any of the new
>    virtio-1.0 functionality
>  * it is broadly not really maintained in QEMU (and I think
>    not really in the kernel either? not sure), because we'd
>    rather not have to maintain two mechanisms for doing virtio
>    when virtio-pci is clearly better than virtio-mmio

Some of these are design issues, but others can be improved with a bit
of work.

As for the maintenance burden, I volunteer myself to help with that, so
it won't have an impact on other developers and/or projects.

Sergio.


