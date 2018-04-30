Received: from eggs.gnu.org ([2001:4830:134:3::10]:44343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDD6a-00041s-7c
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDD6Z-0006vV-Ic
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:00:52 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:34265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDD6Z-0006vF-D4
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:00:51 -0400
Received: by mail-oi0-x22f.google.com with SMTP id l1-v6so8183694oii.1
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 11:00:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k1so4mj4.fsf@linaro.org>
References: <20180413142336.32163-1-peter.maydell@linaro.org>
	<87k1so4mj4.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 19:00:30 +0100
Message-ID: <CAFEAcA-b0Fi3EOu2r-3=5xtKv+7DZ2mFkWCv-NUh00veM8DGVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] tcg/mips: Handle large offsets
 from target env to tlb_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, "patches@linaro.org" <patches@linaro.org>

On 30 April 2018 at 18:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> An ideal long term approach would be to rearrange the CPU state
>> so that the tlb_table was not so far along it, but this is tricky
>> because it would move it from the "not cleared on CPU reset" part
>> of the struct to the "cleared on CPU reset" part.
>
> Is that really a problem? Doesn't it mean we'll just reload the TLB
> after a reset?

It was the sort of "this subtly changes the semantics on all
hosts for the sake of an issue that's mips-hosts-only" change
that I didn't want to try to reason through and make very close
to release when we didn't have a lot of time to test the results...

thanks
-- PMM
