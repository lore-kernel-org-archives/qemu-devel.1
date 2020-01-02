Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D29C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 09:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D7C2085B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 09:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd/6OK5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D7C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imx3d-0008Ku-O5
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 04:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1imx2k-0007UO-JM
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 04:45:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1imx2h-0004xU-VG
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 04:45:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45765
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1imx2h-0004vJ-5b
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 04:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577958321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lSuXTcKs/CF4JxeUcWioLf+gWvLHrylrfliOgf7jHYI=;
 b=Gd/6OK5a/NfSENEwzClo1++uqWC40chNnjKu+2gadeBoFkEsxALGgXbvskqMLEFBPqNEPg
 AiFObO6wtya37GKsxlahuOdBAkY6ajJ2h7QRICyrra0Kt/yrZTTKBHZlztT5XQl2tg3JJO
 9c7KAdC6q+K5R3qAU+bzEXEbjcAHyvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-DghkZT8AM5W8KJ3wM_HzBw-1; Thu, 02 Jan 2020 04:45:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42652477;
 Thu,  2 Jan 2020 09:45:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D193C5C554;
 Thu,  2 Jan 2020 09:45:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C7C7C9DA5; Thu,  2 Jan 2020 10:45:15 +0100 (CET)
Date: Thu, 2 Jan 2020 10:45:15 +0100
From: "kraxel@redhat.com" <kraxel@redhat.com>
To: Sai Pavan Boddu <saipava@xilinx.com>
Subject: Re: sysbus usb xhci
Message-ID: <20200102094515.bbjaqlif7ucvzuou@sirius.home.kraxel.org>
References: <MN2PR02MB5935CFE95528B85E06DA9583CA200@MN2PR02MB5935.namprd02.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MN2PR02MB5935CFE95528B85E06DA9583CA200@MN2PR02MB5935.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: DghkZT8AM5W8KJ3wM_HzBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 02, 2020 at 07:13:25AM +0000, Sai Pavan Boddu wrote:
> Hi Gred,
>=20
> We are seeing of options to reuse the hcd-xhci model and use it over syst=
em bus interface rather than pci. (for Xilinx ZynqMP SOC, usb emulation)
> Are there any plans of implementing a sysbus device ? if none it would be=
 good if provided few pointers to start.

There have been some discussions about this for a (IIRC) sbsa machine,
but I'm not sure whenever that where just ideas or some code exists.

> Im looking at hcd-ehci/ochi as a reference, let me know if there are any =
know limitations for this usecase.

Yep, the path for xhci would be quite simliar:  Create a new
XHCIPciState struct, move over all pci-specific bits from XHCIState,
leaving the generic stuff in XHCIState for sharing with sysbus.
Possibly move all pci-specific code bits into a new source file (for
cleanup, will also allow to build qemu with CONFIG_PCI=3Dn and still have
XHCI enabled).

Once this separation is done you should be able to create a sysbus
device, reusing the generic xhci code and adding sysbus plumbing
(mmio, irq, ...)

cheers,
  Gerd


