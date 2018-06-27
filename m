Received: from eggs.gnu.org ([2001:4830:134:3::10]:54387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY8U1-00012l-9M
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fY8Tv-00043S-OI
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:19:33 -0400
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-10-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0d745709-2f06-01ad-c144-562648834603@redhat.com>
Date: Wed, 27 Jun 2018 13:19:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180625115352.6889-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 9/9] s390x/tcg: fix CPU
 hotplug with single-threaded TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 25.06.2018 13:53, David Hildenbrand wrote:
> run_on_cpu() doesn't seem to work reliably until the CPU has been fully
> created if the single-threaded TCG main loop is already running.
> 
> Therefore, hotplugging a CPU under single-threaded TCG does currently
> not work. We should use the direct call instead of going via
> run_on_cpu().
> 
> So let's use run_on_cpu() for KVM only - KVM requires it due to the initial
> CPU reset ioctl. As a nice side effect, we get rif of the ifdef.

With the typo fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>
