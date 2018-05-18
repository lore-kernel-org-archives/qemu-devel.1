Received: from eggs.gnu.org ([2001:4830:134:3::10]:52823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJkLv-0003aH-CT
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fJkLr-0005EE-Dn
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:43:43 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-14-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5e01cf18-680b-210f-ffa1-5b81d4fe22a3@redhat.com>
Date: Fri, 18 May 2018 14:43:36 -0400
MIME-Version: 1.0
In-Reply-To: <20180518132114.4070-14-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/40] job: Move coroutine and related
 code to Job
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
> This commit moves some core functions for dealing with the job coroutine
> from BlockJob to Job. This includes primarily entering the coroutine
> (both for the first and reentering) and yielding explicitly and at pause
> points.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

The _cond functions get shuffled around a bit, you address Max's
comments and otherwise it's the same as in V1.

Reviewed-by: John Snow <jsnow@redhat.com>
