Received: from eggs.gnu.org ([2001:4830:134:3::10]:33350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cYLl9-00079C-1j
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 18:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cYLl5-0003Mc-3h
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 18:53:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41329
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cYLl4-0003MM-Tt
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 18:53:15 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UNmlK5035145
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 18:53:13 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 289yx076g7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 18:53:13 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 31 Jan 2017 09:53:10 +1000
Date: Tue, 31 Jan 2017 10:52:10 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <587D4171.6@linux.intel.com>
 <587D4329.5020702@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <587D4329.5020702@linux.intel.com>
Message-Id: <20170130235210.GA4681@tungsten.ozlabs.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-pcc 2.8.0 linux-user segfaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?An=EDbal_Lim=F3n?= <anibal.limon@linux.intel.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, Jan 16, 2017 at 04:03:21PM -0600, An=EDbal Lim=F3n wrote:
>=20
>=20
> On 01/16/2017 03:56 PM, An=EDbal Lim=F3n wrote:
> > Hi folks,
> >=20
> > I'm trying to upgrade qemu to 2.8.0 in Openembedded-core and segfault=
s
> > in qemu-ppc when is executing:

Hi An=EDbal,

I've recently encountered a similar problem and I've posted a fix. If
you'd like to try it, it's here:

https://lists.gnu.org/archive/html/qemu-ppc/2017-01/msg00413.html

Cheers,
Sam.

> > /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
.8.0-r0/build/ppc-linux-user/qemu-ppc
> > -s 16M -r 3.2.0 -cpu 7400 -L
> > /home/alimon/repos/poky/build-ppc/tmp/sysroots/qemuppc -E
> > LD_LIBRARY_PATH=3D/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-=
poky-linux/gobject-introspection/1.50.0-r0/build/.libs:.libs:/home/alimon=
/repos/poky/build-ppc/tmp/sysroots/qemuppc//usr/lib:/home/alimon/repos/po=
ky/build-ppc/tmp/sysroots/qemuppc//lib
> > /home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-poky-linux/gobject=
-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z/Gio-2.0
> > --introspect-dump=3D/home/alimon/repos/poky/build-ppc/tmp/work/ppc740=
0-poky-linux/gobject-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z=
/functions.txt,/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-poky-li=
nux/gobject-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z/dump.xml
> > [Thread debugging using libthread_db enabled]
> >=20
> >=20
> > And the debug info,
> >=20
> > (gdb) info threads
> >   Id   Target Id         Frame
> >   1    Thread 0x7ffff7fd0780 (LWP 25457) "qemu-ppc"
> > pthread_cond_wait@@GLIBC_2.3.2 () at
> > ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
> >   2    Thread 0x7ffff647e700 (LWP 25461) "qemu-ppc" syscall () at
> > ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> > * 3    Thread 0x7ffff7f4d700 (LWP 25462) "qemu-ppc" 0x000000000086fba=
4
> > in static_code_gen_buffer ()
> >=20
> > (gdb) bt
> > #0  0x000000000086fba4 in static_code_gen_buffer ()
> > #1  0x000000000040e922 in cpu_tb_exec (itb=3D<optimized out>,
> > itb=3D<optimized out>, cpu=3D0x29864d0) at
> > /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
.8.0-r0/qemu-2.8.0/cpu-exec.c:164
> > #2  cpu_loop_exec_tb (sc=3D<optimized out>, tb_exit=3D<synthetic poin=
ter>,
> > last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D0x29864d0)=
 at
> > /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
.8.0-r0/qemu-2.8.0/cpu-exec.c:544
> > #3  cpu_exec (cpu=3Dcpu@entry=3D0x29864d0) at
> > /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
.8.0-r0/qemu-2.8.0/cpu-exec.c:638
> > #4  0x0000000000445fba in cpu_loop (env=3Denv@entry=3D0x298e750) at
> > /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
.8.0-r0/qemu-2.8.0/linux-user/main.c:1359
> > #5  0x0000000000448a95 in clone_func (arg=3D0x7fffffffa910) at
> > /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
.8.0-r0/qemu-2.8.0/linux-user/syscall.c:6090
> > #6  0x00007ffff6a750a4 in start_thread (arg=3D0x7ffff7f4d700) at
> > pthread_create.c:309
> > #7  0x00007ffff67aa62d in clone () at
> > ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>=20
> Here is the core dump,
>=20
> https://drive.google.com/file/d/0B9uDfO-FJ1kgY3ZhendISTZzOUU/view?usp=3D=
sharing
>=20
> >=20
> > Any help will be appreciated.
> >=20
> > Best regards,
> > 	alimon
> >=20
>=20
