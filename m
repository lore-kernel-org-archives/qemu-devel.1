Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 06:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB7D20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 06:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyGKCnXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB7D20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXIvP-0004rL-Lq
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 02:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kXIuM-0004NU-1T
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 02:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kXIuI-0001hG-TA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 02:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603781792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjJ+fnfLw0yG27JqRqzoRy45hsKEOPxRf3O0DmrIim4=;
 b=GyGKCnXTy+0yyv8BiuVYfUKLyg8YMR5xnVJQURfjl3jLIoAH2zngPiNPp875KX2X0yQDKm
 0m6zmfc4OHrC0D8ofVXJnjMUjbDWys8RM22MSQf2oN0oOfp5Xh1Q8hJvCQSvNvRCOgtZGV
 WsGcixz7+UFLFCWzfKjGkPHMHszdhl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-b4qFGpgfMM-cwR1dA7NmWw-1; Tue, 27 Oct 2020 02:56:30 -0400
X-MC-Unique: b4qFGpgfMM-cwR1dA7NmWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D24D81006CA4;
 Tue, 27 Oct 2020 06:56:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EF5E60FC2;
 Tue, 27 Oct 2020 06:56:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 50AF39D0D; Tue, 27 Oct 2020 07:56:21 +0100 (CET)
Date: Tue, 27 Oct 2020 07:56:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/8] arm/virt: add usb support
Message-ID: <20201027065621.d7y7g2rtrdu3slyn@sirius.home.kraxel.org>
References: <20201023071022.24916-1-kraxel@redhat.com>
 <CAFEAcA-gEeHUJtuF9CX4XhXh6dnANNut-TJWz0nM8obAmMa3yA@mail.gmail.com>
 <20201026070117.5ovcm4ep6iohjyfh@sirius.home.kraxel.org>
 <CAFEAcA8vWzGQ3SG8bHzYwitqOat7fx71Kqs8tPQ8ZV6uWLHKXQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vWzGQ3SG8bHzYwitqOat7fx71Kqs8tPQ8ZV6uWLHKXQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Well, pci seems to come with some extra resource needs (see -M pc vs.
> > -M q35 memory footprint differences discussed some months ago).  Thats
> > why microvm started without pci support, and even now with pcie support
> > added it is optional (and off by default).
> 
> I think PCI is too useful to discard.

Discard is out of question of course.  I'd only add the option to
disable it if not needed.

> You can run anything you want (practically) via PCI. If we make it
> optional then we're going to give ourselves the task of reimplementing
> memory mapped versions of all the functionality it gives us,

No.  Well, at least it would not be *my* plan to reach feature parity.
I'm just trying to make available what we have.

The mmio versions of usb host adapters are needed anyway to emulate some
SoCs.  Describing them in device tree / ACPI is standardized so they
just work without additional changes on the guest side.  So this is
really just adding the device to the machine, adding a device tree node,
adding a acpi dsdt entry (roughly a dozen lines of code each).

Having virtio(-mmio) and usb is enough to cover alot of use cases.
Especially on arm where virtio-gpu is the only display device option.

> all of which is extra code and all of which adds to the
> amount of stuff on the guest-to-QEMU security boundary.

usb is off by default so it doesn't add anything unless you
explicitly ask for it.

Oh, and pci adds some non-trivial stuff to the guest-to-QEMU
security boundary too ...

> I think to be persuaded that no-PCI was a good idea I'd
> want to at least see solid figures based on doing this
> for Arm and on having put a lot of effort into slimming
> down the PCI handling code/overhead in the guest and still
> not being able to get near an MMIO setup. That is, try the
> "improve the guest" approach first.

Ok, fair enough.

take care,
  Gerd


