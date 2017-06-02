Received: from eggs.gnu.org ([2001:4830:134:3::10]:45440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGvza-0007OM-S5
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 19:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGvza-0006ws-1t
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 19:28:30 -0400
References: <1496437930-12654-1-git-send-email-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <714c3518-599c-ca95-6fb4-ab639e486479@redhat.com>
Date: Fri, 2 Jun 2017 19:28:19 -0400
MIME-Version: 1.0
In-Reply-To: <1496437930-12654-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] commit: Fix use after
 free in completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com



On 06/02/2017 05:12 PM, Kevin Wolf wrote:
> Kevin Wolf (2):
>   commit: Fix use after free in completion
>   qemu-iotests: Test automatic commit job cancel on hot unplug
> 
>  block/commit.c             |  7 +++++++
>  tests/qemu-iotests/040     | 35 +++++++++++++++++++++++++++++++++--
>  tests/qemu-iotests/040.out |  4 ++--
>  3 files changed, 42 insertions(+), 4 deletions(-)
> 

Reviewed-by: John Snow <jsnow@redhat.com>
