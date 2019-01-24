Received: from eggs.gnu.org ([209.51.188.92]:45144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmccr-0002Cn-J6
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:52:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmccp-0002xR-Eg
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:52:49 -0500
Date: Thu, 24 Jan 2019 10:52:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190124105230.GC2101@work-vm>
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
	<6325d205-774f-865b-1351-8a7e675bebf7@virtuozzo.com>
	<ad03195b-04fb-3e87-25f3-b974d9971d57@virtuozzo.com>
	<20190124101046.GB2404@work-vm>
	<49df4ecc-50c1-fd41-e6a3-87aadae5e4c8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <49df4ecc-50c1-fd41-e6a3-87aadae5e4c8@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Luiz Capitulino <lcapitulino@redhat.com>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 24.01.2019 13:10, Dr. David Alan Gilbert wrote:
> > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> >> 24.01.2019 12:29, Vladimir Sementsov-Ogievskiy wrote:
> >>> 23.01.2019 18:48, Max Reitz wrote:
> >>>> Hi,
> >>>>
> >>>> When running 169 in parallel (e.g. like so:
> >>>>
> >>>> $ while TEST_DIR=3D/tmp/t0 ./check -T -qcow2 169; do; done
> >>>> $ while TEST_DIR=3D/tmp/t1 ./check -T -qcow2 169; do; done
> >>>> $ while TEST_DIR=3D/tmp/t2 ./check -T -qcow2 169; do; done
> >>>> $ while TEST_DIR=3D/tmp/t3 ./check -T -qcow2 169; do; done
> >>>>
> >>>> in four different shells), I get aborts:
> >>>>
> >>>> (Often I get segfaults, but that's because of
> >>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.h=
tml --
> >>>> feel free to apply the attached patch to make them go away)
> >>>>
> >>>>
> >>>> WARNING:qemu:qemu received signal 6:
> >>>> build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
> >>>> -chardev socket,id=3Dmon,path=3D/tmp/t0/tmpbX30XU/qemua-25745-moni=
tor.sock
> >>>> -mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
> >>>> unix:path=3D/tmp/t0/qemua-25745-qtest.sock -machine accel=3Dqtest
> >>>> -nodefaults -machine accel=3Dqtest -drive
> >>>> if=3Dvirtio,id=3Ddrive0,file=3D/tmp/t0/disk_a,format=3Dqcow2,cache=
=3Dwriteback
> >>>> .................E..
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> ERROR:
> >>>> test_do_test_migration_resume_source_not_persistent__not_migbitmap
> >>>> (__main__.TestDirtyBitmapMigration)
> >>>> ------------------------------------------------------------------=
----
> >>>> Traceback (most recent call last):
> >>>>  =A0=A0 File "169", line 206, in <lambda>
> >>>>  =A0=A0=A0=A0 setattr(klass, 'test_' + method + name, lambda self:=
 mc(self))
> >>>>  =A0=A0 File "169", line 113, in do_test_migration_resume_source
> >>>>  =A0=A0=A0=A0 self.check_bitmap(self.vm_a, sha256)
> >>>>  =A0=A0 File "169", line 72, in check_bitmap
> >>>>  =A0=A0=A0=A0 node=3D'drive0', name=3D'bitmap0')
> >>>>  =A0=A0 File "tests/qemu-iotests/../../scripts/qemu.py", line 369,=
 in qmp
> >>>>  =A0=A0=A0=A0 return self._qmp.cmd(cmd, args=3Dqmp_args)
> >>>>  =A0=A0 File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 1=
91, in cmd
> >>>>  =A0=A0=A0=A0 return self.cmd_obj(qmp_cmd)
> >>>>  =A0=A0 File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 1=
74, in cmd_obj
> >>>>  =A0=A0=A0=A0 resp =3D self.__json_read()
> >>>>  =A0=A0 File "tests/qemu-iotests/../../scripts/qmp/qmp.py", line 8=
2, in
> >>>> __json_read
> >>>>  =A0=A0=A0=A0 data =3D self.__sockfile.readline()
> >>>>  =A0=A0 File "/usr/lib64/python2.7/socket.py", line 451, in readli=
ne
> >>>>  =A0=A0=A0=A0 data =3D self._sock.recv(self._rbufsize)
> >>>> error: [Errno 104] Connection reset by peer
> >>>>
> >>>> ------------------------------------------------------------------=
----
> >>>> Ran 20 tests
> >>>>
> >>>> FAILED (errors=3D1)
> >>>>
> >>>>
> >>>> Or:
> >>>>
> >>>> WARNING:qemu:qemu received signal 6:
> >>>> build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
> >>>> -chardev socket,id=3Dmon,path=3D/tmp/t3/tmp0pllWD/qemua-3445-monit=
or.sock
> >>>> -mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
> >>>> unix:path=3D/tmp/t3/qemua-3445-qtest.sock -machine accel=3Dqtest -=
nodefaults
> >>>> -machine accel=3Dqtest -drive
> >>>> if=3Dvirtio,id=3Ddrive0,file=3D/tmp/t3/disk_a,format=3Dqcow2,cache=
=3Dwriteback
> >>>> WARNING:qemu:qemu received signal 6:
> >>>> build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64
> >>>> -chardev socket,id=3Dmon,path=3D/tmp/t3/tmp0pllWD/qemua-3445-monit=
or.sock
> >>>> -mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
> >>>> unix:path=3D/tmp/t3/qemua-3445-qtest.sock -machine accel=3Dqtest -=
nodefaults
> >>>> -machine accel=3Dqtest -drive
> >>>> if=3Dvirtio,id=3Ddrive0,file=3D/tmp/t3/disk_a,format=3Dqcow2,cache=
=3Dwriteback
> >>>>
> >>>> ...................F
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> FAIL: test_do_test_migration_resume_source_persistent__not_migbitm=
ap
> >>>> (__main__.TestDirtyBitmapMigration)
> >>>> ------------------------------------------------------------------=
----
> >>>> Traceback (most recent call last):
> >>>>  =A0=A0 File "169", line 206, in <lambda>
> >>>>  =A0=A0=A0=A0 setattr(klass, 'test_' + method + name, lambda self:=
 mc(self))
> >>>>  =A0=A0 File "169", line 125, in do_test_migration_resume_source
> >>>>  =A0=A0=A0=A0 self.assertEqual(log, '')
> >>>> AssertionError: "qemu-system-x86_64: invalid runstate transition:
> >>>> 'running' -> 'postmigrate'\n" !=3D ''
> >>>>
> >>>> ------------------------------------------------------------------=
----
> >>>> Ran 20 tests
> >>>>
> >>>> FAILED (failures=3D1)
> >>>>
> >>>>
> >>>> The backtrace always goes like this:
> >>>>
> >>>> (gdb) bt
> >>>> #0=A0 0x00007f0acf5cc53f in raise () at /lib64/libc.so.6
> >>>> #1=A0 0x00007f0acf5b6895 in abort () at /lib64/libc.so.6
> >>>> #2=A0 0x000055a46ebbb1a6 in runstate_set (new_state=3DRUN_STATE_PO=
STMIGRATE)
> >>>> at vl.c:742
> >>>> #3=A0 0x000055a46ebbb1a6 in runstate_set
> >>>> (new_state=3Dnew_state@entry=3DRUN_STATE_POSTMIGRATE) at vl.c:730
> >>>> #4=A0 0x000055a46ed39129 in migration_iteration_finish (s=3D0x55a4=
708be000)
> >>>> at migration/migration.c:2972
> >>>> #5=A0 0x000055a46ed39129 in migration_thread
> >>>> (opaque=3Dopaque@entry=3D0x55a4708be000) at migration/migration.c:=
3130
> >>>> #6=A0 0x000055a46eea665a in qemu_thread_start (args=3D<optimized o=
ut>) at
> >>>> util/qemu-thread-posix.c:502
> >>>>
> >>>>
> >>>> #7=A0 0x00007f0acf76258e in start_thread () at /lib64/libpthread.s=
o.0
> >>>> #8=A0 0x00007f0acf6916a3 in clone () at /lib64/libc.so.6
> >>>> (gdb) frame 2
> >>>> #2=A0 0x000055a46ebbb1a6 in runstate_set (new_state=3DRUN_STATE_PO=
STMIGRATE)
> >>>> at vl.c:742
> >>>> 742=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 abort();
> >>>> (gdb) print current_run_state
> >>>> $1 =3D RUN_STATE_RUNNING
> >>>>
> >>>>
> >>>> Neither of migration or runstates are my strong suite, so I though=
t I'd
> >>>> report it before diving into it.
> >>>>
> >>>> Max
> >>>>
> >>>
> >>> [...]
> >>> 450556@1548321072.888979:migrate_set_state new state active
> >>> 450556@1548321072.889022:migration_thread_setup_complete
> >>> 450556@1548321072.988275:migrate_transferred transferred 985298 tim=
e_spent 100 bandwidth 9852 max_size 2955894
> >>> 450556@1548321072.988283:migration_bitmap_sync_start
> >>> 450556@1548321072.988293:migration_bitmap_sync_end dirty_pages 3289=
8
> >>> 450556@1548321072.988495:migration_thread_low_pending 2048
> >>> migration_completion
> >>> 450556@1548321072.988541:runstate_set current_state 9 new_state 7
> >>> 450556@1548321072.988780:migration_bitmap_sync_start
> >>> 450556@1548321072.988790:migration_bitmap_sync_end dirty_pages 3289=
8
> >>> 450556@1548321072.993112:migrate_global_state_pre_save saved state:=
 running
> >>> [1] 450556@1548321072.993237:migrate_set_state new state completed
> >>> 450549@1548321072.993668:handle_qmp_command mon 0x55aebef99830 req:=
 {"execute": "x-debug-block-dirty-bitmap-sha256", "arguments": {"name": "=
bitmap0", "node": "drive0"}}
> >>> 450556@1548321072.993697:migration_thread_after_loop
> >>> [2] 450549@1548321072.993917:handle_qmp_command mon 0x55aebef99830 =
req: {"execute": "cont"}
> >>> 450476@1548321072.994461:runstate_set current_state 7 new_state 9
> >>> qemu-system-x86_64: invalid runstate transition: 'running' -> 'post=
migrate'
> >>>
> >>>
> >>> Aha, so, in test we wait for MIGRATION COMPLETED [1] and run qmp_co=
nt [2] and go to RUNNING.
> >>> then in migration thread we go to migration_iteration_finish() and =
fail to go to POSTMIGRATE.
> >>> (note, that this testcase is about resuming source after migration)
> >>>
> >>> So, fix for test may be additionally wait for POSTMIGRATE, not only=
 for MIGRATION COMPLETION.
> >>>
> >>> But how to fix Qemu not to crash? May be, forbid some transitions (=
FINISH_MIGRATE -> RUNNING),
> >>>   =A0or at least error-out qmp_cont if runstate is=A0 FINISH_MIGRAT=
E?
> >>>
> >>>
> >>>
> >>
> >>
> >> Ok, this seems to fix test for me:
> >>
> >> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
> >> index 527aebd0cb..dd98168c8d 100755
> >> --- a/tests/qemu-iotests/169
> >> +++ b/tests/qemu-iotests/169
> >> @@ -102,6 +102,10 @@ class TestDirtyBitmapMigration(iotests.QMPTestC=
ase):
> >>                event =3D self.vm_a.event_wait('MIGRATION')
> >>                if event['data']['status'] =3D=3D 'completed':
> >>                    break
> >> +        while True:
> >> +            result =3D self.vm_a.qmp('query-status')
> >> +            if (result['return']['status'] =3D=3D 'postmigrate'):
> >> +                break
> >=20
> > Hmm; I can see that it might help; although I still can't quite see
> > how the bad transition that was reported can have happened.
> >=20
>=20
> It can be assumed from my trace above:
>=20
> 1. migration thread do migratioN_completion and goes to RUN_STATE_FINIS=
H_MIGRATE through vm_stop_force_state(RUN_STATE_FINISH_MIGRATE)
> 2. migration_completion do
>          migrate_set_state(&s->state, current_active_state,
>                              MIGRATION_STATUS_COMPLETED);
>     and MIGRATION COMPLETED event is reported, so
> 3. 169 iotest gets event, and think that all is done about migration. A=
nd it call qmp_cont
> 4. qmp_cont do transition from RUN_STATE_FINISH_MIGRATE to RUN_STATE_RU=
NNING
> 5. migration thread goes to migration_iteration_finish and do invalid t=
ransition

Yes, agreed.

Dave

>=20
> >=20
> >>            # test that bitmap is still here
> >>            removed =3D (not migrate_bitmaps) and persistent
> >>
> >> -
> >>
> >>
> >> And this is the full diff of the test I used, to skip checking log (=
as I enabled traces) and to skip all other test-cases:
> >>
> >> (hmm, we definitely need simple way to run one test case from test, =
without editing it)
> >>
> >> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
> >> index 527aebd0cb..dd98168c8d 100755
> >> --- a/tests/qemu-iotests/169
> >> +++ b/tests/qemu-iotests/169
> >> @@ -102,6 +102,10 @@ class TestDirtyBitmapMigration(iotests.QMPTestC=
ase):
> >>                event =3D self.vm_a.event_wait('MIGRATION')
> >>                if event['data']['status'] =3D=3D 'completed':
> >>                    break
> >> +        while True:
> >> +            result =3D self.vm_a.qmp('query-status')
> >> +            if (result['return']['status'] =3D=3D 'postmigrate'):
> >> +                break
> >>
> >>            # test that bitmap is still here
> >>            removed =3D (not migrate_bitmaps) and persistent
> >> @@ -117,12 +121,12 @@ class TestDirtyBitmapMigration(iotests.QMPTest=
Case):
> >>
> >>            # catch 'Could not reopen qcow2 layer: Bitmap already exi=
sts'
> >>            # possible error
> >> -        log =3D self.vm_a.get_log()
> >> -        log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
> >> -        log =3D re.sub(r'^(wrote .* bytes at offset .*\n.*KiB.*ops.=
*sec.*\n){3}',
> >> -                     '', log)
> >> -        log =3D re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
> >> -        self.assertEqual(log, '')
> >> +        #log =3D self.vm_a.get_log()
> >> +        #log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
> >> +        #log =3D re.sub(r'^(wrote .* bytes at offset .*\n.*KiB.*ops=
.*sec.*\n){3}',
> >> +                     #'', log)
> >> +        #log =3D re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
> >> +        #self.assertEqual(log, '')
> >>
> >>            # test that bitmap is still persistent
> >>            self.vm_a.launch()
> >> @@ -211,14 +215,16 @@ for cmb in list(itertools.product((True, False=
), repeat=3D4)):
> >>        name +=3D '_online' if cmb[2] else '_offline'
> >>        name +=3D '_shared' if cmb[3] else '_nonshared'
> >>
> >> -    inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migra=
tion',
> >> +    if False:
> >> +        inject_test_case(TestDirtyBitmapMigration, name, 'do_test_m=
igration',
> >>                         *list(cmb))
> >>
> >>    for cmb in list(itertools.product((True, False), repeat=3D2)):
> >>        name =3D ('_' if cmb[0] else '_not_') + 'persistent_'
> >>        name +=3D ('_' if cmb[1] else '_not_') + 'migbitmap'
> >>
> >> -    inject_test_case(TestDirtyBitmapMigration, name,
> >> +    if name =3D=3D '_persistent__migbitmap':
> >> +        inject_test_case(TestDirtyBitmapMigration, name,
> >>                         'do_test_migration_resume_source', *list(cmb=
))
> >>
> >>    if __name__ =3D=3D '__main__':
> >> diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
> >> index 3a89159833..ae1213e6f8 100644
> >> --- a/tests/qemu-iotests/169.out
> >> +++ b/tests/qemu-iotests/169.out
> >> @@ -1,5 +1,5 @@
> >> -....................
> >> +.
> >>    -----------------------------------------------------------------=
-----
> >> -Ran 20 tests
> >> +Ran 1 tests
> >>
> >>    OK
> >>
> >>
> >>
> >> --=20
> >> Best regards,
> >> Vladimir
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
>=20
> --=20
> Best regards,
> Vladimir
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
