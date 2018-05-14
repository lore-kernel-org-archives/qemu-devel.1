Received: from eggs.gnu.org ([2001:4830:134:3::10]:50771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fILY2-0004wf-85
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fILY1-0000L7-HV
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:02:26 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-17-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fc19008b-a91c-23c7-bbec-e6f8bbc2d744@redhat.com>
Date: Mon, 14 May 2018 18:02:19 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-17-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/42] job: Add Job.aio_context
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
> When block jobs need an AioContext, they just take it from their main
> block node. Generic jobs don't have a main block node, so we need to
> assign them an AioContext explicitly.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Nothing uses the field yet, but so far so good.

Reviewed-by: John Snow <jsnow@redhat.com>
