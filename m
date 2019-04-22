Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B9C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 18:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60AB214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 18:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60AB214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIdce-0000H4-TL
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 14:24:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIdas-0007k6-E6
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 14:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIdar-0007e9-5I
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 14:23:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIdaq-0007cp-W6
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 14:23:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D82F2C05683E;
	Mon, 22 Apr 2019 18:23:02 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8470A60141;
	Mon, 22 Apr 2019 18:22:56 +0000 (UTC)
Date: Mon, 22 Apr 2019 15:22:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190422182255.GV25134@habkost.net>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422083013-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190422083013-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 22 Apr 2019 18:23:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Message-ID: <20190422182255.F7MA5VFb7mQJ4pbbfuQxFSjKAmZcqPpwNNHixjUuLsc@z>

On Mon, Apr 22, 2019 at 08:34:51AM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 22, 2019 at 08:48:47AM +0800, Wei Yang wrote:
> > Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
> > guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
> > files on ext4/xfs file system mounted with '-o dax').
> > 
> > A description of MAP_SYNC and MAP_SHARED_VALIDATE can be found at
> >     https://patchwork.kernel.org/patch/10028151/
> > 
> > In order to make sure that the file metadata is in sync after a fault 
> > while we are writing a shared DAX supporting backend files, this
> > patch-set enables QEMU to use MAP_SYNC flag for memory-backend-dax-file.
> > 
> > As the DAX vs DMA truncated issue was solved, we refined the code and
> > send out this feature for the v5 version.
> > 
> > We will pass MAP_SYNC to mmap(2); if MAP_SYNC is supported and
> > 'share=on' & 'pmem=on'. 
> > Or QEMU will not pass this flag to mmap(2)
> 
> OK this is in a good shape. As we are in freeze anyway,
> there's still a bit more time to polish it. I have a couple of
> suggestions:
> 
> - squash docs in same patch with code, no need for two patches
> - mmap errors are not silently ignored as the doc says,
>   a warning is produced

Note that a warning is produced only if both share=on and pmem=on
is specified.  If using pmem=on without share=on, no warning is
printed at all.

I agree we could squash the docs in the same patch, but I don't
want to prevent the code from being merged and require v15 to be
sent just because we are still polishing the documentation.

If there are no objections, I plan to apply this version of the
series including the following fixup (just removing the word
"silently"), and I suggest further improvements to be sent as
follow up patches.

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index bcd1456e72..b531cacd35 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -159,8 +159,8 @@ If these conditions are not satisfied i.e. if either 'pmem' or 'share'
 are not set, if the backend file does not support DAX or if MAP_SYNC
 is not supported by the host kernel, write persistence is not
 guaranteed after a system crash. For compatibility reasons, these
-conditions are silently ignored if not satisfied. Currently, no way
-is provided to test for them.
+conditions are ignored if not satisfied. Currently, no way is
+provided to test for them.
 For more details, please reference mmap(2) man page:
 http://man7.org/linux/man-pages/man2/mmap.2.html.
 
-- 
Eduardo

