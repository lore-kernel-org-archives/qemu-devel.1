Received: from eggs.gnu.org ([2001:4830:134:3::10]:36708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHDSl-0000bs-BX
	for qemu-devel@nongnu.org; Fri, 11 May 2018 15:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fHDSi-0001Mz-6m
	for qemu-devel@nongnu.org; Fri, 11 May 2018 15:12:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fHDSi-0001M4-0U
	for qemu-devel@nongnu.org; Fri, 11 May 2018 15:12:16 -0400
Date: Fri, 11 May 2018 16:12:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180511191211.GU25013@localhost.localdomain>
References: <20180510204148.11687-1-babu.moger@amd.com>
	<20180510204148.11687-2-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510204148.11687-2-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/8] i386: Helpers to encode cache
 information consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com, kash@tripleback.net

On Thu, May 10, 2018 at 03:41:41PM -0500, Babu Moger wrote:
> From: Eduardo Habkost <ehabkost@redhat.com>
> 
> Instead of having a collection of macros that need to be used in
> complex expressions to build CPUID data, define a CPUCacheInfo
> struct that can hold information about a given cache.  Helper
> functions will take a CPUCacheInfo struct as input to encode
> CPUID leaves for a cache.
> 
> This will help us ensure consistency between cache information
> CPUID leaves, and make the existing inconsistencies in CPUID info
> more visible.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Geoffrey McRae <geoff@hostfission.com>

CPUID compatibility is now being kept.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued, thanks.

-- 
Eduardo
