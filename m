Received: from eggs.gnu.org ([2001:4830:134:3::10]:43494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cypoj-00036g-HP
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 21:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cypoi-0005hl-Oy
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 21:14:29 -0400
References: <20170314023933.12118-1-famz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <63a9a137-2709-f936-7c7a-f11ace8fdc51@redhat.com>
Date: Thu, 13 Apr 2017 21:14:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170314023933.12118-1-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 0/3] block: Backdoor to
 skip image locking in qemu-io/qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 03/13/2017 10:39 PM, Fam Zheng wrote:
> Hi Kevin,
> 
> This tries to capture your idea to add a explicit command option in qemu-io and
> qemu-img for user to specify "expect inconsistent data when reading image".
> It's stored as a BDRV_O_ flag internally, I don't know if there is a cleaner
> way or not.
> 
> It's depended on by image locking series because several test cases need to be
> updated to use this flag.
> 
> Fam
> 
> Fam Zheng (3):
>   block: Introduce BDRV_O_UNSAFE_READ
>   qemu-img: Add --unsafe-read option to subcommands
>   qemu-io: Add --unsafe-read option
> 
>  block/block-backend.c |   2 +-
>  include/block/block.h |   1 +
>  qemu-img.c            | 148 ++++++++++++++++++++++++++++++++++++++------------
>  qemu-io.c             |  28 +++++++---
>  4 files changed, 137 insertions(+), 42 deletions(-)
> 

Month old with no replies or ping, DOA?

--js
