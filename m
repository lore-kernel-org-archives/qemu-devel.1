Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A33C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 17:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D7320657
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 17:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D7320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUwcI-0002D1-EE
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 13:07:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1hUwad-00010d-9T
	for qemu-devel@nongnu.org; Sun, 26 May 2019 13:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1hUwVM-00059w-IF
	for qemu-devel@nongnu.org; Sun, 26 May 2019 13:00:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>)
	id 1hUwVM-00059E-5V; Sun, 26 May 2019 13:00:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so14512444wrq.12;
	Sun, 26 May 2019 10:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7q5YvfkXAo/8pm66hs8SqX8dlCLic+UAAQlf98ognZE=;
	b=cDzpa96TLsczsbbza9DBSG1rRsyIqen/ulvREO4MxQVSJUdwsJBLDMXasWhP8RklO4
	+E4BkBVRbCl8HSZ2XKULz0Ku2B6g/SQoRD6ZkM2XLAppqSwEp9rfYEsWB86TPEovzDK1
	12PTdKcNVZM0+JL1t+DBn564Ano0HtNw6T5scwVTNdUSyNbwVlf+ZMGdhsblFXQYOnC4
	fLlHrK9QoJUoru3akIgxoA0FJ1R08aSj6pNzfvBbVZQS+qB9fAD8oCd/e4wXHzgZgKnl
	s8LHz3418Kme2Bd/GjdlE8kd5xedstYUzq0QWmGnPbxX1Ab//ZTBP2aBUqEqINWPPpt4
	9BXw==
X-Gm-Message-State: APjAAAW+77b5y7jcNqgfOBP+5sHuVhzCu0BFUqVg5VNsyWJ6cPZGYivZ
	rd3WG+2ljR5sk6q5WSR9lbs=
X-Google-Smtp-Source: APXvYqxexwx9L9ACYh6gH+XNr/qMSmNZH3wscK27ejIhWezWlbtuLymI4J7VhJz/0NYYwQiGQDVPeA==
X-Received: by 2002:a5d:5504:: with SMTP id b4mr54355038wrv.251.1558890014982; 
	Sun, 26 May 2019 10:00:14 -0700 (PDT)
Received: from thl530.multi.box (pD9E8362E.dip0.t-ipconnect.de.
	[217.232.54.46]) by smtp.gmail.com with ESMTPSA id
	z16sm5807180wmk.36.2019.05.26.10.00.12
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 26 May 2019 10:00:13 -0700 (PDT)
Date: Sun, 26 May 2019 19:00:11 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190526190011.361380e5@thl530.multi.box>
In-Reply-To: <20190525225013.13916-11-laurent@vivier.eu>
References: <20190525225013.13916-1-laurent@vivier.eu>
	<20190525225013.13916-11-laurent@vivier.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v7 10/10] hw/m68k: define Macintosh Quadra
 800
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau
	<marcandre.lureau@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Sun, 26 May 2019 00:50:13 +0200
schrieb Laurent Vivier <laurent@vivier.eu>:

> If you want to test the machine, it doesn't yet boot a MacROM, but
> you can boot a linux kernel from the command line.
> 
> You can install your own disk using debian-installer with:
> 
>     ./qemu-system-m68k \
>     -M q800 \
>     -serial none -serial mon:stdio \
>     -m 1000M -drive file=m68k.qcow2,format=qcow2 \
>     -net nic,model=dp83932,addr=09:00:07:12:34:57 \
>     -append "console=ttyS0 vga=off" \
>     -kernel vmlinux-4.15.0-2-m68k \
>     -initrd initrd.gz \
>     -drive file=debian-9.0-m68k-NETINST-1.iso \
>     -drive file=m68k.qcow2,format=qcow2 \
>     -nographic
> 
> If you use a graphic adapter instead of "-nographic", you can use
> "-g" to set the size of the display (I use "-g 1600x800x24").
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  MAINTAINERS                      |  14 ++
>  default-configs/m68k-softmmu.mak |   1 +
>  hw/m68k/Kconfig                  |  12 +
>  hw/m68k/Makefile.objs            |   1 +
>  hw/m68k/bootinfo.h               | 100 +++++++++
>  hw/m68k/q800.c                   | 369
> +++++++++++++++++++++++++++++++ 6 files changed, 497 insertions(+)
>  create mode 100644 hw/m68k/bootinfo.h
>  create mode 100644 hw/m68k/q800.c
[...]
> diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
> new file mode 100644
> index 0000000000..6584775f6d
> --- /dev/null
> +++ b/hw/m68k/bootinfo.h
> @@ -0,0 +1,100 @@
> +struct bi_record {
> +    uint16_t tag;        /* tag ID */
> +    uint16_t size;       /* size of record */
> +    uint32_t data[0];    /* data */
> +};

Maybe add a short description, license information and header guards at
the top of the file?

Apart from that, the patch looks sane to me.

 Thomas

