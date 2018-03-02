Received: from eggs.gnu.org ([2001:4830:134:3::10]:56496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermSQ-0001hh-JZ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermSM-00070e-Jw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:18:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41198 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermSM-000700-FA
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:18:46 -0500
References: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28a549c0-fffb-6c9a-8855-450125751234@redhat.com>
Date: Fri, 2 Mar 2018 16:18:36 +0100
MIME-Version: 1.0
In-Reply-To: <1519665216-1078-1-git-send-email-juterry@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/8] WHPX updates based on the 17095
 insider sdk.
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

On 26/02/2018 18:13, Justin Terry (VM) wrote:
> This change set includes fixes for two breaking changes that were introduced
> in the Windows Insider SDK 17095. First, the casing of the headers/libs changed
> such that a direct reference out of Windows Kits will fail during compile on
> case sensitive file systems. Second, a few API's were modified to improve
> performance and changes are required to QEMU to maintain ability to build on
> such platforms.
> 
> The rest of the changes are around improvements/fixes to the accelerator to
> increase performance and correctness.
> 
> Thanks,
> Justin Terry
> 
> Justin Terry (VM) (8):
>   Fixing WHPX casing to match SDK
>   Resolves WHPX breaking changes in SDK 17095
>   Remove unnecessary WHPX __debugbreak();
>   Fix WHPX additional lock acquisition
>   Fix WHPX typo in 'mmio'
>   Fix WHPX issue leaking tpr values
>   WHXP Removes the use of WHvGetExitContextSize
>   WHPX improve interrupt notification registration
> 
>  configure              | 10 ++++----
>  target/i386/whpx-all.c | 70 +++++++++++++++++---------------------------------
>  2 files changed, 28 insertions(+), 52 deletions(-)
> 

Queued, thanks!

Paolo
