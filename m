Received: from eggs.gnu.org ([209.51.188.92]:52311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2Mgg-00033V-Lu
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2Mga-0006fq-Qs
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:05:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2Mga-0006e4-2Z
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 16:05:44 -0500
References: <155207840014.8146.15614871827520628296@6acff2cf482b>
From: John Snow <jsnow@redhat.com>
Message-ID: <8c73e40e-a272-aa39-85ea-bde887c59ab7@redhat.com>
Date: Fri, 8 Mar 2019 16:05:40 -0500
MIME-Version: 1.0
In-Reply-To: <155207840014.8146.15614871827520628296@6acff2cf482b>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/17] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org

Guess I'll fix these first, sorry for the noise.

On 3/8/19 3:53 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190308202858.26636-1-jsnow@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20190308202858.26636-1-jsnow@redhat.com
> Subject: [Qemu-devel] [PULL 00/17] Bitmaps patches
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  t [tag update]            patchew/20190308202858.26636-1-jsnow@redhat.com -> patchew/20190308202858.26636-1-jsnow@redhat.com
> Switched to a new branch 'test'
> d67d39e43b block/dirty-bitmaps: implement inconsistent bit
> cc50ffdaaa block/dirty-bitmaps: disallow busy bitmaps as merge source
> fe93ecd8b1 block/dirty-bitmaps: prohibit removing readonly bitmaps
> 1d82e65c16 block/dirty-bitmaps: prohibit readonly bitmaps for backups
> 61c55a9de7 block/dirty-bitmaps: add block_dirty_bitmap_check function
> 4f1ceecd95 block/dirty-bitmap: add inconsistent status
> 9d5d76cbd6 block/dirty-bitmaps: add inconsistent bit
> bdc998d9d5 iotests: add busy/recording bit test to 124
> 22c03a2fd5 blockdev: remove unused paio parameter documentation
> d74e8a7202 block/dirty-bitmaps: move comment block
> 8ea8b7a875 block/dirty-bitmaps: unify qmp_locked and user_locked calls
> ae989ad6ff block/dirty-bitmap: explicitly lock bitmaps with successors
> 6c71258b44 nbd: change error checking order for bitmaps
> cf861d0168 block/dirty-bitmap: change semantics of enabled predicate
> 5ba70dfbcf block/dirty-bitmap: remove set/reset assertions against enabled bit
> 83886ed7db block/dirty-bitmaps: rename frozen predicate helper
> 0e38e3ff4f block/dirty-bitmap: add recording and busy properties
> 
> === OUTPUT BEGIN ===
> 1/17 Checking commit 0e38e3ff4ff4 (block/dirty-bitmap: add recording and busy properties)
> 2/17 Checking commit 83886ed7db44 (block/dirty-bitmaps: rename frozen predicate helper)
> WARNING: line over 80 characters
> #87: FILE: block/dirty-bitmap.c:248:
> +        error_setg(errp, "Cannot create a successor for a bitmap that is in-use "
> 
> total: 0 errors, 1 warnings, 124 lines checked
> 
> Patch 2/17 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 3/17 Checking commit 5ba70dfbcf19 (block/dirty-bitmap: remove set/reset assertions against enabled bit)
> 4/17 Checking commit cf861d01687f (block/dirty-bitmap: change semantics of enabled predicate)
> 5/17 Checking commit 6c71258b445a (nbd: change error checking order for bitmaps)
> 6/17 Checking commit ae989ad6ffc7 (block/dirty-bitmap: explicitly lock bitmaps with successors)
> 7/17 Checking commit 8ea8b7a8757e (block/dirty-bitmaps: unify qmp_locked and user_locked calls)
> ERROR: open brace '{' following function declarations go on the next line
> #39: FILE: block/dirty-bitmap.c:190:
> +bool bdrv_dirty_bitmap_busy(BdrvDirtyBitmap *bitmap) {
> 
> total: 1 errors, 0 warnings, 271 lines checked
> 
> Patch 7/17 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 8/17 Checking commit d74e8a720254 (block/dirty-bitmaps: move comment block)
> 9/17 Checking commit 22c03a2fd589 (blockdev: remove unused paio parameter documentation)
> 10/17 Checking commit bdc998d9d5ed (iotests: add busy/recording bit test to 124)
> 11/17 Checking commit 9d5d76cbd6ca (block/dirty-bitmaps: add inconsistent bit)
> WARNING: Block comments use a leading /* on a separate line
> #26: FILE: block/dirty-bitmap.c:49:
> +    bool inconsistent;          /* bitmap is persistent, but inconsistent.
> 
> WARNING: Block comments use a trailing */ on a separate line
> #28: FILE: block/dirty-bitmap.c:51:
> +                                 * a QMP user can remove it. */
> 
> total: 0 errors, 2 warnings, 82 lines checked
> 
> Patch 11/17 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 12/17 Checking commit 4f1ceecd9528 (block/dirty-bitmap: add inconsistent status)
> 13/17 Checking commit 61c55a9de7e4 (block/dirty-bitmaps: add block_dirty_bitmap_check function)
> ERROR: open brace '{' following function declarations go on the next line
> #37: FILE: block/dirty-bitmap.c:177:
> +static bool bdrv_dirty_bitmap_busy(const BdrvDirtyBitmap *bitmap) {
> 
> WARNING: line over 80 characters
> #284: FILE: migration/block-dirty-bitmap.c:305:
> +            if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
> 
> total: 1 errors, 1 warnings, 236 lines checked
> 
> Patch 13/17 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 14/17 Checking commit 1d82e65c16d6 (block/dirty-bitmaps: prohibit readonly bitmaps for backups)
> 15/17 Checking commit fe93ecd8b1cd (block/dirty-bitmaps: prohibit removing readonly bitmaps)
> 16/17 Checking commit cc50ffdaaa38 (block/dirty-bitmaps: disallow busy bitmaps as merge source)
> 17/17 Checking commit d67d39e43b84 (block/dirty-bitmaps: implement inconsistent bit)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20190308202858.26636-1-jsnow@redhat.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 
