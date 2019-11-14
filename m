Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A0FC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127ED206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127ED206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFAW-0004Lv-83
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1iVF9Y-0003r6-4L
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1iVF9X-00015P-8r
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:27:16 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:54515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1iVF9W-00014m-VQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:27:15 -0500
X-IronPort-AV: E=Sophos;i="5.68,304,1569276000"; d="scan'208";a="326720212"
Received: from unknown (HELO function) ([193.50.111.121])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384;
 14 Nov 2019 14:27:12 +0100
Received: from samy by function with local (Exim 4.92.3)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1iVF9U-000XvN-42; Thu, 14 Nov 2019 14:27:12 +0100
Date: Thu, 14 Nov 2019 14:27:12 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Teemu Kuusisto <teemu.kuusisto@gmail.com>
Subject: Re: Braille device (chardev/baum.c) is unable to detect the TTY
 correctly and does not act on graphic console connect/disconnect
Message-ID: <20191114132712.rpqzq7jvl32beduu@function>
References: <20191114120915.GA31365@valhalla>
 <20191114130841.kxgorkvtinyaahdm@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114130841.kxgorkvtinyaahdm@function>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.134.164.104
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

Samuel Thibault, le jeu. 14 nov. 2019 14:08:41 +0100, a ecrit:
> The way to properly fix it is to add a brlapi channel to spice:

And that would be workable through a spice agent as well, so that
braille management from orca running inside the guest could talk
directly through to brltty running on the host instead of having to go
through the emulation layers.

Samuel

