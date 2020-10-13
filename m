Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B01AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773D420797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V79PicHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773D420797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEPp-0006yR-Gf
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSENO-0003nj-RK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 03:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSENN-0001Z6-4V
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 03:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602572736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=173lJMH/typSsDMg9+mYGgAHoDM3o3FufiJ7fJrtiC0=;
 b=V79PicHQd5ioSVLQ+vedbOGTgWUfDF7l6LMmzCWP3M/AuFYh6cHj3rixI4yUwV2fKumhAm
 z6lgrp4dYKRcB6Tlwl5PCj4eBQ9NrZu5SmpYDkuHlONyd9GyYKYx/ydj2/iIq+M77t0EqQ
 H4u+jHTDvdVUmxBfaK/pzUo8nhZ1rHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-IN3QqB9RPwamXv3GwMWLVA-1; Tue, 13 Oct 2020 03:05:34 -0400
X-MC-Unique: IN3QqB9RPwamXv3GwMWLVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C554718A823C;
 Tue, 13 Oct 2020 07:05:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8229A60C13;
 Tue, 13 Oct 2020 07:05:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A37101750A; Tue, 13 Oct 2020 09:05:30 +0200 (CEST)
Date: Tue, 13 Oct 2020 09:05:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Havard Skinnemoen <hskinnemoen@google.com>
Subject: Re: [PATCH 5/6] hw/arm/npcm7xx: Add EHCI and OHCI controllers
Message-ID: <20201013070530.nq5zhuotqaucj3ja@sirius.home.kraxel.org>
References: <20201008232154.94221-1-hskinnemoen@google.com>
 <20201008232154.94221-6-hskinnemoen@google.com>
MIME-Version: 1.0
In-Reply-To: <20201008232154.94221-6-hskinnemoen@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, f4bug@amsat.org, qemu-devel@nongnu.org,
 kfting@nuvoton.com, qemu-arm@nongnu.org, Avi.Fishman@nuvoton.com, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 08, 2020 at 04:21:53PM -0700, Havard Skinnemoen wrote:
> The NPCM730 and NPCM750 chips have a single USB host port shared between
> a USB 2.0 EHCI host controller and a USB 1.1 OHCI host controller. This
> adds support for both of them.
> 
> Testing notes:
>   * With -device usb-kbd, qemu will automatically insert a full-speed
>     hub, and the keyboard becomes controlled by the OHCI controller.
>   * With -device usb-kbd,bus=usb-bus.0,port=1, the keyboard is directly
>     attached to the port without any hubs, and the device becomes
>     controlled by the EHCI controller since it's high speed capable.
>   * With -device usb-kbd,bus=usb-bus.0,port=1,usb_version=1, the
>     keyboard is directly attached to the port, but it only advertises
>     itself as full-speed capable, so it becomes controlled by the OHCI
>     controller.
> 
> In all cases, the keyboard device enumerates correctly.

Looks good.  Goes through the arm queue I guess?

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


