Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206EAC4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B31321D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7OoOhiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B31321D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt8b-0005sW-Gs
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMt0U-0003QD-PD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMt0P-0002BA-3X
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:15:54 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601298946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ELbPUT56WE3t+U6IuK0HaFN17wtg0pFKQoWrviDgJ2w=;
 b=F7OoOhiXxWwqq7lPJxj90P6IeO2Im6GA1lOdcdoHbz0+jqm8kLY3bhLYG00wPCZfJRZmUv
 KhotDRA7LxcVDncG4i3NhNZ4JvKZKBJYW88RiEAI8+BgMdK6lOrZe6B2l9QcpZ/6v+Tca3
 FFZG2jD117WXaWZKwWOickwFr/yXNYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-oyuSbUPFNl2AsHkZpNoHFg-1; Mon, 28 Sep 2020 09:15:40 -0400
X-MC-Unique: oyuSbUPFNl2AsHkZpNoHFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8280C8B8D17;
 Mon, 28 Sep 2020 13:15:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64A5875151;
 Mon, 28 Sep 2020 13:15:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4E4EC40827; Mon, 28 Sep 2020 15:15:17 +0200 (CEST)
Date: Mon, 28 Sep 2020 15:15:17 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Subject: Re: [PATCH v10 7/7] Versal: Connect DWC3 controller with virt-versal
Message-ID: <20200928131517.hmczcqisasv47tls@sirius.home.kraxel.org>
References: <1600957256-6494-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600957256-6494-8-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200925183946.GP4142@toto>
MIME-Version: 1.0
In-Reply-To: <20200925183946.GP4142@toto>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
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

On Fri, Sep 25, 2020 at 08:39:46PM +0200, Edgar E. Iglesias wrote:
> On Thu, Sep 24, 2020 at 07:50:56PM +0530, Sai Pavan Boddu wrote:
> > From: Vikram Garhwal <fnu.vikram@xilinx.com>
> > 
> > Connect dwc3 controller and usb2-reg module to xlnx-versal SOC, its placed
> > in iou of lpd domain and configure it as dual port host controller. Add the
> > respective guest dts nodes for "xlnx-versal-virt" machine.
> 
> Hi Sai,
> 
> One minor comment inline.

Cherry-picked patches 1-4 for the usb queue, leaving 5-7 for later (or
maybe the arm queue).

take care,
  Gerd


