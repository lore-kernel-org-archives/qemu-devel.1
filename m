Received: from eggs.gnu.org ([2001:4830:134:3::10]:60138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eb3rL-0000jA-As
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eb3rI-00083h-7n
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:27:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eb3rI-00083R-0q
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:27:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 425092DB731
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 12:27:18 +0000 (UTC)
Date: Mon, 15 Jan 2018 10:27:13 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180115122713.GL6646@localhost.localdomain>
References: <20180109154519.25634-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109154519.25634-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] CPU model updates for CVE-2017-5715
 (Spectre variant #2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 09, 2018 at 01:45:12PM -0200, Eduardo Habkost wrote:
> This series adds support for the new IA32_SPEC_CTRL MSR on Intel
> CPU models.  The new MSR and the spec-ctrl CPUID bit
> (CPUID[EAX=7,ECX=0].EDX[bit 26]) were introduced by a recent
> Intel microcode updated and can be used by OSes to mitigate
> CVE-2017-5715.
> 
> It also adds a new EPYC-IBPB CPU model that includes
> CPUID[0x80000008].EBX[bit 12] (IBPB).  That patch is a RFC
> because I couldn't find any detailed info on the new CPUID bit
> and the IA32_PRED_CMD MSR.
> 
> Additionally, the last patch on this series changes the new
> Westmere-IBRS, SandyBridge-IBRS and IvyBridge-IBRS to include the
> PCID feature, because PCID helps to reduce the performance impact
> of KPTI on the guest.  The patch is also a RFC because we need to
> confirm if all Westmere (and newer) CPUs out there have PCID
> available.
> 
> References:
> * https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-5715
> * Google Security Blog on Meltdown/Spectre mitigations:
>   https://security.googleblog.com/2018/01/more-details-about-mitigations-for-cpu_4.html
> * Kernel patches to make use of the new MSRs:
>   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1578798.html
> * KVM kernel patches for the new CPUID bits and MSRs:
>   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1580363.html
> * Patches adding PCID to the existing CPU models:
>   https://patchew.org/QEMU/20180108205052.24385-1-vincent@bernat.im
>   https://patchew.org/QEMU/20180109070112.30806-1-vincent@bernat.im

Intel docs for the new CPUID flags and MSRs were finally
published:
https://software.intel.com/sites/default/files/managed/c5/63/336996-Speculative-Execution-Side-Channel-Mitigations.pdf

-- 
Eduardo
