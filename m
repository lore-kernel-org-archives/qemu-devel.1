Received: from eggs.gnu.org ([2001:4830:134:3::10]:50764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gREx5-0001b0-DP
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gREx2-0007PF-6G
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:21:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:35530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gREx1-0007Ow-Vl
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:21:16 -0500
Received: by mail-wm1-x32c.google.com with SMTP id c126so17918930wmh.0
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 03:21:15 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-13-cota@braap.org>
	<871s7dhw8t.fsf@linaro.org> <20181124000938.GD17229@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181124000938.GD17229@flamenco>
Date: Mon, 26 Nov 2018 11:21:13 +0000
Message-ID: <87r2f83x06.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 12/48] atomic_template: define pre/post macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> On Thu, Nov 22, 2018 at 17:12:34 +0000, Alex Benn=C3=A9e wrote:
>>
>> Emilio G. Cota <cota@braap.org> writes:
>>
>> > In preparation for plugin support.
>> >
>> > Signed-off-by: Emilio G. Cota <cota@braap.org>
>>
>> More macros for the macro-god. I guess this works but I wonder if it's
>> possible to do a clean-up ala softfloat and the experimental softmmu
>> re-factor that makes this less a mess of macros?
>
> Heh, point taken.
>
> I'll try to fix this once (and if!) the series graduates from RFC
> to proper patchset. BTW I'm planning to pick rth's softfloat
> cleanup soon, so that should help.

Yeah I was in the middle of re-spinning the softmmu demacro patches but
ran into a bug I didn't get time to track down. I'll get it re-spun once
I've finished going through this.

I assume the rth's softfloat cleanup is for hardfloat support? I stand
ready to review the next version. We should get it in well before the
4.0 soft freeze (next release).

>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
