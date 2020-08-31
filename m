Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D28C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC272072D
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NA7jDWca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC272072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCe0c-0001fw-BH
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 03:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCe06-0001EP-O1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:13:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCe04-0005Kf-Lm
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598857987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mPK86FLmpOats8qjh1dqdyqLXy8NURBXZnOb89hUJ9U=;
 b=NA7jDWca38RMrLyVbAi3RHcZ/X9uux+Zgg6mjFn/jPqjl6aWpTE5+dvAqXbTzxlvKvkzpA
 tReBMcGP6lfGlWWqZKHPhe0vubSbLSQWWG+Oofc2SRqscd/OmrAVYoyU9Q5pHubq2s7dXf
 XtaDT6CGLGNPlQ/lgqQ+D0AYPuS0d0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-rkRGNV3tPN2ze1dKUNekzA-1; Mon, 31 Aug 2020 03:13:04 -0400
X-MC-Unique: rkRGNV3tPN2ze1dKUNekzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 455C0802B6A;
 Mon, 31 Aug 2020 07:13:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A62EE614F9;
 Mon, 31 Aug 2020 07:12:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C14DC17447; Mon, 31 Aug 2020 09:12:58 +0200 (CEST)
Date: Mon, 31 Aug 2020 09:12:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v4 7/7] Versal: Connect DWC3 controller with virt-versal
Message-ID: <20200831071258.pkjkqss76tiuc7i2@sirius.home.kraxel.org>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-8-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1598642380-27817-8-git-send-email-sai.pavan.boddu@xilinx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:06:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Francisco Iglesias <francisco.iglesias@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?'Marc-Andr=C3=A9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?utf-8?Q?Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> +        unsigned int irq = VERSAL_USB0_IRQ_0;
> +        const char intName[] = "dwc_usb3";
> +        qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> +                         intName, sizeof(intName));
> +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> +                                   GIC_FDT_IRQ_TYPE_SPI, irq,
> +                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);

This seems to declare one IRQ in the FDT.

> +    qdev_prop_set_uint32(xhci_dev, "intrs", 4);

Here you configure 4 IRQs for xhci-sysbus.

> +    sysbus_connect_irq(SYS_BUS_DEVICE(xhci_dev), 0, pic[VERSAL_USB0_IRQ_0]);

Also a single IRQ only.

I'm wondering which is correct?  Probably one IRQ?  Do we need support
for multiple IRQs in xhci-sysbus in the first place?

take care,
  Gerd


