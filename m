Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C61CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 10:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1299121D81
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 10:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="Uqh94ehR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1299121D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRZfO-0001XN-3A
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 05:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1iRZeN-00011y-6o
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iRZeL-0004c3-68
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:31:55 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:54140)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <geoff@hostfission.com>) id 1iRZeJ-0004Zk-HE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 05:31:52 -0500
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id 903114BBD9;
 Mon,  4 Nov 2019 21:31:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1572863507;
 bh=cxQ+0qmzBe83UvRQrJx3+5vRL/vfqs31vodGFW1rj5c=;
 h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
 b=Uqh94ehR5dfePnFYWiSYISwjxLt8apZu8cQ3wNs2Uvl2wqC8XamLo/9MT8mJXbZLC
 TCokqhkCM5w397nN+sqj6twvJI4OMktQUOuXllEAUj65RClxU1YepizIGkKbx740UV
 uc7T48ST4Wzvfzu1O1CpHEdMO8kAFDHXzOGu2zsc=
Received: by www1.hostfission.com (Postfix, from userid 1000)
 id 8876280CC2; Mon,  4 Nov 2019 21:31:47 +1100 (AEDT)
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: RFC: New device for zero-copy VM memory access
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Nov 2019 21:31:47 +1100
From: geoff@hostfission.com
Cc: qemu-devel@nongnu.org
In-Reply-To: <20191104102656.caomxar3xbv2wd5n@sirius.home.kraxel.org>
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <20191104102656.caomxar3xbv2wd5n@sirius.home.kraxel.org>
Message-ID: <3296a09c5696d746b8295912892c4265@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.2.3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 139.99.139.48
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019-11-04 21:26, Gerd Hoffmann wrote:
> Hi,
> 
>> This new device, currently named `introspection` (which needs a more
>> suitable name, porthole perhaps?), provides a means of translating
>> guest physical addresses to host virtual addresses, and finally to the
>> host offsets in RAM for file-backed memory guests. It does this by
>> means of a simple protocol over a unix socket (chardev) which is
>> supplied the appropriate fd for the VM's system RAM. The guest (in
>> this case, Windows), when presented with the address of a userspace
>> buffer and size, will mlock the appropriate pages into RAM and pass
>> guest physical addresses to the virtual device.
> 
> So, if I understand things correctly, the workflow looks like this:
> 
>   (1) guest allocates buffers, using guest ram.
>   (2) guest uses these buffers as render target for the gpu
> (pci-assigned I guess?).
>   (3) guest passes guest physical address to qemu (via porthole 
> device).
>   (4) qemu translates gpa into file offset and passes offsets to
>       the client application.
>   (5) client application maps all guest ram, then uses the offsets from
>       qemu to find the buffers.  Then goes displaying these buffers I 
> guess.
> 
> Correct?

Correct, however step 5 might be a proxy to copy the buffers into 
another
porthole device in a second VM allowing VM->VM transfers.

> 
> Performance aside for now, is it an option for your use case to simply
> use both an emulated display device and the assigned gpu, then 
> configure
> screen mirroring inside the guest to get the guest display scanned out
> to the host?

Unfortunately no, NVidia and AMD devices do not support mirroring their
outputs to a separate GPU unless it's a professional-grade GPU such as a
Quadro or Firepro.

-Geoff

> 
> cheers,
>   Gerd

