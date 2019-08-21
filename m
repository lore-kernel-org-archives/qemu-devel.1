Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBCEC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A9620870
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A9620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0OkO-000390-G6
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i0OfA-0004RX-SN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i0OYH-0002Uq-LJ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:13:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i0OYH-0002U9-Cu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:13:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4E0F8AC6F6;
 Wed, 21 Aug 2019 11:13:16 +0000 (UTC)
Received: from work-vm (ovpn-117-245.ams2.redhat.com [10.36.117.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9D505C221;
 Wed, 21 Aug 2019 11:13:15 +0000 (UTC)
Date: Wed, 21 Aug 2019 12:13:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yuchen <yu.chen@h3c.com>, jdenemar@redhat.com
Message-ID: <20190821111313.GA3351@work-vm>
References: <C25843086C0E6B4ABD8D1A14B0094D46013FECD0B6@H3CMLB12-EX.srv.huawei-3com.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C25843086C0E6B4ABD8D1A14B0094D46013FECD0B6@H3CMLB12-EX.srv.huawei-3com.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 21 Aug 2019 11:13:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [BUG] living migrate vm pause forever
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yuchen (yu.chen@h3c.com) wrote:
> Sometimes, living migrate vm pause forever, migrate job stop, but very =
small probability, I can=E2=80=99t reproduce.
> qemu wait semaphore from libvirt send migrate continue, however libvirt=
 wait semaphore from qemu send vm pause.

Hi,
  I've copied in Jiri Denemark from libvirt.
Can you confirm exactly which qemu and libvirt versions you're using
please.

> follow stack:
> qemu:
> Thread 6 (Thread 0x7f50445f3700 (LWP 18120)):
> #0  0x00007f504b84d670 in sem_wait () from /lib/x86_64-linux-gnu/libpth=
read.so.0
> #1  0x00005574eda1e164 in qemu_sem_wait (sem=3Dsem@entry=3D0x5574ef6930=
e0) at qemu-2.12/util/qemu-thread-posix.c:322
> #2  0x00005574ed8dd72e in migration_maybe_pause (s=3D0x5574ef692f50, cu=
rrent_active_state=3D0x7f50445f2ae4, new_state=3D10)
>     at qemu-2.12/migration/migration.c:2106
> #3  0x00005574ed8df51a in migration_completion (s=3D0x5574ef692f50) at =
qemu-2.12/migration/migration.c:2137
> #4  migration_iteration_run (s=3D0x5574ef692f50) at qemu-2.12/migration=
/migration.c:2311
> #5  migration_thread (opaque=3D0x5574ef692f50) atqemu-2.12/migration/mi=
gration.c:2415
> #6  0x00007f504b847184 in start_thread () from /lib/x86_64-linux-gnu/li=
bpthread.so.0
> #7  0x00007f504b574bed in clone () from /lib/x86_64-linux-gnu/libc.so.6

In migration_maybe_pause we have:

    migrate_set_state(&s->state, *current_active_state,
                      MIGRATION_STATUS_PRE_SWITCHOVER);
    qemu_sem_wait(&s->pause_sem);
    migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
                      new_state);

the line numbers don't match my 2.12.0 checkout; so I guess that it's
that qemu_sem_wait it's stuck at.

QEMU must have sent the switch to PRE_SWITCHOVER and that should have
sent an event to libvirt, and libvirt should notice that - I'm
not sure how to tell whether libvirt has seen that event yet or not?

Dave

> libvirt:
> Thread 95 (Thread 0x7fdb82ffd700 (LWP 28775)):
> #0  0x00007fdd177dc404 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/x=
86_64-linux-gnu/libpthread.so.0
> #1  0x00007fdd198c3b07 in virCondWait (c=3D0x7fdbc4003000, m=3D0x7fdbc4=
002f30) at ../../../src/util/virthread.c:252
> #2  0x00007fdd198f36d2 in virDomainObjWait (vm=3D0x7fdbc4002f20) at ../=
../../src/conf/domain_conf.c:3303
> #3  0x00007fdd09ffaa44 in qemuMigrationRun (driver=3D0x7fdd000037b0, vm=
=3D0x7fdbc4002f20, persist_xml=3D0x0,
>     cookiein=3D0x7fdb780084e0 "<qemu-migration>\n  <name>mss-pl_652</na=
me>\n  <uuid>1f2b2334-451e-424b-822a-ea10452abb38</uuid>\n  <hostname>mss=
 </hostname>\n  <hostuuid>334e344a-4130-4336-5534-323544543642</hostuuid>=
\n</qemu-migra"..., cookieinlen=3D207, cookieout=3D0x7fdb82ffcad0, cookie=
outlen=3D0x7fdb82ffcac8, flags=3D777,
>     resource=3D0, spec=3D0x7fdb82ffc670, dconn=3D0x0, graphicsuri=3D0x0=
, nmigrate_disks=3D0, migrate_disks=3D0x0, compression=3D0x7fdb78007990, =
migParams=3D0x7fdb82ffc900)
>     at ../../../src/qemu/qemu_migration.c:3937
> #4  0x00007fdd09ffb26a in doNativeMigrate (driver=3D0x7fdd000037b0, vm=3D=
0x7fdbc4002f20, persist_xml=3D0x0, uri=3D0x7fdb780073a0 "tcp://172.16.202=
.17:49152",
>     cookiein=3D0x7fdb780084e0 "<qemu-migration>\n  <name>mss-pl_652</na=
me>\n  <uuid>1f2b2334-451e-424b-822a-ea10452abb38</uuid>\n  <hostname>mss=
</hostname>\n  <hos---Type <return> to continue, or q <return> to quit---
> tuuid>334e344a-4130-4336-5534-323544543642</hostuuid>\n</qemu-migra"...=
, cookieinlen=3D207, cookieout=3D0x7fdb82ffcad0, cookieoutlen=3D0x7fdb82f=
fcac8, flags=3D777,
>     resource=3D0, dconn=3D0x0, graphicsuri=3D0x0, nmigrate_disks=3D0, m=
igrate_disks=3D0x0, compression=3D0x7fdb78007990, migParams=3D0x7fdb82ffc=
900)
>     at ../../../src/qemu/qemu_migration.c:4118
> #5  0x00007fdd09ffd808 in qemuMigrationPerformPhase (driver=3D0x7fdd000=
037b0, conn=3D0x7fdb500205d0, vm=3D0x7fdbc4002f20, persist_xml=3D0x0,
>     uri=3D0x7fdb780073a0 "tcp://172.16.202.17:49152", graphicsuri=3D0x0=
, nmigrate_disks=3D0, migrate_disks=3D0x0, compression=3D0x7fdb78007990, =
migParams=3D0x7fdb82ffc900,
>     cookiein=3D0x7fdb780084e0 "<qemu-migration>\n  <name>mss-pl_652</na=
me>\n  <uuid>1f2b2334-451e-424b-822a-ea10452abb38</uuid>\n  <hostname>mss=
</hostname>\n  <hostuuid>334e344a-4130-4336-5534-323544543642</hostuuid>\=
n</qemu-migra"..., cookieinlen=3D207, cookieout=3D0x7fdb82ffcad0, cookieo=
utlen=3D0x7fdb82ffcac8, flags=3D777,
>     resource=3D0) at ../../../src/qemu/qemu_migration.c:5030
> #6  0x00007fdd09ffdbb5 in qemuMigrationPerform (driver=3D0x7fdd000037b0=
, conn=3D0x7fdb500205d0, vm=3D0x7fdbc4002f20, xmlin=3D0x0, persist_xml=3D=
0x0, dconnuri=3D0x0,
>     uri=3D0x7fdb780073a0 "tcp://172.16.202.17:49152", graphicsuri=3D0x0=
, listenAddress=3D0x0, nmigrate_disks=3D0, migrate_disks=3D0x0, nbdPort=3D=
0, compression=3D0x7fdb78007990,
>     migParams=3D0x7fdb82ffc900,
>     cookiein=3D0x7fdb780084e0 "<qemu-migration>\n  <name>mss-pl_652</na=
me>\n  <uuid>1f2b2334-451e-424b-822a-ea10452abb38</uuid>\n  <hostname>mss=
</hostname>\n  <hostuuid>334e344a-4130-4336-5534-323544543642</hostuuid>\=
n</qemu-migra"..., cookieinlen=3D207, cookieout=3D0x7fdb82ffcad0, cookieo=
utlen=3D0x7fdb82ffcac8, flags=3D777,
>     dname=3D0x0, resource=3D0, v3proto=3Dtrue) at ../../../src/qemu/qem=
u_migration.c:5124
> #7  0x00007fdd0a054725 in qemuDomainMigratePerform3 (dom=3D0x7fdb78007b=
00, xmlin=3D0x0,
>     cookiein=3D0x7fdb780084e0 "<qemu-migration>\n  <name>mss-pl_652</na=
me>\n  <uuid>1f2b2334-451e-424b-822a-ea10452abb38</uuid>\n  <hostname>mss=
</hostname>\n  <hostuuid>334e344a-4130-4336-5534-323544543642</hostuuid>\=
n</qemu-migra"..., cookieinlen=3D207, cookieout=3D0x7fdb82ffcad0, cookieo=
utlen=3D0x7fdb82ffcac8, dconnuri=3D0x0,
>     uri=3D0x7fdb780073a0 "tcp://172.16.202.17:49152", flags=3D777, dnam=
e=3D0x0, resource=3D0) at ../../../src/qemu/qemu_driver.c:12996
> #8  0x00007fdd199ad0f0 in virDomainMigratePerform3 (domain=3D0x7fdb7800=
7b00, xmlin=3D0x0,
>     cookiein=3D0x7fdb780084e0 "<qemu-migration>\n  <name>mss-pl_652</na=
me>\n  <uuid>1f2b2334-451e-424b-822a-ea10452abb38</uuid>\n  <hostname>mss=
</hostname>\n  <hostuuid>334e344a-4130-4336-5534-323544543642</hostuuid>\=
n</qemu-migra"..., cookieinlen=3D207, cookieout=3D0x7fdb82ffcad0, cookieo=
utlen=3D0x7fdb82ffcac8, dconnuri=3D0x0,
>     uri=3D0x7fdb780073a0 "tcp://172.16.202.17:49152", flags=3D777, dnam=
e=3D0x0, bandwidth=3D0) at ../../../src/libvirt-domain.c:4698
> #9  0x000055d13923a939 in remoteDispatchDomainMigratePerform3 (server=3D=
0x55d13af90e60, client=3D0x55d13b0156f0, msg=3D0x55d13afbf620, rerr=3D0x7=
fdb82ffcbc0,
>     args=3D0x7fdb7800b220, ret=3D0x7fdb78021e90) at ../../../daemon/rem=
ote.c:4528
> #10 0x000055d13921a043 in remoteDispatchDomainMigratePerform3Helper (se=
rver=3D0x55d13af90e60, client=3D0x55d13b0156f0, msg=3D0x55d13afbf620, rer=
r=3D0x7fdb82ffcbc0,
>     args=3D0x7fdb7800b220, ret=3D0x7fdb78021e90) at ../../../daemon/rem=
ote_dispatch.h:7944
> #11 0x00007fdd19a260b4 in virNetServerProgramDispatchCall (prog=3D0x55d=
13af98b50, server=3D0x55d13af90e60, client=3D0x55d13b0156f0, msg=3D0x55d1=
3afbf620)
>     at ../../../src/rpc/virnetserverprogram.c:436
> #12 0x00007fdd19a25c17 in virNetServerProgramDispatch (prog=3D0x55d13af=
98b50, server=3D0x55d13af90e60, client=3D0x55d13b0156f0, msg=3D0x55d13afb=
f620)
>     at ../../../src/rpc/virnetserverprogram.c:307
> #13 0x000055d13925933b in virNetServerProcessMsg (srv=3D0x55d13af90e60,=
 client=3D0x55d13b0156f0, prog=3D0x55d13af98b50, msg=3D0x55d13afbf620)
>     at ../../../src/rpc/virnetserver.c:148
> -----------------------------------------------------------------------=
--------------------------------------------------------------
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=
=E6=9C=89=E6=96=B0=E5=8D=8E=E4=B8=89=E9=9B=86=E5=9B=A2=E7=9A=84=E4=BF=9D=E5=
=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA
> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=
=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=
=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=
=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=
=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81
> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=
=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=
=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=
=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=
=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC
> =E9=82=AE=E4=BB=B6=EF=BC=81
> This e-mail and its attachments contain confidential information from N=
ew H3C, which is
> intended only for the person or entity whose address is listed above. A=
ny use of the
> information contained herein in any way (including, but not limited to,=
 total or partial
> disclosure, reproduction, or dissemination) by persons other than the i=
ntended
> recipient(s) is prohibited. If you receive this e-mail in error, please=
 notify the sender
> by phone or email immediately and delete it!
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

