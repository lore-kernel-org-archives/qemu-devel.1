Received: from eggs.gnu.org ([2001:4830:134:3::10]:59888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ1tb-0005k7-Rc
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ1tb-0001iz-2w
	for qemu-devel@nongnu.org; Wed, 16 May 2018 15:15:31 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-24-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <75815ff8-fa5e-1d9f-69db-d83a0757b55d@redhat.com>
Date: Wed, 16 May 2018 14:15:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-24-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/42] blockjob: Split
 block_job_event_pending()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On 05/09/2018 11:26 AM, Kevin Wolf wrote:
> block_job_event_pending() doesn't only send a QMP event, but it also
> transitions to the PENDING state. Split the function so that we get one
> part only sending the event (like other block_job_event_* functions) and
> another part than does the state transition.

s/than/that/

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   blockjob.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
