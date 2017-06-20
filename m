Received: from eggs.gnu.org ([2001:4830:134:3::10]:38996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNE8a-0000ir-V0
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNE8W-00069Z-VU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:03:48 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNE8W-00068v-Nz
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:03:44 -0400
Received: by mail-wr0-x235.google.com with SMTP id y25so47693472wrd.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 01:03:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <104840a4-9665-324e-329a-3ae92c657b4f@twiddle.net>
References: <CAFEAcA9+HauZoeSxrdXE+cENswUPsjoSOVFJ-wMfboYH5wC2=Q@mail.gmail.com>
	<c1efba1b-0af9-50a5-e200-a3f74a88d1c1@redhat.com>
	<CAFEAcA9ShizMdZRg_EboKK_7kKhakX8rtF32jCgva77e24rnZA@mail.gmail.com>
	<104840a4-9665-324e-329a-3ae92c657b4f@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 09:03:22 +0100
Message-ID: <CAFEAcA-65QiZseNUHxD+57x9AXhHvb_Pk0L_qdTPR4gXabXj+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU issues on SPARC hosts due to
 more-than-page-alignment requirement for MAP_SHARED|MAP_FIXED...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 19 June 2017 at 23:49, Richard Henderson <rth@twiddle.net> wrote:
> On 06/16/2017 02:18 AM, Peter Maydell wrote:
>>
>> (As an aside I wonder whether any still-used hardware has
>> the cache aliasing constraints in question :-))
>
>
> I strongly doubt it.  Certainly none of the 64-bit chips have this.

If so then it would be possible to make the kernel less strict
here, I think (without breaking back compat), though for QEMU's
purposes we probably ought to deal with the kernel as it stands.

thanks
-- PMM
