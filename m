Received: from eggs.gnu.org ([2001:4830:134:3::10]:53090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gTnvV-0004Jf-RA
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gTnvR-0006kf-T3
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:06:17 -0500
Received: from m12-18.163.com ([220.181.12.18]:59033)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gTnvQ-0006Yb-U6
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 08:06:13 -0500
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Mon, 3 Dec 2018 21:06:00 +0800
Message-Id: <5C052A3D.01FFE0.13753@m12-18.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Questions about the VFIO device BAR emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.l.williamson@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>

Hello Alex, Paolo and all

I have a question about VFIO about the BAR.

Why we have two MemoryRegion for every device=E2=80=99s BAR.
I mean in VFIOBAR we have a field =E2=80=98mr=E2=80=99.
typedef struct VFIOBAR {
    VFIORegion region;
    MemoryRegion *mr;
    size_t size;
    uint8_t type;
    bool ioport;
    bool mem64;
    QLIST_HEAD(, VFIOQuirk) quirks;
} VFIOBAR;

And in the field =E2=80=98region=E2=80=99 field of VFIOBAR,
We also have a MemoryReion named =E2=80=98mem=E2=80=99.
And the =E2=80=98VFIOBAR=E2=80=99s mr is just the subregion of =E2=80=98VFI=
OREGION=E2=80=99.

Why here we can=E2=80=99t use just one MR link VFIOREGION=E2=80=99s =E2=80=
=98mem=E2=80=99field to represent the device=E2=80=99s BAR?


Thanks,
Li Qiang
