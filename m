Received: from eggs.gnu.org ([2001:4830:134:3::10]:34306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e44H6-0001Md-Hs
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e44H3-0000GA-9T
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:13:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e44H3-0000FB-2m
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:13:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3248F13AA2
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 12:13:36 +0000 (UTC)
References: <20171016094121.16455-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8a857a8d-c0eb-c826-f14f-83810ac27280@redhat.com>
Date: Mon, 16 Oct 2017 14:13:28 +0200
MIME-Version: 1.0
In-Reply-To: <20171016094121.16455-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] kvm: tolerate non-existing slot for
 log_start and log_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 16/10/2017 11:41, David Hildenbrand wrote:
> log_start might be called by memory.c just before registering the
> section. So we can actually get a log_start without a region_add, which
> we can silently ignore.

This is really a bug in memory.c, I think.  When you put together
everything as a single patch series, can you include the memory.c change
instead, and drop this reference in the commit message and the kvm-all.c
comment?

Thanks,

Paolo

> This makes current KVM code trigger an assertion
> ("kvm_section_update_flags: error finding slot").
> 
> Also, if we want to trap every access to a section, we might not have a
> slot. So let's just tolerate if we don't have a slot.
