Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AD4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 06:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4A5206FB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 06:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMrhVqx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4A5206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRrbe-00013T-EF
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 02:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kRrak-0000bm-Qv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 02:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kRrah-0003qP-NJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 02:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602485149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yzD/eAYf8lyOos+am/OOkUJWvH6t/vap7RoX1OCR0M0=;
 b=NMrhVqx2Y2WzsZYrjQGBzsONgrsbG0LxiuTJm7tx9vkS0u3IecV3snhzfhjtYjDEy3R4cW
 QSBwPISUPe0BM1Py9El7i6AjX5fD6dDv2Mb3xeJ5MDMuub3DrtLB/N3/fZ3qQiBoLPiHCp
 gnDxod1ay8CsrZLfFWHft2i4IiNxS68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-IAfrcyNINTqyy-FaZG4D1Q-1; Mon, 12 Oct 2020 02:45:45 -0400
X-MC-Unique: IAfrcyNINTqyy-FaZG4D1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92339185A0C9;
 Mon, 12 Oct 2020 06:45:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 839E95D9CD;
 Mon, 12 Oct 2020 06:45:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6A26117538; Mon, 12 Oct 2020 08:45:36 +0200 (CEST)
Date: Mon, 12 Oct 2020 08:45:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 4/9] microvm: add usb support
Message-ID: <20201012064536.fgiyh7mrldj4gcwy@sirius.home.kraxel.org>
References: <20201001082834.15821-1-kraxel@redhat.com>
 <20201001082834.15821-5-kraxel@redhat.com>
 <20201006120326.765e4e61@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006120326.765e4e61@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 06, 2020 at 12:03:26PM +0200, Igor Mammedov wrote:
> On Thu,  1 Oct 2020 10:28:29 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > Wire up "usb=on" machine option, when enabled add
> > a sysbus xhci controller with 8 ports.
> 
> first pci, and now usb - not so micro anymore.

Both pcie and usb are optional and disabled by default.

> why not just reuse pci to add usb controller?
> what/how much do we win avoiding PCI?

Didn't benchmark stuff myself, but there are several reports that
the pcie initialization by the linux kernel at boot is noticable
(lots of vmexits for pci config space access).

IIRC this is also the reason why microvm started without pci support in
the first place.  So being able to enable usb without having to enable
pcie too looks useful to me.

But, yes, functionality-wise there isn't much of a difference between
"-microvm usb=on" and "-microvm pcie=on -device qemu-xhci".

take care,
  Gerd


