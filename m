Received: from eggs.gnu.org ([2001:4830:134:3::10]:33339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ludo@gnu.org>) id 1fb3PV-0000Xo-5r
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ludo@gnu.org>) id 1fb3PQ-0003H5-FB
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:30:57 -0400
From: ludo@gnu.org (Ludovic =?utf-8?Q?Court=C3=A8s?=)
References: <87tvpfch8g.fsf@gnu.org> <20180704130841.GF32267@redhat.com>
	<877emahzjs.fsf@gnu.org> <20180705114646.GA2539@work-vm>
Date: Thu, 05 Jul 2018 14:30:49 +0200
In-Reply-To: <20180705114646.GA2539@work-vm> (David Alan Gilbert's message of
	"Thu, 5 Jul 2018 12:46:47 +0100")
Message-ID: <87lgapeufa.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?32-bit_=E2=80=9Cqemu-system-i386_-enable-?=
 =?utf-8?q?kvm=E2=80=9D_segfaults_on_x86=5F64?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> skribis:

> * Ludovic Court=C3=A8s (ludo@gnu.org) wrote:
>> Hi Daniel,
>>=20
>> Thanks for the quick reply.
>>=20
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> skribis:
>>=20
>> > On Wed, Jul 04, 2018 at 02:34:07PM +0200, Ludovic Court=C3=A8s wrote:
>> >> Hello,
>> >>=20
>> >> (I=E2=80=99m reporting the issue here because for some reason the lau=
nchpad.net
>> >> login page redirects me to an =E2=80=9Coops=E2=80=9D page and fails t=
o log me in.)
>> >>=20
>> >> On a Linux 4.17 x86_64 host, =E2=80=9Cqemu-system-i386 -enable-kvm=E2=
=80=9D, where
>> >> qemu-system-i386 is a 32-bit binary, crashes (it works fine without
>> >> =E2=80=98-enable-kvm=E2=80=99):
>> >>=20
>> >> --8<---------------cut here---------------start------------->8---
>> >> $ uname -rm
>> >> 4.17.3-gnu x86_64
>> >> $ file /gnu/store/h22dc67wzkv0w2l3775f0xqkyr318x5j-qemu-minimal-2.12.=
0/bin/qemu-system-i386=20
>> >> /gnu/store/h22dc67wzkv0w2l3775f0xqkyr318x5j-qemu-minimal-2.12.0/bin/q=
emu-system-i386: ELF 32-bit LSB shared object, Intel 80386, version 1 (SYSV=
), dynamically linked, interpreter /gnu/store/4aka3nwppxf3z072l6vr8cxvwj3x5=
h9s-glibc-2.27/lib/ld-linux.so.2, for GNU/Linux 2.6.32, stripped
>> >
>> > It appears that not only are you using qemu-system-i386 on x86_64
>> > host, but this has actually also been built as a 32-bit ELF binary,
>> > so will be using the 32-bit compat syscalls. This is quite possibly
>> > relevant to any crash, so it would be useful to know if qemu-system-i3=
86,
>> > when built as a 64-bit ELF binary works or fails.
>>=20
>> The 64-bit qemu-system-i386 works fine.
>>=20
>> > It appears you are using 2.12.0 release, so it is also helpful if
>> > you would try using current git master to see if it still reproduces.
>>=20
>> Here=E2=80=99s what I get with today=E2=80=99s master (commit
>> 6d8ad1614e0c97c59a87e6c6208ebeb94e769149):
>
> If you do a dmesg after you get the seg fault do you see
> any unusual messages ?

Just this:

  qemu-system-i38[1762]: segfault at 14 ip 000000005675842e sp 00000000f621=
d000 error 4 in qemu-system-i386[565e2000+b3d000]

Ludo=E2=80=99.
