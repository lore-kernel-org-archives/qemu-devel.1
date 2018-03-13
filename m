Received: from eggs.gnu.org ([2001:4830:134:3::10]:45898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evq7U-0006sJ-Ku
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evq7R-0001AS-C1
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:02:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Mar 2018 20:01:52 +0000
Message-ID: <DB6PR0801MB20563C8F2FAF24F77D3101A5C1D20@DB6PR0801MB2056.eurprd08.prod.outlook.com>
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>,
	<152096780751.39.15281812348627104231@71c20359a636>
In-Reply-To: <152096780751.39.15281812348627104231@71c20359a636>
Content-Language: ru-RU
MIME-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 00/13] Dirty bitmaps postcopy migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "lirans@il.ibm.com" <lirans@il.ibm.com>, "quintela@redhat.com" <quintela@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>

It looks like a bug in a recent commit to checkpatch. It don't support do {=
 } while


Best regards,

Vladimir.

________________________________
=EF=D4: no-reply@patchew.org <no-reply@patchew.org>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 13 =CD=C1=D2=D4=C1 2018 =C7. 22:03:29
=EB=CF=CD=D5: Vladimir Sementsov-Ogievskiy
=EB=CF=D0=C9=D1: famz@redhat.com; qemu-block@nongnu.org; qemu-devel@nongnu.=
org; kwolf@redhat.com; peter.maydell@linaro.org; Vladimir Sementsov-Ogievsk=
iy; famz@redhat.com; lirans@il.ibm.com; quintela@redhat.com; jsnow@redhat.c=
om; armbru@redhat.com; mreitz@redhat.com; stefanha@redhat.com; Denis Lunev;=
 amit.shah@redhat.com; pbonzini@redhat.com; dgilbert@redhat.com
=F4=C5=CD=C1: Re: [Qemu-devel] [PATCH v11 00/13] Dirty bitmaps postcopy mig=
ration

Hi,

This series seems to have some coding style problems. See output below for
more information:

Type: series
Message-id: 20180313180320.339796-1-vsementsov@virtuozzo.com
Subject: [Qemu-devel] [PATCH v11 00/13] Dirty bitmaps postcopy migration

=3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
#!/bin/bash

BASE=3Dbase
n=3D1
total=3D$(git log --oneline $BASE.. | wc -l)
failed=3D0

git config --local diff.renamelimit 0
git config --local diff.renames True
git config --local diff.algorithm histogram

commits=3D"$(git log --format=3D%H --reverse $BASE..)"
for c in $commits; do
    echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
    if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailback =
-; then
        failed=3D1
        echo
    fi
    n=3D$((n+1))
done

exit $failed
=3D=3D=3D TEST SCRIPT END =3D=3D=3D

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>From https://github.com/patchew-project/qemu
 * [new tag]               patchew/20180313180320.339796-1-vsementsov@virtu=
ozzo.com -> patchew/20180313180320.339796-1-vsementsov@virtuozzo.com
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
Switched to a new branch 'test'
71e03c4ecc iotests: add dirty bitmap postcopy test
daa548f79f iotests: add dirty bitmap migration test
353c5fdae1 migration: add postcopy migration of dirty bitmaps
1da07d4ba2 migration: allow qmp command migrate-start-postcopy for any post=
copy
b789a2887e migration: add is_active_iterate handler
48eb14f856 migration/qemu-file: add qemu_put_counted_string()
1d6549dae1 migration: include migrate_dirty_bitmaps in migrate_postcopy
e9e40af39a qapi: add dirty-bitmaps migration capability
c575185038 migration: introduce postcopy-only pending
7cae35cd7c dirty-bitmap: add locked state
47bbd2a70c block/dirty-bitmap: add _locked version of bdrv_reclaim_dirty_bi=
tmap
870ff1d916 block/dirty-bitmap: fix locking in bdrv_reclaim_dirty_bitmap
5dca3ae226 block/dirty-bitmap: add bdrv_dirty_bitmap_enable_successor()

=3D=3D=3D OUTPUT BEGIN =3D=3D=3D
Checking PATCH 1/13: block/dirty-bitmap: add bdrv_dirty_bitmap_enable_succe=
ssor()...
Checking PATCH 2/13: block/dirty-bitmap: fix locking in bdrv_reclaim_dirty_=
bitmap...
Checking PATCH 3/13: block/dirty-bitmap: add _locked version of bdrv_reclai=
m_dirty_bitmap...
Checking PATCH 4/13: dirty-bitmap: add locked state...
Checking PATCH 5/13: migration: introduce postcopy-only pending...
Checking PATCH 6/13: qapi: add dirty-bitmaps migration capability...
Checking PATCH 7/13: migration: include migrate_dirty_bitmaps in migrate_po=
stcopy...
Checking PATCH 8/13: migration/qemu-file: add qemu_put_counted_string()...
Checking PATCH 9/13: migration: add is_active_iterate handler...
Checking PATCH 10/13: migration: allow qmp command migrate-start-postcopy f=
or any postcopy...
Checking PATCH 11/13: migration: add postcopy migration of dirty bitmaps...
ERROR: braces {} are necessary for all arms of this statement
#737: FILE: migration/block-dirty-bitmap.c:690:
+    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
[...]

total: 1 errors, 0 warnings, 816 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Checking PATCH 12/13: iotests: add dirty bitmap migration test...
Checking PATCH 13/13: iotests: add dirty bitmap postcopy test...
=3D=3D=3D OUTPUT END =3D=3D=3D

Test command exited with code: 1


---
Email generated automatically by Patchew [http://patchew.org/].
Please send your feedback to patchew-devel@freelists.org
