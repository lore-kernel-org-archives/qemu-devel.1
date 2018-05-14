Received: from eggs.gnu.org ([2001:4830:134:3::10]:37394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIMoS-0004iw-6t
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIMoR-0004dn-E4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 19:23:28 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-21-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2bb84732-dba5-7f1b-c933-e5639815a811@redhat.com>
Date: Mon, 14 May 2018 19:23:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-21-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/42] job: Move pause/resume functions to
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



On 05/09/2018 12:26 PM, Kevin Wolf wrote:
> While we already moved the state related to job pausing to Job, the
> functions to do were still BlockJob only. This commit moves them over to
> Job.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

I'm slightly sad about the new callback, because it still seems silly to
have to specify something that's enforced with an assertion to be
ubiquitously true, but I think any other way of fixing that is probably
uglier.

So OK.

Reviewed-by: John Snow <jsnow@redhat.com>
