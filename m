Received: from eggs.gnu.org ([2001:4830:134:3::10]:51199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cym1D-0005Ed-Pc
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cym1C-00080l-Qa
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:11:07 -0400
References: <20170207235757.2026-1-mreitz@redhat.com>
	<efaef6ef-a1a5-a767-72a6-8c93ba0d9dd1@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <15602fea-b24c-83c4-ea7e-6aa56558e535@redhat.com>
Date: Thu, 13 Apr 2017 17:11:02 -0400
MIME-Version: 1.0
In-Reply-To: <efaef6ef-a1a5-a767-72a6-8c93ba0d9dd1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] progress: Show current
 progress on SIGINFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 04/13/2017 04:38 PM, Max Reitz wrote:
> On 08.02.2017 00:57, Max Reitz wrote:
>> Currently we only print progress information on retrieval of SIGUSR1.
>> Some systems have a dedicated SIGINFO for this, however, so it should be
>> handled appropriately if it is available.
>>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1662468
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> Can anyone test this on a BSD system? O:-)
>> ---
>>  util/qemu-progress.c | 3 +++
>>  qemu-img.texi        | 3 ++-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> Ping
> 
> (If nobody replies in the next month or so, I'm just going to merge
> this, as util/qemu-progress.c doesn't have a maintainer.)
> 

https://www.youtube.com/watch?v=vU54c3YDyak
