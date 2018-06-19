Received: from eggs.gnu.org ([2001:4830:134:3::10]:47651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVFlz-00059O-Ds
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVFlt-0004hg-Qy
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:30:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVFlt-0004hC-KG
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:30:05 -0400
References: <20180605221500.21674-1-juterry@microsoft.com>
	<20180605221500.21674-2-juterry@microsoft.com>
	<dfb2eddc-b582-4175-0109-c752d97ccf34@redhat.com>
	<MW2PR2101MB09217AB059213F2EAE1C7B72B6710@MW2PR2101MB0921.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2413663f-b3c7-04cb-afb4-5d1b18147559@redhat.com>
Date: Tue, 19 Jun 2018 14:30:02 +0200
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB09217AB059213F2EAE1C7B72B6710@MW2PR2101MB0921.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] WHPX: register for unrecognized MSR
 exits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>

On 19/06/2018 00:01, Justin Terry (VM) wrote:
> The issue is that the Windows Hypervisor Platform will return #GP for
> any rdmsr/wrmsr that is not a virtualized MSR in the hypervisor by
> default. A virt stack (QEMU) can override this default behavior by
> registering for MSR exits. In this configuration the virt stack will
> receive any non-virtualized MSR exit and from the hypervisors
> perspective this is now effectively handled. I could certainly list
> each MSR individually but it seems overly prone to test-matrix
> errors. For example, each kernel that I try might succeed but a
> single option difference in another kernel might fail (which was the
> case here because the 4.4 kernel is different from the 4.14+ it
> seems). But, I will make any change you see fit to handle this in the
> way QEMU prefers.
> 
> As FYI, this is the same logic that Hyper-V uses in its virt stack
> for any hypervisor exits that are not handled in the hypervisor
> itself.

If by "the same logic" you mean that Hyper-V does
read-as-zero/write-to-nowhere, then the patch is okay with a comment
that says so.

Thanks,

Paolo
