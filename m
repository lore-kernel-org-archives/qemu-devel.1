Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11198C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F06264E7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 07:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F06264E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWbla-0005ok-Tt
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 03:15:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWbkn-0005OT-Cc
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hWbkl-00022X-Uu
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:15:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hWbkl-00020t-OV
	for qemu-devel@nongnu.org; Fri, 31 May 2019 03:15:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id 16so900147wmg.5
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 00:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=Xp7S87pMWKfS+OxxYnRMTsJviwl5DIpY9EkqXcWozWc=;
	b=X5erxDYg2E7Q4Nhquwto5r3PK1V8NhrIGgRHp5wDwDfqYVrpXvrUBjICa1F8HwqABc
	oVPncITl3OWVImz6IR0Xy31EAvd9F1HmnRhmGVr9ZLtBJbnlQZfLerGp5/U+ITvEe1WC
	lDPcWnenVAMWtK7KwJ6klP/ne7SOgFA4YKkU5Biaq4eHBzAYHCFhYn3m7n7aEgp5fCEk
	oIyroJsjcrb9s1Rl9nR6i+Z3frqspzLPTOdIdHupaWoIlYy0/r0PDKqcmCHgiatcR7Fl
	N6O9WA/8HfyR8HAu1D1f1W+YpLxNpOZVmLitn7CYODjd+34D/nz1fnsx1kEsdtR4znU8
	bW3A==
X-Gm-Message-State: APjAAAW/1jIZhh8uE+wrZbS1SL7Zp/hSRcKXgiZWmupxxgdf10/fZPEN
	+tQrhWkUcuhYoiiJzfXethkfJQ==
X-Google-Smtp-Source: APXvYqxGVlPibScuUgCJpWh3SOj2zV+E53c8FkCZN4waV6xU3Ng3ZonnnIoJmqmWrmaKhNBQrMviOQ==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr4614676wmj.53.1559286902589; 
	Fri, 31 May 2019 00:15:02 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253])
	by smtp.gmail.com with ESMTPSA id t15sm5427218wmt.2.2019.05.31.00.15.01
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 00:15:02 -0700 (PDT)
Date: Fri, 31 May 2019 09:14:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190531071459.dy7wuszgmunnhsf3@steredhat.homenet.telecomitalia.it>
References: <20190530081055.9560-1-dplotnikov@virtuozzo.com>
	<20190530082646.ltwaew7jlaybumiv@steredhat.homenet.telecomitalia.it>
	<d4e62140-4b0d-a519-021a-a9bfd9b13eb9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4e62140-4b0d-a519-021a-a9bfd9b13eb9@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4] qemu-io: add pattern file
 for write command
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 06:21:13AM +0000, Denis Plotnikov wrote:
> 
> 
> On 30.05.2019 11:26, Stefano Garzarella wrote:
> > On Thu, May 30, 2019 at 11:10:55AM +0300, Denis Plotnikov wrote:
> >> The patch allows to provide a pattern file for write
> >> command. There was no similar ability before.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >> ---
> > 
> > Hi Denis,
> > for next versions I suggest to describe here, after the ---, the changes
> > with previous versions. In this way the review should be easier.
> ---
> Sure
> > 
> >>   qemu-io-cmds.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++----
> >>   1 file changed, 75 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> >> index 09750a23ce..1c6a5e4faf 100644
> >> --- a/qemu-io-cmds.c
> >> +++ b/qemu-io-cmds.c
> >> @@ -21,6 +21,7 @@
> >>   #include "qemu/option.h"
> >>   #include "qemu/timer.h"
> >>   #include "qemu/cutils.h"
> >> +#include "string.h"
> >>   
> >>   #define CMD_NOFILE_OK   0x01
> >>   
> >> @@ -343,6 +344,61 @@ static void *qemu_io_alloc(BlockBackend *blk, size_t len, int pattern)
> >>       return buf;
> >>   }
> >>   
> >> +static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
> >> +                                     char *file_name)
> >> +{
> >> +    char *buf, *buf_pos;
> >> +    FILE *f = fopen(file_name, "r");
> >> +    int l;
> >> +
> >> +    if (!f) {
> >> +        printf("'%s': %s\n", file_name, strerror(errno));
> >> +        return NULL;
> >> +    }
> >> +
> >> +    if (qemuio_misalign) {
> >> +        len += MISALIGN_OFFSET;
> >> +    }
> >> +    buf = blk_blockalign(blk, len);
> >> +    memset(buf, 0, len);
> >> +
> >> +    buf_pos = buf;
> >> +
> >> +    while (len > 0) {
> >> +        l = fread(buf_pos, sizeof(char), len, f);
> >> +
> >> +        if (feof(f)) {
> >> +            rewind(f);
> >> +        }
> >> +
> >> +        if (ferror(f)) {
> >> +            printf("'%s': %s\n", file_name, strerror(errno));
> >> +            goto error;
> >> +        }
> >> +
> >> +        if (l == 0) {
> >> +            printf("'%s' is empty\n", file_name);
> >> +            goto error;
> >> +        }
> > 
> > Could it happen that we read some bytes, than we reached the EOF, so we made
> > the rewind() and fread() returns 0?
> > If that can happen, maybe we should change it in this way:
> > 
> >          if (l == 0 && buf_pos == buf) {
> >              printf("'%s' is empty\n", file_name);
> >              goto error;
> >          }
> This shouldn't happen. To get that situation we need to read exactly the 
> file length (from the current position to the end) on the first step, 
> then rewind, read again and in that case get l == 0 and feof == true. 
> But reading the exact length means that we asked for that size, so the 
> buffer is fully populated, thus len == 0 and we leave the loop.
> 
> So, l == 0 is only when we read an empty file on the first iteration.
> 

Right!

> >> @@ -983,8 +1039,9 @@ static int write_f(BlockBackend *blk, int argc, char **argv)
> >>      /* Some compilers get confused and warn if this is not initialized.  */
> >>      int64_t total = 0;
> >>      int pattern = 0xcd;
> >> +    char *file_name;

I think we should initialize file_name to NULL here to silent the compiler.
I applied this patch and I had this error:
/home/stefano/repos/qemu/qemu-io-cmds.c: In function ‘write_f’:
/home/stefano/repos/qemu/qemu-io-cmds.c:351:15: error: ‘file_name’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     FILE *f = fopen(file_name, "r");
               ^~~~~~~~~~~~~~~~~~~~~
/home/stefano/repos/qemu/qemu-io-cmds.c:1042:11: note: ‘file_name’ was declared here
     char *file_name;
           ^~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/home/stefano/repos/qemu/rules.mak:69: qemu-io-cmds.o] Error 1
make: *** Waiting for unfinished jobs....

Thanks,
Stefano

