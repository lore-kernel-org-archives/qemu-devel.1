Received: from eggs.gnu.org ([2001:4830:134:3::10]:47968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ewLSK-000144-0a
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1ewLSG-00010X-R7
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 01:29:36 -0400
References: <20180314173213.18563-1-kwolf@redhat.com>
From: Jack Schwartz <jack.schwartz@oracle.com>
Message-ID: <75f404ed-70f5-dba5-17bb-e7302caa05af@oracle.com>
Date: Wed, 14 Mar 2018 22:19:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180314173213.18563-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] multiboot: Fix buffer overflow on
 invalid kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, anatol.pomozov@gmail.com, ppandit@redhat.com

Hi Kevin.

I see an issue with the commit message of patch 1; please see my reply=20
to that patch for details.=C2=A0 I fully understand patches 1,2,3, patch =
4=20
except for some of the Makefile black magic, and patch 5 looks=20
reasonable to me.

So, for patches 2,3,4,5:
 =C2=A0=C2=A0=C2=A0 Reviewed-by: Jack Schwartz <jack.schwartz@oracle.com>

 =C2=A0=C2=A0=C2=A0 Thanks,
 =C2=A0=C2=A0=C2=A0 Jack

On 2018-03-14 10:32, Kevin Wolf wrote:
> Patch 1 fixes another Multiboot kernel validation bug that could cause
> QEMU to load the kernel image file into a too small buffer. Patch 2 add=
s
> another check to harden the code. The rest of the series adds Multiboot
> test cases for kernels using the a.out kludge, which is where the recen=
t
> bugs were found.
>
> Kevin Wolf (5):
>    multiboot: Reject kernels exceeding the address space
>    multiboot: Check validity of mh_header_addr
>    tests/multiboot: Test exit code for every qemu run
>    tests/multiboot: Add tests for the a.out kludge
>    tests/multiboot: Add .gitignore
>
>   hw/i386/multiboot.c             |   8 +++
>   tests/multiboot/.gitignore      |   3 +
>   tests/multiboot/Makefile        |  22 +++++--
>   tests/multiboot/aout_kludge.S   | 138 +++++++++++++++++++++++++++++++=
+++++++++
>   tests/multiboot/aout_kludge.out |  42 ++++++++++++
>   tests/multiboot/run_test.sh     |  34 ++++++----
>   6 files changed, 227 insertions(+), 20 deletions(-)
>   create mode 100644 tests/multiboot/.gitignore
>   create mode 100644 tests/multiboot/aout_kludge.S
>   create mode 100644 tests/multiboot/aout_kludge.out
>
