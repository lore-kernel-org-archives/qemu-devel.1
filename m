Received: from eggs.gnu.org ([2001:4830:134:3::10]:37422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTXCN-0006D1-1e
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTXCI-0000gB-S3
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:42:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTXCI-0000fb-M1
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:42:14 -0400
Date: Thu, 14 Jun 2018 15:42:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180614184207.GX7451@localhost.localdomain>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
	<1528939107-17193-5-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528939107-17193-5-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v14 4/6] cpus: Add new function
 topology_supports_topoext
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

On Wed, Jun 13, 2018 at 09:18:25PM -0400, Babu Moger wrote:
> Add new function topology_supports_topoext to verify
> if we can support topoext feature. Will be used to enable/disable
> topoext feature.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  accel/tcg/user-exec-stub.c |  5 +++++
>  cpus.c                     | 13 +++++++++++++
>  include/qom/cpu.h          |  9 +++++++++
>  3 files changed, 27 insertions(+)
> 

x86-specific code doesn't belong to arch-independent code.  Why
not keep it in target/i386/cpu.c like before?

-- 
Eduardo
