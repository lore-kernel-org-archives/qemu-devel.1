Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B84C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1E820679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Y0clnCzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1E820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspVZ-00045M-Qu
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hspTZ-0000WH-Sb
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hspTY-0007Uk-RT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:21:09 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:38428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hspTW-0007SM-4g; Wed, 31 Jul 2019 10:21:06 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id F109996F50;
 Wed, 31 Jul 2019 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564582864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CIx9wnDk9ftdXlP6H4HNfr9G4iy0BtPVqZppcCvc0MM=;
 b=Y0clnCzheLnDW+uiXaKZNuswYUqvIC908J1hOp8ryf7/5J9v45yt09MKQJwh5loWuhwah6
 CWILtJ5Nzp4sqUk5+PsQU/TX9QzcUCU1vfDYXkxdOZrherX+EfReMFuYf6qu1auj3k8oiV
 EpuAeRyu6rGUdFmACcHI+mmu6lk5Lj4=
From: Damien Hedde <damien.hedde@greensocs.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <6ea54e80-63cd-5759-337b-1eb1686453f5@greensocs.com>
Date: Wed, 31 Jul 2019 16:21:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564582864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CIx9wnDk9ftdXlP6H4HNfr9G4iy0BtPVqZppcCvc0MM=;
 b=wJ0grTRADndZKLn8vEEkpRTuqgEcz9oiHc5v7uTVRAZHli41NYYMAmPN1kucZGyBOSa1g6
 UJZ8mVt7Okpi2Vj2zrZZWqgy2f1lDXqKw1HMdJtnWyXaLe+7qLUhMTronLUu/dudZXrSZa
 3g6SDsVQHvat8tJRkR+SfINVa7E/BDQ=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564582864; a=rsa-sha256; cv=none;
 b=MSvXQ8Qik1H1dtitCw+iFXeGmi49irVrFbnAqYD85AIJGRR4/bToVbM/07SjGBVcKaYqQM
 ef9LKrjSU1xZ11pLtUfO8vPiqQbYc9tAZI0Yj49e3wd6oJ8+CrQESuDRa7Pz1w2KPKn2SI
 R5Ei0RYvzD/8pBpfArLCFY7fz+YxhWo=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] RFC raspberry pi sd-card reset
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 f4bug@amsat.org, Andrew.Baumann@microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Concerning the reset on the raspi2/3 machine, I ran into an issue with
the sd-card.

Here follows a subset of the qbus/qdev tree of the raspi2&3 machine as
it is initialized:
 + System
   * bcm2835_gpio
     + sd-bus
       * sd-card
   * bcm2835-sdhost
     + bcm2835-sdhost-bus
   * generic-sdhci
     + sdhci-bus

raspi_init does 2 things:
 + it creates the soc
 + then it explicitly creates the sd-card on the bcm2835_gpio's sd-bus

As it happens, the reset moves the sd-card on another bus: the
sdhci-bus. More precisely the bcm2835_gpio reset method does it (the
sd-card can be mapped on bcm2835-sdhost-bus or sdhci-bus depending on
bcm2835_gpio registers, reset configuration corresponds to the sdhci-bus).

Reset call order is the following (it follows children-before-parent order):
 1 sd-card
 2 sd-bus
 3 bcm2835_gpio -> move the sd-card
 4 bcm2835-sdhost-bus
 5 bcm2835-sdhost
 6 sd-card  (again)
 7 sdhci-bus
 8 generic-sdhci

In the end, the sd-card is reset twice, which is no big-deal in itself.
But it only depends on the bcm2835_gpio tree being reset before the
generic-sdhci (probably depends on the machine creation code).

I checked and it seems this is the only platform where such things
happen during master reset.

IMO this is a bit hazardous because reset is based on the qdev/qbus
tree (and with the multi-phase I'm working on, even if it still works,
it's worse).
I'm not sure what we should do to avoid this (and if there's is
something to be done).

The easiest solution would be to initialize the platform with the
sd-card at the right initial place (I do not really understand why it is
created in the bcm2835_gpio in the first place since we move it just
after). But it won't solve the issue if a reset is done afterwards.

Or maybe we could move the sd-card on the proper bus in a machine
reset code so that it's on the right place when we do the sysbus tree
reset just after.

What do you think ?

--
Damien

