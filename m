Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9875DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66991214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b57YbCAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66991214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeCEJ-0007XH-Hl
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 02:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeCDi-00075S-2A
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:40:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22660
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeCDd-0007UR-Fl
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590648044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lL2azkr6dKea3GStfcQMYrBjdCXke6sLNc46mp7zYAc=;
 b=b57YbCAruG9OJAot7lvS7HJgHMx/mS2Vti9ysLhmuWqUP0o9kCMuMB/uZZ9V6ESe7HDsjR
 jWz8g65Qd6fx7B+4Jg7ixKynhrJmPuey4e1DM6PQBmn8rI56s4FdqVgSGSkdjGPJJxelej
 7mfHpyaYpRtMka2nt9BN29QFDmRNtbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-N5rq_NpOOTyeFyV8EYeAJw-1; Thu, 28 May 2020 02:40:42 -0400
X-MC-Unique: N5rq_NpOOTyeFyV8EYeAJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15EBE1005510;
 Thu, 28 May 2020 06:40:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B22F89F9BA;
 Thu, 28 May 2020 06:40:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8189A1753B; Thu, 28 May 2020 08:40:39 +0200 (CEST)
Date: Thu, 28 May 2020 08:40:39 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: USB pass-through problems
Message-ID: <20200528064039.yw5in3whgjvlni4z@sirius.home.kraxel.org>
References: <alpine.BSF.2.22.395.2005272129480.93454@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2005272129480.93454@zero.eik.bme.hu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 09:44:54PM +0200, BALATON Zoltan wrote:
> Hello,
> 
> I've seen a case when QEMU hangs with a passed through USB device. This is
> with -device usb-ehci and pass through with usb-host. This works until the
> attached USB device reboots (so likely it disconnects and reconnects) at
> which point QEMU hangs and need to be SIGKILL-ed to end (that's a bit hard
> to do with mouse and keyboard grabbed). I've got this stack trace:
> 
> #0  0x00007f23e7bd4949 in poll () at /lib64/libc.so.6
> #1  0x00007f23e8bfa9a5 in  () at /lib64/libusb-1.0.so.0
> #2  0x00007f23e8bfbb13 in libusb_handle_events_timeout_completed () at /lib64/libusb-1.0.so.0
> #3  0x000055e09854b7da in usb_host_abort_xfers (s=0x55e09b036dd0) at hw/usb/host-libusb.c:963
> #4  0x000055e09854b87a in usb_host_close (s=0x55e09b036dd0) at hw/usb/host-libusb.c:977
> #5  0x000055e09854b92e in usb_host_nodev_bh (opaque=0x55e09b036dd0) at hw/usb/host-libusb.c:998
> #6  0x000055e098757500 in aio_bh_call (bh=0x55e099ad9cc0) at util/async.c:136
> #7  0x000055e09875760a in aio_bh_poll (ctx=0x55e0996c2620) at util/async.c:164
> #8  0x000055e09875cb2a in aio_dispatch (ctx=0x55e0996c2620) at util/aio-posix.c:380
> #9  0x000055e098757a3d in aio_ctx_dispatch (source=0x55e0996c2620, callback=0x0, user_data=0x0) at util/async.c:306
> #10 0x00007f23e8c59665 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
> #11 0x000055e09875b0a9 in glib_pollfds_poll () at util/main-loop.c:219
> #12 0x000055e09875b123 in os_host_main_loop_wait (timeout=0) at util/main-loop.c:242
> #13 0x000055e09875b228 in main_loop_wait (nonblocking=0) at util/main-loop.c:518
> #14 0x000055e0982c91f8 in qemu_main_loop () at softmmu/vl.c:1664
> #15 0x000055e098162e7e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at softmmu/main.c:49
> 
> so the problem may be in libusb but QEMU should not hang completely. The
> host is Linux with libusb 1.0.22.

Hmm, does reverting 76d0a9362c6a6a7d88aa18c84c4186c9107ecaef change
behavior?

cheers,
  Gerd


