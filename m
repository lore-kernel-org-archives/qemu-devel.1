Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A54C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4C1217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4C1217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50448 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4mZ-0004No-Jf
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:38:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hU4lj-0003zb-Tn
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hU4lj-0002I9-2g
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:37:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hU4li-0002HX-Q9
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:37:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so8235383wmb.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 00:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=6k5jJio9kFUXyobHJAepZdqEKvTtZc78YOjQ/twkC/Y=;
	b=KS8God+jpocE2fo2Oo/ldWvdc9o21ljOySUhiiaudfL4kLSkm32GfPsw7YPt5T/27Y
	jXXytEO9HUIATOtDJtJzyuerDWHT+SCz5eZOzMTWuKuWoDyaYln6g6cSNgP0UmDnHOve
	F9qYiYdHMOiP4Hhf6hU0zbqetnZ98yBT0f1lyi1O7SwKProtd/bHwh27vFRAPHhnKH9+
	2zJPVr92zguoW/Wvpu2fJ/6f7QoMvMxi27A1EHae3hLP8vp4hU8gFJhSyX1mZ6jVeCdg
	E5CmexV5P3zkRQ/CP4tgQWLKgroU8UkI6ss9DtaJr+1wGwVdfaM2PMfuaux14qWs0ehQ
	sTcg==
X-Gm-Message-State: APjAAAUWdGWwvFZ22CsjAEQfMSIjInq44IrwT/HJCDMPd7s2RMtt5AFJ
	he9AeQRWmqpYftTAZbTgW8FZTw==
X-Google-Smtp-Source: APXvYqzrtrzidUSOW384wAZyCZk+q9IPmEaFWKeij6gaM8L+eEl/VHA7WDDvKB9p8DwhvQHZV50ANA==
X-Received: by 2002:a1c:8004:: with SMTP id b4mr15083157wmd.79.1558683453727; 
	Fri, 24 May 2019 00:37:33 -0700 (PDT)
Received: from steredhat (host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253])
	by smtp.gmail.com with ESMTPSA id d26sm1520600wmb.4.2019.05.24.00.37.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 00:37:33 -0700 (PDT)
Date: Fri, 24 May 2019 09:37:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190524073730.u2oimsx3ftxi3ozq@steredhat>
References: <20190523152250.106717-1-sgarzare@redhat.com>
	<20190523152250.106717-4-sgarzare@redhat.com>
	<87y32xgmd5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y32xgmd5.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 3/3] block/gluster: update .help of
 BLOCK_OPT_PREALLOC option
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
	qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 06:35:18PM +0200, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > Show 'falloc' and 'full' among the allowed values of
> > 'preallocation' option, only when they are supported
> > ('falloc' is support if defined CONFIG_GLUSTERFS_FALLOCATE,
> > 'full' is support if defined CONFIG_GLUSTERFS_ZEROFILL)
> 
> You could mention that 'falloc' is missing before the patch.
> 

I'll fix the commit message.

> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  block/gluster.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/gluster.c b/block/gluster.c
> > index e664ca4462..682fe49912 100644
> > --- a/block/gluster.c
> > +++ b/block/gluster.c
> > @@ -97,7 +97,14 @@ static QemuOptsList qemu_gluster_create_opts = {
> >          {
> >              .name = BLOCK_OPT_PREALLOC,
> >              .type = QEMU_OPT_STRING,
> > -            .help = "Preallocation mode (allowed values: off, full)"
> > +            .help = "Preallocation mode (allowed values: off"
> > +#ifdef CONFIG_GLUSTERFS_FALLOCATE
> > +                    ", falloc"
> > +#endif
> > +#ifdef CONFIG_GLUSTERFS_ZEROFILL
> > +                    ", full"
> > +#endif
> > +                    ")"
> >          },
> >          {
> >              .name = GLUSTER_OPT_DEBUG,
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks,
Stefano

