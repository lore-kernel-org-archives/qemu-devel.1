Received: from eggs.gnu.org ([2001:4830:134:3::10]:44666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anibal.limon@linux.intel.com>) id 1cYgGG-0003Yu-Hn
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 16:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anibal.limon@linux.intel.com>) id 1cYgGD-0000OR-Dv
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 16:46:48 -0500
References: <587D4171.6@linux.intel.com> <587D4329.5020702@linux.intel.com>
	<20170130235210.GA4681@tungsten.ozlabs.ibm.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <58910677.9080501@linux.intel.com>
Date: Tue, 31 Jan 2017 15:49:43 -0600
MIME-Version: 1.0
In-Reply-To: <20170130235210.GA4681@tungsten.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VehTKUqeA76rsmI1G8kiKJ85bK7S198mq"
Subject: Re: [Qemu-devel] qemu-pcc 2.8.0 linux-user segfaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VehTKUqeA76rsmI1G8kiKJ85bK7S198mq
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 01/30/2017 05:52 PM, Sam Bobroff wrote:
> On Mon, Jan 16, 2017 at 04:03:21PM -0600, An=EDbal Lim=F3n wrote:
>>
>>
>> On 01/16/2017 03:56 PM, An=EDbal Lim=F3n wrote:
>>> Hi folks,
>>>
>>> I'm trying to upgrade qemu to 2.8.0 in Openembedded-core and segfault=
s
>>> in qemu-ppc when is executing:
>=20
> Hi An=EDbal,
>=20
> I've recently encountered a similar problem and I've posted a fix. If
> you'd like to try it, it's here:
>=20
> https://lists.gnu.org/archive/html/qemu-ppc/2017-01/msg00413.html

The patch works, thanks for made it.

Cheers,
	alimon

>=20
> Cheers,
> Sam.
>=20
>>> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
=2E8.0-r0/build/ppc-linux-user/qemu-ppc
>>> -s 16M -r 3.2.0 -cpu 7400 -L
>>> /home/alimon/repos/poky/build-ppc/tmp/sysroots/qemuppc -E
>>> LD_LIBRARY_PATH=3D/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-=
poky-linux/gobject-introspection/1.50.0-r0/build/.libs:.libs:/home/alimon=
/repos/poky/build-ppc/tmp/sysroots/qemuppc//usr/lib:/home/alimon/repos/po=
ky/build-ppc/tmp/sysroots/qemuppc//lib
>>> /home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-poky-linux/gobject=
-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z/Gio-2.0
>>> --introspect-dump=3D/home/alimon/repos/poky/build-ppc/tmp/work/ppc740=
0-poky-linux/gobject-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z=
/functions.txt,/home/alimon/repos/poky/build-ppc/tmp/work/ppc7400-poky-li=
nux/gobject-introspection/1.50.0-r0/build/tmp-introspectu_ewt_1z/dump.xml=

>>> [Thread debugging using libthread_db enabled]
>>>
>>>
>>> And the debug info,
>>>
>>> (gdb) info threads
>>>   Id   Target Id         Frame
>>>   1    Thread 0x7ffff7fd0780 (LWP 25457) "qemu-ppc"
>>> pthread_cond_wait@@GLIBC_2.3.2 () at
>>> ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
>>>   2    Thread 0x7ffff647e700 (LWP 25461) "qemu-ppc" syscall () at
>>> ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
>>> * 3    Thread 0x7ffff7f4d700 (LWP 25462) "qemu-ppc" 0x000000000086fba=
4
>>> in static_code_gen_buffer ()
>>>
>>> (gdb) bt
>>> #0  0x000000000086fba4 in static_code_gen_buffer ()
>>> #1  0x000000000040e922 in cpu_tb_exec (itb=3D<optimized out>,
>>> itb=3D<optimized out>, cpu=3D0x29864d0) at
>>> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
=2E8.0-r0/qemu-2.8.0/cpu-exec.c:164
>>> #2  cpu_loop_exec_tb (sc=3D<optimized out>, tb_exit=3D<synthetic poin=
ter>,
>>> last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D0x29864d0)=
 at
>>> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
=2E8.0-r0/qemu-2.8.0/cpu-exec.c:544
>>> #3  cpu_exec (cpu=3Dcpu@entry=3D0x29864d0) at
>>> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
=2E8.0-r0/qemu-2.8.0/cpu-exec.c:638
>>> #4  0x0000000000445fba in cpu_loop (env=3Denv@entry=3D0x298e750) at
>>> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
=2E8.0-r0/qemu-2.8.0/linux-user/main.c:1359
>>> #5  0x0000000000448a95 in clone_func (arg=3D0x7fffffffa910) at
>>> /home/alimon/repos/poky/build-ppc/tmp/work/x86_64-linux/qemu-native/2=
=2E8.0-r0/qemu-2.8.0/linux-user/syscall.c:6090
>>> #6  0x00007ffff6a750a4 in start_thread (arg=3D0x7ffff7f4d700) at
>>> pthread_create.c:309
>>> #7  0x00007ffff67aa62d in clone () at
>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>>
>> Here is the core dump,
>>
>> https://drive.google.com/file/d/0B9uDfO-FJ1kgY3ZhendISTZzOUU/view?usp=3D=
sharing
>>
>>>
>>> Any help will be appreciated.
>>>
>>> Best regards,
>>> 	alimon
>>>
>>
>=20
>=20
>=20


--VehTKUqeA76rsmI1G8kiKJ85bK7S198mq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYkQZ8AAoJEGJqcE9h3glgWpMQAIG1oiYFkDWXDRYRZLRwa3CD
hRVlnpAnurHqsZOFa6gfflcovOTXhW780SeWKkKeuMW3L2qYK28QwDof0Cb5a3KS
1zr7rkNZ1O+n58JweCshhnL53iIaUnkCwCY5J1yji+GlJE77ZHohYP0/JK3jzwFh
YvDjJugqqLMZAhqWLB6o0UNeAwA2V7X+xYsaOGermpJJJQrW4Kw06fiq/IwkUc22
LPppDfjLGfQKYnisBWWxlR22UaMX27WqxHtEPwjtOAEu63KDkejvA/tHYM/Ja+eo
PW1syoijn3Rs3oYIQSd4atuEQMM4YugrRJJF2yp1k4qs1KOOyhnJcOPocJ/XhtiZ
K2EwHY3Kt1Lw4nU/sEMptJfHMeqLTPqi2CvkJF4soe4VU1/97aDsCboDij6+noHv
5/rq8q/eeOWy/2aJfdRigcJo+UgRzlF8B2NMvwk7MM40MSShkfeo6mCa7c/VxrZU
h70ZWCMK1uaPrfOuJMxKTbmYtRlvOjLdCuTJPOmhN5nT4xJ5c1ktLzudqjsFUA+x
+OLqkhmvRrUOStY9ewLjb+ULx97myEwfJwRvjI10/p1U+JCagihr14wbBb57yfCY
5Yr2GO/03ERDWsM1PhkNiVp7uzwPKq/YJWqbPOYeu1Fo5B4vzNmlHj8t5qrd+fbr
pyiLv04gLsaV2t362/Vi
=dVMH
-----END PGP SIGNATURE-----

--VehTKUqeA76rsmI1G8kiKJ85bK7S198mq--
