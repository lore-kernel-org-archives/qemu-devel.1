Received: from eggs.gnu.org ([2001:4830:134:3::10]:55481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eCpR6-0004mO-UA
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eCpR0-0006Zg-W0
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:12:12 -0500
References: <cover.1510059970.git.jcody@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <f65bca5a-c43b-b703-501b-4be0b0d815c8@openvz.org>
Date: Thu, 9 Nov 2017 19:11:58 +0300
MIME-Version: 1.0
In-Reply-To: <cover.1510059970.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 0/4] Don't write headers if BDS is
 INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, stefanha@redhat.com

On 11/07/2017 04:10 PM, Jeff Cody wrote:
> Changes from v3->v4:
>
> Patch 3: Add migrate_del_blocker and error_free (Thanks Stefan)
>
>
> git-backport-diff -r qemu/master.. -u ba11b69
>
> 001/4:[----] [--] 'block/vhdx.c: Don't blindly update the header'
> 002/4:[----] [--] 'block/parallels: Do not update header or truncate image when INMIGRATE'
> 003/4:[0003] [FC] 'block/parallels: add migration blocker'
> 004/4:[----] [--] 'qemu-iotests: update unsupported image formats in 194'
>
>
> Changes from v2->v3:
>
> Patch 2: Uh... fix that misspelling.  Thanks Stefan :)
> Patch 3: New patch to block migration in parallels
>
> git-backport-diff -r qemu/master.. -u 6dc6acb
>
> 001/4:[----] [--] 'block/vhdx.c: Don't blindly update the header'
> 002/4:[----] [--] 'block/parallels: Do not update header or truncate image when INMIGRATE'
> 003/4:[down] 'block/parallels: add migration blocker'
> 004/4:[----] [--] 'qemu-iotests: update unsupported image formats in 194'
>
>
> Changes from v1->v2:
>
> * Drop previous parallels patches, just check BDRV_O_INACTIVE now
>   (Kevin)
>
> git-backport-diff -r qemu/master.. -u github/master
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>
> 001/3:[----] [--] 'block/vhdx.c: Don't blindly update the header'
> 002/3:[down] 'block/parallals: Do not update header or truncate image when INMIGRATE'
> 003/3:[----] [--] 'qemu-iotests: update unsupported image formats in 194'
>
>
> v1:
>
> VHDX and Parallels both blindly write headers to the image file
> if the images are opened R/W.  This causes an assert if the QEMU run
> state is INMIGRATE.
>
> Jeff Cody (4):
>   block/vhdx.c: Don't blindly update the header
>   block/parallels: Do not update header or truncate image when INMIGRATE
>   block/parallels: add migration blocker
>   qemu-iotests: update unsupported image formats in 194
>
>  block/parallels.c      | 22 +++++++++++++++++-----
>  block/vhdx.c           |  7 -------
>  tests/qemu-iotests/194 |  2 +-
>  3 files changed, 18 insertions(+), 13 deletions(-)
>
Reviewed-by: Denis V. Lunev <den@openvz.org>
