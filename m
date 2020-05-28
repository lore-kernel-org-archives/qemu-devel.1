Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E87C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1162075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1162075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEsU-0007Gj-Lu
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jeErQ-0006kf-ER
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:30:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:34950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jeErO-0007jW-03
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:29:59 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0A1697482D3;
 Thu, 28 May 2020 11:29:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DDE8C7482CA; Thu, 28 May 2020 11:29:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DC8827482CE;
 Thu, 28 May 2020 11:29:53 +0200 (CEST)
Date: Thu, 28 May 2020 11:29:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: USB pass-through problems
In-Reply-To: <20200528064039.yw5in3whgjvlni4z@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.22.395.2005281128460.96126@zero.eik.bme.hu>
References: <alpine.BSF.2.22.395.2005272129480.93454@zero.eik.bme.hu>
 <20200528064039.yw5in3whgjvlni4z@sirius.home.kraxel.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:29:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

On Thu, 28 May 2020, Gerd Hoffmann wrote:
> On Wed, May 27, 2020 at 09:44:54PM +0200, BALATON Zoltan wrote:
>> Hello,
>>
>> I've seen a case when QEMU hangs with a passed through USB device. This is
>> with -device usb-ehci and pass through with usb-host. This works until the
>> attached USB device reboots (so likely it disconnects and reconnects) at
>> which point QEMU hangs and need to be SIGKILL-ed to end (that's a bit hard
>> to do with mouse and keyboard grabbed). I've got this stack trace:
>>
>> #0  0x00007f23e7bd4949 in poll () at /lib64/libc.so.6
>> #1  0x00007f23e8bfa9a5 in  () at /lib64/libusb-1.0.so.0
>> #2  0x00007f23e8bfbb13 in libusb_handle_events_timeout_completed () at /lib64/libusb-1.0.so.0
>> #3  0x000055e09854b7da in usb_host_abort_xfers (s=0x55e09b036dd0) at hw/usb/host-libusb.c:963
>> #4  0x000055e09854b87a in usb_host_close (s=0x55e09b036dd0) at hw/usb/host-libusb.c:977
>> #5  0x000055e09854b92e in usb_host_nodev_bh (opaque=0x55e09b036dd0) at hw/usb/host-libusb.c:998
>> #6  0x000055e098757500 in aio_bh_call (bh=0x55e099ad9cc0) at util/async.c:136
>> #7  0x000055e09875760a in aio_bh_poll (ctx=0x55e0996c2620) at util/async.c:164
>> #8  0x000055e09875cb2a in aio_dispatch (ctx=0x55e0996c2620) at util/aio-posix.c:380
>> #9  0x000055e098757a3d in aio_ctx_dispatch (source=0x55e0996c2620, callback=0x0, user_data=0x0) at util/async.c:306
>> #10 0x00007f23e8c59665 in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
>> #11 0x000055e09875b0a9 in glib_pollfds_poll () at util/main-loop.c:219
>> #12 0x000055e09875b123 in os_host_main_loop_wait (timeout=0) at util/main-loop.c:242
>> #13 0x000055e09875b228 in main_loop_wait (nonblocking=0) at util/main-loop.c:518
>> #14 0x000055e0982c91f8 in qemu_main_loop () at softmmu/vl.c:1664
>> #15 0x000055e098162e7e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at softmmu/main.c:49
>>
>> so the problem may be in libusb but QEMU should not hang completely. The
>> host is Linux with libusb 1.0.22.
>
> Hmm, does reverting 76d0a9362c6a6a7d88aa18c84c4186c9107ecaef change
> behavior?

Yes it does. Reverting that patch fixes the problem, no hang and device 
reconnects without problem.

Thanks,
BALATON Zoltan

