Received: from eggs.gnu.org ([2001:4830:134:3::10]:51031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLAZ-0007Y6-0M
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLAY-0008Ha-77
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:35:31 -0400
References: <20180228180507.3964-1-mreitz@redhat.com>
	<20180228180507.3964-16-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fea69d15-d7e4-6772-c583-c224b3dbe4a1@redhat.com>
Date: Tue, 20 Mar 2018 12:35:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180228180507.3964-16-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/16] block/mirror: Add copy mode QAPI
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On 02/28/2018 12:05 PM, Max Reitz wrote:
> This patch allows the user to specify whether to use active or only
> background mode for mirror block jobs.  Currently, this setting will
> remain constant for the duration of the entire block job.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/block-core.json      | 11 +++++++++--
>   include/block/block_int.h |  4 +++-
>   block/mirror.c            | 12 +++++++-----
>   blockdev.c                |  9 ++++++++-
>   4 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c73b769c27..1186c007ae 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1573,6 +1573,9 @@
>   #         written. Both will result in identical contents.
>   #         Default is true. (Since 2.4)
>   #
> +# @copy-mode: when to copy data to the destination; defaults to 'background'
> +#             (Since: 2.12)
> +#

Are we still aiming for 2.12, or is this a feature which missed 
softfreeze and should therefore be 2.13?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
