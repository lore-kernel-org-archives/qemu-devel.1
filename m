Received: from eggs.gnu.org ([209.51.188.92]:48938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gveLJ-0007YT-Hz
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gveLI-0005XH-Ls
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:32:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gveLI-0005Ma-Ef
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 03:32:00 -0500
Date: Mon, 18 Feb 2019 16:22:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190218082217.GA9040@xz-x1>
References: <CACQB2UxS6a2LbnOsdLt6q1=9xN4NoGBQNwVNZe-vGQjWdus_KQ@mail.gmail.com>
	<CABdVeAAvoXr5oG+G8NYJDiNO4Tdgu2QNhR4dVzd_wZ=W2GhgPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABdVeAAvoXr5oG+G8NYJDiNO4Tdgu2QNhR4dVzd_wZ=W2GhgPg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Fwd: QEMU: AMD IOMMU implementation bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Kiarie <davidkiarie4@gmail.com>, alexaltea123@gmail.com
Cc: Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Valentine Sinitsyn <valentine.sinitsyn@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, rkrcmar@redhat.com

On Sat, Feb 16, 2019 at 10:11:28PM +0300, David Kiarie wrote:
> ---------- Forwarded message ---------
> From: Alexandro S=C3=A1nchez Bach <alexaltea123@gmail.com>
> Date: Wed, Jan 31, 2018 at 2:29 AM
> Subject: QEMU: AMD IOMMU implementation bugs
> To: <davidkiarie4@gmail.com>
>=20
>=20
> Hey David,
>=20
> hello Mr Alexandro Sanchez Bach,
>=20
> I'm working with your AMD IOMMU implementation since I'm writing a
> PlayStation 4 emulator. I found few bugs, that I wanted to report to yo=
u.
>=20
> 1. https://github.com/qemu/qemu/blob/master/hw/i386/amd_iommu.c#L380
> Did you mean amdvi_assign_orq instead of  amdvi_test_mask? Otherwise my
> guest OS will get stuck in an endless loop waiting for a flag that neve=
r
> comes.
>=20
> it looks like you're correct to me.
>=20
> 2. The arguments `addr` and `val` are swapped in these two lines:
> > static void amdvi_writeq_raw(AMDVIState *s, uint64_t val, hwaddr addr=
);
> > amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) | val);
>=20
> same here.
>=20
> 3. And this might be something specific to my AMD IOMMU (1022:1437, Fam=
ily
> 16h), but the PS4 OS is checks the entire word stored in these register=
s
> and computes the expression as:
> config[AMDVI_CAPAB_BAR_LOW] | cap[AMDVI_CAPAB_BAR_HIGH] << 32
> So just storing half words should be wrong.
>=20
> not sure about this.
>=20
> since it looks to me like you're working with emulation and virtualizat=
ion,
> i have cc'd people who i know/knew to be actively involved. it doubt it
> would take any effort for these people to respond to bugs like above in=
 the
> future.

Hi, Alex,

The sentences are a bit messed up above.  IMHO you can simply post
patches directly if you found any bugs in the code.  You can prefix
the subject with "RFC" if you are uncertain about the changes.  People
on the list can directly comment on the patches.

Regards,

--=20
Peter Xu
