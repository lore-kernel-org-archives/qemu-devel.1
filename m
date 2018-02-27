Received: from eggs.gnu.org ([2001:4830:134:3::10]:36943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlB4-0002Ne-1J
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqlB3-0002k1-CM
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:44:42 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-12-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7240c40a-7c73-e30d-7048-0a72b171fca7@redhat.com>
Date: Tue, 27 Feb 2018 13:44:35 -0600
MIME-Version: 1.0
In-Reply-To: <20180223235142.21501-12-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 11/21] blockjobs: add block_job_dismiss
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
> For jobs that have reached their CONCLUDED state, prior to having their
> last reference put down (meaning jobs that have completed successfully,
> unsuccessfully, or have been canceled), allow the user to dismiss the
> job's lingering status report via block-job-dismiss.
> 
> This gives management APIs the chance to conclusively determine if a job
> failed or succeeded, even if the event broadcast was missed.
> 
> Note that jobs do not yet linger in any such state, they are freed
> immediately upon reaching this previously-unnamed state. such a state is
> added immediately in the next commit.
> 
> Verbs:
> Dismiss: operates on CONCLUDED jobs only.
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
