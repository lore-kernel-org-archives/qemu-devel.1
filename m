Received: from eggs.gnu.org ([2001:4830:134:3::10]:45364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJhnO-0002Uo-C0
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJhnN-0001Jd-Hr
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:59:54 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-35-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6e0f678-c86e-f24b-6769-34aacec808ce@redhat.com>
Date: Fri, 18 May 2018 10:59:46 -0500
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

Do you want to add a MAINTAINERS entry under a block section, so that 
the block list is cc'd on changes to the new file, in addition to the 
fact that it is already covered by normal QAPI reviewers?  (If we do 
that, block-core.json could also use such additional coverage.)

> +++ b/Makefile
> @@ -98,6 +98,7 @@ GENERATED_FILES += qapi/qapi-types-char.h qapi/qapi-types-char.c
>   GENERATED_FILES += qapi/qapi-types-common.h qapi/qapi-types-common.c
>   GENERATED_FILES += qapi/qapi-types-crypto.h qapi/qapi-types-crypto.c
>   GENERATED_FILES += qapi/qapi-types-introspect.h qapi/qapi-types-introspect.c
> +GENERATED_FILES += qapi/qapi-types-job.h qapi/qapi-types-job.c
>   GENERATED_FILES += qapi/qapi-types-migration.h qapi/qapi-types-migration.c
>   GENERATED_FILES += qapi/qapi-types-misc.h qapi/qapi-types-misc.c
>   GENERATED_FILES += qapi/qapi-types-net.h qapi/qapi-types-net.c

I've threatened to post a refactoring patch to make it so that adding a 
new schema file doesn't require so many edits in the Makefile.  Maybe I 
should make good on that threat :)

But in the meantime, this looks good.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
