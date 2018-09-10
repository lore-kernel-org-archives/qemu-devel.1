Received: from eggs.gnu.org ([2001:4830:134:3::10]:58399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzRp3-00075Y-1E
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 15:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzRoz-0006fg-P8
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 15:26:08 -0400
References: <20180802144834.520904-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f58d46ef-744b-e886-4b5b-a3dd2e2a57d8@redhat.com>
Date: Mon, 10 Sep 2018 15:25:58 -0400
MIME-Version: 1.0
In-Reply-To: <20180802144834.520904-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/4 for-3.0?] NBD fixes for
 unaligned images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

Hi, has this series been superseded or do we need a respin for 3.1?

(It's not quite been a month, but it caught my eye.)

--js

On 08/02/2018 10:48 AM, Eric Blake wrote:
> Rich reported a bug when using qemu as client to nbdkit serving
> a non-sector-aligned image; in turn, I found a second bug with
> qemu as server of such an image.
> 
> Both bugs were present in 2.12, and thus are not new regressions
> in 3.0. If there is a reason to spin -rc4, then these could be
> included; but this series alone is not a driving reason to cause
> -rc4.
> 
> Eric Blake (4):
>   block: Add bdrv_get_request_alignment()
>   nbd/server: Advertise actual minimum block size
>   iotests: Add 228 to test NBD on unaligned images
>   nbd/client: Deal with unaligned size from server
> 
>  include/sysemu/block-backend.h |  1 +
>  block/block-backend.c          |  7 +++
>  block/nbd.c                    | 11 ++++-
>  nbd/server.c                   | 10 +++--
>  tests/qemu-iotests/228         | 96 ++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/228.out     |  8 ++++
>  tests/qemu-iotests/group       |  1 +
>  7 files changed, 129 insertions(+), 5 deletions(-)
>  create mode 100755 tests/qemu-iotests/228
>  create mode 100644 tests/qemu-iotests/228.out
> 
