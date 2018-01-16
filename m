Received: from eggs.gnu.org ([2001:4830:134:3::10]:39013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPtp-0004IB-1t
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebPto-00084d-8T
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:59:29 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:43861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebPto-000843-3Z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:59:28 -0500
Received: by mail-oi0-x230.google.com with SMTP id t16so10398249oif.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:59:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116033404.31532-1-richard.henderson@linaro.org>
References: <20180116033404.31532-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 11:59:06 +0000
Message-ID: <CAFEAcA_6KgcmRFa_AyyhpUb2EQKNBUsQQ9Wk_-guJXsoS-h-tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 00/26] tcg: generic vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 16 January 2018 at 03:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I think this will be the last revision before queueing for pull.
>
> Peter, the target/arm patches here are primarily for testing,
> without having to go all the way through to SVE.  It also shows
> how the generic vector interface ought to be used.  I'm happy
> to drop the patches from the tcg pull and feed them through
> target-arm.next, or keep them here as you wish.

I see the ppc gcc that patchew uses doesn't like this:

/var/tmp/patchew-tester-tmp-r7vd2rsz/src/accel/tcg/tcg-runtime-gvec.c:
In function =E2=80=98helper_gvec_shl8i=E2=80=99:
/var/tmp/patchew-tester-tmp-r7vd2rsz/src/accel/tcg/tcg-runtime-gvec.c:533:2=
6:
internal compiler error: in emit_move_insn, at expr.c:3495
         *(vec8 *)(d + i) =3D *(vec8 *)(a + i) << shift;
                          ^
Please submit a full bug report,
with preprocessed source if appropriate.

We need to either work around that or update the compiler in patchew's
setup or disable that build before we can merge this, or patchew will
start mailing complaints about every series that's sent to the list...

thanks
-- PMM
