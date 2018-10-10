Received: from eggs.gnu.org ([2001:4830:134:3::10]:39057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gA9aw-0007sR-2Y
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gA9ar-0007dd-5E
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:11:50 -0400
Date: Wed, 10 Oct 2018 10:11:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181010101129.409d6e48.cohuck@redhat.com>
In-Reply-To: <20181009175226.22138-3-akrowiak@linux.vnet.ibm.com>
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-3-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 2/6] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>

On Tue,  9 Oct 2018 13:52:22 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

(...)

> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

This patch (and the others) have a mismatch between the author (address
with vnet), and the s-o-b (address without vnet). While these are
obviously the same person, the addresses really should match.

Should I fix up the author to use the vnet-less address?

> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> ---
>  target/s390x/cpu_features.c     | 3 +++
>  target/s390x/cpu_features_def.h | 3 +++
>  target/s390x/cpu_models.c       | 2 ++
>  target/s390x/gen-features.c     | 3 +++
>  4 files changed, 11 insertions(+)
