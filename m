Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C44C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0EE2175B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0EE2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51087 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIsOq-0000Cj-3i
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 06:11:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hIsK4-0004cL-Il
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hIsAs-0005pr-IN
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hIsAq-0005oN-Hw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA0555D601;
	Tue, 23 Apr 2019 09:57:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BDBB104C421;
	Tue, 23 Apr 2019 09:57:10 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 484B03FB10;
	Tue, 23 Apr 2019 09:57:10 +0000 (UTC)
Date: Tue, 23 Apr 2019 05:57:09 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <1530268636.22974041.1556013429816.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190422004849.26463-3-richardw.yang@linux.intel.com>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422004849.26463-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.13, 10.4.195.19]
Thread-Topic: docs: Added MAP_SYNC documentation
Thread-Index: Yhqam+6X2jvRKQ1DnzscVTfMNJ4oIg==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 23 Apr 2019 09:57:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v14 2/2] docs: Added MAP_SYNC documentation
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
Cc: xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, mst@redhat.com,
	qemu-devel@nongnu.org, yi z zhang <yi.z.zhang@linux.intel.com>,
	yu c zhang <yu.c.zhang@linux.intel.com>, stefanha@redhat.com,
	pbonzini@redhat.com, imammedo@redhat.com,
	dan j williams <dan.j.williams@intel.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423095709.BHPmPmBy_t1omFtOHsH7jY63Kl0ZcaioP8kfUqZCVrQ@z>


> 
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  docs/nvdimm.txt | 22 +++++++++++++++++++---
>  qemu-options.hx |  5 +++++
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index 7231c2d78f..bcd1456e72 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -144,9 +144,25 @@ Guest Data Persistence
>  ----------------------
>  
>  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> -currently the only one that can guarantee the guest write persistence
> -is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> -which all guest access do not involve any host-side kernel cache.
> +the only backend that can guarantee the guest write persistence is:
> +
> +A. DAX device (e.g., /dev/dax0.0, ) or
> +B. DAX file(mounted with dax option)
> +
> +When using B (A file supporting direct mapping of persistent memory)
> +as a backend, write persistence is guaranteed if the host kernel has
> +support for the MAP_SYNC flag in the mmap system call (available
> +since Linux 4.15 and on certain distro kernels) and additionally
> +both 'pmem' and 'share' flags are set to 'on' on the backend.
> +
> +If these conditions are not satisfied i.e. if either 'pmem' or 'share'
> +are not set, if the backend file does not support DAX or if MAP_SYNC
> +is not supported by the host kernel, write persistence is not
> +guaranteed after a system crash. For compatibility reasons, these
> +conditions are silently ignored if not satisfied. Currently, no way
> +is provided to test for them.
> +For more details, please reference mmap(2) man page:
> +http://man7.org/linux/man-pages/man2/mmap.2.html.
>  
>  When using other types of backends, it's suggested to set 'unarmed'
>  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 08749a3391..bdc74c0620 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4233,6 +4233,11 @@ using the SNIA NVM programming model (e.g. Intel
> NVDIMM).
>  If @option{pmem} is set to 'on', QEMU will take necessary operations to
>  guarantee the persistence of its own writes to @option{mem-path}
>  (e.g. in vNVDIMM label emulation and live migration).
> +Also, we will map the backend-file with MAP_SYNC flag, which ensures the
> +file metadata is in sync for @option{mem-path} in case of host crash
> +or a power failure. MAP_SYNC requires support from both the host kernel
> +(since Linux kernel 4.15) and the filesystem of @option{mem-path} mounted
> +with DAX option.
>  
>  @item -object
>  memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
>  
> --
> 2.19.1

Looks good to me.

Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> 
> 
> 

