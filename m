Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4605C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83F22075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83F22075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWgH-0006iZ-SN
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1ipWfb-0006GR-Kv
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1ipWfY-0007B4-UP
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:12:09 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57116)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1ipWfY-00078e-9M
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:12:08 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id A4D67A2201;
 Thu,  9 Jan 2020 15:12:04 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Kevin Wolf'" <kwolf@redhat.com>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
 <003a01d5c6b3$df62afd0$9e280f70$@ru> <20200109120038.GD9504@linux.fritz.box>
In-Reply-To: <20200109120038.GD9504@linux.fritz.box>
Subject: RE: [for-5.0 PATCH 00/11] Support for reverse debugging with GDB
Date: Thu, 9 Jan 2020 15:12:04 +0300
Message-ID: <003e01d5c6e6$01ff6470$05fe2d50$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdXG5HLoayuvUd2ESTGfyItaM1MvZgAAYZ0A
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 alex.bennee@linaro.org, 'Pavel Dovgalyuk' <pavel.dovgaluk@gmail.com>,
 maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
 boost.lists@gmail.com, thomas.dullien@googlemail.com, pbonzini@redhat.com,
 mreitz@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 09.01.2020 um 07:13 hat Pavel Dovgalyuk geschrieben:
> > Ping.
> 
> I think you have my Acked-by for the block-related patches in this
> series now. If I missed something, please let me know.

Thank you.

Pavel Dovgalyuk


