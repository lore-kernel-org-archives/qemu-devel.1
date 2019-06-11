Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB06C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322E020866
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aIIur25j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cta0xmu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322E020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajd4-000585-AJ
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37238)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mojha@codeaurora.org>) id 1haj43-00050g-PT
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mojha@codeaurora.org>) id 1haj3z-00024f-Qm
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:51:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mojha@codeaurora.org>)
 id 1haj3w-0001zO-MA
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:51:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 42944602F3; Tue, 11 Jun 2019 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1560268302;
 bh=P+6TqFuJT2bY8s954ypY4z0WYk/DOnDDVQJjEfruBrQ=;
 h=To:From:Subject:Date:From;
 b=aIIur25jqLZSVlvcpzYHLF894ROhBZDN4QCSkMfVfYyD9meiHGSr8x9EROS63Bz3i
 HiYZ8OES7TBgNLLDK119sFibK604rMmLobXgIflBWyLydEXCnCToQHWPwpTruhmwc2
 Ju5YcjLqDObTMME2kHmbdVbtUD0sZrqbiiUc5NyA=
Received: from [10.204.79.15]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E8A216019D
 for <qemu-devel@nongnu.org.>; Tue, 11 Jun 2019 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1560268302;
 bh=P+6TqFuJT2bY8s954ypY4z0WYk/DOnDDVQJjEfruBrQ=;
 h=To:From:Subject:Date:From;
 b=Cta0xmu5xGD4TX9FChPEjDksAqkOZOm7FDXDso6GjKBZ4SfZRfZqetAcs4XvZjsAv
 G4YpBme8dMLYnj8MPxlMYi+R6jDHBS3TxWbr49ik8gQfgL67JVwShmSoI0fHJDSl0I
 P4UChTXplf4C1TlEcS8F5+p5+bbgb/jfhOuxHYOE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8A216019D
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
To: qemu-devel@nongnu.org
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <bb7caa03-8a3a-7a17-7624-ed361dd97612@codeaurora.org>
Date: Tue, 11 Jun 2019 21:21:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.96
X-Mailman-Approved-At: Tue, 11 Jun 2019 12:01:58 -0400
Subject: [Qemu-devel] Qemu: Scroll up in qemu
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

How can we scroll up in the console in qemu=C2=A0 ?

/local/mnt/workspace/mojha/qemu/qemu.git/x86_64-softmmu/qemu-system-x86_6=
4=20
-kernel /local/mnt/workspace/mojha/linux/arch/x86/boot/bzImage
-initrd /local/mnt/workspace/mojha/buildroot/output/images/rootfs.cpio=20
-append "resume=3D/dev/sda console=3DttyAMA0,115200 console=3Dtty console=
=3DttyS0"
-smp 4 -drive format=3Draw,file=3Dubuntu.img -nographic -curses


Thanks,
Mukesh


