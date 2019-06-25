Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BFFC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FDF208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 14:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FDF208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfmrg-0001Uh-V6
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 10:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50513)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hfmjF-0005Ni-Ux
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hfmjD-000880-1D
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:47:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hfmjA-00084M-L6
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:47:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so3143621wms.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 07:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=f29OXgzObWKmch49Da0RFamZ2zfhq4D4gpvDqbKtncA=;
 b=c95MIjC5HDc2SDB8igOCS370jnb8qk62Bwycsoc7CMtQHayYwAPHI5jzmx4qxoYTyC
 I3+DI0MbVcO1DQlzM20GZtOmpBUCeWlRzLNtZJRNmBBfV+ONCNqSWJrH1xbbIYJPJRus
 DBleoq4+zkD9yl7eC7xpdJcRZdICLE7kjUW4flFDGVHln8eUyZgVq1raed1bhX9LzZ2O
 KPoV6d8gl/M60skAdiydhLM9syFoSu/EXBVUVyp7cQLJF7ydt0j7zhWQC7KoOKaofakO
 62HTEtdPUTKUfBlU0aWX/yRyPD+8JJ9h9emdaKdUpDAp6TjBXUglMBIQffMlKQRE2aK3
 ESVQ==
X-Gm-Message-State: APjAAAUly32pzpKQU2OEbEud4uaoDzm54Vp99sLYAmytWudmscFjm77b
 N23Ql0XdOMZsjnK8ZoEqKXiWpA==
X-Google-Smtp-Source: APXvYqxmhLhP/gpD0EFpaKKz9Xz4uw9I+45F+7vQfhvQpulGw9e9X3yvX89+O/yyxRJW9dQX7413Gw==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr14226833wmi.142.1561474039158; 
 Tue, 25 Jun 2019 07:47:19 -0700 (PDT)
Received: from steredhat (host21-207-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.207.21])
 by smtp.gmail.com with ESMTPSA id z6sm14037357wrw.2.2019.06.25.07.47.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 07:47:18 -0700 (PDT)
Date: Tue, 25 Jun 2019 16:47:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190625144710.xvlwcqcbp5bipbku@steredhat>
References: <20190509145927.293369-1-sgarzare@redhat.com>
 <7a3e37bd-dd24-a97f-5354-7793df44c53e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a3e37bd-dd24-a97f-5354-7793df44c53e@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: increase dynamically the
 image size
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 Jason Dillaman <jdillama@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 04:02:04PM +0200, Max Reitz wrote:
> On 09.05.19 16:59, Stefano Garzarella wrote:
> > RBD APIs don't allow us to write more than the size set with
> > rbd_create() or rbd_resize().
> > In order to support growing images (eg. qcow2), we resize the
> > image before write operations that exceed the current size.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v3:
> >   - add 'image_size' field in the BDRVRBDState to keep track of the
> >     current size of the RBD image [Jason, Kevin]
> > ---
> >  block/rbd.c | 42 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 39 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..b0355a2ce0 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> 
> [...]
> 
> > @@ -833,6 +842,22 @@ static void qemu_rbd_close(BlockDriverState *bs)
> >      rados_shutdown(s->cluster);
> >  }
> >  
> > +/* Resize the RBD image and update the 'image_size' with the current size */
> > +static int qemu_rbd_resize(BlockDriverState *bs, uint64_t size)
> > +{
> > +    BDRVRBDState *s = bs->opaque;
> > +    int r;
> > +
> > +    r = rbd_resize(s->image, size);
> > +    if (r < 0) {
> > +        return r;
> > +    }
> > +
> > +    s->image_size = size;
> 
> I think this should update bs->total_sectors, too.  In fact, I’m
> wondering why you don’t just use bs->total_sectors (or bdrv_getlength(),
> which returns bs->total_sectors * 512) instead of adding this new field?
> 

Hi Max,
thanks for taking a look!

I used bs->total_sectors in the v2, but Jason pointed out a possible
issue with this, so I proposed to add a variable in the BDRVRBDState to
track the latest resize and Kevin acked [1].

IIUC what Kevin said on his comment, the 'bs->total_sectors' should be
updated by bdrv_co_write_req_finish(), for this reason I didn't update
it.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg615195.html

Thanks,
Stefano

