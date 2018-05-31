Received: from eggs.gnu.org ([2001:4830:134:3::10]:53161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOV0l-0007AS-6k
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fOV0k-0003Is-Ct
	for qemu-devel@nongnu.org; Thu, 31 May 2018 17:21:31 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-35-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <18349e38-30fc-fbbd-c4ce-c3bc526cda1c@redhat.com>
Date: Thu, 31 May 2018 16:21:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-35-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 34/40] job: Introduce qapi/job.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

On 05/18/2018 08:21 AM, Kevin Wolf wrote:
> This adds a separate schema file for all job-related definitions that
> aren't tied to the block layer.
> 
> For a start, move the enums JobType, JobStatus and JobVerb.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json  | 90 +-----------------------------------------------
>   qapi/job.json         | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   qapi/qapi-schema.json |  1 +
>   Makefile              |  9 +++++
>   Makefile.objs         |  4 +++
>   5 files changed, 109 insertions(+), 89 deletions(-)
>   create mode 100644 qapi/job.json

This commit now results in a dirty 'git status' for in-tree builds:

	qapi/qapi-commands-job.c
	qapi/qapi-commands-job.h
	qapi/qapi-events-job.c
	qapi/qapi-events-job.h
	qapi/qapi-types-job.c
	qapi/qapi-types-job.h
	qapi/qapi-visit-job.c
	qapi/qapi-visit-job.h

I'll propose a cleanup patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
