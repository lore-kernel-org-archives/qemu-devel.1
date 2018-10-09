Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xJn-000236-Gg
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xJm-0007t8-5k
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:05:19 -0400
References: <20181009172501.17353-1-peter.maydell@linaro.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <dfa4ca15-2d7d-1c35-d674-352cbb9ed9ba@redhat.com>
Date: Tue, 9 Oct 2018 15:04:59 -0400
MIME-Version: 1.0
In-Reply-To: <20181009172501.17353-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] block/qcow*: Don't take
 address of fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 10/09/2018 01:24 PM, Peter Maydell wrote:
> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this. Avoid the bug by not using the
> "modify in place" byte swapping functions.
> 
> There are a few places in the affected files where the in-place swap
> function is used on something other than a packed struct field; we
> convert those anyway, for consistency.
> 
> Patches produced mechanically using spatch; in one case I also
> did a little hand-editing to wrap overlong lines that checkpatch
> would otherwise complain about.
> 
> (clang also complains about other files in block: vdi.c, vpc.c,
> vhdx.h, vhdx.c, vhdx-endian.c, vhdx-log.c -- I may produce patches
> for those later if nobody else gets there first.)
> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>   block/qcow2: Don't take address of fields in packed structs
>   block/qcow: Don't take address of fields in packed structs
>   block/qcow2-bitmap: Don't take address of fields in packed structs
> 
>  block/qcow.c         | 18 ++++++-------
>  block/qcow2-bitmap.c | 24 ++++++++---------
>  block/qcow2.c        | 64 +++++++++++++++++++++++---------------------
>  3 files changed, 55 insertions(+), 51 deletions(-)
> 

Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
