Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4BCC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 03:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6822087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 03:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nanotek.info header.i=@nanotek.info header.b="DbuETvOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6822087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nanotek.info
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQNYc-0006EF-AC
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 23:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36070 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shiftag@nanotek.info>) id 1jQNY4-0005nd-W9
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 23:56:45 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <shiftag@nanotek.info>) id 1jQNY4-0004kd-Hg
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 23:56:44 -0400
Received: from mail.nanotek.info ([188.166.13.56]:48824)
 by eggs1p.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shiftag@nanotek.info>) id 1jQNY3-0004hA-RV
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 23:56:44 -0400
Received: from ousire.calculus.lan (unknown [185.107.80.152])
 by mail.nanotek.info (Postfix) with ESMTPSA id CB7A36037B
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 05:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nanotek.info;
 s=default; t=1587354467;
 bh=hqTwvYOq0VDKehf9cW5Y8seWf+AIwFG/cCjwu3+X9cg=;
 h=To:From:Subject:Date:From;
 b=DbuETvOzakuP+9P53cH/ZGYRyJNlI3uq6WYekTxqkXWpVu8KPmi+HOHNU0c2uU2kF
 zRlayFGFBFFrTtFSjWki1R0FdWwnc2Hy9nk/Z1m7C1qAEhpx5EgOsjX6bqt4AjnMyy
 QmQ5y0WufplV8igKdPPMDBfWk2zAsqPRWYvftrRk=
To: qemu-devel@nongnu.org
From: shiftag <shiftag@nanotek.info>
Subject: qemu-img from qemu-4.2.0 load the wrong nettle dependency
Message-ID: <2d5da469-abde-400e-cf6f-0af939052bee@nanotek.info>
Date: Mon, 20 Apr 2020 07:56:37 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=188.166.13.56; envelope-from=shiftag@nanotek.info;
 helo=mail.nanotek.info
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/19
 23:56:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 188.166.13.56
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

Hi,

I built qemu-4.2.0 from source in order to link it with my system
libnettle library. Below some information :

$ pkg-config --modversion nettle
3.5.1

$ find /usr -name 'libnettle*' -type f
/usr/lib64/libnettle.so.7.0

When executing qemu-img, I have the following error :

$ qemu-img
qemu-img: error while loading shared libraries: libnettle.so.6: cannot
open shared object file: No such file or directory

So it look like qemu-img was not built using my system libnettle.

An idea about how to fix this ?


