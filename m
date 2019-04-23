Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265CC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 12:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D9C206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 12:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D9C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIuuT-0001rl-OA
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 08:52:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hIut4-0000j5-To
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hIula-00057U-A1
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:43:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hIula-00056v-59
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 08:43:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id l17so9118511qtp.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 05:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=aQpRxc0B0dAg2CGN5rw4TlzVw2OhifB4kJj1LIl32Mk=;
	b=FSawtdD8MMOGlrjlKACL/s8ENpWLs3Bi+oq3o+HnpWnvBUVWUkWdg5Jvr0wtSSXNI3
	T7tljxLUtZW1D1azfrTcqh2bveU0v05gJdxgw34I7mvuY4onn5RDGa/MmU1bVw/srmEt
	EbmQpvZ3k94bcuEgNqXtKJWYrhQitCFFZb2jVRLM0kVOh1N8ZrP9m1gzNx1b7o6pDWFQ
	uyCZSsLXmNsKdlizlCh4zrdP7256sw5Di3hAqzdo4F0zGYLzke4nCfnPnLMHxPH3aMu8
	7Z7DxGo7wyunNWDCbBnrWGhckfqgEeTsyYdMIlS9h97ITGfW80/CmyFJa36odMdO/+/C
	sJww==
X-Gm-Message-State: APjAAAVNjrE7DwKZUIhQ43/3bV+1Fe4bK4y5LsXlTD8CoSSl+VxtExlV
	1DtDBbBLwfoeYvfKo3i1qfW7Xg==
X-Google-Smtp-Source: APXvYqxv/i7ku63+XbffNpsVqxNkZyddIA6R3fJAFJrrnYhU9rkfLuCelyBf74mg5lnljTiJ46ES0A==
X-Received: by 2002:a0c:a9d7:: with SMTP id c23mr19915229qvb.11.1556023396508; 
	Tue, 23 Apr 2019 05:43:16 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	k128sm4614105qkb.5.2019.04.23.05.43.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 23 Apr 2019 05:43:15 -0700 (PDT)
Date: Tue, 23 Apr 2019 08:43:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190423084248-mutt-send-email-mst@kernel.org>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422083013-mutt-send-email-mst@kernel.org>
	<20190422182255.GV25134@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190422182255.GV25134@habkost.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v14 0/2] support MAP_SYNC for
 memory-backend-file
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
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, qemu-devel@nongnu.org,
	yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com,
	Wei Yang <richardw.yang@linux.intel.com>, stefanha@redhat.com,
	imammedo@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423124312.Ar_KO4RgcO1KNjafB0MROxWow-ic30aTYYkeLoiYwCA@z>

On Mon, Apr 22, 2019 at 03:22:55PM -0300, Eduardo Habkost wrote:
> On Mon, Apr 22, 2019 at 08:34:51AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Apr 22, 2019 at 08:48:47AM +0800, Wei Yang wrote:
> > > Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
> > > guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
> > > files on ext4/xfs file system mounted with '-o dax').
> > > 
> > > A description of MAP_SYNC and MAP_SHARED_VALIDATE can be found at
> > >     https://patchwork.kernel.org/patch/10028151/
> > > 
> > > In order to make sure that the file metadata is in sync after a fault 
> > > while we are writing a shared DAX supporting backend files, this
> > > patch-set enables QEMU to use MAP_SYNC flag for memory-backend-dax-file.
> > > 
> > > As the DAX vs DMA truncated issue was solved, we refined the code and
> > > send out this feature for the v5 version.
> > > 
> > > We will pass MAP_SYNC to mmap(2); if MAP_SYNC is supported and
> > > 'share=on' & 'pmem=on'. 
> > > Or QEMU will not pass this flag to mmap(2)
> > 
> > OK this is in a good shape. As we are in freeze anyway,
> > there's still a bit more time to polish it. I have a couple of
> > suggestions:
> > 
> > - squash docs in same patch with code, no need for two patches
> > - mmap errors are not silently ignored as the doc says,
> >   a warning is produced
> 
> Note that a warning is produced only if both share=on and pmem=on
> is specified.  If using pmem=on without share=on, no warning is
> printed at all.
> 
> I agree we could squash the docs in the same patch, but I don't
> want to prevent the code from being merged and require v15 to be
> sent just because we are still polishing the documentation.
> 
> If there are no objections, I plan to apply this version of the
> series including the following fixup (just removing the word
> "silently"), and I suggest further improvements to be sent as
> follow up patches.
> 
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index bcd1456e72..b531cacd35 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -159,8 +159,8 @@ If these conditions are not satisfied i.e. if either 'pmem' or 'share'
>  are not set, if the backend file does not support DAX or if MAP_SYNC
>  is not supported by the host kernel, write persistence is not
>  guaranteed after a system crash. For compatibility reasons, these
> -conditions are silently ignored if not satisfied. Currently, no way
> -is provided to test for them.
> +conditions are ignored if not satisfied. Currently, no way is
> +provided to test for them.
>  For more details, please reference mmap(2) man page:
>  http://man7.org/linux/man-pages/man2/mmap.2.html.

with the two being squashed, and above fix:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



> -- 
> Eduardo

