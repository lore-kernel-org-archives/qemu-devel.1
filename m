Received: from eggs.gnu.org ([2001:4830:134:3::10]:49184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIIvJ-00026c-IX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIIvI-0004HC-N1
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:14:17 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-3-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8993ef0f-1a9d-1166-0df2-e06d8e746004@redhat.com>
Date: Mon, 14 May 2018 15:14:09 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/42] blockjob: Wrappers for progress
 counter access
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



On 05/09/2018 12:25 PM, Kevin Wolf wrote:
> Block job drivers are not expected to mess with the internals of the
> BlockJob object, so provide wrapper functions for one of the cases where
> they still do it: Updating the progress counter.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

The backup code takes a hot second to read, but it seems correct. Having
both a common len and a backup len is a bit awful, but only in this
patch diff where you have to deal with both.

Reviewed-by: John Snow <jsnow@redhat.com>
