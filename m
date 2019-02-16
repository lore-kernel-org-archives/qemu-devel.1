Received: from eggs.gnu.org ([209.51.188.92]:50872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1gv5kw-0005JM-Qh
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 14:36:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1gv5kv-0007rf-PI
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 14:36:10 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1gv5kv-0007rN-Im
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 14:36:09 -0500
Received: by mail-ot1-x342.google.com with SMTP id s5so22147208oth.7
	for <qemu-devel@nongnu.org>; Sat, 16 Feb 2019 11:36:09 -0800 (PST)
MIME-Version: 1.0
References: <CACQB2UxS6a2LbnOsdLt6q1=9xN4NoGBQNwVNZe-vGQjWdus_KQ@mail.gmail.com>
	<CABdVeAAvoXr5oG+G8NYJDiNO4Tdgu2QNhR4dVzd_wZ=W2GhgPg@mail.gmail.com>
In-Reply-To: <CABdVeAAvoXr5oG+G8NYJDiNO4Tdgu2QNhR4dVzd_wZ=W2GhgPg@mail.gmail.com>
From: David Kiarie <davidkiarie4@gmail.com>
Date: Sat, 16 Feb 2019 22:35:30 +0300
Message-ID: <CABdVeAAd8Gk3uiS38GXRja-4pLJaTyqeB4BS0dpJ-LavdogWVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU: AMD IOMMU implementation bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Valentine Sinitsyn <valentine.sinitsyn@gmail.com>, Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, rkrcmar@redhat.com

On Sat, Feb 16, 2019 at 10:11 PM David Kiarie <davidkiarie4@gmail.com>
wrote:

>
>
> ---------- Forwarded message ---------
> From: Alexandro S=C3=A1nchez Bach <alexaltea123@gmail.com>
> Date: Wed, Jan 31, 2018 at 2:29 AM
> Subject: QEMU: AMD IOMMU implementation bugs
> To: <davidkiarie4@gmail.com>
>
>
> Hey David,
>
> hello Mr Alexandro Sanchez Bach,
>
> I'm working with your AMD IOMMU implementation since I'm writing a
> PlayStation 4 emulator. I found few bugs, that I wanted to report to you.
>
> 1. https://github.com/qemu/qemu/blob/master/hw/i386/amd_iommu.c#L380
> Did you mean amdvi_assign_orq instead of  amdvi_test_mask? Otherwise my
> guest OS will get stuck in an endless loop waiting for a flag that never
> comes.
>
> it looks like you're correct to me.
>
> 2. The arguments `addr` and `val` are swapped in these two lines:
> > static void amdvi_writeq_raw(AMDVIState *s, uint64_t val, hwaddr addr);
> > amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) | val);
>
> same here.
>
> 3. And this might be something specific to my AMD IOMMU (1022:1437, Famil=
y
> 16h), but the PS4 OS is checks the entire word stored in these registers
> and computes the expression as:
> config[AMDVI_CAPAB_BAR_LOW] | cap[AMDVI_CAPAB_BAR_HIGH] << 32
> So just storing half words should be wrong.
>
> not sure about this.
>
> since it looks to me like you're working with emulation and
> virtualization, i have cc'd people who i know/knew to be actively involve=
d.
> it doubt it would take any effort for these people to respond to bugs lik=
e
> above in the future.
>

i believe these people even know enough about emulation and virtualization
even respond to "research-ish" questions, as PlayStation emulation could
come off a research project.

you probably just need to frame it in the right way.


> Cheers,
> Alex
>
>
