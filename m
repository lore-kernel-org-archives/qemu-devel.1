Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB07C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E94E20661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB5zVbid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E94E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZAt-0006QP-9L
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyZ9z-0005oO-Fs
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyZ9y-0003QP-51
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:40:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25681
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyZ9x-0003Pj-T6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580726453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2QhhQdBRZL7xZQ334ORP4hkV6y/W6g9j7ZoUEg0z44=;
 b=cB5zVbidwnUsrmqN+vqSF7mogIcN4DOVXbP/H15MafwjJ9Zej7Ce/V0k2CfiERohHHFVI9
 OtI4gE1bUOiyhE7WD8DIQqjf2eAgQQgCTIDEfdezX+eIKui7sJ99lPjpcFoEewrF6cCE7S
 UmLKwcK0J8lGKFNJoYE708OxsufCzbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-FqF_M4RHOe-HFcdBNzM8Cg-1; Mon, 03 Feb 2020 05:40:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FEA4107ACC4;
 Mon,  3 Feb 2020 10:40:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F0E28885A;
 Mon,  3 Feb 2020 10:40:43 +0000 (UTC)
Date: Mon, 3 Feb 2020 11:40:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 03/80] machine: alias -mem-path and -mem-prealloc
 into memory-foo backend
Message-ID: <20200203114042.71ef1575@redhat.com>
In-Reply-To: <20200203043724-mutt-send-email-mst@kernel.org>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-4-git-send-email-imammedo@redhat.com>
 <20200203040204-mutt-send-email-mst@kernel.org>
 <20200203102720.6de2374e@redhat.com>
 <20200203043724-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: FqF_M4RHOe-HFcdBNzM8Cg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pasic@linux.ibm.com, pbonzini@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 04:42:23 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Feb 03, 2020 at 10:27:20AM +0100, Igor Mammedov wrote:
> > On Mon, 3 Feb 2020 04:04:15 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Fri, Jan 31, 2020 at 04:08:33PM +0100, Igor Mammedov wrote:  
> > > > Allow machine to opt in for hostmem backend based initial RAM
> > > > even if user uses old -mem-path/prealloc options by providing
> > > >   MachineClass::default_ram_id
> > > > Follow up patches will incrementally convert machines to new API,
> > > > by dropping memory_region_allocate_system_memory() and setting
> > > > default_ram_id that board used to use before conversion to keep
> > > > migration stream the same.
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
> > > 
> > > What about non-versioned machines though?
> > > Why do these need to set default_ram_id?
> > > Seems redundant as they don't need to support cross-version
> > > migration ...  
> > 
> > They need at least some id for migration to work,
> > so this series reuses id that they are using today.  
> 
> However for non versioned machines (and that's the majority of them), we could supply the
> id in the generic code. Basically
> 	if (!default_ram_id)
> 		default_ram_id = "ram";
there was cleanup patch like this in v2, which I dropped for now
as it needs more not directly related this refactoring.
See my reply to: "[PATCH v4 43/80] x86/pc: use memdev for RAM"
I dropped it since if above were done, it would trigger a bunch
of changes /to properly handle case/ to boards that do not care
about -m and manage RAM in its own way and not related to
removing memory_region_allocate_system_memory().

I'm not saying it shouldn't be done but rather,
it should be done on top to take in account cases for fixed size
boards and for boards that do not use -m at all and just create
RAM memory region on its own.

> > Basically default_ram_id is a means to optin into hostmem
> > based allocation with (-m).  
> 
> It's just a cryptic way to do it.
name came up from current meaning of the value stored there,
namely boards use value as the default memory region id.
But optin behavior is not clear from that, How about adding
following to doc comment to make intent explicit:

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 56a4dd9..142b86d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -147,6 +147,9 @@ typedef struct {
  *    Specifies inital RAM MemoryRegion name to be used for default backend
  *    creation if user explicitly hasn't specified backend with "memory-backend"
  *    property.
+ *    It also will be used as a way to optin into "-m" option support.
+ *    If it's not set by board, '-m' will be ignored and generic code will
+ *    not create default RAM MemoryRegion.
  */


[...]


> > "
> > v3:
> > [...]
> >   - drop "[PATCH v2 76/86] post conversion default_ram_id cleanup"
> >     so that default memory-backedend won't be created for boards that do not care
> >     about -m. Which makes -m optin feature. We should decide  what do in  case
> >     board doesn't use -m (but that's out of scope of this series)
> > [...]
> > "
> >   
> > >   
> > > > -- 
> > > > 2.7.4
> > > > 
> > > >     
> > >   
> 


