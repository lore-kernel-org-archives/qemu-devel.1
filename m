Received: from eggs.gnu.org ([2001:4830:134:3::10]:38528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fW4K9-0006AL-6Q
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fW4K6-0007Wt-1w
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:28:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fW4K5-0007Wk-RF
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:28:45 -0400
Date: Thu, 21 Jun 2018 15:28:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180621182841.GV7451@localhost.localdomain>
References: <1529443919-67509-1-git-send-email-babu.moger@amd.com>
	<1529443919-67509-2-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529443919-67509-2-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v16 1/3] i386: Fix up the Node id for
 CPUID_8000_001E
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, mtosatti@redhat.com, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Tue, Jun 19, 2018 at 05:31:57PM -0400, Babu Moger wrote:
> This is part of topoext support. To keep the compatibility, it is better
> we support all the combination of nr_cores and nr_threads currently
> supported. By allowing more nr_cores and nr_threads, we might end up with
> more nodes than we can actually support with the real hardware. We need to
> fix up the node id to make this work. We can achieve this by shifting the
> socket_id bits left to address more nodes.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued, thanks.

-- 
Eduardo
