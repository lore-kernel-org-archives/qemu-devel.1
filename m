Received: from eggs.gnu.org ([2001:4830:134:3::10]:50838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLvua-0001JM-7r
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLvuX-0000Yj-Jf
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:28:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fLvuX-0000YY-DN
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:28:29 -0400
Date: Thu, 24 May 2018 16:28:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180524192821.GM8988@localhost.localdomain>
References: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
	<1527176614-26271-2-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527176614-26271-2-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/5] i386: Clean up cache CPUID code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Thu, May 24, 2018 at 11:43:30AM -0400, Babu Moger wrote:
> From: Eduardo Habkost <ehabkost@redhat.com>
> 
> Always initialize CPUCaches structs with cache information, even
> if legacy_cache=true.  Use different CPUCaches struct for
> CPUID[2], CPUID[4], and the AMD CPUID leaves.
> 
> This will simplify a lot the logic inside cpu_x86_cpuid().
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Queued, thanks.

-- 
Eduardo
