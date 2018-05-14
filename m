Received: from eggs.gnu.org ([2001:4830:134:3::10]:54649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJNL-00053B-HS
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJNK-0007WI-Oc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:43:15 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-7-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bd11dfc1-5ea8-045d-5cac-b2f259ae12ee@redhat.com>
Date: Mon, 14 May 2018 15:43:09 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/42] blockjob: Add block_job_driver()
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



On 05/09/2018 12:26 PM, Kevin Wolf wrote:
> The backup block job directly accesses the driver field in BlockJob. Add
> a wrapper for getting it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

I'm not too far into this series yet but I suppose it turns out that
it's more useful to get the driver than to ask the job system what the
job type is.

Probably there's some QAPI reasons for why that's true, too...

Reviewed-by: John Snow <jsnow@redhat.com>.
