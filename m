Received: from eggs.gnu.org ([2001:4830:134:3::10]:32813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJsQ-0006hf-CY
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJsP-0002Nc-Fx
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:15:22 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-12-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8b92696b-8c37-549c-72a2-32ebcfb21fcb@redhat.com>
Date: Mon, 14 May 2018 16:15:14 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/42] job: Add job_delete()
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
> This moves freeing the Job object and its fields from block_job_unref()
> to job_delete().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

I guess the reference counting comes later.

*peeks*

Oh, soon!
