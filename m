Received: from eggs.gnu.org ([2001:4830:134:3::10]:45783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey2vg-0006bM-GL
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ey2vb-0007o1-PN
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:06:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ey2vb-0007nI-KC
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:06:51 -0400
References: <20180216164620.GA53727@humpty.home.comstyle.com>
	<c4407146-8ec6-c317-9ec8-a47ab909fb94@amsat.org>
	<85dc7f9f-95e1-c666-ee17-8f04d008d21b@gmx.com>
	<e625c026-2fa4-f3ea-d85e-080c65a4885f@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <128f62e5-9184-57e5-88c1-d5cc4bf27d4f@redhat.com>
Date: Mon, 19 Mar 2018 17:06:37 -0500
MIME-Version: 1.0
In-Reply-To: <e625c026-2fa4-f3ea-d85e-080c65a4885f@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] make vm-test [was: [PATCH] maintainers: Add myself as
 a OpenBSD maintainer]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

On 02/16/2018 11:44 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 02/16/2018 02:41 PM, Kamil Rytarowski wrote:
>> On 16.02.2018 18:30, Philippe Mathieu-Daud=C3=A9 wrote:
>>> But before announcing the host OS being supported again, I'd rather s=
ee
>>> reproducible build/tests logs, in a (public - if possible) continuous
>>> integration system. Else it is hard to notice when it get broken.
>>>
>>
>> This is already done for FreeBSD, NetBSD and OpenBSD.
>=20
> We have the ability to run those, but afaik no CI are using them.
>=20
> $ make vm-test
> vm-test: Test QEMU in preconfigured virtual machines
>=20
>    vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM
>    vm-build-freebsd                - Build QEMU in FreeBSD VM
>    vm-build-netbsd                 - Build QEMU in NetBSD VM
>    vm-build-openbsd                - Build QEMU in OpenBSD VM
>=20
>>
>> CC: Fam who can confirm this.

Thanks for this; today was my first day trying the various vm-build-=20
targets.

Question: is this expected behavior?

$ make vm-build-ubuntu.i386
     VM-IMAGE ubuntu.i386
...
Image resized.
debconf: unable to initialize frontend: Dialog
debconf: (TERM is not set, so the dialog frontend is not usable.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (This frontend requires a controlling tty.)
debconf: falling back to frontend: Teletype
dpkg-preconfigure: unable to re-open stdin:
Connection to 127.0.0.1 closed by remote host.
...
Cloning into=20
'/home/eblake/qemu/vm-test-VoVkBv.tmp/data-5ba3c.tar.vroot/ui/keycodemapd=
b'...
sudo: unable to resolve host ubuntu-guest
make[1]: flex: Command not found
...
make[1]: flex: Command not found
Could not access KVM kernel module: No such file or directory
qemu-system-i386: failed to initialize KVM: No such file or directory
qemu-system-i386: Back to tcg accelerator

I'm wondering if the image initialized incorrectly, and as a result=20
can't do as much as it's supposed to do, or runs way slower than it=20
needs to?  The command eventually completed with status 0, but failed to=20
find a 32-bit compile error in the rdma code, and the output log does=20
not look like it actually attempted to compile anything in qemu (unless=20
it did compile it, but the logs were not output to stdout/stderr).

make vm-build-freebsd was a lot faster at completing for me (but shows=20
that we still have a lot of clang warnings about address of a packed=20
struct member).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
