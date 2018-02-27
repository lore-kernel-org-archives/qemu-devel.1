Received: from eggs.gnu.org ([2001:4830:134:3::10]:43043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqldG-00067i-Rm
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqldF-0006XU-Qd
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:13:50 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-19-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <30051eac-ab7f-a089-5b13-f282f593e9b6@redhat.com>
Date: Tue, 27 Feb 2018 14:13:25 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-19-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 18/21] blockjobs: add block-job-finalize
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
> Instead of automatically transitioning from PENDING to CONCLUDED, gate
> the .prepare() and .commit() phases behind an explicit acknowledgement
> provided by the QMP monitor if manual completion mode has been requested.
> 
> This allows us to perform graph changes in prepare and/or commit so that
> graph changes do not occur autonomously without knowledge of the
> controlling management layer.
> 
> Transactions that have reached the "PENDING" state together can all be
> moved to invoke their finalization methods by issuing block_job_finalize
> to any one job in the transaction.
> 
> Jobs in a transaction with mixed job->manual settings will remain stuck
> in the "WAITING" state until block_job_finalize is authored on the job(s)
> that have reached the "PENDING" state.
> 
> These jobs are not allowed to progress because other jobs in the
> transaction may still fail during their preparation phase during
> finalization, so these jobs must remain in the WAITING phase until
> success is guaranteed. These jobs will then automatically dismiss
> themselves, but jobs that had the manual property set will remain
> at CONCLUDED as normal.
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
