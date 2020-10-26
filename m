Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F488C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 07:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E77D20747
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 07:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDFALj3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E77D20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWwWn-0006Yk-Eh
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 03:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kWwVZ-00062m-B8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 03:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kWwVX-0005He-NV
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 03:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603695690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XaW8X1jOGOCjgR5P8L3QnYQHLpbScR8ZrCJ31P06vvo=;
 b=WDFALj3WdrAPoaMd3tYsUU+2QnJjZRkhaqY/eIsCObGAypyTqvVfAeoA6dE6FQ0N9rmG8m
 k4oU+bgq+9ANa9Yg4muRo6dGwWg0vtdqc03U3n+pH+1ytDeXamq6YeJKslHu1LNcFIjPAy
 ZmG0rNSJ3sH1jMYNGGR95LQOOa4WZdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-nRV1tDVQOCGYGR-95ozjIA-1; Mon, 26 Oct 2020 03:01:26 -0400
X-MC-Unique: nRV1tDVQOCGYGR-95ozjIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 561DEA0BE1;
 Mon, 26 Oct 2020 07:01:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8CA66EF46;
 Mon, 26 Oct 2020 07:01:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F1196204A1; Mon, 26 Oct 2020 08:01:17 +0100 (CET)
Date: Mon, 26 Oct 2020 08:01:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/8] arm/virt: add usb support
Message-ID: <20201026070117.5ovcm4ep6iohjyfh@sirius.home.kraxel.org>
References: <20201023071022.24916-1-kraxel@redhat.com>
 <CAFEAcA-gEeHUJtuF9CX4XhXh6dnANNut-TJWz0nM8obAmMa3yA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gEeHUJtuF9CX4XhXh6dnANNut-TJWz0nM8obAmMa3yA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 23, 2020 at 12:36:05PM +0100, Peter Maydell wrote:
> On Fri, 23 Oct 2020 at 08:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Bring new microvm goodies to arm virt too.  Wire up
> > -machine usb=on, add sysbus-xhci in case it is enabled.
> 
> So my question here is the usual one -- why can't we
> just use a PCI USB controller ?

Well, pci seems to come with some extra resource needs (see -M pc vs.
-M q35 memory footprint differences discussed some months ago).  Thats
why microvm started without pci support, and even now with pcie support
added it is optional (and off by default).

I'm wondering whenever it makes sense for arm/virt to make pcie optional
too.  Adding an OnOffAuto pcie switch is easy.  Some places which
assume pci is present need fixing (-cdrom for example blindly uses
virtio-blk-pci).  Looks doable without too much effort and it would
effectively bring a microvm-ish machine type to the arm/virt world.

So in case pcie is switchable using sysbus-xhci would bring usb support
without requiring pcie support for that.

With pcie being present unconditionally there isn't much of a difference
between sysbus-xhci and qemu-xhci (the pci variant of the device).  The
only problem with machine,usb=on adding a qemu-xhci device automatically
would be that we would have to pick some pci slot where we can place the
device ...

take care,
  Gerd


