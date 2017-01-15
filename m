Received: from eggs.gnu.org ([2001:4830:134:3::10]:33006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cSaGy-0000fa-7p
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 21:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cSaGv-0002C1-2a
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 21:10:20 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:44136)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cSaGu-0002BS-M8
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 21:10:16 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278451049.8988.5349519787388002909.stgit@fimbulvetr.bsc.es>
	<20170109161702.GH30228@stefanha-x1.localdomain>
Date: Sun, 15 Jan 2017 03:10:13 +0100
In-Reply-To: <20170109161702.GH30228@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 9 Jan 2017 16:17:02 +0000")
Message-ID: <878tqdysxm.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 6/6] hypertrace: Add guest-side Linux
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>

Stefan Hajnoczi writes:

> On Mon, Dec 26, 2016 at 09:35:10PM +0100, Llu=C3=ADs Vilanova wrote:
>> Provides guest Linux kernel module "qemu-hypertrace.ko" to abstract
>> access to the hypertrace channel.
>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> Makefile                                           |    4 -
>> configure                                          |    4 +
>> hypertrace/guest/linux-module/Kbuild.in            |    7 +
>> hypertrace/guest/linux-module/Makefile             |   23 +++
>> .../include/linux/qemu-hypertrace-internal.h       |   46 ++++++
>> .../linux-module/include/linux/qemu-hypertrace.h   |   73 ++++++++++
>> hypertrace/guest/linux-module/qemu-hypertrace.c    |  149 ++++++++++++++=
++++++
>> 7 files changed, 305 insertions(+), 1 deletion(-)
>> create mode 100644 hypertrace/guest/linux-module/Kbuild.in
>> create mode 100644 hypertrace/guest/linux-module/Makefile
>> create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace-internal.h
>> create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace.h
>> create mode 100644 hypertrace/guest/linux-module/qemu-hypertrace.c

> This should be submitted to Linux, the module cannot live in the QEMU
> tree (we don't carry out-of-tree kernel modules).

I thought it made sense to have it here, the same way we have the user-mode
guest library. If not, I will split it into a separate repo and point at it=
 from
the documentation file. Once the rest is merged into QEMU, I can post the k=
ernel
module repo to the linux list.

Thanks,
  LLuis
