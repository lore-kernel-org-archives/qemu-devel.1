Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14942C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF4D2077B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF4D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zEA-0003dY-1p
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 10:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <poletaev@ispras.ru>) id 1i2ypr-00019F-5O
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <poletaev@ispras.ru>) id 1i2ypl-0007uB-Uw
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:22:06 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39944)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <poletaev@ispras.ru>) id 1i2ypl-0007t5-OH
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:22:01 -0400
Received: from rainloop.ispras.ru (mail2.ispras.ru [83.149.199.43])
 by mail.ispras.ru (Postfix) with ESMTPS id 478FB54006A
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 17:21:58 +0300 (MSK)
Mime-Version: 1.0
Date: Wed, 28 Aug 2019 14:21:58 +0000
Message-ID: <51deeefdf33168ff11234ffd96ee646d@rainloop.ispras.ru>
X-Mailer: RainLoop/1.9.2.343
From: poletaev@ispras.ru
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
X-Mailman-Approved-At: Wed, 28 Aug 2019 10:46:19 -0400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Can not read SMI handler code with cpu_memory_rw_debug
 while in SMM
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

I am using OVMF2018 (https://github.com/tianocore/tianocore.github.io/wik=
i/OVMF) build with smm functionality. Run qemu with "-machine smm=3Don" o=
ption.=0AWhen SMI handler starts working,=C2=A0cpu_memory_rw_debug() func=
tion reads from tseg_blackhole device mem and function returns ffff... in=
stead of actual data.=0ASame situation when using remote gdb debugging, g=
uess because=C2=A0cpu_memory_rw_debug() is in use also.=0ABut code of SMI=
 handler executes normally, so cpu can access actual data and not tseg_bl=
ackhole.=0A=0ACan anybody explain please, what is the difference in this =
context between, for example,=C2=A0x86_ldub_code() and=C2=A0=C2=A0cpu_mem=
ory_rw_debug()?=0AIs such behavior=C2=A0intended? (guess no)=0AWhat is ts=
eg at all? I can't find similar terminology in intel manuals.
