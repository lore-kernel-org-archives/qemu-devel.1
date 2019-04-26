Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0ACC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 08:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACAA2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 08:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACAA2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJvwI-000859-UG
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 04:10:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hJvvC-0007av-Mr
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hJvvB-0005ai-I3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:09:26 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1hJvvB-0005Wq-CK
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 04:09:25 -0400
Received: from localhost.localdomain (prva10-snat226-2.provo.novell.com
	[137.65.226.36])
	by smtp2.provo.novell.com with ESMTP (TLS encrypted);
	Fri, 26 Apr 2019 02:09:17 -0600
From: Lin Ma <lma@suse.com>
To: qemu-devel@nongnu.org
Message-ID: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
Date: Fri, 26 Apr 2019 16:09:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 137.65.250.81
Subject: [Qemu-devel] About pt-br keyboard layout
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
Cc: kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426080912.IMpU5q_jJuMhw6l0Iw2mz41bo3yOyhKTwwGB95TfCcA@z>

Hi all,

While I launch qemu with vnc + pt-br keyboard layout on my pc, If I type 
shift + 6 in iPXE shell or grub shell via my usual 105-key keyboard,
shift + 6 would be mapped to "(apostrophe), But IIUC the correct 
character should be ¨(diaeresis) in pt-br layout.

I'm wondering that is it the expected behavior? In other words, Does it 
make sense if I want to type multi-character characters(say Ç or ¨) 
without guest os's help?



About pt-br keyboard (ABNT2), please refer to:
http://www.cjdinfo.com.br/utilitario-tabela-caracteres
https://docs.microsoft.com/en-us/globalization/keyboards/kbdbr_2.html


Any feedback would be appreciated,
Lin

