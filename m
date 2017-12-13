Received: from eggs.gnu.org ([2001:4830:134:3::10]:47944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePERN-0000b6-TJ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePERJ-00026g-Up
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:19:45 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171213204611.26276-1-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ca12a05-2e7b-9c39-d32d-ec3e3febead1@redhat.com>
Date: Wed, 13 Dec 2017 22:19:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171213204611.26276-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] blockjob: kick jobs on set-speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On 13/12/2017 21:46, John Snow wrote:
> 
> When a user provides a new speed, kick the job to allow it to recalculate
> its delay.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
> 
> RFC: Why is block_job_mutex shared between all jobs,
>      instead of being per-job?

Because that patch was partly extracted out of a bigger one, and I was
both lazy and worried about breaking things close to the release.

In other words more uses of the mutex are coming, and it will need to be
shared between jobs to work fine with transactions and monitor commands
(which don't know the job they're working on until they've looked it
up).  Starting a paused block job is not a hot path. :)

Paolo
