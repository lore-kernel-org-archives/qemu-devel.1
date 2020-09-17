Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DBE206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMQ3q5/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DBE206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIsLd-0004Dn-5k
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 07:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIsKn-0003XM-BB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 07:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIsKl-0006nz-8o
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 07:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600343054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4zY/9uVcpWpKtUIKhnSEgHm+vzNC4Ik8ckZgzyHz0Ng=;
 b=QMQ3q5/snwjpk2QfLX3X1ceydI/bIJeGnVLlmsQekmF9KQEKRGIyhzt2fBa0vE89tGL60U
 EdwKguLkMgvpZeh6s+MVFdwTlpT8eynTSfaotJLsNRtgn10nGWeMTRtV+CNsufZWhudDVG
 xHWQnJXjngRa7XKH1QAJrOKyAJ8bx6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-v-_Dzt1cPvyB3CwdfWsIaw-1; Thu, 17 Sep 2020 07:44:12 -0400
X-MC-Unique: v-_Dzt1cPvyB3CwdfWsIaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA65E188C126;
 Thu, 17 Sep 2020 11:44:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8808E5DA30;
 Thu, 17 Sep 2020 11:44:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BFA689D5A; Thu, 17 Sep 2020 13:44:06 +0200 (CEST)
Date: Thu, 17 Sep 2020 13:44:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v7 3/7] usb/hcd-xhci: Split pci wrapper for xhci base model
Message-ID: <20200917114406.sudvur5sjt4nqjd4@sirius.home.kraxel.org>
References: <1600266140-20763-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600266140-20763-4-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <1600266140-20763-4-git-send-email-sai.pavan.boddu@xilinx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?'Marc-Andr=C3=A9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?utf-8?Q?Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> +static const VMStateDescription vmstate_xhci_pci = {
> +    .name = "xhci-pci",
> +    .version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj, XHCIPciState),
> +        VMSTATE_MSIX(parent_obj, XHCIPciState),
> +        VMSTATE_UINT8_ARRAY(msix_used, XHCIPciState, MAXINTRS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

> @@ -3634,7 +3527,6 @@ static const VMStateDescription vmstate_xhci_intr = {
>          VMSTATE_UINT32(erdp_high,     XHCIInterrupter),
>  
>          /* state */
> -        VMSTATE_BOOL(msix_used,       XHCIInterrupter),
>          VMSTATE_BOOL(er_pcs,          XHCIInterrupter),
>          VMSTATE_UINT64(er_start,      XHCIInterrupter),
>          VMSTATE_UINT32(er_size,       XHCIInterrupter),
> @@ -3657,9 +3549,6 @@ static const VMStateDescription vmstate_xhci = {
>      .version_id = 1,
>      .post_load = usb_xhci_post_load,
>      .fields = (VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(parent_obj, XHCIState),
> -        VMSTATE_MSIX(parent_obj, XHCIState),
> -
>          VMSTATE_STRUCT_VARRAY_UINT32(ports, XHCIState, numports, 1,
>                                       vmstate_xhci_port, XHCIPort),
>          VMSTATE_STRUCT_VARRAY_UINT32(slots, XHCIState, numslots, 1,

Uh oh, that'll break cross-version live migration (i.e. save state with
5.1, load with 5.2).  Sorry for not noticing this earlier.

You can't remove the msix_used field.  I guess easiest is to just leave
that in XHCIInterrupter even if only xhci-pci actually uses it.

The vmstate_xhci + vmstate_xhci_pci reorganization should work with a
few changes:
 * First it must be one vmstate which keeps the fields in order.
   I think you can do that by not registering vmstate_xhci directly, but
   using an VMSTATE_STRUCT() entry in vmstate_xhci_pci.
 * Second the name must not change, so vmstate_xhci_pci must continue to
   use the "xhci" name.
 * I think for vmstates referenced by VMSTATE_STRUCT the name doesn't
   matter, so you could rename vmstate_xhci to -- for example --
   "xhci-core" so vmstate_xhci and vmstate_xhci_pci have different
   names.

take care,
  Gerd


