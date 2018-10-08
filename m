Received: from eggs.gnu.org ([2001:4830:134:3::10]:52691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9XEy-0007Ta-05
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9XEu-00022N-NW
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:14:35 -0400
References: <20181004152857.14525-1-cohuck@redhat.com>
	<CAFEAcA87E1F5vbmU8-xv=jtoezpOcp-oyPQjE0gAVga_9YufXw@mail.gmail.com>
	<87woqsmqgi.fsf@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <674805a0-019d-7432-7a3c-6d2b708a19ae@redhat.com>
Date: Mon, 8 Oct 2018 17:14:19 +0200
MIME-Version: 1.0
In-Reply-To: <87woqsmqgi.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/15] s390x updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 08/10/2018 17:02, Alex Benn=C3=A9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On 4 October 2018 at 16:28, Cornelia Huck <cohuck@redhat.com> wrote:
>>> The following changes since commit dafd95053611aa14dda40266857608d12d=
dce658:
>>>
>>>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' in=
to staging (2018-10-02 18:27:18 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/cohuck/qemu tags/s390x-20181004
>>>
>>> for you to fetch changes up to b576d582ea2b03f4eada186fff59308d22b40a=
6a:
>>>
>>>   hw/s390x/s390-pci-bus: Convert sysbus init function to realize func=
tion (2018-10-04 12:10:40 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Various s390x updates:
>>> - fix several struct definitions so that sparc hosts do not trip over
>>>   unaligned accesses
>>> - fence enabling huge pages for pre-3.1 machines
>>> - sysbus init -> realize conversion
>>> - fixes and improvements in tcg (instruction flags and AFP registers)
>>
>> Applied, thanks.
> <snip>
>=20
> This pull has broken s390x-linux-user tcg tests:
>=20
>   timeout: the monitored command dumped core
>   Illegal instruction
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/multiarch/Makefile.target:30:=
 recipe for target 'run-test-mmap' failed
>   make[2]: *** [run-test-mmap] Error 132
>   make[2]: *** Waiting for unfinished jobs....
>   timeout: the monitored command dumped core
>   Illegal instruction
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/Makefile:96: recipe for targe=
t 'run-linux-test' failed
>   make[2]: *** [run-linux-test] Error 132
>   timeout: the monitored command dumped core
>   Illegal instruction
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/Makefile:96: recipe for targe=
t 'run-hello-s390x' failed
>   make[2]: *** [run-hello-s390x] Error 132
>   timeout: the monitored command dumped core
>   Illegal instruction
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/Makefile:96: recipe for targe=
t 'run-ipm' failed
>   make[2]: *** [run-ipm] Error 132
>   timeout: the monitored command dumped core
>   Illegal instruction
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/Makefile:96: recipe for targe=
t 'run-exrl-trtr' failed
>   make[2]: *** [run-exrl-trtr] Error 132
>   timeout: the monitored command dumped core
>   Illegal instruction
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/Makefile:96: recipe for targe=
t 'run-testthread' failed
>   make[2]: *** [run-testthread] Error 132
>   timeout: the monitored command dumped core
>   Illegal instruction
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/Makefile:96: recipe for targe=
t 'run-exrl-trt' failed
>   make[2]: *** [run-exrl-trt] Error 132
>   timeout: the monitored command dumped core
>   Illegal instruction
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/Makefile:96: recipe for targe=
t 'run-sha1' failed
>   make[2]: *** [run-sha1] Error 132
>   timeout: the monitored command dumped core
>   Illegal instruction
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/Makefile:96: recipe for targe=
t 'run-csst' failed
>   make[2]: *** [run-csst] Error 132
>   /home/alex/lsrc/qemu/qemu.git/tests/tcg/Makefile.include:71: recipe f=
or target 'run-guest-tests' failed
>   make[1]: *** [run-guest-tests] Error 2
>   /home/alex/lsrc/qemu/qemu.git/tests/Makefile.include:968: recipe for =
target 'run-tcg-tests-s390x-linux-user' failed
>   make: *** [run-tcg-tests-s390x-linux-user] Error 2
>=20
> which are now showing up on Travis (admitidly hidden by the usual Travi=
s
> noise). I have bisected the breakage:
>=20
>   git bisect start
>   git bisect bad b576d582ea2b03f4eada186fff59308d22b40a6a
>   b576d582ea bad hw/s390x/s390-pci-bus: Convert sysbus init function to=
 realize function
>   git bisect good dafd95053611aa14dda40266857608d12ddce658
>   dafd950536 good Merge remote-tracking branch 'remotes/bonzini/tags/fo=
r-upstream' into staging
>   git bisect good bbf6ea3bd961970785a583117ac1c0b84a8ee736
>   bbf6ea3bd9 good s390x/tcg: factor out and fix DATA exception injectio=
n
>   git bisect bad db0504154ef1feedd135f25f8ca6e9abb5d00bbb
>   db0504154e bad s390x/tcg: check for AFP-register, BFP and DFP data ex=
ceptions
>   git bisect good 82d179336dd696d04495963ca007fa961496d924
>   82d179336d good s390x/tcg: support flags for instructions
>   git bisect good ca5f31a0f27d265f2220ad43913f70280e8753a2
>   ca5f31a0f2 good s390x/tcg: add instruction flags for floating point i=
nstructions
>=20
> Which is points at:
>=20
>   Bisect Rest (1)
>   db0504154e * bad @ s390x/tcg: check for AFP-register, BFP and DFP dat=
a exceptions
>=20

Thanks for reporting. We have to enable AFP as default in linux-user (in
control register 0).

Will send a patch later this day.

> --
> Alex Benn=C3=A9e
>=20


--=20

Thanks,

David / dhildenb
