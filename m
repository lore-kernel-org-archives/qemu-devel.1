Received: from eggs.gnu.org ([2001:4830:134:3::10]:44188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0WuX-0001Jt-Re
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0WuT-0005yw-UP
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:32:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0WuT-0005yY-OT
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:31:57 -0400
References: <20180326170658.606-1-juterry@microsoft.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3721c5b5-8e46-1a48-9183-f0cba181ca48@redhat.com>
Date: Mon, 26 Mar 2018 13:31:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180326170658.606-1-juterry@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] WHPX fixes an issue with CPUID 1 not
 returning CPUID_EXT_HYPERVISOR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net

On 03/26/2018 12:06 PM, Justin Terry (VM) via Qemu-devel wrote:

[meta-comment]

Since we're already discussing this today, I noticed the list rewrites 
your headers due to SPF policies at microsoft.com, to the point that a 
blind 'git am' on the list message will attempt to attribute your patch 
to 'Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>' if the 
maintainer is not careful.

You may want to configure git on your end to emit an explicit 'From: 
Justin Terry (VM) <juterry@microsoft.com>' in the body of each message 
you send, to override the mailman overwrite of your messages to the 
list.  I don't know whether 'git config format.from "Your Name 
<address@example.com>"' is sufficient for this (the help for git 
format-patch mentions that it adds the From: line to the body only when 
it differs textually from the From: header, but doesn't mention a way to 
force the From: line in the body) even when the two start out the same.

> Implements the CPUID trap for CPUID 1 to include the
> CPUID_EXT_HYPERVISOR flag in the ECX results. This was preventing some
> older linux kernels from booting when trying to access MSR's that dont

s/dont/don't/

> make sense when virtualized.
> 
> Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
> ---


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
