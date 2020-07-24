Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E21C433F4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466012063A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym8e3F4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466012063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyQ7-0005IZ-Gh
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyyPH-0004Aq-08
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:10:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyyPF-00013T-Ey
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595599836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IPRfWj4rSh5uLFBulmZutr55dBuWTSvRU9SOKR5M2YI=;
 b=Ym8e3F4Mzp8TL6powUZXIIc4BSEx0F+0iedSGBW/3oLxKo21S5q/+MX3sOnRbmbui4HcDO
 sllFQyYARjaX+22sCkU0wwNvIf0Qcel+0z9rPBC2hj8BbF7ifNtbPvPSay7xImtnyuOWbh
 5tOpBUjXGh3SCKFcWwfDB9XYVkw9sdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-XBBd-q4mOtSeQt1gfWralA-1; Fri, 24 Jul 2020 10:10:35 -0400
X-MC-Unique: XBBd-q4mOtSeQt1gfWralA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A07B800C64;
 Fri, 24 Jul 2020 14:10:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D24F174F64;
 Fri, 24 Jul 2020 14:10:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7BE0217444; Fri, 24 Jul 2020 16:10:32 +0200 (CEST)
Date: Fri, 24 Jul 2020 16:10:32 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Aaron Lauterer <a.lauterer@proxmox.com>
Subject: Re: Possible regression with VGA and resolutions in Windows 10?
Message-ID: <20200724141032.jmub3zixekeyy3x3@sirius.home.kraxel.org>
References: <24909a16-be74-7516-b5c5-08bdc743a553@proxmox.com>
 <20200724094120.dptmucij4phzd3od@sirius.home.kraxel.org>
 <1ee13b41-3ed7-8dd4-99b7-e325e95878d5@proxmox.com>
MIME-Version: 1.0
In-Reply-To: <1ee13b41-3ed7-8dd4-99b7-e325e95878d5@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> The behavior is similar when setting a custom resolution with the xres
> and yres parameters. Setting it the first time works fine and it is
> shown along with the short list. Setting it to something different on
> the next boot will not be recognized unless the display adapter is
> uninstalled and the VM rebooted.

Interesting.  Seems Windows caches the list of resolutions (or the edid
blob) somewhere in the registry instead of loading it on every boot.
I've seen simliar behavior with usb device info.

[ something for the 5.1 release notes I think, thanks for testing this ]

That still leaves the question open why the list of resolutions is that
short  It should be more like this:

# qemu-edid | edid-decode | grep @
  640x480@60Hz
  800x600@60Hz
  1024x768@60Hz
  2048x1152@60Hz
  1920x1080@60Hz
    VIC 101 4096x2160@50Hz 
    VIC  96 3840x2160@50Hz 
    VIC  89 2560x1080@50Hz 
    VIC  31 1920x1080@50Hz 

Seems windows filters out a bunch for some reason ...

take care,
  Gerd


