Received: from eggs.gnu.org ([2001:4830:134:3::10]:34597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1mR-0003Ju-Pz
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1mQ-0002U0-W3
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:46:31 -0400
Date: Thu, 5 Jul 2018 12:46:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705104622.GF3309@localhost.localdomain>
References: <20180705092139.776069-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705092139.776069-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, mreitz@redhat.com, den@openvz.org

Am 05.07.2018 um 11:21 hat Vladimir Sementsov-Ogievskiy geschrieben:
> If it appropriate for 3.0, let's push it. If not - then for 3.1
> with fixed "since". Should I cc stable?
> 
> v3: - update Qcow2OverlapCheckFlags in qapi/block-core.json [Max]
> 
> v2: - squash 02 (indentation fix) to 01
>     - drop comment from qcow2_check_metadata_overlap()
>     - set @ign to QCOW2_OL_BITMAP_DIRECTORY for in-place case in
>       bitmap_list_store. I don't think non-inplace case should be changed,
>       as it don't touch active bitmap directory.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json   | 21 ++++++++++++---------
>  block/qcow2.h          | 45 ++++++++++++++++++++++++---------------------
>  block/qcow2-bitmap.c   |  7 ++++++-
>  block/qcow2-refcount.c | 10 ++++++++++
>  block/qcow2.c          | 22 ++++++++++++++--------
>  5 files changed, 66 insertions(+), 39 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 90e554ed0f..e7393e0313 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2695,18 +2695,21 @@
>  # @template: Specifies a template mode which can be adjusted using the other
>  #            flags, defaults to 'cached'
>  #
> +# @bitmap-directory: since 3.0
> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'Qcow2OverlapCheckFlags',
> -  'data': { '*template':       'Qcow2OverlapCheckMode',
> -            '*main-header':    'bool',
> -            '*active-l1':      'bool',
> -            '*active-l2':      'bool',
> -            '*refcount-table': 'bool',
> -            '*refcount-block': 'bool',
> -            '*snapshot-table': 'bool',
> -            '*inactive-l1':    'bool',
> -            '*inactive-l2':    'bool' } }
> +  'data': { '*template':        'Qcow2OverlapCheckMode',
> +            '*main-header':     'bool',
> +            '*active-l1':       'bool',
> +            '*active-l2':       'bool',
> +            '*refcount-table':  'bool',
> +            '*refcount-block':  'bool',
> +            '*snapshot-table':  'bool',
> +            '*inactive-l1':     'bool',
> +            '*inactive-l2':     'bool',
> +            '*bitmap-directory': 'bool' } }

Did you intend to add two spaces to each line? Because this still isn't
aligned to the same column.

Kevin
