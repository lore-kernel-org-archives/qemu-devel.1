Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946E1C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6642F214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6642F214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmvvp-0005AA-BH
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 04:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hmvve-0004m0-N0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hmvvc-0004Zc-Op
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:01:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hmvvb-0004Xy-Ov
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:01:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so14135619wml.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 01:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=cpz6DNitm9oJtQHxBO9E2ulCRcfeE6mdPD9kHIHajXQ=;
 b=bhVWpFfvJIk65QemySEzZ6jMs7sGKEF5Vr38pA/XkmoqDOqvPpZsn00NXXsatV8fqf
 lzK+suMa1yBvt+nZqbZPe+uN7JiyivUgKCZbxlc0JmlmG6DjAXyP44Sp8+ZEgh+3wobh
 EXxvXppk6wyhyXsZ3ijkPJULXH1rZv7lzn7tFaR1runK7iI9qVDQSYbagoOhzNOzNb2p
 /H41tB02WykMnBl0M3VMOwbugJ+jOmpdI/EAYlnspwe1TJzeY7FK7ZKRVMb6nZWwffTr
 9LE3GxRCbFbhq5tVyoK9zt2B9WKMPcX0vCFB+Pg3fSm9/P++kQKjyfVPAuYDEzA2GWMn
 7ieA==
X-Gm-Message-State: APjAAAW+28a7wKZVtx+bsngjZiyjH8OmF5Em4lw2vR8upo+JwtiuPp22
 XTfdDF1iD6yFwFI02PWwWUc/pg==
X-Google-Smtp-Source: APXvYqxwnn3BGnN7EsN3Ob0z96MjwQ+XjpfTKd3K4KBeyXHZqKXv8K0Ml6pAw7os0TtnIGq0A3pcNg==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr23663404wma.120.1563177701651; 
 Mon, 15 Jul 2019 01:01:41 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id u1sm15741583wml.14.2019.07.15.01.01.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 01:01:41 -0700 (PDT)
Date: Mon, 15 Jul 2019 10:01:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190715080138.lwuszn5vefyp6qig@steredhat>
References: <20190711132935.13070-1-mreitz@redhat.com>
 <20190712102735.ea5f4aqqgok7qdxa@steredhat>
 <b77578d8-3da7-e0c7-75db-69f078cfcbda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b77578d8-3da7-e0c7-75db-69f078cfcbda@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] doc: Preallocation does not
 require writing zeroes
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 08:33:14PM +0200, Max Reitz wrote:
> On 12.07.19 12:27, Stefano Garzarella wrote:
> > On Thu, Jul 11, 2019 at 03:29:35PM +0200, Max Reitz wrote:
> >> When preallocating an encrypted qcow2 image, it just lets the protocol
> >> driver write data and then does not mark the clusters as zero.
> >> Therefore, reading this image will yield effectively random data.
> >>
> >> As such, we have not fulfilled the promise of always writing zeroes when
> >> preallocating an image in a while.  It seems that nobody has really
> >> cared, so change the documentation to conform to qemu's actual behavior.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  qapi/block-core.json         | 9 +++++----
> >>  docs/qemu-block-drivers.texi | 4 ++--
> >>  qemu-img.texi                | 4 ++--
> >>  3 files changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> index 0d43d4f37c..a4363b84d2 100644
> >> --- a/qapi/block-core.json
> >> +++ b/qapi/block-core.json
> >> @@ -5167,10 +5167,11 @@
> >>  # @off: no preallocation
> >>  # @metadata: preallocate only for metadata
> >>  # @falloc: like @full preallocation but allocate disk space by
> >> -#          posix_fallocate() rather than writing zeros.
> >> -# @full: preallocate all data by writing zeros to device to ensure disk
> >> -#        space is really available. @full preallocation also sets up
> >> -#        metadata correctly.
> >> +#          posix_fallocate() rather than writing data.
> >> +# @full: preallocate all data by writing it to the device to ensure
> >> +#        disk space is really available. This data may or may not be
> >> +#        zero, depending on the image format and storage.
> >> +#        @full preallocation also sets up metadata correctly.
> >>  #
> >>  # Since: 2.2
> >>  ##
> >> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> >> index 91ab0eceae..c02547e28c 100644
> >> --- a/docs/qemu-block-drivers.texi
> >> +++ b/docs/qemu-block-drivers.texi
> >> @@ -31,8 +31,8 @@ Supported options:
> >>  @item preallocation
> >>  Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{full}).
> >>  @code{falloc} mode preallocates space for image by calling posix_fallocate().
> >> -@code{full} mode preallocates space for image by writing zeros to underlying
> >> -storage.
> >> +@code{full} mode preallocates space for image by writing data to underlying
> >> +storage.  This data may or may not be zero, depending on the storage location.
> >>  @end table
> >>  
> >>  @item qcow2
> >> diff --git a/qemu-img.texi b/qemu-img.texi
> >> index c8e9bba515..b5156d6316 100644
> >> --- a/qemu-img.texi
> >> +++ b/qemu-img.texi
> >> @@ -666,8 +666,8 @@ Supported options:
> >>  @item preallocation
> >>  Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{full}).
> >>  @code{falloc} mode preallocates space for image by calling posix_fallocate().
> >> -@code{full} mode preallocates space for image by writing zeros to underlying
> >> -storage.
> >> +@code{full} mode preallocates space for image by writing data to underlying
> >> +storage.  This data may or may not be zero, depending on the storage location.
> >>  @end table
> >>  
> >>  @item qcow2
> > 
> > Just a question:
> 
> But a very good one, actually.

:-)

> 
> > if a protocol driver returns 1 with the .bdrv_has_zero_init callback, is it
> > expected that the preallocation will fill the image with zeroes?
> 
> Yes.
> 
> > IIUC, for example, the qcow2 returns 1 with the .bdrv_has_zero_init. but during
> > the qcow2_co_truncate() it calls bdrv_co_truncate() and, depending on the
> > backend driver, it should fill the image with zeroes (or not?).
> 
> Yes.
> 
> > Maybe I miss something related to the metadata...
> 
> Well.  If the image isn’t preallocated, all will be well because nothing
> of the added range is entered into the metadata, so it returns zero when
> read (unless there is a backing file, but that is handled independently
> of has_zero_init).

Okay, that makes sense.

> 
> But you were asking about preallocation.  As I wrote in the commit
> message, the qcow2 driver lets the protocol driver preallocate the data
> and then enters it as normal data clusters into its metadata.  If the
> image is encrypted, it will appears as random data (or if the protocol
> dirver writes non-zero data).  But then it shouldn’t report
> has_zero_init as 1.
> 
> Let’s test it.
> 
> $ qemu-img create -f qcow2 src.qcow2 64M
> Formatting 'src.qcow2', fmt=qcow2 size=67108864 cluster_size=65536
> lazy_refcounts=off refcount_bits=16
> $ qemu-img convert -O qcow2 \
>     -o \
>     encrypt.format=luks,encrypt.key-secret=pass,preallocation=metadata \
>     --object secret,id=pass,data=123456 \
>     src.qcow2 dest.qcow2
> $ qemu-img compare --image-opts \
>     file.filename=src.qcow2 \
>     file.filename=dest.qcow2,encrypt.key-secret=pass \
>     --object secret,id=pass,data=123456
> Content mismatch at offset 0!
> 
> Oops.
> 
> 
> So.  We can do two things here.
> 
> (A) We drop this patch and actually make sure that preallocation always
> writes zeroes, and if that cannot be done efficiently, then too bad.
> 
> Note that for qcow2, we cannot just mark all clusters as zero clusters
> because that would kind of defeat the purpose of metadata preallocation.
>  One of its main purposes is to prevent COW when you write to a new
> image, i.e. that the qcow2 driver needs to do a read-modify-write cycle
> just to zero a new cluster.  If we kept preallocating potentially random
> data and hooked it up as preallocated zero clusters, those RMW cycles
> would remain, thus defeating the point of metadata preallocation.  So
> even for qcow2, if there is a chance that the data stored is not zero,
> it needs to explicitly store zeroes then.
> 
> But the good thing here is that the protocol driver would always
> guarantee that it preallocates pure zeroes.
> 
> The bad thing is that I don’t think we could support pure metadata or
> falloc preallocation together with encryption any longer, which would
> definitely be an incompatible change.  Well, because we wouldn’t want to
> break this support, I suppose we would in this case (encryption) resort
> to linking the data clusters as preallocated zero clusters.  Which is
> bad because of RMW. but well.  That’s life.

Yes, I agree that it is a bad thing.

> 
> 
> (B) We keep this patch and audit our use of bdrv_has_zero_init().  So
> for qcow2, we need to return 0 for encrypted images.  That is suboptimal
> for non-preallocated encrypted images, but again, that’s life.
> 
> Also, we need to return 0 if the protocol layer does not preallocate the
> data to be zero -- which we can see from its setting of
> bdrv_has_zero_init(), I’d suppose.  So for preallocated unencrypted
> images, qcow2 would need to return bdrv_has_zero_init(s->data_file->bs).

Yes, that's what I had in mind, too.

> 
> But here’s the problem: How do we know whether an image has been
> preallocated or not?  And that is a problem.  I don’t know a solution
> off the top of my head.  We could add a parameter to
> bdrv_has_zero_init() for that, but what would blockdev-mirror assume?
> It doesn’t know.

Why we need to know if an image has been preallocated with zeroes or not?

Maybe when we convert it, but I'm not sure.

> 
> Hm.  I suppose qcow2’s implementation could sift through its L2 tables
> and if there are any links to data clusters, it is by definition in some
> way preallocated.
> 
> 
> So I suppose B seems like the better solution if there is a way for all
> format drivers to determine whether their image has been preallocated or
> not?

Seems like the better solution to me, also if I miss something why we need to
determine whether or not it's been pre-allocated. :-(


Thanks for very detailed answer,
Stefano

