Received: from eggs.gnu.org ([2001:4830:134:3::10]:58387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmGOU-00056U-SM
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cmGOR-0003yf-O5
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:59:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cmGOR-0003yV-IM
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 03:59:23 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 832CF81138
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 08:59:23 +0000 (UTC)
Date: Fri, 10 Mar 2017 16:59:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170310085917.GF17299@pxdev.xzpeter.org>
References: <1489119213-977-1-git-send-email-peterx@redhat.com>
	<da6200fe-c0ac-00bb-d0b7-dbf3c5a8a21f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da6200fe-c0ac-00bb-d0b7-dbf3c5a8a21f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hostmem: fix reference to uninit mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Mar 10, 2017 at 09:33:57AM +0100, Paolo Bonzini wrote:
> 
> 
> On 10/03/2017 05:13, Peter Xu wrote:
> > Trying to get memory region size of an uninitialized memory region is
> > probably not a good idea. Let's just do the alloc no matter what.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> What is the effect of the bug? The idea was to do the initialization
> once only (memory_region_size ought to be 0 when the MR is
> uninitialized; now it is ugly but it made more sense when MemoryRegion
> was just a C struct and not a QOM object).

It's not really a bug. I just saw it, thought it was something not
quite right, so posted a patch. Since it's intended, then please
ignore this patch, and sorry for the noise... :)

(Considering it's a QOM object, it'll better explain itself if we were
 using something like object_initialized() here for the check, but
 since we don't have that, I think fetching size is okay as well)

Thanks,

-- peterx
