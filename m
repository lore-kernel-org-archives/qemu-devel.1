Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609E7C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4018A21479
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4018A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he1Nu-00004r-AW
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 14:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1he1FI-0004jE-57
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1he1FF-0007si-RC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1he19S-00008b-P0; Thu, 20 Jun 2019 13:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E1153082140;
 Thu, 20 Jun 2019 17:46:46 +0000 (UTC)
Received: from localhost (ovpn-116-108.ams2.redhat.com [10.36.116.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F54919C4F;
 Thu, 20 Jun 2019 17:46:45 +0000 (UTC)
Date: Wed, 12 Jun 2019 15:29:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: l00284672 <lizhengui@huawei.com>
Message-ID: <20190612142946.GE19156@stefanha-x1.localdomain>
References: <f1cc2c01-62ec-c820-3771-58a9b2a72841@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <f1cc2c01-62ec-c820-3771-58a9b2a72841@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 20 Jun 2019 17:46:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] virtual machine cpu soft lock when qemu attach disk
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jiangyiwen@huawei.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 04:39:00PM +0800, l00284672 wrote:
> Hi,=A0 I found a problem that virtual machine cpu soft lock when I attach=
 a
> disk to the vm in the case that
>=20
> backend storage network has a large delay or IO pressure is too large.
>=20
> 1) The disk xml which I attached is:
>=20
> =A0=A0=A0 <disk type=3D'block' device=3D'lun' rawio=3D'yes'>
> =A0=A0=A0=A0=A0 <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'n=
ative'/>
> =A0=A0=A0=A0=A0 <source dev=3D'/dev/mapper/360022a11000c1e0a0787c23a00000=
1cb'/>
> =A0=A0=A0=A0=A0 <backingStore/>
> =A0=A0=A0=A0=A0 <target dev=3D'sdb' bus=3D'scsi'/>
> =A0=A0=A0=A0=A0 <alias name=3D'scsi0-0-1-0'/>
> =A0=A0=A0=A0=A0 <address type=3D'drive' controller=3D'0' bus=3D'0' target=
=3D'1' unit=3D'0'/>
> =A0=A0=A0 </disk>
>=20
> 2) The bt of qemu main thread:
>=20
> #0 0x0000ffff9d78402c in pread64 () from /lib64/libpthread.so.0
> #1 0x0000aaaace3357d8 in pread64 (__offset=3D0, __nbytes=3D4096,
> __buf=3D0xaaaad47a5200, __fd=3D202) at /usr/include/bits/unistd.h:99
> #2 raw_is_io_aligned (fd=3Dfd@entry=3D202, buf=3Dbuf@entry=3D0xaaaad47a52=
00,
> len=3Dlen@entry=3D4096) at block/raw_posix.c:294
> #3 0x0000aaaace33597c in raw_probe_alignment (bs=3Dbs@entry=3D0xaaaad32ea=
920,
> fd=3D202, errp=3Derrp@entry=3D0xfffffef7a330) at block/raw_posix.c:349
> #4 0x0000aaaace335a48 in raw_refresh_limits (bs=3D0xaaaad32ea920,
> errp=3D0xfffffef7a330) at block/raw_posix.c:811
> #5 0x0000aaaace3404b0 in bdrv_refresh_limits (bs=3D0xaaaad32ea920,
> errp=3D0xfffffef7a330, errp@entry=3D0xfffffef7a360) at block/io.c:122
> #6 0x0000aaaace340504 in bdrv_refresh_limits (bs=3Dbs@entry=3D0xaaaad09ce=
800,
> errp=3Derrp@entry=3D0xfffffef7a3b0) at block/io.c:97
> #7 0x0000aaaace2eb9f0 in bdrv_open_common (bs=3Dbs@entry=3D0xaaaad09ce800,
> file=3Dfile@entry=3D0xaaaad0e89800, options=3D<optimized out>,
> errp=3Derrp@entry=3D0xfffffef7a450)
> at block.c:1194
> #8 0x0000aaaace2eedec in bdrv_open_inherit (filename=3D<optimized out>,
> filename@entry=3D0xaaaad25f92d0
> "/dev/mapper/36384c4f100630193359db7a80000011d",
> reference=3Dreference@entry=3D0x0, options=3D<optimized out>,
> options@entry=3D0xaaaad3d0f4b0, flags=3D<optimized out>, flags@entry=3D12=
8,
> parent=3Dparent@entry=3D0x0,
> child_role=3Dchild_role@entry=3D0x0, errp=3Derrp@entry=3D0xfffffef7a710) =
at
> block.c:1895
> #9 0x0000aaaace2ef510 in bdrv_open (filename=3Dfilename@entry=3D0xaaaad25=
f92d0
> "/dev/mapper/36384c4f100630193359db7a80000011d",
> reference=3Dreference@entry=3D0x0,
> options=3Doptions@entry=3D0xaaaad3d0f4b0, flags=3Dflags@entry=3D128,
> errp=3Derrp@entry=3D0xfffffef7a710) at block.c:1979
> #10 0x0000aaaace331ef0 in blk_new_open
> (filename=3Dfilename@entry=3D0xaaaad25f92d0
> "/dev/mapper/36384c4f100630193359db7a80000011d",
> reference=3Dreference@entry=3D0x0,
> options=3Doptions@entry=3D0xaaaad3d0f4b0, flags=3D128,
> errp=3Derrp@entry=3D0xfffffef7a710) at block/block_backend.c:213
> #11 0x0000aaaace0da1f4 in blockdev_init (file=3Dfile@entry=3D0xaaaad25f92=
d0
> "/dev/mapper/36384c4f100630193359db7a80000011d",
> bs_opts=3Dbs_opts@entry=3D0xaaaad3d0f4b0,
> errp=3Derrp@entry=3D0xfffffef7a710) at blockdev.c:603
> #12 0x0000aaaace0dc478 in drive_new (all_opts=3Dall_opts@entry=3D0xaaaad4=
dc31d0,
> block_default_type=3D<optimized out>) at blockdev.c:1116
> #13 0x0000aaaace0e3ee0 in add_init_drive (
> optstr=3Doptstr@entry=3D0xaaaad0872ec0 "file=3D/dev/mapper/36384c4f100630=
193359db7a80000011d,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-3,cache=3Dn=
one,aio=3Dnative")
> at device_hotplug.c:46
> #14 0x0000aaaace0e3f78 in hmp_drive_add (mon=3D0xfffffef7a810,
> qdict=3D0xaaaad0c8f000) at device_hotplug.c:67
> #15 0x0000aaaacdf7d688 in handle_hmp_command (mon=3D0xfffffef7a810,
> cmdline=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:3199
> #16 0x0000aaaacdf7d778 in qmp_human_monitor_command (
> command_line=3D0xaaaacfc8e3c0 "drive_add dummy file=3D/dev/mapper/36384c4=
f100630193359db7a80000011d,format=3Draw,if=3Dnone,id=3Ddrive-scsi0-0-0-3,ca=
che=3Dnone,aio=3Dnative",
>=20
> has_cpu_index=3Dfalse, cpu_index=3D0, errp=3Derrp@entry=3D0xfffffef7a968)=
 at
> /usr/src/debug/qemu-kvm-2.8.1/monitor.c:660
> #17 0x0000aaaace0fdb30 in qmp_marshal_human_monitor_command (args=3D<opti=
mized
> out>, ret=3D0xfffffef7a9e0, errp=3D0xfffffef7a9d8) at qmp-marshal.c:2223
> #18 0x0000aaaace3b6ad0 in do_qmp_dispatch (request=3D<optimized out>,
> errp=3D0xfffffef7aa20, errp@entry=3D0xfffffef7aa40) at qapi/qmp_dispatch.=
c:115
> #19 0x0000aaaace3b6d58 in qmp_dispatch (request=3D<optimized out>) at
> qapi/qmp_dispatch.c:142
> #20 0x0000aaaacdf79398 in handle_qmp_command (parser=3D<optimized out>,
> tokens=3D<optimized out>) at /usr/src/debug/qemu-kvm-2.8.1/monitor.c:4010
> #21 0x0000aaaace3bd6c0 in json_message_process_token (lexer=3D0xaaaacf834=
c80,
> input=3D<optimized out>, type=3DJSON_RCURLY, x=3D214, y=3D274) at
> qobject/json_streamer.c:105
> #22 0x0000aaaace3f3d4c in json_lexer_feed_char
> (lexer=3Dlexer@entry=3D0xaaaacf834c80, ch=3D<optimized out>,
> flush=3Dflush@entry=3Dfalse) at qobject/json_lexer.c:319
> #23 0x0000aaaace3f3e6c in json_lexer_feed (lexer=3D0xaaaacf834c80,
> buffer=3D<optimized out>, size=3D<optimized out>) at qobject/json_lexer.c=
:369
> #24 0x0000aaaacdf77c64 in monitor_qmp_read (opaque=3D<optimized out>,
> buf=3D<optimized out>, size=3D<optimized out>) at
> /usr/src/debug/qemu-kvm-2.8.1/monitor.c:4040
> #25 0x0000aaaace0eab18 in tcp_chr_read (chan=3D<optimized out>,
> cond=3D<optimized out>, opaque=3D0xaaaacf90b280) at qemu_char.c:3260
> #26 0x0000ffff9dadf200 in g_main_context_dispatch () from
> /lib64/libglib-2.0.so.0
> #27 0x0000aaaace3c4a00 in glib_pollfds_poll () at util/main_loop.c:230
> --Type <RET> for more, q to quit, c to continue without paging--
> #28 0x0000aaaace3c4a88 in os_host_main_loop_wait (timeout=3D<optimized ou=
t>)
> at util/main_loop.c:278
> #29 0x0000aaaace3c4bf0 in main_loop_wait (nonblocking=3D<optimized out>) =
at
> util/main_loop.c:534
> #30 0x0000aaaace0f5d08 in main_loop () at vl.c:2120
> #31 0x0000aaaacdf3a770 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>,
> envp=3D<optimized out>) at vl.c:5017
>=20
> 3)The bt of vcpu thread
>=20
> From the bt we can see,=A0 when do qmp sush as drive_add,=A0 qemu main th=
read
> locks the qemu_global_mutex=A0 and do pread in raw_probe_alignmen. Pread
>=20
> is a synchronous operation. If backend storage network has a large delay =
or
> IO pressure is too large,=A0 the pread operation will not return for a lo=
ng
> time, which
>=20
> make vcpu thread can't acquire qemu_global_mutex for a long time and make
> the vcpu thread unable to be scheduled for a long time. So virtual machine
> cpu soft lock happened.
>=20
>=20
> I thank=A0 qemu main thread should not hold qemu_global_mutex for a long =
time
> when do qmp that involving IO synchronous operation sush pread , ioctl, e=
tc.
>=20
> Do you have any solutions or good ideas about it? Thanks for your reply!

Hi,
Unfortunately this is a general problem in QEMU.  There are code paths
that use synchronous I/O and can hang QEMU (and the guest) if I/O does
not complete within a reasonable amount of time.

In certain cases the code can be converted to async, but there is no
general solution.  For example, the virtio-blk device reports
information about the disk in the (synchronous) VIRTIO configuration
space.  We really need to know this information before exposing the
device to the guest.  (In SCSI maybe we can wait before replying to the
guest's INQUIRY command but in general we can't do that...)

"drive_add" is a synchronous monitor command.  It would be necessary to
create an asynchronous version of this command and then make drive_new()
asynchronous as well.  This would probably be a lot of work.

Stefan

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0BDFoACgkQnKSrs4Gr
c8gCxggAufW3RN0ROyyNirCKXzTotdjYTj49+SdfQOFyJhhsaJFUEJAXGF3hRG7q
nLrNwEpFu6JsRP4Gx9WmoBRhU1GIyGp+4X3CRewCBlm8Xv05K9EC6jV5NR05MFPy
dkipkqm3moZgi7kcN9KBEEBCqAx3qAU9CQO5Xl6kN79SDRadcRuZG3icjry19f9V
cqpNisembWYAf9r5a/PzZCd3vX3kWIMUn+2JCPObLRFODoS9V1UxNjgYTQi27g2H
hBI4L/AVdTGBn0tewcrK2RRN4+Z+1SIfFTnoyidpXkHb+EbBypUrAG19I+XEAKIq
nAniJwEOO0g08GbgLGs+dLVt+Q5SyQ==
=ki/w
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

