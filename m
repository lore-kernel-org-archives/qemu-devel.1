Received: from eggs.gnu.org ([2001:4830:134:3::10]:55004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewYSB-0001vv-NH
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewYS8-000794-K5
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:22:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ewYS8-00078b-Ey
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:22:16 -0400
Date: Thu, 15 Mar 2018 16:22:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180315192206.GK3417@localhost.localdomain>
References: <20180312223455.18124-1-ehabkost@redhat.com>
	<CAFEAcA9W=CLdogF+gHUfQOy7Gb=UHg0oTLYhYMRh7S363ss9wQ@mail.gmail.com>
	<20180313183704.GA3417@localhost.localdomain>
	<d41924c6-a526-352a-c37a-5a4cf2786dcf@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d41924c6-a526-352a-c37a-5a4cf2786dcf@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] Machine queue, 2018-03-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On Thu, Mar 15, 2018 at 07:31:09PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Eduardo,
>=20
> On 03/13/2018 07:37 PM, Eduardo Habkost wrote:
> > On Tue, Mar 13, 2018 at 06:29:10PM +0000, Peter Maydell wrote:
> >> On 12 March 2018 at 22:34, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> >>> The following changes since commit 6ceb1b51f05f9e1892d082960ed602dc=
a7b6696e:
> >>>
> >>>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180312-=
pull-request' into staging (2018-03-12 16:14:37 +0000)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >>>
> >>> for you to fetch changes up to a82664f2f8b1ce2db90e644df01d7ca78458=
81a6:
> >>>
> >>>   cpu: drop unnecessary NULL check and cpu_common_class_by_name() (=
2018-03-12 19:33:32 -0300)
> >>>
> >>> ----------------------------------------------------------------
> >>> Machine queue, 2018-03-12
> >>>
> >>
> >> Hi. It looks like this breaks bsd-user compilation:
> >>
> >> /root/qemu/bsd-user/main.c: In function 'main':
> >> /root/qemu/bsd-user/main.c:905:5: warning: implicit declaration of
> >> function 'create' [-Wimplicit-function-declaration]
> >>      cpu =3D create(cpu_type);
> >>      ^
> >> /root/qemu/bsd-user/main.c:905:5: warning: nested extern declaration
> >> of 'create' [-Wnested-externs]
> >> /root/qemu/bsd-user/main.c:905:9: warning: assignment makes pointer
> >> from integer without a cast [enabled by default]
> >>      cpu =3D create(cpu_type);
> >>          ^
> >>
> >> and then later it fails to link with
> >> /root/qemu/bsd-user/main.c:905: undefined reference to `create'
> >=20
> > Oops, sorry.  I don't have a BSD host handy right now, are you able t=
o confirm
> > if the new tag I pushed fixes it?
>=20
> You might try:
>=20
> $ make vm-test
> vm-test: Test QEMU in preconfigured virtual machines
>=20
>   vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM
>   vm-build-freebsd                - Build QEMU in FreeBSD VM
>   vm-build-netbsd                 - Build QEMU in NetBSD VM
>   vm-build-openbsd                - Build QEMU in OpenBSD VM

This is awesome, thanks for the pointer!

--=20
Eduardo
