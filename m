Received: from eggs.gnu.org ([2001:4830:134:3::10]:40410)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1e1z9s-0003Gh-21
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1e1z9m-000577-W8
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:21:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:53115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1e1z9m-00056G-LI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:21:30 -0400
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
	<CAFEAcA8d+UkhOJKovyedTye=8mD0mcbEScHm58RKyCuzYezxqA@mail.gmail.com>
	<1412741304.28261373.1507657333058.JavaMail.zimbra@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <9ec6aacf-240f-5ac3-573f-44afec61f4ef@gmx.com>
Date: Tue, 10 Oct 2017 20:23:39 +0200
MIME-Version: 1.0
In-Reply-To: <1412741304.28261373.1507657333058.JavaMail.zimbra@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7cP2LHAGtnf5BxBsh1AM87gVxI5LiC8CB"
Subject: Re: [Qemu-devel] [PULL 00/27] vhost-user patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, changpeng liu <changpeng.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Felipe Franciosi <felipe@nutanix.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7cP2LHAGtnf5BxBsh1AM87gVxI5LiC8CB
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 changpeng liu <changpeng.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Felipe Franciosi <felipe@nutanix.com>
Message-ID: <9ec6aacf-240f-5ac3-573f-44afec61f4ef@gmx.com>
Subject: Re: [Qemu-devel] [PULL 00/27] vhost-user patches
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
 <CAFEAcA8d+UkhOJKovyedTye=8mD0mcbEScHm58RKyCuzYezxqA@mail.gmail.com>
 <1412741304.28261373.1507657333058.JavaMail.zimbra@redhat.com>
In-Reply-To: <1412741304.28261373.1507657333058.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.10.2017 19:42, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
>> On 10 October 2017 at 18:10, Marc-Andr=C3=A9 Lureau
>> <marcandre.lureau@redhat.com> wrote:
>>> The following changes since commit
>>> 567d0a19c7998fa366598b83d5a6e5f0759d3ea9:
>>>
>>>   Merge remote-tracking branch
>>>   'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging
>>>   (2017-10-10 13:25:46 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://github.com/elmarco/qemu.git tags/vus-pull-request
>>>
>>> for you to fetch changes up to 25f1fe82c64c8c4922254d63195e1d9cffbb05=
07:
>>>
>>>   vhost-user-scsi: remove server_sock from VusDev (2017-10-10 19:06:0=
6
>>>   +0200)
>>>
>>> ----------------------------------------------------------------
>>>
>>> ----------------------------------------------------------------
>>
>> Hi. I'm afraid this fails to build:
>>
>> On ppc host:
>>   CC      contrib/libvhost-user/libvhost-user.o
>> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
>> =E2=80=98vu_set_vring_addr_exec=E2=80=99:
>> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:524:5: error:
>> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long l=
ong unsigned int=E2=80=99, but
>> argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>>      DPRINT("    desc_user_addr:   0x%016llx\n", vra->desc_user_addr);=

>>      ^
>> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:525:5: error:
>> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long l=
ong unsigned int=E2=80=99, but
>> argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>>      DPRINT("    used_user_addr:   0x%016llx\n", vra->used_user_addr);=

>>      ^
>> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:526:5: error:
>> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long l=
ong unsigned int=E2=80=99, but
>> argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>>      DPRINT("    avail_user_addr:  0x%016llx\n", vra->avail_user_addr)=
;
>>      ^
>> /home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:527:5: error:
>> format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long l=
ong unsigned int=E2=80=99, but
>> argument 3 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
>>      DPRINT("    log_guest_addr:   0x%016llx\n", vra->log_guest_addr);=

>>      ^
>>
>>
>> On NetBSD, OpenBSD, FreeBSD, OSX:
>>
>>   CC      contrib/libvhost-user/libvhost-user.o
>> /root/qemu/contrib/libvhost-user/libvhost-user.c:27:25: fatal error:
>> sys/eventfd.h: No such file or directory
>>  #include <sys/eventfd.h>
>>                          ^
>> compilation terminated.
>>
>=20
> That was quick!
>=20
> It looks like the solution is to remove libvhost-user.a from $(SUBDIR_R=
ULES) target. I have checked with 'make vm-build-freebsd'.
>=20
> (the printf format errors are pre-existing - I think should be addresse=
d in a different series)=20
>=20
>=20
>=20

This interface is absent in all BSDs, it's available in SmartOS
(Illumos). The equivalent is kevent(2)/kqueue(2).


--7cP2LHAGtnf5BxBsh1AM87gVxI5LiC8CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ3RAwAAoJEEuzCOmwLnZsedYP+QEwrZ6MiZYnk2k187Zljo3o
+zGyw72znzi+ez9Ktj4vEhz+DRzSQMkJ2LIfSRYUHVxX0IFRawTGzNg97E3BSprp
lkzncF7jOxnxCEiDIfx5q9cLWZ1NbQBwl2QzZ1y1b9geyXuwX3W8TnOX6hUIStuy
jiZTKYjvaYNknRIXtf5nqA0uvwuYqRs0P1UZb2c0aoFuDmtd0t/GaGHpUNvxsGhV
B9FRwkuK10p1HupA37ZQ2yicNo/SKTyaDtGrgsBTV5MPH4FJHvmAH7R7ZHv3+lU8
pAUjWqWh7MTMsvZhFBiVyZmSpprLiBgmqIXqP8CF0i8y1odH0OkAyyIIwOVA27bs
4xWpB06afv8Ftu4jx4EANlylNbG04ofHqBvGvFj4a5idyBTR4Ybh9Fe0VsBwg+pM
JtpGo8Qaomfrq9QjVh7//f+ma+I3eoaOZPsa0mUPSwFaqNLFcoBOBUgcMYVhZmPI
7cO3526EWVie/vetBqraNWfcOrJyajdO8gfmUvWgQdhTbSosf/CEMLJq1bkkn2tx
CPOOFS7qlz5ob/1AFVGCzcc8IXOSuZDyaVkLvTDSgfAMotrt9IUrWx7RKwYP1mz7
Zl6Wo+RRbNyR7DAytPbjDPSoxTqiZ2IWneOEdTKO/P3zkZtHflgLewiGK2o9Qh8d
0Hgsqj3CMqbEEDPOwL2Q
=SVeh
-----END PGP SIGNATURE-----

--7cP2LHAGtnf5BxBsh1AM87gVxI5LiC8CB--
