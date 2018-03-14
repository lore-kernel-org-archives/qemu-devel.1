Received: from eggs.gnu.org ([2001:4830:134:3::10]:44794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ew92R-0005nR-0y
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ew92M-0006Ct-1u
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:14:03 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ew92L-0006CX-Qy
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 12:13:57 -0400
Received: by mail-wm0-x244.google.com with SMTP id q83so5179208wme.5
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 09:13:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1521039163-138-1-git-send-email-juterry@microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99e60a02-d242-b79e-b4c0-95a6eb273f62@redhat.com>
Date: Wed, 14 Mar 2018 17:13:54 +0100
MIME-Version: 1.0
In-Reply-To: <1521039163-138-1-git-send-email-juterry@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] WHPX introduce changes for Windows
 Insider SDK 17110
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, ehabkost@redhat.com

On 14/03/2018 15:52, Justin Terry (VM) wrote:
> This change set fixes two breaking changes that were introduced in the
> Windows Insider SDK 17110. First, a change to the WHvGetCapability function
> decl to include the 'out' WrittenSizeInBytes. Second, changes to the
> WHvSetPartitionProperty function decl and WHV_PARTITION_PROPERTY structure
> to directly pass the PropertyCode at invocation.
> 
> Lastly, it introduces a major performance improvement in whpx_vcpu_post_run
> using the VpContext exit structure rather than another round trip call to
> WHvGetVirtualProcessorRegisters to synchronize vp state.
> 
> QEMU compiled against this SDK (17110+) is expected to work on all Windows
> Insider Builds (17115+).
> 
> Thanks,
> Justin Terry
> 
> Justin Terry (VM) (3):
>   WHPX fix WHvGetCapability out WrittenSizeInBytes
>   WHPX fix WHvSetPartitionProperty in PropertyCode
>   WHPX improve vcpu_post_run perf
> 
>  configure              |  4 +++-
>  target/i386/whpx-all.c | 46 ++++++++++++++--------------------------------
>  2 files changed, 17 insertions(+), 33 deletions(-)
> 

Queued, thanks.

Paolo
