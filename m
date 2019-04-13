Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6A7C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 09:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D4820850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 09:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D4820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=durchholz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFEZK-00083Z-1O
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 05:03:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFEYL-0007kS-C7
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 05:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFEYK-0004JI-Ax
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 05:02:25 -0400
Received: from 5.itsy.de ([188.40.84.14]:60851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jo@durchholz.org>) id 1hFEYK-0004HV-08
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 05:02:24 -0400
Received: from [192.168.178.32] (unknown [195.48.33.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 5.itsy.de (Postfix) with ESMTPSA id 1CB6C65763
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 11:02:21 +0200 (CEST)
To: qemu-devel@nongnu.org
From: Joachim Durchholz <jo@durchholz.org>
Message-ID: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
Date: Sat, 13 Apr 2019 11:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.40.84.14
Subject: [Qemu-devel] curses.c: "We need a terminal output" ?
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
Message-ID: <20190413090220.zy7dc8ajuTaZpLizfbS5yCca2p7UI99Lhqckr40GXYo@z>

Hi all,

what's the reasoning behind "We need a terminal output" in curses.c?

I don't really see a scenario where it's problematic if qemu emits 
escape sequences to a pipe.
I have experienced one scenario where it is problematic: It doesn't work 
properly with pexpect and expectit (a Python and a Java library that do 
expect). I suspect they fail to use a pty, but then I see no harm in not 
doing so.
I can see another scenario when this is problematic: Unit testing code 
that directly writes to the console. E.g. testing BIOS code, or testing 
operating systems when using the serial port is not an option.

Regards,
Jo

