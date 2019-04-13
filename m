Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257D2C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 15:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E5620818
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 15:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E5620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=durchholz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFKZh-0002Ec-36
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 11:28:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFKYt-0001vM-HE
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFKYr-0005oY-Ex
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:27:23 -0400
Received: from 5.itsy.de ([188.40.84.14]:44206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jo@durchholz.org>) id 1hFKYo-0005j6-FG
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 11:27:19 -0400
Received: from [192.168.178.32] (unknown [195.48.33.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 5.itsy.de (Postfix) with ESMTPSA id 9AA14658AE
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 17:27:14 +0200 (CEST)
To: qemu-devel@nongnu.org
From: Joachim Durchholz <jo@durchholz.org>
Message-ID: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
Date: Sat, 13 Apr 2019 17:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.40.84.14
Subject: [Qemu-devel] How to I trigger a rebuild?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413152714.Vn1zkmkxgXUj2KUQQwKalA_eG8se4vBM-gWS1vOXihQ@z>

Hi all,

I did the usual ./configure; make dance.
Then modified a source file (ui/curses.c), called make again, but didn't 
see curses.c recompiled, and the change was indeed ineffective.
make clean; make didn't help either.

Is there a list of make targets anywhere?
I looked in a few places in the source directories but nothing presented 
itself.

Regards,
Jo

