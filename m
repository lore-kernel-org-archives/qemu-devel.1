Received: from eggs.gnu.org ([2001:4830:134:3::10]:33110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqiHf-0001vm-Fr
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqiHe-0001tF-Bd
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:39:19 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04352010-772f-c457-17c9-b7d039646a8b@redhat.com>
Date: Tue, 27 Feb 2018 10:39:13 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 03/21] blockjobs: add manual property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

On 02/23/2018 05:51 PM, John Snow wrote:
> This property will be used to opt-in to the new BlockJobs workflow
> that allows a tighter, more explicit control over transitions from
> one runstate to another.
> 
> While we're here, fix up the documentation for block_job_create
> a little bit.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   blockjob.c                   |  1 +
>   include/block/blockjob.h     | 10 ++++++++++
>   include/block/blockjob_int.h |  4 +++-
>   3 files changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
