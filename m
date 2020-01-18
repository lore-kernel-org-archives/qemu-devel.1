Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E73C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 22:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61642469D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 22:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61642469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iswmy-00030A-So
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 17:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iswmO-0002aw-Do
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 17:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iswmM-00028V-UF
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 17:41:19 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:48308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iswmM-00022D-ON
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 17:41:18 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 67AB97482CC;
 Sat, 18 Jan 2020 23:41:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4F1AB7482CB; Sat, 18 Jan 2020 23:41:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4D9CD7475F6;
 Sat, 18 Jan 2020 23:41:09 +0100 (CET)
Date: Sat, 18 Jan 2020 23:41:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
Subject: Commit 3e7fb5811b or something in that series breaks build?
Message-ID: <alpine.BSF.2.21.99999.352.2001182314430.68247@zero.eik.bme.hu>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I'm getting errors about missing headers in qapi/* and build fails on 
current master.

I've tried bisecting it which lead to commit 3e7fb5811b where I get:

   CC      qapi/qapi-types-audio.o
cc: error: qapi/qapi-types-audio.c: No such file or directory
cc: fatal error: no input files

(This is with --audio-drv-list=alsa configure option and in-tree build in 
case that matters.)

Reverting that commit alone does not fix build on master I had to revert 
both 3bef3aaec9 and 3e7fb5811b

Regards,
BALATON Zoltan

