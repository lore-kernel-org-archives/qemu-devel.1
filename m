Received: from eggs.gnu.org ([2001:4830:134:3::10]:54368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLcBp-0001BT-5n
	for qemu-devel@nongnu.org; Wed, 23 May 2018 18:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLcBo-00068y-Dn
	for qemu-devel@nongnu.org; Wed, 23 May 2018 18:25:01 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-18-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fa219be9-84e4-07ec-69a5-1fddb608ccbb@redhat.com>
Date: Wed, 23 May 2018 18:24:56 -0400
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-18-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/40] job: Move BlockJobCreateFlags to
 Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 05/18/2018 09:20 AM, Kevin Wolf wrote:
> +    job->auto_finalize = !(flags & JOB_MANUAL_FINALIZE);
> +    job->auto_dismiss  = !(flags & JOB_MANUAL_DISMISS);

Job API might be a good chance to say "No, this is the default behavior
for this API."

I don't know how possible this is, but could we remove these behavior
flags for jobs (but keep them for block jobs), and then any legacy block
job creation interfaces we have can enable/disable them as the user
requested,

and the block job layer itself has hooks that persuade the core job
layer to automatically transition without user input, if appropriate.

(Unless that happens later?)
