Received: from eggs.gnu.org ([2001:4830:134:3::10]:55873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew2bC-0007ud-9a
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew2bA-0005to-T2
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 05:21:30 -0400
Date: Wed, 14 Mar 2018 09:20:59 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180314092058.GA3006@work-vm>
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>
	<152096780751.39.15281812348627104231@71c20359a636>
	<DB6PR0801MB20563C8F2FAF24F77D3101A5C1D20@DB6PR0801MB2056.eurprd08.prod.outlook.com>
	<20180313201023.GP3545@work-vm>
	<76133c4e.1db4b.16222efdca4.Coremail.suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76133c4e.1db4b.16222efdca4.Coremail.suhang16@mails.ucas.ac.cn>
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
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: eblake@redhat.com, vladimir sementsov-ogievskiy <vsementsov@virtuozzo.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, denis lunev <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

* Su Hang (suhang16@mails.ucas.ac.cn) wrote:
>=20
> Sincerely sorry for my negligence to cause this bug!
> I will fix it as quick as I can!
>=20
> Sorry again, I'm really ashamed about the mistake I have made.

No need to be ashamed; bugs happen!

Dave

> Su Hang
>=20
> > -----Original Messages-----
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Sent Time: 2018-03-14 04:10:24 (Wednesday)
> > To: "Vladimir Sementsov-Ogievskiy" <vsementsov@virtuozzo.com>, suhang=
16@mails.ucas.ac.cn, eblake@redhat.com
> > Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Denis Lun=
ev" <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,=
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com" <ar=
mbru@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "jsnow@red=
hat.com" <jsnow@redhat.com>
> > Subject: Re: [Qemu-devel] [PATCH v11 00/13] Dirty bitmaps postcopy mi=
gration
> >=20
> > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > > It looks like a bug in a recent commit to checkpatch. It don't supp=
ort do { } while
> >=20
> > Yes, adding Su Hang and Eric in and trimming some others out.
> > So yes, ignore this patchew failure for this case, but we need to fix
> > that separately.
> >=20
> > Dave
> >=20
> > >=20
> > > Best regards,
> > >=20
> > > Vladimir.
> > >=20
> > > ________________________________
> > > =D0=9E=D1=82: no-reply@patchew.org <no-reply@patchew.org>
> > > =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 13 =D0=
=BC=D0=B0=D1=80=D1=82=D0=B0 2018 =D0=B3. 22:03:29
> > > =D0=9A=D0=BE=D0=BC=D1=83: Vladimir Sementsov-Ogievskiy
> > > =D0=9A=D0=BE=D0=BF=D0=B8=D1=8F: famz@redhat.com; qemu-block@nongnu.=
org; qemu-devel@nongnu.org; kwolf@redhat.com; peter.maydell@linaro.org; V=
ladimir Sementsov-Ogievskiy; famz@redhat.com; lirans@il.ibm.com; quintela=
@redhat.com; jsnow@redhat.com; armbru@redhat.com; mreitz@redhat.com; stef=
anha@redhat.com; Denis Lunev; amit.shah@redhat.com; pbonzini@redhat.com; =
dgilbert@redhat.com
> > > =D0=A2=D0=B5=D0=BC=D0=B0: Re: [Qemu-devel] [PATCH v11 00/13] Dirty =
bitmaps postcopy migration
> > >=20
> > > Hi,
> > >=20
> > > This series seems to have some coding style problems. See output be=
low for
> > > more information:
> > >=20
> > > Type: series
> > > Message-id: 20180313180320.339796-1-vsementsov@virtuozzo.com
> > > Subject: [Qemu-devel] [PATCH v11 00/13] Dirty bitmaps postcopy migr=
ation
> > >=20
> > > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > > #!/bin/bash
> > >=20
> > > BASE=3Dbase
> > > n=3D1
> > > total=3D$(git log --oneline $BASE.. | wc -l)
> > > failed=3D0
> > >=20
> > > git config --local diff.renamelimit 0
> > > git config --local diff.renames True
> > > git config --local diff.algorithm histogram
> > >=20
> > > commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> > > for c in $commits; do
> > >     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c=
)..."
> > >     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --m=
ailback -; then
> > >         failed=3D1
> > >         echo
> > >     fi
> > >     n=3D$((n+1))
> > > done
> > >=20
> > > exit $failed
> > > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> > >=20
> > > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > > From https://github.com/patchew-project/qemu
> > >  * [new tag]               patchew/20180313180320.339796-1-vsements=
ov@virtuozzo.com -> patchew/20180313180320.339796-1-vsementsov@virtuozzo.=
com
> > > Auto packing the repository in background for optimum performance.
> > > See "git help gc" for manual housekeeping.
> > > Switched to a new branch 'test'
> > > 71e03c4ecc iotests: add dirty bitmap postcopy test
> > > daa548f79f iotests: add dirty bitmap migration test
> > > 353c5fdae1 migration: add postcopy migration of dirty bitmaps
> > > 1da07d4ba2 migration: allow qmp command migrate-start-postcopy for =
any postcopy
> > > b789a2887e migration: add is_active_iterate handler
> > > 48eb14f856 migration/qemu-file: add qemu_put_counted_string()
> > > 1d6549dae1 migration: include migrate_dirty_bitmaps in migrate_post=
copy
> > > e9e40af39a qapi: add dirty-bitmaps migration capability
> > > c575185038 migration: introduce postcopy-only pending
> > > 7cae35cd7c dirty-bitmap: add locked state
> > > 47bbd2a70c block/dirty-bitmap: add _locked version of bdrv_reclaim_=
dirty_bitmap
> > > 870ff1d916 block/dirty-bitmap: fix locking in bdrv_reclaim_dirty_bi=
tmap
> > > 5dca3ae226 block/dirty-bitmap: add bdrv_dirty_bitmap_enable_success=
or()
> > >=20
> > > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > > Checking PATCH 1/13: block/dirty-bitmap: add bdrv_dirty_bitmap_enab=
le_successor()...
> > > Checking PATCH 2/13: block/dirty-bitmap: fix locking in bdrv_reclai=
m_dirty_bitmap...
> > > Checking PATCH 3/13: block/dirty-bitmap: add _locked version of bdr=
v_reclaim_dirty_bitmap...
> > > Checking PATCH 4/13: dirty-bitmap: add locked state...
> > > Checking PATCH 5/13: migration: introduce postcopy-only pending...
> > > Checking PATCH 6/13: qapi: add dirty-bitmaps migration capability..=
.
> > > Checking PATCH 7/13: migration: include migrate_dirty_bitmaps in mi=
grate_postcopy...
> > > Checking PATCH 8/13: migration/qemu-file: add qemu_put_counted_stri=
ng()...
> > > Checking PATCH 9/13: migration: add is_active_iterate handler...
> > > Checking PATCH 10/13: migration: allow qmp command migrate-start-po=
stcopy for any postcopy...
> > > Checking PATCH 11/13: migration: add postcopy migration of dirty bi=
tmaps...
> > > ERROR: braces {} are necessary for all arms of this statement
> > > #737: FILE: migration/block-dirty-bitmap.c:690:
> > > +    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
> > > [...]
> > >=20
> > > total: 1 errors, 0 warnings, 816 lines checked
> > >=20
> > > Your patch has style problems, please review.  If any of these erro=
rs
> > > are false positives report them to the maintainer, see
> > > CHECKPATCH in MAINTAINERS.
> > >=20
> > > Checking PATCH 12/13: iotests: add dirty bitmap migration test...
> > > Checking PATCH 13/13: iotests: add dirty bitmap postcopy test...
> > > =3D=3D=3D OUTPUT END =3D=3D=3D
> > >=20
> > > Test command exited with code: 1
> > >=20
> > >=20
> > > ---
> > > Email generated automatically by Patchew [http://patchew.org/].
> > > Please send your feedback to patchew-devel@freelists.org
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
