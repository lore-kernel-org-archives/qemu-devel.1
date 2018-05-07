Received: from eggs.gnu.org ([2001:4830:134:3::10]:50010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkIP-0000tO-27
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkIL-0007qZ-U8
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:51:33 -0400
References: <CABLmASE-AqqfVEZ5Q-vWBuXRTHTHhW9=c5f2PRZ34tVCMiRfdg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <539d5d61-8d58-0ffc-e56a-a3ddec5cea86@redhat.com>
Date: Mon, 7 May 2018 12:51:20 -0500
MIME-Version: 1.0
In-Reply-To: <CABLmASE-AqqfVEZ5Q-vWBuXRTHTHhW9=c5f2PRZ34tVCMiRfdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Compilation error for qemu-system-ppc on Fedora 28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On 05/06/2018 05:56 AM, Howard Spoelstra wrote:
> Hi all,
>=20
> I get these errors compiling qemu-system-ppc on Fedora 28, gcc 8.0.1:
>=20
> /home/hsp/src/qemu-master/hw/ppc/e500.c: In function =E2=80=98ppce500_l=
oad_device_tree=E2=80=99:
> /home/hsp/src/qemu-master/hw/ppc/e500.c:442:37: error: =E2=80=98/pic@=E2=
=80=99
> directive output may be truncated writing 5 bytes into a region of
> size between 1 and 128 [-Werror=3Dformat-truncation=3D]
>       snprintf(mpic, sizeof(mpic), "%s/pic@%llx", soc, MPC8544_MPIC_REG=
S_OFFSET);
>                                       ^~~~~

Looks like this fixes it:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg01359.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
