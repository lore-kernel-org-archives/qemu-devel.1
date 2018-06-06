Received: from eggs.gnu.org ([2001:4830:134:3::10]:40634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQfwz-0004hP-R1
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQfwv-0005K4-Qd
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:26:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQfwv-0005Ip-Kv
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:26:33 -0400
Date: Wed, 6 Jun 2018 18:26:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606212626.GB7451@localhost.localdomain>
References: <1528295806-90593-1-git-send-email-babu.moger@amd.com>
	<1528295806-90593-2-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528295806-90593-2-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v12 1/4] i386: Add support for
 CPUID_8000_001E for AMD
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

On Wed, Jun 06, 2018 at 10:36:43AM -0400, Babu Moger wrote:
[...]
> +    /*
> +     * CPUID_Fn8000001E_EBX
> +     * 31:16 Reserved
> +     * 15:8  Threads per core (The number of threads per core is
> +     *       Threads per core + 1)
> +     *  7:0  Core id (see bit decoding below)
> +     *       SMT:
> +     *           4:3 node id
> +     *             2 Core complex id
> +     *           1:0 Core id
> +     *       Non SMT:
> +     *           5:4 node id
> +     *             3 Core complex id
> +     *           1:0 Core id
> +     */

Where are those bit offsets documented?  AMD Family 17h PPR just
says "7:0 Core ID".

-- 
Eduardo
