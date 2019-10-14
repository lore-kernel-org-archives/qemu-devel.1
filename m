Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F08C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 22:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622F221721
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 22:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622F221721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK8OY-0005R9-Fv
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 18:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iK8NM-0004q9-0q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 17:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iK8NK-0000oJ-S5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 17:59:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:21062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iK8NK-0000o9-J8; Mon, 14 Oct 2019 17:59:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Oct 2019 14:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; d="scan'208";a="185618717"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga007.jf.intel.com with ESMTP; 14 Oct 2019 14:59:27 -0700
Date: Tue, 15 Oct 2019 05:59:11 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 0/2] cleanup on page size
Message-ID: <20191014215911.GB15059@richard>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013021145.16011-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: fam@euphon.net, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, den@openvz.org,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, sw@weilnetz.de, dgilbert@redhat.com,
 yuval.shaia@oracle.com, alex.williamson@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au, kwolf@redhat.com,
 cohuck@redhat.com, qemu-s390x@nongnu.org, mreitz@redhat.com,
 qemu-ppc@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, All,

I got one page size related question, hope to get some hint.

There is one comment in page_size_init().

    /* NOTE: we can always suppose that qemu_host_page_size >=
       TARGET_PAGE_SIZE */

The final result is true, since we compare qemu_host_page_size with
TARGET_PAGE_SIZE and if not qemu_host_page_size will be assigned to
TARGET_PAGE_SIZE.

Generally, there is no problem, but one corner case for migration.

In function ram_save_host_page(), it tries to save a whole host page. Or to be
specific, it tries to save a whole REAL host page.

The potential problem is when qemu_real_host_page_size < TARGET_PAGE_SIZE,
this whole host page would be a wrong range.

So I am wondering why we have the assumption written in page_size_init()?

I tried to dig out who and why we have this comment, but found the first
commit is

    commit 54936004fddc52c321cb3f9a9a51140e782bed5d
    Author: bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
    Date:   Tue May 13 00:25:15 2003 +0000
    
        mmap emulation
    
    
        git-svn-id: svn://svn.savannah.nongnu.org/qemu/trunk@158 c046a42c-6fe2-441c-8c8c-71466251a162

There is no reason logged.

On Sun, Oct 13, 2019 at 10:11:43AM +0800, Wei Yang wrote:
>Patch 1 simplify the definition of xxx_PAGE_ALIGN.
>Patch 2 replaces getpagesize() with qemu_real_host_page_size. This one touch a
>volume of code. If some point is not correct, I'd appreciate your
>notification.
>
>Wei Yang (2):
>  cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
>  core: replace getpagesize() with qemu_real_host_page_size
>
> accel/kvm/kvm-all.c            |  6 +++---
> backends/hostmem.c             |  2 +-
> block.c                        |  4 ++--
> block/file-posix.c             |  9 +++++----
> block/io.c                     |  2 +-
> block/parallels.c              |  2 +-
> block/qcow2-cache.c            |  2 +-
> contrib/vhost-user-gpu/vugbm.c |  2 +-
> exec.c                         |  6 +++---
> hw/intc/s390_flic_kvm.c        |  2 +-
> hw/ppc/mac_newworld.c          |  2 +-
> hw/ppc/spapr_pci.c             |  2 +-
> hw/rdma/vmw/pvrdma_main.c      |  2 +-
> hw/vfio/spapr.c                |  7 ++++---
> include/exec/cpu-all.h         |  7 +++----
> include/exec/ram_addr.h        |  2 +-
> include/qemu/osdep.h           |  4 ++--
> migration/migration.c          |  2 +-
> migration/postcopy-ram.c       |  4 ++--
> monitor/misc.c                 |  2 +-
> target/ppc/kvm.c               |  2 +-
> tests/vhost-user-bridge.c      |  8 ++++----
> util/mmap-alloc.c              | 10 +++++-----
> util/oslib-posix.c             |  4 ++--
> util/oslib-win32.c             |  2 +-
> util/vfio-helpers.c            | 12 ++++++------
> 26 files changed, 55 insertions(+), 54 deletions(-)
>
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me

