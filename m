Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4CAC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB69C206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQLiNp/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB69C206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRiG-0008Ne-Jk
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 09:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLRhF-0007Ad-38
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLRhD-0007Oy-1p
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600955642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CAu9/I54QJluDwpEoNQeVkCOoQ/IokLD7lWxreHcAS4=;
 b=UQLiNp/VX+/rNSJYt5owjzeHFJWTyvCl7a6gd71iohWZZqOViOJENs0yhQKDrnzPoP6X7l
 WAwun3/c5JPldMo1MGAPoRPdMVd6voN8XDh275NDNb3lmbQvNOntTAi4PRaUB0+Hcudper
 bxoGelUtCbFJ2jpXk98Xlfwu91F/HME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-Uevu38hXP6uDrtVTbSkGAg-1; Thu, 24 Sep 2020 09:53:48 -0400
X-MC-Unique: Uevu38hXP6uDrtVTbSkGAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 076A01891E80;
 Thu, 24 Sep 2020 13:53:47 +0000 (UTC)
Received: from work-vm (ovpn-114-250.ams2.redhat.com [10.36.114.250])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EE3B60BF3;
 Thu, 24 Sep 2020 13:53:45 +0000 (UTC)
Date: Thu, 24 Sep 2020 14:53:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: SEV guest debugging support for Qemu
Message-ID: <20200924135342.GE2792@work-vm>
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
MIME-Version: 1.0
In-Reply-To: <20200922201124.GA6606@ashkalra_ubuntu_server>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 qemu-devel@nongnu.org, thomas.lendacky@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Ashish Kalra (ashish.kalra@amd.com) wrote:
> Hello Alan, Paolo,
> 
> I am following up on Brijesh’s patches for SEV guest debugging support for Qemu using gdb and/or qemu monitor.
> I believe that last time, Qemu SEV debug patches were not applied and have attached the link to the email thread and Paolo’s feedback below for reference [1].
> I wanted to re-start a discussion on the same here with the Qemu community and seek the feedback on the approaches which we are considering :
> Looking at Qemu code, I see the following interface is defined, for virtual memory access for debug : cpu_memory_rw_debug(). 
> Both gdbstub (target_memory_rw_debug() ) and QMP/HMP (monitor/misc.c : memory_dump() ) use this standard and well-defined interface to access guest memory for debugging purposes. 
> 
> This internally invokes the address_space_rw() accessor functions which we had  "fixed" internally (as part of the earlier patch) to invoke memory region specific debug ops. 
> In our earlier approach we were adding debug ops/callbacks to memory regions and as per comments on our earlier patches, Paolo was not happy with this debug API for
> MemoryRegions and hence the SEV support for Qemu was merged without the debug support.
> 
> Now, we want to reuse this cpu_memory_rw_debug() interface or alternatively introduce a new generic debug interface/object in the Qemu. This 
> debug interface should be controlled through the global machine policy.

Let me leave the question of how the memory_rw_debug interface should
work to Paolo.

> For e.g., 
> # $QEMU -machine -debug=<a debug object>
> or
> # $QEMU -machine -debug=sev-guest-debug
> 
> The QMP and GDB access will be updated to use the generic debug  interface. The generic debug interface or the cpu_memory_rw_debug() interace will introduce hooks to call a 
> vendor specific debug object to delegate accessing the data. The vendor specific debug object may do a further checks before and after accessing the memory.

I'm not sure that needs a commandline switch for it; since you can
already get it from the guest policy in the sev object and I can't think
of any other cases that would need something similar.

> Now, looking specifically at cpu_memory_rw_debug() interface, this interface is invoked for all guest memory accesses for debugging purposes and it also does 
> guest VA to GPA translation via cpu_get_phys_page_attrs_debug(), so we can again add a vendor specific callback here to do guest VA to GPA translations specific
> to SEV as SEV guest debugging will also require accessing guest page table entries and decrypting them via the SEV DBG_DECRYPT APIs and additionally clearing
> the C-bit on page table entries (PxEs) before using them further for page table walks.
> 
> There is still an issue with the generic cpu_memory_rw_debug() interface, though it is used for all guest memory accesses for debugging and we can also handle
> guest page table walks via it (as mentioned above), there are still other gdb/monitor commands such as tlb_info_xx() and mem_info_xx() which also do guest page
> table walks, but they don’t go through any generic guest memory access/debug interface, so these commands will need to be handled additionally for SEV.

If some of those should be using the debug interface and aren't then
please fix them anyway.

> The vendor specific debug object (added as a hook to generic debug object or the generic cpu_memory_rw_debug() interface) will do further checks before and after accessing the memory.
> 
> e.g., in the case of SEV,
> 
> 1. Check the guest policy, if guest policy does not allow debug then return an error.
> 
> 2. If its an MMIO region then access the data.
> 
> 3. If its RAM region then call the PSP commands to decrypt the data.
> 
> 4. If caller asked to read the PTE entry then probably clear the C-bits after reading the PTE entry.

Does that work if the guest is currently running?

Dave

> 5. many more checks
> 
> Looking fwd. to your feedback/comments on the above approach or other any other suggestions.
> 
> Thanks,
> Ashish
> 
> [1] -> http://next.patchew.org/QEMU/20180308124901.83533-1-brijesh.singh@amd.com/20180308124901.83533-29-brijesh.singh@amd.com/
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


